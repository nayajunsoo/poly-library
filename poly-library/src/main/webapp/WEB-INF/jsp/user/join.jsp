<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 - 폴리 인공지능 도서관</title>
<style>
  * { margin: 0; padding: 0; box-sizing: border-box; }
  body { font-family: 'Georgia', serif; background-color: #F5F0E8; display: flex; flex-direction: column; min-height: 100vh; }
  .header { background-color: #5C3D2E; padding: 20px; box-shadow: 0 2px 8px rgba(0,0,0,0.3); text-align: center; position: relative; }
  .header h1 { color: #F5E6C8; font-size: 22px; letter-spacing: 1px; }
  .header h1 a { color: inherit; text-decoration: none; }
  .btn-home { position: absolute; left: 24px; top: 50%; transform: translateY(-50%); color: #C4A882; text-decoration: none; font-size: 13px; border: 1px solid #8A6040; border-radius: 5px; padding: 6px 14px; }
  .btn-home:hover { color: #F5E6C8; border-color: #C4A882; }
  .join-container { flex: 1; display: flex; align-items: center; justify-content: center; padding: 30px 20px; }
  .join-card { background: #FFFDF8; width: 100%; max-width: 450px; padding: 40px; border-radius: 12px; box-shadow: 0 4px 20px rgba(92,61,46,0.15); border: 1px solid #EDE0CE; }
  .join-card h2 { color: #5C3D2E; text-align: center; margin-bottom: 25px; font-size: 22px; border-bottom: 2px solid #A0522D; padding-bottom: 10px; }
  .input-group { margin-bottom: 16px; }
  .input-group label { display: block; margin-bottom: 6px; color: #5C3D2E; font-size: 14px; font-weight: bold; }
  .input-group input { width: 100%; padding: 11px 14px; border: 1.5px solid #D4B896; border-radius: 6px; background: #FFF8F0; font-family: inherit; font-size: 14px; }
  .input-group input:focus { outline: none; border-color: #A0522D; }
  .input-hint { font-size: 12px; color: #A08060; margin-top: 4px; }
  .btn-join { width: 100%; background: #5C3D2E; color: #F5E6C8; padding: 14px; border: none; border-radius: 6px; cursor: pointer; font-size: 16px; font-weight: bold; margin-top: 10px; font-family: inherit; }
  .btn-join:hover { background: #3D2719; }
  .divider { border: none; border-top: 1px solid #EDE0CE; margin: 16px 0; }
  .join-footer { text-align: center; font-size: 14px; color: #A08060; margin-top: 16px; }
  .join-footer a { color: #A0522D; text-decoration: none; font-weight: bold; }
  .footer { text-align: center; padding: 24px; color: #A08060; font-size: 13px; border-top: 1px solid #DDD0BC; }
</style>
</head>
<body>

<div class="header">
  <a href="${pageContext.request.contextPath}/book/bookList.do" class="btn-home">← 메인으로</a>
  <h1><a href="${pageContext.request.contextPath}/book/bookList.do">📚 폴리 인공지능 도서관</a></h1>
</div>

<div class="join-container">
  <div class="join-card">
    <h2>📝 회원가입</h2>
    <form action="${pageContext.request.contextPath}/user/insertUser.do" method="post">
      <div class="input-group">
        <label>아이디</label>
        <input type="text" name="memberId" placeholder="아이디를 입력하세요" required>
      </div>
      <div class="input-group">
        <label>비밀번호</label>
        <input type="password" name="password" placeholder="비밀번호를 입력하세요" required>
      </div>
      <div class="input-group">
        <label>이름</label>
        <input type="text" name="name" placeholder="이름을 입력하세요" required>
      </div>
      <div class="input-group">
        <label>전화번호</label>
        <input type="text" name="phone" placeholder="예) 010-1234-4542">
        <p class="input-hint">※ 도서 대출 시 회원 검색에 사용됩니다.</p>
      </div>

      <button type="submit" class="btn-join">가입하기</button>
    </form>

    <hr class="divider">

    <div class="join-footer">
      이미 회원이신가요? <a href="${pageContext.request.contextPath}/user/loginView.do">로그인 하기</a>
    </div>
    <div class="join-footer" style="margin-top:8px;">
      <a href="${pageContext.request.contextPath}/book/bookList.do">← 메인 화면으로 돌아가기</a>
    </div>
  </div>
</div>

<div class="footer">© 2026 폴리 인공지능 도서관 · Poly AI Library</div>
</body>
</html>
