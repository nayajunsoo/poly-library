<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>도서관 프로젝트</title>
<style>
    body { font-family: 'Malgun Gothic', sans-serif; line-height: 1.6; padding: 20px; }
    h1 { color: #2c3e50; border-bottom: 2px solid #3498db; padding-bottom: 10px; }
    .success-msg { color: #27ae60; font-weight: bold; font-size: 1.2em; }
    .status-list { background-color: #f9f9f9; border-left: 5px solid #3498db; padding: 15px; list-style: none; }
    .status-list li::before { content: "✅ "; }
</style>
</head>
<body>

    <h1>🚀 poly-library 프로젝트 시작</h1>
    
    <p class="success-msg">현재 서버와 DB 환경 구축 완료되었습니다.</p>
    
    <ul class="status-list">
        <li><strong>MySQL 연결:</strong> library_db 접속 준비 완료</li>
        <li><strong>서버 상태:</strong> Tomcat v9.0 정상 작동 중</li>
        <li><strong>데이터 모델:</strong> BookVO, MemberVO 등 4개 부품 장착 완료</li>
        <li><strong>인코딩 설정:</strong> UTF-8 한글 처리 완료</li>
    </ul>

    <hr>
    <p>이 화면이 깨짐 확인 <strong>Git Bash</strong>에 작업물 커밋</p>
    <p>개발시작</p>

</body>
</html>