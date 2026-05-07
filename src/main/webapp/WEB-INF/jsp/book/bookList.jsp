<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>도서 목록 - 폴리 인공지능 도서관</title>
<style>
  /* 기존 스타일 유지 (팀장님이 주신 코드와 동일) */
  * { margin: 0; padding: 0; box-sizing: border-box; }
  body { font-family: 'Georgia', serif; background-color: #F5F0E8; color: #3B2F2F; min-height: 100vh; }
  .header { background-color: #5C3D2E; padding: 0; box-shadow: 0 2px 8px rgba(0,0,0,0.3); }
  .header-inner { max-width: 1100px; margin: 0 auto; padding: 20px 30px; display: flex; align-items: center; justify-content: space-between; }
  .header h1 { color: #F5E6C8; font-size: 22px; letter-spacing: 1px; }
  .header .subtitle { color: #C4A882; font-size: 13px; margin-top: 4px; }
  .nav-links { display: flex; align-items: center; gap: 20px; }
  .nav-links a { color: #F5E6C8; text-decoration: none; font-size: 14px; }
  .nav-links a:hover { color: #E8C87A; }
  .user-greet { color: #C4A882; font-size: 13px; font-weight: bold; }
  
  /* 페이지 레이아웃 스타일 생략 (기존과 동일) */
  .container { max-width: 1100px; margin: 40px auto; padding: 0 30px; }
  .page-header { display: flex; align-items: center; justify-content: space-between; margin-bottom: 20px; }
  .page-title { font-size: 26px; color: #5C3D2E; font-weight: bold; border-left: 5px solid #A0522D; padding-left: 14px; }
  .btn-register { background-color: #A0522D; color: #FFF8F0; padding: 10px 22px; border: none; border-radius: 6px; font-size: 14px; cursor: pointer; text-decoration: none; display: inline-block; transition: background 0.2s; }
  .search-box { background: #FFFDF8; border-radius: 10px; box-shadow: 0 2px 8px rgba(92,61,46,0.1); padding: 16px 20px; margin-bottom: 20px; display: flex; gap: 10px; align-items: center; }
  .search-box select, .search-box input { padding: 9px 14px; border: 1.5px solid #D4B896; border-radius: 6px; font-size: 14px; background: #FFF8F0; }
  .btn-search { background-color: #5C3D2E; color: #FFF8F0; padding: 9px 22px; border: none; border-radius: 6px; cursor: pointer; }
  .table-card { background: #FFFDF8; border-radius: 12px; box-shadow: 0 2px 12px rgba(92,61,46,0.1); overflow: hidden; }
  table { width: 100%; border-collapse: collapse; }
  thead tr { background-color: #5C3D2E; }
  thead th { color: #F5E6C8; padding: 16px 12px; font-size: 14px; }
  tbody td { padding: 14px 12px; font-size: 14px; text-align: center; color: #4A3728; border-bottom: 1px solid #EDE0CE; }
  .badge { display: inline-block; padding: 4px 10px; border-radius: 20px; font-size: 12px; font-weight: bold; }
  .badge-available { background-color: #E8F5E9; color: #2E7D32; }
  .badge-loaned { background-color: #FFF3E0; color: #E65100; }
  .btn-edit { background: #E8D5B0; color: #5C3D2E; padding: 6px 14px; border-radius: 4px; font-size: 12px; text-decoration: none; }
  .btn-delete { background: #F5D5CC; color: #7B2D2D; padding: 6px 14px; border-radius: 4px; font-size: 12px; text-decoration: none; }
  .footer { text-align: center; margin-top: 60px; padding: 24px; color: #A08060; font-size: 13px; border-top: 1px solid #DDD0BC; }
</style>
</head>
<body>

<div class="header">
  <div class="header-inner">
    <div>
      <h1>📚 폴리 인공지능 도서관</h1>
      <div class="subtitle">Poly AI Library Management System</div>
    </div>
    <div class="nav-links">
      <a href="/poly-library/book/bookList.do">도서 목록</a>
      
      <%-- 로그인 상태에 따른 버튼 제어 --%>
      <c:choose>
        <c:when test="${empty loginVO}">
          <a href="/poly-library/user/loginView.do">로그인</a>
          <a href="/poly-library/user/joinView.do">회원가입</a>
        </c:when>
        <c:otherwise>
          <span class="user-greet">${loginVO.userName}님 환영합니다! [${loginVO.role}]</span>
          <a href="/poly-library/user/logout.do" onclick="return confirm('로그아웃 하시겠습니까?')">로그아웃</a>
        </c:otherwise>
      </c:choose>
    </div>
  </div>
</div>

<div class="container">
  <div class="page-header">
    <div class="page-title">도서 목록</div>
    <%-- 어드민만 도서 등록 가능 --%>
    <c:if test="${loginVO.role == 'ADMIN'}">
      <a href="/poly-library/book/bookRegisterView.do" class="btn-register">+ 도서 등록</a>
    </c:if>
  </div>

  <!-- 검색창 부분 생략 (기존과 동일) -->

  <div class="table-card">
    <table>
      <thead>
        <tr>
          <th>번호</th>
          <th>도서명</th>
          <th>저자</th>
          <th>출판사</th>
          <th>상태</th>
          <%-- 어드민에게만 관리 열 노출 --%>
          <c:if test="${loginVO.role == 'ADMIN'}">
            <th>관리</th>
          </c:if>
        </tr>
      </thead>
      <tbody>
        <c:forEach var="book" items="${bookList}">
          <tr>
            <td>${book.bookId}</td>
            <td style="text-align:left;">${book.title}</td>
            <td>${book.author}</td>
            <td>${book.publisher}</td>
            <td>
              <c:choose>
                <c:when test="${book.status == 'Y'}"><span class="badge badge-available">대출가능</span></c:when>
                <c:otherwise><span class="badge badge-loaned">대출중</span></c:otherwise>
              </c:choose>
            </td>
            <%-- 어드민 전용 수정/삭제 버튼 --%>
            <c:if test="${loginVO.role == 'ADMIN'}">
              <td>
                <a href="/poly-library/book/bookModifyView.do?bookId=${book.bookId}" class="btn-edit">수정</a>
                <a href="/poly-library/book/bookDelete.do?bookId=${book.bookId}" class="btn-delete" onclick="return confirm('삭제하시겠습니까?')">삭제</a>
              </td>
            </c:if>
          </tr>
        </c:forEach>
      </tbody>
    </table>
  </div>
</div>

<div class="footer">© 2026 폴리 인공지능 도서관 · Poly AI Library</div>
</body>
</html>