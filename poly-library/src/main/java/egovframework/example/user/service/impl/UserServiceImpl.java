package egovframework.example.user.service.impl;

import javax.annotation.Resource;
import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

<<<<<<< HEAD
import egovframework.example.member.service.MemberVO;
import egovframework.example.user.service.UserService;
import egovframework.example.user.service.UserVO;

=======
import egovframework.example.member.service.MemberVO; // 👈 이 줄이 반드시 필요합니다!
import egovframework.example.user.service.UserService;
import egovframework.example.user.service.UserVO;

/**
 * UserService의 구현 클래스
 */
>>>>>>> c35c9fa3da37ff3babc985bb0c77426861bb6aa1
@Service("userService")
public class UserServiceImpl extends EgovAbstractServiceImpl implements UserService {

    @Resource(name = "userMapper")
    private UserMapper userMapper;

    @Override
    public UserVO actionLogin(UserVO vo) throws Exception {
        return userMapper.actionLogin(vo);
    }

<<<<<<< HEAD
    @Override
    public void insertUser(MemberVO vo) throws Exception {
        userMapper.insertUser(vo);
    }

    @Override
    public boolean checkIdExists(String memberId) throws Exception {
        int cnt = userMapper.countById(memberId);
        return cnt > 0;
    }
}
=======
    /**
     * 인터페이스에서 선언한 insertUser를 실제로 구현
     */
    @Override
    public void insertUser(MemberVO vo) throws Exception {
        // 듬직하게 매퍼를 호출하여 DB에 데이터를 전달합니다.
        userMapper.insertUser(vo); 
    }
}
>>>>>>> c35c9fa3da37ff3babc985bb0c77426861bb6aa1
