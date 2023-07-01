/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import DTO.NewsDTO;
import Utils.DBUtils;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

/**
 *
 * @author Admin
 */
public class NewsDAO {

    public static int updateNewsImage(int newsId, String image) {
        int result = 0;
        Connection cn = null;

        try {
            cn = DBUtils.getConnection();

            if (cn != null) {
                String sql = "UPDATE News SET image = ? WHERE id = ?";

                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, image);
                pst.setInt(2, newsId);
                result = pst.executeUpdate();
                pst.close();
                cn.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    public static int deleteNews(int newsId) {
        int result = 0;
        Connection cn = null;

        try {
            cn = DBUtils.getConnection();

            if (cn != null) {
                String sql = "DELETE News WHERE id = ?";

                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setInt(1, newsId);
                result = pst.executeUpdate();
                pst.close();
                cn.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    public static int updateNews(int newsId, String title, String desc, Date updateAt, int categoryId) {
        int result = 0;
        Connection cn = null;

        try {
            cn = DBUtils.getConnection();

            if (cn != null) {
                String sql = "UPDATE News SET \n"
                        + "title = ?,\n"
                        + "description = ?,\n"
                        + "update_at = ?, \n"
                        + "news_category_id = ?\n"
                        + "WHERE id = ?";

                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, title);
                pst.setString(2, desc);
                pst.setDate(3, updateAt);
                pst.setInt(4, categoryId);
                pst.setInt(5, newsId);
                result = pst.executeUpdate();
                pst.close();
                cn.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    public static int insertNews(String title, String desc, Date createAt, Date updateAt, int userId, int categoryId) {
        int result = 0;
        Connection cn = null;

        try {
            cn = DBUtils.getConnection();

            if (cn != null) {
                String sql = "INSERT INTO News(title, description, create_at, update_at, user_id, news_category_id) \n"
                        + "VALUES (?, ?, ?, ?, ?, ?)";

                PreparedStatement pst = cn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
                pst.setString(1, title);
                pst.setString(2, desc);
                pst.setDate(3, createAt);
                pst.setDate(4, createAt);
                pst.setInt(5, userId);
                pst.setInt(6, categoryId);

                pst.executeUpdate();

                ResultSet generatedKeys = pst.getGeneratedKeys();

                // Step 4: Retrieve the generated ID
                if (generatedKeys.next()) {
                    result = generatedKeys.getInt(1);
                }

                // Step 5: Close the database connection and resources
                generatedKeys.close();

                pst.close();
                cn.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    public static ArrayList<String> getAllNewsCategory() {
        ArrayList<String> result = new ArrayList<>();
        Connection cn = null;

        try {
            cn = DBUtils.getConnection();

            if (cn != null) {
                String sql = "SELECT title FROM NewsCategory";

                PreparedStatement pst = cn.prepareStatement(sql);
                ResultSet rs = pst.executeQuery();
                if (rs != null) {
                    while (rs.next()) {
                        String title = rs.getString("title");;

                        result.add(title);
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

    public static String getNewsAuthorByNewsId(int id) {
        String result = "";
        Connection cn = null;

        try {
            cn = DBUtils.getConnection();

            if (cn != null) {
                String sql = "SELECT user_name FROM [User] u\n"
                        + "INNER JOIN [News] n\n"
                        + "ON u.id = n.user_id\n"
                        + "WHERE n.id = ?";

                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setInt(1, id);
                ResultSet rs = pst.executeQuery();
                if (rs != null) {
                    while (rs.next()) {
                        result = rs.getString("user_name");
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

    public static String getNewsCategoryByNewsId(int id) {
        String result = "";
        Connection cn = null;

        try {
            cn = DBUtils.getConnection();

            if (cn != null) {
                String sql = "SELECT nc.title FROM NewsCategory nc \n"
                        + "INNER JOIN News n\n"
                        + "ON nc.id = n.news_category_id\n"
                        + "WHERE n.id = ?";

                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setInt(1, id);
                ResultSet rs = pst.executeQuery();
                if (rs != null) {
                    while (rs.next()) {
                        result = rs.getString("title");
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

    public static NewsDTO getLatestNews() {
        NewsDTO news = null;
        Connection cn = null;

        try {
            cn = DBUtils.getConnection();

            if (cn != null) {
                String sql = "SELECT TOP 1 * FROM News ORDER BY id DESC";

                PreparedStatement pst = cn.prepareStatement(sql);
                ResultSet rs = pst.executeQuery();
                if (rs != null) {
                    while (rs.next()) {
                        int id = rs.getInt("id");
                        String title = rs.getString("title");
                        String description = rs.getString("description");
                        String image = rs.getString("image");
                        Date createAt = rs.getDate("create_at");
                        Date updateAt = rs.getDate("update_at");
                        int user_id = rs.getInt("user_id");
                        int news_category_id = rs.getInt("news_category_id");

                        news = new NewsDTO(id, title, description, image, createAt, updateAt, user_id, news_category_id);
                    }
                }
                rs.close();
                pst.close();
                cn.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return news;
    }

    public static ArrayList<NewsDTO> getNext2News(int tag) {
        ArrayList<NewsDTO> result = new ArrayList<>();
        Connection cn = null;

        try {
            cn = DBUtils.getConnection();

            if (cn != null) {
                String sql = "SELECT *\n"
                        + "FROM News\n"
                        + "WHERE id <> ?";

                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setInt(1, tag);
                ResultSet rs = pst.executeQuery();
                if (rs != null) {
                    while (rs.next()) {
                        int id = rs.getInt("id");
                        String title = rs.getString("title");
                        String description = rs.getString("description");
                        String image = rs.getString("image");
                        Date createAt = rs.getDate("create_at");
                        Date updateAt = rs.getDate("update_at");
                        int user_id = rs.getInt("user_id");
                        int news_category_id = rs.getInt("news_category_id");

                        NewsDTO news = new NewsDTO(id, title, description, image, createAt, updateAt, user_id, news_category_id);
                        result.add(news);
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

    public static ArrayList<NewsDTO> getAllNews() {
        ArrayList<NewsDTO> result = new ArrayList<>();
        Connection cn = null;

        try {
            cn = DBUtils.getConnection();

            if (cn != null) {
                String sql = "SELECT * FROM News";

                PreparedStatement pst = cn.prepareStatement(sql);
                ResultSet rs = pst.executeQuery();
                if (rs != null) {
                    while (rs.next()) {
                        int id = rs.getInt("id");
                        String title = rs.getString("title");
                        String description = rs.getString("description");
                        String image = rs.getString("image");
                        Date createAt = rs.getDate("create_at");
                        Date updateAt = rs.getDate("update_at");
                        int user_id = rs.getInt("user_id");
                        int news_category_id = rs.getInt("news_category_id");

                        NewsDTO news = new NewsDTO(id, title, description, image, createAt, updateAt, user_id, news_category_id);
                        result.add(news);
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

    public static NewsDTO getNewsByNewsId(int id) {
        NewsDTO news = null;
        Connection cn = null;

        try {
            cn = DBUtils.getConnection();

            if (cn != null) {
                String sql = "SELECT * FROM News WHERE id = ?";

                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setInt(1, id);
                ResultSet rs = pst.executeQuery();
                if (rs != null) {
                    while (rs.next()) {
                        String title = rs.getString("title");
                        String description = rs.getString("description");
                        String image = rs.getString("image");
                        Date createAt = rs.getDate("create_at");
                        Date updateAt = rs.getDate("update_at");
                        int user_id = rs.getInt("user_id");
                        int news_category_id = rs.getInt("news_category_id");

                        news = new NewsDTO(id, title, description, image, createAt, updateAt, user_id, news_category_id);
                    }
                }
                rs.close();
                pst.close();
                cn.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return news;
    }

    public static void main(String[] args) {
        //System.out.println(NewsDAO.getNewsByNewsId(2));
//        ArrayList<NewsDTO> list = NewsDAO.getAllNews();
//        for (NewsDTO o : list) {
//            System.out.println(o);
//        }
        java.util.Date date = new java.util.Date();
        java.sql.Date createAt = new java.sql.Date(date.getTime());
        java.sql.Date updateAt = createAt;

//        System.out.println(NewsDAO.insertNews("title", "desc", createAt, updateAt, 4, 3));
        System.out.println(NewsDAO.getNext2News(3));
    }
}
