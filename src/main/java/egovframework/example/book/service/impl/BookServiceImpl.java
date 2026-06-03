package egovframework.example.book.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import egovframework.example.book.service.BookService;
import egovframework.example.book.service.BookVO;

@Service("bookService")
public class BookServiceImpl implements BookService {

    @Resource(name = "bookDAO")
    private BookDAO bookDAO;

    @Override public List<BookVO> selectBookList() throws Exception { return bookDAO.selectBookList(); }
    @Override public BookVO selectBook(int bookId) throws Exception { return bookDAO.selectBook(bookId); }
    @Override public void insertBook(BookVO bookVO) throws Exception { bookDAO.insertBook(bookVO); }
    @Override public void updateBook(BookVO bookVO) throws Exception { bookDAO.updateBook(bookVO); }
    @Override public void deleteBook(int bookId) throws Exception { bookDAO.deleteBook(bookId); }
    @Override public List<BookVO> searchBookList(String searchType, String keyword) throws Exception {
        return bookDAO.searchBookList(searchType, keyword);
    }
    @Override public List<BookVO> selectBookListPaged(Map<String, Object> param) throws Exception {
        return bookDAO.selectBookListPaged(param);
    }
    @Override public int selectBookCount(Map<String, Object> param) throws Exception {
        return bookDAO.selectBookCount(param);
    }
}
