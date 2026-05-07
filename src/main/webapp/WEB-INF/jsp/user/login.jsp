<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 - 폴리 인공지능 도서관</title>
<script type="text/javascript">
    // 서버에서 전달된 메시지가 있을 경우 팝업을 띄웁니다.
    // 회원가입 완료 후 "회원가입이 완료되었습니다" 메시지를 여기서 잡습니다.
    var msg = "${msg}";
    if (msg && msg !== "null" && msg !== "") {
        alert(msg);
    }
</script>
<style>
  * { margin: 0; padding: 0; box-sizing: border-box; }
  body { font-family: 'Georgia', serif; background-color: #F5F0E8; color: #3B2F2F; display: flex; flex-direction: column; min-height: 100vh; }
  
  .header { background-color: #5C3D2E; padding: 20px; box-shadow: 0 2px 8px rgba(0,0,0,0.3); text-align: center; }
  .header h1 { color: #F5E6C8; font-size: 24px; letter-spacing: 1px; }

  .login-container { flex: 1; display: flex; align-items: center; justify-content: center; padding: 20px; }
  .login-card { background: #FFFDF8; width: 100%; max-width: 400px; padding: 40px; border-radius: 12px; box-shadow: 0 4px 20px rgba(92,61,46,0.15); border: 1px solid #EDE0CE; }
  .login-card h2 { color: #5C3D2E; text-align: center; margin-bottom: 30px; font-size: 22px; }
  
  .input-group { margin-bottom: 20px; }
  .input-group label { display: block; margin-bottom: 8px; color: #5C3D2E; font-size: 14px; font-weight: bold; }
  .input-group input { width: 100%; padding: 12px; border: 1.5px solid #D4B896; border-radius: 6px; background: #FFF8F0; font-family: inherit; }
  .input-group input:focus { outline: none; border-color: #A0522D; }
  
  .btn-login { width: 100%; background: #5C3D2E; color: #F5E6C8; padding: 14px; border: none; border-radius: 6px; cursor: pointer; font-size: 16px; font-weight: bold; transition: background 0.2s; margin-top: 10px; }
  .btn-login:hover { background: #3D2719; }
  
  .login-footer { margin-top: 25px; text-align: center; font-size: 14px; color: #A08060; }
  .login-footer a { color: #A0522D; text-decoration: none; font-weight: bold; }
  
  .footer { text-align: center; padding: 24px; color: #A08060; font-size: 13px; border-top: 1px solid #DDD0BC; }
</style>
</head>
<body>

<div class="header">
  <h1>📚 폴리 인공지능 도서관</h1>
</div>

<div class="login-container">
  <div class="login-card">
    <h2>도서관 로그인</h2>
    <%-- contextPath를 사용하여 경로를 유연하게 잡았습니다. --%>
    <form action="${pageContext.request.contextPath}/user/login.do" method="post">
      <div class="input-group">
        <label for="userId">아이디</label>
        <%-- name 속성을 UserVO의 필드명(userId)과 맞췄습니다. --%>
        <input type="text" id="userId" name="userId" placeholder="ID를 입력하세요" required>
      </div>
      <div class="input-group">
        <label for="password">비밀번호</label>
        <%-- 중요: name을 'userPw'에서 'password'로 수정했습니다. UserVO와 일치해야 합니다. --%>
        <input type="password" id="password" name="password" placeholder="Password를 입력하세요" required>
      </div>
      <button type="submit" class="btn-login">로그인</button>
    </form>
    
    <div class="login-footer">
      아직 회원이 아니신가요? <a href="${pageContext.request.contextPath}/user/joinView.do">회원가입 하기</a>
    </div>
  </div>
</div>

<div class="footer">© 2026 폴리 인공지능 도서관 · Poly AI Library</div>

</body>
</html>