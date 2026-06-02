<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://fonts.googleapis.com/css2?family=Noto+Serif+KR:wght@400;700&display=swap" rel="stylesheet">
<title>회원 관리 - 폴리 인공지능 도서관</title>
<style>
*{margin:0;padding:0;box-sizing:border-box;}
body{font-family:'Noto Serif KR',serif;background:#F0EBE0;color:#3B2F2F;min-height:100vh;}
.header{background:#3B2010;box-shadow:0 2px 8px rgba(0,0,0,0.4);}
.header-inner{max-width:1300px;margin:0 auto;padding:14px 30px;display:flex;align-items:center;justify-content:space-between;}
.logo-area h1{color:#F5E6C8;font-size:19px;}
.admin-badge{background:#C62828;color:#fff;font-size:11px;padding:2px 8px;border-radius:10px;margin-left:8px;}
.nav-links{display:flex;gap:16px;align-items:center;}
.nav-links a{color:#F5E6C8;text-decoration:none;font-size:13px;padding:6px 12px;border-radius:6px;}
.nav-links a:hover{background:rgba(255,255,255,0.1);}
.container{max-width:1100px;margin:28px auto;padding:0 30px;}
.page-title{font-size:22px;color:#3B2010;font-weight:bold;border-left:5px solid #A0522D;padding-left:14px;margin-bottom:20px;}
.card{background:#FFFDF8;border-radius:12px;box-shadow:0 2px 12px rgba(59,32,16,0.1);overflow:hidden;}
table{width:100%;border-collapse:collapse;}
thead tr{background:#3B2010;}
thead th{color:#F5E6C8;padding:12px;font-size:13px;text-align:center;}
tbody td{padding:12px;font-size:13px;text-align:center;border-bottom:1px solid #EDE0CE;}
tbody tr:hover{background:#FFF8EE;}
.role-select{padding:5px 10px;border:1.5px solid #D4B896;border-radius:5px;font-size:12px;background:#FFF8F0;font-family:inherit;cursor:pointer;}
.btn-role{background:#5C3D2E;color:#fff;border:none;border-radius:5px;padding:5px 12px;font-size:11px;cursor:pointer;font-family:inherit;margin-left:6px;}
.badge-admin{background:#C62828;color:#fff;padding:3px 10px;border-radius:10px;font-size:11px;font-weight:bold;}
.badge-user{background:#E8D5B0;color:#5C3D2E;padding:3px 10px;border-radius:10px;font-size:11px;}
.toast{display:none;position:fixed;top:24px;left:50%;transform:translateX(-50%);background:#2E7D6B;color:#fff;padding:12px 24px;border-radius:8px;font-size:13px;z-index:9999;}
.toast.err{background:#C62828;}
.footer{text-align:center;padding:20px;color:#A08060;font-size:12px;border-top:1px solid #DDD0BC;margin-top:40px;}
</style>
</head>
<body>
<div id="toast" class="toast"></div>
<div class="header">
  <div class="header-inner">
    <div class="logo-area">
      <h1>📚 폴리 인공지능 도서관 <span class="admin-badge">ADMIN</span></h1>
    </div>
    <div class="nav-links">
      <a href="${pageContext.request.contextPath}/admin/adminMain.do">← 대시보드</a>
      <a href="${pageContext.request.contextPath}/book/bookList.do">도서목록</a>
      <a href="${pageContext.request.contextPath}/user/logout.do"
         onclick="return confirm('로그아웃?')" style="color:#C4A882;">로그아웃</a>
    </div>
  </div>
</div>

<div class="container">
  <div class="page-title">👥 회원 관리</div>
  <div class="card">
    <table>
      <thead>
        <tr>
          <th>아이디</th>
          <th>이름</th>
          <th>전화번호</th>
          <th>이메일</th>
          <th>현재 권한</th>
          <th>권한 변경</th>
        </tr>
      </thead>
      <tbody>
        <c:forEach var="user" items="${userList}">
          <tr>
            <td><strong>${user.memberId}</strong></td>
            <td>${user.name}</td>
            <td>${user.phone}</td>
            <td>${user.email}</td>
            <td>
              <span class="${user.role=='ADMIN'?'badge-admin':'badge-user'}">${user.role}</span>
            </td>
            <td>
              <c:if test="${user.memberId != sessionScope.loginVO.userId}">
                <select class="role-select" id="role_${user.memberId}">
                  <option value="USER" ${user.role=='USER'?'selected':''}>USER</option>
                  <option value="ADMIN" ${user.role=='ADMIN'?'selected':''}>ADMIN</option>
                </select>
                <button class="btn-role" onclick="changeRole('${user.memberId}')">변경</button>
              </c:if>
              <c:if test="${user.memberId == sessionScope.loginVO.userId}">
                <span style="font-size:11px;color:#A08060;">본인</span>
              </c:if>
            </td>
          </tr>
        </c:forEach>
      </tbody>
    </table>
  </div>
</div>
<div class="footer">© 2026 폴리 인공지능 도서관</div>

<script>
function changeRole(memberId) {
    var role = document.getElementById('role_'+memberId).value;
    if(!confirm(memberId + '님의 권한을 ' + role + '(으)로 변경하시겠습니까?')) return;
    fetch('${pageContext.request.contextPath}/admin/updateRole.do', {
        method:'POST',
        headers:{'Content-Type':'application/x-www-form-urlencoded'},
        body:'memberId='+encodeURIComponent(memberId)+'&role='+role
    }).then(function(r){return r.text();}).then(function(res){
        var t=document.getElementById('toast');
        if(res==='OK'){t.textContent='권한이 변경되었습니다.';t.className='toast';}
        else{t.textContent='변경 실패';t.className='toast err';}
        t.style.display='block';setTimeout(function(){t.style.display='none';location.reload();},1500);
    });
}
</script>
</body>
</html>
