/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package User;

import java.sql.Date;
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
public class UserDetailDTO {
    
    private int user_id;
    private String firstName;
    private String lastName;
    private String specialty;
    private Date birthdate;
    private String bio;
    
}
