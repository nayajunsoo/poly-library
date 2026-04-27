<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>도서 목록</title>
</head>
<body>
<h2>도서 목록</h2>
<a href="/poly-library/book/bookRegisterView.do">도서 등록</a>
<table border="1">
    <tr>
        <th>번호</th>
        <th>제목</th>
        <th>저자</th>
        <th>출판사</th>
        <th>상태</th>
        <th>관리</th>
    </tr>
    <c:forEach var="book" items="${bookList}">
    <tr>
        <td>${book.bookId}</td>
        <td><a href="/poly-library/book/bookDetail.do?bookId=${book.bookId}">${book.title}</a></td>
        <td>${book.author}</td>
        <td>${book.publisher}</td>
        <td>${book.status == 'Y' ? '대출가능' : '대출중'}</td>
        <td>
            <a href="/poly-library/book/bookModifyView.do?bookId=${book.bookId}">수정</a>
            <a href="/poly-library/book/bookDelete.do?bookId=${book.bookId}" onclick="return confirm('삭제하시겠습니까?')">삭제</a>
        </td>
    </tr>
    </c:forEach>
</table>
</body>
</html>