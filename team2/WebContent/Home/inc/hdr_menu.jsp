<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>	
<c:set var="id" value="${sessionScope.id}"/>
<c:set var="name" value="${sessionScope.name}"/>
<c:set var="memtype" value="${sessionScope.memtype}"/>
<header>	
<script>
	function fnCommonSearch(){
		document.fr.submit();
	}
</script>
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
	<a href="${contextPath}/common/index.do" class="MainLogo"><img src="${contextPath}/Images/Ver1/Common/logo.png" /></a>
	<a href="${contextPath}/common/index.do" class="MainLogoScroll"><img src="${contextPath}/Images/Ver1/Common/logo.png" /></a>
	<div class="CategoryLarge">
		<ul>
			<li class="CategoryMiddle"><a href="${contextPath}/living/list.do">리빙</a></li>
			<li class="CategoryMiddle"><a href="${contextPath}/crafts/list.do">공예</a></li>
			<li class="CategoryMiddle"><a href="#">문구</a></li>
			<li class="CategoryMiddle"><a href="${contextPath}/CsCenter/NoticeList.do">공지사항</a></li>
			<li class="CategoryMiddle"><a href="#">평가받기</a></li>
			
			<li class="Cart">
				<a href="Order/Cart.html" title="장바구니">			
					<img src="${contextPath}/Images/Ver1/Common/top_icon_cart.png" />
				</a>
			</li>
			<li class="Search">
				<form action="${contextPath}/common/search.do" name="fr" method="post">
					<div class="CommonSearch">
						<input type="text" id="kwd" name="kwd">
						<a href="javascript:fnCommonSearch();">
							<img src="${contextPath}/Images/Ver1/Common/top_icon_search.png" />
						</a>
					</div>
				</form>
			</li>
			<c:choose>
				<c:when test="${memtype == 'seller'}">
					<li class="admin">
						<a href="${contextPath}/common/seller.do?shopName=${name}">			
							상점관리페이지
						</a>
					</li>
				</c:when>
			</c:choose>
		</ul>
		<div class="clear"></div>
	</div>
	</div>
	<div id="CommonHeaderArea"></div>
<div id="CommonHeader_M"></div>
	


	<a class="btn_top" href="javascript:;"><img src="${contextPath}/Images/Ver1/Common/btn_top.png"></a>
	<script type="text/javascript">
		$(document).on("click",".btn_top",function(){ $("html, body").animate({ scrollTop :0},200); });
	</script>
	</header>