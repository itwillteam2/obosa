<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<c:set var="recentURI" value="${header.referer}"/>

<!DOCTYPE html>
<html lang="ko">
<head>

<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
<meta http-equiv="Content-Script-Type" content="text/javascript" />
<meta http-equiv="Content-Style-Type" content="text/css" />
<title>SSMarket</title>

<link href="${contextPath}/T2_tmp/Home/Css/Common/Common.css" type="text/css" rel="stylesheet" />
<link href="${contextPath}/T2_tmp/Home/Css/Common/swiper.min.css" type="text/css" rel="stylesheet" />
<script type="text/javascript" src="${contextPath}/T2_tmp/Home/Js/Common/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="${contextPath}/T2_tmp/Home/Js/Common/Common.js"></script>
<script type="text/javascript" src="${contextPath}/T2_tmp/Home/Js/Common/swiper_r.min.js"></script>
<link rel="stylesheet" type="text/css" href="${contextPath}/T2_tmp/Home/Css/Member/Member.css" />
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
<jsp:include page="../inc/header.jsp" />
<div id="CommonHeaderArea"></div>
<div id="CommonHeader_M">
	<div id="CommonHeaderMenu_M">
		<div class="tableDiv">
			<dl class="trMobileMenu">
				<dd class="tdBtn"><a href="javascript:fnMobileMenu(1);" onclick="GA_event('HEAD', '최상단 메뉴 MO', '메뉴버튼');"><img src="${contextPath}/T2_tmp/Images/Ver1/Common/m_top_menu.png" /></a></dd>
				<dd class="tdBtn">&nbsp;</dd>
				<dd class="tdLogo"><a href="${contextPath}/T2_tmp/Home/index-2.html"><img src="${contextPath}/T2_tmp/Images/Ver1/Common/m_logo.png" onclick="GA_event('HEAD', '최상단 메뉴 MO', '홈');"/></a></dd>
				<dd class="tdBtn"><a href="javascript:fnMobileMenuToggle(1);" onclick="GA_event('HEAD', '최상단 메뉴 MO', '검색 활성화');"><img src="${contextPath}/T2_tmp/Images/Ver1/Common/m_top_search.png" /></a></dd>
				<dd class="tdBtn">
					<a href="${contextPath}/T2_tmp/Home/Order/Cart.html" onclick="GA_event('HEAD', '최상단 메뉴 MO', '장바구니');">
						
						<img src="${contextPath}/T2_tmp/Images/Ver1/Common/m_top_cart.png" />
					</a>
				</dd>
			</dl>
		</div>
	</div>
	<div id="CommonHeaderSearch_M">
		<div class="tableDiv">
			<dl class="trMobileMenu">
				<dd class="tdKwd"><div class="CommonSearch"><input type="text" id="kwd_M" value="" onkeypress="if(event.keyCode==13){fnCommonSearch(2);}" /></div></dd>
				<dd class="tdBtn"><a href="javascript:fnCommonSearch(2);" onclick="GA_event('HEAD', '최상단 메뉴 MO', '검색');"><img src="${contextPath}/T2_tmp/Images/Ver1/Common/m_top_search.png" /></a></dd>
				<dd class="tdBtn"><a href="javascript:fnMobileMenuToggle(2);" onclick="GA_event('HEAD', '최상단 메뉴 MO', '검색 비활성화');"><img src="${contextPath}/T2_tmp/Images/Ver1/Common/m_top_close.png" /></a></dd>
			</dl>
		</div>
	</div>
</div>
<div id="CommonHeaderArea_M"></div>

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
	<div class="BenefitImage">
		<img src="${contextPath}/T2_tmp/Images/Ver1/Member/benefit.png" />
	</div>

</div>
</form>
<jsp:include page="../inc/footer.jsp" />
</body>
</html>
