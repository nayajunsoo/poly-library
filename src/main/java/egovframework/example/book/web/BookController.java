package egovframework.example.book.web;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import egovframework.example.book.service.BookService;
import egovframework.example.book.service.BookVO;

@Controller
public class BookController {

    @Resource(name = "bookService")
    private BookService bookService;

    // 도서 목록
    @RequestMapping("/book/bookList.do")
    public String bookList(ModelMap model) throws Exception {
        List<BookVO> bookList = bookService.selectBookList();
        model.addAttribute("bookList", bookList);
        return "book/bookList";
    }

    // 도서 상세
    @RequestMapping("/book/bookDetail.do")
    public String bookDetail(@RequestParam int bookId, ModelMap model) throws Exception {
        BookVO book = bookService.selectBook(bookId);
        model.addAttribute("book", book);
        return "book/bookDetail";
    }

    // 도서 등록 화면
    @RequestMapping("/book/bookRegisterView.do")
    public String bookRegisterView() throws Exception {
        return "book/bookRegister";
    }

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
        BookVO book = bookService.selectBook(bookId);
        model.addAttribute("book", book);
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