<%@page import="board.BoardDAO"%>
<%@page import="board.BoardBean"%>
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

	BoardBean boardbean = new BoardBean();

	boardbean.setName(name);
	boardbean.setPasswd(passwd);
	boardbean.setSubject(subject);
	boardbean.setContent(content);
	boardbean.setDate(timestamp);
	boardbean.setIp(ip);
	
	BoardDAO bdao = new BoardDAO();
	bdao.insertBoard(boardbean); 
%>
	<script>
		alert("글이 추가되었습니다.");
		location.href='../Notice.jsp';
	</script>