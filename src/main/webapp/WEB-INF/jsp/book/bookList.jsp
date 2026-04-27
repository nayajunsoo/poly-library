<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>도서 목록 - 폴리 인공지능 도서관</title>
<style>
  * { margin: 0; padding: 0; box-sizing: border-box; }
  body { font-family: 'Georgia', serif; background-color: #F5F0E8; color: #3B2F2F; min-height: 100vh; }
  .header { background-color: #5C3D2E; padding: 0; box-shadow: 0 2px 8px rgba(0,0,0,0.3); }
  .header-inner { max-width: 1100px; margin: 0 auto; padding: 20px 30px; display: flex; align-items: center; justify-content: space-between; }
  .header h1 { color: #F5E6C8; font-size: 22px; letter-spacing: 1px; }
  .header .subtitle { color: #C4A882; font-size: 13px; margin-top: 4px; }
  .nav-links a { color: #F5E6C8; text-decoration: none; margin-left: 20px; font-size: 14px; }
  .nav-links a:hover { color: #E8C87A; }
  .container { max-width: 1100px; margin: 40px auto; padding: 0 30px; }
  .page-header { display: flex; align-items: center; justify-content: space-between; margin-bottom: 20px; }
  .page-title { font-size: 26px; color: #5C3D2E; font-weight: bold; border-left: 5px solid #A0522D; padding-left: 14px; }
  .btn-register { background-color: #A0522D; color: #FFF8F0; padding: 10px 22px; border: none; border-radius: 6px; font-size: 14px; cursor: pointer; text-decoration: none; display: inline-block; transition: background 0.2s; }
  .btn-register:hover { background-color: #7B3F20; }

  /* 검색창 */
  .search-box { background: #FFFDF8; border-radius: 10px; box-shadow: 0 2px 8px rgba(92,61,46,0.1); padding: 16px 20px; margin-bottom: 20px; display: flex; gap: 10px; align-items: center; }
  .search-box select { padding: 9px 14px; border: 1.5px solid #D4B896; border-radius: 6px; font-size: 14px; font-family: inherit; background: #FFF8F0; color: #3B2F2F; cursor: pointer; }
  .search-box select:focus { outline: none; border-color: #A0522D; }
  .search-box input { flex: 1; padding: 9px 14px; border: 1.5px solid #D4B896; border-radius: 6px; font-size: 14px; font-family: inherit; background: #FFF8F0; color: #3B2F2F; }
  .search-box input:focus { outline: none; border-color: #A0522D; }
  .btn-search { background-color: #5C3D2E; color: #FFF8F0; padding: 9px 22px; border: none; border-radius: 6px; font-size: 14px; cursor: pointer; font-family: inherit; transition: background 0.2s; white-space: nowrap; }
  .btn-search:hover { background-color: #3D2719; }
  .btn-reset { background-color: #E8D5B0; color: #5C3D2E; padding: 9px 16px; border: none; border-radius: 6px; font-size: 14px; cursor: pointer; text-decoration: none; display: inline-block; transition: background 0.2s; white-space: nowrap; }
  .btn-reset:hover { background-color: #D4B896; }

  /* 검색 결과 안내 */
  .search-result { font-size: 14px; color: #7B3F20; margin-bottom: 12px; padding-left: 4px; }

  .table-card { background: #FFFDF8; border-radius: 12px; box-shadow: 0 2px 12px rgba(92,61,46,0.1); overflow: hidden; }
  table { width: 100%; border-collapse: collapse; table-layout: fixed; }
  thead tr { background-color: #5C3D2E; }
  thead th { color: #F5E6C8; padding: 16px 12px; font-size: 14px; font-weight: bold; text-align: center; letter-spacing: 0.5px; }
  tbody tr { border-bottom: 1px solid #EDE0CE; transition: background 0.15s; }
  tbody tr:last-child { border-bottom: none; }
  tbody tr:hover { background-color: #FDF3E3; }
  tbody td { padding: 14px 12px; font-size: 14px; text-align: center; color: #4A3728; word-break: keep-all; }
  tbody td.title-cell { text-align: left; }
  .book-link { color: #7B3F20; text-decoration: none; font-weight: bold; }
  .book-link:hover { color: #A0522D; text-decoration: underline; }
  .badge { display: inline-block; padding: 4px 10px; border-radius: 20px; font-size: 12px; font-weight: bold; white-space: nowrap; }
  .badge-available { background-color: #E8F5E9; color: #2E7D32; }
  .badge-loaned { background-color: #FFF3E0; color: #E65100; }
  .btn-edit { background: #E8D5B0; color: #5C3D2E; border: none; padding: 6px 14px; border-radius: 4px; font-size: 12px; cursor: pointer; text-decoration: none; margin-right: 6px; transition: background 0.2s; white-space: nowrap; display: inline-block; }
  .btn-edit:hover { background: #D4B896; }
  .btn-delete { background: #F5D5CC; color: #7B2D2D; border: none; padding: 6px 14px; border-radius: 4px; font-size: 12px; cursor: pointer; text-decoration: none; transition: background 0.2s; white-space: nowrap; display: inline-block; }
  .btn-delete:hover { background: #E8B8AC; }
  .empty { text-align: center; padding: 60px; color: #A08060; font-size: 16px; }
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
      <a href="/poly-library/book/bookRegisterView.do">도서 등록</a>
    </div>
  </div>
</div>

<div class="container">
  <div class="page-header">
    <div class="page-title">도서 목록</div>
    <a href="/poly-library/book/bookRegisterView.do" class="btn-register">+ 도서 등록</a>
  </div>

  <!-- 검색창 -->
  <form action="/poly-library/book/bookSearch.do" method="get">
    <div class="search-box">
      <select name="searchType">
        <option value="title"     ${searchType == 'title'     ? 'selected' : ''}>제목</option>
        <option value="author"    ${searchType == 'author'    ? 'selected' : ''}>저자</option>
        <option value="publisher" ${searchType == 'publisher' ? 'selected' : ''}>출판사</option>
      </select>
      <input type="text" name="keyword" value="${keyword}" placeholder="검색어를 입력하세요" />
      <button type="submit" class="btn-search">🔍 검색</button>
      <a href="/poly-library/book/bookList.do" class="btn-reset">전체보기</a>
    </div>
  </form>

  <!-- 검색 결과 안내 -->
  <c:if test="${not empty keyword}">
    <div class="search-result">
      "<strong>${keyword}</strong>" 검색 결과: ${bookList.size()}건
    </div>
  </c:if>

  <div class="table-card">
    <table>
      <colgroup>
        <col style="width:60px;">
        <col style="width:30%;">
        <col style="width:20%;">
        <col style="width:20%;">
        <col style="width:110px;">
        <col style="width:160px;">
      </colgroup>
      <thead>
        <tr>
          <th>번호</th>
          <th>도서명</th>
          <th>저자</th>
          <th>출판사</th>
          <th>상태</th>
          <th>관리</th>
        </tr>
      </thead>
      <tbody>
        <c:choose>
          <c:when test="${empty bookList}">
            <tr><td colspan="6" class="empty">검색 결과가 없습니다.</td></tr>
          </c:when>
          <c:otherwise>
            <c:forEach var="book" items="${bookList}">
            <tr>
              <td>${book.bookId}</td>
              <td class="title-cell">
                <a href="/poly-library/book/bookDetail.do?bookId=${book.bookId}" class="book-link">${book.title}</a>
              </td>
              <td>${book.author}</td>
              <td>${book.publisher}</td>
              <td>
                <c:choose>
                  <c:when test="${book.status == 'Y'}"><span class="badge badge-available">대출가능</span></c:when>
                  <c:otherwise><span class="badge badge-loaned">대출중</span></c:otherwise>
                </c:choose>
              </td>
              <td>
                <a href="/poly-library/book/bookModifyView.do?bookId=${book.bookId}" class="btn-edit">수정</a>
                <a href="/poly-library/book/bookDelete.do?bookId=${book.bookId}" class="btn-delete" onclick="return confirm('삭제하시겠습니까?')">삭제</a>
              </td>
            </tr>
            </c:forEach>
          </c:otherwise>
        </c:choose>
      </tbody>
    </table>
  </div>
</div>

<div class="footer">© 2026 폴리 인공지능 도서관 · Poly AI Library</div>
</body>
</html>