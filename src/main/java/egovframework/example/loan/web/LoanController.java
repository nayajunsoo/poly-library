package egovframework.example.loan.web;

import java.time.LocalDate;
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

import com.fasterxml.jackson.databind.ObjectMapper;

import egovframework.example.book.service.BookVO;
import egovframework.example.loan.service.LoanService;
import egovframework.example.loan.service.LoanVO;
import egovframework.example.user.service.UserVO;

@Controller
public class LoanController {

    @Resource(name = "loanService")
    private LoanService loanService;

    private final ObjectMapper mapper = new ObjectMapper();

    @RequestMapping("/loan/searchBook.do")
    @ResponseBody
    public String searchBook(
            @RequestParam(defaultValue = "title") String searchType,
            @RequestParam(defaultValue = "") String keyword) throws Exception {
        List<BookVO> list = loanService.searchBook(searchType, keyword);
        return mapper.writeValueAsString(list);
    }

    @RequestMapping(value = "/loan/loanApply.do", method = RequestMethod.POST)
    public String loanApply(@RequestParam int bookId, @RequestParam String memberId, HttpSession session) {
        UserVO loginVO = (UserVO) session.getAttribute("loginVO");
        if (loginVO == null) return "redirect:/user/loginView.do?returnUrl=/book/bookList.do";
        try {
            LoanVO vo = new LoanVO();
            vo.setBookId(bookId); vo.setMemberId(memberId);
            vo.setLoanDate(LocalDate.now().toString()); vo.setStatus("ACTIVE");
            loanService.insertLoan(vo);
            return "redirect:/book/bookList.do?msg=" + encode("대출이 완료되었습니다.");
        } catch (Exception e) {
            return "redirect:/book/bookList.do?msg=" + encode(e.getMessage());
        }
    }

    @RequestMapping(value = "/loan/loanApplyMulti.do", method = RequestMethod.POST)
    public String loanApplyMulti(
            @RequestParam(value = "bookIds") int[] bookIds,
            @RequestParam String memberId, HttpSession session) {
        UserVO loginVO = (UserVO) session.getAttribute("loginVO");
        if (loginVO == null) return "redirect:/user/loginView.do?returnUrl=/book/bookList.do";
        int success = 0;
        StringBuilder err = new StringBuilder();
        for (int bookId : bookIds) {
            try {
                LoanVO vo = new LoanVO();
                vo.setBookId(bookId); vo.setMemberId(memberId);
                vo.setLoanDate(LocalDate.now().toString()); vo.setStatus("ACTIVE");
                loanService.insertLoan(vo);
                success++;
            } catch (Exception e) {
                if (err.length() > 0) err.append(", ");
                err.append(e.getMessage());
            }
        }
        String msg = err.length() == 0 ? success + "권 대출이 완료되었습니다." : success + "권 완료. 오류: " + err;
        return "redirect:/book/bookList.do?msg=" + encode(msg);
    }

    // 반납 요청 (유저) - PENDING으로 상태 변경
    @RequestMapping(value = "/loan/requestReturn.do", method = RequestMethod.POST)
    public String requestReturn(@RequestParam int loanId, HttpSession session) {
        UserVO loginVO = (UserVO) session.getAttribute("loginVO");
        if (loginVO == null) return "redirect:/user/loginView.do";
        try { loanService.requestReturn(loanId); } catch (Exception e) {}
        return "redirect:/loan/myLoan.do?msg=" + encode("반납 요청이 완료되었습니다. 관리자 승인 후 반납처리됩니다.");
    }

    @RequestMapping("/loan/myLoan.do")
    public String myLoan(HttpSession session, Model model,
                         @RequestParam(defaultValue = "") String msg) {
        UserVO loginVO = (UserVO) session.getAttribute("loginVO");
        if (loginVO == null) return "redirect:/user/loginView.do?returnUrl=/loan/myLoan.do";
        try {
            model.addAttribute("loanList", loanService.selectMyLoanList(loginVO.getUserId()));
        } catch (Exception e) {
            model.addAttribute("loanList", new java.util.ArrayList<>());
        }
        if (!msg.isEmpty()) model.addAttribute("msg", msg);
        return "loan/myLoan";
    }

    @RequestMapping("/loan/myLoanSummary.do")
    @ResponseBody
    public String myLoanSummary(HttpSession session) throws Exception {
        UserVO loginVO = (UserVO) session.getAttribute("loginVO");
        if (loginVO == null) return "[]";
        return mapper.writeValueAsString(loanService.selectMyLoanSummary(loginVO.getUserId()));
    }

    private String encode(String msg) {
        try { return java.net.URLEncoder.encode(msg, "UTF-8"); }
        catch (Exception e) { return msg; }
    }
}
