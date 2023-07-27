/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import DTO.DateDTO;
import DTO.MealDTO;
import Utils.DBUtils;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

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

    public static DateDTO getDailyTemplateByPlanId(int planId) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        DateDTO result = null;
        
        String sql = "SELECT * FROM date WHERE is_template = 1 AND plan_id = ?";

        try {
            con = DBUtils.getConnection();
            if (con != null) {
                stm = con.prepareStatement(sql);
                stm.setInt(1, planId); // Set the plan_id value
                rs = stm.executeQuery();

                if (rs.next()) {
                  
                        int id = rs.getInt("id");
                        Date date = rs.getDate("date");
                        int week_id = rs.getInt("week_id");
                        planId = rs.getInt("plan_id");
                        boolean isSync = rs.getBoolean("is_sync");
                        boolean isTemplate = rs.getBoolean("is_template");

                        result = new DateDTO(id, date, week_id, planId, isSync, isTemplate);
                    
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

        return result; 

    }

    public static ArrayList<Integer> getSyncDateId(int planId) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        ArrayList<Integer> idList = new ArrayList<>(); // Variable to store the first value

        String sql = "SELECT id FROM date WHERE is_template = 0 AND plan_id = ? AND is_sync = 1";

        try {
            con = DBUtils.getConnection();
            if (con != null) {
                stm = con.prepareStatement(sql);
                stm.setInt(1, planId); // Set the plan_id value
                rs = stm.executeQuery();

                if (rs != null) {
                    while (rs.next()) {
                        int id = rs.getInt(1);
                        idList.add(id);
                    }
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

        return idList;

    }

    public static boolean syncWithDailyTemplate(ArrayList<Integer> idList, ArrayList<MealDTO> templateMeals) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        String sql = "INSERT INTO [Meal](date_id, recipe_id, start_time, isNotified)\n"
                + "VALUES (?, ?, ?, ?)";

        try {
            con = DBUtils.getConnection();
            if (con != null) {
                for (int id : idList) {
                    for (MealDTO meal : templateMeals) {
                        stm = con.prepareStatement(sql);
                        stm.setInt(1, id);
                        stm.setInt(2, meal.getRecipe_id());
                        stm.setTime(3, meal.getStart_time());
                        stm.setBoolean(4, false);
                        stm.executeUpdate();
                    }
                }
            }
        } catch (SQLException ex) {
            System.out.println("Query error - deleteAllRecipeByPlanID: " + ex.getMessage());
            return false;
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
        return true;
    }

    public static boolean deleteSyncDateMeal(int planId, ArrayList<Integer> idList) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        String sql = "DELETE m\n"
                + "FROM Meal m\n"
                + "INNER JOIN [Date] d ON d.id = m.date_id\n"
                + "WHERE m.date_id = ?";

        try {
            con = DBUtils.getConnection();
            if (con != null) {
                for (int id : idList) {
                    stm = con.prepareStatement(sql);
                    stm.setInt(1, id);
                    stm.executeUpdate();
                }
            }
        } catch (SQLException ex) {
            System.out.println("Query error - deleteAllRecipeByPlanID: " + ex.getMessage());
            return false;
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
        return true;
    }

    public static void main(String[] args) {
        System.out.println(getDailyTemplateByPlanId(1));
    }
}
