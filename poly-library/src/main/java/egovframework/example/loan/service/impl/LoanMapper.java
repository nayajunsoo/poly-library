package egovframework.example.loan.service.impl;

import java.util.List;
import egovframework.example.loan.service.LoanVO;
import org.egovframe.rte.psl.dataaccess.mapper.Mapper;

@Mapper("loanMapper")
public interface LoanMapper {

    void insertLoan(LoanVO loanVO) throws Exception;

    List<LoanVO> selectLoanListByMember(String memberId) throws Exception;

    List<LoanVO> selectAllLoanList() throws Exception;
}
