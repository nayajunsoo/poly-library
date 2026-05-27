package egovframework.example.loan.web;

import java.time.LocalDate;
import java.util.List;
<<<<<<< HEAD
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
=======

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.example.book.service.BookVO;
import egovframework.example.loan.service.LoanService;
import egovframework.example.loan.service.LoanVO;
import egovframework.example.member.service.MemberVO;

import com.fasterxml.jackson.databind.ObjectMapper;
>>>>>>> c35c9fa3da37ff3babc985bb0c77426861bb6aa1

@Controller
public class LoanController {

    @Resource(name = "loanService")
    private LoanService loanService;

    private final ObjectMapper mapper = new ObjectMapper();

<<<<<<< HEAD
    /** 도서 검색 AJAX */
=======
    /**
     * 도서 검색 AJAX  →  JSON 반환
     * GET /loan/searchBook.do?searchType=title&keyword=노인
     */
>>>>>>> c35c9fa3da37ff3babc985bb0c77426861bb6aa1
    @RequestMapping("/loan/searchBook.do")
    @ResponseBody
    public String searchBook(
            @RequestParam(defaultValue = "title") String searchType,
            @RequestParam(defaultValue = "") String keyword) throws Exception {
        List<BookVO> list = loanService.searchBook(searchType, keyword);
        return mapper.writeValueAsString(list);
    }

<<<<<<< HEAD
    /** 단건 대출 신청 */
    @RequestMapping(value = "/loan/loanApply.do", method = RequestMethod.POST)
    public String loanApply(
            @RequestParam int bookId,
            @RequestParam String memberId,
            HttpSession session) {
        UserVO loginVO = (UserVO) session.getAttribute("loginVO");
        if(loginVO == null) return "redirect:/user/loginView.do?returnUrl=/book/bookList.do";
        try {
            LoanVO vo = new LoanVO();
            vo.setBookId(bookId);
            vo.setMemberId(memberId);
            vo.setLoanDate(LocalDate.now().toString());
            vo.setStatus("ACTIVE");
            loanService.insertLoan(vo);
            return "redirect:/book/bookList.do?msg=" + encodeMsg("대출이 완료되었습니다.");
        } catch(Exception e) {
            return "redirect:/book/bookList.do?msg=" + encodeMsg(e.getMessage());
        }
    }

    /** 다중 대출 신청 */
    @RequestMapping(value = "/loan/loanApplyMulti.do", method = RequestMethod.POST)
    public String loanApplyMulti(
            @RequestParam(value = "bookIds") int[] bookIds,
            @RequestParam String memberId,
            HttpSession session) {
        UserVO loginVO = (UserVO) session.getAttribute("loginVO");
        if(loginVO == null) return "redirect:/user/loginView.do?returnUrl=/book/bookList.do";

        int success = 0;
        StringBuilder errMsg = new StringBuilder();
        for(int bookId : bookIds) {
            try {
                LoanVO vo = new LoanVO();
                vo.setBookId(bookId);
                vo.setMemberId(memberId);
                vo.setLoanDate(LocalDate.now().toString());
                vo.setStatus("ACTIVE");
                loanService.insertLoan(vo);
                success++;
            } catch(Exception e) {
                if(errMsg.length() > 0) errMsg.append(", ");
                errMsg.append(e.getMessage());
            }
        }

        String msg;
        if(errMsg.length() == 0) {
            msg = success + "권 대출이 완료되었습니다.";
        } else {
            msg = success + "권 완료. 오류: " + errMsg.toString();
        }
        return "redirect:/book/bookList.do?msg=" + encodeMsg(msg);
    }

    /** 반납 처리 */
    @RequestMapping(value = "/loan/returnLoan.do", method = RequestMethod.POST)
    public String returnLoan(
            @RequestParam int loanId,
            @RequestParam int bookId,
            HttpSession session) {
        UserVO loginVO = (UserVO) session.getAttribute("loginVO");
        if(loginVO == null) return "redirect:/user/loginView.do";
        try { loanService.returnLoan(loanId, bookId); } catch(Exception e) { }
        return "redirect:/loan/myLoan.do";
    }

    /** 내 대출 현황 페이지 */
    @RequestMapping("/loan/myLoan.do")
    public String myLoan(HttpSession session, Model model) {
        UserVO loginVO = (UserVO) session.getAttribute("loginVO");
        if(loginVO == null) return "redirect:/user/loginView.do?returnUrl=/loan/myLoan.do";
        try {
            List<Map<String,Object>> loanList = loanService.selectMyLoanList(loginVO.getUserId());
            model.addAttribute("loanList", loanList);
        } catch(Exception e) {
            model.addAttribute("loanList", new java.util.ArrayList<>());
        }
        return "loan/myLoan";
    }

    /** 헤더 드롭다운용 내 대출 요약 AJAX */
    @RequestMapping("/loan/myLoanSummary.do")
    @ResponseBody
    public String myLoanSummary(HttpSession session) throws Exception {
        UserVO loginVO = (UserVO) session.getAttribute("loginVO");
        if(loginVO == null) return "[]";
        List<Map<String,Object>> list = loanService.selectMyLoanSummary(loginVO.getUserId());
        return mapper.writeValueAsString(list);
    }

    private String encodeMsg(String msg) {
        try { return java.net.URLEncoder.encode(msg, "UTF-8"); }
        catch(Exception e) { return msg; }
=======
    /**
     * 회원 검색 AJAX  →  JSON 반환
     * GET /loan/searchMember.do?searchType=name&keyword=박준수
     */
    @RequestMapping("/loan/searchMember.do")
    @ResponseBody
    public String searchMember(
            @RequestParam(defaultValue = "name") String searchType,
            @RequestParam(defaultValue = "") String keyword) throws Exception {
        List<MemberVO> list = loanService.searchMember(searchType, keyword);
        // 보안: password 필드는 null 처리
        for (MemberVO m : list) { m.setPassword(null); }
        return mapper.writeValueAsString(list);
    }

    /**
     * 대출 신청 처리
     * POST /loan/loanApply.do
     */
    @RequestMapping("/loan/loanApply.do")
    public String loanApply(
            @RequestParam int    bookId,
            @RequestParam String memberId) throws Exception {
        LoanVO loanVO = new LoanVO();
        loanVO.setBookId(bookId);
        loanVO.setMemberId(memberId);
        loanVO.setLoanDate(LocalDate.now().toString());
        loanVO.setStatus("ACTIVE");
        loanService.insertLoan(loanVO);
        return "redirect:/book/bookList.do?loanSuccess=true";
>>>>>>> c35c9fa3da37ff3babc985bb0c77426861bb6aa1
    }
}
