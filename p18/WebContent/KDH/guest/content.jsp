<%@page import="guest.GuestBean"%>
<%@page import="guest.GuestDAO"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Content</title>
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

	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	
	GuestDAO dao = new GuestDAO();
	
	dao.updateReadCount(num); 
	
	GuestBean guestBean = dao.getGuest(num);
	
	int DBnum = guestBean.getNum();
	int DBReadcount = guestBean.getReadcount();
	String DBName = guestBean.getName();
	Timestamp DBDate = guestBean.getDate();
	String DBSubject = guestBean.getSubject();
	String DBContent = "";
	
	if(guestBean.getContent() != null){
		DBContent = guestBean.getContent().replace("<br>", "\r\n");
	}

	int DBRe_ref = guestBean.getRe_ref();
	int DBRe_lev = guestBean.getRe_lev();
	int DBRe_seq = guestBean.getRe_seq();
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");
	
%>
<jsp:include page="../inc/top2.jsp"/>
	<div class="img">
		<img alt="공지" src="../images/notice/guest.jpg"> 
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
			<h2>방명록</h2>
			<form class="form2" method="post">
				<table class="table">
					<tr class="name">
						<td>
							<label for="name">글번호</label>
							<input type="text" name="name" id="name" value="<%=DBnum %>" readonly />					
						</td>
					</tr>
					<tr class="name">
						<td>
							<label for="name">아이디</label>
							<input type="text" name="name" id="name" value="<%=DBName %>" readonly />					
						</td>
					</tr>
					<tr class="name">
						<td>
							<label for="name">작성일</label>
							<input type="text" name="name" id="name" value="<%=sdf.format(DBDate) %>" readonly />					
						</td>
					</tr>
					<tr class="name">
						<td>
							<label for="name">글제목</label>
							<input type="text" name="name" id="name" value="<%=DBSubject %>" readonly />				
						</td>
					</tr>
					<tr class="content">
						<td><textarea name="content" id="content"><%=DBContent %></textarea><td>
					</tr>
				</table>

				<div class="btn">
				<%
					if(DBName.equals(id)){
				%>		
						<input type="button" value="글삭제" class="button" id="button" onclick="location.href='delete.jsp?num=<%=DBnum %>&pageNum=<%=pageNum %>'">
						<input type="button" value="글수정" class="button" id="writebutton" onclick="location.href='update.jsp?num=<%=DBnum %>&pageNum=<%=pageNum %>'">		
				<%
					}
				%>	
				
									
					<input type="button" value="답글쓰기" class="button" id="button" onclick="location.href='reWrite.jsp?num=<%=DBnum %>&re_ref=<%=DBRe_ref %>&re_lev=<%=DBRe_lev %>&re_seq=<%=DBRe_seq %>'">
					<input type="button" value="목록으로" class="button" id="button" onclick="location.href='../GuestBook.jsp?pageNum=<%=pageNum%>'">
				</div>
			</form>
			<div class="clear"></div>
		</div>
	</div>
<div class="clear"></div>	


<jsp:include page="../inc/bottom2.jsp"/>
</body>
</html>