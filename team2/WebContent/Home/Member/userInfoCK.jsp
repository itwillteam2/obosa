<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<c:set var="recentURI" value="${header.referer}"/>
<c:set var="id" value="${sessionScope.id}"/>
<c:set var="pwd" value="${vo.pwd}"/>

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

	function fnCheck(){

		var mempwd = document.Check.mempwd.value;

		if (!mempwd) {
			alert("��й�ȣ�� �Է����ּ���.");
			$("input[name=mempwd]").focus();
			return;
		}

	if(mempwd != "${pwd}"){
		alert("��й�ȣ�� ��ġ���� �ʽ��ϴ�.");
		return;
	}
	document.Check.submit();
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
				<dd class="tdBtn"><a href="javascript:fnMobileMenu(1);" onclick="GA_event('HEAD', '�ֻ�� �޴� MO', '�޴���ư');"><img src="${contextPath}/T2_tmp/Images/Ver1/Common/m_top_menu.png" /></a></dd>
				<dd class="tdBtn">&nbsp;</dd>
				<dd class="tdLogo"><a href="${contextPath}/T2_tmp/Home/index-2.html"><img src="${contextPath}/T2_tmp/Images/Ver1/Common/m_logo.png" onclick="GA_event('HEAD', '�ֻ�� �޴� MO', 'Ȩ');"/></a></dd>
				<dd class="tdBtn"><a href="javascript:fnMobileMenuToggle(1);" onclick="GA_event('HEAD', '�ֻ�� �޴� MO', '�˻� Ȱ��ȭ');"><img src="${contextPath}/T2_tmp/Images/Ver1/Common/m_top_search.png" /></a></dd>
				<dd class="tdBtn">
					<a href="${contextPath}/T2_tmp/Home/Order/Cart.html" onclick="GA_event('HEAD', '�ֻ�� �޴� MO', '��ٱ���');">
						
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
				<dd class="tdBtn"><a href="javascript:fnCommonSearch(2);" onclick="GA_event('HEAD', '�ֻ�� �޴� MO', '�˻�');"><img src="${contextPath}/T2_tmp/Images/Ver1/Common/m_top_search.png" /></a></dd>
				<dd class="tdBtn"><a href="javascript:fnMobileMenuToggle(2);" onclick="GA_event('HEAD', '�ֻ�� �޴� MO', '�˻� ��Ȱ��ȭ');"><img src="${contextPath}/T2_tmp/Images/Ver1/Common/m_top_close.png" /></a></dd>
			</dl>
		</div>
	</div>
</div>
<div id="CommonHeaderArea_M"></div>

<form name="Check" method="post" action="${contextPath}/member/userInfo.do">
<input type="hidden" name="recentURI" value="${recentURI}">
<div class="LoginWrap">
	<div class="LoginTitle">��й�ȣ Ȯ��</div>
	<div class="LoginComment"></div>
	<input type="hidden" name="recentURI" value="${recentURI}">
	<div class="LoginInput"><input type="password" name="mempwd" placeholder="��й�ȣ�� �Է����ּ���." maxlength="32" onkeypress="if(event.keyCode==13){fnLogin(1);}" /></div>
	<a class="LoginButton" href="javascript:fnCheck();">Ȯ��</a>
</div>
</form>
<jsp:include page="../inc/footer.jsp" />
</body>
</html>
