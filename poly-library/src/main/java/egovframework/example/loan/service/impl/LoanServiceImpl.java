package egovframework.example.loan.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;

import egovframework.example.book.service.BookVO;
import egovframework.example.loan.service.LoanService;
import egovframework.example.loan.service.LoanVO;
import egovframework.example.member.service.MemberVO;

@Service("loanService")
public class LoanServiceImpl implements LoanService {

    @Resource(name = "egov.sqlSessionTemplate")
    private SqlSession sqlSession;

    private static final String NAMESPACE_LOAN = "egovframework.example.loan.";
    private static final String NAMESPACE_BOOK = "egovframework.example.book.";

    @Override
    public List<BookVO> searchBook(String searchType, String keyword) throws Exception {
        java.util.Map<String, String> param = new java.util.HashMap<>();
        param.put("searchType", searchType);
        param.put("keyword", keyword);
        return sqlSession.selectList(NAMESPACE_BOOK + "searchBookList", param);
    }

    @Override
    public List<MemberVO> searchMember(String searchType, String keyword) throws Exception {
        java.util.Map<String, String> param = new java.util.HashMap<>();
        param.put("searchType", searchType);
        param.put("keyword", keyword);
        return sqlSession.selectList(NAMESPACE_LOAN + "searchMember", param);
    }

    @Override
    public void insertLoan(LoanVO loanVO) throws Exception {
        // 1. 대출 이력 INSERT
        sqlSession.insert(NAMESPACE_LOAN + "insertLoan", loanVO);
        // 2. 도서 상태 → 대출중(N)
        sqlSession.update(NAMESPACE_BOOK + "updateBookStatus",
            new java.util.HashMap<String,Object>(){{ put("bookId", loanVO.getBookId()); put("status","N"); }});
    }

    @Override
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> selectLoanList() throws Exception {
        return sqlSession.selectList(NAMESPACE_LOAN + "selectLoanList");
    }
}
