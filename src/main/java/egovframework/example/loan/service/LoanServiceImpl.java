package egovframework.example.loan.service;

import java.util.List;
import org.springframework.stereotype.Service;

/**
 * 대출 서비스 구현체
 */
@Service("loanService")
public class LoanServiceImpl implements LoanService {

    @Override
    public void insertLoan(LoanVO vo) throws Exception {
        System.out.println("대출 신청 로직 실행");
    }

    @Override
    public List<?> selectLoanList(LoanVO vo) throws Exception {
        System.out.println("대출 목록 조회 로직 실행");
        return null;
    }

    @Override
    public void updateLoanReturn(LoanVO vo) throws Exception {
        System.out.println("반납 처리 로직 실행");
    }
}