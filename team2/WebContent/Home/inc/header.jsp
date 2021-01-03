<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>	
<header>	
<div id="CommonHeader">
	<div id="mymenu">
			<c:choose>
				<c:when test="${empty sessionScope.id}">
					<a href="${contextPath}/member/login.do">로그인</a>&nbsp; | &nbsp;
					<a href="${contextPath}/member/join.do">회원가입</a>
				</c:when>
				<c:otherwise>
					<a href="${contextPath}/member/userInfoCK.do">회원정보변경</a>&nbsp; | &nbsp;
					<a href="${contextPath}/member/logout.do">로그아웃</a>
				</c:otherwise>
			</c:choose>
		</div>
	<a href="${contextPath}/T2_tmp/Home/index.jsp" class="MainLogo"><img src="${contextPath}/T2_tmp/Images/Ver1/Common/logo.png" /></a>
	<a href="${contextPath}/T2_tmp/Home/index.jsp" class="MainLogoScroll"><img src="${contextPath}/T2_tmp/Images/Ver1/Common/logo.png" /></a>
	<div class="CategoryLarge">
		<ul>
			<li class="CategoryMiddle"><a href="#">인형/토이</a></li>
			<li class="CategoryMiddle"><a href="#">문구</a></li>
			<li class="CategoryMiddle"><a href="#">패션</a></li>
			<li class="CategoryMiddle"><a href="#">주방/욕실</a></li>
			<li class="CategoryMiddle"><a href="#">리빙/데코</a></li>
			<li class="CategoryMiddle"><a href="#">디지털/가전</a></li>
			<li class="CategoryMiddle"><a href="#">여행</a></li>
			<li class="CategoryMiddle"><a href="#">뷰티</a></li>
			
<!-- 			<li class="MyPage"> -->
<%-- 			<c:choose> --%>
<%-- 				<c:when test="${empty sessionScope.id}"> --%>
<%-- 					<a href="${contextPath}/T2_tmp/Member/login.do" title="로그인"><img src="${contextPath}/T2_tmp/Images/Ver1/Common/avatar.svg" id="MyInfoSummaryIcon" /></a> --%>
<%-- 					<a href="${contextPath}/T2_tmp/Member/login.do" id="LoginBalloon" title="로그인">로그인 !!</a> --%>
<%-- 					<a href="${contextPath}/T2_tmp/Member/join.do" title="회원가입"><img src="${contextPath}/T2_tmp/Images/Ver1/Common/house_1.svg" /></a> --%>
<%-- 				</c:when> --%>
<%-- 				<c:otherwise> --%>
<%-- 					<a href="${contextPath}/T2_tmp/Member/userInfo.do">회원정보변경</a> --%>
<%-- 					<a href="${contextPath}/T2_tmp/Member/logout.do">로그아웃</a> --%>
<%-- 				</c:otherwise> --%>
<%-- 			</c:choose> --%>
<!-- 			<a class="btnBallon" href="javascript:fnLoginBalloon();"></a> -->
			
<!-- 			</li> -->
			<li class="Cart">
				<a href="Order/Cart.html" title="장바구니">			
					<img src="${contextPath}/T2_tmp/Images/Ver1/Common/top_icon_cart.png" />
				</a>
			</li>
			<li class="Search">
				<div class="CommonSearch">
					<input type="text" id="kwd" value=""><a href="javascript:fnCommonSearch(1);"><img src="${contextPath}/T2_tmp/Images/Ver1/Common/top_icon_search.png" /></a>
				</div>
			</li>
		</ul>
		<div class="clear"></div>
	</div>
	</div>
	<div id="CommonHeaderArea"></div>
<div id="CommonHeader_M"></div>
	


	<a class="btn_top" href="javascript:;"><img src="../Images/Ver1/Common/btn_top.png"></a>
	<script type="text/javascript">
		$(document).on("click",".btn_top",function(){ $("html, body").animate({ scrollTop :0},200); });
	</script>
	</header>