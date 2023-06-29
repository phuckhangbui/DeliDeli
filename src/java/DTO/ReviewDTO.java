/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DTO;

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
public class ReviewDTO {
    
    private int id;
    private int rating;
    private String content;
    private Date create_at;
    private Date update_at;
    private int recipe_id;
    private int user_id;

    public ReviewDTO(int rating, String content, Date create_at, Date update_at, int recipe_id, int user_id) {
        this.rating = rating;
        this.content = content;
        this.create_at = create_at;
        this.update_at = update_at;
        this.recipe_id = recipe_id;
        this.user_id = user_id;
    }
    
    
}
