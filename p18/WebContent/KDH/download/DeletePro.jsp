<%@page import="java.io.File"%>
<%@page import="download.*"%>
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
	
		int num = Integer.parseInt(request.getParameter("num"));
		String pageNum = request.getParameter("pageNum");
		String passwd = request.getParameter("passwd");
		
		DownloadDAO bdao = new DownloadDAO();
	
		DownloadBean dbean = new DownloadBean();
		
		DownloadBean dBean = bdao.getDownload(num);
		String fileName = dBean.getFilename();
		
		ServletContext ctx = getServletContext();
		
		String realPath = ctx.getRealPath("KDH/upload/");
					
		File file = new File(realPath + fileName);
		
		int check = bdao.deleteDownload(num, passwd);
				
		if(check == 1){
			
			if(file.exists()){		
				file.delete();
			}
	%>
		<script>
			alert("글이 삭제되었습니다.");
			location.href="../Download.jsp?pageNum=<%=pageNum%>";
		</script>	
	<%		
		}else{
	%>
		<script>
			alert("비밀번호가 틀립니다.");
			history.back();
		</script>	
	<%		
		}
	%>
</body>
</html>