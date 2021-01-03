<%@page import="Member.EmailConfirm"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<script src = "https://code.jquery.com/jquery-3.5.1.js"></script>
<h3 align="center">인증 메일을 보내는 중입니다.<br>
이 창을 닫지 마세요.</h3>
<%
	String email=request.getParameter("email");
	
	// 위에서 작성한 java파일 객체 생성
	EmailConfirm emailconfirm = new EmailConfirm();
	String authNum=emailconfirm.connectEmail(email);
%>
<script>
	alert("메일로 인증번호가 발송되었습니다");
	self.close();
	$(opener.document).find("#i_mememail_valid").attr("value", "<%=authNum%>");
</script>