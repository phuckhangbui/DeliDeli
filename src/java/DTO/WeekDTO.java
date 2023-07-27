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
public class WeekDTO {
    private int id;
    private Date start_at;
    private int plan_id;
    private boolean is_sync;
    private boolean is_template;
}
