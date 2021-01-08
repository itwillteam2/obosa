<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%
	request.setCharacterEncoding("UTF-8");
	pageContext.setAttribute("newLineChar", "\n");
%>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="ko">
<head>

<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />

<meta http-equiv="Content-Script-Type" content="text/javascript" />
<meta http-equiv="Content-Style-Type" content="text/css" />

<title>SSMarket</title>


<jsp:include page="../inc/head.jsp" />

<script type="text/javascript">
	$(document).on("click", ".list_line", function() {
		if ($(this).next("div").css("display") == "none") {
			$(this).next("div").css("display", "block");
			var idx = $(this).children().find("input").val();
			fnPlusSee(idx);
		} else {
			$(this).next("div").css("display", "none");
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
				<li onclick="location.href='${contextPath}/CsCenter/NoticeList.do'" class="on">공지사항</li>
				<li onclick="location.href='${contextPath}/CsCenter/InquiryList.do'">Q&A</li>
				<li onclick="location.href='${contextPath}/CsCenter/InquiryWrite.do'">1:1문의/상담</li>
			</ul>
		</div>

		<div class="sel_box">
		<c:choose>
			<c:when test="${sessionScope.id == 'admin'}">
				<span onclick="javascript:location.href='${contextPath}/CsCenter/NoticeWrite.do';">공지사항쓰기</span>
			</c:when>
		</c:choose>
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
		<c:forEach var="NoticeList" items="${NoticeList}">			
		<div class="list_line">
				<ul>							
					<li>${NoticeList.nnum}</li>
					<li>${NoticeList.title}</li>
					<li><fmt:formatDate value="${NoticeList.date}" /></li>
				</ul>
			
		</div>
		<div class="list_cont" style="display: none;">
			<p>${fn:replace(NoticeList.content, newLineChar, "<br/>")}</p>
			<c:choose>
				<c:when test="${sessionScope.id == 'admin'}">
					<div class="more_info">
					<span><a href="${contextPath}/CsCenter/NoticeModify.do?nnum=${NoticeList.nnum}" style="color : white;">공지사항 수정</a></span>
					<span><a href="${contextPath}/Home/CsCenter/NoticeDelete.jsp?nnum=${NoticeList.nnum}" style="color : white;">공지사항 삭제</a></span>
				</div>
				</c:when>
			</c:choose>		
		</div>
		</c:forEach>
		<div class="FAQ">
			<div class="SearchContent" style="margin-top: 20px; float: right;">
				<div class="selectbox">
					<ul>
						<li class="Search"
							style="float: right; width: 250px; height: 40px; border-bottom: 2px solid #787878; margin: 20px 0 0 0;">
							<div class="CommonSearch">
								<input type="text" id="kwd" value=""
									style="display: inline-block; background-color: #ffffff; border: 0; padding: 0; margin: 0; width: 200px; height: 35px; line-height: 35px; vertical-align: top; font-size: 16px; color: #000000;">
								<a href="javascript:fnCommonSearch(1);"> <img
									src="${contextPath}/Images/Ver1/Common/top_icon_search.png" />
								</a>
							</div>
						</li>
					</ul>
				</div>
			</div>
		</div>
		<div style="clear: both;"></div>
		<div class="paging">
			<span class="box"> <span class="btn_pageprev opacity"><a
					href="javascript:;"><img class="paging_pc"
						src="${contextPath}/Images/Ver1/Common/btn_board_prev.gif" /></a></span> <span
				class="txt_pagenum"><a href="javascript:;" class="btn_pageon">1</a></span>
				<span class="btn_pagenext opacity"><a href="javascript:;"
					onclick="alert('마지막 페이지입니다.');"><img class="paging_pc"
						src="${contextPath}/Images/Ver1/Common/btn_board_next.gif" /></a></span>
			</span>
		</div>
	</div>

	<jsp:include page="../inc/footer.jsp" />
</body>
</html>