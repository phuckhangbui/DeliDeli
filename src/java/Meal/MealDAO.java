/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Meal;

import Plan.PlanDTO;
import Utils.DBUtils;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 *
 * @author Daiisuke
 */
public class MealDAO {

    public static ArrayList<MealDTO> getMealByDateId(int DateId) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        ArrayList<MealDTO> result = new ArrayList<>();

        String sql = "SELECT * FROM [Meal]\n"
                + "WHERE date_id = ?";

        try {
            con = DBUtils.getConnection();
            if (con != null) {
                stm = con.prepareStatement(sql);
                stm.setInt(1, DateId);
                rs = stm.executeQuery();
                while (rs.next()) {

                    int id = rs.getInt("id");
                    int date_id = rs.getInt("date_id");
                    int recipe_id = rs.getInt("recipe_id");
                    Date start_time = rs.getDate("start_time");
                    Date end_time = rs.getDate("end_time");

                    MealDTO meal = new MealDTO(id, date_id, recipe_id, start_time, end_time);
                    result.add(meal);
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
        return result;
    }
}
