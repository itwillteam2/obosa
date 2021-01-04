<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<c:set var="recentURI" value="${header.referer}"/>

<!DOCTYPE html>
<html lang="ko">
<head>
<jsp:include page="/Home/inc/head.jsp"/>
<script type="text/javascript">

$(document).ready(function(){

	var userInputId = getCookie("userInputId");
	$("input[name='memid']").val(userInputId);  
	
	if($("input[name='memid']").val() != ""){ 
		$("#chkAutoID").attr("checked", true);
	}

});

	function fnLogin(x){

		var memid = document.Login.memid.value;
		var mempwd = document.Login.mempwd.value;

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
<!-- Main Logo area start -->
<div id="CommonHeader">
	<a href="${contextPath}/common/index.do" class="MainLogo"><img src="${contextPath}/Images/Ver1/Common/logo.png" /></a>
	<a href="${contextPath}/common/index.do" class="MainLogoScroll"><img src="${contextPath}/Images/Ver1/Common/logo.png" /></a>		
	<div class="CategoryLarge"></div>
</div>
<div id="CommonHeaderArea"></div>
<div id="CommonHeader_M"></div>
		<div class="clear"></div>
<!-- Main Logo area end -->


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
	

</div>
</form>

<jsp:include page="/Home/inc/footer.jsp" />
</body>
</html>
