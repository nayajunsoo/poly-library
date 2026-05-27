package egovframework.example.user.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

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

    /** 로그인 처리 - 로그인 후 대출 페이지로 돌아가는 returnUrl 처리 */
    @RequestMapping(value = "/user/login.do", method = RequestMethod.POST)
    public String login(UserVO userVO,
                        @RequestParam(defaultValue = "") String returnUrl,
                        HttpServletRequest request,
                        Model model) throws Exception {
        UserVO resultVO = userService.actionLogin(userVO);
        if (resultVO != null && resultVO.getUserId() != null) {
            HttpSession session = request.getSession();
            session.setAttribute("loginVO", resultVO);
            // 로그인 후 returnUrl 이 있으면 해당 경로로, 없으면 도서목록으로
            if (returnUrl != null && !returnUrl.isEmpty()) {
                return "redirect:" + returnUrl;
            }
            return "redirect:/book/bookList.do";
        } else {
            model.addAttribute("msg", "아이디 또는 비밀번호가 일치하지 않습니다.");
            model.addAttribute("returnUrl", returnUrl);
            return "user/login";
        }
    }

    /** 회원가입 화면 */
    @RequestMapping(value = "/user/joinView.do")
    public String joinView(@RequestParam(defaultValue = "") String returnUrl, Model model) {
        model.addAttribute("returnUrl", returnUrl);
        return "user/join";
    }

    /** 아이디 중복 체크 AJAX - GET /user/checkId.do?memberId=xxx */
    @RequestMapping(value = "/user/checkId.do")
    @ResponseBody
    public String checkId(@RequestParam String memberId) throws Exception {
        boolean exists = userService.checkIdExists(memberId);
        return exists ? "DUPLICATE" : "AVAILABLE";
    }

    /** 회원가입 처리 */
    @RequestMapping(value = "/user/insertUser.do", method = RequestMethod.POST)
    public String insertUser(MemberVO memberVO,
                             @RequestParam(defaultValue = "") String returnUrl,
                             Model model) throws Exception {
        memberVO.setRole("USER");
        try {
            // 중복 체크 재확인
            if (userService.checkIdExists(memberVO.getMemberId())) {
                model.addAttribute("msg", "이미 사용 중인 아이디입니다.");
                model.addAttribute("returnUrl", returnUrl);
                return "user/join";
            }
            userService.insertUser(memberVO);
            model.addAttribute("msg", "회원가입이 완료되었습니다. 로그인해 주세요.");
            model.addAttribute("returnUrl", returnUrl);
            return "user/login";
        } catch (Exception e) {
            model.addAttribute("msg", "오류가 발생했습니다: " + e.getMessage());
            model.addAttribute("returnUrl", returnUrl);
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
