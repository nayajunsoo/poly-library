package egovframework.example.book.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import egovframework.example.book.service.BookVO;

@Repository("bookDAO")
public class BookDAO {

    @Resource(name = "egov.sqlSessionTemplate")
    private SqlSessionTemplate sqlSession;

    private static final String NAMESPACE = "egovframework.example.book.";

    public List<BookVO> selectBookList() throws Exception {
        return sqlSession.selectList(NAMESPACE + "selectBookList");
    }

    public BookVO selectBook(int bookId) throws Exception {
        return sqlSession.selectOne(NAMESPACE + "selectBook", bookId);
    }

    public void insertBook(BookVO bookVO) throws Exception {
        sqlSession.insert(NAMESPACE + "insertBook", bookVO);
    }

    public void updateBook(BookVO bookVO) throws Exception {
        sqlSession.update(NAMESPACE + "updateBook", bookVO);
    }

    public void deleteBook(int bookId) throws Exception {
        sqlSession.delete(NAMESPACE + "deleteBook", bookId);
    }
}