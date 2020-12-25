<%@page import="java.text.SimpleDateFormat"%>
<%@page import="download.DownloadBean"%>
<%@page import="java.util.List"%>
<%@page import="download.DownloadDAO"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Notice</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/notice.css">
    <script src="javascript/jquery-1.12.3.js"></script>
    <script src="javascript/script.js" defer="defer"></script>
</head>
<body>
<%
	DownloadDAO downloadDAO = new DownloadDAO();

	int count = downloadDAO.getdownloadCount();  
	
	int pageSize = 5;
	
	String pageNum = request.getParameter("pageNum");
	
	if(pageNum == null){
		pageNum = "1";
	}
	
	int currentPage = Integer.parseInt(pageNum);
	
	int startRow = (currentPage -1) * pageSize; 
	
	List<DownloadBean> list = null; 
	
	if(count > 0){
		list = downloadDAO.getdownloadList(startRow, pageSize);
		
	}
	//날짜 포맷 형식을 개발자가 지정할 수 있는 객체 생성
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");
%>

<jsp:include page="inc/top.jsp"/>
	<div class="img">
		<img alt="공지" src="images/notice/download.jpg"> 
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
		
		<div class="main">
			<h2>자료실</h2>
		
			<table class="table">
				<tr class="th">
					<th class="t1">No.</th>
					<th class="t2">Title</th>
					<th class="t3">Writer</th>
					<th class="t4">Date</th>
					<th class="t5">Read</th>
				</tr>
	<%
		if(count > 0){//DB에 글이 존재 한다면
			for(int i = 0; i<list.size(); i++){
				DownloadBean bean = list.get(i);
	%>
				<tr onclick="location.href='download/content.jsp?num=<%=bean.getNum()%>&pageNum=<%=pageNum%>'">
					<td><%=bean.getNum() %></td>
					<td style="text-align:left; padding-left : 30px;">
					<%=bean.getSubject() %>			
					</td>
					<td><%=bean.getName() %></td>
					<td><%=sdf.format(bean.getDate())%></td>
					<td><%=bean.getReadcount() %></td>
				</tr>
	<%			
			}
		}else{//DB에 글이 존재 하지 않으면
	%>
				<tr>
					<td colspan="5">게시판 글 없음</td>
				</tr>
	<%		
		}
	%>		
	
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
							<a href="Download.jsp?pageNum=<%=startPage-pageBlock%>">이전</a>
				<%
						}
						
							if(startPage==1){
								for(int i=startPage; i<=endPage; i++){
				%>					
									<a href="Download.jsp?pageNum=<%=i%>"><%=i %></a>	
				<%
								}
							}else
								for(int i=startPage-1; i<=endPage-1; i++){
				%>					
								<a href="Download.jsp?pageNum=<%=i%>"><%=i %></a>
							
						
				<%			
						}
				%>			
						<a href="Download.jsp?pageNum=<%=startPage+pageBlock%>">다음</a>
				<%		
						}				
				%>
			</div>
		
			<div class="btn">		
				<input type="button" value="글쓰기" class="button" onclick="location.href='download/downloadWrite.jsp'">
				<form action="download/search.jsp" method="get">
					<input type="submit" value="검색" class="button" id="search">
					<input type="text" name="searchText" class="search"> <select
						name="search" class="search1">
						<option value="num">글번호</option>
						<option value="subject">글제목</option>
						<option value="name">작성자</option>
					</select>
				</form>
			</div>
			<div class="clear"></div>
		</div>
	</div>
	
<div class="clear"></div>	
<jsp:include page="inc/bottom.jsp"/>
</body>
</html>