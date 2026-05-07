package egovframework.example.member.service;

import java.io.Serializable;

public class MemberVO implements Serializable {
    private static final long serialVersionUID = 1L;

    private String memberId;   // 아이디 (기존 유지)
    private String password;   // 비밀번호 (로그인을 위해 필수!)
    private String name;       // 이름 (기존 유지)
    private String role;       // 권한 (ADMIN 또는 USER 구분을 위해 필수!)
    
    // 이메일과 폰은 일단 남겨두거나, 나중에 추가하셔도 됩니다.
    private String phone;
    private String email;

    // Getter & Setter
    public String getMemberId() { return memberId; }
    public void setMemberId(String memberId) { this.memberId = memberId; }
    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }
    
}