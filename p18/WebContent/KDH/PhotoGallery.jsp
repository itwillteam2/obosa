<%@page import="java.text.SimpleDateFormat"%>
<%@page import="gallery.GalleryBean"%>
<%@page import="java.util.List"%>
<%@page import="gallery.GalleryDAO"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Notice</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/gallery.css">
    <script src="javascript/jquery-1.12.3.js"></script>
    <script src="javascript/script.js" defer="defer"></script>
</head>
<body>
<%
	GalleryDAO galleryDAO = new GalleryDAO();

	int count = galleryDAO.getGalleryCount();  
	
	int pageSize = 6;
	
	String pageNum = request.getParameter("pageNum");
	
	if(pageNum == null){
		pageNum = "1";
	}
	
	int currentPage = Integer.parseInt(pageNum);
	
	int startRow = (currentPage -1) * pageSize; 
	
	List<GalleryBean> list = null; 
	
	if(count > 0){
		list = galleryDAO.getGalleryList(startRow, pageSize);
		
	}
	//날짜 포맷 형식을 개발자가 지정할 수 있는 객체 생성
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");
%>
<jsp:include page="inc/top.jsp"/>
	<div class="img">
		<img alt="공지" src="images/notice/gallery.jpg"> 
	</div>
	<div class="content">
		<div class="menu">
			<nav>
				<ul class="submenu2">
					<li><a href="Notice.jsp">공지사항</a></li>
					<li><a href="GuestBook.jsp">방명록</a></li>
					<li><a href="PhotoGallery.jsp">갤러리</a></li>
					<li><a href="Download.jsp">자료실</a></li>
				</ul>
			</nav>
		</div>
		
		<div class="main" style="margin-bottom: 250px;">
			<h2>갤러리</h2>
		
			<table class="table">
				<tr>
					<td>
	<%
		if(count > 0){//DB에 글이 존재 한다면
			for(int i = 0; i<list.size(); i++){
				GalleryBean bean = list.get(i);
	%>
					<div class="gal1" style="border-bottom: 1px dotted #ccc;"><img src="photoUpload/<%=bean.getRealname()%>" 
					onclick="location.href='gallery/content.jsp?num=<%=bean.getNum()%>&pageNum=<%=pageNum%>'">
						<div class="clear"></div>
							<ul>
								<li><%=bean.getSubject() %></li>
								<li id="gray"><%=sdf.format(bean.getDate())%> / <%=bean.getReadcount() %></li>
								<li id="gray"><%=bean.getName() %></li>
							</ul>
						</div>					
	<%			
			}
		}
	%>
					</td>
				</tr>
			</table>
						<div id="page_control">
				<%
					if(count > 0){

						int pageCount = count/pageSize + (count % pageSize == 0 ? 0 : 1);
						
						if(count % 5 > 0) {
							pageCount++;
			            }
						
						int pageBlock = 1;

						int startPage = ((currentPage / pageBlock) - (currentPage%pageBlock==0?1:0)) * pageBlock+1;

						int endPage = startPage + 2;

						if(startPage > pageBlock){
				%>			
							<a href="PhotoGallery.jsp?pageNum=<%=startPage-pageBlock%>">이전</a>
				<%
						}
						
							if(startPage==1){
								for(int i=startPage; i<=endPage; i++){
				%>					
									<a href="PhotoGallery.jsp?pageNum=<%=i%>"><%=i %></a>	
				<%
								}
							}else
								for(int i=startPage-1; i<=endPage-1; i++){
				%>					
								<a href="PhotoGallery.jsp?pageNum=<%=i%>"><%=i %></a>
							
						
				<%			
						}
				%>			
						<a href="PhotoGallery.jsp?pageNum=<%=startPage+pageBlock%>">다음</a>
				<%		
						}				
				%>
			</div>
			<div class="btn">		
				<input type="button" value="글쓰기" class="button" onclick="location.href='gallery/gallerywrite.jsp'">
			</div>
			<div class="clear"></div>
		</div>
	</div>
	
<div class="clear"></div>	
<jsp:include page="inc/bottom.jsp"/>
</body>
</html>