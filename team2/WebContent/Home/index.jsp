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
							<td><a class="SlideLink" href="" target="_self" ><img style="border:0;" src="${contextPath}/Images/Ver1/Common/house_1.svg" /></a></td>
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
		<a class="BestItemTitle" href="">NEW ITEM</a>
		<div class="BestItemList">
			<ul>
				<c:forEach var="newarr" items="${NewArrivalList}">
					<li>
						<a href="${contextPath}/${newarr.category}/viewContent.do?num=${newarr.num}"></a>
						<span class="ImageBackGround"></span> <img class="ItemImage" src="${contextPath}/download.do?fd=${newarr.category}&num=${newarr.num}&productImageName=${newarr.productImageName1}" />
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
				<a href="#">
					<img style="border-radius:50%;" src="${contextPath}/Images/Ver1/Common/logo.png" />
				</a>
			</div>
		
			<div class="swiper-slide">
				<a href="#">
					<img style="border-radius:50%;" src="${contextPath}/Images/Ver1/Common/logo.png" />
				</a>
			</div>
		
			<div class="swiper-slide">
				<a href="#">
					<img style="border-radius:50%;" src="${contextPath}/Images/Ver1/Common/logo.png" />
				</a>
			</div>
		
			<div class="swiper-slide">
				<a href="#">
					<img style="border-radius:50%;" src="${contextPath}/Images/Ver1/Common/logo.png" />
				</a>
			</div>
		
			<div class="swiper-slide">
				<a href="#">
					<img style="border-radius:50%;" src="${contextPath}/Images/Ver1/Common/logo.png" />
				</a>
			</div>
		
			<div class="swiper-slide">
				<a href="#">
					<img style="border-radius:50%;" src="${contextPath}/Images/Ver1/Common/logo.png" />
				</a>
			</div>
		
			<div class="swiper-slide">
				<a href="#">
					<img style="border-radius:50%;" src="${contextPath}/Images/Ver1/Common/logo.png" />
				</a>
			</div>
		
			<div class="swiper-slide">
				<a href="#">
					<img style="border-radius:50%;" src="${contextPath}/Images/Ver1/Common/logo.png" />
				</a>
			</div>
		
			<div class="swiper-slide">
				<a href="#">
					<img style="border-radius:50%;" src="${contextPath}/Images/Ver1/Common/logo.png" />
				</a>
			</div>
		
			<div class="swiper-slide">
				<a href="#">
					<img style="border-radius:50%;" src="${contextPath}/Images/Ver1/Common/logo.png" />
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