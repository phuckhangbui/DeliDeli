/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Nutrition;

import Utils.DBUtils;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

/**
 *
 * @author khang
 */
public class NutritionDAO {

    public static NutritionDTO getNutrition(int recipe_id) {
        NutritionDTO result = null;

        Connection cn = null;

        try {
            cn = DBUtils.getConnection();

            if (cn != null) {
                String sql = "SELECT *\n"
                        + "  FROM [RecipeManagement].[dbo].[Nutrition]"
                        + "WHERE recipe_id = ?";

                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setInt(1, recipe_id);
                ResultSet rs = pst.executeQuery();
                if (rs != null) {
                    while (rs.next()) {
                        int calories = rs.getInt("calories");
                        int fat = rs.getInt("fat");
                        int carbs = rs.getInt("carbs");
                        int protein = rs.getInt("protein");

                        result = new NutritionDTO(recipe_id, calories, fat, carbs, protein);
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

    public static int addNutrition(NutritionDTO nutrition) {
        int result = -1;

        Connection cn;
        try {
            cn = DBUtils.getConnection();
            String sql = "INSERT INTO Nutrition(recipe_id, calories, fat, carbs, protein) \n"
                    + "VALUES \n"
                    + "(?,?,?,?,?)";
            PreparedStatement pst = cn.prepareStatement(sql);

            pst.setInt(1, nutrition.getRecipe_id());
            pst.setInt(2, nutrition.getCalories());
            pst.setInt(3, nutrition.getFat());
            pst.setInt(4, nutrition.getCarbs());
            pst.setInt(5, nutrition.getProtein());
            pst.executeUpdate();
            result = 1;

            pst.close();
            cn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }

    public static int editNutrition(NutritionDTO nutrition) {
        int result = -1;

        Connection cn;
        try {
            cn = DBUtils.getConnection();
            String sql = "UPDATE Nutrition SET calories = ?, fat = ?, carbs = ?, protein = ? WHERE recipe_id = ?";
            PreparedStatement pst = cn.prepareStatement(sql);

            pst.setInt(5, nutrition.getRecipe_id());
            pst.setInt(1, nutrition.getCalories());
            pst.setInt(2, nutrition.getFat());
            pst.setInt(3, nutrition.getCarbs());
            pst.setInt(4, nutrition.getProtein());
            pst.executeUpdate();
            result = 1;
            pst.close();
            cn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }

    public static int deleteNutrition(int recipeId) {
        int result = -1;

        Connection cn;
        try {
            cn = DBUtils.getConnection();
            String sql = "DELETE FROM [dbo].[Nutrition]\n"
                    + "WHERE recipe_id = ?";
            PreparedStatement pst = cn.prepareStatement(sql);

            pst.setInt(1, recipeId);
            pst.executeUpdate();
            result = 1;

            pst.close();
            cn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }

}
