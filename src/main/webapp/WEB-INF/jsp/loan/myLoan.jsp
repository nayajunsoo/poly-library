<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="https://fonts.googleapis.com/css2?family=Noto+Serif+KR:wght@400;700&display=swap" rel="stylesheet">
<title>내 대출 현황 - 폴리 인공지능 도서관</title>
<style>
*{margin:0;padding:0;box-sizing:border-box;}
html,body{overflow-x:hidden;max-width:100%;}
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

/* AI 도서 추천 */
.ai-section{background:#FFFDF8;border-radius:14px;box-shadow:0 2px 14px rgba(92,61,46,0.1);padding:28px 28px 24px;margin-top:36px;}
.ai-section-title{font-size:18px;font-weight:bold;color:#5C3D2E;border-left:5px solid #C8A96E;padding-left:12px;margin-bottom:18px;}
.cat-grid{display:flex;flex-wrap:wrap;gap:10px;margin-bottom:22px;}
.cat-btn{background:#F5EEE6;color:#5C3D2E;border:1.5px solid #C8A96E;border-radius:20px;padding:8px 18px;font-size:13px;font-family:inherit;cursor:pointer;transition:all 0.2s;}
.cat-btn:hover{background:#EDD9B8;border-color:#A0522D;}
.cat-btn.active{background:#5C3D2E;color:#F5E6C8;border-color:#5C3D2E;}
.ai-loading{text-align:center;color:#A08060;padding:32px;font-size:14px;}
.ai-spinner{display:inline-block;width:18px;height:18px;border:3px solid #DDD0BC;border-top-color:#A0522D;border-radius:50%;animation:spin 0.8s linear infinite;margin-right:8px;vertical-align:middle;}
@keyframes spin{to{transform:rotate(360deg)}}
.ai-book-list{display:flex;flex-direction:column;gap:12px;}
.ai-book-card{background:#F9F4EE;border-radius:10px;padding:14px 18px;display:flex;align-items:center;gap:14px;border:1px solid #E4D5C0;}
.ai-book-num{min-width:28px;height:28px;background:#5C3D2E;color:#F5E6C8;border-radius:50%;display:flex;align-items:center;justify-content:center;font-size:13px;font-weight:bold;}
.ai-book-info{flex:1;}
.ai-book-title{font-size:14px;font-weight:bold;color:#3B2F2F;margin-bottom:2px;}
.ai-book-meta{font-size:12px;color:#A08060;}
.badge-avail{background:#E8F5E9;color:#2E7D32;border-radius:12px;padding:3px 10px;font-size:11px;font-weight:bold;margin-left:8px;}
.badge-none{background:#F3EBE1;color:#A0522D;border-radius:12px;padding:3px 10px;font-size:11px;}
.btn-loan-ai{background:#2E7D6B;color:#fff;border:none;border-radius:6px;padding:8px 16px;font-size:12px;font-weight:bold;cursor:pointer;font-family:inherit;white-space:nowrap;}
.btn-loan-ai:hover{background:#1B5E4F;}
.btn-request{background:#F5EEE6;color:#A0522D;border:1.5px solid #C8A96E;border-radius:6px;padding:7px 14px;font-size:12px;cursor:pointer;font-family:inherit;white-space:nowrap;}
.btn-request:hover{background:#EDD9B8;}
.ai-error{text-align:center;color:#C62828;padding:24px;font-size:13px;}
.ai-hint{font-size:12px;color:#B09070;text-align:center;margin-top:16px;}
.hamburger{display:none;background:none;border:none;color:#F5E6C8;font-size:24px;cursor:pointer;padding:4px 8px;line-height:1;}
@media (max-width:767px){
  .header,.header-inner,.container,.loan-card,.card-inner,.summary-bar,.ai-section,.ai-book-card{max-width:100%;box-sizing:border-box;}
  .hamburger{display:block;}
  .nav-links{display:none;}
  .header-inner{padding:12px 16px;}
  .header h1{font-size:16px;}
  .container{padding:0 12px;margin:20px auto;}
  .page-title{font-size:18px;}
  .card-inner{flex-wrap:wrap;gap:12px;padding:14px 14px;}
  .card-dday{min-width:unset;}
  .book-title{font-size:14px;}
  .btn-return,.btn-pending{width:100%;padding:12px;}
  .ai-section{padding:20px 16px 18px;}
  .ai-section-title{font-size:16px;}
  .cat-grid{gap:8px;}
  .cat-btn{padding:9px 14px;font-size:12px;}
  .ai-book-card{flex-wrap:wrap;gap:10px;padding:12px 14px;}
  .btn-loan-ai,.btn-request{width:100%;padding:10px;}
}
@media (min-width:768px) and (max-width:1024px){
  .container{max-width:700px;padding:0 20px;}
  .cat-btn{padding:8px 14px;}
}
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
    <button class="hamburger" onclick="openMobileNav()">☰</button>
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

  <!-- AI 도서 추천 섹션 -->
  <div class="ai-section">
    <div class="ai-section-title">✨ AI 도서 추천</div>
    <div class="cat-grid">
      <button class="cat-btn" onclick="loadAiRecommend(this, '컴퓨터/IT')">💻 컴퓨터/IT</button>
      <button class="cat-btn" onclick="loadAiRecommend(this, '소설/문학')">📖 소설/문학</button>
      <button class="cat-btn" onclick="loadAiRecommend(this, '인문/사회')">🏛 인문/사회</button>
      <button class="cat-btn" onclick="loadAiRecommend(this, '경영/경제')">📊 경영/경제</button>
      <button class="cat-btn" onclick="loadAiRecommend(this, '과학/기술')">🔬 과학/기술</button>
      <button class="cat-btn" onclick="loadAiRecommend(this, '자기계발')">🌱 자기계발</button>
      <button class="cat-btn" onclick="loadAiRecommend(this, '역사/문화')">🏺 역사/문화</button>
      <button class="cat-btn" onclick="loadAiRecommend(this, '의학/건강')">❤️ 의학/건강</button>
    </div>
    <div id="ai-result">
      <div class="ai-hint">카테고리를 선택하면 AI가 도서를 추천해드립니다.</div>
    </div>
  </div>
</div>
<div class="footer">© 2026 폴리 인공지능 도서관</div>

<div id="navOverlay" onclick="closeMobileNav()" style="display:none;position:fixed;inset:0;background:rgba(0,0,0,0.5);z-index:499;"></div>
<nav id="mobileNav" style="display:none;position:fixed;top:0;right:0;width:260px;height:100vh;background:#3B2010;z-index:500;flex-direction:column;overflow-y:auto;">
  <div style="background:#5C3D2E;padding:16px 18px;display:flex;justify-content:space-between;align-items:center;">
    <span style="color:#F5E6C8;font-size:14px;font-weight:bold;">📚 폴리 도서관</span>
    <button onclick="closeMobileNav()" style="background:none;border:none;color:#F5E6C8;font-size:20px;cursor:pointer;">✕</button>
  </div>
  <div style="padding:16px;display:flex;flex-direction:column;gap:2px;">
    <a href="${pageContext.request.contextPath}/book/bookList.do" style="color:#F5E6C8;text-decoration:none;padding:12px 8px;border-bottom:1px solid rgba(255,255,255,0.08);font-size:14px;">📖 도서 목록</a>
    <a href="${pageContext.request.contextPath}/loan/myLoan.do" style="color:#F5E6C8;text-decoration:none;padding:12px 8px;border-bottom:1px solid rgba(255,255,255,0.08);font-size:14px;">📋 내 대출현황</a>
    <a href="${pageContext.request.contextPath}/user/logout.do" onclick="return confirm('로그아웃 하시겠습니까?')" style="color:#C4A882;text-decoration:none;padding:12px 8px;font-size:14px;">🚪 로그아웃</a>
  </div>
</nav>

<script>
function openMobileNav(){document.getElementById('mobileNav').style.display='flex';document.getElementById('navOverlay').style.display='block';document.body.style.overflow='hidden';}
function closeMobileNav(){document.getElementById('mobileNav').style.display='none';document.getElementById('navOverlay').style.display='none';document.body.style.overflow='';}
var msg = '${msg}';
if(msg && msg !== '') {
    var t = document.getElementById('toast');
    t.textContent = decodeURIComponent(msg.replace(/\+/g,' '));
    t.style.display = 'block';
    setTimeout(function(){ t.style.display='none'; }, 3000);
}

var ctx = '${pageContext.request.contextPath}';
var memberId = '${sessionScope.loginVO.userId}';

function loadAiRecommend(btn, category) {
    document.querySelectorAll('.cat-btn').forEach(function(b){ b.classList.remove('active'); });
    btn.classList.add('active');

    var resultDiv = document.getElementById('ai-result');
    resultDiv.innerHTML = '<div class="ai-loading"><span class="ai-spinner"></span>AI가 ' + category + ' 추천 도서를 분석 중입니다...</div>';

    fetch(ctx + '/loan/aiRecommend.do?category=' + encodeURIComponent(category))
        .then(function(r){ return r.json(); })
        .then(function(data){
            if (data.error) {
                resultDiv.innerHTML = '<div class="ai-error">오류: ' + data.error + '</div>';
                return;
            }
            var html = '<div class="ai-book-list">';
            data.forEach(function(item, i){
                var metaHtml = '';
                if (item.author) metaHtml += item.author;
                if (item.publisher) metaHtml += (metaHtml ? ' · ' : '') + item.publisher;

                var badgeHtml = item.available
                    ? '<span class="badge-avail">대출 가능</span>'
                    : '<span class="badge-none">미보유/대출중</span>';

                var btnHtml = '';
                if (item.available && item.bookId) {
                    btnHtml = '<form action="' + ctx + '/loan/loanApply.do" method="post" style="display:inline">'
                        + '<input type="hidden" name="bookId" value="' + item.bookId + '">'
                        + '<input type="hidden" name="memberId" value="' + memberId + '">'
                        + '<button type="submit" class="btn-loan-ai" onclick="return confirm(\'&quot;' + escapeHtml(item.title) + '&quot;를 대출하시겠습니까?\')">대여하기</button>'
                        + '</form>';
                } else {
                    btnHtml = '<button class="btn-request" onclick="requestStock(\'' + escapeHtml(item.title) + '\')">입고요청</button>';
                }

                html += '<div class="ai-book-card">'
                    + '<div class="ai-book-num">' + (i+1) + '</div>'
                    + '<div class="ai-book-info">'
                    + '<div class="ai-book-title">' + escapeHtml(item.title) + badgeHtml + '</div>'
                    + (metaHtml ? '<div class="ai-book-meta">' + escapeHtml(metaHtml) + '</div>' : '')
                    + '</div>'
                    + btnHtml
                    + '</div>';
            });
            html += '</div>';
            resultDiv.innerHTML = html;
        })
        .catch(function(){
            resultDiv.innerHTML = '<div class="ai-error">추천 도서를 불러오는 중 오류가 발생했습니다. 잠시 후 다시 시도해주세요.</div>';
        });
}

function requestStock(title) {
    showToast('"' + title + '" 입고 요청이 접수되었습니다.');
}

function showToast(message) {
    var t = document.getElementById('toast');
    t.textContent = message;
    t.style.display = 'block';
    setTimeout(function(){ t.style.display='none'; }, 3000);
}

function escapeHtml(str) {
    if (!str) return '';
    return str.replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/>/g,'&gt;').replace(/"/g,'&quot;').replace(/'/g,'&#39;');
}
</script>
</body>
</html>
