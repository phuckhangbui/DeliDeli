/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Utils.DBUtils;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 *
 * @author khang
 */
public class DailyPlanTemplateDAO {

    public static int insertDateTemplate(int plan_id) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        int effectRows = 0;
        int generatedId = -1; // Variable to store the generated ID

        String sql = "INSERT INTO [Date](plan_id, is_template)\n"
                + "VALUES (?, 1)";

        try {
            con = DBUtils.getConnection();
            if (con != null) {

                stm = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS); // Specify that you want to retrieve generated keys
                stm.setInt(1, plan_id);
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

    public static int getDailyTemplateIdByPlanId(int planId) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        int firstValue = -1; // Variable to store the first value

        String sql = "SELECT id FROM date WHERE is_template = 1 AND plan_id = ?";

        try {
            con = DBUtils.getConnection();
            if (con != null) {
                stm = con.prepareStatement(sql);
                stm.setInt(1, planId); // Set the plan_id value
                rs = stm.executeQuery();

                if (rs.next()) {
                    firstValue = rs.getInt("id"); // Get the first value from the "id" column
                }
            }
        } catch (SQLException ex) {
            System.out.println("Query error - retrieveFirstValue: " + ex.getMessage());
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

        return firstValue; // Return the first value from the "id" column, or -1 if it couldn't be retrieved or an error occurred

    }
    
    
    
    public static boolean syncWithDailyTemplate(int templateId, int planId){
        
        return true;
    }
    
    
    
    

    public static void main(String[] args) {
        System.out.println(getDailyTemplateIdByPlanId(1));
    }
}
