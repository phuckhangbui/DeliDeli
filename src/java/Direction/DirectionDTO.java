/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Direction;

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
public class DirectionDTO {
    
    private int id;
    private Boolean is_header;
    private int step;
    private String desc;
    private int recipe_id;    
}
