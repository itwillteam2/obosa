<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>	
<c:set var="id" value="${sessionScope.id}"/>
<c:set var="name" value="${sessionScope.name}"/>
<c:set var="memtype" value="${sessionScope.memtype}"/>


<header>
<!-- 네비 메뉴 위에 현재 위치 표시 script-->
<script type="text/javascript">
$(document).ready(
function (){
	var category="${category}";
	$("ul.nav a").each(function(){
		if ($(this).attr("class") == category) {  $(this).parent().addClass('selected'); }
	});


	var didScroll; 
	var ScrollTop = 0;
	var delta=5;
	var CommonHeaderHeight = $("header").outerHeight();

	$(window).scroll(function() { 
		var st = $(this).scrollTop();
		if(Math.abs(ScrollTop - st)<=delta)
			return;
		
		if(st>ScrollTop && st >CommonHeaderHeight){
				$("header").css("height","138px");
				$("#mymenu").css("margin","0 0 0 0");
				$("#CommonHeader .MainLogo").css("display","none");
				$("#CommonHeader .MainLogoScroll").css("display","block");
				$("#CommonHeader .CategoryLarge ul.nav").css("margin","0 0 0 0");
				$("#CommonHeader .CategoryLarge ul.rtMenu").css("margin","0 0 0 0").css("background-color","white").css("opacity","0.8")
				$("#CommonHeader").css("opacity","0.9");
			} else {
				if(st+$(window).height() < $(document).height()) { 
				$("header").css("height","250px")
				$("#mymenu").css("margin","0 0 20px 0");
				$("#CommonHeader .CategoryLarge ul.nav").css("margin","35px 0px 10px 10px");
				$("#CommonHeader .CategoryLarge ul.rtMenu").css("margin","30px 60px 10px 10px");
				$("#CommonHeader .MainLogo").css("display","block");
				$("#CommonHeader .MainLogoScroll").css("display","none");
				$("#CommonHeader").css("opacity","1");
				}
			}
		 lastScrollTop = st;
  		});
	});

//초기 장바구니 내용 개수 가져오기
$(document).ready(function(){
	if("${id}"!=""){
		cartCount();
	}else{
		$("#countCart").css("display","none");
	}
});
	
// 장바구니 내용 개수 가져오기
	function cartCount(){
		var id="${id}";
	 $.post("${contextPath}/cart/countCart.do",
			 {customer_id:"${id}"},
			 function(result){
				$("#countCart").val(result);
			 });
	}		 

	function fnCommonSearch(){
		document.fr.submit();
	}
	function pageMove(category){
		location.href="${contextPath}/category/list.do?category="+category;
	}
	function fnGoCart(){
		if("${id}"!=""){ location.href="${contextPath}/cart/cartList.do?customer_id=${id}"	}
		else{ alert("회원 전용 서비스입니다."); }	
	}

	
	
	
	
</script>
<div id="CommonHeader">
	<div id="mymenu">
			<ul class="personal">
					<c:choose>
				<c:when test="${empty sessionScope.id}">
					<li class="logInfo lt"><a href="${contextPath}/member/join.do">회원가입</a></li>
					<li class="logInfo"><a href="${contextPath}/member/login.do">로그인</a></li>
				</c:when>
				<c:otherwise>
					<li class="logInfo lt"><a href="${contextPath}/member/logout.do">로그아웃</a></li>
					<li id="upper" class="logInfo">환영합니다 ${name}님!
							<ul id = "sub">
								<li><a href="${contextPath}/member/userInfoCK.do">회원정보변경</a></li>
								<li><a href="${contextPath}/member/orderList.do">주문내역</a></li>
							</ul>
						</li>
				</c:otherwise>
			</c:choose>
			</ul>
		</div>
	<a href="${contextPath}/common/index.do" class="MainLogo"><img src="${contextPath}/Images/Ver1/Common/logo.png" /></a>
	<a href="${contextPath}/common/index.do" class="MainLogoScroll"><img src="${contextPath}/Images/Ver1/Common/logo.png" /></a>
	<div class="CategoryLarge">
		<ul class="nav">
		    <li class="tab"></li> <!-- 공간 띄우기  -->
			<li class="CategoryMiddle"><a class="living" href="${contextPath}/living/list.do" >리빙</a></li>
			<li class="CategoryMiddle"><a class="crafts" href="${contextPath}/crafts/list.do" >공예</a></li>
			<li class="CategoryMiddle"><a class="fancy" href="${contextPath}/fancy/list.do" >문구</a></li>
			<li class="CategoryMiddle"><a href="${contextPath}/CsCenter/NoticeList.do" >공지사항</a></li>
			<li class="CategoryMiddle"><a href="#" style="font-size:20px">평가받기</a></li>
		</ul>
		<ul class="rtMenu">
		
			<c:choose>
				<c:when test="${memtype == 'seller'}">
					<li class="admin">
						<a href="${contextPath}/common/seller.do?shopName=${name}">			
							상점관리페이지
						</a>
					</li>
				</c:when>
			</c:choose>
	
			<li class="Cart">
				<a href="javascript:void(0)" onclick="fnGoCart();" title="장바구니">			
					<img src="${contextPath}/Images/Ver1/Common/top_icon_cart.png" />
				</a>
				  <input type="text" id="countCart" value="" readonly>
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
			
		</ul>
		
	</div>
	</div>
	</header>
<div class="CommonHeaderArea"></div>
<div class="clear"></div>	
	