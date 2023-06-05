/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Direction;

import Utils.DBUtils;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Admin
 */
public class DirectionDAO {

    public static ArrayList<DirectionDTO> getDirectionByRecipeId(int id) {
        ArrayList<DirectionDTO> result = new ArrayList<>();
        Connection cn = null;

        try {
            cn = DBUtils.getConnection();

            if (cn != null) {
                String sql = "SELECT d.*\n"
                        + "FROM Recipe r INNER JOIN Direction d\n"
                        + "ON r.id = d.recipe_id\n"
                        + "WHERE r.id = ?";

                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setInt(1, id);
                ResultSet rs = pst.executeQuery();
                if (rs != null) {
                    while (rs.next()) {
                        id = rs.getInt("id");
                        int isHeader = rs.getInt("is_header");
                        int step = rs.getInt("step");
                        String desc = rs.getString("description");
                        int recipe_id = rs.getInt("recipe_id");
                        DirectionDTO direction = new DirectionDTO(id, isHeader, step, desc, recipe_id);
                        
                        result.add(direction);
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
    
    public static void main(String[] args) {
        List<DirectionDTO> list = DirectionDAO.getDirectionByRecipeId(1);
        for (DirectionDTO o : list) {
            System.out.println(o);
        }
    }

}
