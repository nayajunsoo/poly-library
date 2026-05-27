package egovframework.example.loan.service;

import java.util.List;
import java.util.Map;
import egovframework.example.book.service.BookVO;
import egovframework.example.member.service.MemberVO;

public interface LoanService {

<<<<<<< HEAD
    /** 도서 검색 */
    List<BookVO> searchBook(String searchType, String keyword) throws Exception;

    /** 회원 검색 */
    List<MemberVO> searchMember(String searchType, String keyword) throws Exception;

    /** 대출 신청 (중복 대출 검사 포함) */
    void insertLoan(LoanVO loanVO) throws Exception;

    /** 내 대출 현황 (ACTIVE 목록 + D-day 계산) */
    List<Map<String, Object>> selectMyLoanList(String memberId) throws Exception;

    /** 내 대출 현황 요약 (헤더 드롭다운용, 최근 3건) */
    List<Map<String, Object>> selectMyLoanSummary(String memberId) throws Exception;

    /** 반납 처리 */
    void returnLoan(int loanId, int bookId) throws Exception;

    /** 중복 대출 체크: 해당 도서를 현재 대출 중인지 확인 */
    boolean isAlreadyLoaned(int bookId, String memberId) throws Exception;
=======
    /** 도서 검색 (제목/저자/출판사) */
    List<BookVO> searchBook(String searchType, String keyword) throws Exception;

    /** 회원 검색 (이름/전화번호끝4자리/아이디) */
    List<MemberVO> searchMember(String searchType, String keyword) throws Exception;

    /** 대출 신청 */
    void insertLoan(LoanVO loanVO) throws Exception;

    /** 대출 현황 목록 */
    List<Map<String, Object>> selectLoanList() throws Exception;
>>>>>>> c35c9fa3da37ff3babc985bb0c77426861bb6aa1
}
