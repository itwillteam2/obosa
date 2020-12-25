<%@page import="java.sql.Timestamp"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.io.File" %>
<%@page import="gallery.*"%>
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
		
		String realPath = ctx.getRealPath("KDH/photoUpload/");
		
		int max = 100 * 1024 * 1024;
		
		MultipartRequest multi = new MultipartRequest(request, realPath, max, "utf-8", new DefaultFileRenamePolicy());
		


		
		String fileName = multi.getFilesystemName("file");
		String realName = multi.getOriginalFileName("file"); 
		String dfileName = multi.getParameter("dfileName");
		String name = multi.getParameter("name");
		String passwd = multi.getParameter("passwd");
		String subject = multi.getParameter("subject");
		String content = multi.getParameter("content");
		
		System.out.println(dfileName);

		int num = Integer.parseInt(multi.getParameter("num"));
		String pageNum = multi.getParameter("pageNum");
		
		Timestamp timestamp = new Timestamp(System.currentTimeMillis());
	
		String ip = request.getRemoteAddr();
		
		GalleryDAO dao = new GalleryDAO();
		GalleryBean dbean = new GalleryBean();
		
		dbean.setNum(num);
		dbean.setName(name);
		dbean.setPasswd(passwd);
		dbean.setSubject(subject);
		dbean.setContent(content);
		dbean.setFilename(fileName);
		dbean.setRealname(realName);
		dbean.setDate(timestamp);
		dbean.setIp(ip);
					
		File file = new File(realPath + dfileName);
		System.out.println(realPath + dfileName);

		int check = dao.updateGallery(dbean); 

		if(check==1){
			if(file.exists()){		
				file.delete();
			}
	%>
		<script type="text/javascript">		
			window.alert("수정 성공");
			location.href='../PhotoGallery.jsp?pageNum=<%=pageNum%>';
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