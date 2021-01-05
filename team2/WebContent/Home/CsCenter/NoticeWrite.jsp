<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
	request.setCharacterEncoding("UTF-8");
%>          

<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />  

<!DOCTYPE html>
<html lang="ko">
<head>

<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />

<meta http-equiv="Content-Script-Type" content="text/javascript" />
<meta http-equiv="Content-Style-Type" content="text/css" />

<title>SSMarket</title>

<link rel="stylesheet" type="text/css" href="${contextPath}/Home/Css/Common/Common.css" />
<link rel="stylesheet" type="text/css" href="${contextPath}/Home/Css/Common/swiper.min.css" />

<script type="text/javascript" src="${contextPath}/Home/Js/Common/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="${contextPath}/Home/Js/Common/Common.js"></script>
<script type="text/javascript" src="${contextPath}/Home/Js/Common/swiper_r.min.js"></script>

<link rel="stylesheet" type="text/css" href="${contextPath}/Home/Css/CsCenter/Cscenter.css" />


<script type="text/javascript" src="${contextPath}/Home/Js/Common/iscroll.js"></script>
<script type="text/javascript" src="${contextPath}/Home/Js/Common/jquery.sticky.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/feather-icons/4.9.0/feather.min.js"></script>
<link rel="stylesheet" href="${contextPath}/Home/Css/Write/bootstrap.min.css">
<link rel="stylesheet" href="${contextPath}/Home/Css/Write/board.css">
<script type="text/javascript">

$(function(){		
	$("#submit").click(function(){
		if($("#title").val()==""){
			alert("제목을 입력해주세요.");
			$("#title").focus();
			return false;				
		};
		if($("#content").val()==""){
			alert("내용을 입력해주세요.");
			$("#content").focus();
			return false;				
		};
	});	
	return false;
});
	
	
	//글목록 보기 버튼 클릭했을떄 호출되는 함수 
	function backToList(obj){//클릭한 버튼이 속해 있는 <form>태그를 매개변수로 전달 받는다.
		
		obj.action="${contextPath}/CsCenter/NoticeList.do";
		obj.submit();//form태그로 서블릿에  모든 글 조회 요청	
	}

</script>
</head>
<body>
<jsp:include page="/Home/inc/hdr_info.jsp"/>

<div>
	<div>
		<h2 style="text-align:center; margin: 30px 0; font-size:30px;">공지사항 등록</h2>
	</div>
</div>
<article class="product" style="width:1200px; margin : 0 auto" >
	<form action="${contextPath}/CsCenter/addNotice.do" method="post">
		<table class="table">
			<colgroup>
				<col style="width:120px" />
				<col />
			</colgroup>
			<tr>
				<th class="align-middle">
					<label for="title" class="m-0">제목</label>
				</th>
				<td>
					<input style="width:700px; margin:0 auto;" class="form-control" type="text" name="title" id="title" />
				</td>
			</tr>
			<tr>
				<th class="align-middle">
					<label for="Content"  class="m-0">내용</label>
				</th>
				<td>			
					<textarea style="margin:0 auto; resize:none; height:400px; width:700px;"class="form-control" name="content" id="content" cols="40" rows="13"></textarea>
				</td>
			</tr>
		</table>
		<div class="text-center my-5">
			<button type="button" class="btn btn-secondary" onclick="history.back()">취소</button>
			<button type="submit" id="submit" class="btn btn-primary">공지사항 등록하기</button>
		</div>
	</form>
</article>
<script src="${contextPath}/Home/Js/Shop/bootstrap.min.js"></script>
<jsp:include page="/Home/inc/footer.jsp"/>
</body>
</html>