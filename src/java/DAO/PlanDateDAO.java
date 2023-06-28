/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import DTO.MealDTO;
import DTO.PlanDateDTO;
import Utils.DBUtils;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Time;
import java.util.ArrayList;

/**
 *
 * @author Daiisuke
 */
public class PlanDateDAO {

    public static ArrayList<PlanDateDTO> getAllDateByPlanId(int plan_id) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        ArrayList<PlanDateDTO> result = new ArrayList<>();

        String sql = "SELECT * FROM [Date]\n"
                + "WHERE plan_id = ?";

        try {
            con = DBUtils.getConnection();
            if (con != null) {
                stm = con.prepareStatement(sql);
                stm.setInt(1, plan_id);
                rs = stm.executeQuery();
                while (rs.next()) {

                    int id = rs.getInt("id");
                    Date date = rs.getDate("date");
                    int week_id = rs.getInt("week_id");
                    plan_id = rs.getInt("plan_id");

                    PlanDateDTO planDate = new PlanDateDTO(id, date, week_id, plan_id);
                    result.add(planDate);
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
