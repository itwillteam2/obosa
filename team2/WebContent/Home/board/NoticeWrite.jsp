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

<script type="text/javascript">

	$(document).ready(function(){

	});
	
	$(document).on("click", ".imageFileName", function(){
		var targetNum = $(this).attr("data");
		
		$("[name=txFile"+targetNum+"]").val("");
		$("[name=file"+targetNum+"]").val("");
		$(this).css("display","none");
	});

	function fnItem1FileUpload()
	{
		$("[name=txFile1]").val( $("[name=imageFileName]").val().replace(/^.*\\/, "") );
		$(".file_x[data=1]").css("display", "block");
	}
	
	function InquiryInput(){
		var f = document.Inquiryfrm;
		
		
		if(!f.title.value){
			alert("제목을 입력해주세요.");
			f.txSubject.focus();
			return false;
		}	

		
		if(f.title.value.length < 2){
			alert("제목을 2자 이상 입력하세요.");
			f.txSubject.focus() ;
			return;	
		}
		
		
		if(!f.content.value){
			alert("내용을 입력해주세요.");
			f.txContent.focus();
			return false;
		}	


		if(f.content.value.length > 32767) {
			alert("문의내용은 32767바이트(한글 약 15000자)를 넘길 수 없습니다.\t");
			return false;
		}

		
		f.method = "post";
		f.encoding = "multipart/form-data"
		f.action = "${contextPath}/board/addArticle.do";
		f.submit();
	}
	
	
	//글목록 보기 버튼 클릭했을떄 호출되는 함수 
	function backToList(obj){//클릭한 버튼이 속해 있는 <form>태그를 매개변수로 전달 받는다.
		
		obj.action="${contextPath}/board/listArticles.do";
		obj.submit();//form태그로 서블릿에  모든 글 조회 요청	
	}

</script>
</head>
<body>
	<jsp:include page="../inc/hdr_menu.jsp" />
	<div id="CommonHeaderArea"></div>
	<div id="CommonHeader_M"></div>

	<div class="wrap" id="ori_wrap">
		<div class="top_title">고객감동센터</div>	
	<div class="MenuBar_Box">
		<ul>
			<li onclick="location.href='${contextPath}/Home/board/NoticeList.jsp';" class="on">공지사항</li>
			<li onclick="location.href='${contextPath}/Home/board/InquiryList.jsp';" >상품Q&A</li>
			<li onclick="location.href='${contextPath}/Home/board/InquiryWrite.jsp';" >1:1 문의/상담</li>
		</ul>
	</div>
	
	<form action="${contextPath}/board/addArticle.do" name="Inquiryfrm" method="post" enctype="multipart/form-data">	
		<div class="outter_box">
			<div class="right_box">

			<div>
				<ul>
					<li>제목</li>
					<li>
						<input type="text" name="title" />
					</li>
				</ul>
			</div>

			<div>
				<ul>
					<li>내용</li>
					<li class="textbox">
						<textarea type="text" name="content"></textarea>
					</li>
				</ul>
			</div>

			<div>
				<ul>
					<li class="filebox">파일첨부</li>
					<li class="filebox" style="position:relative;">
						<img class="file_x" data="https://www.artboxmall.com/Home/Cscenter/1" src="https://www.artboxmall.com/Images/Ver1/Common/btn_file_x.png" />
						<input type="text" name="txFile1" /><span class="file_btn">파일선택<input type="file" name="imageFileName"  onchange="fnItem1FileUpload()"/></span>
						<div style="clear:both; margin-bottom:10px;"></div>
					</li>

				</ul>
			</div>
			</div>
		</div>

		<div class="btn_area">
			<span onclick="backToList(this.form);">취소</span>
			<span onclick="InquiryInput();">등록</span>
		</div>
	</form>
	
	</div>
	<jsp:include page="../inc/footer.jsp" />
</body>
</html>