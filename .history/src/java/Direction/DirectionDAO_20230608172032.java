/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Direction;

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
public class DirectionDAO {

    public static DirectionDTO getDirectionByRecipeId(int id) {
        DirectionDTO result = null;
        Connection cn = null;

        try {
            cn = DBUtils.getConnection();

            if (cn != null) {
                String sql = "SELECT [recipe_id],[description]\n"
                        + "FROM [dbo].[Direction]\n"
                        + "WHERE [recipe_id] = ?";

                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setInt(1, id);
                ResultSet rs = pst.executeQuery();
                if (rs != null) {
                    while (rs.next()) {
<<<<<<< HEAD
                        String desc = rs.getString("description");
                        int recipe_id = rs.getInt("recipe_id");
                        result = new DirectionDTO(desc, recipe_id);

=======
                        id = rs.getInt("id");
                        int isHeader = rs.getInt("is_header");
                        int step = rs.getInt("step");
                        String desc = rs.getString("description");
                        int recipe_id = rs.getInt("recipe_id");
                        DirectionDTO direction = new DirectionDTO(id, isHeader, step, desc, recipe_id);
                        
                        result.add(direction);
>>>>>>> khoa-admin-user-manage
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

//    public static List<DirectionDTO> extractDirectionsFromQueryString(String queryString, int recipeId) {
//        String[] parameters = queryString.split("&");
//        List<DirectionDTO> directionsList = new ArrayList<>();
//        int step = 1;
//
//        for (String parameter : parameters) {
//            String[] parts = parameter.split("=");
//            String paramName = parts[0];
//            String paramValue = parts.length > 1 ? parts[1] : "";
//
//            if (paramName.equals("header")) {
//                DirectionDTO directionDTO = new DirectionDTO();
//                directionDTO.setIs_header(true);
//                directionDTO.setStep(step++);
//                directionDTO.setDesc(paramValue);
//                directionDTO.setRecipe_id(recipeId);
//                directionsList.add(directionDTO);
//            } else if (paramName.equals("direction")) {
//                DirectionDTO directionDTO = new DirectionDTO();
//                directionDTO.setIs_header(false);
//                directionDTO.setStep(step++);
//                directionDTO.setDesc(paramValue);
//                directionDTO.setRecipe_id(recipeId);
//                directionsList.add(directionDTO);
//            }
//        }
//
//        return directionsList;
//    }
    public static int addDirections(DirectionDTO direction) {
        int generatedId = -1; // Default value if ID generation fails
        Connection cn = null;
        try {
            // Step 1: Establish a database connection
            cn = DBUtils.getConnection();
            // Step 2: Create a prepared statement to insert the directions
            String sql = "INSERT INTO [dbo].[Direction] (description, recipe_id) VALUES ( ?, ? )";
            PreparedStatement pst = cn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);

            // Step 3: Insert each direction object and retrieve the generated keys
            pst.setString(1, direction.getDesc());
            pst.setInt(2, direction.getRecipe_id());

            // Execute the statement for each direction
            pst.executeUpdate();

            // Retrieve the generated keys
            ResultSet generatedKeys = pst.getGeneratedKeys();
            if (generatedKeys.next()) {
                generatedId = generatedKeys.getInt(1); // Assuming the ID column is the first column
                direction.setRecipe_id(generatedId); // Set the generated ID in the direction object
            }

            // Step 4: Close the database connection and statement
            pst.close();
            cn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return generatedId;
    }

    public static int editDirections(DirectionDTO direction) {
        int generatedId = -1; // Default value if ID generation fails
        Connection cn = null;
        try {
            // Step 1: Establish a database connection
            cn = DBUtils.getConnection();
            // Step 2: Create a prepared statement to insert the directions
            String sql = "UPDATE [dbo].[Direction] "
                    + "SET description = ? "
                    + "WHERE id = ?";
            PreparedStatement pst = cn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);

            // Step 3: Insert each direction object and retrieve the generated keys
            pst.setString(1, direction.getDesc());
            pst.setInt(2, direction.getRecipe_id());

            // Execute the statement for each direction
            pst.executeUpdate();

            // Retrieve the generated keys
            ResultSet generatedKeys = pst.getGeneratedKeys();
            if (generatedKeys.next()) {
                generatedId = generatedKeys.getInt(1); // Assuming the ID column is the first column
                direction.setRecipe_id(generatedId); // Set the generated ID in the direction object
            }

            // Step 4: Close the database connection and statement
            pst.close();
            cn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return generatedId;
    }

    public static int deleteDirection(int recipeId) {
        int result = -1;
        Connection cn = null;

        try {
            cn = DBUtils.getConnection();

            if (cn != null) {
                String sql = "DELETE FROM [dbo].[Direction]\n"
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

    public static void main(String[] args) {

    }

}
