<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<head>
<html lang="ko">
<jsp:include page="/Home/inc/head.jsp"/>
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
							<td><a class="SlideLink" href="" target="_self" ><img style=" width:100%; border:0;" src="${contextPath}/Images/Ver1/Common/2021.jpg" /></a></td>
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
							<td bgcolor="#d3e9f6"></td>
							<td><a class="SlideLink" href="" target="_self" ><img style="width:100%; border:0;" src="${contextPath}/Images/Ver1/Common/mind.jpg" /></a></td>
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
							<td bgcolor="#d3e9f6"></td>
							<td><a class="SlideLink" href="" target="_self" ><img style="width:100%; border:0;" src="${contextPath}/Images/Ver1/Common/soso.jpg" /></a></td>
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
							<td bgcolor="#d3e9f6"></td>
							<td><a class="SlideLink" href="" target="_self" ><img style="width:100%; border:0;" src="${contextPath}/Images/Ver1/Common/jaetack.jpg" /></a></td>
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
							<td bgcolor="#d3e9f6"></td>
							<td><a class="SlideLink" href="" target="self" ><img style="border:0; width:100%;" src="${contextPath}/Images/Ver1/Common/seolnal.jpg" /></a></td>
							<td bgcolor="#d3e9f6"></td>
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
	<a class="EventBanner1" href="" style="background-color:#f1d4d7; background-image:url(../Images/Ver1/Common/ban2.jpg);" target="_self"></a>
	<a class="EventBanner2" href="" style="background-image:url(../Images/Ver1/Common/ban1.jpg);" target="_self"></a>
	<div class="clear"></div>
</div>

	<div class="BestItemWrap">
	<a class="BestItemTitle" href="">NEW ITEM</a>
		<div class="BestItemList">
			<ul>
				<c:forEach var="newarr" items="${NewArrivalList}">
					<li>
						<a href="${contextPath}/${newarr.category}/viewContent.do?num=${newarr.num}">
						<span class="ImageBackGround"></span> <img class="ItemImage" src="${contextPath}/download.do?fd=${newarr.category}&num=${newarr.num}&productImageName=${newarr.productImageName1}" />
						</a>
						<span class="ItemName">${newarr.productName }</span>

						<span class="ItemPrice">${newarr.productPrice }원</span>
					</li>
				</c:forEach>
			</ul>

		</div>
	</div>
	<div class="NewArrivalWrap">
	<a class="NewArrivalTitle" href="">BANNER</a>
	<div class="NewArrivalList">
		<a class="NewArrival1" href="#" style="background-image:url(../Images/Ver1/Common/banner1.png);"></a>
		<a class="NewArrival2" href="#" style="background-image:url(../Images/Ver1/Common/banner2.png);"></a>
		<a class="NewArrival3" href="#" style="background-image:url(../Images/Ver1/Common/banner3.png);"></a>
		<div class="clear"></div>
	</div>
</div>
<div class="clear"></div>

	<div class="mnBx funIdea" style="margin-bottom : 50px;">

		<h3 class="mnTitle">FUN & IDEA</h3>

		<div class="funIdeaBn slide" id="funIdeaSlide">
			<ul class="swiper-wrapper">
			
				<li class="swiper-slide">
					<a href="javascript:void(0);"  data-area=D2008001074 data-stock=2008001476 data-cmps=200700000006873 onclick="overpass.tracking.link({  goods_no : 'G20120024203', sale_shop_divi_cd : '10', sale_shop_no : '1312000036', sale_area_no : 'D2008001074', tr_yn : 'Y', conts_form_cd : '100', conts_dist_no : 'G20120024203', conts_divi_cd : '20', rel_no : 'G20120024203', rel_divi_cd : '10', openwinyn : '', disp_ctg_no : '', purch_age_limit_cd : '00'});" >
						<span class="img"><img src="//image.artbox.co.kr/upload/C00001/dspl/banner/70/441/00/210100000006085_210100000006441.jpg" alt="펀앤아이디어_1"></span>
						<span class="txt">
							<strong>여간 힙한 것이 아니랑께</strong>
							<em>2021벽걸이 달력</em>
						</span>
					</a>
				</li>
			
				<li class="swiper-slide">
					<a href="javascript:void(0);"  data-area=D2008001074 data-stock=2008001476 data-cmps=200700000006873 onclick="overpass.tracking.link({  goods_no : '2012080184', sale_shop_divi_cd : '10', sale_shop_no : '1312000036', sale_area_no : 'D2008001074', tr_yn : 'Y', conts_form_cd : '100', conts_dist_no : '2012080184', conts_divi_cd : '20', rel_no : '2012080184', rel_divi_cd : '10', openwinyn : '', disp_ctg_no : '', purch_age_limit_cd : '00'});" >
						<span class="img"><img src="//image.artbox.co.kr/upload/C00001/dspl/banner/70/444/00/210100000006088_210100000006444.jpg" alt="펀앤아이디어_2"></span>
						<span class="txt">
							<strong>꽃과 향기를 그대에게</strong>
							<em>아로마코 드라이플라워 부케꽃디퓨저 (디퓨져오일 15ml 포함)</em>
						</span>
					</a>
				</li>
			
				<li class="swiper-slide">
					<a href="javascript:void(0);"  data-area=D2008001074 data-stock=2008001476 data-cmps=200700000006873 onclick="overpass.tracking.link({  goods_no : '2012140252', sale_shop_divi_cd : '10', sale_shop_no : '1312000036', sale_area_no : 'D2008001074', tr_yn : 'Y', conts_form_cd : '100', conts_dist_no : '2012140252', conts_divi_cd : '20', rel_no : '2012140252', rel_divi_cd : '10', openwinyn : '', disp_ctg_no : '', purch_age_limit_cd : '00'});" >
						<span class="img"><img src="//image.artbox.co.kr/upload/C00001/dspl/banner/70/445/00/210100000006089_210100000006445.jpg" alt="펀앤아이디어_3"></span>
						<span class="txt">
							<strong>다각도로 생각한다면</strong>
							<em>rcube 인비지 데스크 펜</em>
						</span>
					</a>
				</li>
			
				<li class="swiper-slide">
					<a href="javascript:void(0);"  data-area=D2008001074 data-stock=2008001476 data-cmps=200700000006873 onclick="overpass.tracking.link({  goods_no : '2012100015', sale_shop_divi_cd : '10', sale_shop_no : '1312000036', sale_area_no : 'D2008001074', tr_yn : 'Y', conts_form_cd : '100', conts_dist_no : '2012100015', conts_divi_cd : '20', rel_no : '2012100015', rel_divi_cd : '10', openwinyn : '', disp_ctg_no : '', purch_age_limit_cd : '00'});" >
						<span class="img"><img src="//image.artbox.co.kr/upload/C00001/dspl/banner/70/446/00/210100000006090_210100000006446.jpg" alt="펀앤아이디어_4"></span>
						<span class="txt">
							<strong>못 닦을 구석이 없어요!</strong>
							<em>뿌리면서 닦는 청소 브러쉬 4종 SET</em>
						</span>
					</a>
				</li>

			</ul>
		</div>

	</div>

</div>

<jsp:include page="/Home/inc/footer.jsp"/>
</body>
</html>