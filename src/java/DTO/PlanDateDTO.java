/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DTO;

import java.sql.Date;

/**
 *
 * @author Daiisuke
 */
public class PlanDateDTO {
    private int id;
    private Date date;
    private int week_id;
    private int plan_id;

    public PlanDateDTO() {
    }

    public PlanDateDTO(int id, Date date, int week_id, int plan_id) {
        this.id = id;
        this.date = date;
        this.week_id = week_id;
        this.plan_id = plan_id;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public int getWeek_id() {
        return week_id;
    }

    public void setWeek_id(int week_id) {
        this.week_id = week_id;
    }

    public int getPlan_id() {
        return plan_id;
    }

    public void setPlan_id(int plan_id) {
        this.plan_id = plan_id;
    }
    
    
}
