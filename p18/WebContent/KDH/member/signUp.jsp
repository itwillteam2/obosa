<%@page import="database.SignUp"%>
<%@page import="database.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>SignUp</title>
</head>
<body>
	<%
		request.setCharacterEncoding("utf-8");
	%>	
		<jsp:useBean id="signUp" class="database.SignUp" scope="page"/>

		<jsp:setProperty name="signUp" property="*"/>	
	<%	
		MemberDAO memberDAO = new MemberDAO();
			
		memberDAO.addMember(signUp);
	%>
		<script>
			alert("회원가입을 축하드립니다");
			location.href="../login.jsp";
		</script>
</body>
</html>