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

import egovframework.example.member.service.MemberVO;
import egovframework.example.user.service.UserService;
import egovframework.example.user.service.UserVO;

@Controller
public class UserController {

    @Resource(name = "userService")
    private UserService userService;

    @RequestMapping(value = "/user/loginView.do")
    public String loginView(@RequestParam(defaultValue = "") String returnUrl, Model model) {
        model.addAttribute("returnUrl", returnUrl);
        return "user/login";
    }

    @RequestMapping(value = "/user/login.do", method = RequestMethod.POST)
    public String login(UserVO userVO,
                        @RequestParam(defaultValue = "") String returnUrl,
                        HttpServletRequest request, Model model) throws Exception {
        UserVO resultVO = userService.actionLogin(userVO);
        if (resultVO != null && resultVO.getUserId() != null) {
            request.getSession().setAttribute("loginVO", resultVO);
            if (returnUrl != null && !returnUrl.isEmpty()) {
                return "redirect:" + returnUrl;
            }
            // ADMIN이면 어드민 메인으로, USER면 도서목록으로
            if ("ADMIN".equals(resultVO.getRole())) {
                return "redirect:/admin/adminMain.do";
            }
            return "redirect:/book/bookList.do";
        } else {
            model.addAttribute("msg", "아이디 또는 비밀번호가 일치하지 않습니다.");
            model.addAttribute("returnUrl", returnUrl);
            return "user/login";
        }
    }

    @RequestMapping(value = "/user/joinView.do")
    public String joinView(@RequestParam(defaultValue = "") String returnUrl, Model model) {
        model.addAttribute("returnUrl", returnUrl);
        return "user/join";
    }

    @RequestMapping(value = "/user/checkId.do")
    @ResponseBody
    public String checkId(@RequestParam String memberId) throws Exception {
        boolean exists = userService.checkIdExists(memberId);
        return exists ? "DUPLICATE" : "AVAILABLE";
    }

    @RequestMapping(value = "/user/insertUser.do", method = RequestMethod.POST)
    public String insertUser(MemberVO memberVO,
                             @RequestParam(defaultValue = "") String returnUrl,
                             Model model) throws Exception {
        memberVO.setRole("USER");
        try {
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

    @RequestMapping(value = "/user/logout.do")
    public String logout(HttpServletRequest request) {
        request.getSession().invalidate();
        return "redirect:/book/bookList.do";
    }
}
