package egovframework.example.login.service;

import java.io.Serializable;

public class LoginVO implements Serializable {
    private static final long serialVersionUID = 1L;

    private String id;         // 아이디
    private String password;   // 비밀번호
    private String name;       // 이름
    private String userType;   // 권한 (ADMIN / USER)

    public String getId() { return id; }
    public void setId(String id) { this.id = id; }
    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getUserType() { return userType; }
    public void setUserType(String userType) { this.userType = userType; }
}