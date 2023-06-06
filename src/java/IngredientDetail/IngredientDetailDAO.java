/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package IngredientDetail;

import Utils.DBUtils;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
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

    public static void main(String[] args) {
        List<IngredientDetailDTO> list = IngredientDetailDAO.getIngredientDetailByRecipeId(1);
        for (IngredientDetailDTO o : list) {
            System.out.println(o);
        }
    }
}
