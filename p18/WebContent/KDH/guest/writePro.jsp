<%@page import="guest.GuestDAO"%>
<%@page import="guest.GuestBean"%>
<%@page import="board.BoardDAO"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>

<%

	String id = (String)session.getAttribute("id");

	request.setCharacterEncoding("utf-8");
	
	String name = request.getParameter("name");
	String passwd = request.getParameter("passwd");
	String subject = request.getParameter("subject");
	String content = request.getParameter("content");
	
	Timestamp timestamp = new Timestamp(System.currentTimeMillis());

	String ip = request.getRemoteAddr();

	GuestBean guestbean = new GuestBean();

	guestbean.setName(name);
	guestbean.setPasswd(passwd);
	guestbean.setSubject(subject);
	guestbean.setContent(content);
	guestbean.setDate(timestamp);
	guestbean.setIp(ip);
	
	GuestDAO gdao = new GuestDAO();
	gdao.insertGuest(guestbean); 
%>
	<script>
		alert("글이 추가되었습니다.");
		location.href='../GuestBook.jsp';
	</script>