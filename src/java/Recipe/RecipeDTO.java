/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Recipe;

import Direction.DirectionDTO;
import IngredientDetail.IngredientDetailDTO;
import java.sql.Date;
import java.util.List;
import lombok.*;

/**
 *
 * @author Daiisuke
 */
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
public class RecipeDTO {

    private int id;
    private String title;
    private String description;
    private int prep_time;
    private int cook_time;
    private int servings;
    private Date create_at;
    private Date update_at;
    private int cuisine_id;
    private int category_id;
    private int user_id;
    private int level_id;
    private int status;


    public RecipeDTO(String title, String description, int prep_time, int cook_time, int servings, Date create_at, Date update_at, int cuisine_id, int category_id, int user_id, int level_id, int status) {
        this.title = title;
        this.description = description;
        this.prep_time = prep_time;
        this.cook_time = cook_time;
        this.servings = servings;
        this.create_at = create_at;
        this.update_at = update_at;
        this.cuisine_id = cuisine_id;
        this.category_id = category_id;
        this.user_id = user_id;
        this.level_id = level_id;
        this.status = status;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getPrep_time() {
        return prep_time;
    }

    public void setPrep_time(int prep_time) {
        this.prep_time = prep_time;
    }

    public int getCook_time() {
        return cook_time;
    }

    public void setCook_time(int cook_time) {
        this.cook_time = cook_time;
    }

    public int getServings() {
        return servings;
    }

    public void setServings(int servings) {
        this.servings = servings;
    }

    public Date getCreate_at() {
        return create_at;
    }

    public void setCreate_at(Date create_at) {
        this.create_at = create_at;
    }

    public Date getUpdate_at() {
        return update_at;
    }

    public void setUpdate_at(Date update_at) {
        this.update_at = update_at;
    }

    public int getCuisine_id() {
        return cuisine_id;
    }

    public void setCuisine_id(int cuisine_id) {
        this.cuisine_id = cuisine_id;
    }

    public int getCategory_id() {
        return category_id;
    }

    public void setCategory_id(int category_id) {
        this.category_id = category_id;
    }

    public int getUser_id() {
        return user_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }

    public int getLevel_id() {
        return level_id;
    }

    public void setLevel_id(int level_id) {
        this.level_id = level_id;
    }


}
