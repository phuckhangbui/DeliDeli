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

    public static ArrayList<ReviewDTO> getReviewByUserId(int userId) {
        ArrayList<ReviewDTO> result = new ArrayList<>();
        Connection cn = null;

        try {
            cn = DBUtils.getConnection();

            if (cn != null) {
                String sql = "SELECT *\n"
                        + "FROM Review\n"
                        + "WHERE user_id = ?\n"
                        + "ORDER BY COALESCE(update_at, create_at) DESC, create_at DESC;";

                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setInt(1, userId);
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

    public static ReviewDTO getReviewById(int reviewId) {
        ReviewDTO result = null;
        Connection cn = null;

        try {
            cn = DBUtils.getConnection();

            if (cn != null) {
                String sql = "SELECT * FROM Review WHERE id = ? ";

                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setInt(1, reviewId);
                ResultSet rs = pst.executeQuery();
                if (rs != null) {
                    while (rs.next()) {
                        int id = rs.getInt("id");
                        int rating = rs.getInt("rating");
                        String content = rs.getString("content");
                        Date create_at = rs.getDate("create_at");
                        Date update_at = rs.getDate("update_at");
                        int recipe_id = rs.getInt("recipe_id");
                        int user_id = rs.getInt("user_id");

                        result = new ReviewDTO(id, rating, content, create_at, update_at, recipe_id, user_id);
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

    public static ReviewDTO getReviewByRecipeAndUser(int userId, int recipeId) {
        ReviewDTO result = null;
        Connection cn = null;

        try {
            cn = DBUtils.getConnection();

            if (cn != null) {
                String sql = "SELECT * FROM Review WHERE user_id = ? AND recipe_id= ?";

                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setInt(1, userId);
                pst.setInt(2, recipeId);
                ResultSet rs = pst.executeQuery();
                if (rs != null) {
                    while (rs.next()) {
                        int id = rs.getInt("id");
                        int rating = rs.getInt("rating");
                        String content = rs.getString("content");
                        Date create_at = rs.getDate("create_at");
                        Date update_at = rs.getDate("update_at");
                        int recipe_id = rs.getInt("recipe_id");
                        int user_id = rs.getInt("user_id");

                        result = new ReviewDTO(id, rating, content, create_at, update_at, recipe_id, user_id);
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

    public static int deleteReview(int reviewId) {
        int result = 0;
        Connection cn = null;

        try {
            cn = DBUtils.getConnection();

            if (cn != null) {
                String sql = " DELETE FROM [dbo].[Review]\n"
                        + " WHERE id = ?";

                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setInt(1, reviewId);
                result = pst.executeUpdate();
                pst.close();
                cn.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }

    public static boolean updateReview(ReviewDTO review) {
        boolean success = false;
        Connection cn = null;

        try {
            cn = DBUtils.getConnection();

            if (cn != null) {
                String sql = "UPDATE Review SET rating = ?, content = ?, update_at = ? WHERE id = ?";

                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setInt(1, review.getRating());
                pst.setString(2, review.getContent());
                pst.setDate(3, review.getUpdate_at());
                pst.setInt(4, review.getId());

                int rowsAffected = pst.executeUpdate();
                if (rowsAffected > 0) {
                    success = true;
                }

                pst.close();
                cn.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return success;
    }

    public static void main(String[] args) {
        ReviewDTO o = ReviewDAO.getReviewById(6);
//        System.out.println("Owner: " + getReviewByUserId(1));
        updateReview(o);
        System.out.println(o);

    }
}
