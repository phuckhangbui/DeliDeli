/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import DTO.RecipeImageDTO;
import Utils.DBUtils;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author Daiisuke
 */
public class RecipeImageDAO {

    public RecipeImageDTO checkRecipeImageByID(int recipeID) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        RecipeImageDTO recipeImage = null;

        String sql = "SELECT * FROM [RecipeImage]\n"
                + "WHERE recipe_id = ?";

        try {
            con = DBUtils.getConnection();
            if (con != null) {
                stm = con.prepareStatement(sql);
                stm.setInt(1, recipeID);
                rs = stm.executeQuery();

                if (rs != null && rs.next()) {
                    int id = rs.getInt("id");
                    String image = rs.getString("image");
                    recipeID = rs.getInt("recipe_id");
                    boolean isThumbnail = rs.getBoolean("thumbnail");
                    recipeImage = new RecipeImageDTO(id, image, recipeID, isThumbnail);
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
            return recipeImage;
        }
    }

    public boolean insertRecipeImageByID(boolean isThumbnail, String imageName, int recipeID) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        String sql = "INSERT INTO [RecipeImage](image,recipe_id,thumbnail) \n"
                + "VALUES \n"
                + "(?,?,?)";

        try {
            con = DBUtils.getConnection();
            if (con != null) {
                stm = con.prepareStatement(sql);
                stm.setString(1, imageName);
                stm.setInt(2, recipeID);
                stm.setBoolean(3, isThumbnail);

                int effectRows = stm.executeUpdate();

                System.out.println("[DAO - insertRecipeImageByID]: Executed.");

                if (effectRows > 0) {
                    return true;
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
            return false;
        }
    }

    public boolean updateRecipeDetailedImageByID(String imageName, int recipeID) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        String sql = "UPDATE [RecipeImage] \n"
                + "SET image = ? \n"
                + "WHERE recipe_id = ? AND thumbnail = 0";

        try {
            con = DBUtils.getConnection();
            if (con != null) {
                stm = con.prepareStatement(sql);
                stm.setString(1, imageName);
                stm.setInt(2, recipeID);

                int effectRows = stm.executeUpdate();

                System.out.println("[DAO - updateRecipeImageByID]: Executed.");

                if (effectRows > 0) {
                    return true;
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
            return false;
        }
    }

    public boolean updateRecipeThumbnailImageByID(String imageName, int recipeID) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        String sql = "UPDATE [RecipeImage] \n"
                + "SET image = ? \n"
                + "WHERE recipe_id = ? AND thumbnail = 1";

        try {
            con = DBUtils.getConnection();
            if (con != null) {
                stm = con.prepareStatement(sql);
                stm.setString(1, imageName);
                stm.setInt(2, recipeID);

                int effectRows = stm.executeUpdate();

                System.out.println("[DAO - updateRecipeImageByID]: Executed.");

                if (effectRows > 0) {
                    return true;
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
            return false;
        }
    }

    public static boolean deleteRecipeImages(int recipeID) {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        String sql = "DELETE FROM RecipeImage\n"
                + "WHERE recipe_id = ?";

        try {
            con = DBUtils.getConnection();
            if (con != null) {
                stm = con.prepareStatement(sql);
                stm.setInt(1, recipeID);

                int effectRows = stm.executeUpdate();

                System.out.println("[DAO - DeleteRecipeImages]: Executed.");

                if (effectRows > 0) {
                    return true;
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
            return false;
        }
    }
}
