/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Plan;

import Diet.DietDAO;
import Diet.DietDTO;
import PasswordEncode.EncodePass;
import Utils.DBUtils;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

/**
 *
 * @author Daiisuke
 */
public class PlanDAO {

    public static boolean insertPlan(String name, String description, String note, Date start_at, Date end_at, int user_id, int diet_id) throws Exception {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        String sql = "INSERT INTO [Plan](name, description, note, start_at, end_at, user_id, diet_id)\n"
                + "VALUES (?, ?, ?, ?, ?, ?, ?)";

        try {
            con = DBUtils.getConnection();
            if (con != null) {
                stm = con.prepareStatement(sql);
                stm.setString(1, name);
                stm.setString(2, description);
                stm.setString(3, note);
                stm.setDate(4, start_at);
                stm.setDate(5, end_at);
                stm.setInt(6, user_id);
                stm.setInt(7, diet_id);

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

    public static boolean insertAllDatesWithinAWeek(Date start_date, Date end_date, int week_id, int plan_id) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        int effectRows = 0;

        String sql = "INSERT INTO [Date](date, week_id, plan_id)\n"
                + "VALUES (?, ?, ?)";

        try {
            con = DBUtils.getConnection();
            if (con != null) {

                List<Date> dates = new ArrayList<>();

                // Iterate through calendar
                Calendar calendar = Calendar.getInstance();
                calendar.setTime(start_date);

                // Iterate from start_date until end_date, we add each date into a list.
                while (!calendar.getTime().after(end_date)) {
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

    public static ArrayList<PlanDTO> getAllUserPlanByUserID(int userId) throws Exception {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        ArrayList<PlanDTO> result = new ArrayList<>();

        String sql = "SELECT * FROM [Plan]\n"
                + "WHERE user_id = ?";

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
                    int user_id = rs.getInt("user_id");
                    int diet_id = rs.getInt("diet_id");

                    PlanDTO userPlan = new PlanDTO(id, name, description, note, start_at, end_at, user_id, diet_id);
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
                    int user_id = rs.getInt("user_id");
                    int diet_id = rs.getInt("diet_id");

                    result = new PlanDTO(id, name, description, note, start_at, end_at, user_id, diet_id);
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
}
