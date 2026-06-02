package egovframework.example.loan.service;

import java.util.List;
import java.util.Map;
import egovframework.example.book.service.BookVO;
import egovframework.example.member.service.MemberVO;

public interface LoanService {
    List<BookVO> searchBook(String searchType, String keyword) throws Exception;
    List<MemberVO> searchMember(String searchType, String keyword) throws Exception;
    void insertLoan(LoanVO loanVO) throws Exception;
    List<Map<String, Object>> selectMyLoanList(String memberId) throws Exception;
    List<Map<String, Object>> selectMyLoanSummary(String memberId) throws Exception;
    // 반납 요청 (PENDING)
    void requestReturn(int loanId) throws Exception;
    // 어드민 반납 승인 (RETURNED)
    void approveReturn(int loanId, int bookId) throws Exception;
    boolean isAlreadyLoaned(int bookId, String memberId) throws Exception;
    // 어드민용
    List<Map<String, Object>> selectPendingReturnList() throws Exception;
    List<Map<String, Object>> selectMonthlyTop30() throws Exception;
    List<Map<String, Object>> selectAllLoanList() throws Exception;
}
