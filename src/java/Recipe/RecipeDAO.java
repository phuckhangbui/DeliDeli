/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Recipe;

import Utils.DBUtils;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;
import static org.omg.IOP.TAG_JAVA_CODEBASE.value;

/**
 *
 * @author Daiisuke
 */
public class RecipeDAO {

    public static String getRecipeOwnerByRecipeId(int recipeId) {
        String owner = "";
        Connection cn = null;

        try {
            cn = DBUtils.getConnection();

            if (cn != null) {
                String sql = "SELECT first_name + ' ' + last_name AS full_name FROM Recipe r \n"
                        + "INNER JOIN\n"
                        + "UserDetail ud\n"
                        + "ON r.user_id = ud.user_id\n"
                        + "WHERE r.id = ?";

                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setInt(1, recipeId);
                ResultSet rs = pst.executeQuery();
                if (rs != null) {
                    while (rs.next()) {
                        owner = rs.getString("full_name");
                    }
                }
                rs.close();
                pst.close();
                cn.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return owner;
    }

    public static int getTotalReviewByRecipeId(int recipeId) {
        int total = 0;
        Connection cn = null;

        try {
            cn = DBUtils.getConnection();

            if (cn != null) {
                String sql = "SELECT COUNT(id) AS total FROM Review WHERE recipe_id = ?";

                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setInt(1, recipeId);
                ResultSet rs = pst.executeQuery();
                if (rs != null) {
                    while (rs.next()) {
                        total = rs.getInt("total");
                    }
                }
                rs.close();
                pst.close();
                cn.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return total;
    }

    public static double getRatingByRecipeId(int recipeId) {
        double result = 0;
        Connection cn = null;

        try {
            cn = DBUtils.getConnection();

            if (cn != null) {
                String sql = "SELECT CAST(SUM(rev.rating) AS decimal) / COUNT (rev.rating) AS avg\n"
                        + "FROM Review rev\n"
                        + "INNER JOIN Recipe rec \n"
                        + "ON rev.recipe_id = rec.id \n"
                        + "WHERE rec.id = ?\n";

                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setInt(1, recipeId);
                ResultSet rs = pst.executeQuery();
                if (rs != null) {
                    while (rs.next()) {
                        result = rs.getDouble("avg");

                    }
                }
                rs.close();
                pst.close();
                cn.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        int decimalPlaces = 2;
        result = Math.round(result * Math.pow(10, decimalPlaces)) / Math.pow(10, decimalPlaces);
        return result;
    }

    public static String getImageByRecipeId(int recipeId) {
        String image = "";
        Connection cn = null;

        try {
            cn = DBUtils.getConnection();

            if (cn != null) {
                String sql = "SELECT TOP 1 image FROM RecipeImage ri\n"
                        + "INNER JOIN Recipe r\n"
                        + "ON ri.recipe_id = r.id\n"
                        + "WHERE r.id = ? AND ri.thumbnail = 0";

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

    public static String getThumbnailByRecipeId(int recipeId) {
        String image = "";
        Connection cn = null;

        try {
            cn = DBUtils.getConnection();

            if (cn != null) {
                String sql = "SELECT image FROM RecipeImage ri\n"
                        + "INNER JOIN Recipe r\n"
                        + "ON ri.recipe_id = r.id\n"
                        + "WHERE r.id = ? AND ri.thumbnail = 1";

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

    public static RecipeDTO getRecipeByRecipeId(int id) {
        RecipeDTO recipe = null;
        Connection cn = null;

        try {
            cn = DBUtils.getConnection();

            if (cn != null) {
                String sql = "SELECT * FROM Recipe WHERE id = ?";

                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setInt(1, id);
                ResultSet rs = pst.executeQuery();
                if (rs != null) {
                    while (rs.next()) {
                        id = rs.getInt("id");
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
                        int diet_id = rs.getInt("diet_id");
                        int status = rs.getInt("status");

                        recipe = new RecipeDTO(id, title, description, prep_time,
                                cook_time, servings, create_at, update_at, cuisin_id,
                                category_id, user_id, level_id, diet_id, status);
                    }
                }
                rs.close();
                pst.close();
                cn.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return recipe;
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
                        int diet_id = rs.getInt("diet_id");
                        int status = rs.getInt("status");

                        RecipeDTO recipe = new RecipeDTO(id, title, description, prep_time,
                                cook_time, servings, create_at, update_at, cuisin_id,
                                category_id, user_id, level_id, diet_id, status);
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
                        int diet_id = rs.getInt("diet_id");
                        int status = rs.getInt("status");
                        RecipeDTO recipe = new RecipeDTO(id, title, "", prep_time,
                                cook_time, servings, create_at, update_at, cuisin_id,
                                category_id, user_id, level_id, diet_id, status);
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

    public static ArrayList<RecipeDTO> getRecipeByUserId(int userId) {
        ArrayList<RecipeDTO> result = new ArrayList<RecipeDTO>();
        Connection cn = null;

        try {
            cn = DBUtils.getConnection();

            if (cn != null) {
                String sql = "SELECT * FROM Recipe\n"
                        + "WHERE user_id = ?";

                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setInt(1, userId);
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
                        int diet_id = rs.getInt("diet_id");
                        int status = rs.getInt("status");

                        RecipeDTO recipe = new RecipeDTO(id, title, description, prep_time,
                                cook_time, servings, create_at, update_at, cuisin_id,
                                category_id, user_id, level_id, diet_id, status);
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

    public static int addRecipe(RecipeDTO recipe) {
        int generatedId = -1; // Default value if ID generation fails
        Connection cn = null;

        try {
            cn = DBUtils.getConnection();
            // Step 2: Create a prepared statement to insert the recipe
            String sql = "INSERT INTO [dbo].[Recipe] (title, description, prep_time, cook_time, servings, create_at, \n"
                    + "update_at, cuisine_id, category_id, user_id, level_id, diet_id, status) \n"
                    + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?,?)";
            PreparedStatement pst = cn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);

            // Set the parameter values for the prepared statement
            pst.setString(1, recipe.getTitle());
            pst.setString(2, recipe.getDescription());
            pst.setInt(3, recipe.getPrep_time());
            pst.setInt(4, recipe.getCook_time());
            pst.setInt(5, recipe.getServings());
            pst.setDate(6, recipe.getCreate_at());
            pst.setDate(7, recipe.getUpdate_at());
            pst.setInt(8, recipe.getCuisine_id());
            pst.setInt(9, recipe.getCategory_id());
            pst.setInt(10, recipe.getUser_id());
            pst.setInt(11, recipe.getLevel_id());
            pst.setInt(12, recipe.getDiet_id());
            pst.setInt(13, recipe.getStatus());

            // Step 3: Execute the prepared statement and retrieve the generated keys
            pst.executeUpdate();
            ResultSet generatedKeys = pst.getGeneratedKeys();

            // Step 4: Retrieve the generated ID
            if (generatedKeys.next()) {
                generatedId = generatedKeys.getInt(1);
            }

            // Step 5: Close the database connection and resources
            generatedKeys.close();
            pst.close();
            cn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return generatedId;
    }

    public static void main(String[] args) {
        System.out.println("rating: " + RecipeDAO.getRecipeByUserId(1));
//        List<RecipeDTO> list = RecipeDAO.getAllRecipes();
//        for (RecipeDTO o : list) {
//            System.out.println(o);
//        }
    }
}
