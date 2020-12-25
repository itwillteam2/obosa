<%@page import="gallery.GalleryBean"%>
<%@page import="gallery.GalleryDAO"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Delete</title>
    <link rel="stylesheet" href="../css/style.css">
    <link rel="stylesheet" href="../css/notice.css">
    <link rel="stylesheet" href="../css/write.css">
    <script src="../javascript/jquery-1.12.3.js"></script>
    <script src="../javascript/script.js" defer="defer"></script>
    <script src="../javascript/write.js" defer="defer"></script>
</head>
<body>

<%
	request.setCharacterEncoding("utf-8");

	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	
	GalleryDAO dao = new GalleryDAO();
	GalleryBean dBean = dao.getGallery(num);
	String fileName = dBean.getFilename();

%>

<jsp:include page="../inc/top2.jsp"/>
	<div class="img">
		<img alt="공지" src="../images/notice/download.jpg"> 
	</div>
	<div class="content">
		<div class="menu">
			<nav>
				<ul class="submenu2">
					<li><a href="../Notice.jsp">공지사항</a></li>
					<li><a href="../GuestBook.jsp">방명록</a></li>
					<li><a href="../PhotoGallery.jsp">갤러리</a></li>
					<li><a href="../Download.jsp">자료실</a></li>
				</ul>
			</nav>
		</div>
		
		<div class="main">
			<form class="form2" action="DeletePro.jsp?pageNum=<%=pageNum %>" method="post">
			
				<input type="hidden" name ="num" value="<%=num%>">
				
				<table class="table">
					<tr class="passwd">
						<td>
							<label for="passwd">비밀번호</label>
							<input type="password" name="passwd" id="passwd" /> 
						<td>
					</tr>
				</table>
			
			<div class="btn">		
				<input type="submit" value="글삭제" class="button" id="writebutton">
				<input type="button" value="목록으로" class="button" id="button" onclick="location.href='../PhotoGallery.jsp?pageNum=<%=pageNum%>'">
			</div>
			</form>
			<div class="clear"></div>
		</div>
	</div>
	<div class="clear"></div>		
	<jsp:include page="../inc/bottom2.jsp"/>	
</body>
</html>