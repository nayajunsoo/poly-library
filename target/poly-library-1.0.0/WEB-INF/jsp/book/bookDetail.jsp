<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>도서 상세</title>
</head>
<body>
<h2>도서 상세</h2>
<table border="1">
    <tr>
        <th>도서번호</th>
        <td>${book.bookId}</td>
    </tr>
    <tr>
        <th>제목</th>
        <td>${book.title}</td>
    </tr>
    <tr>
        <th>저자</th>
        <td>${book.author}</td>
    </tr>
    <tr>
        <th>출판사</th>
        <td>${book.publisher}</td>
    </tr>
    <tr>
        <th>상태</th>
        <td>${book.status == 'Y' ? '대출가능' : '대출중'}</td>
    </tr>
</table>
<a href="/poly-library/book/bookModifyView.do?bookId=${book.bookId}">수정</a>
<a href="/poly-library/book/bookList.do">목록으로</a>
</body>
</html>