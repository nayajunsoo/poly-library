package egovframework.example.book.service;

import java.util.List;
import java.util.Map;

public interface BookService {
    List<BookVO> selectBookList() throws Exception;
    BookVO selectBook(int bookId) throws Exception;
    void insertBook(BookVO bookVO) throws Exception;
    void updateBook(BookVO bookVO) throws Exception;
    void deleteBook(int bookId) throws Exception;
    List<BookVO> searchBookList(String searchType, String keyword) throws Exception;
    // 페이지네이션
    List<BookVO> selectBookListPaged(Map<String, Object> param) throws Exception;
    int selectBookCount(Map<String, Object> param) throws Exception;
}
