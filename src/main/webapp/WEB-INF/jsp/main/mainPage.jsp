<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://fonts.googleapis.com/css2?family=Noto+Serif+KR:wght@400;700&display=swap" rel="stylesheet">
<title>폴리 인공지능 도서관</title>
<style>
*{margin:0;padding:0;box-sizing:border-box;}
body{font-family:'Noto Serif KR',serif;background:#F5F0E8;color:#3B2F2F;min-height:100vh;}
/* 헤더 */
.header{background:#5C3D2E;box-shadow:0 2px 8px rgba(0,0,0,0.3);position:sticky;top:0;z-index:200;}
.header-inner{max-width:1200px;margin:0 auto;padding:14px 30px;display:flex;align-items:center;justify-content:space-between;gap:20px;}
.logo h1{color:#F5E6C8;font-size:20px;letter-spacing:1px;white-space:nowrap;}
.logo .sub{color:#C4A882;font-size:11px;margin-top:2px;}
/* 헤더 검색바 */
.header-search{flex:1;max-width:440px;display:flex;gap:0;}
.header-search input{flex:1;padding:9px 14px;border:none;border-radius:6px 0 0 6px;font-size:13px;font-family:inherit;background:#FFF8F0;}
.header-search button{padding:9px 16px;background:#A0522D;color:#fff;border:none;border-radius:0 6px 6px 0;cursor:pointer;font-size:13px;}
.header-search button:hover{background:#7B3A1F;}
.nav-links{display:flex;align-items:center;gap:18px;flex-shrink:0;}
.nav-links a{color:#F5E6C8;text-decoration:none;font-size:13px;transition:color 0.2s;}
.nav-links a:hover{color:#E8C87A;}
/* 유저 드롭다운 */
.user-menu{position:relative;}
.user-btn{color:#C4A882;font-size:13px;cursor:pointer;background:none;border:none;font-family:inherit;display:flex;align-items:center;gap:5px;}
.dropdown{display:none;position:absolute;top:calc(100% + 12px);right:0;width:270px;background:#FFFDF8;border-radius:10px;box-shadow:0 8px 30px rgba(0,0,0,0.25);border:1px solid #EDE0CE;overflow:hidden;}
.user-menu.open .dropdown{display:block;animation:fadeDown 0.18s ease;}
@keyframes fadeDown{from{opacity:0;transform:translateY(-8px)}to{opacity:1;transform:translateY(0)}}
.dropdown-header{background:#5C3D2E;padding:10px 14px;color:#F5E6C8;font-size:12px;font-weight:bold;}
.dropdown-body{padding:8px 0;max-height:220px;overflow-y:auto;}
.loan-item{padding:9px 14px;border-bottom:1px solid #F0E8DC;}
.loan-item:last-child{border-bottom:none;}
.li-title{font-size:12px;font-weight:bold;color:#3B2F2F;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;}
.li-meta{font-size:10px;color:#A08060;display:flex;justify-content:space-between;margin-top:2px;}
.li-dday{font-size:10px;font-weight:bold;padding:1px 6px;border-radius:8px;}
.dday-ok{background:#E8F5E9;color:#2E7D32;}
.dday-warn{background:#FFF3E0;color:#E65100;}
.dday-over{background:#FFEBEE;color:#C62828;}
.empty-drop{padding:16px;text-align:center;font-size:12px;color:#A08060;}
.dropdown-footer{border-top:1px solid #EDE0CE;padding:8px 14px;text-align:center;}
.dropdown-footer a{color:#A0522D;font-size:12px;font-weight:bold;text-decoration:none;}
/* 히어로 배너 */
.hero{background:linear-gradient(135deg,#5C3D2E 0%,#3B2010 100%);padding:48px 30px;text-align:center;position:relative;overflow:hidden;}
.hero::before{content:'📚';position:absolute;font-size:200px;opacity:0.04;top:-20px;right:-20px;}
.hero h2{color:#F5E6C8;font-size:32px;margin-bottom:10px;letter-spacing:1px;}
.hero p{color:#C4A882;font-size:15px;margin-bottom:28px;}
.hero-search{max-width:560px;margin:0 auto;display:flex;gap:0;box-shadow:0 4px 20px rgba(0,0,0,0.3);}
.hero-search select{padding:13px 14px;border:none;border-radius:8px 0 0 8px;font-size:14px;background:#FFF8F0;font-family:inherit;color:#3B2F2F;}
.hero-search input{flex:1;padding:13px 16px;border:none;font-size:14px;font-family:inherit;background:#FFFDF8;}
.hero-search button{padding:13px 22px;background:#A0522D;color:#fff;border:none;border-radius:0 8px 8px 0;font-size:14px;cursor:pointer;font-weight:bold;}
.hero-search button:hover{background:#7B3A1F;}
/* 컨테이너 */
.container{max-width:1200px;margin:0 auto;padding:36px 30px;}
/* 섹션 헤더 */
.sec-hdr{display:flex;align-items:center;justify-content:space-between;margin-bottom:20px;}
.sec-title{font-size:20px;color:#5C3D2E;font-weight:bold;border-left:4px solid #A0522D;padding-left:12px;display:flex;align-items:center;gap:8px;}
.sec-badge{background:#A0522D;color:#fff;font-size:11px;padding:2px 9px;border-radius:20px;font-weight:normal;}
.sec-link{color:#A0522D;text-decoration:none;font-size:13px;}
.sec-link:hover{text-decoration:underline;}
/* TOP30 그리드 */
.top30-grid{display:grid;grid-template-columns:repeat(auto-fill,minmax(320px,1fr));gap:14px;margin-bottom:48px;}
.book-card{background:#FFFDF8;border-radius:10px;box-shadow:0 2px 8px rgba(92,61,46,0.1);padding:16px 18px;display:flex;align-items:flex-start;gap:12px;cursor:pointer;border:1.5px solid transparent;transition:all 0.15s;}
.book-card:hover{box-shadow:0 6px 18px rgba(92,61,46,0.18);transform:translateY(-2px);border-color:#D4B896;}
.rank-badge{min-width:38px;height:38px;border-radius:50%;display:flex;align-items:center;justify-content:center;font-size:14px;font-weight:bold;flex-shrink:0;}
.r1{background:#FFD700;color:#5C3D2E;}
.r2{background:#C0C0C0;color:#3B2F2F;}
.r3{background:#CD7F32;color:#fff;}
.ro{background:#E8D5B0;color:#5C3D2E;font-size:12px;}
.bi{flex:1;min-width:0;}
.bt{font-size:14px;font-weight:bold;color:#3B2F2F;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;margin-bottom:2px;}
.bm{font-size:11px;color:#A08060;margin-bottom:5px;}
.bb{display:flex;align-items:center;justify-content:space-between;}
.cat-chip{font-size:10px;background:#EEF7F4;color:#2E7D6B;padding:2px 7px;border-radius:8px;}
.loan-cnt{font-size:10px;color:#A08060;}
.status-y{background:#E8F5E9;color:#2E7D32;font-size:10px;font-weight:bold;padding:2px 8px;border-radius:8px;}
.status-n{background:#FFF3E0;color:#E65100;font-size:10px;font-weight:bold;padding:2px 8px;border-radius:8px;}
/* AI 추천 섹션 */
.ai-section{background:#FFFDF8;border-radius:14px;box-shadow:0 2px 12px rgba(92,61,46,0.1);margin-bottom:48px;overflow:hidden;}
.ai-header{background:linear-gradient(90deg,#2E4057,#1E2D40);padding:20px 28px;display:flex;align-items:center;justify-content:space-between;}
.ai-title{color:#E8F0FF;font-size:18px;font-weight:bold;display:flex;align-items:center;gap:10px;}
.ai-badge{background:#4A90D9;color:#fff;font-size:11px;padding:3px 10px;border-radius:20px;}
.ai-body{padding:32px 28px;display:flex;flex-direction:column;align-items:center;justify-content:center;min-height:220px;text-align:center;}
.ai-placeholder-icon{font-size:56px;margin-bottom:16px;opacity:0.6;}
.ai-placeholder-title{font-size:18px;font-weight:bold;color:#5C3D2E;margin-bottom:8px;}
.ai-placeholder-desc{font-size:13px;color:#A08060;line-height:1.7;margin-bottom:20px;max-width:500px;}
.ai-coming-badge{background:#EEF7F4;border:2px dashed #2E7D6B;color:#2E7D6B;padding:10px 24px;border-radius:8px;font-size:13px;font-weight:bold;display:inline-block;}
.ai-week-label{font-size:11px;color:#A08060;margin-top:8px;}
/* 대출 모달 */
.modal-overlay{display:none;position:fixed;top:0;left:0;width:100%;height:100%;background:rgba(0,0,0,0.55);z-index:1000;justify-content:center;align-items:center;}
.modal-overlay.active{display:flex;}
.modal{background:#FFFDF8;border-radius:14px;box-shadow:0 8px 40px rgba(0,0,0,0.3);width:100%;max-width:660px;max-height:90vh;overflow-y:auto;padding:26px 26px 18px;position:relative;animation:slideUp 0.2s ease;}
@keyframes slideUp{from{transform:translateY(30px);opacity:0;}to{transform:translateY(0);opacity:1;}}
.modal-close{position:absolute;top:12px;right:16px;background:none;border:none;font-size:20px;cursor:pointer;color:#A08060;}
.modal h2{color:#5C3D2E;font-size:17px;margin-bottom:3px;}
.modal-sub{color:#A08060;font-size:11px;margin-bottom:14px;}
hr.mdv{border:none;border-top:1px solid #EDE0CE;margin:10px 0;}
.sec-t{font-size:11px;font-weight:bold;color:#5C3D2E;margin-bottom:5px;}
.ms-row{display:flex;gap:7px;margin-bottom:7px;}
.ms-row select,.ms-row input{padding:7px 10px;border:1.5px solid #D4B896;border-radius:5px;background:#FFF8F0;font-size:12px;font-family:inherit;}
.ms-row input{flex:1;}
.btn-ms{background:#5C3D2E;color:#fff;border:none;border-radius:5px;padding:7px 14px;cursor:pointer;font-size:12px;}
.rbox{background:#F9F4EE;border:1.5px solid #EDE0CE;border-radius:7px;min-height:56px;padding:8px 10px;font-size:11px;color:#A08060;display:flex;flex-direction:column;gap:4px;}
.ri{background:#FFFDF8;border:1px solid #D4B896;border-radius:5px;padding:7px 9px;cursor:pointer;display:flex;align-items:center;gap:7px;transition:background 0.12s;}
.ri:hover{background:#FFF0DC;border-color:#A0522D;}
.ri.sel{background:#FFF0DC;border-color:#2E7D6B;}
.ri.dis{opacity:0.5;cursor:not-allowed;}
.ri-chk{width:18px;height:18px;border-radius:50%;border:2px solid #D4B896;display:flex;align-items:center;justify-content:center;flex-shrink:0;font-size:10px;}
.ri.sel .ri-chk{background:#2E7D6B;border-color:#2E7D6B;color:#fff;}
.ri-info{flex:1;}
.ri-t{font-weight:bold;color:#5C3D2E;font-size:12px;margin-bottom:1px;}
.ri-s{font-size:10px;color:#A08060;}
.cart-area{background:#EEF7F4;border:1.5px solid #A8D5C8;border-radius:7px;padding:8px 10px;min-height:38px;display:flex;flex-wrap:wrap;gap:5px;}
.c-chip{background:#2E7D6B;color:#fff;border-radius:16px;padding:3px 9px;font-size:11px;display:flex;align-items:center;gap:4px;}
.c-chip button{background:none;border:none;color:#fff;cursor:pointer;font-size:11px;line-height:1;}
.mfooter{margin-top:12px;display:flex;gap:8px;justify-content:flex-end;}
.btn-ok{background:#2E7D6B;color:#fff;border:none;border-radius:5px;padding:9px 20px;font-size:12px;font-weight:bold;cursor:pointer;}
.btn-cl{background:#E8D5B0;color:#5C3D2E;border:none;border-radius:5px;padding:9px 16px;font-size:12px;cursor:pointer;}
.toast{display:none;position:fixed;top:20px;left:50%;transform:translateX(-50%);background:#2E7D6B;color:#fff;padding:10px 22px;border-radius:7px;font-size:13px;font-weight:bold;z-index:9999;}
.toast.err{background:#C62828;}
.footer{text-align:center;padding:20px;color:#A08060;font-size:12px;border-top:1px solid #DDD0BC;margin-top:20px;}
</style>
</head>
<body>
<div id="toast" class="toast"></div>

<!-- 헤더 -->
<div class="header">
  <div class="header-inner">
    <div class="logo">
      <h1>📚 폴리 인공지능 도서관</h1>
      <div class="sub">Poly AI Library</div>
    </div>
    <form action="${pageContext.request.contextPath}/book/bookList.do" method="get" class="header-search">
      <input type="text" name="keyword" placeholder="도서명, 저자 검색...">
      <button type="submit">검색</button>
    </form>
    <div class="nav-links">
      <a href="${pageContext.request.contextPath}/main/mainPage.do">홈</a>
      <a href="${pageContext.request.contextPath}/book/bookList.do">도서 목록</a>
      <c:if test="${not empty sessionScope.loginVO}">
        <a href="${pageContext.request.contextPath}/loan/myLoan.do">내 대출</a>
      </c:if>
      <c:if test="${sessionScope.loginVO.role=='ADMIN'}">
        <a href="${pageContext.request.contextPath}/admin/adminMain.do" style="color:#E8C87A;">관리자</a>
      </c:if>
      <c:choose>
        <c:when test="${not empty sessionScope.loginVO}">
          <div class="user-menu" id="userMenu">
            <button class="user-btn" onclick="toggleMenu()">
              👤 ${sessionScope.loginVO.userName} ▼
            </button>
            <div class="dropdown">
              <div class="dropdown-header">📖 내 대출 현황</div>
              <div class="dropdown-body" id="dropBody"><div class="empty-drop">불러오는 중...</div></div>
              <div class="dropdown-footer"><a href="${pageContext.request.contextPath}/loan/myLoan.do">전체 보기 →</a></div>
            </div>
          </div>
          <a href="${pageContext.request.contextPath}/user/logout.do"
             onclick="return confirm('로그아웃?')" style="color:#C4A882;font-size:12px;">로그아웃</a>
        </c:when>
        <c:otherwise>
          <a href="${pageContext.request.contextPath}/user/loginView.do">로그인</a>
          <a href="${pageContext.request.contextPath}/user/joinView.do">회원가입</a>
        </c:otherwise>
      </c:choose>
    </div>
  </div>
</div>

<!-- 히어로 배너 -->
<div class="hero">
  <h2>📚 폴리 인공지능 도서관</h2>
  <p>원하는 도서를 검색하고, AI 추천으로 새로운 책을 만나보세요</p>
  <form action="${pageContext.request.contextPath}/book/bookList.do" method="get" class="hero-search">
    <select name="searchType">
      <option value="title">제목</option>
      <option value="author">저자</option>
      <option value="publisher">출판사</option>
    </select>
    <input type="text" name="keyword" placeholder="읽고 싶은 책을 검색하세요...">
    <button type="submit">🔍 검색</button>
  </form>
</div>

<div class="container">

  <!-- 이달의 인기 도서 TOP30 -->
  <div class="sec-hdr">
    <div class="sec-title">
      🏆 이달의 인기 도서
      <span class="sec-badge" id="monthBadge"></span>
    </div>
    <div style="display:flex;gap:12px;align-items:center;">
      <c:if test="${not empty sessionScope.loginVO}">
        <button class="btn-ok" onclick="openLoanModal()" style="padding:8px 16px;font-size:12px;">📚 대출 신청</button>
      </c:if>
      <a href="${pageContext.request.contextPath}/book/bookList.do" class="sec-link">전체 도서 보기 →</a>
    </div>
  </div>

  <div class="top30-grid">
    <c:forEach var="book" items="${top30List}" varStatus="vs">
      <div class="book-card"
           onclick="location.href='${pageContext.request.contextPath}/book/bookDetail.do?bookId=${book.bookId}'">
        <div class="rank-badge ${vs.index==0?'r1':vs.index==1?'r2':vs.index==2?'r3':'ro'}">
          ${vs.index+1}
        </div>
        <div class="bi">
          <div class="bt" title="${book.title}">${book.title}</div>
          <div class="bm">${book.author} · ${book.publisher}</div>
          <div class="bb">
            <span class="cat-chip">${empty book.category?'기타':book.category}</span>
            <span class="loan-cnt">이달 ${book.loanCount}회</span>
            <span class="${book.status=='Y'?'status-y':'status-n'}">${book.status=='Y'?'대출가능':'대출중'}</span>
          </div>
        </div>
      </div>
    </c:forEach>
  </div>

  <!-- AI 추천 섹션 -->
  <div class="sec-hdr">
    <div class="sec-title">
      🤖 이런 도서는 어떠세요?
      <span class="sec-badge">AI 추천</span>
    </div>
  </div>

  <div class="ai-section">
    <div class="ai-header">
      <div class="ai-title">
        🤖 AI 맞춤 도서 추천
        <span class="ai-badge">COMING SOON</span>
      </div>
      <div style="color:#8899BB;font-size:12px;">Powered by Claude AI</div>
    </div>
    <div class="ai-body">
      <div class="ai-placeholder-icon">🔮</div>
      <div class="ai-placeholder-title">AI 도서 추천 기능 준비 중</div>
      <div class="ai-placeholder-desc">
        관심 분야나 키워드를 입력하면<br>
        AI가 딱 맞는 도서를 추천해드릴 예정입니다.<br>
        도서관에 없는 책은 바로 신청도 가능해요!
      </div>
      <div class="ai-coming-badge">🚀 AI 도입 예정</div>
      <div class="ai-week-label">다음 주 업데이트 예정</div>
    </div>
  </div>

</div>

<!-- 대출 신청 모달 -->
<div class="modal-overlay" id="loanModal">
  <div class="modal">
    <button class="modal-close" onclick="closeLoanModal()">✕</button>
    <h2>📚 도서 대출 신청</h2>
    <p class="modal-sub">도서를 검색해 장바구니에 담고 한 번에 신청하세요.</p>
    <hr class="mdv">
    <div class="sec-t">도서 검색</div>
    <div class="ms-row">
      <select id="bst"><option value="title">제목</option><option value="author">저자</option><option value="category">분류</option></select>
      <input type="text" id="bkw" placeholder="검색어..." onkeydown="if(event.keyCode==13)srchBook()">
      <button class="btn-ms" onclick="srchBook()">검색</button>
    </div>
    <div class="rbox" id="bres"><span style="color:#C4A882;">검색 결과가 표시됩니다.</span></div>
    <hr class="mdv">
    <div class="sec-t">대출 장바구니 <span id="cntLbl" style="color:#2E7D6B;font-weight:bold;">(0권)</span></div>
    <div class="cart-area" id="cartArea"><span style="color:#A08060;font-size:11px;">도서를 선택하면 표시됩니다.</span></div>
    <div class="mfooter">
      <button class="btn-cl" onclick="closeLoanModal()">취소</button>
      <button class="btn-ok" onclick="submitLoan()">대출 신청</button>
    </div>
  </div>
</div>

<div class="footer">© 2026 폴리 인공지능 도서관 · Poly AI Library Management System</div>

<script>
document.getElementById('monthBadge').textContent = (new Date().getMonth()+1)+'월';

var urlP = new URLSearchParams(window.location.search);
if(urlP.get('msg')) showToast(decodeURIComponent(urlP.get('msg').replace(/\+/g,' ')));

function showToast(m,e){var t=document.getElementById('toast');t.textContent=m;t.className='toast'+(e?' err':'');t.style.display='block';setTimeout(function(){t.style.display='none';},3000);}

function toggleMenu(){
    var m=document.getElementById('userMenu');
    m.classList.toggle('open');
    if(m.classList.contains('open')) loadSummary();
}
document.addEventListener('click',function(e){var m=document.getElementById('userMenu');if(m&&!m.contains(e.target))m.classList.remove('open');});
function loadSummary(){
    fetch('${pageContext.request.contextPath}/loan/myLoanSummary.do')
    .then(function(r){return r.json();}).then(function(d){
        var el=document.getElementById('dropBody');
        if(!d||d.length===0){el.innerHTML='<div class="empty-drop">대출 중인 도서가 없습니다.</div>';return;}
        var h='';d.forEach(function(l){h+='<div class="loan-item"><div class="li-title">'+l.bookTitle+'</div><div class="li-meta"><span>'+l.returnDate+'</span><span class="li-dday '+(l.ddayClass||'dday-ok')+'">'+(l.ddayLabel||'')+'</span></div></div>';});
        el.innerHTML=h;
    }).catch(function(){document.getElementById('dropBody').innerHTML='<div class="empty-drop">오류</div>';});
}

var cart={};
function openLoanModal(){document.getElementById('loanModal').classList.add('active');}
function closeLoanModal(){document.getElementById('loanModal').classList.remove('active');}
document.getElementById('loanModal').addEventListener('click',function(e){if(e.target===this)closeLoanModal();});

function srchBook(){
    var t=document.getElementById('bst').value,k=document.getElementById('bkw').value.trim();
    if(!k){showToast('검색어를 입력하세요.',true);return;}
    document.getElementById('bres').innerHTML='<span style="color:#A08060;">검색 중...</span>';
    fetch('${pageContext.request.contextPath}/loan/searchBook.do?searchType='+t+'&keyword='+encodeURIComponent(k))
    .then(function(r){return r.json();}).then(function(list){
        if(!list||list.length===0){document.getElementById('bres').innerHTML='<span style="color:#A08060;">결과 없음</span>';return;}
        var h='';list.forEach(function(b){
            var inC=cart[b.bookId]!==undefined,na=b.status!=='Y';
            h+='<div class="ri '+(inC?'sel':na?'dis':'')+'" onclick="togCart('+b.bookId+',\''+esc(b.title)+'\',\''+b.status+'\')">'
             +'<div class="ri-chk">'+(inC?'✓':'')+'</div>'
             +'<div class="ri-info"><div class="ri-t">'+b.title+'</div>'
             +'<div class="ri-s">'+b.author+(na?' · <span style="color:#E65100;">대출중</span>':'')+'</div></div></div>';
        });
        document.getElementById('bres').innerHTML=h;
    });
}
function esc(s){return s.replace(/'/g,"\\'");}
function togCart(id,title,status){
    if(status!=='Y'&&!cart[id]){showToast('대출 중인 도서입니다.',true);return;}
    if(cart[id])delete cart[id];else cart[id]=title;
    renderCart();srchBook();
}
function renderCart(){
    var ids=Object.keys(cart),cnt=ids.length;
    document.getElementById('cntLbl').textContent='('+cnt+'권)';
    if(cnt===0){document.getElementById('cartArea').innerHTML='<span style="color:#A08060;font-size:11px;">도서를 선택하면 표시됩니다.</span>';return;}
    var h='';for(var id in cart)h+='<div class="c-chip">'+cart[id]+'<button onclick="rmCart('+id+')">✕</button></div>';
    document.getElementById('cartArea').innerHTML=h;
}
function rmCart(id){delete cart[id];renderCart();}
function submitLoan(){
    var ids=Object.keys(cart);
    if(ids.length===0){showToast('대출할 도서를 선택하세요.',true);return;}
    var form=document.createElement('form');form.method='POST';
    form.action='${pageContext.request.contextPath}/loan/loanApplyMulti.do';
    ids.forEach(function(id){var i=document.createElement('input');i.type='hidden';i.name='bookIds';i.value=id;form.appendChild(i);});
    var m=document.createElement('input');m.type='hidden';m.name='memberId';m.value='${sessionScope.loginVO.userId}';form.appendChild(m);
    document.body.appendChild(form);form.submit();
}
</script>
</body>
</html>
