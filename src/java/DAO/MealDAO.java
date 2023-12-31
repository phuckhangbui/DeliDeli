/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import DTO.DateDTO;
import DTO.MealDTO;
import DTO.NutritionDTO;
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

                    MealDTO meal = new MealDTO(id, date_id, recipe_id, start_time, date_id);
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

                    result = new MealDTO(id, date_id, recipe_id, start_time, date_id);
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

    public static MealDTO getMealByTimeAndDate(Time start_time, int date_id) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        MealDTO result = new MealDTO();

        System.out.println("Start_time - " + start_time);

        String sql = "SELECT * FROM [Meal]\n"
                + "WHERE CAST(start_time AS time) = CAST(? AS time) AND date_id = ?";

        try {
            con = DBUtils.getConnection();
            if (con != null) {
                stm = con.prepareStatement(sql);
                stm.setTime(1, start_time);
                stm.setInt(2, date_id);
                rs = stm.executeQuery();
                while (rs.next()) {

                    int id = rs.getInt("id");
                    date_id = rs.getInt("date_id");
                    int recipe_id = rs.getInt("recipe_id");
                    start_time = rs.getTime("start_time");

                    result = new MealDTO(id, date_id, recipe_id, start_time);
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
                    plan_id = rs.getInt("plan_id");

                    // Time filter
                    if (breakfast) {
                        if (start_time.getHours() < 12) {
                            MealDTO meal = new MealDTO(id, date_id, recipe_id, start_time, plan_id);
                            result.add(meal);
                        }
                    } else if (lunch) {
                        if (start_time.getHours() >= 12 && start_time.getHours() < 17) {
                            MealDTO meal = new MealDTO(id, date_id, recipe_id, start_time, plan_id);
                            result.add(meal);
                        }
                    } else if (dinner) {
                        if (start_time.getHours() >= 17 && start_time.getHours() <= 24) {
                            MealDTO meal = new MealDTO(id, date_id, recipe_id, start_time, plan_id);
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

    public static int countRecipeBasedOnTime(int date_id) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        int result = 0;

        String sql = "SELECT COUNT(*) AS meal_count\n"
                + "FROM Meal\n"
                + "WHERE date_id = ? AND DATEPART(HOUR, start_time) >= 0 AND DATEPART(HOUR, start_time) < 12";

        try {
            con = DBUtils.getConnection();
            if (con != null) {
                stm = con.prepareStatement(sql);
                stm.setInt(1, date_id);
                rs = stm.executeQuery();
                while (rs.next()) {

                    int meal_count = rs.getInt("meal_count");
                    result = meal_count;

                    return result;
                }
            }
        } catch (SQLException ex) {
            System.out.println("Query error - countRecipeBasedOnTime: " + ex.getMessage());
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

//    public static boolean addMealById(int date_id, int recipe_id, Time start_time, Time end_time) {
//        Connection con = null;
//        PreparedStatement stm = null;
//        ResultSet rs = null;
//
//        String sql = "INSERT INTO [Meal](date_id, recipe_id, start_time, end_time, isNotified)\n"
//                + "VALUES (?, ?, ?, ?, ?)";
//
//        try {
//            con = DBUtils.getConnection();
//            if (con != null) {
//                stm = con.prepareStatement(sql);
//                stm.setInt(1, date_id);
//                stm.setInt(2, recipe_id);
//                stm.setTime(3, start_time);
//                stm.setTime(4, end_time);
//                stm.setBoolean(5, false);
//
//                int effectRows = stm.executeUpdate();
//                if (effectRows > 0) {
//                    return true;
//                }
//            }
//        } catch (SQLException ex) {
//            System.out.println("Query error - insertMeal: " + ex.getMessage());
//        } finally {
//            try {
//                if (rs != null) {
//                    rs.close();
//                }
//                if (stm != null) {
//                    stm.close();
//                }
//                if (con != null) {
//                    con.close();
//                }
//            } catch (SQLException ex) {
//                System.out.println("Error closing database resources: " + ex.getMessage());
//            }
//        }
//        return false;
//    }
    public static boolean changeStartTimeOfRecipe(int meal_id, int date_id, Time start_time) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        String sql = "UPDATE Meal SET [start_time] = ?\n"
                + "WHERE id = ? AND date_id = ?";

        try {
            con = DBUtils.getConnection();
            if (con != null) {
                stm = con.prepareStatement(sql);
                stm.setTime(1, start_time);
                stm.setInt(2, meal_id);
                stm.setInt(3, date_id);

                int effectRows = stm.executeUpdate();
                if (effectRows > 0) {
                    return true;
                }
            }
        } catch (SQLException ex) {
            System.out.println("Query error - change recipe start time: " + ex.getMessage());
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

    public static boolean addMealById(int date_id, int recipe_id, Time start_time) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        String sql = "INSERT INTO [Meal](date_id, recipe_id, start_time, isNotified)\n"
                + "VALUES (?, ?, ?, ?)";

        try {
            con = DBUtils.getConnection();
            if (con != null) {
                stm = con.prepareStatement(sql);
                stm.setInt(1, date_id);
                stm.setInt(2, recipe_id);
                stm.setTime(3, start_time);
                stm.setBoolean(4, false);

                int effectRows = stm.executeUpdate();
                if (effectRows > 0) {
                    return true;
                }
            }
        } catch (SQLException ex) {
            System.out.println("Query error - addMealById: " + ex.getMessage());
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

    public static boolean updateMealNotificationStatusByMealID(int meal_id) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        String sql = "UPDATE dbo.[Meal]\n"
                + "SET [isNotified] = ?\n"
                + "WHERE id = ?";

        try {
            con = DBUtils.getConnection();
            if (con != null) {
                stm = con.prepareStatement(sql);
                stm.setBoolean(1, true);
                stm.setInt(2, meal_id);

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

    public static ArrayList<MealDTO> getActiveRecipePlanByTime(Date currentDate, int plan_id, String currentTime) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        ArrayList<MealDTO> result = new ArrayList<>();

        String sql = "SELECT m.id, m.start_time, m.date_id, m.recipe_id\n"
                + "FROM [Meal] m\n"
                + "JOIN [Date] d ON d.id = m.date_id\n"
                + "WHERE d.[date] = ? AND d.plan_id = ? AND m.start_time <= ? AND m.isNotified = 0";

        try {
            con = DBUtils.getConnection();
            if (con != null) {
                stm = con.prepareStatement(sql);
                stm.setDate(1, new java.sql.Date(currentDate.getTime()));
                stm.setInt(2, plan_id);
                stm.setString(3, currentTime);
                rs = stm.executeQuery();
                while (rs.next()) {

                    int id = rs.getInt("id");
                    Time start_time = rs.getTime("start_time");
                    int date_id = rs.getInt("date_id");
                    int recipe_id = rs.getInt("recipe_id");

                    MealDTO meal = new MealDTO(id, date_id, recipe_id, start_time);
                    result.add(meal);
                }
            }
        } catch (SQLException ex) {
            System.out.println("Query error - getActiveRecipePlanByTime: " + ex.getMessage());
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

    public static boolean removeRecipeFromPlan(int meal_id) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        String sql = "DELETE FROM Meal\n"
                + "WHERE id = ?";

        try {
            con = DBUtils.getConnection();
            if (con != null) {
                stm = con.prepareStatement(sql);
                stm.setInt(1, meal_id);

                int effectRows = stm.executeUpdate();
                if (effectRows > 0) {
                    return true;
                }
            }
        } catch (SQLException ex) {
            System.out.println("Query error - removeRecipeFromPlanByMealID: " + ex.getMessage());
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

    public static boolean deleteAllMealByDate(int plan_id, int date_id) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        String sql = "DELETE m\n"
                + "FROM Meal m\n"
                + "INNER JOIN [Date] d ON d.id = m.date_id\n"
                + "WHERE d.plan_id = ? AND d.id = ?";

        try {
            con = DBUtils.getConnection();
            if (con != null) {
                stm = con.prepareStatement(sql);
                stm.setInt(1, plan_id);
                stm.setInt(2, date_id);

                int rowsAffected = stm.executeUpdate();
                return rowsAffected > 0;
            }
        } catch (SQLException ex) {
            System.out.println("Query error - deleteAllRecipeByPlanID: " + ex.getMessage());
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

    public static boolean deleteAllMealByPlanID(int plan_id) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        String sql = "DELETE m\n"
                + "FROM Meal m\n"
                + "INNER JOIN [Date] d ON d.id = m.date_id\n"
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
            System.out.println("Query error - deleteAllRecipeByPlanID: " + ex.getMessage());
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

    public static void deleteMealByRecipeId(int id) {
        Connection cn = null;

        try {
            cn = DBUtils.getConnection();

            if (cn != null) {
                String sql = "DELETE FROM Meal\n"
                        + "WHERE recipe_id = ?";

                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setInt(1, id);
                pst.executeUpdate();

                pst.close();
                cn.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    public static void main(String[] args) {
        System.out.println(getMealByTimeAndDate(new java.sql.Time(System.currentTimeMillis()), 5));
    }

    public static ArrayList<NutritionDTO> getSumNutritionValuesByDateId(int date_id) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        ArrayList<NutritionDTO> result = new ArrayList<>();

        String sql = "SELECT SUM(n.calories) AS total_calories, SUM(n.fat) AS total_fat, SUM(n.carbs) AS total_carbs, SUM(n.protein) AS total_protein\n"
                + "FROM Recipe r\n"
                + "JOIN Meal m ON r.id = m.recipe_id\n"
                + "JOIN Nutrition n ON r.id = n.recipe_id\n"
                + "WHERE m.date_id = ?\n";

        try {
            con = DBUtils.getConnection();
            if (con != null) {
                stm = con.prepareStatement(sql);
                stm.setInt(1, date_id);

                rs = stm.executeQuery();
                while (rs.next()) {
                    int total_calories = rs.getInt("total_calories");
                    int total_fat = rs.getInt("total_fat");
                    int total_carbs = rs.getInt("total_carbs");
                    int total_protein = rs.getInt("total_protein");

                    NutritionDTO recipeNutrition = new NutritionDTO(total_calories, total_fat, total_carbs, total_protein);
                    result.add(recipeNutrition);

                }
            }
        } catch (SQLException ex) {
            System.out.println("Query error - getSumNutritionValuesByDateId: " + ex.getMessage());
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
