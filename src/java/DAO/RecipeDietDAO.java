/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import DTO.IngredientDetailDTO;
import DTO.RecipeDietDTO;
import Utils.DBUtils;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

/**
 *
 * @author khang
 */
public class RecipeDietDAO {

    public static ArrayList<RecipeDietDTO> getDietDetailByRecipeId(int id) {
        ArrayList<RecipeDietDTO> result = new ArrayList<>();
        Connection cn = null;

        try {
            cn = DBUtils.getConnection();

            if (cn != null) {
                String sql = "SELECT rd.[id]\n"
                        + "      ,[recipe_id]\n"
                        + "      ,[diet_id]\n"
                        + "	  ,title\n"
                        + "  FROM [RecipeManagement].[dbo].[RecipeDiet] rd\n"
                        + "  JOIN [dbo].[Diet] d ON rd.diet_id = d.id  \n"
                        + "WHERE recipe_id = ?";

                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setInt(1, id);
                ResultSet rs = pst.executeQuery();
                if (rs != null) {
                    while (rs.next()) {
                        id = rs.getInt("id");
                        int recipe_id = rs.getInt("recipe_id");
                        int diet_id = rs.getInt("diet_id");
                        String title = rs.getString("title");

                        RecipeDietDTO recipeDiet = new RecipeDietDTO(id, recipe_id, diet_id, title);
                        result.add(recipeDiet);
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
    
    public static Set<Integer> getDietSetByRecipeId(int id) {
        Set<Integer> result = new HashSet<>();
        Connection cn = null;

        try {
            cn = DBUtils.getConnection();

            if (cn != null) {
                String sql = "SELECT rd.[id]\n"
                        + "      ,[recipe_id]\n"
                        + "      ,[diet_id]\n"
                        + "  FROM [RecipeManagement].[dbo].[RecipeDiet] rd\n"
                        + "  JOIN [dbo].[Diet] d ON rd.diet_id = d.id  \n"
                        + "WHERE recipe_id = ?";

                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setInt(1, id);
                ResultSet rs = pst.executeQuery();
                if (rs != null) {
                    while (rs.next()) {
                        int diet_id = rs.getInt("diet_id");
                        result.add(diet_id);
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
    

    public static int addRecipeDiet(List<RecipeDietDTO> recipeDiet) {
        int result = -1;
        Connection cn = null;

        try {
            cn = DBUtils.getConnection();

            if (cn != null) {
                String sql = "INSERT INTO RecipeDiet(recipe_id, diet_id) \n"
                        + "VALUES (?, ?)";

                PreparedStatement pst = cn.prepareStatement(sql);
                for (RecipeDietDTO rd : recipeDiet) {

                    pst.setInt(1, rd.getRecipe_id());
                    pst.setInt(2, rd.getDiet_id());
                    result = pst.executeUpdate();
                }
                pst.close();
                cn.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }

    public static int deleteRecipeDiet(int recipeId) {
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
                pst.close();
                cn.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }
    
    public static void main(String[] args) {
        System.out.println(getDietDetailByRecipeId(9).size() == 0);
    }

}
