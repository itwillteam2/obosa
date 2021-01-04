<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<c:set var="recentURI" value="${header.referer}"/>
<c:set var="id" value="${sessionScope.id}"/>
<c:set var="pwd" value="${vo.pwd}"/>

<!DOCTYPE html>
<html lang="ko">
<head>
<jsp:include page="/Home/inc/head.jsp"/>
<script type="text/javascript">

	function fnCheck(){

		var mempwd = document.Check.mempwd.value;

		if (!mempwd) {
			alert("비밀번호를 입력해주세요.");
			$("input[name=mempwd]").focus();
			return;
		}

	if(mempwd != "${pwd}"){
		alert("비밀번호가 일치하지 않습니다.");
		return;
	}
	document.Check.submit();
	}
	
</script>
</head>
<body>
<jsp:include page="/Home/inc/header.jsp" />
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

<form name="Check" method="post" action="${contextPath}/member/userInfo.do">
<input type="hidden" name="recentURI" value="${recentURI}">
<div class="LoginWrap">
	<div class="LoginTitle">비밀번호 확인</div>
	<div class="LoginComment"></div>
	<input type="hidden" name="recentURI" value="${recentURI}">
	<div class="LoginInput"><input type="password" name="mempwd" placeholder="비밀번호를 입력해주세요." maxlength="32" onkeypress="if(event.keyCode==13){fnLogin(1);}" /></div>
	<a class="LoginButton" href="javascript:fnCheck();">확인</a>
</div>
</form>
<jsp:include page="/Home/inc/footer.jsp" />
</body>
</html>
