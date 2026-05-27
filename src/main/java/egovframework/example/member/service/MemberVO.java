package egovframework.example.member.service;

import java.io.Serializable;

public class MemberVO implements Serializable {
    private static final long serialVersionUID = 1L;

    private String memberId;   // 회원 아이디
    private String name;       // 이름
    private String phone;      // 전화번호
    private String email;      // 이메일

    public String getMemberId() { return memberId; }
    public void setMemberId(String memberId) { this.memberId = memberId; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
}