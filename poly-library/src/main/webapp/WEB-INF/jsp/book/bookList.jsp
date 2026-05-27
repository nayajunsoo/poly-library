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
  .header { background-color: #5C3D2E; box-shadow: 0 2px 8px rgba(0,0,0,0.3); }
  .header-inner { max-width: 1100px; margin: 0 auto; padding: 20px 30px; display: flex; align-items: center; justify-content: space-between; }
  .header h1 { color: #F5E6C8; font-size: 22px; letter-spacing: 1px; }
  .header .subtitle { color: #C4A882; font-size: 13px; margin-top: 4px; }
  .nav-links { display: flex; align-items: center; gap: 20px; }
  .nav-links a { color: #F5E6C8; text-decoration: none; font-size: 14px; }
  .nav-links a:hover { color: #E8C87A; }
  .user-greet { color: #C4A882; font-size: 13px; font-weight: bold; }
  .container { max-width: 1100px; margin: 40px auto; padding: 0 30px; }
  .page-header { display: flex; align-items: center; justify-content: space-between; margin-bottom: 20px; flex-wrap: wrap; gap: 12px; }
  .page-title { font-size: 26px; color: #5C3D2E; font-weight: bold; border-left: 5px solid #A0522D; padding-left: 14px; }
  .btn-group { display: flex; gap: 10px; align-items: center; }
  .btn-register { background-color: #A0522D; color: #FFF8F0; padding: 10px 22px; border: none; border-radius: 6px; font-size: 14px; cursor: pointer; text-decoration: none; display: inline-block; }
  .btn-register:hover { background-color: #7B3A1F; }
  .btn-loan { background-color: #2E7D6B; color: #FFFFFF; padding: 10px 22px; border: none; border-radius: 6px; font-size: 14px; font-weight: bold; cursor: pointer; text-decoration: none; display: inline-block; letter-spacing: 0.5px; }
  .btn-loan:hover { background-color: #1E5C4E; }
  .search-box { background: #FFFDF8; border-radius: 10px; box-shadow: 0 2px 8px rgba(92,61,46,0.1); padding: 16px 20px; margin-bottom: 20px; display: flex; gap: 10px; align-items: center; flex-wrap: wrap; }
  .search-box select, .search-box input { padding: 9px 14px; border: 1.5px solid #D4B896; border-radius: 6px; font-size: 14px; background: #FFF8F0; font-family: inherit; }
  .btn-search { background-color: #5C3D2E; color: #FFF8F0; padding: 9px 22px; border: none; border-radius: 6px; cursor: pointer; font-family: inherit; font-size: 14px; }
  .btn-search:hover { background-color: #3D2719; }
  .table-card { background: #FFFDF8; border-radius: 12px; box-shadow: 0 2px 12px rgba(92,61,46,0.1); overflow: hidden; }
  table { width: 100%; border-collapse: collapse; }
  thead tr { background-color: #5C3D2E; }
  thead th { color: #F5E6C8; padding: 16px 12px; font-size: 14px; text-align: center; }
  tbody td { padding: 14px 12px; font-size: 14px; text-align: center; color: #4A3728; border-bottom: 1px solid #EDE0CE; }
  tbody tr:hover { background-color: #FFF8EE; }
  .badge { display: inline-block; padding: 4px 10px; border-radius: 20px; font-size: 12px; font-weight: bold; }
  .badge-available { background-color: #E8F5E9; color: #2E7D32; }
  .badge-loaned { background-color: #FFF3E0; color: #E65100; }
  .btn-edit { background: #E8D5B0; color: #5C3D2E; padding: 6px 14px; border-radius: 4px; font-size: 12px; text-decoration: none; margin-right: 4px; }
  .btn-delete { background: #F5D5CC; color: #7B2D2D; padding: 6px 14px; border-radius: 4px; font-size: 12px; text-decoration: none; }
  .empty-msg { text-align: center; padding: 40px; color: #A08060; font-size: 15px; }
  .footer { text-align: center; margin-top: 60px; padding: 24px; color: #A08060; font-size: 13px; border-top: 1px solid #DDD0BC; }

  /* ── 대출 모달 ── */
  .modal-overlay { display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.55); z-index: 1000; justify-content: center; align-items: center; }
  .modal-overlay.active { display: flex; }
  .modal { background: #FFFDF8; border-radius: 14px; box-shadow: 0 8px 40px rgba(0,0,0,0.3); width: 100%; max-width: 700px; max-height: 90vh; overflow-y: auto; padding: 36px 36px 28px; position: relative; animation: slideUp 0.22s ease; }
  @keyframes slideUp { from { transform: translateY(30px); opacity: 0; } to { transform: translateY(0); opacity: 1; } }
  .modal-close { position: absolute; top: 16px; right: 20px; background: none; border: none; font-size: 24px; cursor: pointer; color: #A08060; }
  .modal-close:hover { color: #5C3D2E; }
  .modal h2 { color: #5C3D2E; font-size: 20px; margin-bottom: 6px; }
  .modal .modal-subtitle { color: #A08060; font-size: 13px; margin-bottom: 24px; }
  .modal-divider { border: none; border-top: 1px solid #EDE0CE; margin: 20px 0; }
  .sec-title { font-size: 13px; font-weight: bold; color: #5C3D2E; margin-bottom: 10px; letter-spacing: 0.5px; }
  .modal-search-row { display: flex; gap: 8px; margin-bottom: 10px; }
  .modal-search-row select { padding: 9px 12px; border: 1.5px solid #D4B896; border-radius: 6px; background: #FFF8F0; font-family: inherit; font-size: 13px; }
  .modal-search-row input { flex: 1; padding: 9px 14px; border: 1.5px solid #D4B896; border-radius: 6px; background: #FFF8F0; font-family: inherit; font-size: 13px; }
  .modal-search-row input:focus, .modal-search-row select:focus { outline: none; border-color: #A0522D; }
  .btn-ms { background: #5C3D2E; color: #FFF8F0; border: none; border-radius: 6px; padding: 9px 18px; cursor: pointer; font-size: 13px; white-space: nowrap; font-family: inherit; }
  .btn-ms:hover { background: #3D2719; }
  .result-box { background: #F9F4EE; border: 1.5px solid #EDE0CE; border-radius: 8px; min-height: 76px; padding: 12px 14px; font-size: 13px; color: #A08060; display: flex; flex-direction: column; gap: 6px; }
  .result-item { background: #FFFDF8; border: 1px solid #D4B896; border-radius: 6px; padding: 10px 14px; cursor: pointer; width: 100%; transition: background 0.15s, border-color 0.15s; font-size: 13px; color: #3B2F2F; }
  .result-item:hover { background: #FFF0DC; border-color: #A0522D; }
  .result-item.selected { background: #FFF0DC; border-color: #A0522D; font-weight: bold; }
  .item-title { font-weight: bold; color: #5C3D2E; margin-bottom: 3px; }
  .item-sub { font-size: 12px; color: #A08060; }
  .rbadge { display: inline-block; padding: 2px 8px; border-radius: 12px; font-size: 11px; margin-left: 6px; }
  .rb-ok { background: #E8F5E9; color: #2E7D32; }
  .rb-no { background: #FFF3E0; color: #E65100; }
  .hint { font-size: 12px; color: #B09070; margin-top: 5px; }
  .confirm-area { background: #EEF7F4; border: 1.5px solid #A8D5C8; border-radius: 8px; padding: 16px 18px; display: none; }
  .confirm-area.active { display: block; }
  .confirm-title { font-size: 13px; font-weight: bold; color: #2E7D6B; margin-bottom: 10px; }
  .confirm-row { font-size: 13px; color: #3B2F2F; margin-bottom: 6px; }
  .confirm-row span { font-weight: bold; color: #5C3D2E; }
  .btn-submit-loan { width: 100%; background: #2E7D6B; color: white; border: none; border-radius: 8px; padding: 14px; font-size: 15px; font-weight: bold; cursor: pointer; margin-top: 18px; font-family: inherit; transition: background 0.2s; }
  .btn-submit-loan:hover { background: #1E5C4E; }
  .btn-submit-loan:disabled { background: #A8BFBA; cursor: not-allowed; }
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
      <a href="${pageContext.request.contextPath}/book/bookList.do">도서 목록</a>
      <c:choose>
        <c:when test="${empty loginVO}">
          <a href="${pageContext.request.contextPath}/user/loginView.do">로그인</a>
          <a href="${pageContext.request.contextPath}/user/joinView.do">회원가입</a>
        </c:when>
        <c:otherwise>
          <span class="user-greet">${loginVO.userName}님 환영합니다!</span>
          <a href="${pageContext.request.contextPath}/user/logout.do"
             onclick="return confirm('로그아웃 하시겠습니까?')">로그아웃</a>
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
    <form action="${pageContext.request.contextPath}/book/bookSearch.do" method="get"
          style="display:flex;gap:10px;align-items:center;flex-wrap:wrap;width:100%;">
      <select name="searchType">
        <option value="title"     <c:if test="${searchType=='title'}">selected</c:if>>제목</option>
        <option value="author"    <c:if test="${searchType=='author'}">selected</c:if>>저자</option>
        <option value="publisher" <c:if test="${searchType=='publisher'}">selected</c:if>>출판사</option>
      </select>
      <input type="text" name="keyword" value="${keyword}" placeholder="검색어를 입력하세요" style="flex:1;min-width:180px;">
      <button type="submit" class="btn-search">검색</button>
      <c:if test="${not empty keyword}">
        <a href="${pageContext.request.contextPath}/book/bookList.do"
           class="btn-search" style="text-decoration:none;background:#A08060;">전체 보기</a>
      </c:if>
    </form>
  </div>

  <div class="table-card">
    <table>
      <thead>
        <tr>
          <th>번호</th><th>도서명</th><th>저자</th><th>출판사</th><th>상태</th>
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
                    <a href="${pageContext.request.contextPath}/book/bookDelete.do?bookId=${book.bookId}" class="btn-delete"
                       onclick="return confirm('삭제하시겠습니까?')">삭제</a>
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

<div class="footer">© 2026 폴리 인공지능 도서관 · Poly AI Library</div>

<!-- ══════════════ 도서 대출 모달 ══════════════ -->
<div class="modal-overlay" id="loanModal" onclick="closeBg(event)">
  <div class="modal" id="loanModalBox">
    <button class="modal-close" onclick="closeLoanModal()">✕</button>
    <h2>📖 도서 대출 신청</h2>
    <p class="modal-subtitle">도서와 회원을 검색한 뒤 대출을 신청합니다.</p>

    <!-- ① 도서 검색 -->
    <div class="sec-title">① 도서 검색</div>
    <div class="modal-search-row">
      <select id="bookSearchType">
        <option value="title">제목</option>
        <option value="author">저자</option>
        <option value="publisher">출판사</option>
      </select>
      <input type="text" id="bookKeyword" placeholder="예) 노인과 바다"
             onkeydown="if(event.key==='Enter') searchBook()">
      <button class="btn-ms" onclick="searchBook()">검색</button>
    </div>
    <div class="result-box" id="bookResultBox"><span>검색 결과가 여기에 표시됩니다.</span></div>
    <p class="hint">※ 검색 후 항목을 클릭하여 선택하세요.</p>

    <hr class="modal-divider">

    <!-- ② 회원 검색 -->
    <div class="sec-title">② 회원 검색</div>
    <div class="modal-search-row">
      <select id="memberSearchType">
        <option value="name">이름</option>
        <option value="phone">전화번호 끝 4자리</option>
        <option value="memberId">아이디</option>
      </select>
      <input type="text" id="memberKeyword" placeholder="예) 박준수 또는 4542"
             onkeydown="if(event.key==='Enter') searchMember()">
      <button class="btn-ms" onclick="searchMember()">검색</button>
    </div>
    <div class="result-box" id="memberResultBox"><span>검색 결과가 여기에 표시됩니다.</span></div>
    <p class="hint">※ 검색 후 항목을 클릭하여 선택하세요.</p>

    <hr class="modal-divider">

    <!-- ③ 확인 및 신청 -->
    <div class="confirm-area" id="confirmArea">
      <div class="confirm-title">✅ 대출 신청 내용 확인</div>
      <div class="confirm-row">📚 도서 : <span id="confirmBook">-</span></div>
      <div class="confirm-row">👤 회원 : <span id="confirmMember">-</span></div>
    </div>

    <form id="loanForm" action="${pageContext.request.contextPath}/loan/loanApply.do" method="post">
      <input type="hidden" id="selectedBookId"   name="bookId"   value="">
      <input type="hidden" id="selectedMemberId" name="memberId" value="">
      <button type="button" class="btn-submit-loan" id="loanSubmitBtn"
              disabled onclick="submitLoan()">대출 신청하기</button>
    </form>
  </div>
</div>

<script>
var CP = '${pageContext.request.contextPath}';
var selBook = null, selMember = null;

function openLoanModal()  { document.getElementById('loanModal').classList.add('active'); document.body.style.overflow='hidden'; }
function closeLoanModal() { document.getElementById('loanModal').classList.remove('active'); document.body.style.overflow=''; }
function closeBg(e) { if(e.target===document.getElementById('loanModal')) closeLoanModal(); }

function esc(s){ return s?String(s).replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/>/g,'&gt;'):''; }

/* ── 도서 검색 ── */
function searchBook(){
  var t=document.getElementById('bookSearchType').value,
      k=document.getElementById('bookKeyword').value.trim(),
      box=document.getElementById('bookResultBox');
  if(!k){ box.innerHTML='<span>검색어를 입력해주세요.</span>'; return; }
  box.innerHTML='<span>검색 중...</span>';
  ajax(CP+'/loan/searchBook.do?searchType='+enc(t)+'&keyword='+enc(k), function(data){
    if(!data||!data.length){ box.innerHTML='<span>검색 결과가 없습니다.</span>'; return; }
    var h='';
    data.forEach(function(b){
      var av=b.status==='Y';
      h+='<div class="result-item" data-obj="'+esc(JSON.stringify(b))+'" onclick="selBookFn(this,'+esc(JSON.stringify(b))+')">'
        +'<div class="item-title">'+esc(b.title)+(av?'<span class="rbadge rb-ok">대출가능</span>':'<span class="rbadge rb-no">대출중</span>')+'</div>'
        +'<div class="item-sub">저자: '+esc(b.author)+' | 출판사: '+esc(b.publisher)+'</div></div>';
    });
    box.innerHTML=h;
  }, function(){ box.innerHTML='<span style="color:#C0392B;">서버 오류. 잠시 후 다시 시도하세요.</span>'; });
}

function selBookFn(el, b){
  document.querySelectorAll('#bookResultBox .result-item').forEach(function(e){e.classList.remove('selected');});
  el.classList.add('selected');
  selBook=b; document.getElementById('selectedBookId').value=b.bookId; updateConfirm();
}

/* ── 회원 검색 ── */
function searchMember(){
  var t=document.getElementById('memberSearchType').value,
      k=document.getElementById('memberKeyword').value.trim(),
      box=document.getElementById('memberResultBox');
  if(!k){ box.innerHTML='<span>검색어를 입력해주세요.</span>'; return; }
  box.innerHTML='<span>검색 중...</span>';
  ajax(CP+'/loan/searchMember.do?searchType='+enc(t)+'&keyword='+enc(k), function(data){
    if(!data||!data.length){ box.innerHTML='<span>검색 결과가 없습니다.</span>'; return; }
    var h='';
    data.forEach(function(m){
      var pt=m.phone?m.phone.slice(-4):'미등록';
      h+='<div class="result-item" onclick="selMemberFn(this,'+esc(JSON.stringify(m))+')">'
        +'<div class="item-title">'+esc(m.name)+' <span style="font-weight:normal;font-size:12px;color:#A08060;">('+esc(m.memberId)+')</span></div>'
        +'<div class="item-sub">전화번호 끝 4자리: '+esc(pt)+'</div></div>';
    });
    box.innerHTML=h;
  }, function(){ box.innerHTML='<span style="color:#C0392B;">서버 오류. 잠시 후 다시 시도하세요.</span>'; });
}

function selMemberFn(el, m){
  document.querySelectorAll('#memberResultBox .result-item').forEach(function(e){e.classList.remove('selected');});
  el.classList.add('selected');
  selMember=m; document.getElementById('selectedMemberId').value=m.memberId; updateConfirm();
}

/* ── 확인 영역 ── */
function updateConfirm(){
  var area=document.getElementById('confirmArea'), btn=document.getElementById('loanSubmitBtn');
  if(selBook&&selMember){
    var pt=selMember.phone?selMember.phone.slice(-4):'미등록';
    document.getElementById('confirmBook').textContent=selBook.title+' (저자: '+selBook.author+')';
    document.getElementById('confirmMember').textContent=selMember.name+' (전화번호 끝 4자리: '+pt+')';
    area.classList.add('active'); btn.disabled=false;
  } else { area.classList.remove('active'); btn.disabled=true; }
}

function submitLoan(){
  if(!selBook||!selMember){ alert('도서와 회원을 모두 선택해주세요.'); return; }
  if(selBook.status!=='Y'){ alert('선택한 도서는 현재 대출 중입니다.'); return; }
  if(confirm('"'+selBook.title+'"을 "'+selMember.name+'"님께 대출하시겠습니까?'))
    document.getElementById('loanForm').submit();
}

/* ── 공통 AJAX ── */
function ajax(url, success, error){
  var x=new XMLHttpRequest(); x.open('GET',url,true);
  x.onload=function(){ if(x.status===200){ try{ success(JSON.parse(x.responseText)); }catch(e){ error&&error(e); } }else{ error&&error(); } };
  x.onerror=function(){ error&&error(); };
  x.send();
}
function enc(s){ return encodeURIComponent(s); }
</script>
</body>
</html>
