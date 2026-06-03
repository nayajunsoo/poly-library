package egovframework.example.user.service.impl;

import java.util.List;
import java.util.Map;
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
        return userMapper.countById(memberId) > 0;
    }

    @Override
    public List<MemberVO> selectAllUsers() throws Exception {
        return userMapper.selectAllUsers();
    }

    @Override
    public void updateUserRole(Map<String, String> param) throws Exception {
        userMapper.updateUserRole(param);
    }
}
