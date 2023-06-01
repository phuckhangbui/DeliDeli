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
import java.util.List;

/**
 *
 * @author khang
 */
public class NavigationBarUtils {

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
        ArrayList<RecipeDTO> result = new ArrayList<RecipeDTO>();
        Connection cn = null;
        try {
            cn = DBUtils.getConnection();

            if (cn != null) {
                String sql = "SELECT r.[id],r.[title],r.[prep_time],r.[cook_time],[servings],\n"
                        + "r.[create_at],r.[update_at],[cuisine_id],[category_id],r.[user_id],[level_id]\n"
                        + "FROM [dbo].[Recipe] r JOIN [dbo].[Review] re ON r.[id] = re.recipe_id\n";

                if (type.equals("Ingredient")) {
                    sql +=  "JOIN [dbo].[IngredientDetail] id ON r.id = id.recipe_id\n"
                            + "WHERE id.ingredient_id = ?\n";
                }
                if (type.equals("Category")) {
                    sql += "WHERE r.category_id = ?\n";
                }
                if (type.equals("Cuisine")) {
                    sql += "WHERE [cuisine_id] = ?\n";
                }
                if (type.equals("Level")) {
                    sql += "WHERE [level_id]= ?\n";
                }

                sql += "GROUP BY r.[id],r.[title],r.[prep_time],r.[cook_time],[servings],\n"
                        + "r.[create_at],r.[update_at],[cuisine_id],[category_id],r.[user_id],[level_id]\n"
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

                        RecipeDTO recipe = new RecipeDTO(id, title, description, prep_time,
                                cook_time, servings, create_at, update_at, cuisin_id,
                                category_id, user_id, level_id);
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
        ArrayList<RecipeDTO> list = getRecipeByType("category", 3);
        for (RecipeDTO r : list) {
            System.out.println(r.getTitle());
        }
    }
}
