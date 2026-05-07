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
import egovframework.example.member.service.MemberVO; // 회원가입용 VO 임포트

@Controller
public class UserController {

    @Resource(name = "userService")
    private UserService userService;

    /**
     * 로그인 화면을 띄운다.
     */
    @RequestMapping(value = "/user/loginView.do")
    public String loginView() {
        return "user/login"; // WEB-INF/jsp/user/login.jsp
    }

    /**
     * 실제 로그인을 처리한다.
     */
    @RequestMapping(value = "/user/login.do", method = RequestMethod.POST)
    public String login(UserVO userVO, HttpServletRequest request, Model model) throws Exception {
        
        // DB에서 회원 정보 조회
        UserVO resultVO = userService.actionLogin(userVO);
        
        if (resultVO != null && resultVO.getUserId() != null) {
            // 로그인 성공 시 세션 생성
            HttpSession session = request.getSession();
            session.setAttribute("loginVO", resultVO); 
            
            // 메인 화면(도서 목록)으로 리다이렉트
            return "redirect:/book/bookList.do";
        } else {
            // 로그인 실패 시 메시지와 함께 다시 로그인창으로
            model.addAttribute("msg", "아이디 또는 비밀번호가 일치하지 않습니다.");
            return "user/login";
        }       
    }

    /**
     * 회원가입 화면을 띄운다. (새로 추가)
     */
    @RequestMapping(value = "/user/joinView.do")
    public String joinView() {
        return "user/join"; // WEB-INF/jsp/user/join.jsp
    }

    /**
     * 회원가입 처리를 한다. (새로 추가)
     */
    @RequestMapping(value = "/user/insertUser.do", method = RequestMethod.POST)
    public String insertUser(MemberVO memberVO, Model model) throws Exception {
        memberVO.setRole("USER");
        try {
            userService.insertUser(memberVO);
            // 여기서 담은 메시지가 login.jsp의 alert(msg)로 전달됩니다!
            model.addAttribute("msg", "회원가입이 완료되었습니다. 로그인해 주세요.");
            return "user/login"; 
        } catch (Exception e) {
            model.addAttribute("msg", "오류가 발생했습니다.");
            return "user/join"; 
        }
    }

    /**
     * 로그아웃 처리
     */
    @RequestMapping(value = "/user/logout.do")
    public String logout(HttpServletRequest request) {
        HttpSession session = request.getSession();
        session.invalidate(); // 세션 완전 초기화
        return "redirect:/book/bookList.do";
    }
}