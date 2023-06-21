/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Notification;

import java.sql.Date;
import java.sql.Time;
import java.sql.Timestamp;
import lombok.*;

/**
 *
 * @author khang
 */
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
public class NotificationDTO {
    private int id;
    private String title;
    private String description;
    private Timestamp send_date;
    private boolean is_read;
    private int user_id;
    private int notification_type;
    private int recipe_id;
    private int plan_id;
    private String link;
}
