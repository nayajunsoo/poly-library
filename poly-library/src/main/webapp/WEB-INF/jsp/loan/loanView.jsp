<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>도서 대출 - 폴리 인공지능 도서관</title>
<%-- 이 JSP는 팝업 창용 예비 파일입니다. 실제 대출 UI는 bookList.jsp의 인라인 팝업으로 동작합니다. --%>
</head>
<body>
<c:set var="cp" value="${pageContext.request.contextPath}"/>
<script>
  // 팝업으로 열렸다면 부모 창의 openLoanPopup() 호출 후 닫기 (대비용)
  if(window.opener) {
    window.opener.openLoanPopup();
    window.close();
  } else {
    location.href = '${cp}/book/bookList.do';
  }
</script>
</body>
</html>
