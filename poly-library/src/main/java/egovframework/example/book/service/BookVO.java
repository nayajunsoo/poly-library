package egovframework.example.book.service;

import java.io.Serializable;

public class BookVO implements Serializable {
    private static final long serialVersionUID = 1L;

    private int bookId;        // 도서 번호
    private String title;      // 제목
    private String author;     // 저자
    private String publisher;  // 출판사
    private String status;     // 대출 상태

    // Getter & Setter
    public int getBookId() { return bookId; }
    public void setBookId(int bookId) { this.bookId = bookId; }
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    public String getAuthor() { return author; }
    public void setAuthor(String author) { this.author = author; }
    public String getPublisher() { return publisher; }
    public void setPublisher(String publisher) { this.publisher = publisher; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}