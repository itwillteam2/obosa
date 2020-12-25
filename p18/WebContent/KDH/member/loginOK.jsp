<%@page import="database.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>loginOK</title>
</head>
<body>
	<%
		request.setCharacterEncoding("utf-8");
		
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		
		MemberDAO memberdao = new MemberDAO();
		
		int check = memberdao.userCheck(id, pw);
		
		if(check == 1){
			session.setAttribute("id", id);		

			if(id.equals("admin")){
				response.sendRedirect("loginadmin.html");
			}else{
				response.sendRedirect("../index.jsp");
			}
		}else if(check == 0){
%>		
		<script>
			alert("비밀번호가 틀립니다.")
			history.back();
		</script>
<%	
		}else{
%>
		<script>
			alert("아이디가 없습니다.")
			history.go(-1);
		</script>
<%		
		}
%>
		
		
		

	
</body>
</html>