/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import DTO.DateDTO;
import DTO.PlanDTO;
import Utils.DBUtils;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

/**
 *
 * @author Daiisuke
 */
public class PlanDAO {

    public static boolean insertPlan(String name, String description, String note, Date start_at, Date end_at, boolean status, int user_id, int diet_id, boolean isDaily) throws Exception {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        LocalDate today = LocalDate.now();

        String sql = "INSERT INTO [Plan](name, description, note, start_at, end_at, status, user_id, diet_id, isDaily)\n"
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try {
            con = DBUtils.getConnection();
            if (con != null) {
                stm = con.prepareStatement(sql);
                stm.setString(1, name);
                stm.setString(2, description);
                stm.setString(3, note);
                stm.setDate(4, start_at);
                stm.setDate(5, end_at);

                if (today.isEqual(start_at.toLocalDate())) {
                    status = true;
                }

                stm.setBoolean(6, status);
                stm.setInt(7, user_id);
                stm.setInt(8, diet_id);
                stm.setBoolean(9, isDaily);

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

    public static PlanDTO getCurrentActivePlan(int user_id) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        PlanDTO result = null;

        String sql = "SELECT * FROM [Plan]\n"
                + "WHERE user_id = ? AND status = 1";

        try {
            con = DBUtils.getConnection();
            if (con != null) {
                stm = con.prepareStatement(sql);
                stm.setInt(1, user_id);
                rs = stm.executeQuery();
                while (rs.next()) {

                    int id = rs.getInt("id");
                    String name = rs.getString("name");
                    String description = rs.getString("description");
                    String note = rs.getString("note");
                    Date start_at = rs.getDate("start_at");
                    Date end_at = rs.getDate("end_at");
                    boolean status = rs.getBoolean("status");
                    user_id = rs.getInt("user_id");
                    int diet_id = rs.getInt("diet_id");
                    boolean isDaily = rs.getBoolean("isDaily");

                    result = new PlanDTO(id, name, description, note, start_at, end_at, status, user_id, diet_id, isDaily);
                }
            }
        } catch (SQLException ex) {
            System.out.println("Query error - getAllUserPlanByUserID: " + ex.getMessage());
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

    public static PlanDTO getTodayPlan(int user_id, Date today_date) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        PlanDTO result = null;

        String sql = "SELECT * FROM [Plan]\n"
                + "WHERE user_id = ? AND start_at = ? AND status = 0";

        try {
            con = DBUtils.getConnection();
            if (con != null) {
                stm = con.prepareStatement(sql);
                stm.setInt(1, user_id);
                stm.setDate(2, today_date);
                rs = stm.executeQuery();
                while (rs.next()) {

                    int id = rs.getInt("id");
                    String name = rs.getString("name");
                    String description = rs.getString("description");
                    String note = rs.getString("note");
                    Date start_at = rs.getDate("start_at");
                    Date end_at = rs.getDate("end_at");
                    boolean status = rs.getBoolean("status");
                    user_id = rs.getInt("user_id");
                    int diet_id = rs.getInt("diet_id");
                    boolean isDaily = rs.getBoolean("isDaily");

                    result = new PlanDTO(id, name, description, note, start_at, end_at, status, user_id, diet_id, isDaily);
                }
            }
        } catch (SQLException ex) {
            System.out.println("Query error - getAllUserPlanByUserID: " + ex.getMessage());
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

    public static ArrayList<PlanDTO> getAllUserPlanByUserID(int userId) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        ArrayList<PlanDTO> result = new ArrayList<>();

        String sql = "SELECT * FROM [Plan]\n"
                + "WHERE user_id = ?\n"
                + "ORDER BY status DESC";

        try {
            con = DBUtils.getConnection();
            if (con != null) {
                stm = con.prepareStatement(sql);
                stm.setInt(1, userId);
                rs = stm.executeQuery();
                while (rs.next()) {

                    int id = rs.getInt("id");
                    String name = rs.getString("name");
                    String description = rs.getString("description");
                    String note = rs.getString("note");
                    Date start_at = rs.getDate("start_at");
                    Date end_at = rs.getDate("end_at");
                    boolean status = rs.getBoolean("status");
                    int user_id = rs.getInt("user_id");
                    int diet_id = rs.getInt("diet_id");
                    boolean isDaily = rs.getBoolean("isDaily");

                    PlanDTO userPlan = new PlanDTO(id, name, description, note, start_at, end_at, status, user_id, diet_id, isDaily);
                    result.add(userPlan);
                }
            }
        } catch (SQLException ex) {
            System.out.println("Query error - getAllUserPlanByUserID: " + ex.getMessage());
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

    public static PlanDTO getPlanById(int plan_id) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        PlanDTO result = new PlanDTO();

        String sql = "SELECT * FROM [Plan]\n"
                + "WHERE id = ?\n";

        try {
            con = DBUtils.getConnection();
            if (con != null) {
                stm = con.prepareStatement(sql);
                stm.setInt(1, plan_id);
                rs = stm.executeQuery();
                while (rs.next()) {

                    plan_id = rs.getInt("id");
                    String name = rs.getString("name");
                    String description = rs.getString("description");
                    String note = rs.getString("note");
                    Date start_at = rs.getDate("start_at");
                    Date end_at = rs.getDate("end_at");
                    boolean status = rs.getBoolean("status");
                    int user_id = rs.getInt("user_id");
                    int diet_id = rs.getInt("diet_id");
                    boolean isDaily = rs.getBoolean("isDaily");

                    result = new PlanDTO(plan_id, name, description, note, start_at, end_at, status, user_id, diet_id, isDaily);
                }
            }
        } catch (SQLException ex) {
            System.out.println("Query error - getAllUserPlanByUserID: " + ex.getMessage());
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

    public static boolean checkPlanTitleDuplicateByUserID(String plan_title, int user_id) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        String name = "";

        String sql = "SELECT name FROM [Plan]\n"
                + "WHERE name like ? AND user_id = ?";

        try {
            con = DBUtils.getConnection();
            if (con != null) {
                stm = con.prepareStatement(sql);
                stm.setString(1, plan_title);
                stm.setInt(2, user_id);
                rs = stm.executeQuery();
                if (rs.next()) {
                    name = rs.getString("name");
                }

                if (name.isEmpty()) {
                    return true;
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
        return false;
    }

    public static PlanDTO getUserPlanById(int id) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        PlanDTO result = new PlanDTO();

        String sql = "SELECT * FROM [Plan]\n"
                + "WHERE id = ?";

        try {
            con = DBUtils.getConnection();
            if (con != null) {
                stm = con.prepareStatement(sql);
                stm.setInt(1, id);
                rs = stm.executeQuery();
                while (rs.next()) {

                    id = rs.getInt("id");
                    String name = rs.getString("name");
                    String description = rs.getString("description");
                    String note = rs.getString("note");
                    Date start_at = rs.getDate("start_at");
                    Date end_at = rs.getDate("end_at");
                    boolean status = rs.getBoolean("status");
                    int user_id = rs.getInt("user_id");
                    int diet_id = rs.getInt("diet_id");
                    boolean isDaily = rs.getBoolean("isDaily");

                    result = new PlanDTO(id, name, description, note, start_at, end_at, status, user_id, diet_id, isDaily);
                    return result;
                }
            }
        } catch (SQLException ex) {
            System.out.println("Query error - getAllUserPlanByUserID: " + ex.getMessage());
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

    public static int getPlanByUserIdAndName(int userId, String name) throws Exception {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        String sql = "SELECT * FROM [Plan]\n"
                + "WHERE [user_id] = ? and [name] like ?";

        try {
            con = DBUtils.getConnection();
            if (con != null) {
                stm = con.prepareStatement(sql);
                stm.setInt(1, userId);
                stm.setString(2, name);

                rs = stm.executeQuery();
                while (rs.next()) {
                    int id = rs.getInt("id");
                    return id;
                }
            }
        } catch (SQLException ex) {
            System.out.println("Query error - getPlanIdByUserIdAndDate: " + ex.getMessage());
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
        return 0;
    }

    public static int getWeekIDByPlanId(int plan_id) throws Exception {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

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
                    return id;
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
        return 0;
    }

    public static boolean updatePlanByID(int plan_id, int diet_id, String plan_title, String plan_description, String plan_note, Date start_at, Date end_at) throws Exception {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        String sql = "UPDATE [Plan]\n"
                + "SET name = ?, description = ?, note = ?, start_at = ?, end_at = ?, diet_id = ?\n"
                + "WHERE id = ?";

        try {
            con = DBUtils.getConnection();
            if (con != null) {
                stm = con.prepareStatement(sql);
                stm.setString(1, plan_title);
                stm.setString(2, plan_description);
                stm.setString(3, plan_note);
                stm.setDate(4, start_at);
                stm.setDate(5, end_at);
                stm.setInt(6, diet_id);
                stm.setInt(7, plan_id);

                int rowsAffected = stm.executeUpdate();
                return rowsAffected > 0;
            }
        } catch (SQLException ex) {
            System.out.println("Query error - updatePlanByID: " + ex.getMessage());
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

    public static boolean updateWeekByPlanID(int plan_id, Date start_at) throws Exception {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        String sql = "UPDATE [Week]\n"
                + "SET start_at = ?\n"
                + "WHERE plan_id = ?";

        try {
            con = DBUtils.getConnection();
            if (con != null) {
                stm = con.prepareStatement(sql);
                stm.setDate(1, start_at);
                stm.setInt(2, plan_id);

                int rowsAffected = stm.executeUpdate();
                return rowsAffected > 0;
            }
        } catch (SQLException ex) {
            System.out.println("Query error - updatePlanByID: " + ex.getMessage());
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

    public static boolean updateStatusByPlanID(int plan_id, boolean status) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        String sql = "UPDATE [Plan]\n"
                + "SET status = ?\n"
                + "WHERE id = ?";

        try {
            con = DBUtils.getConnection();
            if (con != null) {
                stm = con.prepareStatement(sql);
                stm.setBoolean(1, status);
                stm.setInt(2, plan_id);

                int rowsAffected = stm.executeUpdate();
                return rowsAffected > 0;
            }
        } catch (SQLException ex) {
            System.out.println("Query error - updatePlanByID: " + ex.getMessage());
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

    public static boolean deleteAllRecipeByPlanID(int plan_id) {
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

    public static void main(String[] args) {
//        ArrayList<UserDTO> list = AdminDAO.searchAccount("a");
//        for (UserDTO o : list) {
//            System.out.println(o);
//        }
        System.out.println(getTodayPlan(3, Date.valueOf(LocalDate.now())));
        System.out.println(getCurrentActivePlan(3));
    }
}
