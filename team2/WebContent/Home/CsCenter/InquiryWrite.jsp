<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%
	request.setCharacterEncoding("UTF-8");
%>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="ko">
<head>
<jsp:include page="/Home/inc/head.jsp" />

<link rel="stylesheet" type="text/css"
	href="${contextPath}/Home/Css/CsCenter/Cscenter.css" />

<script type="text/javascript">
	$(document).ready(function() {

	});

	$(document).on("click", ".file_x", function() {
		var targetNum = $(this).attr("data");

		$("[name=txFile" + targetNum + "]").val("");
		$("[name=file" + targetNum + "]").val("");
		$(this).css("display", "none");
	});

	function isEmail(asValue) {

		var regExp = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;

		return regExp.test(asValue); // 형식에 맞는 경우 true 리턴	

	}

	$(function(){		
		$("#submit").click(function(){
			if($("#id").val()==""){
				alert("아이디를 입력해주세요.");
				$("#id").focus();
				return false;				
			};
			if($("#email").val()==""){
				alert("이메일을 입력해주세요.");
				$("#email").focus();
				return false;				
			};
			if($("#category").val()==""){
				alert("문의분야를 선택해주세요.");
				$("#category").focus();
				return false;				
			};
			
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
				<li onclick="location.href='${contextPath}/CsCenter/NoticeList.do'" >공지사항</li>
				<li onclick="location.href='${contextPath}/CsCenter/InquiryList.do'" >FAQ</li>
				<li onclick="location.href='${contextPath}/CsCenter/InquiryWrite.do'" class="on">1:1문의/상담</li>
			</ul>
		</div>

		<form name="Inquiryfrm" method="post" action="InquiryAdd.do">
			<div class="warning_box">
				<span>답변 가능 시간은 오전 9:00시부터 오후 6:00시까지입니다. (주말 및 공휴일 제외)</span>
			</div>

			<div class="outter_box">
				<div class="left_box">
					<div>
						<ul>
							<li>*아이디</li>
							<li><input type="text" name="id" id="id"/></li>
						</ul>
					</div>
					<div>
						<ul>
							<li>*이메일</li>
							<li><input type="text" name="email" id="email"/></li>
						</ul>
					</div>
					<div class="underline"></div>
					<div>
						<ul>
							<li>*문의분야</li>
							<li><select id="category" name="category" title="상담유형 선택">
									<option value="" selected="selected">상담유형 선택</option>
									<option value="01">주문/결제</option>
									<option value="02">배송</option>
									<option value="03">취소/반품/교환</option>
									<option value="04">기타</option>
							</select></li>
						</ul>
					</div>

				</div>
				<div class="right_box">
					<div>
						<ul>
							<li>*제목</li>
							<li><input type="text" name="title" id="title" /></li>
						</ul>
					</div>

					<div>
						<ul>
							<li>*문의내용</li>
							<li class="textbox"><textarea type="text" name="content" id="content"></textarea>
							</li>
						</ul>
					</div>
				</div>
			</div>
			<div class="btn_area">
				<input type="reset" value="다시 작성">
				<input type="submit" value="등록" id="submit">
			</div>
		</form>
	</div>
	<jsp:include page="../inc/footer.jsp" />
</body>
</html>