<%@page import="mail.MailSend"%>
<%@page import="javax.mail.PasswordAuthentication"%>
<%@page import="javax.mail.Transport"%>
<%@page import="javax.mail.Message"%>
<%@page import="javax.mail.Address"%>
<%@page import="javax.mail.internet.InternetAddress"%>
<%@page import="javax.mail.internet.MimeMessage"%>
<%@page import="javax.mail.Session"%>
<%@page import="javax.mail.Authenticator"%>
<%@page import="java.util.Properties"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%	
	request.setCharacterEncoding("utf-8");

	String to2 = request.getParameter("to");
	String from = request.getParameter("from");
	String subject = request.getParameter("subject");
	String content = request.getParameter("content");
	MailSend ms = new MailSend(to2, from, subject, content); 
%>
<script>
	window.alert("메일이 전송되었습니다.");
	location.href="../Question.jsp";
</script>