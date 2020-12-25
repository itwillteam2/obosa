<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Write</title>
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
	String id = (String)session.getAttribute("id");
%>
<jsp:include page="../inc/top2.jsp"/>
	<div class="img">
		<img alt="공지" src="../images/notice/gallery.jpg"> 
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
			<h2>자료실 글쓰기</h2>
			<form class="form2" action="galleryPro.jsp" method="post" enctype="multipart/form-data">
				<table class="table">
					<tr class="name">
						<td>
							<label for="name">아이디</label>
							<input type="text" name="name" id="name" value="<%=id %>" readonly />					
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
							<input type="text" name="subject" id="subject" /> 
						<td>
					</tr>
					<tr class="file">
						<td>
							<label for="title">파일</label> 
							<input type="file" name="file" id="file" accept=".jpg, .png, .gif"/> 
						<td>
					</tr>
					<tr class="content">
						<td><textarea name="content" id="content"></textarea><td>
					</tr>
				</table>
			
			<div class="btn">		
				<input type="submit" value="글쓰기" class="button" id="writebutton">
				<input type="reset" value="다시작성" class="button" id="button">
				<input type="button" value="목록으로" class="button" id="button" onclick="location.href='../PhotoGallery.jsp'">
			</div>
			</form>
			<div class="clear"></div>
		</div>
	</div>
	
<div class="clear"></div>	
<jsp:include page="../inc/bottom2.jsp"/>
</body>
</html>