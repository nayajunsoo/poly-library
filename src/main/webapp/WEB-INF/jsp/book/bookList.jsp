<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="https://fonts.googleapis.com/css2?family=Noto+Serif+KR:wght@400;700&display=swap" rel="stylesheet">
<title>도서 목록 - 폴리 인공지능 도서관</title>
<style>
*{margin:0;padding:0;box-sizing:border-box;}
html,body{overflow-x:hidden;max-width:100%;}
body{font-family:'Noto Serif KR',serif;background:#F5F0E8;color:#3B2F2F;min-height:100vh;}
.header{background:#5C3D2E;box-shadow:0 2px 8px rgba(0,0,0,0.3);position:sticky;top:0;z-index:100;}
.header-inner{max-width:1200px;margin:0 auto;padding:13px 28px;display:flex;align-items:center;justify-content:space-between;gap:16px;}
.logo a{color:#F5E6C8;text-decoration:none;font-size:18px;font-weight:bold;white-space:nowrap;}
.logo .sub{color:#C4A882;font-size:11px;}
.hdr-search{flex:1;max-width:380px;display:flex;}
.hdr-search input{flex:1;padding:8px 12px;border:none;border-radius:5px 0 0 5px;font-size:13px;background:#FFF8F0;}
.hdr-search button{padding:8px 14px;background:#A0522D;color:#fff;border:none;border-radius:0 5px 5px 0;cursor:pointer;font-size:12px;}
.nav-links{display:flex;gap:14px;align-items:center;flex-shrink:0;}
.nav-links a{color:#F5E6C8;text-decoration:none;font-size:12px;}
.nav-links a:hover{color:#E8C87A;}
.user-menu{position:relative;}
.user-btn{color:#C4A882;font-size:12px;cursor:pointer;background:none;border:none;font-family:inherit;display:flex;align-items:center;gap:4px;}
.dropdown{display:none;position:absolute;top:calc(100% + 10px);right:0;width:250px;background:#FFFDF8;border-radius:9px;box-shadow:0 6px 24px rgba(0,0,0,0.22);border:1px solid #EDE0CE;overflow:hidden;}
.user-menu.open .dropdown{display:block;}
.drop-hdr{background:#5C3D2E;padding:9px 13px;color:#F5E6C8;font-size:11px;font-weight:bold;}
.drop-body{padding:6px 0;max-height:200px;overflow-y:auto;}
.li{padding:8px 13px;border-bottom:1px solid #F0E8DC;font-size:11px;}
.li:last-child{border-bottom:none;}
.li-t{font-weight:bold;color:#3B2F2F;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;}
.li-m{color:#A08060;display:flex;justify-content:space-between;margin-top:2px;}
.ddok{background:#E8F5E9;color:#2E7D32;font-size:10px;padding:1px 5px;border-radius:6px;}
.ddwn{background:#FFF3E0;color:#E65100;font-size:10px;padding:1px 5px;border-radius:6px;}
.ddov{background:#FFEBEE;color:#C62828;font-size:10px;padding:1px 5px;border-radius:6px;}
.edrop{padding:14px;text-align:center;font-size:11px;color:#A08060;}
.drop-ft{border-top:1px solid #EDE0CE;padding:7px 13px;text-align:center;}
.drop-ft a{color:#A0522D;font-size:11px;font-weight:bold;text-decoration:none;}
/* 레이아웃 */
.layout{max-width:1200px;margin:24px auto;padding:0 28px;display:grid;grid-template-columns:220px 1fr;gap:20px;}
/* 사이드바 */
.sidebar{}
.side-card{background:#FFFDF8;border-radius:10px;box-shadow:0 2px 8px rgba(92,61,46,0.1);overflow:hidden;margin-bottom:14px;}
.side-hdr{background:#5C3D2E;padding:10px 14px;color:#F5E6C8;font-size:13px;font-weight:bold;}
.side-body{padding:10px 12px;}
/* 초성 */
.chosung-grid{display:grid;grid-template-columns:repeat(5,1fr);gap:4px;}
.cs-btn{padding:6px 0;background:#F5ECD8;color:#5C3D2E;border:none;border-radius:5px;font-size:12px;cursor:pointer;text-align:center;font-family:inherit;transition:background 0.15s;}
.cs-btn:hover,.cs-btn.active{background:#A0522D;color:#fff;}
/* 장르 */
.cat-list{display:flex;flex-direction:column;gap:4px;}
.cat-btn{padding:7px 10px;background:#F5ECD8;color:#5C3D2E;border:none;border-radius:5px;font-size:12px;cursor:pointer;text-align:left;font-family:inherit;display:flex;justify-content:space-between;align-items:center;transition:background 0.15s;}
.cat-btn:hover,.cat-btn.active{background:#A0522D;color:#fff;}
.cat-cnt{font-size:10px;opacity:0.8;}
/* 정렬/필터 */
.filter-row{display:flex;gap:6px;flex-wrap:wrap;}
.f-btn{padding:5px 10px;background:#F5ECD8;color:#5C3D2E;border:none;border-radius:5px;font-size:11px;cursor:pointer;font-family:inherit;}
.f-btn.active,.f-btn:hover{background:#5C3D2E;color:#fff;}
/* 메인 콘텐츠 */
.main-content{}
/* 검색 바 */
.search-area{background:#FFFDF8;border-radius:10px;box-shadow:0 2px 8px rgba(92,61,46,0.08);padding:14px 18px;margin-bottom:16px;display:flex;gap:8px;align-items:center;}
.search-area select{padding:8px 10px;border:1.5px solid #D4B896;border-radius:5px;font-size:13px;background:#FFF8F0;font-family:inherit;}
.search-area input{flex:1;padding:8px 12px;border:1.5px solid #D4B896;border-radius:5px;font-size:13px;background:#FFF8F0;font-family:inherit;}
.btn-srch{background:#5C3D2E;color:#fff;border:none;border-radius:5px;padding:8px 18px;font-size:13px;cursor:pointer;font-family:inherit;}
.btn-reset{background:#E8D5B0;color:#5C3D2E;border:none;border-radius:5px;padding:8px 14px;font-size:12px;cursor:pointer;font-family:inherit;text-decoration:none;display:inline-block;}
/* 결과 헤더 */
.result-hdr{display:flex;justify-content:space-between;align-items:center;margin-bottom:12px;flex-wrap:wrap;gap:8px;}
.result-title{font-size:15px;color:#5C3D2E;font-weight:bold;}
.result-count{font-size:12px;color:#A08060;}
.btn-loan-top{background:#2E7D6B;color:#fff;border:none;border-radius:5px;padding:7px 16px;font-size:12px;cursor:pointer;font-family:inherit;}
.btn-register{background:#A0522D;color:#fff;padding:7px 14px;border-radius:5px;font-size:12px;text-decoration:none;display:inline-block;margin-right:6px;}
/* 도서 테이블 */
.table-wrap{background:#FFFDF8;border-radius:10px;box-shadow:0 2px 10px rgba(92,61,46,0.1);overflow:hidden;}
table{width:100%;border-collapse:collapse;}
thead tr{background:#5C3D2E;}
thead th{color:#F5E6C8;padding:11px 10px;font-size:12px;text-align:center;}
tbody td{padding:10px;font-size:12px;text-align:center;border-bottom:1px solid #EDE0CE;}
tbody tr:hover{background:#FFF8EE;}
.badge{display:inline-block;padding:2px 8px;border-radius:12px;font-size:10px;font-weight:bold;}
.badge-y{background:#E8F5E9;color:#2E7D32;}
.badge-n{background:#FFF3E0;color:#E65100;}
.btn-e{background:#E8D5B0;color:#5C3D2E;padding:4px 8px;border-radius:4px;font-size:10px;text-decoration:none;margin-right:2px;white-space:nowrap;display:inline-block;}
.btn-d{background:#F5D5CC;color:#7B2D2D;padding:4px 8px;border-radius:4px;font-size:10px;text-decoration:none;white-space:nowrap;display:inline-block;}
.empty-msg{text-align:center;padding:36px;color:#A08060;}
/* 페이지네이션 */
.paging{display:flex;justify-content:center;align-items:center;gap:4px;margin-top:16px;flex-wrap:wrap;}
.p-btn{padding:6px 11px;border:1.5px solid #D4B896;border-radius:5px;background:#FFFDF8;color:#5C3D2E;cursor:pointer;font-size:12px;text-decoration:none;display:inline-block;font-family:inherit;}
.p-btn:hover{background:#F5ECD8;}
.p-btn.active{background:#5C3D2E;color:#FFF8F0;border-color:#5C3D2E;}
.p-btn.disabled{opacity:0.4;cursor:default;}
/* 대출 모달 */
.modal-overlay{display:none;position:fixed;top:0;left:0;width:100%;height:100%;background:rgba(0,0,0,0.55);z-index:1000;justify-content:center;align-items:center;}
.modal-overlay.active{display:flex;}
.modal{background:#FFFDF8;border-radius:12px;box-shadow:0 8px 36px rgba(0,0,0,0.28);width:100%;max-width:640px;max-height:90vh;overflow-y:auto;padding:24px 24px 16px;position:relative;}
.modal-close{position:absolute;top:10px;right:14px;background:none;border:none;font-size:20px;cursor:pointer;color:#A08060;}
.modal h2{color:#5C3D2E;font-size:16px;margin-bottom:3px;}
.modal-sub{color:#A08060;font-size:11px;margin-bottom:12px;}
hr.mdv{border:none;border-top:1px solid #EDE0CE;margin:9px 0;}
.sec-t{font-size:11px;font-weight:bold;color:#5C3D2E;margin-bottom:5px;}
.ms-row{display:flex;gap:6px;margin-bottom:6px;}
.ms-row select,.ms-row input{padding:7px 9px;border:1.5px solid #D4B896;border-radius:5px;background:#FFF8F0;font-size:11px;font-family:inherit;}
.ms-row input{flex:1;}
.btn-ms{background:#5C3D2E;color:#fff;border:none;border-radius:5px;padding:7px 12px;cursor:pointer;font-size:11px;}
.rbox{background:#F9F4EE;border:1.5px solid #EDE0CE;border-radius:6px;min-height:50px;padding:7px 9px;font-size:11px;color:#A08060;display:flex;flex-direction:column;gap:3px;}
.ri{background:#FFFDF8;border:1px solid #D4B896;border-radius:5px;padding:6px 8px;cursor:pointer;display:flex;align-items:center;gap:6px;}
.ri:hover{background:#FFF0DC;border-color:#A0522D;}
.ri.sel{background:#FFF0DC;border-color:#2E7D6B;}
.ri.dis{opacity:0.5;cursor:not-allowed;}
.ri-chk{width:16px;height:16px;border-radius:50%;border:2px solid #D4B896;display:flex;align-items:center;justify-content:center;flex-shrink:0;font-size:9px;}
.ri.sel .ri-chk{background:#2E7D6B;border-color:#2E7D6B;color:#fff;}
.ri-t{font-weight:bold;color:#5C3D2E;font-size:11px;}
.ri-s{font-size:10px;color:#A08060;}
.cart-area{background:#EEF7F4;border:1.5px solid #A8D5C8;border-radius:6px;padding:7px 9px;min-height:36px;display:flex;flex-wrap:wrap;gap:4px;}
.c-chip{background:#2E7D6B;color:#fff;border-radius:14px;padding:2px 8px;font-size:10px;display:flex;align-items:center;gap:3px;}
.c-chip button{background:none;border:none;color:#fff;cursor:pointer;font-size:10px;line-height:1;}
.mfooter{margin-top:10px;display:flex;gap:7px;justify-content:flex-end;}
.btn-ok{background:#2E7D6B;color:#fff;border:none;border-radius:5px;padding:8px 18px;font-size:12px;font-weight:bold;cursor:pointer;}
.btn-cl{background:#E8D5B0;color:#5C3D2E;border:none;border-radius:5px;padding:8px 14px;font-size:12px;cursor:pointer;}
.toast{display:none;position:fixed;top:18px;left:50%;transform:translateX(-50%);background:#2E7D6B;color:#fff;padding:9px 20px;border-radius:6px;font-size:12px;font-weight:bold;z-index:9999;}
.toast.err{background:#C62828;}
.footer{text-align:center;padding:18px;color:#A08060;font-size:11px;border-top:1px solid #DDD0BC;margin-top:30px;}
.hamburger{display:none;background:none;border:none;color:#F5E6C8;font-size:24px;cursor:pointer;padding:4px 8px;line-height:1;flex-shrink:0;}
.sidebar-toggle{display:none;width:100%;background:#5C3D2E;color:#F5E6C8;border:none;border-radius:8px;padding:10px 16px;font-size:13px;font-family:inherit;cursor:pointer;margin-bottom:10px;text-align:left;}
.sidebar-toggle::after{content:' ▼';font-size:11px;}
.sidebar-toggle.open::after{content:' ▲';}
@media (max-width:767px){
  .header,.header-inner,.layout,.main-content,.search-area,.result-hdr,.table-wrap,.paging,.modal{max-width:100%;box-sizing:border-box;}
  .hamburger{display:block;}
  .hdr-search{display:none;}
  .nav-links{display:none;}
  .header-inner{padding:10px 14px;}
  .logo a{font-size:15px;}
  .layout{grid-template-columns:1fr;padding:0 12px;margin:16px auto;gap:0;}
  .sidebar-toggle{display:block;}
  .sidebar{display:none;}
  .sidebar.open{display:block;}
  .search-area{flex-wrap:wrap;padding:10px 12px;gap:8px;}
  .search-area select{width:100%;}
  .search-area input{width:100%;}
  .btn-srch,.btn-reset{flex:1;}
  .result-hdr{flex-direction:column;align-items:flex-start;gap:8px;}
  /* 테이블 → 카드 변환 */
  .table-wrap{background:transparent;box-shadow:none;border-radius:0;overflow:visible;}
  table,tbody,tr,td{display:block;}
  thead{display:none;}
  tbody tr{background:#FFFDF8;border-radius:10px;box-shadow:0 2px 8px rgba(92,61,46,0.1);margin-bottom:10px;border-left:4px solid #5C3D2E;overflow:hidden;}
  tbody tr:hover{background:#FFF8EE;}
  tbody td{display:flex;align-items:center;gap:8px;padding:9px 14px!important;font-size:13px;text-align:left!important;border-bottom:1px solid #F0E8DC;}
  tbody td:last-child{border-bottom:none;}
  tbody td::before{content:attr(data-label);font-size:11px;font-weight:bold;color:#A08060;min-width:54px;flex-shrink:0;}
  tbody td.td-num{display:none;}
  tbody td.td-empty{justify-content:center;padding:28px 14px!important;}
  tbody td.td-empty::before{display:none;}
  .modal{max-width:100%;max-height:95vh;padding:14px 12px 10px;border-radius:8px;}
  .ms-row{flex-wrap:wrap;}
  .ms-row select{width:100%;}
  .paging{gap:3px;}
  .p-btn{padding:8px 10px;font-size:12px;}
}
@media (min-width:768px) and (max-width:1024px){
  .layout{grid-template-columns:180px 1fr;padding:0 16px;gap:14px;}
  .header-inner{padding:10px 16px;}
  .hdr-search{max-width:260px;}
  .modal{max-width:90%;}
  .chosung-grid{grid-template-columns:repeat(4,1fr);}
}
</style>
</head>
<body>
<div id="toast" class="toast"></div>

<!-- 헤더 -->
<div class="header">
  <div class="header-inner">
    <div class="logo">
      <a href="${pageContext.request.contextPath}/main/mainPage.do">📚 폴리 도서관</a>
      <div class="sub">Poly AI Library</div>
    </div>
    <form action="${pageContext.request.contextPath}/book/bookList.do" method="get" class="hdr-search">
      <input type="text" name="keyword" value="${keyword}" placeholder="도서명, 저자 검색...">
      <button type="submit">검색</button>
    </form>
    <div class="nav-links">
      <a href="${pageContext.request.contextPath}/main/mainPage.do">홈</a>
      <a href="${pageContext.request.contextPath}/book/bookList.do">도서목록</a>
      <c:if test="${not empty sessionScope.loginVO}">
        <a href="${pageContext.request.contextPath}/loan/myLoan.do">내 대출</a>
      </c:if>
      <c:if test="${sessionScope.loginVO.role=='ADMIN'}">
        <a href="${pageContext.request.contextPath}/admin/adminMain.do" style="color:#E8C87A;">관리자</a>
      </c:if>
      <c:choose>
        <c:when test="${not empty sessionScope.loginVO}">
          <div class="user-menu" id="userMenu">
            <button class="user-btn" onclick="toggleMenu()">👤 ${sessionScope.loginVO.userName} ▼</button>
            <div class="dropdown">
              <div class="drop-hdr">📖 내 대출</div>
              <div class="drop-body" id="dropBody"><div class="edrop">불러오는 중...</div></div>
              <div class="drop-ft"><a href="${pageContext.request.contextPath}/loan/myLoan.do">전체 보기 →</a></div>
            </div>
          </div>
          <a href="${pageContext.request.contextPath}/user/logout.do"
             onclick="return confirm('로그아웃?')" style="color:#C4A882;font-size:11px;">로그아웃</a>
        </c:when>
        <c:otherwise>
          <a href="${pageContext.request.contextPath}/user/loginView.do">로그인</a>
          <a href="${pageContext.request.contextPath}/user/joinView.do">회원가입</a>
        </c:otherwise>
      </c:choose>
    </div>
    <button class="hamburger" onclick="openMobileNav()">☰</button>
  </div>
</div>

<div class="layout">
  <!-- 모바일 사이드바 토글 -->
  <div style="grid-column:1/-1;display:none;" id="sidebarToggleWrap">
    <button class="sidebar-toggle" id="sidebarToggle" onclick="toggleSidebar()">🔍 검색 필터</button>
  </div>
  <!-- 사이드바 -->
  <div class="sidebar" id="sidebarPanel">

    <!-- 초성 검색 -->
    <div class="side-card">
      <div class="side-hdr">🔤 초성 검색</div>
      <div class="side-body">
        <div class="chosung-grid">
          <button class="cs-btn ${initial=='가'?'active':''}" onclick="setInitial('가')">ㄱ</button>
          <button class="cs-btn ${initial=='나'?'active':''}" onclick="setInitial('나')">ㄴ</button>
          <button class="cs-btn ${initial=='다'?'active':''}" onclick="setInitial('다')">ㄷ</button>
          <button class="cs-btn ${initial=='라'?'active':''}" onclick="setInitial('라')">ㄹ</button>
          <button class="cs-btn ${initial=='마'?'active':''}" onclick="setInitial('마')">ㅁ</button>
          <button class="cs-btn ${initial=='바'?'active':''}" onclick="setInitial('바')">ㅂ</button>
          <button class="cs-btn ${initial=='사'?'active':''}" onclick="setInitial('사')">ㅅ</button>
          <button class="cs-btn ${initial=='아'?'active':''}" onclick="setInitial('아')">ㅇ</button>
          <button class="cs-btn ${initial=='자'?'active':''}" onclick="setInitial('자')">ㅈ</button>
          <button class="cs-btn ${initial=='차'?'active':''}" onclick="setInitial('차')">ㅊ</button>
          <button class="cs-btn ${initial=='카'?'active':''}" onclick="setInitial('카')">ㅋ</button>
          <button class="cs-btn ${initial=='타'?'active':''}" onclick="setInitial('타')">ㅌ</button>
          <button class="cs-btn ${initial=='파'?'active':''}" onclick="setInitial('파')">ㅍ</button>
          <button class="cs-btn ${initial=='하'?'active':''}" onclick="setInitial('하')">ㅎ</button>
          <button class="cs-btn ${initial=='A'?'active':''}" onclick="setInitial('A')">A-Z</button>
        </div>
        <c:if test="${not empty initial}">
          <button onclick="setInitial('')"
                  style="width:100%;margin-top:6px;padding:5px;background:#C4A882;color:#fff;border:none;border-radius:5px;font-size:11px;cursor:pointer;">
            초성 필터 해제
          </button>
        </c:if>
      </div>
    </div>

    <!-- 장르 필터 -->
    <div class="side-card">
      <div class="side-hdr">📂 장르별 조회</div>
      <div class="side-body">
        <div class="cat-list">
          <button class="cat-btn ${empty category?'active':''}" onclick="setCategory('')">
            전체 <span class="cat-cnt">${totalBookCount}</span>
          </button>
          <button class="cat-btn ${category=='컴퓨터/IT'?'active':''}" onclick="setCategory('컴퓨터/IT')">컴퓨터/IT <span class="cat-cnt">${catCount['컴퓨터/IT']}</span></button>
          <button class="cat-btn ${category=='경영/경제'?'active':''}" onclick="setCategory('경영/경제')">경영/경제 <span class="cat-cnt">${catCount['경영/경제']}</span></button>
          <button class="cat-btn ${category=='소설/문학'?'active':''}" onclick="setCategory('소설/문학')">소설/문학 <span class="cat-cnt">${catCount['소설/문학']}</span></button>
          <button class="cat-btn ${category=='인문/사회'?'active':''}" onclick="setCategory('인문/사회')">인문/사회 <span class="cat-cnt">${catCount['인문/사회']}</span></button>
          <button class="cat-btn ${category=='과학/기술'?'active':''}" onclick="setCategory('과학/기술')">과학/기술 <span class="cat-cnt">${catCount['과학/기술']}</span></button>
          <button class="cat-btn ${category=='자기계발'?'active':''}" onclick="setCategory('자기계발')">자기계발 <span class="cat-cnt">${catCount['자기계발']}</span></button>
          <button class="cat-btn ${category=='역사/문화'?'active':''}" onclick="setCategory('역사/문화')">역사/문화 <span class="cat-cnt">${catCount['역사/문화']}</span></button>
          <button class="cat-btn ${category=='예술/디자인'?'active':''}" onclick="setCategory('예술/디자인')">예술/디자인 <span class="cat-cnt">${catCount['예술/디자인']}</span></button>
          <button class="cat-btn ${category=='의학/건강'?'active':''}" onclick="setCategory('의학/건강')">의학/건강 <span class="cat-cnt">${catCount['의학/건강']}</span></button>
          <button class="cat-btn ${category=='기타'?'active':''}" onclick="setCategory('기타')">기타 <span class="cat-cnt">${catCount['기타']}</span></button>
        </div>
      </div>
    </div>

    <!-- 정렬 -->
    <div class="side-card">
      <div class="side-hdr">📊 정렬</div>
      <div class="side-body">
        <div class="filter-row">
          <button class="f-btn ${sortType=='title'?'active':''}" onclick="setSort('title')">가나다순</button>
          <button class="f-btn ${sortType=='loanCount'?'active':''}" onclick="setSort('loanCount')">대출많은순</button>
        </div>
        <div style="margin-top:8px;">
          <button class="f-btn ${statusFilter=='Y'?'active':''}" onclick="setStatus('Y')" style="width:100%;margin-bottom:4px;">대출가능만</button>
          <button class="f-btn ${empty statusFilter?'active':''}" onclick="setStatus('')" style="width:100%;">전체</button>
        </div>
      </div>
    </div>

    <!-- 어드민 빠른메뉴 -->
    <c:if test="${sessionScope.loginVO.role=='ADMIN'}">
      <div class="side-card">
        <div class="side-hdr">⚙️ 관리</div>
        <div class="side-body" style="display:flex;flex-direction:column;gap:5px;">
          <a href="${pageContext.request.contextPath}/book/bookRegisterView.do" class="btn-register" style="text-align:center;display:block;">+ 도서 등록</a>
          <a href="${pageContext.request.contextPath}/admin/adminMain.do"
             style="background:#3B2010;color:#FFF8F0;padding:6px 10px;border-radius:5px;text-align:center;text-decoration:none;font-size:12px;display:block;">대시보드</a>
        </div>
      </div>
    </c:if>
  </div>

  <!-- 메인 콘텐츠 -->
  <div class="main-content">
    <!-- 검색 -->
    <form id="searchForm" action="${pageContext.request.contextPath}/book/bookList.do" method="get" class="search-area">
      <input type="hidden" name="category" id="fCat" value="${category}">
      <input type="hidden" name="initial" id="fInit" value="${initial}">
      <input type="hidden" name="sortType" id="fSort" value="${sortType}">
      <input type="hidden" name="statusFilter" id="fStatus" value="${statusFilter}">
      <input type="hidden" name="page" id="fPage" value="1">
      <select name="searchType">
        <option value="title" ${searchType=='title'?'selected':''}>제목</option>
        <option value="author" ${searchType=='author'?'selected':''}>저자</option>
        <option value="publisher" ${searchType=='publisher'?'selected':''}>출판사</option>
      </select>
      <input type="text" name="keyword" value="${keyword}" placeholder="검색어 입력...">
      <button type="submit" class="btn-srch">검색</button>
      <a href="${pageContext.request.contextPath}/book/bookList.do" class="btn-reset">초기화</a>
    </form>

    <!-- 결과 헤더 -->
    <div class="result-hdr">
      <div class="result-title">
        <c:choose>
          <c:when test="${not empty initial}">
            초성 '${initial}' 도서
          </c:when>
          <c:when test="${not empty category}">
            ${category} 도서
          </c:when>
          <c:when test="${not empty keyword}">
            '${keyword}' 검색 결과
          </c:when>
          <c:otherwise>전체 도서</c:otherwise>
        </c:choose>
        <span class="result-count">(총 ${totalCount}권, ${currentPage}/${totalPages}페이지)</span>
      </div>
      <div>
        <c:if test="${not empty sessionScope.loginVO}">
          <button class="btn-loan-top" onclick="openLoanModal()">📚 대출 신청</button>
        </c:if>
      </div>
    </div>

    <!-- 도서 테이블 -->
    <div class="table-wrap">
      <table>
        <thead>
          <tr>
            <th style="width:50px;">번호</th>
            <th style="text-align:left;padding-left:14px;">도서명</th>
            <th style="width:110px;">저자</th>
            <th style="width:110px;">출판사</th>
            <th style="width:80px;">분류</th>
            <th style="width:72px;">상태</th>
            <c:if test="${sessionScope.loginVO.role=='ADMIN'}">
              <th style="width:120px;">관리</th>
            </c:if>
          </tr>
        </thead>
        <tbody>
          <c:choose>
            <c:when test="${empty bookList}">
              <tr><td colspan="7" class="empty-msg td-empty">조건에 맞는 도서가 없습니다.</td></tr>
            </c:when>
            <c:otherwise>
              <c:forEach var="book" items="${bookList}">
                <tr>
                  <td class="td-num" data-label="번호">${book.bookId}</td>
                  <td data-label="도서명" style="text-align:left;padding-left:14px;">
                    <a href="${pageContext.request.contextPath}/book/bookDetail.do?bookId=${book.bookId}"
                       style="color:#3B2F2F;text-decoration:none;font-weight:bold;">${book.title}</a>
                  </td>
                  <td data-label="저자">${book.author}</td>
                  <td data-label="출판사">${book.publisher}</td>
                  <td data-label="분류"><span style="font-size:10px;color:#2E7D6B;">${empty book.category?'기타':book.category}</span></td>
                  <td data-label="상태"><span class="badge ${book.status=='Y'?'badge-y':'badge-n'}">${book.status=='Y'?'대출가능':'대출중'}</span></td>
                  <c:if test="${sessionScope.loginVO.role=='ADMIN'}">
                    <td class="td-admin" data-label="관리">
                      <a href="${pageContext.request.contextPath}/book/bookModifyView.do?bookId=${book.bookId}" class="btn-e">수정</a>
                      <a href="${pageContext.request.contextPath}/book/bookDelete.do?bookId=${book.bookId}"
                         class="btn-d" onclick="return confirm('삭제?')">삭제</a>
                    </td>
                  </c:if>
                </tr>
              </c:forEach>
            </c:otherwise>
          </c:choose>
        </tbody>
      </table>
    </div>

    <!-- 페이지네이션 -->
    <c:if test="${totalPages > 1}">
      <div class="paging">
        <c:if test="${currentPage > 1}">
          <a href="javascript:goPage(1)" class="p-btn">«</a>
          <a href="javascript:goPage(${currentPage-1})" class="p-btn">‹</a>
        </c:if>
        <c:forEach begin="${currentPage > 3 ? currentPage-2 : 1}"
                   end="${currentPage+2 < totalPages ? currentPage+2 : totalPages}" var="p">
          <a href="javascript:goPage(${p})" class="p-btn ${p==currentPage?'active':''}">${p}</a>
        </c:forEach>
        <c:if test="${currentPage < totalPages}">
          <a href="javascript:goPage(${currentPage+1})" class="p-btn">›</a>
          <a href="javascript:goPage(${totalPages})" class="p-btn">»</a>
        </c:if>
      </div>
    </c:if>
  </div>
</div>

<!-- 대출 모달 -->
<div class="modal-overlay" id="loanModal">
  <div class="modal">
    <button class="modal-close" onclick="closeLoanModal()">✕</button>
    <h2>📚 도서 대출 신청</h2>
    <p class="modal-sub">도서를 검색해 장바구니에 담고 신청하세요.</p>
    <hr class="mdv">
    <div class="sec-t">도서 검색</div>
    <div class="ms-row">
      <select id="bst"><option value="title">제목</option><option value="author">저자</option></select>
      <input type="text" id="bkw" placeholder="검색어..." onkeydown="if(event.keyCode==13)srchBook()">
      <button class="btn-ms" onclick="srchBook()">검색</button>
    </div>
    <div class="rbox" id="bres"><span style="color:#C4A882;">검색 결과가 표시됩니다.</span></div>
    <hr class="mdv">
    <div class="sec-t">장바구니 <span id="cntLbl" style="color:#2E7D6B;font-weight:bold;">(0권)</span></div>
    <div class="cart-area" id="cartArea"><span style="color:#A08060;font-size:10px;">선택하면 표시됩니다.</span></div>
    <div class="mfooter">
      <button class="btn-cl" onclick="closeLoanModal()">취소</button>
      <button class="btn-ok" onclick="submitLoan()">대출 신청</button>
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
    <a href="${pageContext.request.contextPath}/main/mainPage.do" style="color:#F5E6C8;text-decoration:none;padding:12px 8px;border-bottom:1px solid rgba(255,255,255,0.08);font-size:14px;">🏠 홈</a>
    <a href="${pageContext.request.contextPath}/book/bookList.do" style="color:#F5E6C8;text-decoration:none;padding:12px 8px;border-bottom:1px solid rgba(255,255,255,0.08);font-size:14px;">📖 도서목록</a>
    <c:if test="${not empty sessionScope.loginVO}">
      <a href="${pageContext.request.contextPath}/loan/myLoan.do" style="color:#F5E6C8;text-decoration:none;padding:12px 8px;border-bottom:1px solid rgba(255,255,255,0.08);font-size:14px;">📋 내 대출</a>
    </c:if>
    <c:if test="${sessionScope.loginVO.role=='ADMIN'}">
      <a href="${pageContext.request.contextPath}/admin/adminMain.do" style="color:#E8C87A;text-decoration:none;padding:12px 8px;border-bottom:1px solid rgba(255,255,255,0.08);font-size:14px;">⚙️ 관리자</a>
    </c:if>
    <c:choose>
      <c:when test="${not empty sessionScope.loginVO}">
        <a href="${pageContext.request.contextPath}/user/logout.do" onclick="return confirm('로그아웃?')" style="color:#C4A882;text-decoration:none;padding:12px 8px;font-size:14px;">🚪 로그아웃</a>
      </c:when>
      <c:otherwise>
        <a href="${pageContext.request.contextPath}/user/loginView.do" style="color:#F5E6C8;text-decoration:none;padding:12px 8px;border-bottom:1px solid rgba(255,255,255,0.08);font-size:14px;">🔑 로그인</a>
        <a href="${pageContext.request.contextPath}/user/joinView.do" style="color:#F5E6C8;text-decoration:none;padding:12px 8px;font-size:14px;">✏️ 회원가입</a>
      </c:otherwise>
    </c:choose>
  </div>
</nav>

<script>
var CP='${pageContext.request.contextPath}';

function openMobileNav(){document.getElementById('mobileNav').style.display='flex';document.getElementById('navOverlay').style.display='block';document.body.style.overflow='hidden';}
function closeMobileNav(){document.getElementById('mobileNav').style.display='none';document.getElementById('navOverlay').style.display='none';document.body.style.overflow='';}
function toggleSidebar(){var p=document.getElementById('sidebarPanel'),t=document.getElementById('sidebarToggle');p.classList.toggle('open');t.classList.toggle('open');}
(function(){var mq=window.matchMedia('(max-width:767px)');function chk(m){var w=document.getElementById('sidebarToggleWrap');if(w)w.style.display=m.matches?'block':'none';}chk(mq);if(mq.addEventListener)mq.addEventListener('change',chk);else mq.addListener(chk);})();
// 토스트
var urlP=new URLSearchParams(window.location.search);
if(urlP.get('msg'))showToast(decodeURIComponent(urlP.get('msg').replace(/\+/g,' ')));
function showToast(m,e){var t=document.getElementById('toast');t.textContent=m;t.className='toast'+(e?' err':'');t.style.display='block';setTimeout(function(){t.style.display='none';},3000);}

// 드롭다운
function toggleMenu(){var m=document.getElementById('userMenu');m.classList.toggle('open');if(m.classList.contains('open'))loadSum();}
document.addEventListener('click',function(e){var m=document.getElementById('userMenu');if(m&&!m.contains(e.target))m.classList.remove('open');});
function loadSum(){
    fetch(CP+'/loan/myLoanSummary.do').then(function(r){return r.json();}).then(function(d){
        var el=document.getElementById('dropBody');
        if(!d||d.length===0){el.innerHTML='<div class="edrop">대출 없음</div>';return;}
        var h='';d.forEach(function(l){h+='<div class="li"><div class="li-t">'+l.bookTitle+'</div><div class="li-m"><span>'+l.returnDate+'</span><span class="'+(l.ddayClass||'ddok')+'">'+(l.ddayLabel||'')+'</span></div></div>';});
        el.innerHTML=h;
    }).catch(function(){document.getElementById('dropBody').innerHTML='<div class="edrop">오류</div>';});
}

// 필터 함수들
function setInitial(v){document.getElementById('fInit').value=v;document.getElementById('fPage').value=1;document.getElementById('searchForm').submit();}
function setCategory(v){document.getElementById('fCat').value=v;document.getElementById('fPage').value=1;document.getElementById('searchForm').submit();}
function setSort(v){document.getElementById('fSort').value=v;document.getElementById('fPage').value=1;document.getElementById('searchForm').submit();}
function setStatus(v){document.getElementById('fStatus').value=v;document.getElementById('fPage').value=1;document.getElementById('searchForm').submit();}
function goPage(p){document.getElementById('fPage').value=p;document.getElementById('searchForm').submit();}

// 초성 매핑
function setInitial(cs){
    var map={'ㄱ':'가','ㄴ':'나','ㄷ':'다','ㄹ':'라','ㅁ':'마','ㅂ':'바','ㅅ':'사','ㅇ':'아','ㅈ':'자','ㅊ':'차','ㅋ':'카','ㅌ':'타','ㅍ':'파','ㅎ':'하'};
    document.getElementById('fInit').value=map[cs]||cs;
    document.getElementById('fPage').value=1;
    document.getElementById('searchForm').submit();
}

// 대출 모달
var cart={};
function openLoanModal(){document.getElementById('loanModal').classList.add('active');}
function closeLoanModal(){document.getElementById('loanModal').classList.remove('active');}
document.getElementById('loanModal').addEventListener('click',function(e){if(e.target===this)closeLoanModal();});
function srchBook(){
    var t=document.getElementById('bst').value,k=document.getElementById('bkw').value.trim();
    if(!k){showToast('검색어를 입력하세요.',true);return;}
    document.getElementById('bres').innerHTML='<span style="color:#A08060;">검색 중...</span>';
    fetch(CP+'/loan/searchBook.do?searchType='+t+'&keyword='+encodeURIComponent(k))
    .then(function(r){return r.json();}).then(function(list){
        if(!list||list.length===0){document.getElementById('bres').innerHTML='<span style="color:#A08060;">결과 없음</span>';return;}
        var h='';list.forEach(function(b){
            var inC=cart[b.bookId]!==undefined,na=b.status!=='Y';
            h+='<div class="ri '+(inC?'sel':na?'dis':'')+'" onclick="togCart('+b.bookId+',\''+esc(b.title)+'\',\''+b.status+'\')">'
             +'<div class="ri-chk">'+(inC?'✓':'')+'</div>'
             +'<div><div class="ri-t">'+b.title+'</div><div class="ri-s">'+b.author+(na?' · <span style="color:#E65100;">대출중</span>':'')+'</div></div></div>';
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
    if(cnt===0){document.getElementById('cartArea').innerHTML='<span style="color:#A08060;font-size:10px;">선택하면 표시됩니다.</span>';return;}
    var h='';for(var id in cart)h+='<div class="c-chip">'+cart[id]+'<button onclick="rmCart('+id+')">✕</button></div>';
    document.getElementById('cartArea').innerHTML=h;
}
function rmCart(id){delete cart[id];renderCart();}
function submitLoan(){
    var ids=Object.keys(cart);
    if(ids.length===0){showToast('대출할 도서를 선택하세요.',true);return;}
    var form=document.createElement('form');form.method='POST';
    form.action=CP+'/loan/loanApplyMulti.do';
    ids.forEach(function(id){var i=document.createElement('input');i.type='hidden';i.name='bookIds';i.value=id;form.appendChild(i);});
    var m=document.createElement('input');m.type='hidden';m.name='memberId';m.value='${sessionScope.loginVO.userId}';form.appendChild(m);
    document.body.appendChild(form);form.submit();
}
</script>
</body>
</html>
