/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package News;

import java.sql.Date;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;


/**
 *
 * @author Admin
 */
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString

public class NewsDTO {
    
    private int id;
    private String title;
    private String desc;
    private String image;
    private Date createAt;
    private Date updateAt;
    private int user_id;
    private int news_category;

    //Constructor use for insert
    public NewsDTO(String title, String desc, String image, Date createAt, Date updateAt, int user_id, int news_category) {
        this.title = title;
        this.desc = desc;
        this.image = image;
        this.createAt = createAt;
        this.updateAt = updateAt;
        this.user_id = user_id;
        this.news_category = news_category;
    }

    public String getImage() {
        return "pictures/News/"+this.id+"/"+this.image;
    }
}
