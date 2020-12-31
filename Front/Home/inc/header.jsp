<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<header>	
<div id="CommonHeader">
	<a href="../index.jsp" class="MainLogo"><img src="${contextPath}/Images/Ver1/Common/logo.png" /></a>
	<a href="../index.jsp" class="MainLogoScroll"><img src="${contextPath}/Images/Ver1/Common/logo.png" /></a>
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
			
			<li class="MyPage">
				<a href="../Home/Member/Login.jsp" title="로그인"><img src="${contextPath}/Images/Ver1/Common/avatar.svg" id="MyInfoSummaryIcon" /></a>
				<a href="..Home/Member/Login.jsp" id="LoginBalloon"><div class="test" >..님</div><div class="test"><a href="logout.jsp">로그아웃</a> </div><div class="test"><a href="${contextPath}/Join.jsp">회원관리</a></div></a>
				<a class="btnBallon" href="javascript:fnLoginBalloon();"></a>
			</li>
			<li class="Cart">
				<a href="Order/Cart.html" title="장바구니">			
					<img src="${contextPath}/Images/Ver1/Common/bag.svg" />
				</a>
			</li>
			<li class="Search">
				<div class="CommonSearch">
					<input type="text" id="kwd" value=""><a href="javascript:fnCommonSearch(1);"><img src="../../Images/Ver1/Common/top_icon_search.png" /></a>
				</div>
			</li>
		</ul>
		<div class="clear"></div>
	</div>
	</div>
	<div id="CommonHeaderArea"></div>
	<div id="CommonHeader_M">
		<div id="CommonHeaderMenu_M"></div>
	</div>

	<a class="btn_top" href="javascript:;"><img src="../Images/Ver1/Common/btn_top.png"></a>
	<script type="text/javascript">
		$(document).on("click",".btn_top",function(){ $("html, body").animate({ scrollTop :0},200); });
	</script>
	</header>