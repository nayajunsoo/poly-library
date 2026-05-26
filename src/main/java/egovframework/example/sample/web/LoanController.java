package egovframework.example.sample.web;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import egovframework.example.loan.service.LoanVO;
import egovframework.example.loan.service.impl.LoanMapper;

@Controller
public class LoanController {

    @Resource(name = "loanMapper")
    private LoanMapper loanMapper;

    @RequestMapping(value = "/loanList.do")
    public String selectLoanList(
            @RequestParam(value = "userId", defaultValue = "user01") String userId,
            ModelMap model) throws Exception {
        List<LoanVO> loanList = loanMapper.selectLoanList(userId);
        model.addAttribute("loanList", loanList);
        model.addAttribute("userId", userId);
        return "egovframework/example/sample/bookList";
    }

    @RequestMapping(value = "/loanInsert.do")
    public String insertLoan(LoanVO loanVO) throws Exception {
        loanMapper.insertLoan(loanVO);
        return "redirect:/loanList.do?userId=" + loanVO.getUserId();
    }

    @RequestMapping(value = "/loanReturn.do")
    public String updateReturn(LoanVO loanVO) throws Exception {
        loanMapper.updateReturn(loanVO);
        return "redirect:/loanList.do?userId=" + loanVO.getUserId();
    }

    @RequestMapping(value = "/adminLoanList.do")
    public String selectAllLoanList(ModelMap model) throws Exception {
        List<LoanVO> loanList = loanMapper.selectAllLoanList();
        model.addAttribute("loanList", loanList);
        return "egovframework/example/sample/adminLoanList";
    }

    @RequestMapping(value = "/updateOverdue.do")
    public String updateOverdue(ModelMap model) throws Exception {
        int count = loanMapper.updateOverdue();
        model.addAttribute("overdueCount", count);
        return "redirect:/adminLoanList.do";
    }
}