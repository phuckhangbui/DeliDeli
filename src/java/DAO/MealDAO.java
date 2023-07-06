/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import DTO.MealDTO;
import DTO.PlanDTO;
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
public class MealDAO {

    public static ArrayList<MealDTO> getAllMealByDateId(int DateId) {
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
                    Time start_time = rs.getTime("start_time");
                    Time end_time = rs.getTime("end_time");

                    MealDTO meal = new MealDTO(id, date_id, recipe_id, start_time, end_time, date_id);
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
    public static MealDTO getMealByDateId(int DateId) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        MealDTO result = new MealDTO();

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
                    Time start_time = rs.getTime("start_time");
                    Time end_time = rs.getTime("end_time");

                    result = new MealDTO(id, date_id, recipe_id, start_time, end_time);
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

    public static ArrayList<MealDTO> getAllMealsTimeBased(int plan_id, int date_id, boolean breakfast, boolean lunch, boolean dinner) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        ArrayList<MealDTO> result = new ArrayList<>();

        String sql = "SELECT *\n"
                + "FROM [Meal] m\n"
                + "JOIN [Date] d ON m.date_id = d.id\n"
                + "WHERE [plan_id] = ? and [date_id] = ?\n"
                + "ORDER BY [start_time]\n";

        try {
            con = DBUtils.getConnection();
            if (con != null) {
                stm = con.prepareStatement(sql);
                stm.setInt(1, plan_id);
                stm.setInt(2, date_id);
                rs = stm.executeQuery();
                while (rs.next()) {

                    int id = rs.getInt("id");
                    date_id = rs.getInt("date_id");
                    int recipe_id = rs.getInt("recipe_id");
                    Time start_time = rs.getTime("start_time");
                    Time end_time = rs.getTime("end_time");
                    plan_id = rs.getInt("plan_id");

                    // Time filter
                    if (breakfast) {
                        if (start_time.getHours() >= 5 && start_time.getHours() < 12) {
                            MealDTO meal = new MealDTO(id, date_id, recipe_id, start_time, end_time, plan_id);
                            result.add(meal);
                        }
                    } else if (lunch) {
                        if (start_time.getHours() >= 12 && start_time.getHours() < 17) {
                            MealDTO meal = new MealDTO(id, date_id, recipe_id, start_time, end_time, plan_id);
                            result.add(meal);
                        }
                    } else if (dinner) {
                        if (start_time.getHours() >= 17 && start_time.getHours() < 24) {
                            MealDTO meal = new MealDTO(id, date_id, recipe_id, start_time, end_time, plan_id);
                            result.add(meal);
                        }
                    }
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

    public static boolean addMealById(int date_id, int recipe_id, Time start_time, Time end_time) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        String sql = "INSERT INTO [Meal](date_id, recipe_id, start_time, end_time)\n"
                + "VALUES (?, ?, ?, ?)";

        try {
            con = DBUtils.getConnection();
            if (con != null) {
                stm = con.prepareStatement(sql);
                stm.setInt(1, date_id);
                stm.setInt(2, recipe_id);
                stm.setTime(3, start_time);
                stm.setTime(4, end_time);

                int effectRows = stm.executeUpdate();
                if (effectRows > 0) {
                    return true;
                }
            }
        } catch (SQLException ex) {
            System.out.println("Query error - insertPlan: " + ex.getMessage());
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
    
    public static boolean updateMealNotificationStatusById(int id) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        String sql = "UPDATE dbo.[Meal]\n"
                + "SET [isNotified] = 1\n"
                + "WHERE id = ?";

        try {
            con = DBUtils.getConnection();
            if (con != null) {
                stm = con.prepareStatement(sql);
                stm.setInt(1, id);

                int effectRows = stm.executeUpdate();
                if (effectRows > 0) {
                    return true;
                }
            }
        } catch (SQLException ex) {
            System.out.println("Query error - updateMealNotificationStatusById: " + ex.getMessage());
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
