<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
  // index.jsp 접근 시 도서 목록으로 리다이렉트
  response.sendRedirect(request.getContextPath() + "/book/bookList.do");
%>
