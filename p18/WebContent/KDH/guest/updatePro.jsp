<%@page import="guest.GuestDAO"%>
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
		<jsp:useBean id="bBean" class="guest.GuestBean" scope="page"/>
		
		<jsp:setProperty property="*" name="bBean"/>
	<%	
		GuestDAO gdao = new GuestDAO();
		int check = gdao.updateGuest(bBean); 
		
		int num = Integer.parseInt(request.getParameter("num"));
		String pageNum = request.getParameter("pageNum");

		if(check==1){
	%>
		<script type="text/javascript">		
			window.alert("수정 성공");
			location.href='../GuestBook.jsp?pageNum=<%=pageNum%>';
		</script>
	<%
		}else{
	%>
		<script type="text/javascript">
			window.alert("비밀번호가 틀렸습니다.");
			history.go(-1);
		</script>
	<%		
		}
	%>
</body>
</html>