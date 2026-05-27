package egovframework.example.user.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import egovframework.example.user.service.UserService;
import egovframework.example.user.service.UserVO;
import egovframework.example.member.service.MemberVO;

@Controller
public class UserController {

    @Resource(name = "userService")
    private UserService userService;

    /** 로그인 화면 */
    @RequestMapping(value = "/user/loginView.do")
    public String loginView() {
        return "user/login";
    }

    /** 로그인 처리 */
    @RequestMapping(value = "/user/login.do", method = RequestMethod.POST)
    public String login(UserVO userVO, HttpServletRequest request, Model model) throws Exception {
        UserVO resultVO = userService.actionLogin(userVO);
        if (resultVO != null && resultVO.getUserId() != null) {
            HttpSession session = request.getSession();
            session.setAttribute("loginVO", resultVO);
            return "redirect:/book/bookList.do";
        } else {
            model.addAttribute("msg", "아이디 또는 비밀번호가 일치하지 않습니다.");
            return "user/login";
        }
    }

    /** 회원가입 화면 */
    @RequestMapping(value = "/user/joinView.do")
    public String joinView() {
        return "user/join";
    }

    /**
     * 회원가입 처리
     * MemberVO 에 phone 필드가 추가되어 폼의 phone 파라미터가 자동 바인딩됨
     */
    @RequestMapping(value = "/user/insertUser.do", method = RequestMethod.POST)
    public String insertUser(MemberVO memberVO, Model model) throws Exception {
        memberVO.setRole("USER");
        try {
            userService.insertUser(memberVO);
            model.addAttribute("msg", "회원가입이 완료되었습니다. 로그인해 주세요.");
            return "user/login";
        } catch (Exception e) {
            model.addAttribute("msg", "오류가 발생했습니다: " + e.getMessage());
            return "user/join";
        }
    }

    /** 로그아웃 */
    @RequestMapping(value = "/user/logout.do")
    public String logout(HttpServletRequest request) {
        request.getSession().invalidate();
        return "redirect:/book/bookList.do";
    }
}
