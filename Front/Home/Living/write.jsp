<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Write</title>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
<link rel="stylesheet" href="../css/write/notice.css">
<link rel="stylesheet" href="../Css/write/write.css">
<link rel="stylesheet" type="text/css" href="../Css/Common/Common.css" />
<link rel="stylesheet" type="text/css" href="../Css/Common/swiper.min.css" />
<script type="text/javascript" src="../Js/Common/jquery-1.11.3.min.js"></script>

<script type="text/javascript" src="../Js/Common/Common.js"></script>

<script type="text/javascript" src="../Js/Common/swiper_r.min.js"></script>

<link rel="stylesheet" type="text/css" href="../Css/Shop/ItemDetail.css">
<link rel="stylesheet" type="text/css" href="../Css/Shop/ScrollBar.css"/>
	
<script type="text/javascript" src="../Js/Common/iscroll.js"></script>
<script type="text/javascript" src="../Js/Common/jquery.sticky.js"></script>
</head>
<body>
<jsp:include page="../inc/header.jsp"/>
<div id="CommonHeaderArea"></div>
<div id="CommonHeader_M"></div>
<%
	request.setCharacterEncoding("utf-8");
	String id = (String)session.getAttribute("id");
%>
	<div class="content">		
		<div class="main">
			<h2>상품 등록하기</h2>
			<form class="form2" action="writePro.jsp" method="post" >
				<table class="table" style="margin : 0 auto">
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
					<tr class="image">
						<td>
							<label for="title">이미지</label> 
							<input type="file" name="subject" id="image" /> 
						<td>
					</tr>
					<tr class="content">
						<td><textarea name="content" id="content"></textarea><td>
					</tr>
				</table>
			
			<div class="btn">		
				<input type="submit" value="글쓰기" class="button" id="writebutton">
				<input type="reset" value="다시작성" class="button" id="button">
				<input type="button" value="목록으로" class="button" id="button" onclick="location.href='../Notice.jsp'">
			</div>
			</form>
			<div class="clear"></div>
		</div>
	</div>
			<div class="clear"></div>
<jsp:include page="../inc/footer.jsp"/>
</body>
</html>