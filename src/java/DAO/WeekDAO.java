/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import DTO.WeekDTO;
import Utils.DBUtils;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;

/**
 *
 * @author Daiisuke
 */
public class WeekDAO {

    public static boolean insertWeek(int plan_id, Date start_at) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        String sql = "INSERT INTO [Week](plan_id, start_at)\n"
                + "VALUES (?, ?)";

        try {
            con = DBUtils.getConnection();
            if (con != null) {
                stm = con.prepareStatement(sql);
                stm.setInt(1, plan_id);
                stm.setDate(2, start_at);

                int effectRows = stm.executeUpdate();
                if (effectRows > 0) {
                    return true;
                }
            }
        } catch (SQLException ex) {
            System.out.println("Query error - insertWeek: " + ex.getMessage());
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

    public static WeekDTO getWeekByPlanID(int plan_id) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        WeekDTO result = null;

        String sql = "SELECT * FROM [Week]\n"
                + "WHERE plan_id = ?";

        try {
            con = DBUtils.getConnection();
            if (con != null) {
                stm = con.prepareStatement(sql);
                stm.setInt(1, plan_id);
                rs = stm.executeQuery();
                while (rs.next()) {

                    int id = rs.getInt("id");
                    Date start_at = rs.getDate("start_at");
                    plan_id = rs.getInt("plan_id");
                    boolean is_sync = rs.getBoolean("is_sync");
                    boolean is_template = rs.getBoolean("is_template");

                    result = new WeekDTO(id, start_at, plan_id, is_sync, is_template);
                }

            }
        } catch (SQLException ex) {
            System.out.println("Query error - getWeekIDByPlanId: " + ex.getMessage());
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

    public static WeekDTO getWeekByDate(String selectedDateStr, int plan_id) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        WeekDTO result = null;

        String sql = "SELECT w.*\n"
                + "FROM Week w\n"
                + "LEFT JOIN [Date] d ON w.id = d.week_id \n"
                + "WHERE d.[date] LIKE ? AND d.plan_id = ? AND w.is_template = 0";

        try {
            con = DBUtils.getConnection();
            if (con != null) {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                java.util.Date utilDate = sdf.parse(selectedDateStr);
                java.sql.Date sqlSelectedDate = new java.sql.Date(utilDate.getTime());

                stm = con.prepareStatement(sql);
                stm.setDate(1, sqlSelectedDate);
                stm.setInt(2, plan_id);
                rs = stm.executeQuery();
                while (rs.next()) {

                    int id = rs.getInt("id");
                    Date start_at = rs.getDate("start_at");
                    plan_id = rs.getInt("plan_id");
                    boolean is_sync = rs.getBoolean("is_sync");
                    boolean is_template = rs.getBoolean("is_template");

                    result = new WeekDTO(id, start_at, plan_id, is_sync, is_template);
                }

            }
        } catch (SQLException | ParseException ex) {
            System.out.println("Query error - getWeekIDByPlanId: " + ex.getMessage());
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

    public static boolean deleteWeekOnId(int weekId) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        String sql = "DELETE d\n"
                + "FROM [Week] d\n"
                + "WHERE d.id = ?";

        try {
            con = DBUtils.getConnection();
            if (con != null) {
                stm = con.prepareStatement(sql);
                stm.setInt(1, weekId);

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
