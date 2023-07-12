/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import DTO.FavoriteDTO;
import Utils.DBUtils;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 *
 * @author Daiisuke
 */
public class FavoriteDAO {

    public static ArrayList<FavoriteDTO> getAllFavoriteRecipeByUserId(int userId) {
        //display fav recipe in user management : all user saved recipe by that user, and recipe of others with public status
        ArrayList<FavoriteDTO> result = new ArrayList<>();
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        String sql = "SELECT fr.id, fr.user_id, fr.recipe_id\n"
                + "FROM FavoriteRecipe fr\n"
                + "LEFT JOIN Recipe r ON fr.recipe_id = r.id\n"
                + "WHERE fr.user_id = ?\n"
                + "UNION\n"
                + "SELECT fr.id, fr.user_id, fr.recipe_id\n"
                + "FROM FavoriteRecipe fr\n"
                + "INNER JOIN Recipe r ON fr.recipe_id = r.id\n"
                + "WHERE fr.user_id <> r.user_id\n"
                + "  AND r.status = 3\n"
                + "  AND fr.user_id = ?";

        try {
            con = DBUtils.getConnection();
            if (con != null) {
                stm = con.prepareStatement(sql);
                stm.setInt(1, userId);
                stm.setInt(2, userId);
                rs = stm.executeQuery();

                if (rs != null) {
                    while (rs.next()) {

                        System.out.println("This is loading");

                        int id = rs.getInt("id");
                        int user_id = rs.getInt("user_id");
                        int recipe_id = rs.getInt("recipe_id");

                        FavoriteDTO favoriteRecipe = new FavoriteDTO(id, user_id, recipe_id);
                        result.add(favoriteRecipe);
                    }
                }

            }
        } catch (SQLException ex) {
            System.out.println("Query error: " + ex.getMessage());
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (stm != null) {
                    stm.close();
                }
                if (con != null) {
                    con.close();
                }
            } catch (SQLException ex) {
                System.out.println("Error closing database resources: " + ex.getMessage());
            }
        }
        return result;
    }

    public static ArrayList<FavoriteDTO> getAvailabeFavoriteRecipeByUserId(int userId) {
        //recipe of this user or other that have public status 
        ArrayList<FavoriteDTO> result = new ArrayList<>();
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        String sql = "SELECT fr.id, fr.user_id, fr.recipe_id\n"
                + "FROM FavoriteRecipe fr\n"
                + "INNER JOIN Recipe r ON fr.recipe_id = r.id\n"
                + "WHERE r.status = 3\n"
                + "  AND fr.user_id = ?";

        try {
            con = DBUtils.getConnection();
            if (con != null) {
                stm = con.prepareStatement(sql);
                stm.setInt(1, userId);
                rs = stm.executeQuery();

                if (rs != null) {
                    while (rs.next()) {

                        System.out.println("This is loading");

                        int id = rs.getInt("id");
                        int user_id = rs.getInt("user_id");
                        int recipe_id = rs.getInt("recipe_id");

                        FavoriteDTO favoriteRecipe = new FavoriteDTO(id, user_id, recipe_id);
                        result.add(favoriteRecipe);
                    }
                }

            }
        } catch (SQLException ex) {
            System.out.println("Query error: " + ex.getMessage());
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (stm != null) {
                    stm.close();
                }
                if (con != null) {
                    con.close();
                }
            } catch (SQLException ex) {
                System.out.println("Error closing database resources: " + ex.getMessage());
            }
        }
        return result;
    }

    public static boolean isSaveRecipe(int userId, int recipeId) {
        Connection cn = null;
        boolean isSave = false;

        try {
            cn = DBUtils.getConnection();

            if (cn != null) {
                String sql = "SELECT id\n"
                        + "FROM [dbo].[FavoriteRecipe]\n"
                        + "WHERE user_id = ? AND recipe_id = ?";

                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setInt(1, userId);
                pst.setInt(2, recipeId);
                ResultSet rs = pst.executeQuery();
                if (rs != null) {
                    isSave = rs.next();
                }

                pst.close();
                cn.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return isSave;
    }

    public static void deleteSaveRecipe(int id) {
        Connection cn = null;

        try {
            cn = DBUtils.getConnection();

            if (cn != null) {
                String sql = "DELETE FROM [dbo].[FavoriteRecipe]\n"
                        + "WHERE recipe_id = ?";

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
        System.out.println(getAvailabeFavoriteRecipeByUserId(5));
    }
}
