<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	request.setCharacterEncoding("UTF-8");
	pageContext.setAttribute("newLineChar", "\n");
%>

<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />    
<!DOCTYPE html>
<html lang="ko">
<head>

<jsp:include page="../inc/head.jsp" />

<script type="text/javascript">
	
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
	
	function PageMove(page){
		location.href="${contextPath}/CsCenter/InquiryList.do?pageNO="+page

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
				<li onclick="location.href='${contextPath}/CsCenter/NoticeList.do'" >공지사항</li>
				<li onclick="location.href='${contextPath}/CsCenter/InquiryList.do'" class="on">Q&A</li>
				<li onclick="location.href='${contextPath}/CsCenter/InquiryWrite.do'">1:1문의/상담</li>
			</ul>
	</div>

	<div class="sel_box">
		<c:choose>
		<c:when test="${sessionScope.id ne 'admin'}">
			<span onclick="javascript:location.href='${contextPath}/CsCenter/InquiryWrite.do';">문의하기</span>
		</c:when>
		</c:choose>
		</div>
		<div style="clear: both;"></div>
		<div class="tab_gubn">
			<ul>
				<li>번호</li>
				<li>제목</li>
				<li>등록일</li>
			</ul>
		</div>
		<c:forEach var="InquiryList" items="${pagingList}">			
			<div class="list_line">
				<ul>							
					<li>${InquiryList.inqnum}</li>
					<li>${InquiryList.title}</li>
					<li><fmt:formatDate value="${InquiryList.date}" /></li>
				</ul>	
			</div>
			<div class="list_cont" style="display: none;">
				<p>${fn:replace(InquiryList.content, newLineChar, "<br/>")}</p>
				<div class="underbar"></div>
				
				<c:forEach var="InqRepList" items="${InqRepList}">
					
					<c:choose>
						<c:when test="${InqRepList.inqnum == InquiryList.inqnum }">
							<p>질문해주신 내용의 답변입니다.</p>
							<p>${fn:replace(InqRepList.content, newLineChar, "<br/>")}</p>
							<div class="more_info2">
								<c:if test="${sessionScope.id == 'admin'}">	
								<span onclick="window.open('${contextPath}/Home/CsCenter/ReplyModify.jsp?inqnum=${InquiryList.inqnum}', 
								'Q&A답변수정', 'width=500, height=400, location=no, status=no, scrollbars=no, resizable=no, left=500, top=100' );">답변 수정</span>
								<a href="${contextPath}/Home/CsCenter/ReplyDelete.jsp?inqnum=${InqRepList.inqnum}">답변 삭제</a>
								</c:if>
							</div>
						</c:when>
						<c:otherwise>
						<c:if test="${sessionScope.id == 'admin'}">	
							<div class="more_info" style="margin-top:20px;">
							<span onclick="window.open('${contextPath}/Home/CsCenter/Reply.jsp?inqnum=${InquiryList.inqnum}', 
							'Q&A답변등록', 'width=500, height=400, location=no, status=no, scrollbars=no, resizable=no, left=500, top=100' );">
							Q&A 답변 작성</span></div>
							</c:if>
						</c:otherwise>
					</c:choose>																		
					
				</c:forEach>
					
					<c:if test="${sessionScope.id == InquiryList.id }">
						<div class="more_info">
							<span><a href="${contextPath}/CsCenter/InquiryModify.do?inqnum=${InquiryList.inqnum}" style="color : white;">FAQ 수정</a></span>
							<span><a href="${contextPath}/Home/CsCenter/InquiryDelete.jsp?inqnum=${InquiryList.inqnum}" style="color : white;">FAQ 삭제</a></span>
						</div>
					</c:if>	
			</div>
		</c:forEach>
		
		<div class="FAQ">
			<div class="SearchContent" style="margin-top:20px; float:right;" >
				<div class="selectbox">
				<form method="post" action="InquirySearch.do" name="search">
					<select id='category' name='category' style="float: right;">
						<option value="id" selected>작성자</option>
						<option value="title">제목</option>
					</select>
					<ul>
						<li class="Search" style="float:right; width:250px; height:40px; border-bottom:2px solid #787878; margin:20px 0 0 0;">
							<div class="CommonSearch">
								<input type="text" id="searchText" name="searchText" style="display:inline-block; background-color:#ffffff; border:0; padding:0; margin:0; width:200px; height:35px; line-height:35px; vertical-align:top; font-size:16px; color:#000000;">
									<a href="javascript:search.submit();">
										<img src="${contextPath}/Images/Ver1/Common/top_icon_search.png" />
									</a>
							</div>
						</li>
					</ul>
				</form>
				</div>
			</div>
		</div>
		
		<div style="clear: both;"></div>
		<div class="paging">
			<span class="box">
				<span class="btn_pageprev"><a href="javascript:PageMove(${paging.prevPage})"><img class="paging_pc" src="${contextPath}/Images/Ver1/Common/btn_board_prev.gif" /></a></span>
					<c:forEach var="i" begin="${paging.startPage}" end="${paging.endPage}" step="1">
						<c:choose>
							<c:when test="${i eq paging.pageNo}">
								<span class="txt_pagenum"><a href="javascript:PageMove(${i})" class="btn_pageon">${i}</a></span>
							</c:when>
							<c:otherwise>
								<span class="txt_pagenum"><a href="javascript:PageMove(${i})">${i}</a></span>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				<span class="btn_pagenext"><a href="javascript:PageMove(${paging.nextPage})"><img class="paging_pc" src="${contextPath}/Images/Ver1/Common/btn_board_next.gif" /></a></span>
			</span>
		</div>
	</div>
	
	<jsp:include page="../inc/footer.jsp" />
</body>
</html>