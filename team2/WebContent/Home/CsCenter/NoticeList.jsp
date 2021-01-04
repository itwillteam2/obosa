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


<jsp:include page="../inc/head.jsp" />
<link rel="stylesheet" type="text/css" href="${contextPath}/Home/Css/Common/Common.css" />
<link rel="stylesheet" type="text/css" href="${contextPath}/Home/Css/Common/swiper.min.css" />

<script type="text/javascript" src="${contextPath}/Home/Js/Common/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="${contextPath}/Home/Js/Common/Common.js"></script>
<script type="text/javascript" src="${contextPath}/Home/Js/Common/swiper_r.min.js"></script>

<link rel="stylesheet" type="text/css" href="${contextPath}/Home/Css/Cscenter.css" />
<link rel="stylesheet" type="text/css" href="${contextPath}/Home/Css/MyPageQnA.css" />

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
			url : "/Home//PlusSeeAjax.asp",
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
		
		location.href="https://www.artboxmall.com/Home//NoticeList.asp" + param
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
			<li onclick="location.href='${contextPath}/Home/CsCenter/NoticeList.jsp';" class="on">공지사항</li>
			<li onclick="location.href='${contextPath}/Home/CsCenter/InquiryList.jsp';" >상품Q&A</li>
			<li onclick="location.href='${contextPath}/Home/CsCenter/InquiryWrite.jsp';" >1:1 문의/상담</li>
		</ul>
	</div>

		<div class="sel_box">
			<span
				onclick="javascript:location.href='${contextPath}/CsCenter/NoticeWrite.do';">공지사항 쓰기</span>
		</div>
		<span class="tot_cnt">총 <span>102</span>건의 FAQ가 있습니다.
		</span>
		<div style="clear: both;"></div>
		<div class="tab_gubn">
			<ul>
				<li>번호</li>
				<li>제목</li>
				<li>등록일</li>
			</ul>
		</div>
		<div class="list_line">
			<ul>
				<li>102</li>
				<li>상품을 해외로 배송할 수 있나요?</li>
				<li>2018-09-18</li>
			</ul>
		</div>
		<div class="list_cont" style="display:none;">
			<p>현재 해외배송 서비스는 지원하지 않고 있습니다.</p><p>국내 배송지로 배송만 가능합니다.</p>
			<div class="more_info">답변이 충분하지 않으신가요?<strong class="mobile"></strong> 1:1 문의/상담을 이용해 주세요.<span onclick="javascript:location.href='/Home/Cscenter/Enquiry.asp';">1:1 문의/상담 작성</span></div>
		</div>
		<div class="FAQ">
			<div class="SearchContent">
				<div class="SearchLeftTitle">공지사항 검색</div>

				<div class="selectbox">
					<select id='ClassIDX' name='ClassIDX'>
						<option value=''>전체</option>
						<option value='0'>주문/결제</option>
						<option value='1'>취소/반품/환불</option>
						<option value='2'>배송</option>
					</select>
				</div>
				<div class="inputbox">
					<input type="text" class="i_input01" name="txSch" id="txSch"
						value="" title="검색어"
						onkeypress="if(event.keyCode==13){$('.Search_btn').trigger('click');}" />
					<span class="Search_btn"></span>
				</div>
			</div>
		</div>
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