package egovframework.example.user.service;

import egovframework.example.member.service.MemberVO;

public interface UserService {

    UserVO actionLogin(UserVO vo) throws Exception;

    /**
     * 회원가입 서비스 메서드
     */
    void insertUser(MemberVO vo) throws Exception; // 👈 이 줄도 추가하세요!
}