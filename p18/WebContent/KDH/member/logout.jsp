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
		//세션영역에 접근해서 세션영역에 저장된 모든 값들 제거(단 세션머미로역역은 유지)
		session.invalidate();
		//세션영역에 저장된 값 모두 제거 후 index.jsp(메인페이지)를 재요청해(포워딩) 이동
// 		response.sendRedirect("../index.jsp");		
	%>
	
		<script type="text/javascript">
			window.alert("로그아웃 되었습니다.");
			//자바스크립트의 재요청기술
			location.href="../login.jsp";
		</script>
</body>
</html>