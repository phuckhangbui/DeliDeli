/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import DTO.FavoriteDTO;
import DTO.NutritionDTO;
import DTO.RecipeDTO;
import DTO.RecipeImageDTO;
import DTO.UserDTO;
import Utils.DBUtils;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Daiisuke
 */
public class RecipeDAO {

    public static ArrayList<RecipeDTO> getTop6LatestRecipes() {
        ArrayList<RecipeDTO> result = new ArrayList<RecipeDTO>();
        Connection cn = null;

        try {
            cn = DBUtils.getConnection();

            if (cn != null) {
                String sql = "SELECT TOP 6 * FROM Recipe\n"
                        + "WHERE status = 3 ORDER BY create_at DESC";

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
                        Timestamp create_at = rs.getTimestamp("create_at");
                        Timestamp update_at = rs.getTimestamp("update_at");
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
        }

        return result;
    }

    public static ArrayList<RecipeDTO> getRecipeByDietTitle(String diet_title) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        ArrayList<RecipeDTO> result = new ArrayList<>();

        String sql = "SELECT r.*\n"
                + "FROM Recipe r\n"
                + "JOIN RecipeDiet rd ON rd.recipe_id = r.id\n"
                + "JOIN Diet d ON d.id = rd.diet_id\n"
                + "WHERE d.title = ?";

        try {
            con = DBUtils.getConnection();
            if (con != null) {
                stm = con.prepareStatement(sql);
                stm.setString(1, diet_title);

                rs = stm.executeQuery();
                while (rs.next()) {
                    int id = rs.getInt("id");
                    String title = rs.getString("title");
                    String description = rs.getString("description");
                    int prep_time = rs.getInt("prep_time");
                    int cook_time = rs.getInt("cook_time");
                    int servings = rs.getInt("servings");
                    Timestamp create_at = rs.getTimestamp("create_at");
                    Timestamp update_at = rs.getTimestamp("update_at");
                    int status = rs.getInt("status");
                    int cuisine_id = rs.getInt("cuisine_id");
                    int category_id = rs.getInt("category_id");
                    int user_id = rs.getInt("user_id");
                    int level_id = rs.getInt("level_id");

                    RecipeDTO recipe = new RecipeDTO(id, title, description, prep_time, cook_time, servings, create_at, update_at, cuisine_id, category_id, user_id, level_id, status);
                    result.add(recipe);

                }
            }
        } catch (SQLException ex) {
            System.out.println("Query error - getRecipeByDietTitle: " + ex.getMessage());
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (stm != null) {
                    stm.close();
                }
                if (con != null) {
                    con.close();
                }
            } catch (SQLException ex) {
                System.out.println("Error closing database resources: " + ex.getMessage());
            }
        }
        return result;
    }

    public static ArrayList<RecipeDTO> searchRecipeForPlan(String search_str, String searchBy, int user_id) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        ArrayList<RecipeDTO> result = new ArrayList<>();

        String sql = "SELECT r.id, r.title, r.description, r.prep_time, r.cook_time, r.servings, r.create_at, r.update_at, r.status, r.cuisine_id, r.category_id, r.user_id, r.level_id\n"
                + "FROM Recipe r\n";

        if (searchBy.equalsIgnoreCase("Public")) {
            sql += "WHERE r.title LIKE ?\n";
        }

        if (searchBy.equalsIgnoreCase("Personal")) {
            sql += "WHERE r.title LIKE ? AND r.[user_id] = ?\n";
        }

        if (searchBy.equalsIgnoreCase("Saved")) {
            sql += "JOIN FavoriteRecipe fr ON r.id = fr.recipe_id\n"
                    + "WHERE r.title LIKE ? AND fr.user_id = ?\n";
        }

        try {
            con = DBUtils.getConnection();
            if (con != null) {
                stm = con.prepareStatement(sql);
                stm.setString(1, "%" + search_str + "%");

                if (searchBy.equalsIgnoreCase("Personal")) {
                    stm.setInt(2, user_id);
                }

                if (searchBy.equalsIgnoreCase("Saved")) {
                    stm.setInt(2, user_id);
                }

                rs = stm.executeQuery();
                while (rs.next()) {
                    int id = rs.getInt("id");
                    String title = rs.getString("title");
                    String description = rs.getString("description");
                    int prep_time = rs.getInt("prep_time");
                    int cook_time = rs.getInt("cook_time");
                    int servings = rs.getInt("servings");
                    Timestamp create_at = rs.getTimestamp("create_at");
                    Timestamp update_at = rs.getTimestamp("update_at");
                    int status = rs.getInt("status");
                    int cuisine_id = rs.getInt("cuisine_id");
                    int category_id = rs.getInt("category_id");
                    int recipe_user_id = rs.getInt("user_id");
                    int level_id = rs.getInt("level_id");

                    RecipeDTO recipe = new RecipeDTO(id, title, description, prep_time, cook_time, servings, create_at, update_at, cuisine_id, category_id, recipe_user_id, level_id, status);
                    result.add(recipe);
                }
            }
        } catch (SQLException ex) {
            System.out.println("Query error - searchRecipeForPlan: " + ex.getMessage());
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (stm != null) {
                    stm.close();
                }
                if (con != null) {
                    con.close();
                }
            } catch (SQLException ex) {
                System.out.println("Error closing database resources: " + ex.getMessage());
            }
        }
        return result;
    }

    public static UserDTO getRecipeOwnerByRecipeId(int recipeId) {
        UserDTO owner = new UserDTO();
        Connection cn = null;

        try {
            cn = DBUtils.getConnection();

            if (cn != null) {
                String sql = "SELECT * FROM Recipe r \n"
                        + "INNER JOIN\n"
                        + "[User] u\n"
                        + "ON r.user_id = u.id\n"
                        + "WHERE r.id = ?";

                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setInt(1, recipeId);
                ResultSet rs = pst.executeQuery();
                if (rs != null) {
                    while (rs.next()) {
                        int id = rs.getInt("user_id");
                        String userName = rs.getString("user_name");
                        String email = rs.getString("email");
                        String password = rs.getString("password");
                        String avatar = rs.getString("avatar");
                        String createAt = rs.getString("create_at");
                        int status = rs.getInt("status");
                        int role = rs.getInt("role_id");
                        int setting = rs.getInt("user_setting_id");
                        owner = new UserDTO(id, userName, email, password, avatar, createAt, status, role, setting);
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

    public static RecipeImageDTO getImageByRecipeId(int recipeId) {
        RecipeImageDTO recipeImg = null;
        Connection cn = null;

        try {
            cn = DBUtils.getConnection();

            if (cn != null) {
                String sql = "SELECT *\n"
                        + "FROM [dbo].[RecipeImage]\n"
                        + "WHERE [recipe_id] = ? AND [thumbnail] = 0";

                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setInt(1, recipeId);
                ResultSet rs = pst.executeQuery();
                if (rs != null) {
                    while (rs.next()) {
                        int id = rs.getInt("id");
                        String img = rs.getString("image");
                        boolean thumbnail = rs.getBoolean("thumbnail");
                        recipeImg = new RecipeImageDTO(id, img, recipeId, thumbnail);
                    }
                }
                if (recipeImg == null) {
                    recipeImg = new RecipeImageDTO(0, "", recipeId, false);
                }
                rs.close();
                pst.close();
                cn.close();
            }
        } catch (Exception e) {
            recipeImg = new RecipeImageDTO(0, "", recipeId, false);
        }
        return recipeImg;
    }

    public static RecipeImageDTO getThumbnailByRecipeId(int recipeId) {
        RecipeImageDTO recipeImg = null;
        Connection cn = null;

        try {
            cn = DBUtils.getConnection();

            if (cn != null) {
                String sql = "SELECT *\n"
                        + "FROM [dbo].[RecipeImage]\n"
                        + "WHERE [recipe_id] = ? AND [thumbnail] = 1";

                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setInt(1, recipeId);
                ResultSet rs = pst.executeQuery();
                if (rs != null) {
                    while (rs.next()) {
                        int id = rs.getInt("id");
                        String img = rs.getString("image");
                        boolean thumbnail = rs.getBoolean("thumbnail");
                        recipeImg = new RecipeImageDTO(id, img, recipeId, thumbnail);
                    }
                }
                rs.close();
                pst.close();
                cn.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return recipeImg;
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
                        Timestamp create_at = rs.getTimestamp("create_at");
                        Timestamp update_at = rs.getTimestamp("update_at");
                        int cuisin_id = rs.getInt("cuisine_id");
                        int category_id = rs.getInt("category_id");
                        int user_id = rs.getInt("user_id");
                        int level_id = rs.getInt("level_id");
                        int status = rs.getInt("status");

                        recipe = new RecipeDTO(id, title, description, prep_time,
                                cook_time, servings, create_at, update_at, cuisin_id,
                                category_id, user_id, level_id, status);

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
                String sql = "SELECT * FROM Recipe\n"
                        + "WHERE status = 3";

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
                        Timestamp create_at = rs.getTimestamp("create_at");
                        Timestamp update_at = rs.getTimestamp("update_at");
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
        }

        return result;
    }

    public static ArrayList<RecipeDTO> getRecipeByUserIdAndType(int userId, int status) {
        ArrayList<RecipeDTO> result = new ArrayList<RecipeDTO>();
        Connection cn = null;

        try {
            cn = DBUtils.getConnection();

            if (cn != null) {
                String sql = "SELECT *\n"
                        + "FROM Recipe\n"
                        + "WHERE user_id = ? AND status = ?\n"
                        + "ORDER BY COALESCE(update_at, create_at) DESC, create_at DESC";

                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setInt(1, userId);
                pst.setInt(2, status);
                ResultSet rs = pst.executeQuery();
                if (rs != null) {
                    while (rs.next()) {
                        int id = rs.getInt("id");
                        String title = rs.getString("title");
                        String description = rs.getString("description");
                        int prep_time = rs.getInt("prep_time");
                        int cook_time = rs.getInt("cook_time");
                        int servings = rs.getInt("servings");
                        Timestamp create_at = rs.getTimestamp("create_at");
                        Timestamp update_at = rs.getTimestamp("update_at");
                        int cuisin_id = rs.getInt("cuisine_id");
                        int category_id = rs.getInt("category_id");
                        int user_id = rs.getInt("user_id");
                        int level_id = rs.getInt("level_id");
                        status = rs.getInt("status");

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
                    + "update_at, cuisine_id, category_id, user_id, level_id, status) \n"
                    + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement pst = cn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);

            // Set the parameter values for the prepared statement
            pst.setString(1, recipe.getTitle());
            pst.setString(2, recipe.getDescription());
            pst.setInt(3, recipe.getPrep_time());
            pst.setInt(4, recipe.getCook_time());
            pst.setInt(5, recipe.getServings());
            pst.setTimestamp(6, recipe.getCreate_at());
            pst.setTimestamp(7, recipe.getUpdate_at());
            pst.setInt(8, recipe.getCuisine_id());
            pst.setInt(9, recipe.getCategory_id());
            pst.setInt(10, recipe.getUser_id());
            pst.setInt(11, recipe.getLevel_id());
            pst.setInt(12, recipe.getStatus());

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

    public static int editRecipe(RecipeDTO recipe) {
        int generatedId = -1; // Default value if ID generation fails
        Connection cn = null;

        try {
            cn = DBUtils.getConnection();
            // Step 2: Create a prepared statement to insert the recipe
            String sql = "UPDATE [dbo].[Recipe] \n"
                    + "SET title = ?, \n"
                    + "    description = ?, \n"
                    + "    prep_time = ?, \n"
                    + "    cook_time = ?, \n"
                    + "    servings = ?, \n"
                    + "    update_at = ?, \n"
                    + "    cuisine_id = ?, \n"
                    + "    category_id = ?, \n"
                    + "    user_id = ?, \n"
                    + "    level_id = ?, \n"
                    + "    status = ? \n"
                    + "WHERE id = ?";
            PreparedStatement pst = cn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);

            // Set the parameter values for the prepared statement
            pst.setString(1, recipe.getTitle());
            pst.setString(2, recipe.getDescription());
            pst.setInt(3, recipe.getPrep_time());
            pst.setInt(4, recipe.getCook_time());
            pst.setInt(5, recipe.getServings());
            pst.setTimestamp(6, recipe.getUpdate_at());
            pst.setInt(7, recipe.getCuisine_id());
            pst.setInt(8, recipe.getCategory_id());
            pst.setInt(9, recipe.getUser_id());
            pst.setInt(10, recipe.getLevel_id());
            pst.setInt(11, recipe.getStatus());
            pst.setInt(12, recipe.getId());

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

    public static int deleteRecipe(int recipeId) {
        int result = -1;
        Connection cn = null;

        try {
            cn = DBUtils.getConnection();

            if (cn != null) {
                String sql = "DELETE FROM [dbo].[RecipeDiet]\n"
                        + "WHERE recipe_id = ?";

                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setInt(1, recipeId);
                result = pst.executeUpdate();

                sql = "DELETE FROM [dbo].[Nutrition]\n"
                        + "WHERE recipe_id = ?";
                pst = cn.prepareStatement(sql);
                pst.setInt(1, recipeId);
                result = pst.executeUpdate();

                sql = "DELETE FROM [dbo].[SuggestionRecipe]\n"
                        + "WHERE recipe_id = ?";
                pst = cn.prepareStatement(sql);
                pst.setInt(1, recipeId);
                result = pst.executeUpdate();

                sql = "DELETE FROM [dbo].[Recipe]\n"
                        + "WHERE id = ?";
                pst = cn.prepareStatement(sql);
                pst.setInt(1, recipeId);
                result = pst.executeUpdate();

                pst.close();
                cn.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    public static void main(String[] args) {
        //RecipeDTO r = getRecipeByRecipeId(1);
        deleteRecipe(12);
    }

    public static boolean addFavoriteRecipe(int user_id, int recipe_id) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        String sql = "INSERT INTO FavoriteRecipe(user_id, recipe_id)\n"
                + "VALUES(?, ?)";

        try {
            con = DBUtils.getConnection();
            if (con != null) {
                stm = con.prepareStatement(sql);
                stm.setInt(1, user_id);
                stm.setInt(2, recipe_id);
                int effectRows = stm.executeUpdate();
                if (effectRows > 0) {
                    return true;
                }

            }
        } catch (SQLException ex) {
            System.out.println("Query error: " + ex.getMessage());
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (stm != null) {
                    stm.close();
                }
                if (con != null) {
                    con.close();
                }
            } catch (SQLException ex) {
                System.out.println("Error closing database resources: " + ex.getMessage());
            }
        }
        return false;
    }

    public static ArrayList<NutritionDTO> getNutritionValuesByRecipeID(int recipe_id) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        ArrayList<NutritionDTO> result = new ArrayList<>();

        String sql = "SELECT r.id, r.title, n.calories, n.fat, n.carbs, n.protein\n"
                + "FROM Recipe r\n"
                + "JOIN Nutrition n ON r.id = n.recipe_id\n"
                + "WHERE r.id = ?\n";

        try {
            con = DBUtils.getConnection();
            if (con != null) {
                stm = con.prepareStatement(sql);
                stm.setInt(1, recipe_id);

                rs = stm.executeQuery();
                while (rs.next()) {
                    recipe_id = rs.getInt("id");
                    int calories = rs.getInt("calories");
                    int fat = rs.getInt("fat");
                    int carbs = rs.getInt("carbs");
                    int protein = rs.getInt("protein");

                    NutritionDTO recipeNutrition = new NutritionDTO(recipe_id, calories, fat, carbs, protein);
                    result.add(recipeNutrition);

                }
            }
        } catch (SQLException ex) {
            System.out.println("Query error - getSumNutritionValuesByDateId: " + ex.getMessage());
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (stm != null) {
                    stm.close();
                }
                if (con != null) {
                    con.close();
                }
            } catch (SQLException ex) {
                System.out.println("Error closing database resources: " + ex.getMessage());
            }
        }
        return result;
    }
}
