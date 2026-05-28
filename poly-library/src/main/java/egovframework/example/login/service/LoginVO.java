package egovframework.example.login.service;

import java.io.Serializable;

public class LoginVO implements Serializable {
    private static final long serialVersionUID = 1L;

    private String userId;   // 사용자 아이디
    private String userPw;   // 사용자 비밀번호
    private String userName; // 사용자 이름
    private String role;     // 권한 (ADMIN 또는 USER)

    // Getter & Setter (이클립스 자동생성 활용)
    public String getUserId() { return userId; }
    public void setUserId(String userId) { this.userId = userId; }
    public String getUserPw() { return userPw; }
    public void setUserPw(String userPw) { this.userPw = userPw; }
    public String getUserName() { return userName; }
    public void setUserName(String userName) { this.userName = userName; }
    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }
}