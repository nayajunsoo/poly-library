package egovframework.example.loan.service;

import java.util.List;

/**
 * 대출 서비스를 위한 인터페이스 (메뉴판)
 */
public interface LoanService {

    // 1. 도서 대출 신청 (DB에 대출 기록 추가)
    void insertLoan(LoanVO vo) throws Exception;

    // 2. 내 대출 현황 목록 조회 (내가 빌린 책들 보기)
    List<?> selectLoanList(LoanVO vo) throws Exception;

    // 3. 도서 반납 처리 (대출 기록 업데이트)
    void updateLoanReturn(LoanVO vo) throws Exception;
}