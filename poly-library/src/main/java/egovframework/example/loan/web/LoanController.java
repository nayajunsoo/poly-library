package egovframework.example.loan.web;

import java.time.LocalDate;
import java.util.List;

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

@Controller
public class LoanController {

    @Resource(name = "loanService")
    private LoanService loanService;

    private final ObjectMapper mapper = new ObjectMapper();

    /**
     * 도서 검색 AJAX  →  JSON 반환
     * GET /loan/searchBook.do?searchType=title&keyword=노인
     */
    @RequestMapping("/loan/searchBook.do")
    @ResponseBody
    public String searchBook(
            @RequestParam(defaultValue = "title") String searchType,
            @RequestParam(defaultValue = "") String keyword) throws Exception {
        List<BookVO> list = loanService.searchBook(searchType, keyword);
        return mapper.writeValueAsString(list);
    }

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
    }
}
