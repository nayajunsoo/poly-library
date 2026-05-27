package egovframework.example.user.service.impl;

<<<<<<< HEAD
import egovframework.example.member.service.MemberVO;
=======
import egovframework.example.member.service.MemberVO; // MemberVO 임포트 필수
>>>>>>> c35c9fa3da37ff3babc985bb0c77426861bb6aa1
import egovframework.example.user.service.UserVO;
import org.egovframe.rte.psl.dataaccess.mapper.Mapper;

@Mapper("userMapper")
public interface UserMapper {

<<<<<<< HEAD
    UserVO actionLogin(UserVO vo) throws Exception;

    void insertUser(MemberVO vo) throws Exception;

    /** 아이디 존재 여부 카운트 */
    int countById(String memberId) throws Exception;
}
=======
    // 기존 로그인 메서드
    UserVO actionLogin(UserVO vo) throws Exception;

    /**
     * 회원가입을 위한 매퍼 메서드
     */
    void insertUser(MemberVO vo) throws Exception; // 👈 이 줄을 추가하세요!
}
>>>>>>> c35c9fa3da37ff3babc985bb0c77426861bb6aa1
