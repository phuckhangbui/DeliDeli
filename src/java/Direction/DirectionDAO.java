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

    public static ArrayList<DirectionDTO> getDirectionByRecipeId(int id) {
        ArrayList<DirectionDTO> result = new ArrayList<>();
        Connection cn = null;

        try {
            cn = DBUtils.getConnection();

            if (cn != null) {
                String sql = "SELECT d.*\n"
                        + "FROM Recipe r INNER JOIN Direction d\n"
                        + "ON r.id = d.recipe_id\n"
                        + "WHERE r.id = ?";

                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setInt(1, id);
                ResultSet rs = pst.executeQuery();
                if (rs != null) {
                    while (rs.next()) {
                        id = rs.getInt("id");
                        Boolean isHeader = rs.getBoolean("is_header");
                        int step = rs.getInt("step");
                        String desc = rs.getString("description");
                        int recipe_id = rs.getInt("recipe_id");
                        DirectionDTO direction = new DirectionDTO(id, isHeader, step, desc, recipe_id);

                        result.add(direction);
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

    public static List<DirectionDTO> extractDirectionsFromQueryString(String queryString, int recipeId) {
        String[] parameters = queryString.split("&");
        List<DirectionDTO> directionsList = new ArrayList<>();
        int step = 1;

        for (String parameter : parameters) {
            String[] parts = parameter.split("=");
            String paramName = parts[0];
            String paramValue = parts.length > 1 ? parts[1] : "";

            if (paramName.equals("header")) {
                DirectionDTO directionDTO = new DirectionDTO();
                directionDTO.setIs_header(true);
                directionDTO.setStep(step++);
                directionDTO.setDesc(paramValue);
                directionDTO.setRecipe_id(recipeId);
                directionsList.add(directionDTO);
            } else if (paramName.equals("direction")) {
                DirectionDTO directionDTO = new DirectionDTO();
                directionDTO.setIs_header(false);
                directionDTO.setStep(step++);
                directionDTO.setDesc(paramValue);
                directionDTO.setRecipe_id(recipeId);
                directionsList.add(directionDTO);
            }
        }

        return directionsList;
    }

    public static int addDirections(List<DirectionDTO> directions) {
        int generatedId = -1; // Default value if ID generation fails
        Connection cn = null;
        try {
            // Step 1: Establish a database connection
            cn = DBUtils.getConnection();
            // Step 2: Create a prepared statement to insert the directions
            String sql = "INSERT INTO [dbo].[Direction] ([is_header],[step] ,description, recipe_id) VALUES (?, ?, ?, ?)";
            PreparedStatement pst = cn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);

            // Step 3: Insert each direction object and retrieve the generated keys
            for (DirectionDTO direction : directions) {
                pst.setBoolean(1, direction.getIs_header());
                pst.setInt(2, direction.getStep());
                pst.setString(3, direction.getDesc());
                pst.setInt(4, direction.getRecipe_id());

                // Execute the statement for each direction
                pst.executeUpdate();

                // Retrieve the generated keys
                ResultSet generatedKeys = pst.getGeneratedKeys();
                if (generatedKeys.next()) {
                    generatedId = generatedKeys.getInt(1); // Assuming the ID column is the first column
                    direction.setId(generatedId); // Set the generated ID in the direction object
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
        List<DirectionDTO> list = DirectionDAO.extractDirectionsFromQueryString("http://localhost:3030/ProjectSWP/MainController?title=recipe+title&description=test&thumbnail=&pictures=&servings=12&diet=1&category=4&cuisine=1&level=1&ingredientDesc=i1&ingredientId=1&ingredientDesc=i2&ingredientId=4&ingredientDesc=i3&ingredientId=6&header=h1&direction=d1&direction=d1.1&header=h2&direction=d2&status=2&userId=3&action=addRecipe&prepTimeMinutes=11&cookTimeMinutes=60", 1);
        for (DirectionDTO o : list) {
            System.out.println(o);
        }
    }

}
