/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package User;

import PasswordEncode.EncodePass;
import Utils.DBUtils;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;

/**
 *
 * @author Daiisuke
 */
public class UserDAO {

    //New
    public static int getTotalAccountsBasedOnRole(String roleTag) {
        int result = 0;
        String sql = "";
        Connection cn = null;
        PreparedStatement pst = null;

        try {
            cn = DBUtils.getConnection();

            if (cn != null) {
                if (roleTag.equals("")) {
                    sql = "SELECT COUNT(id) as total FROM [User]";
                    pst = cn.prepareStatement(sql);
                } else {
                    sql = "SELECT COUNT(id) as total FROM [User] WHERE role_id = (SELECT id FROM Role WHERE title = ?)";
                    pst = cn.prepareStatement(sql);
                    pst.setString(1, roleTag);
                }
                ResultSet rs = pst.executeQuery();
                if (rs != null) {
                    while (rs.next()) {
                        result = rs.getInt("total");
                    }
                }
                rs.close();
                pst.close();
                cn.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    //New
    public static ArrayList<UserDTO> getAllUser() {
        ArrayList<UserDTO> result = new ArrayList<>();
        Connection cn = null;

        try {
            cn = DBUtils.getConnection();

            if (cn != null) {
                String sql = "SELECT * FROM [User]";

                PreparedStatement pst = cn.prepareStatement(sql);
                ResultSet rs = pst.executeQuery();
                if (rs != null) {
                    while (rs.next()) {
                        int id = rs.getInt("id");
                        String userName = rs.getString("user_name");
                        String email = rs.getString("email");
                        String password = rs.getString("password");
                        String avatar = rs.getString("avatar");
                        String createAt = rs.getString("create_at");
                        int status = rs.getInt("status");
                        int role = rs.getInt("role_id");
                        int setting = rs.getInt("user_setting_id");
                        UserDTO user = new UserDTO(id, userName, email, password, avatar, createAt, status, role, setting);
                        result.add(user);
                    }
                }
                rs.close();
                pst.close();
                cn.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }

    public static UserDTO getUserByUserId(int userId) {
        UserDTO user = null;
        Connection cn = null;

        try {
            cn = DBUtils.getConnection();

            if (cn != null) {
                String sql = "SELECT * FROM [User] WHERE id = ?";

                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setInt(1, userId);
                ResultSet rs = pst.executeQuery();
                if (rs != null) {
                    while (rs.next()) {
                        String userName = rs.getString("user_name");
                        String email = rs.getString("email");
                        String password = rs.getString("password");
                        String avatar = rs.getString("avatar");
                        String createAt = rs.getString("create_at");
                        String token = rs.getString("token");
                        int status = rs.getInt("status");
                        int role = rs.getInt("role_id");
                        int setting = rs.getInt("user_setting_id");
                        user = new UserDTO(userName, email, password, avatar, createAt, token, status, role, setting);
                    }
                }
                rs.close();
                pst.close();
                cn.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }

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
                int id = rs.getInt("id");
                String userName = rs.getString("user_name");
                email = rs.getString("email");
                password = rs.getString("password");
                String avatar = rs.getString("avatar");
                String createAt = rs.getString("create_at");
                String token = rs.getString("token");
                int status = rs.getInt("status");
                int role = rs.getInt("role_id");
                int setting = rs.getInt("user_setting_id");
                user = new UserDTO(id, userName, email, password, avatar, createAt, token, status, role, setting);
            }
            cn.close();
        }
        return user;
    }

    public static boolean checkOldPassword(int userId, String oldPassword) throws Exception {
        Connection cn = DBUtils.getConnection();
        String password = "";

        if (cn != null) {
            String sql = "SELECT password FROM [User] WHERE id = ?";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setInt(1, userId);
            ResultSet rs = pst.executeQuery();
            if (rs != null && rs.next()) {
                password = rs.getString("password");
            }
            cn.close();
            if (oldPassword.equalsIgnoreCase(password)) {
                return true;
            }
        }
        return false;
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
        boolean check = false;
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
        if (user != null){
            check = true;
        }
        return check;
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

    public static UserDTO getAccountByName(String userName) throws Exception {
        UserDTO user = null;
        Connection cn;
        try {
            cn = DBUtils.getConnection();

            if (cn != null) {
                String sql = "SELECT * FROM [User] WHERE user_name = ?";
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, userName);
                ResultSet rs = pst.executeQuery();
                if (rs != null && rs.next()) {
                    int id = rs.getInt("id");
                    userName = rs.getString("user_name");
                    String email = rs.getString("email");
                    String password = rs.getString("password");
                    String avatar = rs.getString("avatar");
                    String createAt = rs.getString("create_at");
                    int status = rs.getInt("status");
                    int role = rs.getInt("role_id");
                    int setting = rs.getInt("user_setting_id");
                    user = new UserDTO(id, userName, email, password, avatar, createAt, status, role, setting);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }

    public static boolean insertAccount(String username, String email, String password, Date createAt, int status, int role, int setting, String token) throws Exception {
        boolean check = false;
        Connection cn = DBUtils.getConnection();
        EncodePass encode = new EncodePass();
        password = encode.toHexString(encode.getSHA(password));
        System.out.println("[DAO - InsertAccount]: Hash generated: " + password);
        if (cn != null) {
            String sql = "INSERT INTO [User](user_name, email, password, create_at, role_id, status, user_setting_id, token) \n"
                    + "VALUES \n"
                    + "(?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setString(1, username);
            pst.setString(2, email);
            pst.setString(3, password);
            pst.setDate(4, createAt);
            pst.setInt(5, status);
            pst.setInt(6, role);
            pst.setInt(7, setting);
            pst.setString(8, token);
            check = pst.executeUpdate() > 0 ? true : false;
        }
        return check;
    }

    public static int insertUserDetailDefault() {
        int result = 0;
        int userId = 0;
        java.util.Date date = new java.util.Date();
        java.sql.Date birthDate = new java.sql.Date(date.getTime());
        Connection cn = null;

        try {
            cn = DBUtils.getConnection();

            if (cn != null) {
                String sql = "SELECT TOP 1 id FROM [User] ORDER BY id DESC";
                PreparedStatement pst = cn.prepareStatement(sql);
                ResultSet rs = pst.executeQuery();
                if (rs != null) {
                    while (rs.next()) {
                        userId= rs.getInt("id");
                    }
                }
                
                sql = "INSERT INTO UserDetail(user_id, first_name, last_name, specialty, birthdate, bio) \n"
                        + "VALUES (?, ?, ?, ?, ?, ?)";

                pst = cn.prepareStatement(sql);
                pst.setInt(1, userId);
                pst.setString(2, "");
                pst.setString(3, "");
                pst.setString(4, "");
                pst.setDate(5, birthDate);
                pst.setString(6, "");
                result = pst.executeUpdate();

                pst.close();
                cn.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    //Dumb patching idk.
    public Boolean updateStatusFalse(String username) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        String sql = "UPDATE [User] "
                + "SET status = 0 "
                + "WHERE user_name like ?";

        try {
            con = DBUtils.getConnection();
            if (con != null) {
                stm = con.prepareStatement(sql);
                stm.setString(1, username);
                rs = stm.executeQuery();

                System.out.println("[DAO - updateStatusFalse]: Reached to this part.");
                if (rs.next()) {
//                    String tokenString = rs.getString("token");
                    int isUserIdExist = rs.getInt("id");
                    System.out.println("[DAO - updateStatusFalse]: User ID searched: " + isUserIdExist);
                    if (isUserIdExist > 0) {
                        return true;
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
        return false;
    }

    public boolean updatePass(String tokenReceived, String password) throws Exception {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        EncodePass encode = new EncodePass();
        password = encode.toHexString(encode.getSHA(password));
        System.out.println("[DAO - UpdatePass]: Hash generated: " + password);

        String sql = "UPDATE [User] "
                + "SET password = ? "
                + "WHERE token = ?";

        try {
            con = DBUtils.getConnection();
            if (con != null) {
                stm = con.prepareStatement(sql);

                stm.setString(1, password);
                stm.setString(2, tokenReceived);

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

    public Boolean updateStatus(String token) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        String sql = "UPDATE [User] "
                + "SET status = 1 "
                + "WHERE token = ?";

        try {
            con = DBUtils.getConnection();
            if (con != null) {
                stm = con.prepareStatement(sql);
                stm.setString(1, token);
                rs = stm.executeQuery();

                System.out.println("[DAO - updateStatus]: Reached to this part.");
                if (rs.next()) {
//                    String tokenString = rs.getString("token");
                    int isUserIdExist = rs.getInt("id");
                    System.out.println("[DAO - updateStatus]: User ID searched: " + isUserIdExist);
                    if (isUserIdExist > 0) {
                        return true;
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
        return false;
    }

    //==================== TOKEN ==============================
//    public boolean createToken(String email, String tokenReceived) {
//        Connection con = null;
//        PreparedStatement stm = null;
//        ResultSet rs = null;
//
//        String sql = "INSERT INTO UserTbl(id,token) "
//                + "VALUES (?,?)";
//
//        try {
//            con = DBUtils.getConnection();
//            if (con != null) {
//                stm = con.prepareStatement(sql);
//
//                stm.setInt(1, id);
//                stm.setString(2, tokenReceived);
//
//                int effectRows = stm.executeUpdate();
//                if (effectRows > 0) {
//                    return true;
//                }
//            }
//        } catch (SQLException ex) {
//            System.out.println("Query error: " + ex.getMessage());
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
    public boolean updateTokenByEmail(String email, String tokenReceived) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        String sql = "UPDATE [User] "
                + "SET token = ? "
                + "WHERE email = ?";

        try {
            con = DBUtils.getConnection();
            if (con != null) {
                stm = con.prepareStatement(sql);

                stm.setString(1, tokenReceived);
                stm.setString(2, email);

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

    public Boolean verifyToken(String token) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        String sql = "SELECT id "
                + "FROM [User] "
                + "WHERE token = ?";

        try {
            con = DBUtils.getConnection();
            if (con != null) {
                stm = con.prepareStatement(sql);
                stm.setString(1, token);
                rs = stm.executeQuery();

                System.out.println("[DAO - verifyToken]: Reached to this part.");
                if (rs.next()) {
//                    String tokenString = rs.getString("token");
                    int isUserIdExist = rs.getInt("id");
                    System.out.println("[DAO - verifyToken]: User ID searched: " + isUserIdExist);
                    if (isUserIdExist > 0) {
                        return true;
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
        return false;
    }

    public static void main(String[] args) throws Exception {
        System.out.println(UserDAO.checkEmailExist("khoalndse172103@fpt.edu.vn"));
    }

}
