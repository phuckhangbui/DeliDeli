/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Admin;

import User.UserDTO;
import Utils.DBUtils;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

/**
 *
 * @author Admin
 */
public class AdminDAO {

    public static ArrayList<UserDTO> pagingAccount(int index, String roleTag) {
        ArrayList<UserDTO> result = new ArrayList<>();
        Connection cn = null;
        String sql = "";
        PreparedStatement pst = null;

        try {
            cn = DBUtils.getConnection();

            if (cn != null) {
                if (roleTag.equals("")) {
                    sql = "SELECT * FROM [User]\n"
                            + "ORDER BY id \n"
                            + "OFFSET ? ROWS FETCH NEXT 2 ROWS ONLY";
                    pst = cn.prepareStatement(sql);
                    pst.setInt(1, (index - 1) * 2);
                }
                else {
                    sql = "SELECT * FROM [User]\n"
                            + "WHERE role_id = (SELECT id FROM Role WHERE title = ?)\n"
                            + "ORDER BY id \n"
                            + "OFFSET ? ROWS FETCH NEXT 2 ROWS ONLY";
                    pst = cn.prepareStatement(sql);
                    pst.setString(1, roleTag);
                    pst.setInt(2, (index - 1) * 2);
                }
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

    public static int deleteAccount(String userName) {
        int result = 0;
        Connection cn = null;

        try {
            cn = DBUtils.getConnection();

            if (cn != null) {
                String sql = "DELETE FROM Recipe WHERE user_id = (SELECT id FROM [User] WHERE user_name = ?);";
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, userName);
                result += pst.executeUpdate();

                sql = "DELETE FROM [User] WHERE user_name = ?";
                pst = cn.prepareStatement(sql);
                pst.setString(1, userName);
                result += pst.executeUpdate();

                pst.close();
                cn.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    public static int activateAccount(String userName) {
        int result = 0;
        Connection cn = null;

        try {
            cn = DBUtils.getConnection();

            if (cn != null) {
                String sql = "UPDATE [User] SET status = 1 WHERE user_name = ?";

                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, userName);
                result = pst.executeUpdate();
                pst.close();
                cn.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    public static int deactivateAccount(String userName) {
        int result = 0;
        Connection cn = null;

        try {
            cn = DBUtils.getConnection();

            if (cn != null) {
                String sql = "UPDATE [User] SET status = 0 WHERE user_name = ?";

                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, userName);
                result = pst.executeUpdate();
                pst.close();
                cn.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    public static void main(String[] args) {
        System.out.println(AdminDAO.pagingAccount(1, "administrator"));
    }

}
