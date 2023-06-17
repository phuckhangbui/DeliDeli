/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Suggestion;

import Recipe.RecipeDTO;
import Utils.DBUtils;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Admin
 */
public class SuggestionDAO {

    private static final String DATE_FORMAT = "yyyy-MM-dd";

    public static RecipeDTO fromString(String string) {
        String[] parts = string.split(",");

        SimpleDateFormat dateFormat = new SimpleDateFormat(DATE_FORMAT);

        RecipeDTO recipe = new RecipeDTO();
        recipe.setId(Integer.parseInt(parts[0]));
        recipe.setTitle(parts[1]);
        recipe.setDescription(parts[2]);
        recipe.setPrep_time(Integer.parseInt(parts[3]));
        recipe.setCook_time(Integer.parseInt(parts[4]));
        recipe.setServings(Integer.parseInt(parts[5]));

        try {
            java.util.Date utilDate = dateFormat.parse(parts[6]);
            java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());
            recipe.setCreate_at(sqlDate);
        } catch (ParseException ex) {
            Logger.getLogger(SuggestionDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        try {
            java.util.Date utilDate = dateFormat.parse(parts[7]);
            java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());
            recipe.setUpdate_at(sqlDate);
        } catch (ParseException ex) {
            Logger.getLogger(SuggestionDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        recipe.setCuisine_id(Integer.parseInt(parts[8]));
        recipe.setCategory_id(Integer.parseInt(parts[9]));
        recipe.setUser_id(Integer.parseInt(parts[10]));
        recipe.setLevel_id(Integer.parseInt(parts[11]));
        recipe.setStatus(Integer.parseInt(parts[12]));

        return recipe;
    }

    public static ArrayList<String> getAllSuggestion() {
        ArrayList<String> result = new ArrayList<>();
        Connection cn = null;

        try {
            cn = DBUtils.getConnection();

            if (cn != null) {
                String sql = "SELECT * FROM Suggestion ";

                PreparedStatement pst = cn.prepareStatement(sql);
                ResultSet rs = pst.executeQuery();
                if (rs != null) {
                    while (rs.next()) {
//                        int id = rs.getInt("id");
                        String title = rs.getString("title");
//                        int userId = rs.getInt("user_id");

//                        SuggestionDTO suggestion = new SuggestionDTO(id, title, userId);
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

    public static ArrayList<RecipeDTO> getAllRecipesIdBySuggestion(String suggestion) {
        ArrayList<RecipeDTO> result = new ArrayList<>();
        Connection cn = null;

        try {
            cn = DBUtils.getConnection();

            if (cn != null) {
                String sql = "SELECT TOP 3 * FROM Recipe WHERE id IN (SELECT recipe_id FROM SuggestionRecipe sg\n"
                        + "JOIN Suggestion s\n"
                        + "ON sg.suggestion_id = s.id\n"
                        + "WHERE s.title = ? AND status = 3)";

                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, suggestion);
                ResultSet rs = pst.executeQuery();
                if (rs != null) {
                    while (rs.next()) {
                        int id = rs.getInt("id");
                        String title = rs.getString("title");
                        String description = rs.getString("description");
                        int prep_time = rs.getInt("prep_time");
                        int cook_time = rs.getInt("cook_time");
                        int servings = rs.getInt("servings");
                        Date create_at = rs.getDate("create_at");
                        Date update_at = rs.getDate("update_at");
                        int cuisin_id = rs.getInt("cuisine_id");
                        int category_id = rs.getInt("category_id");
                        int user_id = rs.getInt("user_id");
                        int level_id = rs.getInt("level_id");
                        int status = rs.getInt("status");

                        RecipeDTO recipe = new RecipeDTO(id, title, description, prep_time,
                                cook_time, servings, create_at, update_at, cuisin_id,
                                category_id, user_id, level_id, status);
                        result.add(recipe);
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
        System.out.println(SuggestionDAO.getAllRecipesIdBySuggestion("Popular"));
    }
}
