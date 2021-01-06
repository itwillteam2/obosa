<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="id" value="${sessionScope.id}"/>
<c:set var="name" value="${sessionScope.name}"/>
<c:set var="memtype" value="${sessionScope.memtype}"/>
<header>
	<div id="CommonHeader">
		<div id="mymenu">
			<c:choose>
				<c:when test="${empty sessionScope.id}">
					<a href="${contextPath}/member/login.do">로그인</a>&nbsp; | &nbsp;
					<a href="${contextPath}/member/join.do">회원가입</a>
				</c:when>
				<c:otherwise>
					<label>환영합니다 ${name}님!</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<a href="${contextPath}/member/userInfoCK.do">회원정보변경</a>&nbsp; | &nbsp;
					<a href="${contextPath}/member/logout.do">로그아웃</a>
				</c:otherwise>
			</c:choose>
		</div>
	
		<a href="${contextPath}/common/index.do" class="MainLogo"><img
			src="${contextPath}/Images/Ver1/Common/logo.png" /></a> <a
			href="${contextPath}/common/index.do" class="MainLogoScroll"><img
			src="${contextPath}/Images/Ver1/Common/logo.png" /></a>
		<div class="clear"></div>
	</div>
</header>