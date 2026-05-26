package egovframework.example.loan.service;

import java.io.Serializable;

public class LoanVO implements Serializable {
    private static final long serialVersionUID = 1L;

    private int loanId;        // 대출 번호
    private String bookId;     // 도서 ID
    private String title;      // 도서명
    private String userId;     // 회원 아이디
    private String memberId;   // 회원 아이디 (호환용)
    private String loanDate;   // 대출일
    private String dueDate;    // 반납예정일
    private String returnDate; // 반납일
    private String status;     // 상태

    public int getLoanId() { return loanId; }
    public void setLoanId(int loanId) { this.loanId = loanId; }
    public String getBookId() { return bookId; }
    public void setBookId(String bookId) { this.bookId = bookId; }
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    public String getUserId() { return userId; }
    public void setUserId(String userId) { this.userId = userId; }
    public String getMemberId() { return memberId; }
    public void setMemberId(String memberId) { this.memberId = memberId; }
    public String getLoanDate() { return loanDate; }
    public void setLoanDate(String loanDate) { this.loanDate = loanDate; }
    public String getDueDate() { return dueDate; }
    public void setDueDate(String dueDate) { this.dueDate = dueDate; }
    public String getReturnDate() { return returnDate; }
    public void setReturnDate(String returnDate) { this.returnDate = returnDate; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}