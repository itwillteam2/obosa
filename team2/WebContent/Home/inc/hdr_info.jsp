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
	<a href="${contextPath}/common/index.do" class="MainLogo"><img src="${contextPath}/Images/Ver1/Common/logo.png" /></a>
	<a href="${contextPath}/common/index.do" class="MainLogoScroll"><img src="${contextPath}/Images/Ver1/Common/logo.png" /></a>
			   <div class="CategoryLarge"></div>
		<div class="clear"></div>
	</div>
	<div id="CommonHeaderArea"></div>
<div id="CommonHeader_M"></div>
	
<!-- Mobile -->
	<a class="btn_top" href="javascript:;"><img src="${contextPath}/Images/Ver1/Common/btn_top.png"></a>
	<script type="text/javascript">
		$(document).on("click",".btn_top",function(){ $("html, body").animate({ scrollTop :0},200); });
	</script>
	</header>