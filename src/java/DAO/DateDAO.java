/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import DTO.DateDTO;
import Utils.DBUtils;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Time;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

/**
 *
 * @author Daiisuke
 */
public class DateDAO {

    public static ArrayList<DateDTO> getAllDateByPlanIDAndWeekID(int plan_id, int weekId) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        ArrayList<DateDTO> result = new ArrayList<>();

        String sql = "SELECT * FROM [Date]\n"
                + "WHERE [plan_id] = ? AND [week_id] = ?";

        try {
            con = DBUtils.getConnection();
            if (con != null) {
                stm = con.prepareStatement(sql);
                stm.setInt(1, plan_id);
                stm.setInt(2, weekId);

                rs = stm.executeQuery();
                while (rs.next()) {
                    int id = rs.getInt("id");
                    Date date = rs.getDate("date");
                    int week_id = rs.getInt("week_id");
                    plan_id = rs.getInt("plan_id");
                    boolean isSync = rs.getBoolean("is_sync");
                    boolean isTemplate = rs.getBoolean("is_template");

                    DateDTO planDate = new DateDTO(id, date, week_id, plan_id, isSync, isTemplate);
                    result.add(planDate);
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
        return result;
    }

    public static ArrayList<DateDTO> getAllDateByPlanID(int plan_id) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        ArrayList<DateDTO> result = new ArrayList<>();

        String sql = "SELECT * FROM [Date]\n"
                + "WHERE [plan_id] = ? AND is_template = 0";

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
                    boolean isSync = rs.getBoolean("is_sync");
                    boolean isTemplate = rs.getBoolean("is_template");

                    DateDTO planDate = new DateDTO(id, date, week_id, plan_id, isSync, isTemplate);
                    result.add(planDate);
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
        return result;
    }

    public static ArrayList<DateDTO> getDailyTemplate(int plan_id) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        ArrayList<DateDTO> result = new ArrayList<>();

        String sql = "SELECT * FROM [Date]\n"
                + "WHERE [plan_id] = ? AND is_template = 1";

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
                    boolean isSync = rs.getBoolean("is_sync");
                    boolean isTemplate = rs.getBoolean("is_template");

                    DateDTO planDate = new DateDTO(id, date, week_id, plan_id, isSync, isTemplate);
                    result.add(planDate);
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
        return result;
    }

    public static ArrayList<DateDTO> getWeeklyTemplate(int plan_id) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        ArrayList<DateDTO> result = new ArrayList<>();

        String sql = "SELECT * FROM [Date]\n"
                + "WHERE [plan_id] = ? AND is_template = 1";

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
                    boolean isSync = rs.getBoolean("is_sync");
                    boolean isTemplate = rs.getBoolean("is_template");

                    DateDTO planDate = new DateDTO(id, date, week_id, plan_id, isSync, isTemplate);
                    result.add(planDate);
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
        return result;
    }

    public static DateDTO getDateByPlanID(int plan_id) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        DateDTO result = new DateDTO();

        String sql = "SELECT * FROM [Date]\n"
                + "WHERE [plan_id] = ?";

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
                    boolean isSync = rs.getBoolean("is_sync");
                    boolean isTemplate = rs.getBoolean("is_template");

                    result = new DateDTO(id, date, week_id, plan_id, isSync, isTemplate);
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
        return result;
    }

    public static boolean insertAllDatesWithinAWeek(Date start_date, int week_id, int plan_id) {
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

    public static int insertMultiplesDate(Date date, int week_id, int plan_id) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        int result = 0;

        String sqlRemoveDuplicates = "DELETE FROM [Date] WHERE date = ? AND plan_id = ?";
        String sqlInsert = "INSERT INTO [Date] (date, week_id, plan_id) VALUES (?, ?, ?)";

        try {
            con = DBUtils.getConnection();
            if (con != null) {
                // Remove duplicates
                PreparedStatement duplicateRemovalStm = con.prepareStatement(sqlRemoveDuplicates);
                duplicateRemovalStm.setDate(1, date);
                duplicateRemovalStm.setInt(2, plan_id);
                duplicateRemovalStm.executeUpdate();
                duplicateRemovalStm.close();

                // Insert the date
                stm = con.prepareStatement(sqlInsert, Statement.RETURN_GENERATED_KEYS);
                stm.setDate(1, date);
                stm.setInt(2, week_id);
                stm.setInt(3, plan_id);
                stm.executeUpdate();

                // Retrieve the generated keys
                rs = stm.getGeneratedKeys();
                if (rs.next()) {
                    result = rs.getInt(1); // Retrieve the generated ID
                }
            }
        } catch (SQLException ex) {
            System.out.println("Query error - insertMultiplesDate: " + ex.getMessage());
        } finally {
            // Close database resources
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

    public static boolean insertDateForDaily(Date date, int plan_id) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        int effectRows = 0;

        String sql = "INSERT INTO [Date](date,plan_id)\n"
                + "VALUES (?, ?)";

        try {
            con = DBUtils.getConnection();
            if (con != null) {

                stm = con.prepareStatement(sql);
                stm.setDate(1, date);
                stm.setInt(2, plan_id);
                effectRows = stm.executeUpdate();

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

    public static int insertWeekForWeekly(Date date, int plan_id) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        int insertedId = -1; // Default value in case insertion fails

        String sql = "INSERT INTO [dbo].[Week] ([start_at], [plan_id])\n" + "VALUES (?, ?)";

        try {
            con = DBUtils.getConnection();
            if (con != null) {

                stm = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
                stm.setDate(1, date);
                stm.setInt(2, plan_id);
                int effectRows = stm.executeUpdate();

                if (effectRows > 0) {
                    // Get the generated ID of the newly inserted row
                    rs = stm.getGeneratedKeys();
                    if (rs.next()) {
                        insertedId = rs.getInt(1);
                    }
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
        return insertedId;
    }

    public static boolean updateDate(int date_id, Date new_date) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        int effectRows = 0;

        String sql = "UPDATE [Date]\n"
                + "SET date = ?\n"
                + "WHERE id = ? ";

        try {
            con = DBUtils.getConnection();
            if (con != null) {

                stm = con.prepareStatement(sql);
                stm.setDate(1, new_date);
                stm.setInt(2, date_id);
                effectRows = stm.executeUpdate();

                if (effectRows > 0) {
                    return true;
                }
            }
        } catch (SQLException ex) {
            System.out.println("Query error - updateDate: " + ex.getMessage());
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

    public static boolean updateSyncStatus(int date_id, boolean status) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        int effectRows = 0;

        String sql = "UPDATE [Date]\n"
                + "SET is_sync = ?\n"
                + "WHERE id = ? ";

        try {
            con = DBUtils.getConnection();
            if (con != null) {

                stm = con.prepareStatement(sql);
                stm.setBoolean(1, status);
                stm.setInt(2, date_id);
                effectRows = stm.executeUpdate();

                if (effectRows > 0) {
                    return true;
                }
            }
        } catch (SQLException ex) {
            System.out.println("Query error - updateSyncStatus: " + ex.getMessage());
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

    public static boolean deleteDateByDateId(int id) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        String sql = "DELETE d\n"
                + "FROM [Date] d\n"
                + "WHERE d.id = ?";

        try {
            con = DBUtils.getConnection();
            if (con != null) {
                stm = con.prepareStatement(sql);
                stm.setInt(1, id);

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

    public static DateDTO getDateIdByPlanIdAndDate(int planId, Date date) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        DateDTO result = new DateDTO();

        String sql = "SELECT * FROM [Date]\n"
                + "WHERE [plan_id] = ? AND date = ?";

        try {
            con = DBUtils.getConnection();
            if (con != null) {
                stm = con.prepareStatement(sql);
                stm.setInt(1, planId);
                stm.setDate(2, date);

                rs = stm.executeQuery();
                while (rs.next()) {
                    int id = rs.getInt("id");
                    date = rs.getDate("date");
                    int week_id = rs.getInt("week_id");
                    planId = rs.getInt("plan_id");
                    boolean isSync = rs.getBoolean("is_sync");
                    boolean isTemplate = rs.getBoolean("is_template");

                    result = new DateDTO(id, date, week_id, planId, isSync, isTemplate);
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
        return result;
    }

    public static DateDTO getDateIdByPlanIdAndDateInWeeklyPlan(int planId, Date date) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        DateDTO result = new DateDTO();

        String sql = "SELECT * FROM [Date] d JOIN Week w ON d.week_id = w.id\n"
                + "WHERE d.[plan_id] = ? AND w.is_template = 0 AND date = ? AND w.is_sync = 1";

        try {
            con = DBUtils.getConnection();
            if (con != null) {
                stm = con.prepareStatement(sql);
                stm.setInt(1, planId);
                stm.setDate(2, date);

                rs = stm.executeQuery();
                while (rs.next()) {
                    int id = rs.getInt("id");
                    date = rs.getDate("date");
                    int week_id = rs.getInt("week_id");
                    planId = rs.getInt("plan_id");
                    boolean isSync = rs.getBoolean("is_sync");
                    boolean isTemplate = rs.getBoolean("is_template");

                    result = new DateDTO(id, date, week_id, planId, isSync, isTemplate);
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
        return result;
    }

    public static void main(String[] args) {
        System.out.println(DateDAO.getAllDateByPlanIDAndWeekID(5, 3));
    }

}
