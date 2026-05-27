package egovframework.example.user.service.impl;

import javax.annotation.Resource;
import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import egovframework.example.member.service.MemberVO;
import egovframework.example.user.service.UserService;
import egovframework.example.user.service.UserVO;

@Service("userService")
public class UserServiceImpl extends EgovAbstractServiceImpl implements UserService {

    @Resource(name = "userMapper")
    private UserMapper userMapper;

    @Override
    public UserVO actionLogin(UserVO vo) throws Exception {
        return userMapper.actionLogin(vo);
    }

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
