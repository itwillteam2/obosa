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
		<c:forEach var="InquiryList" items="${InquiryList}">			
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
					<c:if test="${InqRepList.inqnum == InquiryList.inqnum}">
						<p>질문해주신 내용의 답변입니다.</p>
						<p>${fn:replace(InqRepList.content, newLineChar, "<br/>")}</p>
					</c:if>
				</c:forEach>
				
				
				<c:choose>
					<c:when test="${sessionScope.id == 'admin'}">
						<c:forEach var="InqRepList" items="${InqRepList}">
							<c:choose>
								<c:when test="${InqRepList.inqnum == InquiryList.inqnum && !empty InqRepList.content}">
									<div class="more_info2">
										<span onclick="window.open('${contextPath}/Home/CsCenter/ReplyModify.jsp?inqnum=${InquiryList.inqnum}', 
										'Q&A답변수정', 'width=500, height=400, location=no, status=no, scrollbars=no, resizable=no, left=500, top=100' );">
										답변 수정</span>
										<a href="${contextPath}/Home/CsCenter/ReplyDelete.jsp?inqnum=${InqRepList.inqnum}">답변 삭제</a>
									</div>
								</c:when>
								<c:otherwise>
								<div class="more_info">
								<span onclick="window.open('${contextPath}/Home/CsCenter/Reply.jsp?inqnum=${InquiryList.inqnum}', 
								'Q&A답변등록', 'width=500, height=400, location=no, status=no, scrollbars=no, resizable=no, left=500, top=100' );">
								Q&A 답변 작성</span></div>	
								</c:otherwise>
							</c:choose>		
						</c:forEach>																				
					</c:when>	
					<c:when test="${sessionScope.id == InquiryList.id }">
						<div class="more_info">
							<span><a href="${contextPath}/CsCenter/InquiryModify.do?inqnum=${InquiryList.inqnum}" style="color : white;">FAQ 수정</a></span>
							<span><a href="${contextPath}/Home/CsCenter/InquiryDelete.jsp?inqnum=${InquiryList.inqnum}" style="color : white;">FAQ 삭제</a></span>
						</div>
					</c:when>	
				</c:choose>	
			</div>
		</c:forEach>
		<form method="post" action="InquirySearch.do" name="search">
		<div class="FAQ">
			<div class="SearchContent" style="margin-top:20px; float:right;" >
				<div class="selectbox">
					<select id='category' name='category' style="float: right;">
						<option value="" selected="selected">상담유형 선택</option>
						<option value="order">주문/결제</option>
						<option value="delivery">배송</option>
						<option value="cancel">취소/반품/교환</option>
						<option value="etc">기타</option>
					</select>
					<ul>
						<li class="Search" style="float:right; width:250px; height:40px; border-bottom:2px solid #787878; margin:20px 0 0 0;">
							<div class="CommonSearch">
								<input type="text" id="kwd" value=""
								style="display:inline-block; background-color:#ffffff; border:0; padding:0; margin:0; width:200px; height:35px; line-height:35px; vertical-align:top; font-size:16px; color:#000000;">
									<a href="javascript:search.submit();">
										<img src="${contextPath}/Images/Ver1/Common/top_icon_search.png" />
									</a>
							</div>
						</li>
					</ul>
				</div>
			</div>
		</div>
		</form>
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