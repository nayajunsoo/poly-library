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

    private static final String NS = "egovframework.example.book.";

    public List<BookVO> selectBookList() throws Exception {
        return sqlSession.selectList(NS + "selectBookList");
    }
    public BookVO selectBook(int bookId) throws Exception {
        return sqlSession.selectOne(NS + "selectBook", bookId);
    }
    public void insertBook(BookVO bookVO) throws Exception {
        sqlSession.insert(NS + "insertBook", bookVO);
    }
    public void updateBook(BookVO bookVO) throws Exception {
        sqlSession.update(NS + "updateBook", bookVO);
    }
    public void deleteBook(int bookId) throws Exception {
        sqlSession.delete(NS + "deleteBook", bookId);
    }
    public List<BookVO> searchBookList(String searchType, String keyword) throws Exception {
        Map<String, String> params = new HashMap<>();
        params.put("searchType", searchType);
        params.put("keyword", keyword);
        return sqlSession.selectList(NS + "searchBookList", params);
    }
    public List<BookVO> selectBookListPaged(Map<String, Object> param) throws Exception {
        return sqlSession.selectList(NS + "selectBookListPaged", param);
    }
    public int selectBookCount(Map<String, Object> param) throws Exception {
        return sqlSession.selectOne(NS + "selectBookCount", param);
    }
}
