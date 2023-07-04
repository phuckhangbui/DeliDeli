/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DTO;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

/**
 *
 * @author Daiisuke
 */
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class FavoriteDTO {

    private int id;
    private int user_id;
    private int recipe_id;
}
