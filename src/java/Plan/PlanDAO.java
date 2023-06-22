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
                    String name = rs.getString("name");
                    String description = rs.getString("description");
                    Date start_at = rs.getDate("start_at");
                    Date end_at = rs.getDate("end_at");
                    String note = rs.getString("note");
                    int user_id = rs.getInt("user_id");
                    int diet_id = rs.getInt("diet_id");

                    PlanDTO userPlan = new PlanDTO(userId, name, description, note, start_at, end_at, user_id, diet_id);
                    result.add(userPlan);
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

}
