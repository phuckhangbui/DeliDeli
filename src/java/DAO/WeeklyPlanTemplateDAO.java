/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import DTO.PlanDTO;
import Utils.DBUtils;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

/**
 *
 * @author khang
 */
public class WeeklyPlanTemplateDAO {

    public static int insertWeekTemplate(int plan_id, Date startDate) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        int effectRows = 0;
        int generatedId = -1; // Variable to store the generated ID

        String sql = "INSERT INTO [dbo].[Week] ([start_at],[plan_id], [is_template])\n"
                + "VALUES (?,?,1)";

        try {
            con = DBUtils.getConnection();
            if (con != null) {

                stm = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS); // Specify that you want to retrieve generated keys
                stm.setDate(1, startDate);
                stm.setInt(2, plan_id);
                effectRows = stm.executeUpdate();

                if (effectRows > 0) {
                    rs = stm.getGeneratedKeys(); // Retrieve the generated keys
                    if (rs.next()) {
                        generatedId = rs.getInt(1); // Get the generated ID
                    }
                    return generatedId; // Return the generated ID
                }
            }
        } catch (SQLException ex) {
            System.out.println("Query error - insertAllDatesWithinAWeek: " + ex.getMessage());
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

        return generatedId; // Return -1 if the ID retrieval failed or the insert query was not successful
    }
    
    public static boolean insertDateOfWeeklyTemplate(Date start_date, int week_id, int plan_id) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        int effectRows = 0;

        String sql = "INSERT INTO [Date](date, week_id, plan_id, is_template)\n"
                + "VALUES (?, ?, ?, 1)";

        try {
            con = DBUtils.getConnection();
            if (con != null) {

                List<Date> dates = new ArrayList<>();

                // Iterate through calendar
                Calendar calendar = Calendar.getInstance();
                calendar.setTime(start_date);

                // Iterate from start_date until end_date, we add each date into a list.
                for(int i = 0; i < 7; i++) {
                    Date currentDate = new Date(calendar.getTime().getTime()); // Convert java.util.Date to java.sql.Date
                    dates.add(currentDate);
                    calendar.add(Calendar.DAY_OF_MONTH, 1);
                }

                // Insert each date into the database
                for (Date date : dates) {
                    stm = con.prepareStatement(sql);
                    stm.setDate(1, date);
                    stm.setInt(2, week_id);
                    stm.setInt(3, plan_id);
                    effectRows = stm.executeUpdate();
                }

                if (effectRows > 0) {
                    return true;
                }
            }
        } catch (SQLException ex) {
            System.out.println("Query error - insertAllDatesWithinAWeek: " + ex.getMessage());
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
