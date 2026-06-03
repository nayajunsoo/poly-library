<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://fonts.googleapis.com/css2?family=Noto+Serif+KR:wght@400;700&display=swap" rel="stylesheet">
<title>도서 수정 - 폴리 인공지능 도서관</title>
<style>
*{margin:0;padding:0;box-sizing:border-box;}
body{font-family:'Noto Serif KR',serif;background:#F5F0E8;color:#3B2F2F;min-height:100vh;}
.header{background:#3B2010;box-shadow:0 2px 8px rgba(0,0,0,0.3);}
.header-inner{max-width:1100px;margin:0 auto;padding:14px 30px;display:flex;align-items:center;justify-content:space-between;}
.header h1{color:#F5E6C8;font-size:19px;}
.admin-badge{background:#C62828;color:#fff;font-size:11px;padding:2px 8px;border-radius:10px;margin-left:8px;}
.nav-links a{color:#F5E6C8;text-decoration:none;margin-left:16px;font-size:13px;}
.container{max-width:600px;margin:40px auto;padding:0 30px;}
.page-title{font-size:22px;color:#5C3D2E;font-weight:bold;border-left:5px solid #A0522D;padding-left:14px;margin-bottom:24px;}
.form-card{background:#FFFDF8;border-radius:12px;box-shadow:0 2px 12px rgba(92,61,46,0.1);padding:32px;}
.form-group{margin-bottom:18px;}
.form-group label{display:block;font-size:13px;font-weight:bold;color:#5C3D2E;margin-bottom:6px;}
.form-group input,.form-group select{width:100%;padding:10px 12px;border:1.5px solid #D4B896;border-radius:6px;font-size:13px;font-family:inherit;background:#FFFDF8;}
.btn-group{display:flex;gap:10px;}
.btn-submit{background:#A0522D;color:#FFF8F0;padding:11px;border:none;border-radius:6px;font-size:13px;cursor:pointer;flex:1;font-family:inherit;}
.btn-cancel{background:#E8D5B0;color:#5C3D2E;padding:11px;border:none;border-radius:6px;font-size:13px;text-decoration:none;display:inline-block;text-align:center;flex:1;}
.footer{text-align:center;margin-top:50px;padding:20px;color:#A08060;font-size:12px;border-top:1px solid #DDD0BC;}
</style>
</head>
<body>
<div class="header">
  <div class="header-inner">
    <div><h1>📚 폴리 인공지능 도서관 <span class="admin-badge">ADMIN</span></h1></div>
    <div class="nav-links">
      <a href="${pageContext.request.contextPath}/admin/adminMain.do">← 대시보드</a>
      <a href="${pageContext.request.contextPath}/book/bookList.do">도서목록</a>
    </div>
  </div>
</div>
<div class="container">
  <div class="page-title">✏️ 도서 수정</div>
  <div class="form-card">
    <form action="${pageContext.request.contextPath}/book/bookModify.do" method="post">
      <input type="hidden" name="bookId" value="${book.bookId}">
      <div class="form-group">
        <label>도서명</label>
        <input type="text" name="title" value="${book.title}" required>
      </div>
      <div class="form-group">
        <label>저자</label>
        <input type="text" name="author" value="${book.author}" required>
      </div>
      <div class="form-group">
        <label>출판사</label>
        <input type="text" name="publisher" value="${book.publisher}" required>
      </div>
      <div class="form-group">
        <label>분류</label>
        <select name="category">
          <option value="">선택하세요</option>
          <option value="컴퓨터/IT"   ${book.category=='컴퓨터/IT'  ?'selected':''}>컴퓨터/IT</option>
          <option value="경영/경제"   ${book.category=='경영/경제'  ?'selected':''}>경영/경제</option>
          <option value="소설/문학"   ${book.category=='소설/문학'  ?'selected':''}>소설/문학</option>
          <option value="인문/사회"   ${book.category=='인문/사회'  ?'selected':''}>인문/사회</option>
          <option value="과학/기술"   ${book.category=='과학/기술'  ?'selected':''}>과학/기술</option>
          <option value="자기계발"    ${book.category=='자기계발'   ?'selected':''}>자기계발</option>
          <option value="역사/문화"   ${book.category=='역사/문화'  ?'selected':''}>역사/문화</option>
          <option value="예술/디자인" ${book.category=='예술/디자인'?'selected':''}>예술/디자인</option>
          <option value="의학/건강"   ${book.category=='의학/건강'  ?'selected':''}>의학/건강</option>
          <option value="기타"        ${book.category=='기타'       ?'selected':''}>기타</option>
        </select>
      </div>
      <div class="form-group">
        <label>대출 상태</label>
        <select name="status">
          <option value="Y" ${book.status=='Y'?'selected':''}>대출가능</option>
          <option value="N" ${book.status=='N'?'selected':''}>대출중</option>
        </select>
      </div>
      <div class="btn-group">
        <button type="submit" class="btn-submit">수정완료</button>
        <a href="${pageContext.request.contextPath}/book/bookList.do" class="btn-cancel">취소</a>
      </div>
    </form>
  </div>
</div>
<div class="footer">© 2026 폴리 인공지능 도서관</div>
</body>
</html>
