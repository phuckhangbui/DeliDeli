/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package User;

//import lombok.*;

/**
 *
 * @author Daiisuke
 */
//@NoArgsConstructor
//@AllArgsConstructor
//@Getter
//@Setter
//@ToString
public class UserDTO {
    private String userName;
    private String email;
    private String password;
    private String avatar;
    private String createAt;
    private int status;
    private int role;
    private int setting;

    public UserDTO() {
    }

    public UserDTO(String userName, String email, String password, String avatar, String createAt, int status, int role, int setting) {
        this.userName = userName;
        this.email = email;
        this.password = password;
        this.avatar = avatar;
        this.createAt = createAt;
        this.status = status;
        this.role = role;
        this.setting = setting;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }

    public String getCreateAt() {
        return createAt;
    }

    public void setCreateAt(String createAt) {
        this.createAt = createAt;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public int getRole() {
        return role;
    }

    public void setRole(int role) {
        this.role = role;
    }

    public int getSetting() {
        return setting;
    }

    public void setSetting(int setting) {
        this.setting = setting;
    }

    @Override
    public String toString() {
        return "UserDTO{" + "userName=" + userName + ", email=" + email + ", password=" + password + ", avatar=" + avatar + ", createAt=" + createAt + ", status=" + status + ", role=" + role + ", setting=" + setting + '}';
    }
    
    
}
