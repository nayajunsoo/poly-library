package egovframework.example.user.service;

import egovframework.example.member.service.MemberVO;

public interface UserService {

    UserVO actionLogin(UserVO vo) throws Exception;

    void insertUser(MemberVO vo) throws Exception;

    /** 아이디 중복 체크: true = 이미 존재 */
    boolean checkIdExists(String memberId) throws Exception;
}
