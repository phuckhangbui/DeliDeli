/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DTO;

import java.sql.Date;
import java.sql.Time;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

/**
 *
 * @author Daiisuke
 */

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
public class MealDTO {
    private int id;
    private int date_id;
    private int recipe_id;
    private Time start_time; 
    private int plan_id; 

    //w/o plan_id
    public MealDTO(int id, int date_id, int recipe_id, Time start_time) {
        this.id = id;
        this.date_id = date_id;
        this.recipe_id = recipe_id;
        this.start_time = start_time;
    }

    
}
