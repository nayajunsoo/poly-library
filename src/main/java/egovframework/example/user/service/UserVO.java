package egovframework.example.user.service;

import java.io.Serializable;

/**
 * 사용자 정보 및 로그인 세션을 위한 VO 클래스
 */
public class UserVO implements Serializable {

    private static final long serialVersionUID = 1L;

    private String userId;      // 사용자 아이디
    private String password;    // 비밀번호 (인증용)
    private String userName;    // 사용자 이름 (화면 표시용)
    private String role;        // 권한 (ADMIN / USER)

    // 기본 생성자
    public UserVO() {}

    // Getter & Setter
    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }
}