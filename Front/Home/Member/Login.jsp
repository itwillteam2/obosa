<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<c:set var="recentURI" value="${header.referer}"/>

<!DOCTYPE html>
<html lang="ko">
<head>
<jsp:include page="${contextPath}/Home/inc/head.jsp"/>

<script type="text/javascript">

$(document).ready(function(){

	var userInputId = getCookie("userInputId");
	$("input[name='memid']").val(userInputId);  
	
	if($("input[name='memid']").val() != ""){ 
		$("#chkAutoID").attr("checked", true);
	}

});

	function fnLogin(x){

		var memid, mempwd, chkAutoID;

		if (x==2) {
			memid = document.SnsLogin.memid.value;
			mempwd = document.SnsLogin.memid.value;
		} else {
			memid = $("input[name=memid]").val().trim();
			mempwd = $("input[name=mempwd]").val();
		}

		if (!memid) {
			alert("아이디를 입력해주세요.");
			$("input[name=memid]").focus();
			return;
		}

		if (!mempwd) {
			alert("비밀번호를 입력해주세요.");
			$("input[name=mempwd]").focus();
			return;
		}

		if ($("input[name=chkAutoID]").prop("checked")) {
			var userInputId = $("input[name='memid']").val();
			setCookie("userInputId", userInputId, 90);
		} else {
			deleteCookie("userInputId");
		}

	document.Login.submit();
	}
	
// 	$(document).on("click", ".btnGoJoin", function(){
// 		$(location).attr("href","Join.jsp");
// 	});

	$(window).resize(function(){
		if ($(".overlay").hasClass("on"))
		{
			$(".overlay.inner").center();	
		}
	});

	$.fn.center = function () {		// 레이어팝업 센터 정렬
		this.css("top", Math.max(0, (($(window).height() - $(this).outerHeight()) / 2) + $(window).scrollTop()) + "px");
		this.css("left", Math.max(0, (($(window).width() - $(this).outerWidth()) / 2) + $(window).scrollLeft()) + "px");
		return this;
	}
	
	function setCookie(cookieName, value, exdays){
		var exdate = new Date();

		exdate.setDate(exdate.getDate() + exdays);

		var cookieValue = escape(value) + ((exdays==null) ? "" : "; expires=" + exdate.toGMTString());

		document.cookie = cookieName + "=" + cookieValue;
	}
	
	function deleteCookie(cookieName){
		var expireDate = new Date();

		expireDate.setDate(expireDate.getDate() - 1);

		document.cookie = cookieName + "= " + "; expires=" + expireDate.toGMTString();
	}
	
	function getCookie(cookieName) {

		cookieName = cookieName + '=';

		var cookieData = document.cookie;
		var start = cookieData.indexOf(cookieName);
		var cookieValue = '';

		if(start != -1){
			start += cookieName.length;

			var end = cookieData.indexOf(';', start);

			if(end == -1)end = cookieData.length;

			cookieValue = cookieData.substring(start, end);
		}
		return unescape(cookieValue);
	}
</script>
</head>
<body>
<jsp:include page="${contextPath}/Home/inc/header.jsp" />

<form name="Login" method="post" action="${contextPath}/member/loginCK.do">
<div class="LoginWrap">
	<div class="LoginTitle">로그인</div>
	<div class="LoginComment"></div>
	<input type="hidden" name="recentURI" value="${recentURI}">
	<div class="LoginInput"><input type="text" name="memid" placeholder="아이디를 입력해주세요." maxlength="16" value="" /></div>
	<div class="LoginInput"><input type="password" name="mempwd" placeholder="비밀번호를 입력해주세요." maxlength="32" onkeypress="if(event.keyCode==13){fnLogin(1);}" /></div>
	<div class="JoinLink">
		<ul>
			<li class="Left"><input name="chkAutoID" type="checkbox"  id="chkAutoID" />&nbsp;&nbsp;아이디 저장하기</li>
			<li class="Right"><a href="${contextPath}/member/find.do">아이디/비밀번호 찾기</a><span>|</span><a href="${contextPath}/member/join.do">회원가입</a></li>
		</ul>
		<div class="clear"></div>
	</div>
	<a class="LoginButton" href="javascript:fnLogin(1);">로그인</a>
	<div id="NonMemberForm">
		<div class="LoginInput"><input type="text" name="ordernumber" placeholder="주문번호를 입력해주세요." maxlength="16" value="" /></div>
		<div class="LoginInput"><input type="text" name="nonmembername" placeholder="주문자명을 입력해주세요." maxlength="16" onkeypress="if(event.keyCode==13){fnNonMemberOrderDetail();}" /></div>
		<div class="NonMemberFormComment">*주문번호는 주문 시 발송되는 메일 또는 문자를 통해 확인할 수 있습니다.</div>
		<a class="NonMemberOrderDetailButton" href="javascript:fnNonMemberOrderDetail();">확인</a>
	</div>
	<div class="BenefitImage">
		<img src="${contextPath}/Images/Ver1/Member/benefit.png" />
	</div>

</div>
</form>

<jsp:include page="${contextPath}/Home/inc/footer.jsp"/>
</body>
</html>
