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
	%>	
		<jsp:useBean id="signUp" class="database.SignUp" scope="page"/>

		<jsp:setProperty name="signUp" property="*"/>
	<%	
		MemberDAO memberDAO = new MemberDAO();
		memberDAO.Delete(id);		
	%>		
			<script>
				alert("ȸ��Ż�� �Ϸ�Ǿ����ϴ�.");
				opener.location.href='../login.jsp';
				window.close();	
			</script>	
</body>
</html>