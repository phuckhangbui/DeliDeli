/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Notification;

import Utils.DBUtils;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Time;
import java.sql.Timestamp;
import java.util.ArrayList;

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

    public static void main(String[] args) {
        int[] count = getNotificationCount(3);
        System.out.println(count[0]);
        System.out.println(count[1]);
        System.out.println(count[2]);

        ArrayList<NotificationDTO> list = getNotificationList(3);
        System.out.println(list.size());
        for (NotificationDTO notification : list) {
            System.out.println(notification.toString());
        }

        System.out.println(getNotificationById(1));

    }
}
