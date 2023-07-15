/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DTO;

import java.sql.Date;
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
public class PlanDTO {

    private int id;
    private String name;
    private String description;
    private String note;
    private Date start_at;
    private Date end_at;
    private boolean status;
    private int user_id;
    private int diet_id;
    private boolean isDaily;

    // Without ID
    public PlanDTO(String name, String description, String note, Date start_at, Date end_at, int user_id, int diet_id, boolean isDaily) {
        this.name = name;
        this.description = description;
        this.note = note;
        this.start_at = start_at;
        this.end_at = end_at;
        this.user_id = user_id;
        this.diet_id = diet_id;
        this.isDaily = isDaily;
    } 
}
