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

	$(document).on("click",".list_line",function(){
		if ( $(this).next("div").css("display") == "none" )
		{
			$(this).next("div").css("display","block");
			var idx = $(this).children().find("input").val();
			fnPlusSee(idx);
		}
		else
		{
			$(this).next("div").css("display","none");
		}
	});

	function fnPlusSee ( idx )
	{
		var param = "mode=N&idx=" + idx ;
		var request = $.ajax({
			url : "/Home/Cscenter/PlusSeeAjax.asp",
			type: "post",
			data: param
		});
		
		request.done(function(response, textStatus, jqXHR){
		});		
	}

	function fnGoPage (page)
	{
		var term = $("[name=Term]").val();
		var param = "?page=" + page;
		
		location.href="https://www.artboxmall.com/Home/Cscenter/NoticeList.asp" + param
	}
	
	//삭제
	function funcDel(Idx)
	{
		if (confirm("삭제하시겠습니까?\n\n삭제하면 다시 복구할 수 없습니다.") )
		{
			location.href = "MyPageMyQnAItemDelete_P.asp?Idx="+Idx+"";
//			thisFrm.submit() ; 
		}
	}

</script>
</head>
<body>
	<jsp:include page="../inc/hdr_menu.jsp" />
	<div id="CommonHeaderArea"></div>
	<div id="CommonHeader_M"></div>

	<div class="wrap">
		<div class="top_title">고객감동센터</div>
	<div class="MenuBar_Box">
		<ul>
			<li onclick="location.href='${contextPath}/Home/board/NoticeList.jsp';" class="on">공지사항</li>
			<li onclick="location.href='${contextPath}/Home/board/'InquireList.jsp;" >상품Q&A</li>
			<li onclick="location.href='${contextPath}/Home/board/InquiryWrite.jsp';" >1:1 문의/상담</li>
		</ul>
	</div>
	
		<%-- <c:if test="${is_admin == 1}"> --%>
			<a href="${contextPath}/board/articleForm.do"><input type="button" value="글쓰기"></a>
		<%-- </c:if> --%>
			
			<div class="tab_gubn">
				<ul>
					<li>번호</li>
					<li>제목</li>
					<li>등록일</li>
				</ul>
			</div>
	
	<c:choose>
		<c:when test="${articlesList == null}" >
				<div>등록된 글이 없습니다.</div>
		</c:when>
		<c:when test="${articlesList != null}" >
		<c:forEach  var="article"   items="${articlesList}"  varStatus="articleNum"  >
			<div class="list_line">
				<ul>
					<li>8</li>
					<li>리플렛 할인 쿠폰 발급 및 사용 종료 안내</li>
					<li>2020-11-27</li>
					<input type="hidden"/>
				</ul>
			</div>
			<div class="list_cont" style="display:none;">
				<p>내용</p>
				<div class="btn_area">
					<span class="btnQA" onclick="javascript:funcDel(52333);">수정</span>
					<span class="btnQA" onclick="">삭제</span>
				</div>
			</div>
		</c:forEach>
		</c:when>
	</c:choose>	
	
			<div class="paging">
				<span class="box">
					<span class="btn_pageprev opacity" ><a href="javascript:;" ><img class="paging_pc" src="${contextPath}/Images/Ver1/Common/btn_board_prev.gif" /></a></span>
					<span class="txt_pagenum"><a href="javascript:;" class="btn_pageon"  >1</a></span>
					<span class="btn_pagenext opacity" ><a href="javascript:;" onclick="alert('마지막 페이지입니다.');"><img class="paging_pc" src="${contextPath}/Images/Ver1/Common/btn_board_next.gif" /></a></span>
				</span>
			</div>
	</div>
	
	<jsp:include page="../inc/footer.jsp" />
</body>
</html>