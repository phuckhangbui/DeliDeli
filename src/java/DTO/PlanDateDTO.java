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
public class PlanDateDTO {
    private int id;
    private Date date;
    private int date_id;
    private int week_id;
    private int plan_id;
    private Time start_time;
    private Time end_time;

    public PlanDateDTO(int id, Date date, int week_id, int plan_id) {
        this.id = id;
        this.date = date;
        this.week_id = week_id;
        this.plan_id = plan_id;
    }

    public PlanDateDTO(int id, Date date, int week_id, int plan_id, Time start_time, Time end_time) {
        this.id = id;
        this.date = date;
        this.week_id = week_id;
        this.plan_id = plan_id;
        this.start_time = start_time;
        this.end_time = end_time;
    }
    
    

    
}
