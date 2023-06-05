/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Admin;

import Recipe.RecipeDTO;
import User.UserDTO;
import Utils.DBUtils;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

/**
 *
 * @author Admin
 */
public class AdminDAO {

    public static ArrayList<RecipeDTO> searchRecipeByTitle(String keyword) {
        ArrayList<RecipeDTO> result = new ArrayList<>();
        Connection cn = null;

        try {
            cn = DBUtils.getConnection();

            if (cn != null) {
                String sql = "SELECT * FROM Recipe WHERE title LIKE ?";

                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, "%" + keyword + "%");
                ResultSet rs = pst.executeQuery();
                if (rs != null) {
                    while (rs.next()) {
                        int id = rs.getInt("id");
                        String title = rs.getString("title");
                        String description = rs.getString("description");
                        int prep_time = rs.getInt("prep_time");
                        int cook_time = rs.getInt("cook_time");
                        int servings = rs.getInt("servings");
                        Date create_at = rs.getDate("create_at");
                        Date update_at = rs.getDate("update_at");
                        int cuisin_id = rs.getInt("cuisine_id");
                        int category_id = rs.getInt("category_id");
                        int user_id = rs.getInt("user_id");
                        int level_id = rs.getInt("level_id");

                        RecipeDTO recipe = new RecipeDTO(id, title, description, prep_time,
                                cook_time, servings, create_at, update_at, cuisin_id,
                                category_id, user_id, level_id);
                        result.add(recipe);
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

    public static int confirmRecipe(int id) {
        int result = 0;
        Connection cn = null;

        try {
            cn = DBUtils.getConnection();

            if (cn != null) {
                String sql = "UPDATE Recipe SET [status] = 3 WHERE id = ?";

                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setInt(1, id);
                result = pst.executeUpdate();
                pst.close();
                cn.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    public static ArrayList<RecipeDTO> getRecipesByStatus(int status) {
        ArrayList<RecipeDTO> result = new ArrayList<>();
        Connection cn = null;

        try {
            cn = DBUtils.getConnection();

            if (cn != null) {
                String sql = "SELECT * FROM Recipe WHERE [status] = ?";

                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setInt(1, status);
                ResultSet rs = pst.executeQuery();
                if (rs != null) {
                    while (rs.next()) {
                        int id = rs.getInt("id");
                        String title = rs.getString("title");
                        String description = rs.getString("description");
                        int prep_time = rs.getInt("prep_time");
                        int cook_time = rs.getInt("cook_time");
                        int servings = rs.getInt("servings");
                        Date create_at = rs.getDate("create_at");
                        Date update_at = rs.getDate("update_at");
                        int cuisin_id = rs.getInt("cuisine_id");
                        int category_id = rs.getInt("category_id");
                        int user_id = rs.getInt("user_id");
                        int level_id = rs.getInt("level_id");

                        RecipeDTO recipe = new RecipeDTO(id, title, description, prep_time,
                                cook_time, servings, create_at, update_at, cuisin_id,
                                category_id, user_id, level_id);
                        result.add(recipe);
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

    public static UserDTO getAccountByUserName(String userName) {
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

    public static ArrayList<UserDTO> searchAccount(String keyword) {
        ArrayList<UserDTO> result = new ArrayList<>();
        Connection cn = null;

        try {
            cn = DBUtils.getConnection();

            if (cn != null) {
                String sql = "SELECT * FROM [User] WHERE user_name LIKE ?";
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, "%" + keyword + "%");
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
                } else {
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
//        ArrayList<UserDTO> list = AdminDAO.searchAccount("a");
//        for (UserDTO o : list) {
//            System.out.println(o);
//        }
        System.out.println(AdminDAO.getAccountByUserName("khoaly"));
    }

}
