package egovframework.example.book.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import egovframework.example.book.service.BookVO;

@Repository("bookDAO")
public class BookDAO {

    @Resource(name = "egov.sqlSessionTemplate")
    private SqlSessionTemplate sqlSession;

    private static final String NAMESPACE = "egovframework.example.book.";

    // 도서 목록 조회
    public List<BookVO> selectBookList() throws Exception {
        return sqlSession.selectList(NAMESPACE + "selectBookList");
    }

    // 도서 상세 조회
    public BookVO selectBook(int bookId) throws Exception {
        return sqlSession.selectOne(NAMESPACE + "selectBook", bookId);
    }

    // 도서 등록
    public void insertBook(BookVO bookVO) throws Exception {
        sqlSession.insert(NAMESPACE + "insertBook", bookVO);
    }

    // 도서 수정
    public void updateBook(BookVO bookVO) throws Exception {
        sqlSession.update(NAMESPACE + "updateBook", bookVO);
    }

    // 도서 삭제
    public void deleteBook(int bookId) throws Exception {
        sqlSession.delete(NAMESPACE + "deleteBook", bookId);
    }

    // 도서 검색
    public List<BookVO> searchBookList(String searchType, String keyword) throws Exception {
        Map<String, String> params = new HashMap<>();
        params.put("searchType", searchType);
        params.put("keyword", keyword);
        return sqlSession.selectList(NAMESPACE + "searchBookList", params);
    }
}