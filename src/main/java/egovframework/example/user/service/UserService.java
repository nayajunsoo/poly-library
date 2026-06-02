package egovframework.example.user.service;

import java.util.List;
import java.util.Map;
import egovframework.example.member.service.MemberVO;

public interface UserService {
    UserVO actionLogin(UserVO vo) throws Exception;
    void insertUser(MemberVO vo) throws Exception;
    boolean checkIdExists(String memberId) throws Exception;
    List<MemberVO> selectAllUsers() throws Exception;
    void updateUserRole(Map<String, String> param) throws Exception;
}
