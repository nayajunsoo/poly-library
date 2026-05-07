<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 - 폴리 인공지능 도서관</title>
<style>
  * { margin: 0; padding: 0; box-sizing: border-box; }
  body { font-family: 'Georgia', serif; background-color: #F5F0E8; display: flex; align-items: center; justify-content: center; min-height: 100vh; }
  .join-card { background: #FFFDF8; width: 100%; max-width: 450px; padding: 40px; border-radius: 12px; box-shadow: 0 4px 20px rgba(92,61,46,0.15); border: 1px solid #EDE0CE; }
  .join-card h2 { color: #5C3D2E; text-align: center; margin-bottom: 25px; font-size: 24px; border-bottom: 2px solid #A0522D; padding-bottom: 10px; }
  .input-group { margin-bottom: 15px; }
  .input-group label { display: block; margin-bottom: 6px; color: #5C3D2E; font-size: 14px; font-weight: bold; }
  .input-group input { width: 100%; padding: 10px; border: 1.5px solid #D4B896; border-radius: 6px; background: #FFF8F0; }
  .btn-join { width: 100%; background: #5C3D2E; color: #F5E6C8; padding: 14px; border: none; border-radius: 6px; cursor: pointer; font-size: 16px; font-weight: bold; margin-top: 10px; }
  .btn-join:hover { background: #3D2719; }
</style>
</head>
<body>
  <div class="join-card">
    <h2>📝 LIBRARY JOIN</h2>
	<form action="${pageContext.request.contextPath}/user/insertUser.do" method="post">
      <div class="input-group">
        <label>아이디</label>
        <input type="text" name="memberId" required>
      </div>
      <div class="input-group">
        <label>비밀번호</label>
        <input type="password" name="password" required>
      </div>
      <div class="input-group">
        <label>이름</label>
        <input type="text" name="name" required>
      </div>
      <!-- 권한은 기본적으로 USER로 들어가게 나중에 처리할 예정입니다 -->
      <button type="submit" class="btn-join">가입하기</button>
    </form>
  </div>
</body>
</html>