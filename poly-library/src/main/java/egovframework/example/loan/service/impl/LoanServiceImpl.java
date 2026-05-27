package egovframework.example.loan.service.impl;

<<<<<<< HEAD
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.HashMap;
=======
>>>>>>> c35c9fa3da37ff3babc985bb0c77426861bb6aa1
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

<<<<<<< HEAD
    private static final String NS_LOAN = "egovframework.example.loan.";
    private static final String NS_BOOK = "egovframework.example.book.";

    @Override
    public List<BookVO> searchBook(String searchType, String keyword) throws Exception {
        Map<String, String> param = new HashMap<>();
        param.put("searchType", searchType);
        param.put("keyword", keyword);
        return sqlSession.selectList(NS_BOOK + "searchBookList", param);
=======
    private static final String NAMESPACE_LOAN = "egovframework.example.loan.";
    private static final String NAMESPACE_BOOK = "egovframework.example.book.";

    @Override
    public List<BookVO> searchBook(String searchType, String keyword) throws Exception {
        java.util.Map<String, String> param = new java.util.HashMap<>();
        param.put("searchType", searchType);
        param.put("keyword", keyword);
        return sqlSession.selectList(NAMESPACE_BOOK + "searchBookList", param);
>>>>>>> c35c9fa3da37ff3babc985bb0c77426861bb6aa1
    }

    @Override
    public List<MemberVO> searchMember(String searchType, String keyword) throws Exception {
<<<<<<< HEAD
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
=======
        java.util.Map<String, String> param = new java.util.HashMap<>();
        param.put("searchType", searchType);
        param.put("keyword", keyword);
        return sqlSession.selectList(NAMESPACE_LOAN + "searchMember", param);
>>>>>>> c35c9fa3da37ff3babc985bb0c77426861bb6aa1
    }

    @Override
    public void insertLoan(LoanVO loanVO) throws Exception {
<<<<<<< HEAD
        // 중복 대출 방지
        if (isAlreadyLoaned(loanVO.getBookId(), loanVO.getMemberId())) {
            throw new Exception("이미 대출 중인 도서입니다.");
        }
        // 반납 예정일 = 대출일 + 14일
        LocalDate loanDate = LocalDate.parse(loanVO.getLoanDate());
        loanVO.setReturnDate(loanDate.plusDays(14).toString());

        sqlSession.insert(NS_LOAN + "insertLoan", loanVO);

        // 도서 상태 → 대출중(N)
        Map<String, Object> p = new HashMap<>();
        p.put("bookId", loanVO.getBookId());
        p.put("status", "N");
        sqlSession.update(NS_BOOK + "updateBookStatus", p);
    }

    @Override
    public List<Map<String, Object>> selectMyLoanList(String memberId) throws Exception {
        List<Map<String, Object>> list =
            sqlSession.selectList(NS_LOAN + "selectMyLoanList", memberId);
        attachDday(list);
        return list;
    }

    @Override
    public List<Map<String, Object>> selectMyLoanSummary(String memberId) throws Exception {
        List<Map<String, Object>> list =
            sqlSession.selectList(NS_LOAN + "selectMyLoanSummary", memberId);
        attachDday(list);
        return list;
    }

    @Override
    public void returnLoan(int loanId, int bookId) throws Exception {
        // LOAN STATUS → RETURNED, 반납일 기록
        Map<String, Object> p = new HashMap<>();
        p.put("loanId", loanId);
        p.put("returnDate", LocalDate.now().toString());
        sqlSession.update(NS_LOAN + "returnLoan", p);

        // 도서 상태 → 대출가능(Y)
        Map<String, Object> bp = new HashMap<>();
        bp.put("bookId", bookId);
        bp.put("status", "Y");
        sqlSession.update(NS_BOOK + "updateBookStatus", bp);
    }

    /** D-day 계산 후 각 Map에 dday, ddayLabel, ddayClass 추가 */
    private void attachDday(List<Map<String, Object>> list) {
        LocalDate today = LocalDate.now();
        for (Map<String, Object> row : list) {
            String rd = (String) row.get("returnDate");
            if (rd != null && !rd.isEmpty()) {
                LocalDate returnDate = LocalDate.parse(rd);
                long diff = ChronoUnit.DAYS.between(today, returnDate); // 양수=남은일, 음수=연체
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
=======
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
>>>>>>> c35c9fa3da37ff3babc985bb0c77426861bb6aa1
    }
}
