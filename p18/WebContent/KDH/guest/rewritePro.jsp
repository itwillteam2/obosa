<%@page import="guest.GuestDAO"%>
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
		<jsp:useBean id="gBean" class="guest.GuestBean"/>
		<jsp:setProperty property="*" name="gBean"/>
	<%
		gBean.setDate(new Timestamp(System.currentTimeMillis()));

		gBean.setIp(request.getRemoteAddr());

		new GuestDAO().reInsertGuest(gBean);  

		response.sendRedirect("../GuestBook.jsp");		
	%>	
</body>
</html>