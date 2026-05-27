package egovframework.example.book.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.example.book.service.BookService;
import egovframework.example.book.service.BookVO;

@Service("bookService")
public class BookServiceImpl implements BookService {

    @Resource(name = "bookDAO")
    private BookDAO bookDAO;

    // 도서 목록 조회
    @Override
    public List<BookVO> selectBookList() throws Exception {
        return bookDAO.selectBookList();
    }

    // 도서 상세 조회
    @Override
    public BookVO selectBook(int bookId) throws Exception {
        return bookDAO.selectBook(bookId);
    }

    // 도서 등록
    @Override
    public void insertBook(BookVO bookVO) throws Exception {
        bookDAO.insertBook(bookVO);
    }

    // 도서 수정
    @Override
    public void updateBook(BookVO bookVO) throws Exception {
        bookDAO.updateBook(bookVO);
    }

    // 도서 삭제
    @Override
    public void deleteBook(int bookId) throws Exception {
        bookDAO.deleteBook(bookId);
    }

    // 도서 검색
    @Override
    public List<BookVO> searchBookList(String searchType, String keyword) throws Exception {
        return bookDAO.searchBookList(searchType, keyword);
    }
}