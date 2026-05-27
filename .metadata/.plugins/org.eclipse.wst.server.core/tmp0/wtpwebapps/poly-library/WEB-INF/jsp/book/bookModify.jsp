<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>도서 수정 - 폴리 인공지능 도서관</title>
<style>
  * { margin: 0; padding: 0; box-sizing: border-box; }
  body { font-family: 'Georgia', serif; background-color: #F5F0E8; color: #3B2F2F; min-height: 100vh; }
  .header { background-color: #5C3D2E; padding: 0; box-shadow: 0 2px 8px rgba(0,0,0,0.3); }
  .header-inner { max-width: 1100px; margin: 0 auto; padding: 20px 30px; display: flex; align-items: center; justify-content: space-between; }
  .header h1 { color: #F5E6C8; font-size: 22px; letter-spacing: 1px; }
  .header .subtitle { color: #C4A882; font-size: 13px; margin-top: 4px; }
  .nav-links a { color: #F5E6C8; text-decoration: none; margin-left: 20px; font-size: 14px; }
  .nav-links a:hover { color: #E8C87A; }
  .container { max-width: 600px; margin: 50px auto; padding: 0 30px; }
  .page-title { font-size: 26px; color: #5C3D2E; font-weight: bold; border-left: 5px solid #A0522D; padding-left: 14px; margin-bottom: 30px; }
  .form-card { background: #FFFDF8; border-radius: 12px; box-shadow: 0 2px 12px rgba(92,61,46,0.1); padding: 36px; }
  .form-group { margin-bottom: 22px; }
  .form-group label { display: block; font-size: 14px; font-weight: bold; color: #5C3D2E; margin-bottom: 8px; }
  .form-group input, .form-group select { width: 100%; padding: 11px 14px; border: 1.5px solid #D4B896; border-radius: 6px; font-size: 14px; font-family: inherit; background: #FFFDF8; color: #3B2F2F; transition: border-color 0.2s; }
  .form-group input:focus, .form-group select:focus { outline: none; border-color: #A0522D; background: #FFF8F0; }
  .form-group select { cursor: pointer; }
  .form-divider { border: none; border-top: 1px solid #EDE0CE; margin: 10px 0 24px; }
  .btn-group { display: flex; gap: 12px; }
  .btn-submit { background-color: #A0522D; color: #FFF8F0; padding: 12px 28px; border: none; border-radius: 6px; font-size: 14px; cursor: pointer; font-family: inherit; transition: background 0.2s; flex: 1; }
  .btn-submit:hover { background-color: #7B3F20; }
  .btn-cancel { background-color: #E8D5B0; color: #5C3D2E; padding: 12px 28px; border: none; border-radius: 6px; font-size: 14px; cursor: pointer; text-decoration: none; display: inline-block; text-align: center; transition: background 0.2s; flex: 1; }
  .btn-cancel:hover { background-color: #D4B896; }
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
  <div class="page-title">도서 수정</div>
  <div class="form-card">
    <form action="/poly-library/book/bookModify.do" method="post">
      <input type="hidden" name="bookId" value="${book.bookId}" />
      <div class="form-group">
        <label for="title">도서명 *</label>
        <input type="text" id="title" name="title" value="${book.title}" required />
      </div>
      <div class="form-group">
        <label for="author">저자 *</label>
        <input type="text" id="author" name="author" value="${book.author}" required />
      </div>
      <div class="form-group">
        <label for="publisher">출판사 *</label>
        <input type="text" id="publisher" name="publisher" value="${book.publisher}" required />
      </div>
      <div class="form-group">
        <label for="status">대출 상태</label>
        <select id="status" name="status">
          <option value="Y" ${book.status == 'Y' ? 'selected' : ''}>대출가능</option>
          <option value="N" ${book.status == 'N' ? 'selected' : ''}>대출중</option>
        </select>
      </div>
      <hr class="form-divider">
      <div class="btn-group">
        <button type="submit" class="btn-submit">수정하기</button>
        <a href="/poly-library/book/bookList.do" class="btn-cancel">취소</a>
      </div>
    </form>
  </div>
</div>
<div class="footer">© 2026 폴리 인공지능 도서관 · Poly AI Library</div>
</body>
</html>