<%@page import="java.sql.Timestamp"%>
<%@page import="download.DownloadBean"%>
<%@page import="download.DownloadDAO"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.io.File" %>
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

	ServletContext ctx = getServletContext();
	
	String realPath = ctx.getRealPath("KDH/upload");
	
	int max = 100 * 1024 * 1024;
	
	MultipartRequest multi = new MultipartRequest(request, realPath, max, "utf-8", new DefaultFileRenamePolicy());
	
	String fileName = multi.getFilesystemName("file");
	String realName = multi.getOriginalFileName("file"); 
	
	
	String name = multi.getParameter("name");
	String passwd = multi.getParameter("passwd");
	String subject = multi.getParameter("subject");
	String content = multi.getParameter("content");
	
	Timestamp timestamp = new Timestamp(System.currentTimeMillis());

	String ip = request.getRemoteAddr();
	
	DownloadDAO dao = new DownloadDAO();
	DownloadBean dbean = new DownloadBean();
	
	dbean.setName(name);
	dbean.setPasswd(passwd);
	dbean.setSubject(subject);
	dbean.setContent(content);
	dbean.setFilename(fileName);
	dbean.setRealname(realName);
	dbean.setDate(timestamp);
	dbean.setIp(ip);
	
	dao.insertDownload(dbean); 
%>
	<script>
			window.alert("자료실에 글이 추가되었습니다.");
			location.href="../Download.jsp";
	</script>

</body>
</html>