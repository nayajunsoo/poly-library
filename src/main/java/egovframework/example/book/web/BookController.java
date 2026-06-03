package egovframework.example.book.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import egovframework.example.book.service.BookService;
import egovframework.example.book.service.BookVO;
import egovframework.example.loan.service.LoanService;

@Controller
public class BookController {

    @Resource(name = "bookService")
    private BookService bookService;

    @Resource(name = "loanService")
    private LoanService loanService;

    private static final int PAGE_SIZE = 50;

    // 도서 목록 (페이지네이션 + 필터)
    @RequestMapping("/book/bookList.do")
    public String bookList(
            @RequestParam(defaultValue = "") String keyword,
            @RequestParam(defaultValue = "title") String searchType,
            @RequestParam(defaultValue = "") String category,
            @RequestParam(defaultValue = "") String initial,
            @RequestParam(defaultValue = "") String statusFilter,
            @RequestParam(defaultValue = "title") String sortType,
            @RequestParam(defaultValue = "1") int page,
            ModelMap model) throws Exception {

        Map<String, Object> param = new HashMap<>();
        param.put("keyword", keyword);
        param.put("searchType", searchType);
        param.put("category", category);
        param.put("initial", initial);
        param.put("statusFilter", statusFilter);
        param.put("sortType", sortType);
        param.put("pageSize", PAGE_SIZE);
        param.put("offset", (page - 1) * PAGE_SIZE);

        int totalCount = bookService.selectBookCount(param);
        int totalPages = (int) Math.ceil((double) totalCount / PAGE_SIZE);

        model.addAttribute("bookList", bookService.selectBookListPaged(param));
        model.addAttribute("totalCount", totalCount);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("currentPage", page);
        model.addAttribute("keyword", keyword);
        model.addAttribute("searchType", searchType);
        model.addAttribute("category", category);
        model.addAttribute("initial", initial);
        model.addAttribute("statusFilter", statusFilter);
        model.addAttribute("sortType", sortType);

        // 카테고리별 도서 수
        List<BookVO> allBooks = bookService.selectBookList();
        Map<String, Integer> catCount = new HashMap<>();
        for (BookVO b : allBooks) {
            String cat = b.getCategory() == null ? "기타" : b.getCategory();
            catCount.merge(cat, 1, Integer::sum);
        }
        model.addAttribute("catCount", catCount);
        model.addAttribute("totalBookCount", allBooks.size());

        return "book/bookList";
    }

    // 도서 상세
    @RequestMapping("/book/bookDetail.do")
    public String bookDetail(@RequestParam int bookId, ModelMap model) throws Exception {
        model.addAttribute("book", bookService.selectBook(bookId));
        return "book/bookDetail";
    }

    // 도서 등록 화면
    @RequestMapping("/book/bookRegisterView.do")
    public String bookRegisterView() { return "book/bookRegister"; }

    // 도서 등록 처리
    @RequestMapping("/book/bookRegister.do")
    public String bookRegister(BookVO bookVO) throws Exception {
        bookVO.setStatus("Y");
        bookService.insertBook(bookVO);
        return "redirect:/book/bookList.do";
    }

    // 도서 수정 화면
    @RequestMapping("/book/bookModifyView.do")
    public String bookModifyView(@RequestParam int bookId, ModelMap model) throws Exception {
        model.addAttribute("book", bookService.selectBook(bookId));
        return "book/bookModify";
    }

    // 도서 수정 처리
    @RequestMapping("/book/bookModify.do")
    public String bookModify(BookVO bookVO) throws Exception {
        bookService.updateBook(bookVO);
        return "redirect:/book/bookList.do";
    }

    // 도서 삭제
    @RequestMapping("/book/bookDelete.do")
    public String bookDelete(@RequestParam int bookId) throws Exception {
        bookService.deleteBook(bookId);
        return "redirect:/book/bookList.do";
    }
}
