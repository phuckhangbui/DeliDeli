/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DTO;




/**
 *
 * @author Daiisuke
 */

public class FavoriteDTO {
    private int id;
    private int user_id;
    private int recipe_id;

    public FavoriteDTO() {
    }

    public FavoriteDTO(int id, int user_id, int recipe_id) {
        this.id = id;
        this.user_id = user_id;
        this.recipe_id = recipe_id;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUser_id() {
        return user_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }

    public int getRecipe_id() {
        return recipe_id;
    }

    public void setRecipe_id(int recipe_id) {
        this.recipe_id = recipe_id;
    }
    
    
    
}
