/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Utils;

import Recipe.RecipeDTO;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

/**
 *
 * @author khang
 */
public class NavigationBarUtils {
    
    public static ArrayList<RecipeDTO> searchRecipes(String keyword, String searchBy) {
        ArrayList<RecipeDTO> result = new ArrayList<RecipeDTO>();
        Connection cn = null;
        try {
            cn = DBUtils.getConnection();

            if (cn != null) {
                String sql = "SELECT r.[id],r.[title],[prep_time],[cook_time],\n"
                        + "[servings],r.[create_at],r.[update_at],[cuisine_id],[category_id],r.[user_id],[level_id], diet_id, status\n"
                        + "FROM [dbo].[Recipe] r LEFT JOIN [dbo].[Review] re ON r.[id] = re.recipe_id\n";
                if (searchBy.equalsIgnoreCase("Title")) {
                    sql += "WHERE r.title LIKE ?\n";
                }
                if (searchBy.equalsIgnoreCase("Cuisine")) {
                    sql += "JOIN [dbo].[Cuisine] AS c \n"
                            + "ON r.cuisine_id =c.id\n"
                            + "WHERE c.title LIKE ?\n";
                }
                if (searchBy.equalsIgnoreCase("Category")) {
                    sql += "JOIN [dbo].[Category] AS c \n"
                            + "ON r.category_id =c.id\n"
                            + "WHERE c.title LIKE ?\n";
                }
                if (searchBy.equalsIgnoreCase("Diet")) {
                    sql += "JOIN [dbo].[Diet] AS d \n"
                            + "ON r.diet_id =d.id\n"
                            + "WHERE d.title LIKE ?\n";
                }

                sql += "GROUP BY r.[id],r.[title],r.[prep_time],r.[cook_time],[servings],\n"
                        + "r.[create_at],r.[update_at],[cuisine_id],[category_id],r.[user_id],[level_id], diet_id, status\n"
                        + "ORDER BY CAST(SUM(re.rating) AS decimal) / COUNT(re.rating) DESC";

                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, "%" + keyword + "%");
                ResultSet rs = pst.executeQuery();
                if (rs != null) {
                    while (rs.next()) {
                        int id = rs.getInt("id");
                        String title = rs.getString("title");
                        int prep_time = rs.getInt("prep_time");
                        int cook_time = rs.getInt("cook_time");
                        int servings = rs.getInt("servings");
                        Date create_at = rs.getDate("create_at");
                        Date update_at = rs.getDate("update_at");
                        int cuisin_id = rs.getInt("cuisine_id");
                        int category_id = rs.getInt("category_id");
                        int user_id = rs.getInt("user_id");
                        int level_id = rs.getInt("level_id");
                        int status = rs.getInt("status");
                        RecipeDTO recipe = new RecipeDTO(id, title, "", prep_time,
                                cook_time, servings, create_at, update_at, cuisin_id,
                                category_id, user_id, level_id, status);
                        result.add(recipe);
                    }
                }
                rs.close();
                pst.close();
                cn.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    public static HashMap<Integer, String> getMap(String str) {
        //Category
        //Cuisine
        //Level
        //Ingredient
        HashMap<Integer, String> map = new HashMap<Integer, String>();
        Connection cn = null;
        try {
            cn = DBUtils.getConnection();
            System.out.println(str);
            if (cn != null) {
                String sql;
                //type in level is equivalent of title
                if (str.equals("Level")) {
                    sql = "SELECT [id],[type]\n"
                            + "FROM [dbo].[Level]";
                } else {
                    sql = "SELECT [id], [title]\n"
                            + "FROM [dbo].[" + str + "]";
                }

                PreparedStatement pst = cn.prepareStatement(sql);
                ResultSet rs = pst.executeQuery();
                if (rs != null) {
                    while (rs.next()) {
                        int id = rs.getInt("id");
                        String title;
                        if (str.equals("Level")) {
                            title = rs.getString("type");
                        } else {
                            title = rs.getString("title");
                        }
                        map.put(id, title);
                    }
                }
                rs.close();
                pst.close();
                cn.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return map;
    }

    //Get Recipe base on ingredient/category/level/cuisine
    public static ArrayList<RecipeDTO> getRecipeByType(String type, int typeId) {
        ArrayList<RecipeDTO> ratingList = new ArrayList<RecipeDTO>();
        ArrayList<RecipeDTO> noRatingList = new ArrayList<RecipeDTO>();
        ArrayList<RecipeDTO> result = null;
        Connection cn = null;
        try {
            cn = DBUtils.getConnection();

            if (cn != null) {
                String sql = "SELECT r.[id],r.[title],r.[prep_time],r.[cook_time],[servings],\n"
                        + "r.[create_at],r.[update_at],[cuisine_id],[category_id],r.[user_id],[level_id], diet_id, status\n"
                        + "FROM [dbo].[Recipe] r JOIN [dbo].[Review] re ON r.[id] = re.recipe_id\n";

                if (type.equals("Ingredient")) {
                    sql += "JOIN [dbo].[IngredientDetail] id ON r.id = id.recipe_id\n"
                            + "WHERE id.ingredient_id = ? AND r.status = 3\n";
                }
                if (type.equals("Category")) {
                    sql += "WHERE r.category_id = ? AND status = 3\n";
                }
                if (type.equals("Cuisine")) {
                    sql += "WHERE [cuisine_id] = ? AND status = 3\n";
                }
                if (type.equals("Level")) {
                    sql += "WHERE [level_id]= ? AND status = 3\n";
                }
                if (type.equals("Diet")) {
                    sql += "WHERE [diet_id]= ? AND status = 3\n";
                }

                sql += "GROUP BY r.[id],r.[title],r.[prep_time],r.[cook_time],[servings],\n"
                        + "r.[create_at],r.[update_at],[cuisine_id],[category_id],r.[user_id],[level_id], diet_id, status\n"
                        + "ORDER BY CAST(SUM(re.rating) AS decimal) / COUNT(re.rating) DESC";

                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setInt(1, typeId);
                ResultSet rs = pst.executeQuery();
                if (rs != null) {
                    while (rs.next()) {
                        int id = rs.getInt("id");
                        String title = rs.getString("title");
                        String description = "";
                        int prep_time = rs.getInt("prep_time");
                        int cook_time = rs.getInt("cook_time");
                        int servings = rs.getInt("servings");
                        Date create_at = rs.getDate("create_at");
                        Date update_at = rs.getDate("update_at");
                        int cuisin_id = rs.getInt("cuisine_id");
                        int category_id = rs.getInt("category_id");
                        int user_id = rs.getInt("user_id");
                        int level_id = rs.getInt("level_id");
                        int status = rs.getInt("status");

                        RecipeDTO recipe = new RecipeDTO(id, title, description, prep_time,
                                cook_time, servings, create_at, update_at, cuisin_id,
                                category_id, user_id, level_id, status);
                        ratingList.add(recipe);
                    }
                }
                noRatingList = getRecipeByTypeNoRating(type, typeId);
                Map<Integer, RecipeDTO> uniqueRecipes = new HashMap<>();

                for (RecipeDTO recipe : ratingList) {
                    uniqueRecipes.put(recipe.getId(), recipe);
                }

                for (RecipeDTO recipe : noRatingList) {
                    if (!uniqueRecipes.containsKey(recipe.getId())) {
                        uniqueRecipes.put(recipe.getId(), recipe);
                    }
                }

                result = new ArrayList<>(uniqueRecipes.values());

                rs.close();
                pst.close();
                cn.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
        return result;
    }

    public static ArrayList<RecipeDTO> getRecipeByTypeNoRating(String type, int typeId) {
        ArrayList<RecipeDTO> result = new ArrayList<RecipeDTO>();
        Connection cn = null;
        try {
            cn = DBUtils.getConnection();

            if (cn != null) {
                String sql = "SELECT r.[id],r.[title],r.[prep_time],r.[cook_time],[servings],\n"
                        + "r.[create_at],r.[update_at],[cuisine_id],[category_id],r.[user_id],[level_id], diet_id, status\n"
                        + "FROM [dbo].[Recipe] r\n";

                if (type.equals("Ingredient")) {
                    sql += "JOIN [dbo].[IngredientDetail] id ON r.id = id.recipe_id\n"
                            + "WHERE id.ingredient_id = ? AND status = 3\n";
                }
                if (type.equals("Category")) {
                    sql += "WHERE r.category_id = ? AND status = 3\n";
                }
                if (type.equals("Cuisine")) {
                    sql += "WHERE [cuisine_id] = ? AND status = 3\n";
                }
                if (type.equals("Level")) {
                    sql += "WHERE [level_id]= ? AND status = 3\n";
                }
                if (type.equals("Diet")) {
                    sql += "WHERE [diet_id]= ? AND status = 3\n";
                }

                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setInt(1, typeId);
                ResultSet rs = pst.executeQuery();
                if (rs != null) {
                    while (rs.next()) {
                        int id = rs.getInt("id");
                        String title = rs.getString("title");
                        String description = "";
                        int prep_time = rs.getInt("prep_time");
                        int cook_time = rs.getInt("cook_time");
                        int servings = rs.getInt("servings");
                        Date create_at = rs.getDate("create_at");
                        Date update_at = rs.getDate("update_at");
                        int cuisin_id = rs.getInt("cuisine_id");
                        int category_id = rs.getInt("category_id");
                        int user_id = rs.getInt("user_id");
                        int level_id = rs.getInt("level_id");
                        int status = rs.getInt("status");

                        RecipeDTO recipe = new RecipeDTO(id, title, description, prep_time,
                                cook_time, servings, create_at, update_at, cuisin_id,
                                category_id, user_id, level_id, status);
                        result.add(recipe);
                    }
                }
                rs.close();
                pst.close();
                cn.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
        return result;
    }

    public static void main(String[] args) {
//        HashMap<Integer, String> map = getMap("Diet");
//        for (Map.Entry<Integer, String> entry : map.entrySet()) {
//            Integer key = entry.getKey();
//            String value = entry.getValue();
//            System.out.println(key);
//            System.out.println(value + "\n");
//        }
        ArrayList<RecipeDTO> recipeList = getRecipeByType("Diet", 1);
        for (RecipeDTO r : recipeList) {
            System.out.println(r.toString());
        }

    }
}
