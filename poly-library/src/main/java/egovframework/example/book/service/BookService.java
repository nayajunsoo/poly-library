package egovframework.example.book.service;

import java.util.List;

public interface BookService {

    // 도서 목록 조회
    List<BookVO> selectBookList() throws Exception;

    // 도서 상세 조회
    BookVO selectBook(int bookId) throws Exception;

    // 도서 등록
    void insertBook(BookVO bookVO) throws Exception;

    // 도서 수정
    void updateBook(BookVO bookVO) throws Exception;

    // 도서 삭제
    void deleteBook(int bookId) throws Exception;

    // 도서 검색
    List<BookVO> searchBookList(String searchType, String keyword) throws Exception;
}