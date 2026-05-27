package egovframework.example.loan.service;

import java.util.List;
import java.util.Map;
import egovframework.example.book.service.BookVO;
import egovframework.example.member.service.MemberVO;

public interface LoanService {

    /** 도서 검색 (제목/저자/출판사) */
    List<BookVO> searchBook(String searchType, String keyword) throws Exception;

    /** 회원 검색 (이름/전화번호끝4자리/아이디) */
    List<MemberVO> searchMember(String searchType, String keyword) throws Exception;

    /** 대출 신청 */
    void insertLoan(LoanVO loanVO) throws Exception;

    /** 대출 현황 목록 */
    List<Map<String, Object>> selectLoanList() throws Exception;
}
