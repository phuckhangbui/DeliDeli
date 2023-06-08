/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package IngredientDetail;

import Utils.DBUtils;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Admin
 */
public class IngredientDetailDAO {

    public static ArrayList<IngredientDetailDTO> getIngredientDetailByRecipeId(int id) {
        ArrayList<IngredientDetailDTO> result = new ArrayList<>();
        Connection cn = null;

        try {
            cn = DBUtils.getConnection();

            if (cn != null) {
                String sql = "SELECT id.* FROM Recipe r INNER JOIN IngredientDetail id\n"
                        + "ON r.id = id.recipe_id\n"
                        + "WHERE r.id = ?";

                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setInt(1, id);
                ResultSet rs = pst.executeQuery();
                if (rs != null) {
                    while (rs.next()) {
                        id = rs.getInt("id");
                        String desc = rs.getString("description");
                        int ingredient_id = rs.getInt("ingredient_id");
                        int recipe_id = rs.getInt("recipe_id");

                        IngredientDetailDTO ingredientDetail = new IngredientDetailDTO(id, desc, ingredient_id, recipe_id);
                        result.add(ingredientDetail);
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

    public static int deleteIngredientDetails(int recipeId) {
        int result = -1;
        Connection cn = null;

        try {
            cn = DBUtils.getConnection();

            if (cn != null) {
                String sql = "DELETE FROM [dbo].[IngredientDetail]\n"
                        + "WHERE recipe_id = ?";

                PreparedStatement pst = cn.prepareStatement(sql);
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

    public static int addIngredientDetails(List<IngredientDetailDTO> ingredientDetails) {
        int generatedId = -1; // Default value if ID generation fails
        Connection cn = null;

        try {
            cn = DBUtils.getConnection();
            // Step 2: Create a prepared statement to insert the ingredient details
            String sql = "INSERT INTO [dbo].[IngredientDetail] ([description], ingredient_id, recipe_id) VALUES (?,?,?)";
            PreparedStatement pst = cn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);

            // Step 3: Insert each ingredient detail object and retrieve the generated keys
            for (IngredientDetailDTO ingredientDetail : ingredientDetails) {
                pst.setString(1, ingredientDetail.getDesc());
                pst.setInt(2, ingredientDetail.getIngredient_id());
                pst.setInt(3, ingredientDetail.getRecipe_id());

                // Execute the statement for each ingredient detail
                pst.executeUpdate();

                // Retrieve the generated keys
                ResultSet generatedKeys = pst.getGeneratedKeys();
                if (generatedKeys.next()) {
                    generatedId = generatedKeys.getInt(1); // Assuming the ID column is the first column
                    ingredientDetail.setId(generatedId); // Set the generated ID in the ingredient detail object
                }
            }

            // Step 4: Close the database connection and statement
            pst.close();
            cn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return generatedId;
    }

    public static int editIngredientDetails(List<IngredientDetailDTO> ingredientDetails) {
        int generatedId = -1; // Default value if ID generation fails
        Connection cn = null;

        try {
            cn = DBUtils.getConnection();
            // Step 2: Create a prepared statement to insert the ingredient details
            String sql = "UPDATE [dbo].[IngredientDetail] "
                    + "SET [description] = ?, "
                    + "    ingredient_id = ?, "
                    + "    recipe_id = ? "
                    + "WHERE id = ?";

            PreparedStatement pst = cn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);

            // Step 3: Insert each ingredient detail object and retrieve the generated keys
            for (IngredientDetailDTO ingredientDetail : ingredientDetails) {
                pst.setString(1, ingredientDetail.getDesc());
                pst.setInt(2, ingredientDetail.getIngredient_id());
                pst.setInt(3, ingredientDetail.getRecipe_id());

                // Execute the statement for each ingredient detail
                pst.executeUpdate();

                // Retrieve the generated keys
                ResultSet generatedKeys = pst.getGeneratedKeys();
                if (generatedKeys.next()) {
                    generatedId = generatedKeys.getInt(1); // Assuming the ID column is the first column
                    ingredientDetail.setId(generatedId); // Set the generated ID in the ingredient detail object
                }
            }

            // Step 4: Close the database connection and statement
            pst.close();
            cn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return generatedId;
    }

    public static void main(String[] args) {
        List<IngredientDetailDTO> list = IngredientDetailDAO.getIngredientDetailByRecipeId(1);
        for (IngredientDetailDTO o : list) {
            System.out.println(o);
        }
    }
}
