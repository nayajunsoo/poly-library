package egovframework.example.user.service;

import java.io.Serializable;

public class UserVO implements Serializable {
    private static final long serialVersionUID = 1L;

    private String userId;
    private String password;
    private String userName;
    private String role;
    private String phone;
    private String email;

    public UserVO() {}

    public String getUserId() { return userId; }
    public void setUserId(String userId) { this.userId = userId; }
    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
    public String getUserName() { return userName; }
    public void setUserName(String userName) { this.userName = userName; }
    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }
    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
}
