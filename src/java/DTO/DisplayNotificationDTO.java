/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DTO;

import java.sql.Timestamp;
import lombok.*;

/**
 *
 * @author khang
 */
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class DisplayNotificationDTO {
    private int id;
    private String title;
    private String description;
    private Timestamp send_date;
    private boolean is_read;
    private int user_id;
    private int recipe_id;
    private int plan_id;
    private String link;
    private NotificationTypeDTO type;
    
    
    public String getImgPath(){
        return "Broadcast/" + this.link;
    }
}
