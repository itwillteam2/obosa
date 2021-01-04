<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<head>
<html lang="ko">
<jsp:include page="/Home/inc/head.jsp"/>
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
<jsp:include page="/Home/inc/hdr_menu.jsp"/>

<div class="TopRollingPc">
	<div class="swiper-container">
		<div class="swiper-wrapper">

			<div class="swiper-slide">
				<table border="0" cellspacing="0" cellpadding="0" style="width:100%; box-sizing:border-box;">
					<colgroup><col width="*"><col width="1200"><col width="*"></colgroup>
					<tbody>
						<tr>
							<td bgcolor="#d3e9f6"></td>
							<td><a class="SlideLink" href="event/eventcontentse13a.html?EvtID=91374" target="_self" ><img style="border:0;" src="${contextPath}/Images/Ver1/Common/house_1.svg" /></a></td>
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
							<td><a class="SlideLink" href="event/eventcontents3ec6.html?EvtID=91095&amp;cdl=500" target="_self" ><img style="border:0;" src="${contextPath}/Images/Ver1/Common/house_1.svg" /></a></td>
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


		<div class="clear"></div>

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


<jsp:include page="/Home/inc/footer.jsp"/>
</body>
</html>
