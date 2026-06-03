package egovframework.example.common.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class CommonController {
    @RequestMapping("/common/accessDenied.do")
    public String accessDenied() {
        return "common/accessDenied";
    }
}
