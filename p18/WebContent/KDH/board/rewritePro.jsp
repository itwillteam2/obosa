<%@page import="board.BoardDAO"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
</head>
<body>
	<%
		request.setCharacterEncoding("utf-8");
	%>
		<jsp:useBean id="bBean" class="board.BoardBean"/>
		<jsp:setProperty property="*" name="bBean"/>
	<%
		bBean.setDate(new Timestamp(System.currentTimeMillis()));

		bBean.setIp(request.getRemoteAddr());

		new BoardDAO().reInsertBoard(bBean);  

		response.sendRedirect("../Notice.jsp");		
	%>	
</body>
</html>