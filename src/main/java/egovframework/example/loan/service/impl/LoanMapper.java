package egovframework.example.loan.service.impl;

import java.util.List;
import egovframework.example.loan.service.LoanVO;
import org.egovframe.rte.psl.dataaccess.mapper.Mapper;

@Mapper("loanMapper")
public interface LoanMapper {
    // 대출 정보를 DB에 저장
    void insertLoan(LoanVO vo) throws Exception;

    // 내 대출 목록 조회
    List<LoanVO> selectLoanList(String userId) throws Exception;

    // 반납 처리
    void updateReturn(LoanVO vo) throws Exception;

    // [추가] 전체 대출 목록 조회 (관리자용)
    List<LoanVO> selectAllLoanList() throws Exception;

    // [추가] 연체 항목 OVERDUE로 일괄 업데이트
    int updateOverdue() throws Exception;
}
