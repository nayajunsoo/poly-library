<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>도서 목록 - 폴리 인공지능 도서관</title>
<style>
* { margin:0; padding:0; box-sizing:border-box; }
body { font-family:'Georgia',serif; background-color:#F5F0E8; color:#3B2F2F; min-height:100vh; }
.header { background-color:#5C3D2E; box-shadow:0 2px 8px rgba(0,0,0,0.3); position:relative; z-index:100; }
.header-inner { max-width:1100px; margin:0 auto; padding:20px 30px; display:flex; align-items:center; justify-content:space-between; }
.header h1 { color:#F5E6C8; font-size:22px; letter-spacing:1px; }
.header .subtitle { color:#C4A882; font-size:13px; margin-top:4px; }
.nav-links { display:flex; align-items:center; gap:20px; }
.nav-links a { color:#F5E6C8; text-decoration:none; font-size:14px; }
.nav-links a:hover { color:#E8C87A; }

/* 헤더 드롭다운 */
.user-menu { position:relative; }
.user-btn { color:#C4A882; font-size:13px; font-weight:bold; cursor:pointer; background:none; border:none; font-family:inherit; display:flex; align-items:center; gap:6px; padding:4px 0; }
.user-btn:hover { color:#F5E6C8; }
.user-btn .arrow { font-size:10px; transition:transform 0.2s; }
.user-menu.open .arrow { transform:rotate(180deg); }
.dropdown { display:none; position:absolute; top:calc(100% + 14px); right:0; width:280px; background:#FFFDF8; border-radius:10px; box-shadow:0 8px 30px rgba(0,0,0,0.25); border:1px solid #EDE0CE; overflow:hidden; }
.user-menu.open .dropdown { display:block; animation:fadeDown 0.18s ease; }
@keyframes fadeDown { from{opacity:0;transform:translateY(-8px)} to{opacity:1;transform:translateY(0)} }
.dropdown-header { background:#5C3D2E; padding:12px 16px; color:#F5E6C8; font-size:13px; font-weight:bold; }
.dropdown-body { padding:10px 0; max-height:260px; overflow-y:auto; }
.loan-item { padding:10px 16px; border-bottom:1px solid #F0E8DC; }
.loan-item:last-child { border-bottom:none; }
.li-title { font-size:13px; font-weight:bold; color:#3B2F2F; margin-bottom:3px; overflow:hidden; text-overflow:ellipsis; white-space:nowrap; }
.li-meta { font-size:11px; color:#A08060; display:flex; justify-content:space-between; align-items:center; }
.li-dday { font-size:11px; font-weight:bold; padding:2px 7px; border-radius:10px; }
.dday-ok  { background:#E8F5E9; color:#2E7D32; }
.dday-warn { background:#FFF3E0; color:#E65100; }
.dday-over { background:#FFEBEE; color:#C62828; }
.empty-drop { padding:20px 16px; text-align:center; font-size:13px; color:#A08060; }
.dropdown-footer { border-top:1px solid #EDE0CE; padding:10px 16px; text-align:center; }
.dropdown-footer a { color:#A0522D; text-decoration:none; font-size:13px; font-weight:bold; }
.dropdown-footer a:hover { text-decoration:underline; }

.container { max-width:1100px; margin:40px auto; padding:0 30px; }
.page-header { display:flex; align-items:center; justify-content:space-between; margin-bottom:20px; flex-wrap:wrap; gap:12px; }
.page-title { font-size:26px; color:#5C3D2E; font-weight:bold; border-left:5px solid #A0522D; padding-left:14px; }
.btn-group { display:flex; gap:10px; align-items:center; }
.btn-register { background-color:#A0522D; color:#FFF8F0; padding:10px 22px; border:none; border-radius:6px; font-size:14px; cursor:pointer; text-decoration:none; display:inline-block; }
.btn-register:hover { background-color:#7B3A1F; }
.btn-loan { background-color:#2E7D6B; color:#FFFFFF; padding:10px 22px; border:none; border-radius:6px; font-size:14px; font-weight:bold; cursor:pointer; display:inline-block; }
.btn-loan:hover { background-color:#1E5C4E; }
.search-box { background:#FFFDF8; border-radius:10px; box-shadow:0 2px 8px rgba(92,61,46,0.1); padding:16px 20px; margin-bottom:20px; display:flex; gap:10px; align-items:center; flex-wrap:wrap; }
.search-box select,.search-box input { padding:9px 14px; border:1.5px solid #D4B896; border-radius:6px; font-size:14px; background:#FFF8F0; font-family:inherit; }
.btn-search { background-color:#5C3D2E; color:#FFF8F0; padding:9px 22px; border:none; border-radius:6px; cursor:pointer; font-family:inherit; font-size:14px; }
.btn-search:hover { background-color:#3D2719; }
.toast { display:none; position:fixed; top:24px; left:50%; transform:translateX(-50%); background:#2E7D6B; color:#fff; padding:12px 28px; border-radius:8px; font-size:14px; font-weight:bold; z-index:9999; box-shadow:0 4px 16px rgba(0,0,0,0.2); }
.toast.err { background:#C62828; }
.table-card { background:#FFFDF8; border-radius:12px; box-shadow:0 2px 12px rgba(92,61,46,0.1); overflow:hidden; }
table { width:100%; border-collapse:collapse; }
thead tr { background-color:#5C3D2E; }
thead th { color:#F5E6C8; padding:16px 12px; font-size:14px; text-align:center; }
tbody td { padding:14px 12px; font-size:14px; text-align:center; color:#4A3728; border-bottom:1px solid #EDE0CE; }
tbody tr:hover { background-color:#FFF8EE; }
.badge { display:inline-block; padding:4px 10px; border-radius:20px; font-size:12px; font-weight:bold; }
.badge-available { background-color:#E8F5E9; color:#2E7D32; }
.badge-loaned { background-color:#FFF3E0; color:#E65100; }
.btn-edit { background:#E8D5B0; color:#5C3D2E; padding:6px 14px; border-radius:4px; font-size:12px; text-decoration:none; margin-right:4px; }
.btn-delete { background:#F5D5CC; color:#7B2D2D; padding:6px 14px; border-radius:4px; font-size:12px; text-decoration:none; }
.empty-msg { text-align:center; padding:40px; color:#A08060; font-size:15px; }
.footer { text-align:center; margin-top:60px; padding:24px; color:#A08060; font-size:13px; border-top:1px solid #DDD0BC; }

/* 대출 모달 */
.modal-overlay { display:none; position:fixed; top:0; left:0; width:100%; height:100%; background:rgba(0,0,0,0.55); z-index:1000; justify-content:center; align-items:center; }
.modal-overlay.active { display:flex; }
.modal { background:#FFFDF8; border-radius:14px; box-shadow:0 8px 40px rgba(0,0,0,0.3); width:100%; max-width:700px; max-height:90vh; overflow-y:auto; padding:32px 32px 24px; position:relative; animation:slideUp 0.22s ease; }
@keyframes slideUp { from{transform:translateY(30px);opacity:0;} to{transform:translateY(0);opacity:1;} }
.modal-close { position:absolute; top:16px; right:20px; background:none; border:none; font-size:24px; cursor:pointer; color:#A08060; }
.modal-close:hover { color:#5C3D2E; }
.modal h2 { color:#5C3D2E; font-size:20px; margin-bottom:4px; }
.modal-subtitle { color:#A08060; font-size:13px; margin-bottom:18px; }
.modal-divider { border:none; border-top:1px solid #EDE0CE; margin:16px 0; }
.sec-title { font-size:13px; font-weight:bold; color:#5C3D2E; margin-bottom:8px; }

/* 검색 */
.modal-search-row { display:flex; gap:8px; margin-bottom:10px; }
.modal-search-row select { padding:9px 12px; border:1.5px solid #D4B896; border-radius:6px; background:#FFF8F0; font-family:inherit; font-size:13px; }
.modal-search-row input { flex:1; padding:9px 14px; border:1.5px solid #D4B896; border-radius:6px; background:#FFF8F0; font-family:inherit; font-size:13px; }
.modal-search-row input:focus,.modal-search-row select:focus { outline:none; border-color:#A0522D; }
.btn-ms { background:#5C3D2E; color:#FFF8F0; border:none; border-radius:6px; padding:9px 18px; cursor:pointer; font-size:13px; white-space:nowrap; font-family:inherit; }
.btn-ms:hover { background:#3D2719; }

/* 검색 결과 */
.result-box { background:#F9F4EE; border:1.5px solid #EDE0CE; border-radius:8px; min-height:68px; padding:10px 12px; font-size:13px; color:#A08060; display:flex; flex-direction:column; gap:5px; }
.result-item { background:#FFFDF8; border:1px solid #D4B896; border-radius:6px; padding:9px 12px; cursor:pointer; width:100%; font-size:13px; color:#3B2F2F; display:flex; align-items:center; gap:10px; transition:background 0.12s,border-color 0.12s; }
.result-item:hover { background:#FFF0DC; border-color:#A0522D; }
.result-item.selected { background:#FFF0DC; border-color:#2E7D6B; }
.result-item.disabled { opacity:0.5; cursor:not-allowed; }
.ri-check { width:22px; height:22px; border-radius:50%; border:2px solid #D4B896; display:flex; align-items:center; justify-content:center; flex-shrink:0; font-size:12px; transition:all 0.15s; }
.result-item.selected .ri-check { background:#2E7D6B; border-color:#2E7D6B; color:white; }
.ri-info { flex:1; }
.item-title { font-weight:bold; color:#5C3D2E; margin-bottom:2px; }
.item-sub { font-size:12px; color:#A08060; }
.rbadge { display:inline-block; padding:2px 8px; border-radius:12px; font-size:11px; margin-left:6px; }
.rb-ok { background:#E8F5E9; color:#2E7D32; }
.rb-no { background:#FFF3E0; color:#E65100; }
.hint { font-size:12px; color:#B09070; margin-top:4px; }

/* 선택된 도서 바구니 */
.cart-area { background:#F0FFF8; border:1.5px solid #A8D5C8; border-radius:8px; padding:12px 14px; margin-top:14px; }
.cart-title { font-size:12px; font-weight:bold; color:#2E7D6B; margin-bottom:8px; display:flex; justify-content:space-between; align-items:center; }
.cart-title span { font-weight:normal; font-size:11px; color:#A08060; cursor:pointer; text-decoration:underline; }
.cart-item { display:flex; align-items:center; justify-content:space-between; background:#FFFDF8; border:1px solid #C8E6DC; border-radius:6px; padding:7px 10px; margin-bottom:5px; font-size:12px; }
.cart-item:last-child { margin-bottom:0; }
.cart-item-title { font-weight:bold; color:#3B2F2F; }
.cart-item-sub { color:#A08060; font-size:11px; margin-top:1px; }
.cart-remove { background:none; border:none; color:#A08060; cursor:pointer; font-size:14px; padding:0 4px; line-height:1; }
.cart-remove:hover { color:#C62828; }
.cart-return-date { font-size:11px; color:#2E7D6B; margin-top:2px; }

/* 대출 신청 버튼 */
.btn-submit-loan { width:100%; background:#2E7D6B; color:white; border:none; border-radius:8px; padding:13px; font-size:15px; font-weight:bold; cursor:pointer; margin-top:14px; font-family:inherit; transition:background 0.2s; }
.btn-submit-loan:hover { background:#1E5C4E; }
.btn-submit-loan:disabled { background:#A8BFBA; cursor:not-allowed; }

/* 비로그인 */
.login-required-box { background:#FFF8EE; border:1.5px solid #E8C87A; border-radius:10px; padding:20px; text-align:center; }
.lrb-title { font-size:15px; font-weight:bold; color:#5C3D2E; margin-bottom:8px; }
.lrb-sub { font-size:13px; color:#A08060; margin-bottom:18px; }
.lrb-btn-row { display:flex; gap:10px; justify-content:center; }
.btn-go-login { background:#5C3D2E; color:#FFF8F0; border:none; border-radius:6px; padding:11px 28px; font-size:14px; font-weight:bold; cursor:pointer; font-family:inherit; text-decoration:none; display:inline-block; }
.btn-go-login:hover { background:#3D2719; }
.btn-go-join { background:#FFFDF8; color:#5C3D2E; border:1.5px solid #A0522D; border-radius:6px; padding:11px 28px; font-size:14px; cursor:pointer; font-family:inherit; text-decoration:none; display:inline-block; }
.btn-go-join:hover { background:#FFF0DC; }
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
      <c:choose>
        <c:when test="${not empty loginVO}">
          <div class="user-menu" id="userMenu">
            <button class="user-btn" onclick="toggleDropdown()">
              ${loginVO.userName}님 <span class="arrow">▼</span>
            </button>
            <div class="dropdown" id="dropdown">
              <div class="dropdown-header">📋 내 대출 현황</div>
              <div class="dropdown-body" id="dropdownBody">
                <div class="empty-drop">불러오는 중...</div>
              </div>
              <div class="dropdown-footer">
                <a href="${pageContext.request.contextPath}/loan/myLoan.do">전체 보기 →</a>
              </div>
            </div>
          </div>
          <a href="${pageContext.request.contextPath}/user/logout.do" onclick="return confirm('로그아웃 하시겠습니까?')">로그아웃</a>
        </c:when>
        <c:otherwise>
          <a href="${pageContext.request.contextPath}/user/loginView.do">로그인</a>
          <a href="${pageContext.request.contextPath}/user/joinView.do">회원가입</a>
        </c:otherwise>
      </c:choose>
    </div>
  </div>
</div>

<div class="container">
  <div class="page-header">
    <div class="page-title">도서 목록</div>
    <div class="btn-group">
      <button class="btn-loan" onclick="openLoanModal()">📖 도서 대여</button>
      <c:if test="${loginVO.role == 'ADMIN'}">
        <a href="${pageContext.request.contextPath}/book/bookRegisterView.do" class="btn-register">+ 도서 등록</a>
      </c:if>
    </div>
  </div>

  <div class="search-box">
    <form action="${pageContext.request.contextPath}/book/bookSearch.do" method="get" style="display:flex;gap:10px;align-items:center;flex-wrap:wrap;width:100%;">
      <select name="searchType">
        <option value="title" <c:if test="${searchType=='title'}">selected</c:if>>제목</option>
        <option value="author" <c:if test="${searchType=='author'}">selected</c:if>>저자</option>
        <option value="publisher" <c:if test="${searchType=='publisher'}">selected</c:if>>출판사</option>
      </select>
      <input type="text" name="keyword" value="${keyword}" placeholder="검색어를 입력하세요" style="flex:1;min-width:180px;">
      <button type="submit" class="btn-search">검색</button>
      <c:if test="${not empty keyword}">
        <a href="${pageContext.request.contextPath}/book/bookList.do" class="btn-search" style="text-decoration:none;background:#A08060;">전체 보기</a>
      </c:if>
    </form>
  </div>

  <div class="table-card">
    <table>
      <thead>
        <tr>
          <th>번호</th>
          <th>도서명</th>
          <th>저자</th>
          <th>출판사</th>
          <th>상태</th>
          <c:if test="${loginVO.role == 'ADMIN'}"><th>관리</th></c:if>
        </tr>
      </thead>
      <tbody>
        <c:choose>
          <c:when test="${empty bookList}">
            <tr><td colspan="6" class="empty-msg">등록된 도서가 없습니다.</td></tr>
          </c:when>
          <c:otherwise>
            <c:forEach var="book" items="${bookList}">
              <tr>
                <td>${book.bookId}</td>
                <td style="text-align:left;padding-left:20px;">${book.title}</td>
                <td>${book.author}</td>
                <td>${book.publisher}</td>
                <td>
                  <c:choose>
                    <c:when test="${book.status == 'Y'}"><span class="badge badge-available">대출가능</span></c:when>
                    <c:otherwise><span class="badge badge-loaned">대출중</span></c:otherwise>
                  </c:choose>
                </td>
                <c:if test="${loginVO.role == 'ADMIN'}">
                  <td>
                    <a href="${pageContext.request.contextPath}/book/bookModifyView.do?bookId=${book.bookId}" class="btn-edit">수정</a>
                    <a href="${pageContext.request.contextPath}/book/bookDelete.do?bookId=${book.bookId}" class="btn-delete" onclick="return confirm('삭제하시겠습니까?')">삭제</a>
                  </td>
                </c:if>
              </tr>
            </c:forEach>
          </c:otherwise>
        </c:choose>
      </tbody>
    </table>
  </div>
</div>

<div class="footer">2026 폴리 인공지능 도서관 - Poly AI Library</div>

<div class="modal-overlay" id="loanModal" onclick="closeBg(event)">
  <div class="modal">
    <button class="modal-close" onclick="closeLoanModal()">✕</button>
    <h2>📖 도서 대출 신청</h2>
    <c:choose>
      <c:when test="${not empty loginVO}">
        <p class="modal-subtitle">${loginVO.userName}님 — 도서를 검색하고 클릭해서 선택하세요. 여러 권도 가능합니다.</p>

        <div class="sec-title">도서 검색</div>
        <div class="modal-search-row">
          <select id="bookSearchType">
            <option value="title">제목</option>
            <option value="author">저자</option>
            <option value="publisher">출판사</option>
          </select>
          <input type="text" id="bookKeyword" placeholder="예) 노인과 바다" onkeydown="if(event.key==='Enter') searchBook()">
          <button class="btn-ms" onclick="searchBook()">검색</button>
        </div>
        <div class="result-box" id="bookResultBox"><span>검색 결과가 여기에 표시됩니다.</span></div>
        <p class="hint">클릭하면 선택(✔), 다시 클릭하면 해제. 검색어가 바뀌어도 선택된 도서는 유지됩니다.</p>

        <div class="cart-area" id="cartArea" style="display:none;">
          <div class="cart-title">
            선택된 도서 <span id="cartCount">0</span>권
            <span onclick="clearCart()">전체 해제</span>
          </div>
          <div id="cartList"></div>
        </div>

        <form id="loanForm" action="${pageContext.request.contextPath}/loan/loanApplyMulti.do" method="post">
          <input type="hidden" name="memberId" value="${loginVO.userId}">
          <div id="cartHiddens"></div>
          <button type="button" class="btn-submit-loan" id="loanSubmitBtn" disabled onclick="submitLoan()">
            대출 신청하기 (<span id="btnCount">0</span>권)
          </button>
        </form>
      </c:when>
      <c:otherwise>
        <p class="modal-subtitle">대출할 도서를 먼저 검색해보세요.</p>
        <div class="sec-title">도서 검색</div>
        <div class="modal-search-row">
          <select id="bookSearchType">
            <option value="title">제목</option>
            <option value="author">저자</option>
            <option value="publisher">출판사</option>
          </select>
          <input type="text" id="bookKeyword" placeholder="예) 노인과 바다" onkeydown="if(event.key==='Enter') searchBook()">
          <button class="btn-ms" onclick="searchBook()">검색</button>
        </div>
        <div class="result-box" id="bookResultBox"><span>검색 결과가 여기에 표시됩니다.</span></div>
        <hr class="modal-divider">
        <div class="login-required-box">
          <div class="lrb-title">대출 신청은 로그인이 필요합니다</div>
          <div class="lrb-sub">원하는 도서를 찾으셨나요? 로그인 후 바로 대출할 수 있습니다.</div>
          <div class="lrb-btn-row">
            <a href="${pageContext.request.contextPath}/user/loginView.do?returnUrl=/book/bookList.do" class="btn-go-login">로그인 하기</a>
            <a href="${pageContext.request.contextPath}/user/joinView.do?returnUrl=/book/bookList.do" class="btn-go-join">회원가입 하기</a>
          </div>
        </div>
      </c:otherwise>
    </c:choose>
  </div>
</div>

<script>
var CP = '${pageContext.request.contextPath}';
var dropLoaded = false;

/* ── 장바구니: bookId → book 객체 ── */
var cart = {};

/* ── 토스트 ── */
function showToast(msg, isErr) {
  var t = document.getElementById('toast');
  t.textContent = msg;
  t.className = 'toast' + (isErr ? ' err' : '');
  t.style.display = 'block';
  setTimeout(function(){ t.style.display = 'none'; }, 3000);
}
(function(){
  var p = new URLSearchParams(window.location.search);
  var m = p.get('msg');
  if(m) showToast(decodeURIComponent(m), m.indexOf('오류') > -1 || m.indexOf('이미') > -1);
})();

/* ── 헤더 드롭다운 ── */
function toggleDropdown() {
  var menu = document.getElementById('userMenu');
  var isOpen = menu.classList.contains('open');
  if(isOpen) { menu.classList.remove('open'); }
  else { menu.classList.add('open'); if(!dropLoaded) loadLoanSummary(); }
}
document.addEventListener('click', function(e) {
  var menu = document.getElementById('userMenu');
  if(menu && !menu.contains(e.target)) menu.classList.remove('open');
});
function loadLoanSummary() {
  ajax(CP + '/loan/myLoanSummary.do', function(data) {
    dropLoaded = true;
    var body = document.getElementById('dropdownBody');
    if(!data || !data.length) { body.innerHTML = '<div class="empty-drop">대출 중인 도서가 없습니다.</div>'; return; }
    var h = '';
    data.forEach(function(loan) {
      var dc = loan.ddayClass || 'dday-ok';
      h += '<div class="loan-item">';
      h += '<div class="li-title">' + safeText(loan.bookTitle) + '</div>';
      h += '<div class="li-meta"><span>반납예정: ' + safeText(loan.returnDate) + '</span>';
      h += '<span class="li-dday ' + dc + '">' + safeText(loan.ddayLabel) + '</span></div>';
      h += '</div>';
    });
    body.innerHTML = h;
  }, function() {
    document.getElementById('dropdownBody').innerHTML = '<div class="empty-drop">불러오기 실패</div>';
  });
}

/* ── 모달 open/close ── */
function openLoanModal() { document.getElementById('loanModal').classList.add('active'); document.body.style.overflow = 'hidden'; }
function closeLoanModal() { document.getElementById('loanModal').classList.remove('active'); document.body.style.overflow = ''; }
function closeBg(e) { if(e.target === document.getElementById('loanModal')) closeLoanModal(); }

/* ── 14일 후 날짜 ── */
function calcReturnDate() {
  var d = new Date();
  d.setDate(d.getDate() + 14);
  return d.getFullYear() + '-' + pad(d.getMonth()+1) + '-' + pad(d.getDate());
}
function pad(n){ return String(n).padStart(2,'0'); }

/* ── 도서 검색 ── */
var searchCache = {};
function searchBook() {
  var t = document.getElementById('bookSearchType').value;
  var k = document.getElementById('bookKeyword').value.trim();
  var box = document.getElementById('bookResultBox');
  if(!k) { box.innerHTML = '<span>검색어를 입력해주세요.</span>'; return; }
  box.innerHTML = '<span>검색 중...</span>';
  ajax(CP + '/loan/searchBook.do?searchType=' + enc(t) + '&keyword=' + enc(k), function(data) {
    /* 검색 결과를 캐시에도 저장 */
    if(data) data.forEach(function(b){ searchCache[b.bookId] = b; });
    renderResults(data);
  }, function() {
    box.innerHTML = '<span style="color:#C0392B;">서버 오류가 발생했습니다.</span>';
  });
}

function renderResults(data) {
  var box = document.getElementById('bookResultBox');
  if(!data || !data.length) { box.innerHTML = '<span>검색 결과가 없습니다.</span>'; return; }
  var h = '';
  data.forEach(function(b) {
    var av = b.status === 'Y';
    var inCart = !!cart[b.bookId];
    var cls = 'result-item' + (!av ? ' disabled' : (inCart ? ' selected' : ''));
    h += '<div class="' + cls + '" data-bookid="' + b.bookId + '">';
    h += '<div class="ri-check">' + (inCart ? '✔' : '') + '</div>';
    h += '<div class="ri-info">';
    h += '<div class="item-title">' + safeText(b.title);
    h += av ? '<span class="rbadge rb-ok">대출가능</span>' : '<span class="rbadge rb-no">대출중</span>';
    h += '</div>';
    h += '<div class="item-sub">저자: ' + safeText(b.author) + ' | 출판사: ' + safeText(b.publisher) + '</div>';
    h += '</div></div>';
  });
  box.innerHTML = h;

  /* 클릭 이벤트 — data-bookid 방식으로 JSON.stringify 문제 완전 우회 */
  box.querySelectorAll('.result-item').forEach(function(el) {
    el.addEventListener('click', function() {
      var bid = parseInt(el.getAttribute('data-bookid'));
      var book = searchCache[bid];
      if(!book || book.status !== 'Y') { showToast('대출 중인 도서입니다.', true); return; }
      if(cart[bid]) {
        delete cart[bid];
        el.classList.remove('selected');
        el.querySelector('.ri-check').textContent = '';
      } else {
        cart[bid] = book;
        el.classList.add('selected');
        el.querySelector('.ri-check').textContent = '✔';
      }
      updateCart();
    });
  });
}

/* ── 장바구니 UI 업데이트 ── */
function updateCart() {
  var keys = Object.keys(cart);
  var cartArea = document.getElementById('cartArea');
  var cartList = document.getElementById('cartList');
  var cartCount = document.getElementById('cartCount');
  var btnCount = document.getElementById('btnCount');
  var btn = document.getElementById('loanSubmitBtn');
  var hiddens = document.getElementById('cartHiddens');

  cartCount.textContent = keys.length;
  btnCount.textContent = keys.length;
  btn.disabled = keys.length === 0;

  if(keys.length === 0) {
    cartArea.style.display = 'none';
    cartList.innerHTML = '';
    hiddens.innerHTML = '';
    return;
  }

  cartArea.style.display = 'block';
  var h = '';
  var hh = '';
  var rd = calcReturnDate();
  keys.forEach(function(bid) {
    var b = cart[bid];
    h += '<div class="cart-item">';
    h += '<div><div class="cart-item-title">' + safeText(b.title) + '</div>';
    h += '<div class="cart-item-sub">저자: ' + safeText(b.author) + '</div>';
    h += '<div class="cart-return-date">반납예정: ' + rd + '</div></div>';
    h += '<button class="cart-remove" data-remove="' + bid + '">✕</button>';
    h += '</div>';
    hh += '<input type="hidden" name="bookIds" value="' + bid + '">';
  });
  cartList.innerHTML = h;
  hiddens.innerHTML = hh;

  /* 장바구니 제거 버튼 */
  cartList.querySelectorAll('.cart-remove').forEach(function(btn) {
    btn.addEventListener('click', function() {
      var bid = parseInt(btn.getAttribute('data-remove'));
      delete cart[bid];
      /* 현재 검색 결과에서도 선택 해제 */
      var el = document.querySelector('.result-item[data-bookid="' + bid + '"]');
      if(el) { el.classList.remove('selected'); el.querySelector('.ri-check').textContent = ''; }
      updateCart();
    });
  });
}

function clearCart() {
  cart = {};
  document.querySelectorAll('.result-item.selected').forEach(function(el) {
    el.classList.remove('selected');
    el.querySelector('.ri-check').textContent = '';
  });
  updateCart();
}

/* ── 대출 신청 ── */
function submitLoan() {
  var keys = Object.keys(cart);
  if(keys.length === 0) { alert('도서를 선택해주세요.'); return; }
  var titles = keys.map(function(k){ return '"' + cart[k].title + '"'; }).join(', ');
  if(confirm(keys.length + '권을 대출하시겠습니까?\n' + titles + '\n\n반납예정일: ' + calcReturnDate()))
    document.getElementById('loanForm').submit();
}

/* ── 유틸 ── */
function safeText(s) {
  if(!s) return '';
  return String(s).replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/>/g,'&gt;');
}
function ajax(url, success, error) {
  var x = new XMLHttpRequest();
  x.open('GET', url, true);
  x.onload = function() {
    if(x.status === 200) { try { success(JSON.parse(x.responseText)); } catch(e) { error && error(e); } }
    else { error && error(); }
  };
  x.onerror = function() { error && error(); };
  x.send();
}
function enc(s) { return encodeURIComponent(s); }
</script>
</body>
</html>
