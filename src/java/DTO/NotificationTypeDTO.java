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
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
public class NotificationTypeDTO {
    private int id;
    private String sender;
    private String image;
    private String cate;
}
