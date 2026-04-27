<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>도서 수정</title>
</head>
<body>
<h2>도서 수정</h2>
<form action="/poly-library/book/bookModify.do" method="post">
    <input type="hidden" name="bookId" value="${book.bookId}" />
    <table border="1">
        <tr>
            <th>제목</th>
            <td><input type="text" name="title" value="${book.title}" required /></td>
        </tr>
        <tr>
            <th>저자</th>
            <td><input type="text" name="author" value="${book.author}" required /></td>
        </tr>
        <tr>
            <th>출판사</th>
            <td><input type="text" name="publisher" value="${book.publisher}" required /></td>
        </tr>
        <tr>
            <th>상태</th>
            <td>
                <select name="status">
                    <option value="Y" ${book.status == 'Y' ? 'selected' : ''}>대출가능</option>
                    <option value="N" ${book.status == 'N' ? 'selected' : ''}>대출중</option>
                </select>
            </td>
        </tr>
    </table>
    <button type="submit">수정</button>
    <a href="/poly-library/book/bookList.do">취소</a>
</form>
</body>
</html>