<%@page import="database.SignUp"%>
<%@page import="database.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<%
		request.setCharacterEncoding("utf-8");
		String id = (String)session.getAttribute("id");
		String pw = request.getParameter("pw2");
		String name = request.getParameter("name2");
		String address = request.getParameter("address2");
		
	%>	
		<jsp:useBean id="signUp" class="database.SignUp" scope="page"/>

		<jsp:setProperty name="signUp" property="*"/>
	<%	
		MemberDAO memberDAO = new MemberDAO();
		memberDAO.ModifyUp(id, pw, name, address);		
	%>
		<script>
			alert("회원수정 완료! 다시 로그인해주세요.");
			opener.location.href='../login.jsp';
			window.close();
		</script>
		
</body>
</html>