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
 
<link rel="stylesheet" type="text/css" href="${contextPath}/Home/Css/CsCenter/MyPageQnA.css">

<script type="text/javascript">

	$(document).ready(function(){
	
	
	});
	
	$(document).on("change",".searchType",function(){
		location.href="/Home/MyPage/MyPageMyQna.asp?searchType=" + $(this).val() + "&CounselType=";
	});
	
	$(document).on("change",".CounselType",function(){
		location.href="/Home/MyPage/MyPageMyQna.asp?CounselType=" + $(this).val() + "&searchType=";
	});
	
	function fnGoPage (page)
	{
		var term = $("[name=Term]").val();
		var param = "?page=" + page + "&term=" + term;
		
		location.href="/Home/MyPage/MyPageMain.asp" + param
	}
	
	$(document).on("click",".list_line",function(event){
		if ( $(this).next("div").css("display") == "none" )
		{
			$(this).next("div").css("display","block");
		}
		else
		{
			$(this).next("div").css("display","none");
		}
	});
	
	
	//삭제
	function funcDel(Idx)
	{
		if (confirm("삭제하시겠습니까?\n\n삭제하면 다시 복구할 수 없습니다.") )
		{
			location.href = "MyPageMyQnAItemDelete_P.asp?Idx="+Idx+"";
	//		thisFrm.submit() ; 
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
			<li onclick="location.href='${contextPath}/Home/CsCenter/NoticeList.jsp';" class="on">공지사항</li>
			<li onclick="location.href='${contextPath}/Home/CsCenter/InquiryList.jsp';" >상품Q&A</li>
			<li onclick="location.href='${contextPath}/Home/CsCenter/InquiryWrite.jsp';" >1:1 문의/상담</li>
		</ul>
	</div>

	<div class="sel_box">
		<select class="CounselType">
			<option value="">상담분류 전체</option>
			<option value="01">주문/결제</option>
			<option value="02">배송</option>
			<option value="03">취소/반품/교환</option>
			<option value="04">기타</option>
		</select>
		<select class="searchType">
			<option value="">진행 상태 전체</option>
			<option value="Q">문의접수</option>
			<option value="A">답변완료</option>
		</select>
		<span onclick="javascript:location.href='${contextPath}/Home/CsCenter/InquiryWrite.jsp';">문의하기</span>
	</div>
	
		<div class="MyQnaBox">
			<div class="list_line" onclick="javascript:void(0);">
				<ul>
					<li class="mobile">2020-12-30</li>
					<li>답변 완료</li>
					<li>구매</li>
					<li class="pc">2020-12-30</li>
					<input type="hidden">
				</ul>
			</div>
			<div class="list_cont" style="display:none;">
				<div class="qnabox">
					<span class="marker">Q.</span><p>구매</p>
				</div>
				<div class="qnabox type">
					<span class="marker">A.</span><p>내용</p>
				</div>	
			</div>			
		</div>
		
		<div class="paging">
			<span class="box">
				<span class="btn_pageprev opacity"><a href="javascript:;"><img class="paging_pc" src="${contextPath}/Images/Ver1/Common/btn_board_prev.gif"></a></span>
				<span class="txt_pagenum"><a href="javascript:;" class="btn_pageon">1</a></span>
				<span class="btn_pagenext opacity"><a href="javascript:;" onclick="alert('마지막 페이지입니다.');">	<img class="paging_pc" src="${contextPath}/Images/Ver1/Common/btn_board_next.gif"></a></span>
			</span>
		</div>
	</div>
	
	<jsp:include page="../inc/footer.jsp" />
</body>
</html>