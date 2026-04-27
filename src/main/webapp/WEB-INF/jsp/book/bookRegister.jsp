<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>도서 등록</title>
</head>
<body>
<h2>도서 등록</h2>
<form action="/poly-library/book/bookRegister.do" method="post">
    <table border="1">
        <tr>
            <th>제목</th>
            <td><input type="text" name="title" required /></td>
        </tr>
        <tr>
            <th>저자</th>
            <td><input type="text" name="author" required /></td>
        </tr>
        <tr>
            <th>출판사</th>
            <td><input type="text" name="publisher" required /></td>
        </tr>
    </table>
    <button type="submit">등록</button>
    <a href="/poly-library/book/bookList.do">취소</a>
</form>
</body>
</html>