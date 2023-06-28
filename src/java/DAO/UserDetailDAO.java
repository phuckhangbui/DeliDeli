/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import DTO.UserDetailDTO;
import Utils.EncodePass;
import Utils.DBUtils;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 *
 * @author Admin
 */
public class UserDetailDAO {

    public static int updateUserEmail(int userId, String email) {
        int result = 0;
        Connection cn = null;

        try {
            cn = DBUtils.getConnection();

            if (cn != null) {
            String sqlUser = "UPDATE [User] SET email = ? WHERE id = ?";
            PreparedStatement pstUser = cn.prepareStatement(sqlUser);
            pstUser.setString(1, email);
            pstUser.setInt(2, userId);
            result += pstUser.executeUpdate();
            pstUser.close();

//                String sqlUserDetail = "UPDATE [User] SET password = ? WHERE id = ?";
//                PreparedStatement pstUserDetail = cn.prepareStatement(sqlUserDetail);
//                pstUserDetail.setString(1, password);
//                pstUserDetail.setInt(2, userId);
//                result += pstUserDetail.executeUpdate();
//                pstUserDetail.close();

                cn.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }
    
    public static int updateUserPassword(int userId, String password) throws Exception{
        int result = 0;
        Connection cn = null;

        EncodePass encode = new EncodePass();
        password = encode.toHexString(encode.getSHA(password));
        try {
            cn = DBUtils.getConnection();

            if (cn != null) {
//            String sqlUser = "UPDATE [User] SET email = ? WHERE id = ?";
//            PreparedStatement pstUser = cn.prepareStatement(sqlUser);
//            pstUser.setString(1, email);
//            pstUser.setInt(2, userId);
//            result += pstUser.executeUpdate();
//            pstUser.close();

                String sqlUserDetail = "UPDATE [User] SET password = ? WHERE id = ?";
                PreparedStatement pstUserDetail = cn.prepareStatement(sqlUserDetail);
                pstUserDetail.setString(1, password);
                pstUserDetail.setInt(2, userId);
                result += pstUserDetail.executeUpdate();
                pstUserDetail.close();

                cn.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }

    public static int updateUserPublicDetail(int userId, String firstName, String lastName, String specialty, String bio, String birthdate) {
        int result = 0;
        Connection cn = null;

        try {
            cn = DBUtils.getConnection();

            if (cn != null) {
                String sql = "UPDATE UserDetail SET first_name = ?, last_name = ?, specialty = ?, bio = ?, birthdate = ?\n"
                        + "WHERE user_id = ?";

                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, firstName);
                pst.setString(2, lastName);
                pst.setString(3, specialty);
                pst.setString(4, bio);
                pst.setString(5, birthdate);
                pst.setInt(6, userId);
                result = pst.executeUpdate();
                pst.close();
                cn.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }

    public static UserDetailDTO getUserDetailByUserId(int userId) {
        UserDetailDTO userDetail = null;
        Connection cn = null;

        try {
            cn = DBUtils.getConnection();

            if (cn != null) {
                String sql = "SELECT * FROM UserDetail WHERE user_id = ?";

                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setInt(1, userId);
                ResultSet rs = pst.executeQuery();
                if (rs != null) {
                    while (rs.next()) {
                        userId = rs.getInt("user_id");
                        String firstName = rs.getString("first_name");
                        String lastName = rs.getString("last_name");
                        String specialty = rs.getString("specialty");
                        Date birthdate = rs.getDate("birthdate");
                        String bio = rs.getString("bio");
                        userDetail = new UserDetailDTO(userId, firstName, lastName, specialty, birthdate, bio);
                    }
                }
                rs.close();
                pst.close();
                cn.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return userDetail;
    }

    public static void main(String[] args) {
        System.out.println(UserDetailDAO.getUserDetailByUserId(3));
        //System.out.println(UserDetailDAO.updateUserPublicDetail(4, "ahihi", "ahihi", "ahihi", "ahihi", "2022-01-01"));
        //System.out.println(UserDetailDAO.updateUserPrivateDetail(4, "khoa@gmail.com", "1234"));
        //System.out.println(UserDetailDAO.updateUserPassword(4, "123"));
    }
}
