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
public class DisplayRecipeDTO {
    private int id;
    private String title;
    private String thumbnailPath;
    private String category;
    private double rating;
    private UserDTO owner;
}
