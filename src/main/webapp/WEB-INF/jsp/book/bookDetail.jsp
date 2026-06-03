<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://fonts.googleapis.com/css2?family=Noto+Serif+KR:wght@400;700&display=swap" rel="stylesheet">
<title>도서 상세 - 폴리 인공지능 도서관</title>
<style>
*{margin:0;padding:0;box-sizing:border-box;}
body{font-family:'Noto Serif KR',serif;background:#F5F0E8;color:#3B2F2F;min-height:100vh;}
.header{background:#5C3D2E;box-shadow:0 2px 8px rgba(0,0,0,0.3);}
.header-inner{max-width:1100px;margin:0 auto;padding:16px 30px;display:flex;align-items:center;justify-content:space-between;}
.header h1{color:#F5E6C8;font-size:20px;}
.subtitle{color:#C4A882;font-size:12px;margin-top:2px;}
.nav-links a{color:#F5E6C8;text-decoration:none;margin-left:18px;font-size:13px;}
.nav-links a:hover{color:#E8C87A;}
.container{max-width:700px;margin:40px auto;padding:0 30px;}
.page-title{font-size:24px;color:#5C3D2E;font-weight:bold;border-left:5px solid #A0522D;padding-left:14px;margin-bottom:24px;}
.detail-card{background:#FFFDF8;border-radius:12px;box-shadow:0 2px 12px rgba(92,61,46,0.1);overflow:hidden;}
.detail-row{display:flex;border-bottom:1px solid #EDE0CE;}
.detail-row:last-child{border-bottom:none;}
.detail-label{background:#F5ECD8;width:120px;min-width:120px;padding:16px 18px;font-size:13px;font-weight:bold;color:#5C3D2E;}
.detail-value{padding:16px 18px;font-size:13px;color:#4A3728;flex:1;}
.badge{display:inline-block;padding:3px 12px;border-radius:20px;font-size:12px;font-weight:bold;}
.badge-available{background:#E8F5E9;color:#2E7D32;}
.badge-loaned{background:#FFF3E0;color:#E65100;}
.btn-group{margin-top:24px;display:flex;gap:10px;}
.btn-edit{background:#A0522D;color:#FFF8F0;padding:10px 22px;border:none;border-radius:6px;font-size:13px;text-decoration:none;display:inline-block;}
.btn-edit:hover{background:#7B3F20;}
.btn-back{background:#E8D5B0;color:#5C3D2E;padding:10px 22px;border:none;border-radius:6px;font-size:13px;text-decoration:none;display:inline-block;}
.footer{text-align:center;margin-top:50px;padding:20px;color:#A08060;font-size:12px;border-top:1px solid #DDD0BC;}
</style>
</head>
<body>
<div class="header">
  <div class="header-inner">
    <div><h1>📚 폴리 인공지능 도서관</h1><div class="subtitle">Poly AI Library Management System</div></div>
    <div class="nav-links">
      <a href="${pageContext.request.contextPath}/book/bookList.do">도서 목록</a>
      <c:if test="${sessionScope.loginVO.role=='ADMIN'}">
        <a href="${pageContext.request.contextPath}/admin/adminMain.do">관리자 대시보드</a>
      </c:if>
    </div>
  </div>
</div>
<div class="container">
  <div class="page-title">도서 상세</div>
  <div class="detail-card">
    <div class="detail-row"><div class="detail-label">도서 번호</div><div class="detail-value">${book.bookId}</div></div>
    <div class="detail-row"><div class="detail-label">도서명</div><div class="detail-value">${book.title}</div></div>
    <div class="detail-row"><div class="detail-label">저자</div><div class="detail-value">${book.author}</div></div>
    <div class="detail-row"><div class="detail-label">출판사</div><div class="detail-value">${book.publisher}</div></div>
    <div class="detail-row"><div class="detail-label">분류</div><div class="detail-value">${empty book.category?'기타':book.category}</div></div>
    <div class="detail-row">
      <div class="detail-label">대출 상태</div>
      <div class="detail-value">
        <c:choose>
          <c:when test="${book.status=='Y'}"><span class="badge badge-available">대출가능</span></c:when>
          <c:otherwise><span class="badge badge-loaned">대출중</span></c:otherwise>
        </c:choose>
      </div>
    </div>
  </div>
  <div class="btn-group">
    <c:if test="${sessionScope.loginVO.role=='ADMIN'}">
      <a href="${pageContext.request.contextPath}/book/bookModifyView.do?bookId=${book.bookId}" class="btn-edit">수정</a>
    </c:if>
    <a href="${pageContext.request.contextPath}/book/bookList.do" class="btn-back">목록으로</a>
  </div>
</div>
<div class="footer">© 2026 폴리 인공지능 도서관</div>
</body>
</html>
