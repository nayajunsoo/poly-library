package egovframework.example.user.service;

import egovframework.example.member.service.MemberVO;

public interface UserService {

    UserVO actionLogin(UserVO vo) throws Exception;

<<<<<<< HEAD
    void insertUser(MemberVO vo) throws Exception;

    /** 아이디 중복 체크: true = 이미 존재 */
    boolean checkIdExists(String memberId) throws Exception;
}
=======
    /**
     * 회원가입 서비스 메서드
     */
    void insertUser(MemberVO vo) throws Exception; // 👈 이 줄도 추가하세요!
}
>>>>>>> c35c9fa3da37ff3babc985bb0c77426861bb6aa1
