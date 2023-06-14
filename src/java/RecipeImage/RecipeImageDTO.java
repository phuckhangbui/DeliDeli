/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package RecipeImage;

import Recipe.RecipeDAO;

/**
 *
 * @author Daiisuke
 */
public class RecipeImageDTO {
    private int id;
    private String image;
    private int recipe_id;
    private boolean isThumbnail;

    public RecipeImageDTO() {
    }

    public RecipeImageDTO(int id, String image, int recipe_id, boolean isThumbnail) {
        this.id = id;
        this.image = image;
        this.recipe_id = recipe_id;
        this.isThumbnail = isThumbnail;
    }

    public RecipeImageDTO(String image, int recipe_id, boolean isThumbnail) {
        this.image = image;
        this.recipe_id = recipe_id;
        this.isThumbnail = isThumbnail;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public int getRecipe_id() {
        return recipe_id;
    }

    public void setRecipe_id(int recipe_id) {
        this.recipe_id = recipe_id;
    }

    public boolean getIsThumbnail() {
        return isThumbnail;
    }

    public void setIsThumbnail(boolean isThumbnail) {
        this.isThumbnail = isThumbnail;
    }
    
    public String getThumbnailPath(){
        String path = "Recipe/"+this.recipe_id+"/Thumbnail/"+this.image;
        return path;
    }
    
    public String getImgPath(){
        String path = "Recipe/"+this.recipe_id+"/Detail/"+this.image;
        return path;
    }
}
