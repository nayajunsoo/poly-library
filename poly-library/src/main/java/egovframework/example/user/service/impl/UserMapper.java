package egovframework.example.user.service.impl;

import egovframework.example.member.service.MemberVO;
import egovframework.example.user.service.UserVO;
import org.egovframe.rte.psl.dataaccess.mapper.Mapper;

@Mapper("userMapper")
public interface UserMapper {

    UserVO actionLogin(UserVO vo) throws Exception;

    void insertUser(MemberVO vo) throws Exception;

    /** 아이디 존재 여부 카운트 */
    int countById(String memberId) throws Exception;
}
