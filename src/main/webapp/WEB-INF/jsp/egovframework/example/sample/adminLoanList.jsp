<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 - 전체 대출 현황</title>
<style>
    body { font-family: Arial, sans-serif; margin: 30px; }
    h2 { color: #333; }
    table { border-collapse: collapse; width: 900px; }
    th, td { border: 1px solid #aaa; padding: 8px 12px; text-align: center; }
    th { background-color: #dce8f7; }
    .status-loan    { color: #c00; font-weight: bold; }
    .status-return  { color: #060; }
    .status-overdue { color: #fff; background-color: #c00; padding: 2px 6px; border-radius: 4px; font-weight: bold; }
    .btn { padding: 6px 14px; cursor: pointer; background-color: #c00; color: white; border: none; border-radius: 4px; }
    .btn:hover { background-color: #900; }
    .top-bar { display: flex; justify-content: space-between; align-items: center; width: 900px; }
</style>
</head>
<body>
    <h2>🗂️ 관리자 - 전체 대출 현황</h2>

    <div class="top-bar">
        <span>전체 대출 건수: <strong>${loanList.size()}</strong>건</span>
        <form action="/poly-library/updateOverdue.do" method="post">
            <button type="submit" class="btn">⚠️ 연체 일괄 처리</button>
        </form>
    </div>
    <br/>

    <table>
        <tr>
            <th>대출번호</th>
            <th>도서ID</th>
            <th>도서명</th>
            <th>회원ID</th>
            <th>대출일</th>
            <th>반납예정일</th>
            <th>반납일</th>
            <th>상태</th>
        </tr>
        <c:choose>
            <c:when test="${empty loanList}">
                <tr>
                    <td colspan="8">대출 내역이 없습니다.</td>
                </tr>
            </c:when>
            <c:otherwise>
                <c:forEach var="loan" items="${loanList}">
                <tr>
                    <td>${loan.loanId}</td>
                    <td>${loan.bookId}</td>
                    <td>${loan.title}</td>
                    <td>${loan.userId}</td>
                    <td>${loan.loanDate}</td>
                    <td>${loan.dueDate}</td>
                    <td>${empty loan.returnDate ? '-' : loan.returnDate}</td>
                    <td>
                        <c:choose>
                            <c:when test="${loan.status == 'LOAN'}">
                                <span class="status-loan">대출중</span>
                            </c:when>
                            <c:when test="${loan.status == 'OVERDUE'}">
                                <span class="status-overdue">연체</span>
                            </c:when>
                            <c:otherwise>
                                <span class="status-return">반납완료</span>
                            </c:otherwise>
                        </c:choose>
                    </td>
                </tr>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </table>
    <br/>
    <a href="/poly-library/loanList.do?userId=user01">← 내 대출 목록으로 돌아가기</a>
</body>
</html>
