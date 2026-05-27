<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 - 폴리 인공지능 도서관</title>
<script>
  var msg = "${msg}";
  if (msg && msg !== "null" && msg !== "") { alert(msg); }
</script>
<style>
  * { margin: 0; padding: 0; box-sizing: border-box; }
  body { font-family: 'Georgia', serif; background-color: #F5F0E8; color: #3B2F2F; display: flex; flex-direction: column; min-height: 100vh; }
  .header { background-color: #5C3D2E; padding: 20px; box-shadow: 0 2px 8px rgba(0,0,0,0.3); text-align: center; position: relative; }
  .header h1 { color: #F5E6C8; font-size: 22px; letter-spacing: 1px; }
  .header h1 a { color: inherit; text-decoration: none; }
  .header h1 a:hover { color: #E8C87A; }
  .btn-home { position: absolute; left: 24px; top: 50%; transform: translateY(-50%); color: #C4A882; text-decoration: none; font-size: 13px; border: 1px solid #8A6040; border-radius: 5px; padding: 6px 14px; }
  .btn-home:hover { color: #F5E6C8; border-color: #C4A882; }
  .login-container { flex: 1; display: flex; align-items: center; justify-content: center; padding: 20px; }
  .login-card { background: #FFFDF8; width: 100%; max-width: 400px; padding: 40px; border-radius: 12px; box-shadow: 0 4px 20px rgba(92,61,46,0.15); border: 1px solid #EDE0CE; }
  .login-card h2 { color: #5C3D2E; text-align: center; margin-bottom: 30px; font-size: 22px; }
  .input-group { margin-bottom: 20px; }
  .input-group label { display: block; margin-bottom: 8px; color: #5C3D2E; font-size: 14px; font-weight: bold; }
  .input-group input { width: 100%; padding: 12px; border: 1.5px solid #D4B896; border-radius: 6px; background: #FFF8F0; font-family: inherit; font-size: 14px; }
  .input-group input:focus { outline: none; border-color: #A0522D; }
  .btn-login { width: 100%; background: #5C3D2E; color: #F5E6C8; padding: 14px; border: none; border-radius: 6px; cursor: pointer; font-size: 16px; font-weight: bold; margin-top: 10px; font-family: inherit; }
  .btn-login:hover { background: #3D2719; }
  .login-footer { margin-top: 20px; text-align: center; font-size: 14px; color: #A08060; }
  .login-footer a { color: #A0522D; text-decoration: none; font-weight: bold; }
  .login-footer a:hover { text-decoration: underline; }
  .divider { border: none; border-top: 1px solid #EDE0CE; margin: 16px 0; }
  .footer { text-align: center; padding: 24px; color: #A08060; font-size: 13px; border-top: 1px solid #DDD0BC; }
</style>
</head>
<body>

<div class="header">
  <a href="${pageContext.request.contextPath}/book/bookList.do" class="btn-home">← 메인으로</a>
  <h1><a href="${pageContext.request.contextPath}/book/bookList.do">📚 폴리 인공지능 도서관</a></h1>
</div>

<div class="login-container">
  <div class="login-card">
    <h2>도서관 로그인</h2>
    <form action="${pageContext.request.contextPath}/user/login.do" method="post">
      <div class="input-group">
        <label for="userId">아이디</label>
        <input type="text" id="userId" name="userId" placeholder="ID를 입력하세요" required>
      </div>
      <div class="input-group">
        <label for="password">비밀번호</label>
        <input type="password" id="password" name="password" placeholder="Password를 입력하세요" required>
      </div>
      <button type="submit" class="btn-login">로그인</button>
    </form>

    <hr class="divider">

    <div class="login-footer">
      아직 회원이 아니신가요?
      <a href="${pageContext.request.contextPath}/user/joinView.do">회원가입 하기</a>
    </div>
    <div class="login-footer" style="margin-top:8px;">
      <a href="${pageContext.request.contextPath}/book/bookList.do">← 메인 화면으로 돌아가기</a>
    </div>
  </div>
</div>

<div class="footer">© 2026 폴리 인공지능 도서관 · Poly AI Library</div>
</body>
</html>
