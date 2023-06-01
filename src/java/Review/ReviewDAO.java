/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Review;

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
public class ReviewDAO {

    public static String getReviewOwnerByUserId(int userId) {
        String owner = "";
        Connection cn = null;

        try {
            cn = DBUtils.getConnection();

            if (cn != null) {
                String sql = "SELECT first_name + ' ' + last_name AS full_name FROM Review r INNER JOIN\n"
                        + "UserDetail ud\n"
                        + "ON r.user_id = ud.user_id\n"
                        + "WHERE ud.user_id = ?";

                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setInt(1, userId);
                ResultSet rs = pst.executeQuery();
                if (rs != null) {
                    while (rs.next()) {
                        owner = rs.getString("full_name");
                    }
                }
                rs.close();
                pst.close();
                cn.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return owner;
    }

    public static ArrayList<ReviewDTO> getReviewByRecipeId(int recipeId) {
        ArrayList<ReviewDTO> result = new ArrayList<>();
        Connection cn = null;

        try {
            cn = DBUtils.getConnection();

            if (cn != null) {
                String sql = "SELECT * FROM Review WHERE recipe_id = ?";

                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setInt(1, recipeId);
                ResultSet rs = pst.executeQuery();
                if (rs != null) {
                    while (rs.next()) {
                        int rating = rs.getInt("rating");
                        String content = rs.getString("content");
                        Date create_at = rs.getDate("create_at");
                        Date update_at = rs.getDate("update_at");
                        int recipe_id = rs.getInt("recipe_id");
                        int user_id = rs.getInt("user_id");

                        ReviewDTO review = new ReviewDTO(rating, content, create_at, update_at, recipe_id, user_id);
                        result.add(review);
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

    public static int makeFeedback(int userId, int recipeId, int rating, String txtReview) {
        int result = 0;
        Connection cn = null;

        try {
            cn = DBUtils.getConnection();

            if (cn != null) {
                String sql = "INSERT INTO [dbo].[Review] ([rating],[content],[create_at],[recipe_id],[user_id])\n"
                        + "VALUES (?, ?, GETDATE(), ?, ?)";

                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setInt(1, rating);
                pst.setString(2, txtReview);
                pst.setInt(3, recipeId);
                pst.setInt(4, userId);
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
        ArrayList<ReviewDTO> list = ReviewDAO.getReviewByRecipeId(1);
        System.out.println("Owner: " + getReviewOwnerByUserId(1));
        for (ReviewDTO o : list) {
            System.out.println(o);
        }
    }
}
