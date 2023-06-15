/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Favorite;

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
        ArrayList<FavoriteDTO> result = new ArrayList<>();
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        
        
        String sql = "SELECT *\n"
                + "FROM FavoriteRecipe\n"
                + "WHERE user_id = ?";

        try {
            con = DBUtils.getConnection();
            if (con != null) {
                stm = con.prepareStatement(sql);
                stm.setInt(1, userId);
                rs = stm.executeQuery();
                
                if (rs != null){
                    while (rs.next()) {                        
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
}
