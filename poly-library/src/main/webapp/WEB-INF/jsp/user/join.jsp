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
  .btn-back { position: absolute; left: 24px; top: 50%; transform: translateY(-50%); color: #C4A882; text-decoration: none; font-size: 13px; border: 1px solid #8A6040; border-radius: 5px; padding: 6px 14px; }
  .btn-back:hover { color: #F5E6C8; border-color: #C4A882; }
  .join-container { flex: 1; display: flex; align-items: center; justify-content: center; padding: 30px 20px; }
  .join-card { background: #FFFDF8; width: 100%; max-width: 460px; padding: 40px; border-radius: 12px; box-shadow: 0 4px 20px rgba(92,61,46,0.15); border: 1px solid #EDE0CE; }
  .join-card h2 { color: #5C3D2E; text-align: center; margin-bottom: 28px; font-size: 22px; border-bottom: 2px solid #A0522D; padding-bottom: 10px; }
  .input-group { margin-bottom: 18px; }
  .input-group label { display: block; margin-bottom: 6px; color: #5C3D2E; font-size: 14px; font-weight: bold; }
  .input-row { display: flex; gap: 8px; }
  .input-row input { flex: 1; }
  .input-group input { width: 100%; padding: 11px 14px; border: 1.5px solid #D4B896; border-radius: 6px; background: #FFF8F0; font-family: inherit; font-size: 14px; }
  .input-group input:focus { outline: none; border-color: #A0522D; }
  .input-group input.ok  { border-color: #2E7D32; background: #F0FFF0; }
  .input-group input.err { border-color: #C62828; background: #FFF0F0; }
  .btn-check { background: #5C3D2E; color: #FFF8F0; border: none; border-radius: 6px; padding: 11px 16px; cursor: pointer; font-size: 13px; white-space: nowrap; font-family: inherit; flex-shrink: 0; }
  .btn-check:hover { background: #3D2719; }
  .btn-check:disabled { background: #A8BFBA; cursor: not-allowed; }
  .check-msg { font-size: 12px; margin-top: 5px; min-height: 16px; }
  .check-msg.ok  { color: #2E7D32; }
  .check-msg.err { color: #C62828; }
  .input-hint { font-size: 12px; color: #A08060; margin-top: 4px; }
  .btn-join { width: 100%; background: #5C3D2E; color: #F5E6C8; padding: 14px; border: none; border-radius: 6px; cursor: pointer; font-size: 16px; font-weight: bold; margin-top: 8px; font-family: inherit; }
  .btn-join:hover { background: #3D2719; }
  .btn-join:disabled { background: #A8BFBA; cursor: not-allowed; }
  .divider { border: none; border-top: 1px solid #EDE0CE; margin: 16px 0; }
  .join-footer { text-align: center; font-size: 14px; color: #A08060; margin-top: 12px; }
  .join-footer a { color: #A0522D; text-decoration: none; font-weight: bold; }
  .footer { text-align: center; padding: 24px; color: #A08060; font-size: 13px; border-top: 1px solid #DDD0BC; }
</style>
</head>
<body>

<div class="header">
  <a href="${pageContext.request.contextPath}/book/bookList.do" class="btn-back">← 메인으로</a>
  <h1><a href="${pageContext.request.contextPath}/book/bookList.do">📚 폴리 인공지능 도서관</a></h1>
</div>

<div class="join-container">
  <div class="join-card">
    <h2>📝 회원가입</h2>
    <form id="joinForm" action="${pageContext.request.contextPath}/user/insertUser.do" method="post" onsubmit="return validateForm()">
      <input type="hidden" name="returnUrl" value="${returnUrl}">

      <!-- 아이디 + 중복체크 -->
      <div class="input-group">
        <label>아이디 <span style="color:#C62828;">*</span></label>
        <div class="input-row">
          <input type="text" id="memberId" name="memberId" placeholder="아이디를 입력하세요" required oninput="resetIdCheck()">
          <button type="button" class="btn-check" id="btnCheckId" onclick="checkId()">중복 확인</button>
        </div>
        <div class="check-msg" id="idMsg"></div>
      </div>

      <!-- 비밀번호 -->
      <div class="input-group">
        <label>비밀번호 <span style="color:#C62828;">*</span></label>
        <input type="password" id="password" name="password" placeholder="비밀번호를 입력하세요" required oninput="checkPwMatch()">
      </div>

      <!-- 비밀번호 확인 -->
      <div class="input-group">
        <label>비밀번호 확인 <span style="color:#C62828;">*</span></label>
        <input type="password" id="passwordConfirm" placeholder="비밀번호를 다시 입력하세요" required oninput="checkPwMatch()">
        <div class="check-msg" id="pwMsg"></div>
      </div>

      <!-- 이름 -->
      <div class="input-group">
        <label>이름 <span style="color:#C62828;">*</span></label>
        <input type="text" name="name" placeholder="이름을 입력하세요" required>
      </div>

      <!-- 전화번호 -->
      <div class="input-group">
        <label>전화번호</label>
        <input type="text" name="phone" placeholder="예) 010-1234-5678">
        <p class="input-hint">※ 도서 대출 시 회원 검색에 사용됩니다.</p>
      </div>

      <button type="submit" class="btn-join" id="btnJoin">가입하기</button>
    </form>

    <hr class="divider">
    <div class="join-footer">
      이미 회원이신가요? <a href="${pageContext.request.contextPath}/user/loginView.do?returnUrl=${returnUrl}">로그인 하기</a>
    </div>
    <div class="join-footer" style="margin-top:8px;">
      <a href="${pageContext.request.contextPath}/book/bookList.do">← 메인 화면으로 돌아가기</a>
    </div>
  </div>
</div>

<div class="footer">© 2026 폴리 인공지능 도서관 · Poly AI Library</div>

<script>
var CP = '${pageContext.request.contextPath}';
var idChecked = false;   // 중복체크 통과 여부
var pwMatched = false;   // 비밀번호 일치 여부

/* ── 아이디 중복 체크 ── */
function checkId() {
  var id = document.getElementById('memberId').value.trim();
  var msg = document.getElementById('idMsg');
  var inp = document.getElementById('memberId');
  if (!id) { msg.textContent = '아이디를 입력해주세요.'; msg.className = 'check-msg err'; return; }

  var xhr = new XMLHttpRequest();
  xhr.open('GET', CP + '/user/checkId.do?memberId=' + encodeURIComponent(id), true);
  xhr.onload = function() {
    if (xhr.responseText === 'AVAILABLE') {
      msg.textContent = '✔ 사용 가능한 아이디입니다.';
      msg.className = 'check-msg ok';
      inp.classList.add('ok'); inp.classList.remove('err');
      idChecked = true;
    } else {
      msg.textContent = '✗ 이미 사용 중인 아이디입니다.';
      msg.className = 'check-msg err';
      inp.classList.add('err'); inp.classList.remove('ok');
      idChecked = false;
    }
  };
  xhr.send();
}

/* 아이디 수정 시 체크 초기화 */
function resetIdCheck() {
  idChecked = false;
  var msg = document.getElementById('idMsg');
  var inp = document.getElementById('memberId');
  msg.textContent = ''; msg.className = 'check-msg';
  inp.classList.remove('ok', 'err');
}

/* ── 비밀번호 일치 확인 ── */
function checkPwMatch() {
  var pw  = document.getElementById('password').value;
  var pw2 = document.getElementById('passwordConfirm').value;
  var msg = document.getElementById('pwMsg');
  var inp = document.getElementById('passwordConfirm');
  if (!pw2) { msg.textContent = ''; pwMatched = false; return; }
  if (pw === pw2) {
    msg.textContent = '✔ 비밀번호가 일치합니다.';
    msg.className = 'check-msg ok';
    inp.classList.add('ok'); inp.classList.remove('err');
    pwMatched = true;
  } else {
    msg.textContent = '✗ 비밀번호가 일치하지 않습니다.';
    msg.className = 'check-msg err';
    inp.classList.add('err'); inp.classList.remove('ok');
    pwMatched = false;
  }
}

/* ── 최종 유효성 검사 ── */
function validateForm() {
  if (!idChecked) {
    alert('아이디 중복 확인을 해주세요.');
    return false;
  }
  if (!pwMatched) {
    alert('비밀번호가 일치하지 않습니다.');
    return false;
  }
  return true;
}
</script>
</body>
</html>
