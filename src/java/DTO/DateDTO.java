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
public class DateDTO {
    private int id;
    private Date date;
    private int week_id;
    private int plan_id;
}
