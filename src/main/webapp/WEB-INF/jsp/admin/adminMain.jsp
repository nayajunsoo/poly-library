<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://fonts.googleapis.com/css2?family=Noto+Serif+KR:wght@400;700&display=swap" rel="stylesheet">
<title>관리자 대시보드 - 폴리 인공지능 도서관</title>
<style>
*{margin:0;padding:0;box-sizing:border-box;}
body{font-family:'Noto Serif KR',serif;background:#F0EBE0;color:#3B2F2F;min-height:100vh;display:flex;flex-direction:column;}
/* 어드민 헤더 */
.header{background:#3B2010;box-shadow:0 2px 8px rgba(0,0,0,0.4);}
.header-inner{max-width:1300px;margin:0 auto;padding:14px 30px;display:flex;align-items:center;justify-content:space-between;}
.logo-area h1{color:#F5E6C8;font-size:19px;letter-spacing:1px;}
.logo-area .subtitle{color:#C4A882;font-size:11px;margin-top:2px;}
.admin-badge{background:#C62828;color:#fff;font-size:11px;padding:2px 8px;border-radius:10px;margin-left:8px;vertical-align:middle;}
.nav-links{display:flex;align-items:center;gap:20px;}
.nav-links a{color:#F5E6C8;text-decoration:none;font-size:13px;padding:6px 12px;border-radius:6px;transition:background 0.2s;}
.nav-links a:hover{background:rgba(255,255,255,0.1);}
.nav-links a.active{background:rgba(255,255,255,0.15);font-weight:bold;}
.nav-links .logout{color:#C4A882;font-size:12px;}
/* 레이아웃 */
.main-layout{max-width:1300px;margin:28px auto;padding:0 30px;display:grid;grid-template-columns:1fr 380px;gap:24px;flex:1;}
/* 카드 공통 */
.card{background:#FFFDF8;border-radius:12px;box-shadow:0 2px 12px rgba(59,32,16,0.1);overflow:hidden;margin-bottom:20px;}
.card-header{padding:16px 20px;border-bottom:1px solid #EDE0CE;display:flex;align-items:center;justify-content:space-between;}
.card-title{font-size:16px;font-weight:bold;color:#3B2010;display:flex;align-items:center;gap:8px;}
.card-count{background:#C62828;color:#fff;border-radius:20px;font-size:12px;padding:2px 10px;}
.card-body{padding:0;}
/* 반납대기 테이블 */
table{width:100%;border-collapse:collapse;}
thead tr{background:#3B2010;}
thead th{color:#F5E6C8;padding:11px 12px;font-size:12px;text-align:center;}
tbody td{padding:11px 12px;font-size:12px;text-align:center;border-bottom:1px solid #EDE0CE;color:#4A3728;}
tbody tr:hover{background:#FFF8EE;}
.btn-approve{background:#2E7D6B;color:#fff;border:none;border-radius:5px;padding:5px 14px;font-size:11px;cursor:pointer;font-family:inherit;}
.btn-approve:hover{background:#1E5C4E;}
/* 통계 카드들 */
.stat-grid{display:grid;grid-template-columns:repeat(3,1fr);gap:12px;margin-bottom:20px;}
.stat-card{background:#FFFDF8;border-radius:10px;box-shadow:0 2px 8px rgba(59,32,16,0.08);padding:16px 20px;text-align:center;border-top:3px solid;}
.stat-card.s1{border-color:#2E7D6B;}
.stat-card.s2{border-color:#C62828;}
.stat-card.s3{border-color:#A0522D;}
.stat-num{font-size:28px;font-weight:bold;margin-bottom:4px;}
.stat-label{font-size:12px;color:#A08060;}
/* 사이드 카드 */
.side-card{background:#FFFDF8;border-radius:12px;box-shadow:0 2px 12px rgba(59,32,16,0.1);overflow:hidden;margin-bottom:20px;}
.side-header{padding:14px 18px;background:#5C3D2E;color:#F5E6C8;font-size:14px;font-weight:bold;display:flex;justify-content:space-between;align-items:center;}
.side-body{padding:12px;}
.loan-row{padding:10px 12px;border-bottom:1px solid #EDE0CE;display:flex;justify-content:space-between;align-items:center;}
.loan-row:last-child{border-bottom:none;}
.lr-title{font-size:12px;font-weight:bold;color:#3B2F2F;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;max-width:150px;}
.lr-meta{font-size:11px;color:#A08060;}
.status-chip{font-size:10px;padding:2px 7px;border-radius:10px;font-weight:bold;}
.chip-active{background:#EEF7F4;color:#2E7D6B;}
.chip-pending{background:#FFF3E0;color:#E65100;}
.btn-sm{background:#E8D5B0;color:#5C3D2E;padding:4px 10px;border-radius:4px;font-size:11px;text-decoration:none;}
.empty-msg{text-align:center;padding:30px;color:#A08060;font-size:13px;}
.footer{text-align:center;padding:18px;color:#A08060;font-size:12px;border-top:1px solid #DDD0BC;}
</style>
</head>
<body>

<div class="header">
  <div class="header-inner">
    <div class="logo-area">
      <h1>📚 폴리 인공지능 도서관 <span class="admin-badge">ADMIN</span></h1>
      <div class="subtitle">관리자 대시보드 · ${sessionScope.loginVO.userName}님 로그인 중</div>
    </div>
    <div class="nav-links">
      <a href="${pageContext.request.contextPath}/admin/adminMain.do" class="active">🏠 대시보드</a>
      <a href="${pageContext.request.contextPath}/book/bookList.do">📖 도서목록</a>
      <a href="${pageContext.request.contextPath}/book/bookRegisterView.do">➕ 도서등록</a>
      <a href="${pageContext.request.contextPath}/admin/userList.do">👥 회원관리</a>
      <a href="${pageContext.request.contextPath}/user/logout.do" class="logout"
         onclick="return confirm('로그아웃 하시겠습니까?')">로그아웃</a>
    </div>
  </div>
</div>

<div class="main-layout">
  <!-- 왼쪽 메인 -->
  <div>
    <!-- 통계 카드 -->
    <div class="stat-grid">
      <div class="stat-card s1">
        <div class="stat-num" style="color:#2E7D6B;">${fn:length(allLoanList)}</div>
        <div class="stat-label">현재 대출 중</div>
      </div>
      <div class="stat-card s2">
        <div class="stat-num" style="color:#C62828;">${fn:length(pendingList)}</div>
        <div class="stat-label">반납 대기</div>
      </div>
      <div class="stat-card s3">
        <div class="stat-num" style="color:#A0522D;">${fn:length(allLoanList) + fn:length(pendingList)}</div>
        <div class="stat-label">전체 미반납</div>
      </div>
    </div>

    <!-- 반납 대기 목록 (메인) -->
    <div class="card">
      <div class="card-header">
        <div class="card-title">
          🔔 반납 승인 대기
          <span class="card-count">${fn:length(pendingList)}건</span>
        </div>
      </div>
      <div class="card-body">
        <c:choose>
          <c:when test="${empty pendingList}">
            <div class="empty-msg">✅ 반납 대기 중인 도서가 없습니다.</div>
          </c:when>
          <c:otherwise>
            <table>
              <thead>
                <tr>
                  <th>도서명</th>
                  <th>저자</th>
                  <th>대출자</th>
                  <th>연락처</th>
                  <th>대출일</th>
                  <th>반납예정일</th>
                  <th>승인</th>
                </tr>
              </thead>
              <tbody>
                <c:forEach var="loan" items="${pendingList}">
                  <tr>
                    <td style="text-align:left;padding-left:14px;font-weight:bold;">${loan.bookTitle}</td>
                    <td>${loan.bookAuthor}</td>
                    <td>${loan.memberName}<br><span style="color:#A08060;font-size:10px;">(${loan.memberId})</span></td>
                    <td>${loan.memberPhone}</td>
                    <td>${loan.loanDate}</td>
                    <td>${loan.returnDate}</td>
                    <td>
                      <form action="${pageContext.request.contextPath}/admin/approveReturn.do" method="post" style="display:inline;">
                        <input type="hidden" name="loanId" value="${loan.loanId}">
                        <input type="hidden" name="bookId" value="${loan.bookId}">
                        <button type="submit" class="btn-approve"
                                onclick="return confirm('반납 승인하시겠습니까?')">✔ 승인</button>
                      </form>
                    </td>
                  </tr>
                </c:forEach>
              </tbody>
            </table>
          </c:otherwise>
        </c:choose>
      </div>
    </div>

    <!-- 전체 대출 현황 -->
    <div class="card">
      <div class="card-header">
        <div class="card-title">📋 전체 대출 현황 (최근 50건)</div>
        <a href="${pageContext.request.contextPath}/admin/userList.do" class="btn-sm">회원 조회 →</a>
      </div>
      <div class="card-body">
        <c:choose>
          <c:when test="${empty allLoanList}">
            <div class="empty-msg">대출 중인 도서가 없습니다.</div>
          </c:when>
          <c:otherwise>
            <table>
              <thead>
                <tr>
                  <th>도서명</th>
                  <th>대출자</th>
                  <th>대출일</th>
                  <th>반납예정일</th>
                  <th>상태</th>
                </tr>
              </thead>
              <tbody>
                <c:forEach var="loan" items="${allLoanList}">
                  <tr>
                    <td style="text-align:left;padding-left:14px;">${loan.bookTitle}</td>
                    <td>${loan.memberName}<br><span style="font-size:10px;color:#A08060;">(${loan.memberId})</span></td>
                    <td>${loan.loanDate}</td>
                    <td>${loan.returnDate}</td>
                    <td>
                      <span class="status-chip ${loan.status=='ACTIVE'?'chip-active':'chip-pending'}">
                        ${loan.status=='ACTIVE'?'대출중':'반납요청'}
                      </span>
                    </td>
                  </tr>
                </c:forEach>
              </tbody>
            </table>
          </c:otherwise>
        </c:choose>
      </div>
    </div>
  </div>

  <!-- 오른쪽 사이드바 -->
  <div>
    <!-- 빠른 메뉴 -->
    <div class="side-card">
      <div class="side-header">⚡ 빠른 메뉴</div>
      <div class="side-body" style="display:grid;grid-template-columns:1fr 1fr;gap:8px;padding:14px;">
        <a href="${pageContext.request.contextPath}/book/bookRegisterView.do"
           style="background:#5C3D2E;color:#FFF8F0;padding:12px;border-radius:8px;text-align:center;text-decoration:none;font-size:12px;display:block;">
          📖 도서 등록
        </a>
        <a href="${pageContext.request.contextPath}/admin/userList.do"
           style="background:#2E7D6B;color:#fff;padding:12px;border-radius:8px;text-align:center;text-decoration:none;font-size:12px;display:block;">
          👥 회원 관리
        </a>
        <a href="${pageContext.request.contextPath}/book/bookList.do"
           style="background:#A0522D;color:#fff;padding:12px;border-radius:8px;text-align:center;text-decoration:none;font-size:12px;display:block;">
          📚 도서 목록
        </a>
        <a href="${pageContext.request.contextPath}/user/logout.do"
           onclick="return confirm('로그아웃 하시겠습니까?')"
           style="background:#888;color:#fff;padding:12px;border-radius:8px;text-align:center;text-decoration:none;font-size:12px;display:block;">
          🚪 로그아웃
        </a>
      </div>
    </div>

    <!-- 반납 대기 요약 -->
    <div class="side-card">
      <div class="side-header">
        ⏳ 반납 대기 요약
        <span style="background:#C62828;color:#fff;border-radius:10px;font-size:11px;padding:1px 7px;">${fn:length(pendingList)}</span>
      </div>
      <div class="side-body" style="padding:0;">
        <c:choose>
          <c:when test="${empty pendingList}">
            <div class="empty-msg" style="padding:20px;">반납 대기 없음</div>
          </c:when>
          <c:otherwise>
            <c:forEach var="loan" items="${pendingList}" end="4">
              <div class="loan-row">
                <div>
                  <div class="lr-title">${loan.bookTitle}</div>
                  <div class="lr-meta">${loan.memberName} · ${loan.loanDate}</div>
                </div>
                <span class="status-chip chip-pending">반납요청</span>
              </div>
            </c:forEach>
            <c:if test="${fn:length(pendingList) > 5}">
              <div style="text-align:center;padding:10px;font-size:12px;color:#A0522D;">
                외 ${fn:length(pendingList)-5}건 더 있음
              </div>
            </c:if>
          </c:otherwise>
        </c:choose>
      </div>
    </div>
  </div>
</div>

<div class="footer">© 2026 폴리 인공지능 도서관 관리자 시스템</div>
</body>
</html>
