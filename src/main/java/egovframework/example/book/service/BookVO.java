package egovframework.example.book.service;

import java.io.Serializable;

public class BookVO implements Serializable {
    private static final long serialVersionUID = 1L;

    private int bookId;
    private String title;
    private String author;
    private String publisher;
    private String status;
    private String category;

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
    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }
}
