/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DTO;

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
}
