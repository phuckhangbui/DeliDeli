/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import DTO.DateDTO;
import DTO.MealDTO;
import DTO.PlanDTO;
import DTO.WeekDTO;
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
                for (int i = 0; i < 7; i++) {
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

    public static int getWeeklyTemplateIdByPlanId(int planId) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        int firstValue = -1; // Variable to store the first value

        String sql = "SELECT id FROM week WHERE is_template = 1 AND plan_id = ?";

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

    public static WeekDTO getWeeklyTemplateByPlanId(int planId) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        WeekDTO result = null;

        String sql = "SELECT * FROM week WHERE is_template = 1 AND plan_id = ?";

        try {
            con = DBUtils.getConnection();
            if (con != null) {
                stm = con.prepareStatement(sql);
                stm.setInt(1, planId); // Set the plan_id value
                rs = stm.executeQuery();

                if (rs.next()) {

                    int id = rs.getInt("id");
                    java.sql.Date start_at = rs.getDate("start_at");
                    planId = rs.getInt("plan_id");
                    boolean isSync = rs.getBoolean("is_sync");
                    boolean isTemplate = rs.getBoolean("is_template");

                    result = new WeekDTO(id, start_at, planId, isSync, isTemplate);

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

    public static ArrayList<Integer> getSyncWeekId(int planId) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        ArrayList<Integer> idList = new ArrayList<>(); // Variable to store the first value

        String sql = "SELECT id FROM week WHERE is_template = 0 AND plan_id = ? AND is_sync = 1";

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

    public static boolean syncWithTemplate(int modifiedDateId, ArrayList<MealDTO> templateMeals) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        String sql = "INSERT INTO [Meal](date_id, recipe_id, start_time, isNotified)\n"
                + "VALUES (?, ?, ?, ?)";

        try {
            con = DBUtils.getConnection();
            if (con != null) {
                for (MealDTO meal : templateMeals) {
                    stm = con.prepareStatement(sql);
                    stm.setInt(1, modifiedDateId);
                    stm.setInt(2, meal.getRecipe_id());
                    stm.setTime(3, meal.getStart_time());
                    stm.setBoolean(4, false);
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

    public static ArrayList<Integer> getEmptyWeekId(int planId) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        ArrayList<Integer> idList = new ArrayList<>(); // Variable to store the first value

        String sql = "SELECT w.id\n"
                + "FROM [dbo].[Week] w\n"
                + "LEFT JOIN [dbo].[Date] d ON w.id = d.week_id\n"
                + "WHERE d.week_id IS NULL AND w.plan_id = ?";

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

    public static void main(String[] args) {
//        System.out.println(getDailyTemplateByPlanId(1));
    }
}
