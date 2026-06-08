package egovframework.example.loan.service.impl;

import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.HashMap;
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

    private static final String NS_LOAN = "egovframework.example.loan.";
    private static final String NS_BOOK = "egovframework.example.book.";

    @Override
    public List<BookVO> searchBook(String searchType, String keyword) throws Exception {
        Map<String, String> param = new HashMap<>();
        param.put("searchType", searchType);
        param.put("keyword", keyword);
        return sqlSession.selectList(NS_BOOK + "searchBookList", param);
    }

    @Override
    public List<MemberVO> searchMember(String searchType, String keyword) throws Exception {
        Map<String, String> param = new HashMap<>();
        param.put("searchType", searchType);
        param.put("keyword", keyword);
        return sqlSession.selectList(NS_LOAN + "searchMember", param);
    }

    @Override
    public boolean isAlreadyLoaned(int bookId, String memberId) throws Exception {
        Map<String, Object> param = new HashMap<>();
        param.put("bookId", bookId);
        param.put("memberId", memberId);
        int cnt = sqlSession.selectOne(NS_LOAN + "countActiveByBookAndMember", param);
        return cnt > 0;
    }

    @Override
    public void insertLoan(LoanVO loanVO) throws Exception {
        if (isAlreadyLoaned(loanVO.getBookId(), loanVO.getMemberId())) {
            throw new Exception("이미 대출 중인 도서입니다.");
        }
        LocalDate loanDate = LocalDate.parse(loanVO.getLoanDate());
        loanVO.setReturnDate(loanDate.plusDays(14).toString());
        sqlSession.insert(NS_LOAN + "insertLoan", loanVO);
        Map<String, Object> p = new HashMap<>();
        p.put("bookId", loanVO.getBookId());
        p.put("status", "N");
        sqlSession.update(NS_BOOK + "updateBookStatus", p);
    }

    @Override
    public List<Map<String, Object>> selectMyLoanList(String memberId) throws Exception {
        List<Map<String, Object>> list = sqlSession.selectList(NS_LOAN + "selectMyLoanList", memberId);
        attachDday(list);
        return list;
    }

    @Override
    public List<Map<String, Object>> selectMyLoanSummary(String memberId) throws Exception {
        List<Map<String, Object>> list = sqlSession.selectList(NS_LOAN + "selectMyLoanSummary", memberId);
        attachDday(list);
        return list;
    }

    @Override
    public void requestReturn(int loanId) throws Exception {
        sqlSession.update(NS_LOAN + "requestReturn", loanId);
    }

    @Override
    public void approveReturn(int loanId, int bookId) throws Exception {
        Map<String, Object> p = new HashMap<>();
        p.put("loanId", loanId);
        p.put("actualReturnDate", LocalDate.now().toString());
        sqlSession.update(NS_LOAN + "approveReturn", p);
        Map<String, Object> bp = new HashMap<>();
        bp.put("bookId", bookId);
        bp.put("status", "Y");
        sqlSession.update(NS_BOOK + "updateBookStatus", bp);
    }

    @Override
    public List<Map<String, Object>> selectPendingReturnList() throws Exception {
        return sqlSession.selectList(NS_LOAN + "selectPendingReturnList");
    }

    @Override
    public List<Map<String, Object>> selectMonthlyTop30() throws Exception {
        return sqlSession.selectList(NS_LOAN + "selectMonthlyTop30");
    }

    @Override
    public List<Map<String, Object>> selectAllLoanList() throws Exception {
        List<Map<String, Object>> list = sqlSession.selectList(NS_LOAN + "selectAllLoanList");
        attachDday(list);
        return list;
    }

    @Override
    public BookVO findBookByTitle(String title) throws Exception {
        return sqlSession.selectOne(NS_BOOK + "selectBookByTitle", title);
    }

    private void attachDday(List<Map<String, Object>> list) {
        LocalDate today = LocalDate.now();
        for (Map<String, Object> row : list) {
            String rd = (String) row.get("returnDate");
            if (rd != null && !rd.isEmpty()) {
                LocalDate returnDate = LocalDate.parse(rd);
                long diff = ChronoUnit.DAYS.between(today, returnDate);
                row.put("dday", diff);
                if (diff > 0) {
                    row.put("ddayLabel", "D-" + diff);
                    row.put("ddayClass", diff <= 3 ? "dday-warn" : "dday-ok");
                } else if (diff == 0) {
                    row.put("ddayLabel", "D-Day");
                    row.put("ddayClass", "dday-warn");
                } else {
                    row.put("ddayLabel", "D+" + Math.abs(diff));
                    row.put("ddayClass", "dday-over");
                }
            }
        }
    }
}
