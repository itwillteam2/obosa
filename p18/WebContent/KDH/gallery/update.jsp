<%@page import="gallery.*"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>update</title>
    <link rel="stylesheet" href="../css/style.css">
    <link rel="stylesheet" href="../css/notice.css">
    <link rel="stylesheet" href="../css/write.css">
    <script src="../javascript/jquery-1.12.3.js"></script>
    <script src="../javascript/script.js" defer="defer"></script>
    <script src="../javascript/write.js" defer="defer"></script>
</head>
<body>
<%
	/*글 하나의 정보를 보여주는 페이지*/
	
	//한글 처리
	request.setCharacterEncoding("utf-8");
	
	int num = Integer.parseInt(request.getParameter("num"));

	String pageNum = request.getParameter("pageNum");

	GalleryDAO dao = new GalleryDAO();

	GalleryBean dBean = dao.getGallery(num);
	
	int DBnum = dBean.getNum();
	int DBReadcount = dBean.getReadcount();
	String DBName = dBean.getName();
	String fileName = dBean.getFilename();
	Timestamp DBDate = dBean.getDate();
	String DBSubject = dBean.getSubject();
	String DBContent = "";

	if(dBean.getContent() != null){
		DBContent = dBean.getContent().replace("<br>", "\r\n");
	}
	int DBRe_ref = dBean.getRe_ref();
	int DBRe_lev = dBean.getRe_lev();
	int DBRe_seq = dBean.getRe_seq();
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");	
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
			<h2>자료실 글수정</h2>
			<form class="form2" action="updatePro.jsp" method="post" enctype="multipart/form-data">
			
				<input type="hidden" name="num" value="<%=num%>">
				<input type="hidden" name="pageNum" value="<%=pageNum%>">
				
				<table class="table">
					<tr class="name">
						<td>
							<label for="name">아이디</label>
							<input type="text" name="name" id="name" value="<%=DBName %>" readonly />					
						</td>
					</tr>
					<tr class="passwd">
						<td>
							<label for="passwd">비밀번호</label>
							<input type="password" name="passwd" id="passwd" /> 
						<td>
					</tr>
					<tr class="subject">
						<td>
							<label for="title">제목</label> 
							<input type="text" name="subject" id="subject" value="<%=DBSubject%>" /> 
						<td>
					</tr>
					<tr class="name">
						<td>
							<label for="name">파일</label>
							<input type="file" name="file" id="file">
							<input type="hidden" name="dfileName" id="dfileName" value="<%=fileName%>">					
						</td>
					</tr>
							
					<tr class="content">
						<td><textarea name="content" id="content"><%=DBContent %></textarea><td>
					</tr>	
				</table>
			
			<div class="btn">		
				<input type="submit" value="글수정" class="button" id="writebutton">
				<input type="reset" value="다시작성" class="button" id="button">
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