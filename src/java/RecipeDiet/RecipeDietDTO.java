/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package RecipeDiet;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
/**
 *
 * @author khang
 */

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
public class RecipeDietDTO {
    private int id;
    private int recipe_id;
    private int diet_id;
    private String diet_title;

    public RecipeDietDTO(int id, int recipe_id, int diet_id) {
        this.id = id;
        this.recipe_id = recipe_id;
        this.diet_id = diet_id;
        this.diet_title = "";
    }
    
    
}
