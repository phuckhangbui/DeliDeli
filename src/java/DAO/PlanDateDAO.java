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

    // This will select all current date plan and then select the one that hasn't been notified.
    public static PlanDateDTO getActiveRecipePlan(Date currentDate, int plan_id) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        PlanDateDTO result = new PlanDateDTO();

        String sql = "SELECT TOP 1 *\n"
                + "FROM [Date] d\n"
                + "JOIN [Meal] m ON d.id = m.date_id\n"
                + "WHERE d.[date] = ? AND d.plan_id = ? AND m.isNotified = 0\n"
                + "ORDER BY m.start_time ";

        try {
            con = DBUtils.getConnection();
            if (con != null) {
                stm = con.prepareStatement(sql);
                stm.setDate(1, currentDate);
                stm.setInt(2, plan_id);
                rs = stm.executeQuery();
                while (rs.next()) {

                    int id = rs.getInt("id");
                    Date date = rs.getDate("date");
                    int date_id = rs.getInt("date_id");
                    int week_id = rs.getInt("week_id");
                    plan_id = rs.getInt("plan_id");
                    Time start_time = rs.getTime("start_time");

                    result = new PlanDateDTO(id, date, date_id, week_id, plan_id, start_time);
                    return result;
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

    public static boolean deleteDateByPlanId(int plan_id) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        String sql = "DELETE d\n"
                + "FROM [Date] d\n"
                + "WHERE d.plan_id = ?";

        try {
            con = DBUtils.getConnection();
            if (con != null) {
                stm = con.prepareStatement(sql);
                stm.setInt(1, plan_id);

                int rowsAffected = stm.executeUpdate();
                return rowsAffected > 0;
            }
        } catch (SQLException ex) {
            System.out.println("Query error - deleteDateByPlanId: " + ex.getMessage());
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

}
