<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://fonts.googleapis.com/css2?family=Noto+Serif+KR:wght@400;700&display=swap" rel="stylesheet">
<title>내 대출 현황 - 폴리 인공지능 도서관</title>
<style>
*{margin:0;padding:0;box-sizing:border-box;}
body{font-family:'Noto Serif KR',serif;background:#F5F0E8;color:#3B2F2F;min-height:100vh;}
.header{background:#5C3D2E;box-shadow:0 2px 8px rgba(0,0,0,0.3);}
.header-inner{max-width:1100px;margin:0 auto;padding:16px 30px;display:flex;align-items:center;justify-content:space-between;}
.header h1{color:#F5E6C8;font-size:20px;letter-spacing:1px;}
.subtitle{color:#C4A882;font-size:12px;margin-top:2px;}
.nav-links{display:flex;align-items:center;gap:20px;}
.nav-links a{color:#F5E6C8;text-decoration:none;font-size:13px;}
.nav-links a:hover{color:#E8C87A;}
.container{max-width:900px;margin:36px auto;padding:0 30px;}
.page-title{font-size:22px;color:#5C3D2E;font-weight:bold;border-left:5px solid #A0522D;padding-left:14px;margin-bottom:20px;}
.summary-bar{background:#EEF7F4;border:1px solid #A8D5C8;border-radius:8px;padding:12px 18px;margin-bottom:20px;font-size:13px;color:#2E7D6B;display:flex;gap:20px;flex-wrap:wrap;}
.s-num{font-weight:bold;font-size:16px;}
.empty-box{background:#FFFDF8;border-radius:12px;padding:60px;text-align:center;color:#A08060;font-size:14px;box-shadow:0 2px 12px rgba(92,61,46,0.08);}
.loan-card{background:#FFFDF8;border-radius:12px;box-shadow:0 2px 12px rgba(92,61,46,0.1);margin-bottom:14px;overflow:hidden;border-left:4px solid #5C3D2E;transition:box-shadow 0.2s;}
.loan-card.overdue{border-left-color:#C62828;}
.loan-card.warn{border-left-color:#E65100;}
.loan-card.pending{border-left-color:#A0522D;opacity:0.85;}
.card-inner{padding:18px 22px;display:flex;align-items:center;gap:18px;}
.card-dday{min-width:68px;text-align:center;}
.dday-ok{background:#E8F5E9;color:#2E7D32;border-radius:8px;padding:7px 10px;font-size:14px;font-weight:bold;}
.dday-warn{background:#FFF3E0;color:#E65100;border-radius:8px;padding:7px 10px;font-size:14px;font-weight:bold;}
.dday-over{background:#FFEBEE;color:#C62828;border-radius:8px;padding:7px 10px;font-size:14px;font-weight:bold;}
.card-info{flex:1;}
.book-title{font-size:15px;font-weight:bold;color:#3B2F2F;margin-bottom:3px;}
.book-author{font-size:12px;color:#A08060;margin-bottom:6px;}
.date-row{font-size:11px;color:#888;display:flex;gap:14px;}
.overdue-msg{font-size:11px;color:#C62828;font-weight:bold;margin-top:5px;}
.pending-msg{font-size:11px;color:#A0522D;font-weight:bold;margin-top:5px;}
.btn-return{background:#5C3D2E;color:#FFF8F0;border:none;border-radius:6px;padding:9px 18px;font-size:12px;font-weight:bold;cursor:pointer;font-family:inherit;white-space:nowrap;}
.btn-return:hover{background:#3D2719;}
.btn-pending{background:#A08060;color:#fff;border:none;border-radius:6px;padding:9px 18px;font-size:12px;cursor:default;white-space:nowrap;}
.btn-back{display:inline-block;margin-top:20px;color:#A0522D;text-decoration:none;font-size:13px;}
.toast{display:none;position:fixed;top:24px;left:50%;transform:translateX(-50%);background:#2E7D6B;color:#fff;padding:12px 24px;border-radius:8px;font-size:13px;z-index:9999;}
.footer{text-align:center;margin-top:50px;padding:20px;color:#A08060;font-size:12px;border-top:1px solid #DDD0BC;}
</style>
</head>
<body>
<div id="toast" class="toast"></div>
<div class="header">
  <div class="header-inner">
    <div>
      <h1>📚 폴리 인공지능 도서관</h1>
      <div class="subtitle">Poly AI Library Management System</div>
    </div>
    <div class="nav-links">
      <a href="${pageContext.request.contextPath}/book/bookList.do">도서 목록</a>
      <a href="${pageContext.request.contextPath}/loan/myLoan.do">내 대출현황</a>
      <a href="${pageContext.request.contextPath}/user/logout.do"
         onclick="return confirm('로그아웃 하시겠습니까?')">로그아웃</a>
    </div>
  </div>
</div>

<div class="container">
  <div class="page-title">📋 내 대출 현황</div>

  <c:choose>
    <c:when test="${empty loanList}">
      <div class="empty-box">
        현재 대출 중인 도서가 없습니다.<br><br>
        <a href="${pageContext.request.contextPath}/book/bookList.do"
           style="color:#A0522D;font-weight:bold;text-decoration:none;">도서 목록에서 대출하기 →</a>
      </div>
    </c:when>
    <c:otherwise>
      <div class="summary-bar">
        <span>대출 중 <span class="s-num">${fn:length(loanList)}권</span></span>
      </div>
      <c:forEach var="loan" items="${loanList}">
        <div class="loan-card
          ${loan.status=='PENDING'?'pending':loan.ddayClass=='dday-over'?'overdue':loan.ddayClass=='dday-warn'?'warn':''}">
          <div class="card-inner">
            <div class="card-dday">
              <c:choose>
                <c:when test="${loan.status=='PENDING'}">
                  <div style="background:#FFF3E0;color:#A0522D;border-radius:8px;padding:7px 6px;font-size:11px;font-weight:bold;text-align:center;">반납<br>요청중</div>
                </c:when>
                <c:otherwise>
                  <div class="${loan.ddayClass}">${loan.ddayLabel}</div>
                </c:otherwise>
              </c:choose>
            </div>
            <div class="card-info">
              <div class="book-title">${loan.bookTitle}</div>
              <div class="book-author">${loan.bookAuthor}</div>
              <div class="date-row">
                <span>대출일: ${loan.loanDate}</span>
                <span>반납예정: ${loan.returnDate}</span>
              </div>
              <c:if test="${loan.ddayClass=='dday-over' and loan.status!='PENDING'}">
                <div class="overdue-msg">⚠ 반납 예정일이 ${-loan.dday}일 지났습니다.</div>
              </c:if>
              <c:if test="${loan.status=='PENDING'}">
                <div class="pending-msg">⏳ 관리자 반납 승인 대기 중입니다.</div>
              </c:if>
            </div>
            <c:choose>
              <c:when test="${loan.status=='PENDING'}">
                <button class="btn-pending" disabled>승인 대기중</button>
              </c:when>
              <c:otherwise>
                <form action="${pageContext.request.contextPath}/loan/requestReturn.do" method="post">
                  <input type="hidden" name="loanId" value="${loan.loanId}">
                  <button type="submit" class="btn-return"
                          onclick="return confirm('반납 요청하시겠습니까?\\n관리자 승인 후 반납 처리됩니다.')">반납 요청</button>
                </form>
              </c:otherwise>
            </c:choose>
          </div>
        </div>
      </c:forEach>
    </c:otherwise>
  </c:choose>

  <a href="${pageContext.request.contextPath}/book/bookList.do" class="btn-back">← 도서 목록으로</a>
</div>
<div class="footer">© 2026 폴리 인공지능 도서관</div>

<script>
var msg = '${msg}';
if(msg && msg !== '') {
    var t = document.getElementById('toast');
    t.textContent = decodeURIComponent(msg.replace(/\+/g,' '));
    t.style.display = 'block';
    setTimeout(function(){ t.style.display='none'; }, 3000);
}
</script>
</body>
</html>
