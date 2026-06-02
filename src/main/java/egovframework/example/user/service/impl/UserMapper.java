package egovframework.example.user.service.impl;

import java.util.List;
import java.util.Map;
import egovframework.example.member.service.MemberVO;
import egovframework.example.user.service.UserVO;

public interface UserMapper {
    UserVO actionLogin(UserVO vo) throws Exception;
    void insertUser(MemberVO vo) throws Exception;
    int countById(String memberId) throws Exception;
    List<MemberVO> selectAllUsers() throws Exception;
    void updateUserRole(Map<String, String> param) throws Exception;
}
