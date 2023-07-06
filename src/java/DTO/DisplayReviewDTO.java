/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DTO;

import java.sql.Date;
import lombok.*;

/**
 *
 * @author khang
 */
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class DisplayReviewDTO {
    private int id;
    private int reviewRating;
    private String reviewContent;
    private int recipeId;
    private String recipeTitle;
    private String thumbnailPath;
    private String recipeCategory;
    private UserDTO recipeOwner;
    private UserDTO reviewOwner;
    private Date create_at;
    private Date update_at;

    public DisplayReviewDTO(int id, int reviewRating, String reviewContent, int recipeId, String recipeTitle, String thumbnailPath, String recipeCategory, UserDTO recipeOwner) {
        this.id = id;
        this.reviewRating = reviewRating;
        this.reviewContent = reviewContent;
        this.recipeId = recipeId;
        this.recipeTitle = recipeTitle;
        this.thumbnailPath = thumbnailPath;
        this.recipeCategory = recipeCategory;
        this.recipeOwner = recipeOwner;
    }
    
    
}
