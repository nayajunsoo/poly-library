<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>도서 대출/반납 관리</title>
<style>
    body { font-family: Arial, sans-serif; margin: 30px; }
    h2 { color: #333; }
    table { border-collapse: collapse; width: 800px; }
    th, td { border: 1px solid #aaa; padding: 8px 12px; text-align: center; }
    th { background-color: #f0f0f0; }
    .status-loan   { color: #c00; font-weight: bold; }
    .status-return { color: #060; }
    .btn { padding: 4px 10px; cursor: pointer; }
    form { display: inline; }
</style>
</head>
<body>
    <h2>📚 도서 대출/반납 목록</h2>
    <p>조회 회원: <strong>${userId}</strong></p>

    <form action="/poly-library/loanInsert.do" method="post">
        도서 ID: <input type="text" name="bookId" size="10" />
        <input type="hidden" name="userId" value="${userId}" />
        <button type="submit" class="btn">대출 신청</button>
    </form>
    <br/><br/>

    <table>
        <tr>
            <th>대출번호</th>
            <th>도서ID</th>
            <th>도서명</th>
            <th>대출일</th>
            <th>반납예정일</th>
            <th>상태</th>
            <th>반납</th>
        </tr>
        <c:choose>
            <c:when test="${empty loanList}">
                <tr>
                    <td colspan="7">대출 내역이 없습니다.</td>
                </tr>
            </c:when>
            <c:otherwise>
                <c:forEach var="loan" items="${loanList}">
                <tr>
                    <td>${loan.loanId}</td>
                    <td>${loan.bookId}</td>
                    <td>${loan.title}</td>
                    <td>${loan.loanDate}</td>
                    <td>${loan.dueDate}</td>
                    <td>
                        <c:choose>
                            <c:when test="${loan.status == 'LOAN'}">
                                <span class="status-loan">대출중</span>
                            </c:when>
                            <c:otherwise>
                                <span class="status-return">반납완료</span>
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td>
                        <c:if test="${loan.status == 'LOAN'}">
                            <form action="/poly-library/loanReturn.do" method="post">
                                <input type="hidden" name="loanId" value="${loan.loanId}" />
                                <input type="hidden" name="userId" value="${userId}" />
                                <button type="submit" class="btn">반납</button>
                            </form>
                        </c:if>
                    </td>
                </tr>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </table>
    <br/>
    <a href="/poly-library/adminLoanList.do">🗂️ 관리자 페이지</a>
</body>
</html>