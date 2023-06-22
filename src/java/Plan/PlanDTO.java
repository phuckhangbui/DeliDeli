/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Plan;

import java.sql.Date;

/**
 *
 * @author Daiisuke
 */
public class PlanDTO {

    private int id;
    private String name;
    private String description;
    private String note;
    private Date start_at;
    private Date end_at;
    private int user_id;
    private int diet_id;

    public PlanDTO() {
    }

    public PlanDTO(int id, String name, String description, String note, Date start_at, Date end_at, int user_id, int diet_id) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.note = note;
        this.start_at = start_at;
        this.end_at = end_at;
        this.user_id = user_id;
        this.diet_id = diet_id;
    }

    // Without ID
    public PlanDTO(String name, String description, String note, Date start_at, Date end_at, int user_id, int diet_id) {
        this.name = name;
        this.description = description;
        this.note = note;
        this.start_at = start_at;
        this.end_at = end_at;
        this.user_id = user_id;
        this.diet_id = diet_id;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public Date getStart_at() {
        return start_at;
    }

    public void setStart_at(Date start_at) {
        this.start_at = start_at;
    }

    public Date getEnd_at() {
        return end_at;
    }

    public void setEnd_at(Date end_at) {
        this.end_at = end_at;
    }

    public int getUser_id() {
        return user_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }

    public int getDiet_id() {
        return diet_id;
    }

    public void setDiet_id(int diet_id) {
        this.diet_id = diet_id;
    }

    

}
