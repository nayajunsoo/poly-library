package egovframework.example.admin.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.example.loan.service.LoanService;
import egovframework.example.user.service.UserService;
import egovframework.example.user.service.UserVO;

@Controller
public class AdminController {

    @Resource(name = "loanService")
    private LoanService loanService;

    @Resource(name = "userService")
    private UserService userService;

    // 어드민 메인 - 반납대기 목록
    @RequestMapping("/admin/adminMain.do")
    public String adminMain(Model model, HttpSession session) {
        UserVO loginVO = (UserVO) session.getAttribute("loginVO");
        if (loginVO == null) return "redirect:/user/loginView.do";
        if (!"ADMIN".equals(loginVO.getRole())) return "redirect:/common/accessDenied.do";
        try {
            model.addAttribute("pendingList", loanService.selectPendingReturnList());
            model.addAttribute("allLoanList", loanService.selectAllLoanList());
        } catch (Exception e) {
            model.addAttribute("pendingList", new java.util.ArrayList<>());
            model.addAttribute("allLoanList", new java.util.ArrayList<>());
        }
        return "admin/adminMain";
    }

    // 반납 승인 처리
    @RequestMapping(value = "/admin/approveReturn.do", method = RequestMethod.POST)
    public String approveReturn(@RequestParam int loanId, @RequestParam int bookId) {
        try { loanService.approveReturn(loanId, bookId); } catch (Exception e) {}
        return "redirect:/admin/adminMain.do";
    }

    // 유저 목록 조회
    @RequestMapping("/admin/userList.do")
    public String userList(Model model) {
        try {
            model.addAttribute("userList", userService.selectAllUsers());
        } catch (Exception e) {
            model.addAttribute("userList", new java.util.ArrayList<>());
        }
        return "admin/userList";
    }

    // 유저 권한 변경 (AJAX)
    @RequestMapping(value = "/admin/updateRole.do", method = RequestMethod.POST)
    @ResponseBody
    public String updateRole(@RequestParam String memberId, @RequestParam String role) {
        try {
            Map<String, String> param = new HashMap<>();
            param.put("memberId", memberId);
            param.put("role", role);
            userService.updateUserRole(param);
            return "OK";
        } catch (Exception e) {
            return "ERROR";
        }
    }
}
