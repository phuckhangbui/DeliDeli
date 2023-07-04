/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import DTO.NotificationDTO;
import Utils.DBUtils;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Time;
import java.sql.Timestamp;
import static java.sql.Types.INTEGER;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author khang
 */
public class NotificationDAO {

    public static int[] getNotificationCount(int userId) {
        int[] count = new int[3]; //[0]: total; [1]: read; [2]: unread
        int total = 0;
        int read = 0;
        int unread = 0;
        Connection cn = null;

        try {
            cn = DBUtils.getConnection();

            if (cn != null) {
                String sql = "SELECT COUNT(id) as total\n"
                        + "FROM [dbo].[Notification]\n"
                        + "WHERE [user_id] = ?";

                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setInt(1, userId);
                ResultSet rs = pst.executeQuery();
                if (rs != null) {
                    while (rs.next()) {
                        total = rs.getInt("total");
                    }
                }

                sql = "SELECT COUNT(id) as unread\n"
                        + "FROM [dbo].[Notification]\n"
                        + "WHERE [user_id] = ? AND is_read = 0";

                PreparedStatement pst1 = cn.prepareStatement(sql);
                pst1.setInt(1, userId);
                rs = pst1.executeQuery();
                if (rs != null) {
                    while (rs.next()) {
                        unread = rs.getInt("unread");
                    }
                }

                read = total - unread;
                count[0] = total;
                count[1] = read;
                count[2] = unread;

                rs.close();
                pst.close();
                cn.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return count;
    }

    public static ArrayList<NotificationDTO> getNotificationList(int userId) {
        ArrayList<NotificationDTO> list = new ArrayList<>();

        Connection cn = null;
        try {
            cn = DBUtils.getConnection();
            if (cn != null) {
                String sql = "SELECT * \n"
                        + "FROM [dbo].[Notification]\n"
                        + "WHERE [user_id] = ?\n"
                        + "ORDER BY [send_date] DESC";

                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setInt(1, userId);
                ResultSet rs = pst.executeQuery();
                if (rs != null) {
                    while (rs.next()) {
                        int id = rs.getInt("id");
                        String title = rs.getString("title");
                        String description = rs.getString("description");
                        Timestamp send_date = rs.getTimestamp("send_date");
                        boolean is_read = rs.getBoolean("is_read");
                        int notification_type_id = rs.getInt("notification_type_id");
                        int recipe_id = rs.getInt("recipe_id");
                        int plan_id = rs.getInt("plan_id");
                        String link = rs.getString("link");

                        NotificationDTO notification = new NotificationDTO(id, title, description,
                                send_date, is_read, userId, notification_type_id, recipe_id, plan_id, link);
                        list.add(notification);
                    }
                }
                rs.close();
                pst.close();
                cn.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public static NotificationDTO getNotificationById(int id) {
        NotificationDTO notification = null;
        Connection cn = null;

        try {
            cn = DBUtils.getConnection();

            if (cn != null) {
                String sql = "SELECT * \n"
                        + "FROM [dbo].[Notification]\n"
                        + "WHERE [id] = ?\n";
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setInt(1, id);
                ResultSet rs = pst.executeQuery();
                if (rs != null) {
                    while (rs.next()) {
                        String title = rs.getString("title");
                        String description = rs.getString("description");
                        Timestamp send_date = rs.getTimestamp("send_date");
                        boolean is_read = rs.getBoolean("is_read");
                        int notification_type_id = rs.getInt("notification_type_id");
                        int recipe_id = rs.getInt("recipe_id");
                        int plan_id = rs.getInt("plan_id");
                        String link = rs.getString("link");
                        int userId = rs.getInt("user_id");

                        notification = new NotificationDTO(id, title, description,
                                send_date, is_read, userId, notification_type_id, recipe_id, plan_id, link);
                    }

                }
                rs.close();
                pst.close();
                cn.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return notification;
    }

    public static void setReadNotification(int id) {
        Connection cn = null;

        try {
            cn = DBUtils.getConnection();

            if (cn != null) {
                String sql = "UPDATE [dbo].[Notification]\n"
                        + "SET [is_read] = 1\n"
                        + "WHERE id = ?";

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

    public static void deleteNotification(int id) {
        Connection cn = null;

        try {
            cn = DBUtils.getConnection();

            if (cn != null) {
                String sql = "DELETE FROM Notification\n"
                        + "WHERE id = ?";

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

    public static int addNotification(NotificationDTO notification) {
        int result = -1;
        Connection cn = null;

        try {
            cn = DBUtils.getConnection();

            if (cn != null) {
                String sql = "INSERT INTO Notification(title, description, send_date\n"
                        + ", is_read, user_id, notification_type_id, recipe_id, plan_id, link)\n"
                        + "VALUES\n"
                        + "(?, ?,?, ?, ?, ?, ?, ?, ?)";

                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, notification.getTitle());
                pst.setString(2, notification.getDescription());
                pst.setTimestamp(3, notification.getSend_date());
                pst.setBoolean(4, notification.is_read());
                pst.setInt(5, notification.getUser_id());
                pst.setInt(6, notification.getNotification_type());

                if (notification.getRecipe_id() == 0) {
                    pst.setNull(7, INTEGER);
                } else {
                    pst.setInt(7, notification.getRecipe_id());
                }

                if (notification.getPlan_id() == 0) {
                    pst.setNull(8, INTEGER);
                } else {
                    pst.setInt(8, notification.getRecipe_id());
                }

                pst.setString(9, notification.getLink());

                result = pst.executeUpdate();

                pst.close();
                cn.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    public static int addBroadcast(NotificationDTO notification) {
        int result = -1;
        Connection cn = null;

        try {
            cn = DBUtils.getConnection();

            if (cn != null) {
                List<Integer> userIds = new ArrayList<>();
                String sql = "SELECT id\n"
                        + "FROM [RecipeManagement].[dbo].[User]\n"
                        + "WHERE role_id = 1";
                PreparedStatement pst = cn.prepareStatement(sql);
                ResultSet resultSet = pst.executeQuery();
                while (resultSet.next()) {
                    int userId = resultSet.getInt("id");
                    userIds.add(userId);
                }
                
                pst.close();
                resultSet.close();
                
                

                sql = "INSERT INTO Notification(title, description, send_date\n"
                        + ", is_read, user_id, notification_type_id, recipe_id, plan_id, link)\n"
                        + "VALUES\n"
                        + "(?, ?,?, ?, ?, ?, ?, ?, ?)";
                pst = cn.prepareStatement(sql);
                for(int id: userIds){
                
                pst.setString(1, notification.getTitle());
                pst.setString(2, notification.getDescription());
                pst.setTimestamp(3, notification.getSend_date());
                pst.setBoolean(4, notification.is_read());
                pst.setInt(5, id);
                pst.setInt(6, notification.getNotification_type());

                if (notification.getRecipe_id() == 0) {
                    pst.setNull(7, INTEGER);
                } else {
                    pst.setInt(7, notification.getRecipe_id());
                }

                if (notification.getPlan_id() == 0) {
                    pst.setNull(8, INTEGER);
                } else {
                    pst.setInt(8, notification.getRecipe_id());
                }

                pst.setString(9, notification.getLink());

                result = pst.executeUpdate();
                }
                pst.close();
                cn.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    public static void main(String[] args) {
        NotificationDTO n = getNotificationById(4);
        System.out.println(n);
        int result = addNotification(n);
        System.out.println(result);
    }
}
