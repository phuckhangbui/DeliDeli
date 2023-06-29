/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DTO;

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
public class NutritionDTO {
    private int recipe_id;
    private int calories;
    private int fat;
    private int carbs;
    private int protein;
   
    
}
