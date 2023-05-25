/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Recipe;

import Utils.DBUtils;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Daiisuke
 */
public class RecipeDAO {

    public static int getRatingByRecipeId(int recipeId) {
        int rating = 0;
        Connection cn = null;

        try {
            cn = DBUtils.getConnection();

            if (cn != null) {
                String sql = "SELECT rating FROM Review rev\n"
                        + "INNER JOIN Recipe rec\n"
                        + "ON rev.recipe_id = rec.id\n"
                        + "WHERE rec.id = ?";

                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setInt(1, recipeId);
                ResultSet rs = pst.executeQuery();
                if (rs != null) {
                    while (rs.next()) {
                        rating = rs.getInt("rating");
                    }
                }
                rs.close();
                pst.close();
                cn.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return rating;
    }

    public static String getThumbnailByRecipeId(int recipeId) {
        String image = "";
        Connection cn = null;

        try {
            cn = DBUtils.getConnection();

            if (cn != null) {
                String sql = "SELECT image FROM RecipeImage ri\n"
                        + "INNER JOIN Recipe r\n"
                        + "ON ri.recipe_id = r.id\n"
                        + "WHERE r.id = 1 AND ri.thumbnail = ?";

                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setInt(1, recipeId);
                ResultSet rs = pst.executeQuery();
                if (rs != null) {
                    while (rs.next()) {
                        image = rs.getString("image");
                    }
                }
                rs.close();
                pst.close();
                cn.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return image;
    }

    public static String getCategoryByRecipeId(int recipeId) {
        String category = "";
        Connection cn = null;

        try {
            cn = DBUtils.getConnection();

            if (cn != null) {
                String sql = "SELECT c.title as Category FROM Category c \n"
                        + "LEFT JOIN Recipe r\n"
                        + "ON c.id = r.category_id\n"
                        + "WHERE r.id = ?";

                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setInt(1, recipeId);
                ResultSet rs = pst.executeQuery();
                if (rs != null) {
                    while (rs.next()) {
                        category = rs.getString("Category");
                    }
                }
                rs.close();
                pst.close();
                cn.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return category;
    }

    public static ArrayList<RecipeDTO> getAllRecipes() {
        ArrayList<RecipeDTO> result = new ArrayList<RecipeDTO>();
        Connection cn = null;

        try {
            cn = DBUtils.getConnection();

            if (cn != null) {
                String sql = "SELECT * FROM Recipe";

                PreparedStatement pst = cn.prepareStatement(sql);
                ResultSet rs = pst.executeQuery();
                if (rs != null) {
                    while (rs.next()) {
                        int id = rs.getInt("id");
                        String title = rs.getString("title");
                        String description = rs.getString("description");
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
        }

        return result;
    }

    public static ArrayList<RecipeDTO> searchRecipes(String keyword, String searchBy) {
        ArrayList<RecipeDTO> result = new ArrayList<RecipeDTO>();
        Connection cn = null;
        try {
            cn = DBUtils.getConnection();

            if (cn != null) {
                String sql = "SELECT r.[id],r.[title],r.[description],[prep_time],[cook_time],\n"
                        + "[servings],[create_at],[update_at],[cuisine_id],[category_id],[user_id],[level_id]\n";
                if (searchBy.equalsIgnoreCase("Title")) {
                    sql += "FROM [dbo].[Recipe] AS r\n"
                            + "WHERE title LIKE ?";
                }
                if (searchBy.equalsIgnoreCase("Cuisine")) {
                    sql += "FROM [dbo].[Recipe] AS r JOIN [dbo].[Cuisine] AS c \n"
                            + "ON r.cuisine_id =c.id\n"
                            + "WHERE c.title LIKE ?";
                }
                if (searchBy.equalsIgnoreCase("Category")) {
                    sql += "FROM [dbo].[Recipe] AS r JOIN [dbo].[Category] AS c \n"
                            + "ON r.category_id =c.id\n"
                            + "WHERE c.title LIKE ?";
                }

                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, "%" + keyword + "%");
                ResultSet rs = pst.executeQuery();
                if (rs != null) {
                    while (rs.next()) {
                        int id = rs.getInt("id");
                        String title = rs.getString("title");
                        String description = rs.getString("description");
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
        }
        return result;
    }

    public static void main(String[] args) {
        System.out.println("Rating: " + RecipeDAO.getRatingByRecipeId(1));
        List<RecipeDTO> list = RecipeDAO.getAllRecipes();
        for (RecipeDTO o : list) {
            System.out.println(o);
        }
    }
}
