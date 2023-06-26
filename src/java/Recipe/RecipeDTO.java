/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Recipe;

import Direction.DirectionDTO;
import IngredientDetail.IngredientDetailDTO;
import java.io.Serializable;
import java.sql.Date;
import java.sql.Timestamp;
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
public class RecipeDTO implements Serializable {

    private int id;
    private String title;
    private String description;
    private int prep_time;
    private int cook_time;
    private int servings;
    private Timestamp create_at;
    private Timestamp update_at;
    private int cuisine_id;
    private int category_id;
    private int user_id;
    private int level_id;
    private int status;


    public RecipeDTO(String title, String description, int prep_time, int cook_time, int servings, Timestamp create_at, Timestamp update_at, int cuisine_id, int category_id, int user_id, int level_id, int status) {
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

}
