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

<jsp:include page="../inc/head.jsp" />

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
			<li onclick="location.href='${contextPath}/Home/CsCenter/NoticeList.jsp';" >공지사항</li>
			<li onclick="location.href='${contextPath}/Home/CsCenter/InquiryList.jsp';" class="on">상품Q&A</li>
			<li onclick="location.href='${contextPath}/Home/CsCenter/InquiryWrite.jsp';" >1:1 문의/상담</li>
		</ul>
	</div>

	<div class="sel_box">
		<span onclick="javascript:location.href='${contextPath}/CsCenter/InquiryWrite.do';">문의하기</span>
		</div>
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
			<div class="more_info">답변이 충분하지 않으신가요?<strong class="mobile"></strong> 1:1 문의/상담을 이용해 주세요.<span onclick="location.href='${contextPath}/CsCenter/InquiryWrite.do';">1:1 문의/상담 작성</span></div>
		</div>
		<div class="FAQ">
			<div class="SearchContent" style="margin-top:20px; float:right;" >
				<div class="selectbox">
					<select id='ClassIDX' name='ClassIDX' style="float:right;">
						<option value=''>전체</option>
						<option value='0'>주문/결제</option>
						<option value='1'>취소/반품/환불</option>
						<option value='2'>배송</option>
						<option value='3'>기타</option>
					</select>		
					<ul>
						<li class="Search" style="float:right; width:250px; height:40px; border-bottom:2px solid #787878; margin:20px 0 0 0;">
							<div class="CommonSearch">
								<input type="text" id="kwd" value=""
								style="display:inline-block; background-color:#ffffff; border:0; padding:0; margin:0; width:200px; height:35px; line-height:35px; vertical-align:top; font-size:16px; color:#000000;">
									<a href="javascript:fnCommonSearch(1);">
										<img src="${contextPath}/Images/Ver1/Common/top_icon_search.png" />
									</a>
							</div>
						</li>
					</ul>
				</div>
			</div>
		</div>
		<div style="clear: both;"></div>
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