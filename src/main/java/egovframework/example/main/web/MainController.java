package egovframework.example.main.web;

import java.util.ArrayList;
import javax.annotation.Resource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import egovframework.example.loan.service.LoanService;

@Controller
public class MainController {

    @Resource(name = "loanService")
    private LoanService loanService;

    @RequestMapping({"/", "/main/mainPage.do"})
    public String mainPage(Model model) {
        try {
            model.addAttribute("top30List", loanService.selectMonthlyTop30());
        } catch (Exception e) {
            model.addAttribute("top30List", new ArrayList<>());
        }
        return "main/mainPage";
    }
}
