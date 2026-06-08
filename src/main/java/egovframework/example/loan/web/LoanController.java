package egovframework.example.loan.web;

import java.io.InputStream;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Scanner;

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

    @RequestMapping(value = "/loan/aiRecommend.do", method = RequestMethod.GET)
    @ResponseBody
    public String aiRecommend(@RequestParam String category, HttpSession session) throws Exception {
        UserVO loginVO = (UserVO) session.getAttribute("loginVO");
        if (loginVO == null) return "{\"error\":\"로그인이 필요합니다.\"}";

        String apiKey = "AQ.Ab8RN6LY51FcibAu13sJjnJNE__cZtMFK2eImaiexaQQrMWUYg";
        String prompt = category + " 카테고리의 한국 독자에게 인기 있는 도서 5권을 추천해주세요. "
                + "반드시 아래 JSON 배열 형식으로만 응답하고 다른 텍스트는 포함하지 마세요.\n"
                + "[\"제목1\", \"제목2\", \"제목3\", \"제목4\", \"제목5\"]";

        try {
            String geminiJson = callGeminiApi(prompt, apiKey);
            List<String> titles = parseGeminiTitles(geminiJson);

            List<Map<String, Object>> result = new ArrayList<>();
            for (String title : titles) {
                Map<String, Object> item = new LinkedHashMap<>();
                item.put("aiTitle", title);
                BookVO book = loanService.findBookByTitle(title);
                if (book != null && "Y".equals(book.getStatus())) {
                    item.put("available", true);
                    item.put("bookId", book.getBookId());
                    item.put("title", book.getTitle());
                    item.put("author", book.getAuthor());
                    item.put("publisher", book.getPublisher());
                } else {
                    item.put("available", false);
                    item.put("title", title);
                    item.put("author", book != null ? book.getAuthor() : null);
                    item.put("publisher", book != null ? book.getPublisher() : null);
                }
                result.add(item);
            }
            return mapper.writeValueAsString(result);
        } catch (Exception e) {
            Map<String, Object> err = new LinkedHashMap<>();
            err.put("error", e.getMessage());
            return mapper.writeValueAsString(err);
        }
    }

    private String callGeminiApi(String prompt, String apiKey) throws Exception {
        URL url = new URL("https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent?key=" + apiKey);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("POST");
        conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
        conn.setDoOutput(true);
        conn.setConnectTimeout(10000);
        conn.setReadTimeout(30000);

        String body = "{\"contents\":[{\"parts\":[{\"text\":" + mapper.writeValueAsString(prompt) + "}]}]}";
        try (OutputStream os = conn.getOutputStream()) {
            os.write(body.getBytes("UTF-8"));
        }

        int code = conn.getResponseCode();
        InputStream is = code == 200 ? conn.getInputStream() : conn.getErrorStream();
        try (Scanner scanner = new Scanner(is, "UTF-8")) {
            scanner.useDelimiter("\\A");
            String response = scanner.hasNext() ? scanner.next() : "";
            conn.disconnect();
            if (code != 200) throw new Exception("Gemini API 오류 (" + code + "): " + response);
            return response;
        }
    }

    @SuppressWarnings("unchecked")
    private List<String> parseGeminiTitles(String geminiJson) throws Exception {
        Map<String, Object> resp = mapper.readValue(geminiJson, Map.class);
        List<Map<String, Object>> candidates = (List<Map<String, Object>>) resp.get("candidates");
        Map<String, Object> content = (Map<String, Object>) candidates.get(0).get("content");
        List<Map<String, Object>> parts = (List<Map<String, Object>>) content.get("parts");
        String text = ((String) parts.get(0).get("text")).trim();

        // 마크다운 코드블록 제거
        text = text.replaceAll("```json\\s*", "").replaceAll("```\\s*", "").trim();

        int start = text.indexOf('[');
        int end = text.lastIndexOf(']');
        if (start < 0 || end < 0) throw new Exception("Gemini 응답에서 제목 목록을 파싱할 수 없습니다.");
        return mapper.readValue(text.substring(start, end + 1), List.class);
    }

    private String encode(String msg) {
        try { return java.net.URLEncoder.encode(msg, "UTF-8"); }
        catch (Exception e) { return msg; }
    }
}
