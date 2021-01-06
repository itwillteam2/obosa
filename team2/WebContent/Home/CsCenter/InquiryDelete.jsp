<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%
	request.setCharacterEncoding("UTF-8");

	String inqnum = request.getParameter("inqnum");
%>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="ko">
<head>
<jsp:include page="/Home/inc/head.jsp" />

<link rel="stylesheet" type="text/css"
	href="${contextPath}/Home/Css/CsCenter/Cscenter.css" />

<script type="text/javascript">
	$(function(){		
		$("#submit").click(function(){
			if($("#pw").val()==""){
				alert("비밀번호를 입력해주세요.");
				$("#pw").focus();
				return false;				
			};
		});	
		return false;
	});
</script>
</head>
<body>
	<jsp:include page="../inc/hdr_menu.jsp" />
	<div id="CommonHeaderArea"></div>
	<div id="CommonHeader_M"></div>

	<div class="wrap" id="ori_wrap">
		<div class="top_title">FAQ 삭제</div>

		<form name="Inquiryfrm" method="post" action="${contextPath}/CsCenter/DeleteInquiry.do">
			<div class="outter_box">
				<div style="margin : 0 auto; width : 50%;">
					<div>
							
						<ul>
							<li>*비밀번호</li>
							<li><input type="text" name="pw" id="pw"/></li>
							<li><input type="hidden" name="inqnum" id="inqnum" value="<%=inqnum%>"/></li>
						</ul>
					</div>
				</div>
			</div>
			<div class="btn_area">
				<input type="button" value="취소" onclick="location.href='${contextPath}/CsCenter/InquiryList.do'">
				<input type="submit" value="삭제" id="submit">
			</div>
		</form>
	</div>
	<jsp:include page="../inc/footer.jsp" />
</body>
</html>