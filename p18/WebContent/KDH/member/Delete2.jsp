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
		String id = request.getParameter("id");	
	%>	
		<jsp:useBean id="signUp" class="database.SignUp" scope="page"/>

		<jsp:setProperty name="signUp" property="*"/>
	<%	
		MemberDAO memberDAO = new MemberDAO();
		System.out.println(id);
		memberDAO.Delete(id);		
	%>		
			<script>
				alert("회원탈퇴가 완료되었습니다.");
				location.href='table.jsp';
			</script>	
</body>
</html>