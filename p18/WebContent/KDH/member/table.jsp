<%@page import="database.SignUp"%>
<%@page import="java.util.*"%>
<%@page import="database.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>table</title>
	<link rel="stylesheet" href="../css/table.css">
    <link rel="stylesheet" href="../css/notice.css">
</head>
<body>
<%	
	request.setCharacterEncoding("utf-8");
	MemberDAO memberDAO = new MemberDAO();
	String id = request.getParameter("id");

	int count = memberDAO.getMemberCount(); 
	
	int pageSize = 5;
	
	String pageNum = request.getParameter("pageNum");
	
	if(pageNum == null){
		pageNum = "1";
	}
	
	int currentPage = Integer.parseInt(pageNum);
	
	int startRow = (currentPage -1) * pageSize; 
	
	List<SignUp> list = null; 
	
	if(count > 0){
		list = memberDAO.getMemberList(startRow, pageSize);	
	}
%>
<h2>회원 정보 조회</h2>
<table class="type10">
    <tr>
        <th class="m1" style="font-size:16px;">아이디</th>
        <th class="m2" style="font-size:16px;">비밀번호</th>
        <th class="m3" style="font-size:16px;">이름</th>
        <th class="m4" style="font-size:16px;">주소</th>
        <th class="m5" style="font-size:16px;">삭제</th>
    </tr>
    
    <%
		if(count > 0){//DB에 글이 존재 한다면
			for(int i = 0; i<list.size(); i++){
				SignUp signup = list.get(i);
	%>
    <tr>
        <td style="font-size:16px;"><%=signup.getId2()%></td>
        <td style="font-size:16px;"><%=signup.getPw2()%></td>
        <td style="font-size:16px;"><%=signup.getName2()%></td>
        <td style="font-size:16px;"><%=signup.getAddress2()%></td>
        <td style="font-size:16px;"><a href="Delete2.jsp?id=<%=signup.getId2()%>">삭제</a></td>
    </tr>
    <%
			}
    }
    %> 
    <tr>
    	<td colspan="5"><a href="../index.jsp">메인페이지 가기</a></td>
    </tr>
    </table>
   		 <div id="page_control2">
				<%
					if(count > 0){

						int pageCount = count/pageSize + (count % pageSize == 0 ? 0 : 1);

						int pageBlock = 3;

						int startPage = ((currentPage / pageBlock) - (currentPage%pageBlock==0?1:0)) * pageBlock+1;

						int endPage = startPage + pageBlock -1;

						if(startPage > pageBlock){
				%>			
							<a href="table.jsp?pageNum=<%=startPage-pageBlock%>" style="margin-right:30px;">이전</a>
				<%
						}
						
							if(startPage==1){
								for(int i=startPage; i<=endPage; i++){
				%>					
									<a href="table.jsp?pageNum=<%=i%>" style="letter-spacing: 30px;"><%=i %></a>	
				<%
								}
							}else
								for(int i=startPage-1; i<=endPage-1; i++){
				%>					
								<a href="table.jsp?pageNum=<%=i%>" style="letter-spacing: 30px;"><%=i %></a>
						
						
				<%			
						}
				%>			
						<a href="table.jsp?pageNum=<%=startPage+pageBlock%>">다음</a>
				<%		
						}				
				%>
			</div>
	<form action="search.jsp" method="get" style="margin-top:20px;">
		<input type="submit" value="검색" class="button" id="search" style="margin-right:500px;"> <input
			type="text" name="searchText" class="search"> <select
			name="search" class="search1">
			<option value="id">아이디</option>
			<option value="name">이름</option>
		</select>
	</form>
</body>
</html>