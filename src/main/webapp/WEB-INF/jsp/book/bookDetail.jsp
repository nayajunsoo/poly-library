<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>도서 상세 - 폴리 인공지능 도서관</title>
<style>
  * { margin: 0; padding: 0; box-sizing: border-box; }
  body { font-family: 'Georgia', serif; background-color: #F5F0E8; color: #3B2F2F; min-height: 100vh; }
  .header { background-color: #5C3D2E; padding: 0; box-shadow: 0 2px 8px rgba(0,0,0,0.3); }
  .header-inner { max-width: 1100px; margin: 0 auto; padding: 20px 30px; display: flex; align-items: center; justify-content: space-between; }
  .header h1 { color: #F5E6C8; font-size: 22px; letter-spacing: 1px; }
  .header .subtitle { color: #C4A882; font-size: 13px; margin-top: 4px; }
  .nav-links a { color: #F5E6C8; text-decoration: none; margin-left: 20px; font-size: 14px; }
  .nav-links a:hover { color: #E8C87A; }
  .container { max-width: 700px; margin: 50px auto; padding: 0 30px; }
  .page-title { font-size: 26px; color: #5C3D2E; font-weight: bold; border-left: 5px solid #A0522D; padding-left: 14px; margin-bottom: 30px; }
  .detail-card { background: #FFFDF8; border-radius: 12px; box-shadow: 0 2px 12px rgba(92,61,46,0.1); overflow: hidden; }
  .detail-row { display: flex; border-bottom: 1px solid #EDE0CE; }
  .detail-row:last-child { border-bottom: none; }
  .detail-label { background: #F5ECD8; width: 130px; min-width: 130px; padding: 18px 20px; font-size: 14px; font-weight: bold; color: #5C3D2E; }
  .detail-value { padding: 18px 20px; font-size: 14px; color: #4A3728; flex: 1; }
  .badge { display: inline-block; padding: 4px 14px; border-radius: 20px; font-size: 13px; font-weight: bold; }
  .badge-available { background-color: #E8F5E9; color: #2E7D32; }
  .badge-loaned { background-color: #FFF3E0; color: #E65100; }
  .btn-group { margin-top: 28px; display: flex; gap: 12px; }
  .btn-edit { background-color: #A0522D; color: #FFF8F0; padding: 10px 24px; border: none; border-radius: 6px; font-size: 14px; cursor: pointer; text-decoration: none; display: inline-block; transition: background 0.2s; }
  .btn-edit:hover { background-color: #7B3F20; }
  .btn-back { background-color: #E8D5B0; color: #5C3D2E; padding: 10px 24px; border: none; border-radius: 6px; font-size: 14px; cursor: pointer; text-decoration: none; display: inline-block; transition: background 0.2s; }
  .btn-back:hover { background-color: #D4B896; }
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
  <div class="page-title">도서 상세</div>
  <div class="detail-card">
    <div class="detail-row">
      <div class="detail-label">도서 번호</div>
      <div class="detail-value">${book.bookId}</div>
    </div>
    <div class="detail-row">
      <div class="detail-label">도서명</div>
      <div class="detail-value">${book.title}</div>
    </div>
    <div class="detail-row">
      <div class="detail-label">저자</div>
      <div class="detail-value">${book.author}</div>
    </div>
    <div class="detail-row">
      <div class="detail-label">출판사</div>
      <div class="detail-value">${book.publisher}</div>
    </div>
    <div class="detail-row">
      <div class="detail-label">대출 상태</div>
      <div class="detail-value">
        <c:choose>
          <c:when test="${book.status == 'Y'}"><span class="badge badge-available">대출가능</span></c:when>
          <c:otherwise><span class="badge badge-loaned">대출중</span></c:otherwise>
        </c:choose>
      </div>
    </div>
  </div>
  <div class="btn-group">
    <a href="/poly-library/book/bookModifyView.do?bookId=${book.bookId}" class="btn-edit">수정</a>
    <a href="/poly-library/book/bookList.do" class="btn-back">목록으로</a>
  </div>
</div>
<div class="footer">© 2026 폴리 인공지능 도서관 · Poly AI Library</div>
</body>
</html>