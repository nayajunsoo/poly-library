package egovframework.example.loan.service;

import java.io.Serializable;

public class LoanVO implements Serializable {
    private static final long serialVersionUID = 1L;

    private int loanId;        // 대출 번호
    private int bookId;        // 도서 번호
    private String memberId;   // 회원 아이디
    private String loanDate;   // 대출일
    private String returnDate; // 반납일

    public int getLoanId() { return loanId; }
    public void setLoanId(int loanId) { this.loanId = loanId; }
    public int getBookId() { return bookId; }
    public void setBookId(int bookId) { this.bookId = bookId; }
    public String getMemberId() { return memberId; }
    public void setMemberId(String memberId) { this.memberId = memberId; }
    public String getLoanDate() { return loanDate; }
    public void setLoanDate(String loanDate) { this.loanDate = loanDate; }
    public String getReturnDate() { return returnDate; }
    public void setReturnDate(String returnDate) { this.returnDate = returnDate; }
}