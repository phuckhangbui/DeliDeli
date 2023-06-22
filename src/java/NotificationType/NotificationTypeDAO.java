/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package NotificationType;

import Utils.DBUtils;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 *
 * @author khang
 */
public class NotificationTypeDAO {

    public static NotificationTypeDTO getNotificationType(int typeId) {
        NotificationTypeDTO type = null;

        Connection cn = null;

        try {
            cn = DBUtils.getConnection();

            if (cn != null) {
                String sql = "SELECT * \n"
                        + "FROM [dbo].[NotificationType]\n"
                        + "WHERE id = ?";

                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setInt(1, typeId);
                ResultSet rs = pst.executeQuery();
                if (rs != null) {
                    while (rs.next()) {
                        String sender = rs.getString("sender");
                        String image = rs.getString("image");
                        String cate = rs.getString("cate");
                        type = new NotificationTypeDTO(typeId, sender, image, cate);
                    }
                }
                rs.close();
                pst.close();
                cn.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return type;
    }
}
