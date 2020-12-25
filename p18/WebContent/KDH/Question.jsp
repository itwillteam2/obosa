<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Question</title>
    <link rel="stylesheet" href="css/notice.css">
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/write.css">
    <script src="javascript/jquery-1.12.3.js"></script>
    <script src="javascript/script.js" defer="defer"></script>
    <script src="javascript/write.js" defer="defer"></script>
</head>
<body>
<jsp:include page="inc/top.jsp"/>
	<div class="img">
		<img alt="메일보내기" src="images/notice/mail.jpg"> 
	</div>
	<div class="content">
		<div class="menu">
			<nav>
				<ul class="submenu2">
					<li><a href="Question.jsp">메일보내기</a></li>
					<li><a href="Question2.jsp">문자보내기</a></li>
				</ul>
			</nav>
		</div>

	
		<div class="main">
			<h2>메일 보내기</h2>
			<form class="form2" action="mail/sendmail.jsp" method="post">
				<table class="table">
					<tr class="name">
						<td>
							<label for="name">보내는 사람</label>
							<input type="email" name="from" id="name" value="송정동사무소" readonly/>					
						</td>
					</tr>
					<tr class="passwd">
						<td>
							<label for="passwd">받는 사람</label>
							<input type="email" name="to" id="send" /> 
						<td>
					</tr>
					<tr class="subject">
						<td>
							<label for="title">제목</label> 
							<input type="text" name="subject" id="subject" /> 
						<td>
					</tr>
					<tr class="content">
						<td><textarea name="content" id="content"></textarea><td>
					</tr>
				</table>
			
			<div class="btn">		
				<input type="submit" value="보내기" class="button" id="writebutton">
				<input type="reset" value="다시작성" class="button" id="button">
			</div>
			</form>
			<div class="clear"></div>
		</div>
	</div>
	<div class="clear"></div>
<jsp:include page="inc/bottom.jsp"/>
</body>
</html>