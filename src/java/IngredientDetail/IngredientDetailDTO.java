/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package IngredientDetail;

import lombok.*;

/**
 *
 * @author Admin
 */

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
public class IngredientDetailDTO {
    
    private int id;
    private String desc;
    private int ingredient_id;
    private int recipe_id;
    
}
