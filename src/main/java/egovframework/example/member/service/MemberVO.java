package egovframework.example.member.service;

import java.io.Serializable;

public class MemberVO implements Serializable {
    private static final long serialVersionUID = 1L;
    private String memberId;
    private String password;
    private String name;
    private String role;
    private String phone;
    private String email;

    public String getMemberId()  { return memberId; }
    public void   setMemberId(String memberId) { this.memberId = memberId; }
    public String getPassword()  { return password; }
    public void   setPassword(String password) { this.password = password; }
    public String getName()      { return name; }
    public void   setName(String name) { this.name = name; }
    public String getRole()      { return role; }
    public void   setRole(String role) { this.role = role; }
    public String getPhone()     { return phone; }
    public void   setPhone(String phone) { this.phone = phone; }
    public String getEmail()     { return email; }
    public void   setEmail(String email) { this.email = email; }
}
