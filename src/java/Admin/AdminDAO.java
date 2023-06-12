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
import java.util.TreeMap;

/**
 *
 * @author Admin
 */
public class AdminDAO {

    public static TreeMap<Integer, Integer> getRatingAllRecipesOfOwnerMap(int userId) {
        TreeMap<Integer, Integer> map = new TreeMap<Integer, Integer>();
        Connection cn = null;
        try {
            cn = DBUtils.getConnection();

            if (cn != null) {
                String sql = "SELECT rating, COUNT(*) AS total FROM Recipe rec\n"
                        + "JOIN Review rev\n"
                        + "ON rec.id = rev.recipe_id\n"
                        + "WHERE rec.user_id = ?\n"
                        + "GROUP BY rating";

                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setInt(1, userId);
                ResultSet rs = pst.executeQuery();
                if (rs != null) {
                    while (rs.next()) {
                        int rating = rs.getInt("rating");
                        int total = rs.getInt("total");

                        map.put(rating, total);
                    }
                }
                rs.close();
                pst.close();
                cn.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return map;
    }

    public static TreeMap<Date, Integer> getAccountMap() {
        TreeMap<Date, Integer> map = new TreeMap<Date, Integer>();
        Connection cn = null;
        try {
            cn = DBUtils.getConnection();

            if (cn != null) {
                String sql = "SELECT create_at, COUNT(id) AS total FROM [User]\n"
                        + "GROUP BY create_at";

                PreparedStatement pst = cn.prepareStatement(sql);
                ResultSet rs = pst.executeQuery();
                if (rs != null) {
                    while (rs.next()) {
                        Date create_at = rs.getDate("create_at");
                        int total = rs.getInt("total");

                        map.put(create_at, total);
                    }
                }
                rs.close();
                pst.close();
                cn.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return map;
    }

    public static TreeMap<Date, Integer> getRecipeMap() {
        TreeMap<Date, Integer> map = new TreeMap<Date, Integer>();
        Connection cn = null;
        try {
            cn = DBUtils.getConnection();

            if (cn != null) {
                String sql = "SELECT create_at, COUNT(id) AS total FROM Recipe \n"
                        + "GROUP BY create_at";

                PreparedStatement pst = cn.prepareStatement(sql);
                ResultSet rs = pst.executeQuery();
                if (rs != null) {
                    while (rs.next()) {
                        Date create_at = rs.getDate("create_at");
                        int total = rs.getInt("total");

                        map.put(create_at, total);
                    }
                }
                rs.close();
                pst.close();
                cn.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return map;
    }

    public static ArrayList<UserDTO> getTop5LatestUser() {
        ArrayList<UserDTO> result = new ArrayList<>();
        Connection cn = null;

        try {
            cn = DBUtils.getConnection();

            if (cn != null) {
                String sql = "SELECT TOP 5 * FROM [User] ORDER BY create_at DESC";

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

    public static ArrayList<RecipeDTO> getTop5LatestRecipes() {
        ArrayList<RecipeDTO> result = new ArrayList<>();
        Connection cn = null;

        try {
            cn = DBUtils.getConnection();

            if (cn != null) {
                String sql = "SELECT TOP 5 * FROM Recipe ORDER BY create_at DESC";

                PreparedStatement pst = cn.prepareStatement(sql);
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
                        int diet_id = rs.getInt("diet_id");
                        int status = rs.getInt("status");

                        RecipeDTO recipe = new RecipeDTO(id, title, description, prep_time,
                                cook_time, servings, create_at, update_at, cuisin_id,
                                category_id, user_id, level_id, diet_id, status);
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

    public static int getTotalRecipe() {
        int result = 0;
        Connection cn = null;

        try {
            cn = DBUtils.getConnection();

            if (cn != null) {
                String sql = "SELECT COUNT(id) as total FROM Recipe";

                PreparedStatement pst = cn.prepareStatement(sql);
                ResultSet rs = pst.executeQuery();
                if (rs != null) {
                    while (rs.next()) {
                        result = rs.getInt("total");
                    }
                }

                pst.close();
                cn.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }
    
    public static int getTop1NewsId() {
        int result = 0;
        Connection cn = null;

        try {
            cn = DBUtils.getConnection();

            if (cn != null) {
                String sql = "SELECT TOP 1 id FROM [News] ORDER BY id DESC";

                PreparedStatement pst = cn.prepareStatement(sql);
                ResultSet rs = pst.executeQuery();
                if (rs != null) {
                    while (rs.next()) {
                        result = rs.getInt("id");
                    }
                }

                pst.close();
                cn.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    public static int getTotalAccount() {
        int result = 0;
        Connection cn = null;

        try {
            cn = DBUtils.getConnection();

            if (cn != null) {
                String sql = "SELECT COUNT(id) as total FROM [User]";

                PreparedStatement pst = cn.prepareStatement(sql);
                ResultSet rs = pst.executeQuery();
                if (rs != null) {
                    while (rs.next()) {
                        result = rs.getInt("total");
                    }
                }

                pst.close();
                cn.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

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
                        int diet_id = rs.getInt("diet_id");
                        int status = rs.getInt("status");

                        RecipeDTO recipe = new RecipeDTO(id, title, description, prep_time,
                                cook_time, servings, create_at, update_at, cuisin_id,
                                category_id, user_id, level_id, diet_id, status);
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
                String sql = "SELECT * FROM Recipe WHERE [status] = ? ORDER BY create_at DESC";

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
                        int diet_id = rs.getInt("diet_id");
                        status = rs.getInt("status");

                        RecipeDTO recipe = new RecipeDTO(id, title, description, prep_time,
                                cook_time, servings, create_at, update_at, cuisin_id,
                                category_id, user_id, level_id, diet_id, status);
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
                            + "OFFSET ? ROWS FETCH NEXT 5 ROWS ONLY";
                    pst = cn.prepareStatement(sql);
                    pst.setInt(1, (index - 1) * 5);
                } else {
                    sql = "SELECT * FROM [User]\n"
                            + "WHERE role_id = (SELECT id FROM Role WHERE title = ?)\n"
                            + "ORDER BY id \n"
                            + "OFFSET ? ROWS FETCH NEXT 5 ROWS ONLY";
                    pst = cn.prepareStatement(sql);
                    pst.setString(1, roleTag);
                    pst.setInt(2, (index - 1) * 5);
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
        System.out.println(AdminDAO.getTop1NewsId());
    }

}
