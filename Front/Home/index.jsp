<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="ko">

<meta http-equiv="content-type" content="text/html;charset=utf-8" /><!-- /Added by HTTrack -->
<head>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />

<meta http-equiv="Content-Script-Type" content="text/javascript" />
<meta http-equiv="Content-Style-Type" content="text/css" />
<title>SSMarket</title>

<link href="${contextPath}/T2_tmp/Images/Ver1/Icon/icon180.png" rel="apple-touch-icon-precomposed" />

<link rel="stylesheet" type="text/css" href="${contextPath}/T2_tmp/Home/Css/Common/Common.css" />
<link rel="stylesheet" type="text/css" href="${contextPath}/T2_tmp/Home/Css/Common/swiper.min.css" />
<script type="text/javascript" src="${contextPath}/T2_tmp/Home/Js/Common/jquery-1.11.3.min.js"></script>

<script type="text/javascript" src="${contextPath}/T2_tmp/Home/Js/Common/Common.js"></script>

<script type="text/javascript" src="${contextPath}/T2_tmp/Home/Js/Common/swiper_r.min.js"></script>
 
<link rel="stylesheet" type="text/css" href="${contextPath}/T2_tmp/Home/Css/Common/Index.css" />
<link rel="stylesheet" type="text/css" href="${contextPath}/T2_tmp/Home/Css/Common/FlexSliderIndex.css" />
<script type="text/javascript" src="${contextPath}/T2_tmp/Home/Js/Common/jquery.flexslider-min.js" charset="utf-8"></script>
<link rel="stylesheet" type="text/css" href="${contextPath}/T2_tmp/Home/Css/Common/swiper.min.css" />
<script type="text/javascript" src="${contextPath}/T2_tmp/Home/Js/Common/swiper.min.js"></script>
<script type="text/javascript" src="${contextPath}/T2_tmp/Home/Js/Common/jquery.rwdImageMaps.min.js"></script>

<script type="text/javascript" src="${contextPath}/T2_tmp/Home/Js/Common/jquery.bxslider.ABIndex.js"></script>
<script type="text/javascript">
var WinKind;
$(document).ready(function(){

    $('img[usemap]').rwdImageMaps();

	var token = "2993198200.7efd5c1.43f329e4f4704fdc8a28d4b395c2d938";  	   	
	$.ajax({
		type:"get",  
		dataType: "jsonp",  
		cache: false,  
		url: "https://api.instagram.com/v1/users/self/media/recent/?access_token=" + token,
		success: function(response) {
		//console.log(response)
			var instaHtml = "";
			for (var i = 0; i < response.data.length; i++) {
				instaHtml += "<li class=\"num"+(i+1)+"\"><a href=\"" + response.data[i].link + "\" target=\"_blank\" ><div style=\"background-image:url(" + response.data[i].images.standard_resolution.url + ");\"></div></a></li>";
				if (i >= 5) {
					break;
				}
			}
			$("#InstagramListUl").empty().html(instaHtml);

			$("#InstagramListUl > li").css("height",$("#InstagramListUl > li").width());
		}
	});

	$( window ).resize( function() {
		$("#InstagramListUl > li").css("height",$("#InstagramListUl > li").width());
    });

});


</script>
</head>
<body>
<div id="CommonHeader">
	<div id="mymenu">
		<c:choose>
			<c:when test="${empty sessionScope.id}">
				<a href="${contextPath}/member/login.do">로그인</a>&nbsp; | &nbsp;
				<a href="${contextPath}/member/join.do">회원가입</a>
			</c:when>
			<c:otherwise>
				<a href="${contextPath}/member/userInfo.do">회원정보변경</a>&nbsp; | &nbsp;
				<a href="${contextPath}/member/logout.do">로그아웃</a>
			</c:otherwise>
		</c:choose>
	</div>
	<a href="${contextPath}/common/index.do" class="MainLogo"><img src="${contextPath}/T2_tmp/Images/Ver1/Common/logo.png" /></a>

	<a href="i${contextPath}/common/index.do" class="MainLogoScroll"><img src="${contextPath}/T2_tmp/Images/Ver1/Common/logo.png" /></a>
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
			<li class="Cart">
				<a href="${contextPath}/common/cart.do title="장바구니" onclick="GA_event('HEAD', '최상단 메뉴 PC', '장바구니');">
					<img src="${contextPath}/T2_tmp/Images/Ver1/Common/top_icon_cart.png" />
				</a>
			</li>
			<li class="Search">
				<div class="CommonSearch">
					<input type="text" id="kwd" value="" onkeypress="if(event.keyCode==13){fnCommonSearch(1);}" /><a href="javascript:fnCommonSearch(1);" title="검색" onclick="GA_event('HEAD', '최상단 메뉴 PC', '검색');"><img src="${contextPath}/T2_tmp/Images/Ver1/Common/top_icon_search.png" /></a>
				</div>
			</li>
		</ul>
		<div class="clear"></div>
	</div>

</div>

<div id="CommonHeaderArea"></div>
<div id="CommonHeader_M">

</div>

<div class="TopRollingPc">
	<div class="swiper-container">
		<div class="swiper-wrapper">

			<div class="swiper-slide">
				<table border="0" cellspacing="0" cellpadding="0" style="width:100%; box-sizing:border-box;">
					<colgroup><col width="*"><col width="1200"><col width="*"></colgroup>
					<tbody>
						<tr>
							<td bgcolor="#d3e9f6"></td>
							<td><a class="SlideLink" href="event/eventcontentse13a.html?EvtID=91374" target="_self" onclick="GA_event('메인_PC', '상단 롤링', '1_https_/www.artboxmall.com/home/event/eventcontentse13a.html?EvtID=91374');"><img style="border:0;" src="../Upload/DesignMng/poom2012215156588663759c87.jpg?v=v20201221105142" /></a></td>
							<td bgcolor="#d3e9f6"></td>
						</tr>
					</tbody>
				</table>
			</div>
			
			<div class="swiper-slide">
				<table border="0" cellspacing="0" cellpadding="0" style="width:100%; box-sizing:border-box;">
					<colgroup><col width="*"><col width="1200"><col width="*"></colgroup>
					<tbody>
						<tr>
							<td bgcolor="#dfd5f3"></td>
							<td><a class="SlideLink" href="event/eventcontents3ec6.html?EvtID=91095&amp;cdl=500" target="_self" onclick="GA_event('메인_PC', '상단 롤링', '2_https_/www.artboxmall.com/home/event/eventcontents3ec6.html?EvtID=91095&amp;cdl=500');"><img style="border:0;" src="../Upload/DesignMng/poom2012145731037986089c87.jpg?v=v20201221105142" /></a></td>
							<td bgcolor="#dfd5f3"></td>
						</tr>
					</tbody>
				</table>
			</div>
			
		</div>
	
				
			<!-- Add Pagination -->
			<div class="swiper-pagination pagination1"></div>
			<!-- Add Arrows -->
			<div class="swiper-button-prev"></div>
			<div class="swiper-button-next"></div>
		
	</div>
</div>

<script>
	var swiper = new Swiper('.TopRollingPc > .swiper-container', {
		slidesPerView: 1,
		//      spaceBetween: 30,
		loop: true,
		pagination: {
			el: '.pagination1',
			clickable: true,
		},
		navigation: {
			nextEl: '.swiper-button-next',
			prevEl: '.swiper-button-prev',
		},
		autoplay: {
			delay: 4000,
			disableOnInteraction: false,
		},
	});
</script>

<div class="EventBannerWrap">
	<a class="EventBanner1" href="event/eventcontents7265.html?EvtID=89986" style="background-color:#f1d4d7; background-image:url(../Upload/DesignMng/poom2012215195958986089c87.jpg?v=v20201221105142);" target="_self">
		<b>DESIGNER`s DIARY</b>
		아트박스만의 <br />디자이너스 다이어리!
	</a>
	<a class="EventBanner2" href="event/eventcontents7b3b.html?EvtID=90642" style="background-color:#b6e8ff; background-image:url(../Upload/DesignMng/poom2012145748346219319c87.jpg?v=v20201221105142);" target="_self">
		<b>방방곳곳 초크초크</b>
		마르면 안돼요~<br />가습기, 할인가로 겟겟!
	</a>
	<div class="clear"></div>
</div>

<div class="BestItemWrap">
	<a class="BestItemTitle" href="shop/bestaward.html">BEST ITEM<span class="more"></span></a>
	<div class="BestItemList">
		<ul>
		
			<li>
				<a href="Shop/ItemDetail8e89.html?itemidx=2002240137" title="보조배터리 10,000mA 블루보스 (26019221)" onclick="GA_event('메인_PC', 'BEST ITEM', '#1_보조배터리 10,000mA 블루보스 (26019221)'); GA_onclick('메인_PC', '2002240137', '보조배터리 10,000mA 블루보스 (26019221)', '아트박스', '디지털 > 보조배터리/케이블 > 보조배터리', '19900', '#1', '0');">
					<span class="ImageNumber num1">01</span>
					
					<span class="ImageBackGround"></span>
					
					<img class="ItemImage" src="../../www.poom.co.kr/Upload2/Product/202002/2002240137_detail1.jpg" />
					<span class="ItemName">보조배터리 10,000mA 블루보스 (26019221)</span>
					
					<span class="ItemPrice">19,900원</span>
					
					<div class="stampicongroup"><span class="stampicon blank"></span></div>
				</a>
			</li>
		
			<li>
				<a href="Shop/ItemDetail0665.html?itemidx=2011051267" title="2021 다이어리 MY LOVELY DAY (04010495)" onclick="GA_event('메인_PC', 'BEST ITEM', '#2_2021 다이어리 MY LOVELY DAY (04010495)'); GA_onclick('메인_PC', '2011051267', '2021 다이어리 MY LOVELY DAY (04010495)', '아트박스', '디자인문구 > 다이어리/스케줄러 > 2021 다이어리', '12800', '#2', '0');">
					<span class="ImageNumber num2">02</span>
					
					<span class="ImageBackGround"></span>
					
					<img class="ItemImage" src="../../www.poom.co.kr/Upload2/Product/202011/2011051267_detail1.jpg" />
					<span class="ItemName">2021 다이어리 MY LOVELY DAY (04010495)</span>
					
					<span class="ItemPrice">12,800원</span>
					
					<div class="stampicongroup"><span class="stampicon only"></span></div>
				</a>
			</li>
		
			<li>
				<a href="Shop/ItemDetail64d0.html?itemidx=2012020075" title="크리스마스 춤추는 트리모자 (23004032)" onclick="GA_event('메인_PC', 'BEST ITEM', '#3_크리스마스 춤추는 트리모자 (23004032)'); GA_onclick('메인_PC', '2012020075', '크리스마스 춤추는 트리모자 (23004032)', '아트박스', '취미 > FUN/PARTY > 모자/가발', '19900', '#3', '0');">
					<span class="ImageNumber num3">03</span>
					
					<span class="ImageBackGround"></span>
					
					<img class="ItemImage" src="../../www.poom.co.kr/Upload2/Product/202012/2012020075_detail1.jpg" />
					<span class="ItemName">크리스마스 춤추는 트리모자 (23004032)</span>
					
					<span class="ItemPrice">19,900원</span>
					
					<div class="stampicongroup"><span class="stampicon blank"></span></div>
				</a>
			</li>
		
			<li>
				<a href="Shop/ItemDetaile0b1.html?itemidx=1811190177" title="핫팩 개따뜻 20개세트(90g*20개) (34009553)" onclick="GA_event('메인_PC', 'BEST ITEM', '#4_핫팩 개따뜻 20개세트(90g*20개) (34009553)'); GA_onclick('메인_PC', '1811190177', '핫팩 개따뜻 20개세트(90g*20개) (34009553)', '아트박스', '디자인문구 > 개인/시즌소품 > 핫팩', '12900', '#4', '0');">
					<span class="ImageNumber num4">04</span>
					
					<span class="ImageBackGround"></span>
					
					<img class="ItemImage" src="../../www.poom.co.kr/Upload2/Product/201811/1811190177_detail1.jpg" />
					<span class="ItemName">핫팩 개따뜻 20개세트(90g*20개) (34009553)</span>
					
					<span class="ItemPrice">12,900원</span>
					
					<div class="stampicongroup"><span class="stampicon blank"></span></div>
				</a>
			</li>
		
			<li>
				<a href="Shop/ItemDetail11b1.html?itemidx=2011260248" title="2021 다이어리 6공 곰 (04010474)" onclick="GA_event('메인_PC', 'BEST ITEM', '#5_2021 다이어리 6공 곰 (04010474)'); GA_onclick('메인_PC', '2011260248', '2021 다이어리 6공 곰 (04010474)', '아트박스', '디자인문구 > 다이어리/스케줄러 > 2021 다이어리', '14800', '#5', '0');">
					<span class="ImageNumber num5">05</span>
					
					<span class="ImageBackGround"></span>
					
					<img class="ItemImage" src="../../www.poom.co.kr/Upload2/Product/202011/2011260248_detail1.jpg" />
					<span class="ItemName">2021 다이어리 6공 곰 (04010474)</span>
					
					<span class="ItemPrice">14,800원</span>
					
					<div class="stampicongroup"><span class="stampicon only"></span></div>
				</a>
			</li>
		
			<li>
				<a href="Shop/ItemDetail6fc5.html?itemidx=2011230103" title="무릎담요 옐로우 말리 극세사담요 중 (34010413)" onclick="GA_event('메인_PC', 'BEST ITEM', '#6_무릎담요 옐로우 말리 극세사담요 중 (34010413)'); GA_onclick('메인_PC', '2011230103', '무릎담요 옐로우 말리 극세사담요 중 (34010413)', '아트박스', '패브릭/생활 > 패브릭소품 > 담요/블랭킷', '9900', '#6', '20');">
					<span class="ImageNumber num6">06</span>
					
					<span class="ImageBackGround"></span>
					
					<img class="ItemImage" src="../../www.poom.co.kr/Upload2/Product/202011/2011230103_detail1.jpg" />
					<span class="ItemName">무릎담요 옐로우 말리 극세사담요 중 (34010413)</span>
					
					<span class="ItemPrice red">7,920원 [20%]</span>
					
					<div class="stampicongroup"><span class="stampicon coupon"></span></div>
				</a>
			</li>
		
			<li>
				<a href="Shop/ItemDetail74b7.html?itemidx=2010151035" title="2021 다이어리 6공 레인보우 바비숑 글리터 A5 (04010467)" onclick="GA_event('메인_PC', 'BEST ITEM', '#7_2021 다이어리 6공 레인보우 바비숑 글리터 A5 (04010467)'); GA_onclick('메인_PC', '2010151035', '2021 다이어리 6공 레인보우 바비숑 글리터 A5 (04010467)', '아트박스', '디자인문구 > 다이어리/스케줄러 > 2021 다이어리', '17800', '#7', '10');">
					<span class="ImageNumber num7">07</span>
					
					<span class="ImageBackGround"></span>
					
					<img class="ItemImage" src="../../www.poom.co.kr/Upload2/Product/202011/2010151035_detail1.jpg" />
					<span class="ItemName">2021 다이어리 6공 레인보우 바비숑 글리터 A5 (04010467)</span>
					
					<span class="ItemPrice red">16,020원 [10%]</span>
					
					<div class="stampicongroup"><span class="stampicon coupon"></span><span class="stampicon only"></span></div>
				</a>
			</li>
		
			<li>
				<a href="Shop/ItemDetail87be.html?itemidx=2010201458" title="2021 캘린더 퍼플멍뭉 소 탁상달력 (04010401)" onclick="GA_event('메인_PC', 'BEST ITEM', '#8_2021 캘린더 퍼플멍뭉 소 탁상달력 (04010401)'); GA_onclick('메인_PC', '2010201458', '2021 캘린더 퍼플멍뭉 소 탁상달력 (04010401)', '아트박스', '디자인문구 > 다이어리/스케줄러 > 캘린더', '3800', '#8', '0');">
					<span class="ImageNumber num8">08</span>
					
					<span class="ImageBackGround"></span>
					
					<img class="ItemImage" src="../../www.poom.co.kr/Upload2/Product/202010/2010201458_detail1.jpg" />
					<span class="ItemName">2021 캘린더 퍼플멍뭉 소 탁상달력 (04010401)</span>
					
					<span class="ItemPrice">3,800원</span>
					
					<div class="stampicongroup"><span class="stampicon blank"></span></div>
				</a>
			</li>
		
			<li>
				<a href="Shop/ItemDetail0072.html?itemidx=2010210796" title="2021 다이어리 비밀의 정원 그라데이션 (04010469)" onclick="GA_event('메인_PC', 'BEST ITEM', '#9_2021 다이어리 비밀의 정원 그라데이션 (04010469)'); GA_onclick('메인_PC', '2010210796', '2021 다이어리 비밀의 정원 그라데이션 (04010469)', '아트박스', '디자인문구 > 다이어리/스케줄러 > 2021 다이어리', '11800', '#9', '10');">
					<span class="ImageNumber num9">09</span>
					
					<span class="ImageBackGround"></span>
					
					<img class="ItemImage" src="../../www.poom.co.kr/Upload2/Product/202011/2010210796_detail1.jpg" />
					<span class="ItemName">2021 다이어리 비밀의 정원 그라데이션 (04010469)</span>
					
					<span class="ItemPrice red">10,620원 [10%]</span>
					
					<div class="stampicongroup"><span class="stampicon coupon"></span><span class="stampicon only"></span></div>
				</a>
			</li>
		
			<li>
				<a href="Shop/ItemDetailaafc.html?itemidx=1911110584" title="말하는 인형 플라밍고/펠리칸/앵무새/원숭이" onclick="GA_event('메인_PC', 'BEST ITEM', '#10_말하는 인형 플라밍고/펠리칸/앵무새/원숭이'); GA_onclick('메인_PC', '1911110584', '말하는 인형 플라밍고/펠리칸/앵무새/원숭이', '아트박스', '취미 > 장난감/교육완구 > 작동완구', '19800', '#10', '0');">
					<span class="ImageNumber num10">10</span>
					
					<span class="ImageBackGround"></span>
					
					<img class="ItemImage" src="../../www.poom.co.kr/Upload/Temp/Product/ffpoompreview191111647680454264.jpg" />
					<span class="ItemName">말하는 인형 플라밍고/펠리칸/앵무새/원숭이</span>
					
					<span class="ItemPrice">19,800원</span>
					
					<div class="stampicongroup"><span class="stampicon blank"></span></div>
				</a>
			</li>
		
		</ul>
		<div class="clear"></div>
	</div>
</div>

<div class="NewArrivalWrap">
	<a class="NewArrivalTitle" href="shop/newarrival.html" onclick="GA_event('메인_PC', 'NEW ARRIVAL', 'NEW ARRIVAL');">NEW ARRIVAL<span class="more"></span></a>
	<div class="NewArrivalList">
		<a class="NewArrival1" href="shop/itemdetail6956.html?itemidx=2012070309" target="_self" style="background-color:#faf5bb; background-image:url(../Upload/DesignMng/poom2012214451339219219c87.jpg?v=v20201221105142);" onclick="GA_event('메인', 'NEW_ARRIVAL', '#1_https://www.artboxmall.com/home/shop/itemdetail.asp?itemidx=2012070309');">
			<b>꽃다운 방역생활</b>참 마스크스트랩 (3 Types)
		</a>
		<a class="NewArrival2" href="shop/itemdetailc333.html?itemidx=2012170238" target="_self" style="background-color:#e8f9b8; background-image:url(../Upload/DesignMng/poom2012144261795653659c87.jpg?v=v20201221105142);" onclick="GA_event('메인', 'NEW_ARRIVAL', '#2_https://www.artboxmall.com/home/shop/itemdetail.asp?itemidx=2012170238');">
			<b>산타보다 핵인싸!</b>춤추는 트리모자 (2 Types)
		</a>
		<a class="NewArrival3" href="shop/itemdetaild1fe.html?itemidx=2012020285" target="_self" style="background-color:#ffe1e0; background-image:url(../Upload/DesignMng/poom2012214448483320429c87.jpg?v=v20201221105142);" onclick="GA_event('메인_PC', 'NEW_ARRIVAL', '#3_https://www.artboxmall.com/home/shop/itemdetail.asp?itemidx=2012020285');">
			<b>뽀글뽀글 함께 하숑</b>아이보리비숑 뽀글이 크로스백 (2 Colors)
		</a>
		<div class="clear"></div>
		<a class="NewArrival3_M" href="shop/itemdetaild1fe.html?itemidx=2012020285" target="_self" style="background-color:#ffe1e0; background-image:url(../Upload/DesignMng/poom2012214448831229319c87.jpg?v=v20201221105142);" onclick="GA_event('메인_MO', 'NEW_ARRIVAL', '#3_https://www.artboxmall.com/home/shop/itemdetail.asp?itemidx=2012020285');">
			<b>뽀글뽀글 함께 하숑</b>아이보리비숑 뽀글이 크로스백 (2 Colors)
		</a>
	</div>
</div>

<div class="EventProductWrap" style="background-color:#ffd2d2";>
	<a class="EventProductImage" href="Shop/Categoryd46e.html?kwd=%EB%AC%B8%EB%8B%B5" target="_self" onclick="GA_event('메인_PC', '키워드 카테고리', 'Shop/Categoryd46e.html?kwd=%EB%AC%B8%EB%8B%B5');"><img src="../Upload/DesignMng/poom201221538723007199c87.jpg?v=v20201221105142" /></a>
	<div class="EventProductList">
		<ul>
		
			<li>
				<a href="Shop/ItemDetailc4d9.html?itemidx=2011130544" title="커플문답 연애정복 기출문제집 기본편 (26020806)" onclick="GA_event('메인_PC', '키워드 카테고리', '#1_커플문답 연애정복 기출문제집 기본편 (26020806)'); GA_onclick('메인_PC', '2011130544', '커플문답 연애정복 기출문제집 기본편 (26020806)', '아트박스', '디자인문구 > 노트/메모지 > 유선노트', '5000', '#1', '0');">
					<img class="ItemImage" src="../../www.poom.co.kr/Upload2/Product/202011/2011130544_detail1.jpg" />
					<span class="ItemName">커플문답 연애정복 기출문제집 기본편 (26020806)</span>
					
					<span class="ItemPrice">5,000원</span>
					
					<div class="stampicongroup"><span class="stampicon blank"></span></div>
				</a>
			</li>
		
			<li>
				<a href="Shop/ItemDetail956e.html?itemidx=2008210099" title="꽁냥꽁냥 커플문답책 (26020569)" onclick="GA_event('메인_PC', '키워드 카테고리', '#2_꽁냥꽁냥 커플문답책 (26020569)'); GA_onclick('메인_PC', '2008210099', '꽁냥꽁냥 커플문답책 (26020569)', '아트박스', '디자인문구 > 노트/메모지 > 기능성노트', '7800', '#2', '0');">
					<img class="ItemImage" src="../../www.poom.co.kr/Upload2/Product/202008/2008210099_detail1.jpg" />
					<span class="ItemName">꽁냥꽁냥 커플문답책 (26020569)</span>
					
					<span class="ItemPrice">7,800원</span>
					
					<div class="stampicongroup"><span class="stampicon blank"></span></div>
				</a>
			</li>
		
			<li>
				<a href="Shop/ItemDetail5715.html?itemidx=2011230342" title="연애고사 심화편 (26020807)" onclick="GA_event('메인_PC', '키워드 카테고리', '#3_연애고사 심화편 (26020807)'); GA_onclick('메인_PC', '2011230342', '연애고사 심화편 (26020807)', '아트박스', '디자인문구 > 노트/메모지 > 기능성노트', '5000', '#3', '0');">
					<img class="ItemImage" src="../../www.poom.co.kr/Upload2/Product/202011/2011230342_detail1.jpg" />
					<span class="ItemName">연애고사 심화편 (26020807)</span>
					
					<span class="ItemPrice">5,000원</span>
					
					<div class="stampicongroup"><span class="stampicon blank"></span></div>
				</a>
			</li>
		
			<li>
				<a href="Shop/ItemDetaild8c5.html?itemidx=2011230354" title="감사의 마음 자녀문답 (26020809)" onclick="GA_event('메인_PC', '키워드 카테고리', '#4_감사의 마음 자녀문답 (26020809)'); GA_onclick('메인_PC', '2011230354', '감사의 마음 자녀문답 (26020809)', '아트박스', '디자인문구 > 노트/메모지 > 기능성노트', '5000', '#4', '0');">
					<img class="ItemImage" src="../../www.poom.co.kr/Upload2/Product/202011/2011230354_detail1.jpg" />
					<span class="ItemName">감사의 마음 자녀문답 (26020809)</span>
					
					<span class="ItemPrice">5,000원</span>
					
					<div class="stampicongroup"><span class="stampicon blank"></span></div>
				</a>
			</li>
		
			<li>
				<a href="Shop/ItemDetail1c53.html?itemidx=2011160374" title="[빌럽어스] 티키타카 상황문답 1+1 (51010389)" onclick="GA_event('메인_PC', '키워드 카테고리', '#5_[빌럽어스] 티키타카 상황문답 1+1 (51010389)'); GA_onclick('메인_PC', '2011160374', '[빌럽어스] 티키타카 상황문답 1+1 (51010389)', '아트박스X품', '디자인문구 > 노트/메모지 > 기능성노트', '12800', '#5', '0');">
					<img class="ItemImage" src="../../www.poom.co.kr/Upload2/Product/202011/2011160374_detail1.jpg" />
					<span class="ItemName">[빌럽어스] 티키타카 상황문답 1+1 (51010389)</span>
					
					<span class="ItemPrice">12,800원</span>
					
					<div class="stampicongroup"><span class="stampicon blank"></span></div>
				</a>
			</li>
		
		</ul>
		<div class="clear"></div>
	</div>
</div>

<div class="DesignFinderWrapPc">
	<div class="DesignFinderTitle">
		<ul>
			<li class="left">&lt;</li>
			<li class="center"><b>DESIGN FINDER</b></li>
			<li class="right">&gt;</li>
		</ul>
		<div class="clear"></div>
	</div>
	<div class="swiper-container" style="margin:17px 0 0 0;">
		<div class="swiper-wrapper">
		
			<div class="swiper-slide">
				<a href="Shop/ItemDetail58e5.html?itemidx=2012070226" title="2012070226" target="_blank" onclick="GA_event('메인_PC', 'DESIGN FINDER', '#1_2012070226');">
					<img style="border-radius:50%;" src="../Upload/DesignMng/poom201223600681921931.jpg" />
				</a>
			</div>
		
			<div class="swiper-slide">
				<a href="Shop/ItemDetail4940.html?itemidx=2010300461" title="2010300461" target="_self" onclick="GA_event('메인_PC', 'DESIGN FINDER', '#2_2010300461');">
					<img style="border-radius:50%;" src="../Upload/DesignMng/poom201214446491844153.jpg" />
				</a>
			</div>
		
			<div class="swiper-slide">
				<a href="Shop/ItemDetail981c.html?itemidx=2011130689" title="2011130689" target="_self" onclick="GA_event('메인_PC', 'DESIGN FINDER', '#3_2011130689');">
					<img style="border-radius:50%;" src="../Upload/DesignMng/poom201214446582221931.jpg" />
				</a>
			</div>
		
			<div class="swiper-slide">
				<a href="Shop/ItemDetailb88b.html?itemidx=2011230105" title="2011230105" target="_self" onclick="GA_event('메인_PC', 'DESIGN FINDER', '#4_2011230105');">
					<img style="border-radius:50%;" src="../Upload/DesignMng/poom201214446679332042.jpg" />
				</a>
			</div>
		
			<div class="swiper-slide">
				<a href="Shop/ItemDetail6956-2.html?itemidx=2012070309" title="2012070309" target="_self" onclick="GA_event('메인_PC', 'DESIGN FINDER', '#5_2012070309');">
					<img style="border-radius:50%;" src="../Upload/DesignMng/poom201214446868110820.jpg" />
				</a>
			</div>
		
			<div class="swiper-slide">
				<a href="Shop/ItemDetail11b1.html?itemidx=2011260248" title="2011260248" target="_self" onclick="GA_event('메인_PC', 'DESIGN FINDER', '#6_2011260248');">
					<img style="border-radius:50%;" src="../Upload/DesignMng/poom201223600773421931.jpg" />
				</a>
			</div>
		
			<div class="swiper-slide">
				<a href="Shop/ItemDetail15f0.html?itemidx=2012020321" title="2012020321" target="_self" onclick="GA_event('메인_PC', 'DESIGN FINDER', '#7_2012020321');">
					<img style="border-radius:50%;" src="../Upload/DesignMng/poom201214447146443153.jpg" />
				</a>
			</div>
		
			<div class="swiper-slide">
				<a href="Shop/ItemDetailbe9c.html?itemidx=2012020315" title="2012020315" target="_self" onclick="GA_event('메인_PC', 'DESIGN FINDER', '#8_2012020315');">
					<img style="border-radius:50%;" src="../Upload/DesignMng/poom201214447246898608.jpg" />
				</a>
			</div>
		
			<div class="swiper-slide">
				<a href="Shop/ItemDetailc26c.html?itemidx=2012020343" title="2012020343" target="_self" onclick="GA_event('메인_PC', 'DESIGN FINDER', '#9_2012020343');">
					<img style="border-radius:50%;" src="../Upload/DesignMng/poom201214447386398608.jpg" />
				</a>
			</div>
		
			<div class="swiper-slide">
				<a href="Shop/ItemDetail0e9b.html?itemidx=2012020339" title="2012020339" target="_self" onclick="GA_event('메인_PC', 'DESIGN FINDER', '#10_2012020339');">
					<img style="border-radius:50%;" src="../Upload/DesignMng/poom201214447607209709.jpg" />
				</a>
			</div>
		
		</div>

	</div>
</div>

<script>

	var swiper = new Swiper('.DesignFinderWrapPc > .swiper-container', {
		slidesPerView: 7,
		spaceBetween: 30,
//		centeredSlides: true,
		loop: true,
		navigation: {
			nextEl: '.right',
			prevEl: '.left',
		},
		autoplay: {
			delay: 4000,
			disableOnInteraction: false,
		},
	});
</script>

<div class="InstagramEventWrap">
	<div class="InstagramList">
		<div class="InstagramEventTitle">INSTAGRAM&nbsp;<a href="https://www.instagram.com/artbox_kr_official/" target="_blank" onclick="GA_event('메인', 'INSTAGRAM', 'INSTAGRAM');">@artbox_kr_official</a></div>
			<!-- ul id="InstagramListUl"></ul -->
						
			<ul>
				<li class="num1"><a href="https://www.instagram.com/p/CIC3iGMnUDF" target="_blank" ><img src="../../scontent-ssn1-1.cdninstagram.com/v/t51.2885-15/sh0.08/e35/s640x640/127185132_498983317746426_1967210419633212971_ne098.jpg?_nc_ht=scontent-ssn1-1.cdninstagram.com&amp;_nc_cat=106&amp;_nc_ohc=j3YXkaKYl0sAX_tj2-s&amp;tp=1&amp;oh=107fa44402a3b2cbd16e9fce251e4ce7&amp;oe=5FE95D1C" /></a></li>
				<li class="num2"><a href="https://www.instagram.com/p/CIASziRBlFT" target="_blank" ><img src="../../scontent-ssn1-1.cdninstagram.com/v/t51.2885-15/sh0.08/e35/s640x640/127179987_964497727411756_7643917984820228069_n2768.jpg?_nc_ht=scontent-ssn1-1.cdninstagram.com&amp;_nc_cat=104&amp;_nc_ohc=ZVZF7Ohp_5MAX8v8d7H&amp;tp=1&amp;oh=11167d75aff4adfa3db2334cbae381f3&amp;oe=5FE85F46" /></a></li>
				<li class="num3"><a href="https://www.instagram.com/p/CH9t9-kn82q" target="_blank" ><img src="../../scontent-ssn1-1.cdninstagram.com/v/t51.2885-15/sh0.08/e35/s640x640/126899874_1343772935967955_3342050872195084812_nb569.jpg?_nc_ht=scontent-ssn1-1.cdninstagram.com&amp;_nc_cat=107&amp;_nc_ohc=YxtqRa1hUp4AX-SDuCs&amp;tp=1&amp;oh=ba105a94e07f12475b9497d875ec7ad9&amp;oe=5FE94D7E" /></a></li>
				<li class="num4"><a href="https://www.instagram.com/p/CH7JOWMJJUw" target="_blank" ><img src="../../scontent-ssn1-1.cdninstagram.com/v/t51.2885-15/sh0.08/e35/s640x640/126306997_994758011015279_6754929408948217078_n6442.jpg?_nc_ht=scontent-ssn1-1.cdninstagram.com&amp;_nc_cat=111&amp;_nc_ohc=jPfrpf1oy-sAX-XL106&amp;tp=1&amp;oh=37062b3ee5d49091e2fcc96d001269d6&amp;oe=5FEACFD7" /></a></li>
				<li class="num5"><a href="https://www.instagram.com/p/CHw19sBlrDN" target="_blank" ><img src="../../scontent-ssn1-1.cdninstagram.com/v/t51.2885-15/sh0.08/e35/s640x640/125780254_1495228634001610_6460205359568476577_n4577.jpg?_nc_ht=scontent-ssn1-1.cdninstagram.com&amp;_nc_cat=110&amp;_nc_ohc=KdeSiuHFoywAX-4msJJ&amp;tp=1&amp;oh=5b32a9c9dba63a43b4f7f8193ecb527a&amp;oe=5FE7D832" /></a></li>
				<li class="num6"><a href="https://www.instagram.com/p/CHrsaS0Bx4E" target="_blank" ><img src="../../scontent-ssn1-1.cdninstagram.com/v/t51.2885-15/sh0.08/e35/s640x640/125480492_742296923161913_4502440473476514507_nf2dd.jpg?_nc_ht=scontent-ssn1-1.cdninstagram.com&amp;_nc_cat=105&amp;_nc_ohc=a7L76VOEtzMAX-K5ce7&amp;tp=1&amp;oh=d6be4b292126ac89c37ecbff23285d47&amp;oe=5FE8A033" /></a></li>
			</ul>
			
		<div class="clear"></div>
	</div>
	<style>

		.EventWrapBack .SlideBox	{ width: 240px; height: 380px; background-color: #ffffff; margin: 0 auto; padding: 7px; }
		.EventWrapBack .SlideBox p { margin: 0; padding: 13px 0 0 0; font-size: 15px; line-height: 22px; color: #000000; text-align: center; }
		.EventWrapBack .SlideLink { display: block; width: 226px; height: 293px; margin: 0; }
		.EventWrapBack .SlideLink img { width: 226px; height: 293px; }

		.EventWrapBack .swiper-button-prev { width: 40px; height: 77px; background-size: 40px 77px; background-image: url(../Images/Ver1/Common/slide_arrow_left.png); }
		.EventWrapBack .swiper-button-next { width: 40px; height: 77px; background-size: 40px 77px; background-image: url(../Images/Ver1/Common/slide_arrow_right.png); }
		.EventWrapBack .swiper-pagination { position:relative; }
		.EventWrapBack .swiper-pagination-bullet { margin:0 2px; background: url(../Images/Ver1/Company/AboutArtbox/bulletdark_off.png) no-repeat center; }
		.EventWrapBack .swiper-pagination-bullet.swiper-pagination-bullet-active { background: url(../Images/Ver1/Company/AboutArtbox/bulletdark_on.png) no-repeat center; }

		.EventWrap_M .swiper-pagination-bullet { background: url(../Images/Ver1/Company/AboutArtbox/bulletdark_off.png) no-repeat center; }
		.EventWrap_M .swiper-pagination-bullet.swiper-pagination-bullet-active { background: url(../Images/Ver1/Company/AboutArtbox/bulletdark_on.png) no-repeat center; }
	</style>
	<div class="EventWrap">
		<div class="InstagramEventTitle">EVENT</div>
		<div class="EventWrapBack" style="position:relative;">
			<div class="swiper-container">
				<div class="swiper-wrapper">
				
					<div class="swiper-slide">
						<div class="SlideBox">
							<a class="SlideLink" href="https://www.poom.co.kr/Home/Event/Culturetour/MyHouse.asp" target="_blank" title="도서 <결혼은 모르겠고 내 집은 있습니다> 증정" onclick="GA_event('메인_PC', 'EVENT', '#1_도서 <결혼은 모르겠고 내 집은 있습니다> 증정');"><img src="../Upload/DesignMng/poom2012173747541764869c87.jpg?v=v20201221105142" /></a>
							<p>이벤트 기간<br />2020.12.17 - 2020.12.30</p>
						</div>
					</div>
				
				</div>
			</div>
			
		</div>
	</div>
	<div class="clear"></div>
	</div>
</div>
<script>


</script>


<div class="IndexThreeBannerWrap">
	<div class="Banner1Wrap">
		<a class="Banner1" href="${contextPath}/T2_tmp/Home/company/ArtboxMembership.html" onclick="GA_event('메인_MO', '하단 배너', '#멤버쉽');">
			<h1>ARTBOX MEMBERSHIP</h1>
			<h2>할인에 적립까지-<br />아트박스의 모든 브랜드 혜택을 한 번에!</h2>
			<h3>아트박스 통합 멤버십, 지금 바로 가입하세요~</h3>
		</a>
	</div>
	<div class="Banner2Wrap">
		<a class="Banner2" href="${contextPath}/T2_tmp/Home/company/Wallpaper.html" style="background-image:url(../Images/Ver1/Common/wallpaper.jpg);">
			<h1>WALL PAPER</h1>
			<h2><span class="ios" onclick="GA_event('메인_MO', '하단 배너', '#월페이퍼_IOS');"></span><span class="android" onclick="GA_event('메인_MO', '하단 배너', '#월페이퍼_ANDROID');"></span><span class="desktop" onclick="GA_event('메인_MO', '하단 배너', '#월페이퍼_DESKTOP');"></span></h2>
		</a>
	</div>
	<div class="Banner3Wrap">
		<a class="Banner3" href="${contextPath}/T2_tmp/Home/company/offlinestore.html" onclick="GA_event('메인_MO', '하단 배너', '#오프라인 스토어');">
			<h1>ARTBOX<br />OFFLINE<span class="pc">&nbsp;</span><span class="mobile"><br /></span>STORE</h1>
		</a>
	</div>

	<div class="clear"></div>
</div>


<script>
	setTimeout(function(){ 
		$(".Banner2").css("background-image", "url('../Images/Ver1/Company/WallPaper/2020.12-thumb.jpg')");
		$(".Banner2Wrap").css("background-color", "#f9f5ee");		
	}, 500);
</script>


<div id="CommonFooter">
	<div class="FooterMenu">
		<ul>
			<li class="FooterLink"><a href="${contextPath}/T2_tmp/Home/company/index.html" target="_blank" onclick="GA_event('FOOT', '최하단 메뉴 PC', '회사소개');">회사소개</a></li>
			<li class="FooterLink"><a href="http://recruit.artbox.co.kr/" target="_blank" onclick="GA_event('FOOT', '최하단 메뉴 PC', '인재채용');">인재채용</a></li>
			<li class="FooterLink"><a href="${contextPath}/T2_tmp/Home/company/UserAgreement.html" onclick="GA_event('FOOT', '최하단 메뉴 PC', '이용약관');">이용약관</a></li>
			<li class="FooterLink"><a href="${contextPath}/T2_tmp/Home/company/Privacy.html" class="privacy" onclick="GA_event('FOOT', '최하단 메뉴 PC', '개인정보취급방침');">개인정보취급방침</a></li>
			<li class="FooterLink"><a href="${contextPath}/T2_tmp/Home/company/EmailDeny.html" onclick="GA_event('FOOT', '최하단 메뉴 PC', '이메일주소무단수집거부');">이메일주소무단수집거부</a></li>
			<li class="FooterLink"><a href="${contextPath}/T2_tmp/Home/company/OpenBiz.html" onclick="GA_event('FOOT', '최하단 메뉴 PC', '입점문의');">입점문의</a></li>
			<li class="FooterLink"><a href="${contextPath}/T2_tmp/Home/company/LargeBuy.html" onclick="GA_event('FOOT', '최하단 메뉴 PC', '대량구매');">대량구매</a></li>
			<li class="FamilySite">
				<select title="패밀리 사이트" onchange="if(this.value){window.open(this.value,'_blank');this[0].selected=true;}">
					<option value="">FAMILY SITE</option>
					<option value="http://www.poom.co.kr/">POOM</option>
				</select>
			</li>
			<li class="Facebook">
				<a href="https://www.facebook.com/artbox.kr.official/" target="_blank" title="페이스북" onclick="GA_event('FOOT', '최하단 메뉴 PC', '페이스북');"><img src="../Images/Ver1/Common/facebook.png" /></a>
			</li>
			<li class="Instagram">
				<a href="https://www.instagram.com/artbox_kr_official/" target="_blank" title="인스타그램" onclick="GA_event('FOOT', '최하단 메뉴 PC', '인스타그램');"><img src="../Images/Ver1/Common/instagram.png" /></a>
			</li>
			<li class="Youtube">
				<a href="https://www.youtube.com/channel/UC-3Ys0zhdyTe1x6wLiokAMg/" target="_blank" title="유튜브" onclick="GA_event('FOOT', '최하단 메뉴 PC', '유튜브');"><img src="../Images/Ver1/Common/youtube.png" /></a>
			</li>
		</ul>
		<div class="clear"></div>
	</div>
	<div class="FooterInfo">
		<ul>
			<a href="${contextPath}/T2_tmp/Home/Cscenter/NoticeList.html" onclick="GA_event('FOOT', '최하단 메뉴 PC', '공지사항');"><li class="CallCenter">
				<b class="string">고객감동센터</b>
				<b class="number">1577-9081</b>
				운영시간 09:00 - 18:00, 점심시간 12:30 - 13:30
				<small>*주말 및 공휴일은 1:1 문의/상담을 이용해주세요.</small>
			</li></a>
			<li class="TwoButton">
				<a href="${contextPath}/T2_tmp/Home/Cscenter/FaqList.html" onclick="GA_event('FOOT', '최하단 메뉴 PC', '자주하는 질문');"><img src="${contextPath}/T2_tmp/Images/Ver1/Common/footer_btn1.png" />자주하는 질문</a><a href="${contextPath}/T2_tmp/Home/Cscenter/Enquiry.html" onclick="GA_event('FOOT', '최하단 메뉴 PC', '1:1 문의/상담');"><img src="${contextPath}/T2_tmp/Images/Ver1/Common/footer_btn2.png" />1:1 문의/상담</a>
			</li>
			<li class="Information">
				<big>(주)아트박스</big><br />
				(06653) 서울특별시 서초구 반포대로 12길 41&nbsp;&nbsp;대표이사 : 조석현&nbsp;&nbsp;사업자등록번호 214-81-06825&nbsp;&nbsp;<a style="color:#5f5f5f; font-weight:bold; letter-spacing:-1px;" href="javascript:fnBizInfo();" onclick="GA_event('FOOT', '최하단 메뉴 PC', '사업자정보확인');">사업자정보확인&gt;</a><br />
				통신판매업신고 제 2011-서울서초-0404호&nbsp;&nbsp;개인정보 책임자 : 정연규&nbsp;&nbsp;호스팅제공자 : (주)아트박스<br />
				E-MAIL: customer@poom.co.kr<br /><br />
				<!--a class="BizInfo" href="javascript:fnBizInfo();">사업자 정보 확인</a-->
				COPYRIGHT &copy; 2011 ARTBOX CO., LTD ALL RIGHTS RESERVED.
			</li>
		</ul>
		<div class="clear"></div>
	</div>
</div>

<script type="text/javascript" src="../../wcs.naver.net/wcslog.js"></script> 

<span itemscope="" itemtype="https://schema.org/Organization">
<link itemprop="url" href="https://www.artboxmall.com/"><a itemprop="sameAs" href="https://www.youtube.com/channel/UC-3Ys0zhdyTe1x6wLiokAMg"></a><a itemprop="sameAs" href="https://www.instagram.com/artbox_kr_official/"></a><a itemprop="sameAs" href="https://play.google.com/store/apps/details?id=com.artbox.membership"></a><a itemprop="sameAs" href="https://itunes.apple.com/app/id1190223635"></a><a itemprop="sameAs" href="https://www.facebook.com/artbox.kr.official/"></a></span>

</body>
</html>
