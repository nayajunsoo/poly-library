<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="https://fonts.googleapis.com/css2?family=Noto+Serif+KR:wght@400;700&display=swap" rel="stylesheet">
<title>로그인 - 폴리 인공지능 도서관</title>
<script>var msg="${msg}"; if(msg&&msg!=""&&msg!="null"){alert(decodeURIComponent(msg.replace(/\+/g,' ')));}</script>
<style>
*{margin:0;padding:0;box-sizing:border-box;}
html,body{overflow-x:hidden;max-width:100%;}
body{font-family:'Noto Serif KR',serif;background-color:#F5F0E8;display:flex;flex-direction:column;min-height:100vh;}
.header{background-color:#5C3D2E;padding:20px;box-shadow:0 2px 8px rgba(0,0,0,0.3);text-align:center;position:relative;}
.header h1{color:#F5E6C8;font-size:22px;letter-spacing:1px;}
.header h1 a{color:inherit;text-decoration:none;}
.btn-back{position:absolute;left:24px;top:50%;transform:translateY(-50%);color:#C4A882;text-decoration:none;font-size:13px;border:1px solid #8A6040;border-radius:5px;padding:6px 14px;}
.login-container{flex:1;display:flex;align-items:center;justify-content:center;padding:20px;}
.login-card{background:#FFFDF8;width:100%;max-width:400px;padding:40px;border-radius:12px;box-shadow:0 4px 20px rgba(92,61,46,0.15);}
.login-card h2{color:#5C3D2E;text-align:center;margin-bottom:30px;font-size:22px;}
.loan-notice{background:#EEF7F4;border:1px solid #A8D5C8;border-radius:8px;padding:12px 16px;margin-bottom:20px;font-size:13px;color:#2E7D6B;text-align:center;}
.input-group{margin-bottom:20px;}
.input-group label{display:block;margin-bottom:8px;color:#5C3D2E;font-size:14px;font-weight:bold;}
.input-group input{width:100%;padding:12px;border:1.5px solid #D4B896;border-radius:6px;background:#FFF8F0;font-family:inherit;font-size:14px;}
.btn-login{width:100%;background:#5C3D2E;color:#F5E6C8;padding:14px;border:none;border-radius:6px;cursor:pointer;font-size:16px;font-weight:bold;margin-top:10px;font-family:inherit;}
.divider{border:none;border-top:1px solid #EDE0CE;margin:16px 0;}
.login-footer{margin-top:12px;text-align:center;font-size:14px;color:#A08060;}
.login-footer a{color:#A0522D;text-decoration:none;font-weight:bold;}
.footer{text-align:center;padding:24px;color:#A08060;font-size:13px;border-top:1px solid #DDD0BC;}
@media (max-width:767px){
  .header,.login-container,.login-card,.input-group,.input-group input,.btn-login{max-width:100%;box-sizing:border-box;}
  .header{padding:14px 16px;}
  .header h1{font-size:17px;}
  .btn-back{left:12px;font-size:11px;padding:5px 10px;}
  .login-card{padding:28px 18px;}
  .login-card h2{font-size:19px;margin-bottom:22px;}
  .input-group input{padding:14px 12px;font-size:15px;}
  .btn-login{padding:16px;font-size:15px;}
  .footer{font-size:12px;padding:16px;}
}
</style>
</head>
<body>
<div class="header">
  <a href="${pageContext.request.contextPath}/book/bookList.do" class="btn-back">← 메인으로</a>
  <h1><a href="${pageContext.request.contextPath}/book/bookList.do">📚 폴리 인공지능 도서관</a></h1>
</div>
<div class="login-container">
  <div class="login-card">
    <h2>도서관 로그인</h2>
    <c:if test="${not empty returnUrl}">
      <div class="loan-notice">📖 대출 신청을 위해 로그인이 필요합니다.</div>
    </c:if>
    <form action="${pageContext.request.contextPath}/user/login.do" method="post">
      <input type="hidden" name="returnUrl" value="${returnUrl}">
      <div class="input-group">
        <label>아이디</label>
        <input type="text" name="userId" placeholder="아이디를 입력하세요" required autofocus>
      </div>
      <div class="input-group">
        <label>비밀번호</label>
        <input type="password" name="password" placeholder="비밀번호를 입력하세요" required>
      </div>
      <button type="submit" class="btn-login">로그인</button>
    </form>
    <hr class="divider">
    <div class="login-footer">아직 회원이 아니신가요? <a href="${pageContext.request.contextPath}/user/joinView.do?returnUrl=${returnUrl}">회원가입 하기</a></div>
    <div class="login-footer" style="margin-top:8px;"><a href="${pageContext.request.contextPath}/book/bookList.do">← 메인으로 돌아가기</a></div>
  </div>
</div>
<div class="footer">2026 폴리 인공지능 도서관</div>
</body>
</html>
