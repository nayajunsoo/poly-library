package egovframework.example.user.service.impl;

import egovframework.example.member.service.MemberVO; // MemberVO 임포트 필수
import egovframework.example.user.service.UserVO;
import org.egovframe.rte.psl.dataaccess.mapper.Mapper;

@Mapper("userMapper")
public interface UserMapper {

    // 기존 로그인 메서드
    UserVO actionLogin(UserVO vo) throws Exception;

    /**
     * 회원가입을 위한 매퍼 메서드
     */
    void insertUser(MemberVO vo) throws Exception; // 👈 이 줄을 추가하세요!
}