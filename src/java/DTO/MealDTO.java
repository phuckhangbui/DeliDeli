/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DTO;

import java.sql.Date;
import java.sql.Time;

/**
 *
 * @author Daiisuke
 */
public class MealDTO {
    private int id;
    private int date_id;
    private int recipe_id;
    private Time start_time; 
    private Time end_time; 
    private int plan_id;

    public MealDTO() {
    }

    public MealDTO(int id, int date_id, int recipe_id, Time start_time, Time end_time, int plan_id) {
        this.id = id;
        this.date_id = date_id;
        this.recipe_id = recipe_id;
        this.start_time = start_time;
        this.end_time = end_time;
        this.plan_id = plan_id;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getDate_id() {
        return date_id;
    }

    public void setDate_id(int date_id) {
        this.date_id = date_id;
    }

    public int getRecipe_id() {
        return recipe_id;
    }

    public void setRecipe_id(int recipe_id) {
        this.recipe_id = recipe_id;
    }

    public Time getStart_time() {
        return start_time;
    }

    public void setStart_time(Time start_time) {
        this.start_time = start_time;
    }

    public Time getEnd_time() {
        return end_time;
    }

    public void setEnd_time(Time end_time) {
        this.end_time = end_time;
    }

    public int getPlan_id() {
        return plan_id;
    }

    public void setPlan_id(int plan_id) {
        this.plan_id = plan_id;
    }


    
}
