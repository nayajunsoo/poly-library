<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://fonts.googleapis.com/css2?family=Noto+Serif+KR:wght@400;700&display=swap" rel="stylesheet">
<title>접근 권한 없음 - 폴리 인공지능 도서관</title>
<style>
*{margin:0;padding:0;box-sizing:border-box;}
body{font-family:'Noto Serif KR',serif;background:#F5F0E8;display:flex;flex-direction:column;align-items:center;justify-content:center;min-height:100vh;}
.box{background:#FFFDF8;border-radius:16px;box-shadow:0 4px 24px rgba(92,61,46,0.15);padding:60px 50px;text-align:center;max-width:460px;width:90%;}
.icon{font-size:52px;margin-bottom:18px;}
.title{font-size:22px;color:#5C3D2E;font-weight:bold;margin-bottom:10px;}
.desc{font-size:13px;color:#A08060;line-height:1.7;margin-bottom:28px;}
.btn-home{display:inline-block;background:#5C3D2E;color:#FFF8F0;padding:11px 24px;border-radius:8px;text-decoration:none;font-size:13px;font-weight:bold;margin-right:8px;}
.btn-back{display:inline-block;background:#E8D5B0;color:#5C3D2E;padding:11px 24px;border-radius:8px;text-decoration:none;font-size:13px;font-weight:bold;}
</style>
</head>
<body>
<div class="box">
  <div class="icon">🔒</div>
  <div class="title">접근 권한이 없습니다</div>
  <div class="desc">이 페이지는 <strong>관리자(ADMIN)</strong>만 접근할 수 있습니다.</div>
  <a href="${pageContext.request.contextPath}/book/bookList.do" class="btn-home">📚 메인으로</a>
  <a href="javascript:history.back()" class="btn-back">← 이전으로</a>
</div>
</body>
</html>
