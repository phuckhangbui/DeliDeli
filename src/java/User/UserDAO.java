/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package User;

import Utils.DBUtils;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author Daiisuke
 */
public class UserDAO {

    public static UserDTO getAccount(String email, String password) throws Exception {
        UserDTO user = null;
        Connection cn = DBUtils.getConnection();
        if (cn != null) {
            String sql = "SELECT * FROM [User]\n"
                    + "WHERE email = ?\n"
                    + "AND password = ? Collate latin1_general_ci_as";

            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setString(1, email);
            pst.setString(2, password);
            ResultSet rs = pst.executeQuery();
            if (rs != null && rs.next()) {
                String userName = rs.getString("user_name");
                email = rs.getString("email");
                password = rs.getString("password");
                String avatar = rs.getString("avatar");
                String createAt = rs.getString("create_at");
                int status = rs.getInt("status");
                int role = rs.getInt("role_id");
                int setting = rs.getInt("user_setting_id");
                user = new UserDTO(userName, email, password, avatar, createAt, status, role, setting);
            }
            cn.close();
        }
        return user;
    }

    public static boolean checkUserStatus(String email, String password) throws Exception {
        Connection cn = DBUtils.getConnection();
        int status = 0;
        if (cn != null) {
            String sql = "SELECT status FROM [User] \n"
                    + "WHERE email = ? \n"
                    + "AND password = ?";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setString(1, email);
            pst.setString(2, password);
            ResultSet rs = pst.executeQuery();
            if (rs != null && rs.next()) {
                status = rs.getInt("status");
            }
            cn.close();
        }
        if (status == 1) {
            return true;
        }
        return false;
    }

    public static boolean checkEmailExist(String email) throws Exception {
        Connection cn = DBUtils.getConnection();
        UserDTO user = null;
        if (cn != null) {
            String sql = "SELECT * FROM [User] WHERE email = ?";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setString(1, email);
            ResultSet rs = pst.executeQuery();
            if (rs != null && rs.next()) {
                String userName = rs.getString("user_name");
                email = rs.getString("email");
                String password = rs.getString("password");
                String avatar = rs.getString("avatar");
                String createAt = rs.getString("create_at");
                int status = rs.getInt("status");
                int role = rs.getInt("role_id");
                int setting = rs.getInt("user_setting_id");
                user = new UserDTO(userName, email, password, avatar, createAt, status, role, setting);
            }
        }
        return user != null;
    }

    public static boolean checkUsernameExist(String userName) throws Exception {
        Connection cn = DBUtils.getConnection();
        UserDTO user = null;
        if (cn != null) {
            String sql = "SELECT * FROM [User] WHERE user_name = ?";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setString(1, userName);
            ResultSet rs = pst.executeQuery();
            if (rs != null && rs.next()) {
                userName = rs.getString("user_name");
                String email = rs.getString("email");
                String password = rs.getString("password");
                String avatar = rs.getString("avatar");
                String createAt = rs.getString("create_at");
                int status = rs.getInt("status");
                int role = rs.getInt("role_id");
                int setting = rs.getInt("user_setting_id");
                user = new UserDTO(userName, email, password, avatar, createAt, status, role, setting);
            }
        }
        return user != null;
    }

    public static boolean insertAccount(String username, String email, String password, Date createAt, int status, int role, int setting) throws Exception {
        boolean check = false;
        Connection cn = DBUtils.getConnection();
        if (cn != null) {
            String sql = "INSERT INTO [User](user_name, email, password, create_at, role_id, status, user_setting_id) \n"
                    + "VALUES \n"
                    + "(?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setString(1, username);
            pst.setString(2, email);
            pst.setString(3, password);
            pst.setDate(4, createAt);
            pst.setInt(5, status);
            pst.setInt(6, role);
            pst.setInt(7, setting);
            check = pst.executeUpdate() > 0 ? true : false;
        }
        return check;
    }
}
