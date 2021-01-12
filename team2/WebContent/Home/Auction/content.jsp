<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	request.setCharacterEncoding("utf-8");
	String num = request.getParameter("num");
%>

<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />

<!DOCTYPE html>
<html lang="ko">
<head>
<jsp:include page="/Home/inc/head.jsp"/>
<link rel="stylesheet" type="text/css" href="${contextPath}/Home/Css/Shop/ItemDetail.css">
<link rel="stylesheet" type="text/css" href="${contextPath}/Home/Css/Shop/ScrollBar.css"/>
<link rel="stylesheet" type="text/css" href="${contextPath}/Home/Css/bootstrap/bootstrap.css"/>

<script type="text/javascript">

$(window).load(function(){
	$(".item_content_bar>.inner").sticky({ topSpacing:13.3});
});
	$(document).ready(
			function() {
				$("#CommonHeader").css("z-index", "99998");

				$(".item_content").each(function() {
					$(this).find("iframe").css("maxWidth", "100%");
					$(this).find("iframe").css("width", "100%");
				});
								
			});
	
	$(document).on("click",".tabBar>span", function(){

		var offsetTop = parseInt($(".item_content_bar").offset().top,10);
		
		var i = $(".tabBar>span").index(this);

		$(".tabBar").find("span").removeClass("on");
		$(".item_content").removeClass("on");

		$(this).addClass("on");
		$(".item_content").eq(i).addClass("on");
		$("html, body").animate({ scrollTop :offsetTop},200);

	});

	$(document).on("click", ".btnStockQty", function() {

		var obj = $(this).parent().find("input[type=tel]");

		if ($(this).hasClass("Minus")) {
			if (parseInt(obj.val(), 10) - 1 <= 0) {
				alert("주문수량은 1 이상이어야 합니다.");
				obj.val("1");
			} else {
				obj.val(parseInt(obj.val(), 10) - 1);
			}
		}

		if ($(this).hasClass("Plus")) {
			obj.val(parseInt(obj.val(), 10) + 1);
		}

		fnCheckPriseSum();
	});

	$(document).on("blur", "[name=stockqty]", function() {

		if ($.isNumeric($(this).val()) == false) {
			$(this).val(1);
		}

		fnCheckPriseSum();
	});

	$(document).on("keyup", "[name=stockqty]", function() {

		if ($.isNumeric($(this).val()) == false) {
			$(this).val(1);
		}

		fnCheckPriseSum();
	});

	function fnCheckPriseSum() {
		var itemoptioncd = "N";
		var returnValue = 0;
		var stockqty = 0;
		var itemprice = parseInt($("[name=itemprice]").val(), 10);

		if (itemoptioncd == "N") {
			returnValue = itemprice * parseInt($("[name=stockqty]").val(), 10);
		}

		$(".totalprice").text(setComma(returnValue) + " 원");
	}

	$(document).on("click", ".btnTrigger", function() {

		if ($(this).parent().hasClass("on")) {
			$(this).parent().removeClass("on");
		} else {
			$(this).parent().addClass("on");
		}
	});

	$(document).on("click", ".btnOverlay", function() {

		var obj = $(".overlay." + $(this).attr("data") + "Layer");

		if ($(".overlay").hasClass("on")) {
			$(".overlay").removeClass("on");
		} else {
			$(".overlay.fullScreen").addClass("on");
			obj.addClass("on");

			$(".overlay." + $(this).attr("data") + "Layer").center();
		}
	});

	$(document).on("click", ".overlay_close", function() {
		$(".overlay").removeClass("on");
	});

	$(document).on("click", ".btnItemInfo", function() {

		if ($(this).parent().hasClass("on")) {
			$(this).parent().removeClass("on");
		} else {
			$(this).parent().addClass("on");
		}
	});
	
	$(document).on("click", ".btnOrderList", function() {

		if ($(".pdtOrderLayer").hasClass("on")) {
			$(".pdtOrderLayer").removeClass("on");
		} else {
			$(".pdtOrderLayer").addClass("on");
		}
	});
	
	$(document).on("click",".ClickPs", function(){
		
		if ($(this).parent().find(".ps").hasClass("on"))
		{
			$(this).parent().find(".ps").removeClass("on");
		}
		else
		{
			$(this).parent().find(".ps").addClass("on");
		}

		if ($(this).parent().find(".ps_reply").hasClass("on"))
		{
			$(this).parent().find(".ps_reply").removeClass("on");
		}
		else
		{
			$(this).parent().find(".ps_reply").addClass("on");
		}
	});

	$(document).on("click",".ClickQna", function(){
		
		if ($(this).parent().find(".qna").hasClass("on"))
		{
			$(this).parent().find(".qna").removeClass("on");
		}
		else
		{
			$(this).parent().find(".qna").addClass("on");
		}
	
	});

	$(document).on("click", ".btnDelItem", function() {
		 $("form").attr("action", "${contextPath}/${content.category}/ToUpdateContent.do").submit();
	});
	$(document).on("click", ".btnDelItem", function() {
		 $("form").attr("action", "${contextPath}/${content.category}/deleteContent.do").submit();
	});
</script>
</head>
<body>
	<jsp:include page="../inc/hdr_menu.jsp" />
	<div id="CommonHeaderArea"></div>
	<div id="CommonHeader_M"></div>
	<div class="wrap">
		<form method="post" action="" >
			<section class="iteminfo">
				<div class="inner swiper">
					<div class="swiper-container">
						<ul class="swiper-wrapper">
							<li class="swiper-slide">
								<img src="${contextPath}/download.do?fd=${content.category}&num=${content.num}&productImageName=${content.productImageName1}" />
							</li>
							<li class="swiper-slide">
								<img src="${contextPath}/download.do?fd=${content.category}&num=${content.num}&productImageName=${content.productImageName2}" />
							</li>
							<li class="swiper-slide">
								<img src="${contextPath}/download.do?fd=${content.category}&num=${content.num}&productImageName=${content.productImageName3}" />
							</li>
						</ul>
					</div>
					<div class="swiper-pagination"></div>

					<script type="text/javascript">
						var mainSwiper = new Swiper(
								".swiper .swiper-container", {
									autoplay : {
										delay : 4000,
									},
									pagination : {
										el : '.swiper-pagination',
										clickable : true,
									},
									autoplayDisableOnInteraction : false,

									loop : true,

									followFinger : true,
									preventClicks : false
								});
					</script>
				</div>
				
				<div class="product-detail-spec col-sm-12 col-md-6">
					<div class="tableDefault style2">
						<h3>
							<div>현재가</div>
							<div class="now-price">
								
									
									500,000
								
							</div>
							<div class="text-right"><p class="btn btn-blue"><i class="	fa fa-clock-o"></i> 남은시간 <span id="remain">14일 15시간 30분 2초</span></p></div>
						</h3>
						<table>
						<caption></caption>
						<colgroup>
							<col>
							<col>
						</colgroup>	
							<tbody>
							<tr>
								<th>경매번호</th>
								<td>
									7									
								</td>
							</tr>
							<tr>
								<th>물품번호</th>
								<td>
									2101M5RJONV									
								</td>
							</tr>
							<tr>
								<th>경매기간</th>
								<td>2021/01/07 15:00:00 ~ <br class="visible-xs">2021/01/27 15:05:00</td>
							</tr>
							<tr>
								<th>시작가</th>
								<td>
									
										
										500,000원
									
								</td>
							</tr>
								
							<tr>
								<th>입찰단위</th>
								<td>50,000원</td>
							</tr>
							
							<tr>
								<th>최고입찰자</th>
								<td></td>
							</tr>
							<tr>
								<th>입찰방식</th>
								<td>비공개</td>
							</tr>
							<tr>
								<th>입찰 수</th>
								<td>1<a href="#none" onclick="bidObj.bidListDefault();" class="btn btn-gray3 btn-sm fs14 ml20"><i class="fcGold fa fa-file-text-o"></i> 경매기록보기 &gt;</a></td>
							</tr>
							</tbody>
							
						</table>
						<!--  -->
						<table class="mt30 visible-lg visible-md visible-sm">
							<caption></caption>
							<colgroup>
								<col>
								<col>
								<col>
								<col>
							</colgroup>
							<tbody><tr class="bdr-bottom last">
								<th>판매자 ID</th>
								<td>allgoods</td>
								<th class="pb8">판매자 다른물품</th>
								<td class="pb8"><span class="lineH32">661건</span> <a href="#none" onclick="window.open('/kobay/unisrch/unisrch.do?qry=allgoods');" class="btn btn-gray2 pull-right">더보기 &gt;</a></td>
							</tr>
						</tbody></table>
						<!-- 모바일 -->
						<table class="mt30 visible-xs">
							<caption></caption>
							<colgroup>
								<col>
								<col>
							</colgroup>
							<tbody><tr class="bdr-bottom last">
								<th>판매자 ID</th>
								<td>allgoods</td>
							</tr>
							<tr class="bdr-bottom first last">
								<th>판매자 다른물품</th>
								<td><span class="lineH32">661건</span> <a href="#none" onclick="window.open('/kobay/unisrch/unisrch.do?qry=allgoods');" class="btn btn-gray2 pull-right">더보기 &gt;</a></td>
							</tr>
						</tbody></table>
						<!-- //모바일 -->
					</div>
					<div class="row mt10">
						<img src="/kobay/images/img_pc.jpg" class="visible-md visible-lg">
						<img src="/kobay/images/img_m.jpg" class="visible-xs">
					</div>
					<div class="btnArea row mt30">
						
							
								
									
										
											
												<p class="col-sm-3 btn-block-xs"><a href="#none" onclick="bidObj.bidFormLoad();" class="btn btn-blue btn-lg fs16 wp100">입찰하기</a></p>
											
											
										
										<p class="col-sm-3 btn-block-xs"><a href="#none" onclick="favrObj.favrAdd();" class="btn btn-gold btn-lg fs16 wp100">관심물품</a></p>
										<p class="col-sm-3 btn-block-xs"><a href="#none" onclick="goInquiry('2101M5RJONV','7');" class="btn btn-gray2 btn-lg fs16 wp100">문의하기</a></p>
										<p class="col-sm-3 btn-block-xs"><a href="#none" onclick="location.href='/kobay/item/planList.do?categoryid=01&amp;itemType=OK'" class="btn btn-gray2 btn-lg fs16 wp100">전체보기</a></p>
										
									
									
								
							
							
						
					</div>
				</div>
				
			</section>
		</form>
			<section class="item_content_bar" style="z-index: 997 !important;">
				<div class="inner">
					<div class="tabBar">
						<span class="on">상품상세</span> <span>상품후기</span> <span>상품Q&A</span>
					</div>
				</div>
			</section>

			<section class="item_content on">
				<div class="inner">
					<div class="contentsTopTop">${content.productName}</div>
					<div
						style="margin: 0 auto; width: 37px; height: 3px; background-color: #000000;"></div>
					<div class="contentsTopBottom">${content.productContent}</div>
					<div class="content">
						<div align="center" style="margin-top: 45px; padding: 0 30px;">
							<img src="${contextPath}/download.do?fd=${content.category}&num=${content.num}&productImageName=${content.productImageName1}" />
							<img src="${contextPath}/download.do?fd=${content.category}&num=${content.num}&productImageName=${content.productImageName2}" />
							<img src="${contextPath}/download.do?fd=${content.category}&num=${content.num}&productImageName=${content.productImageName3}" />
							
						</div>
					</div>

					<div class="content_info on">
						<span class="btnTrigger">교환/환불 정보</span>
						<div class="delivery type2">
							<span>배송완료 후 7일 이내에 신청할 수 있으며, 다음의 경우는 교환/반품 신청이 불가할 수
								있습니다.</span> <span class="type2">반품/교환 가능 기간이 경과된 경우</span> <span
								class="type2">포장을 개봉하였거나 포장이 훼손되어 상품가치가 현저히 감소한 경우</span> <span
								class="type2">고객의 주문을 확인한 후 상품제작에 들어가는 주문제작상품인 경우</span> <span
								class="type2">소비자가 책임 있는 사유로 상품 등이 멸실 또는 훼손된 경우</span> <span
								class="type2">시간의 경과에 의해 재판매가 곤란할 정도로 상품 등의 가치가 현저히 감소한
								경우</span> <span class="type2">복제가 가능한 재화 등의 포장을 훼손한 경우</span> <span>단순변심에
								의한 반품/교환 택배비는 고객님이 부담하셔야 하며, 반품 접수 없이 임의로 반송하거나 우편으로 보낼 경우 상품
								확인이 어려워 환불이 불가능 할 수 있습니다.</span>
						</div>
					</div>
				</div>
			</section>

			<section class="item_content postscript">
				<input class='btnOverlay btnProductQnA' type='button' value='상품후기 작성'  onclick="window.open('${contextPath}/Home/living/review.jsp?num=<%=num %>', '상품후기등록', 'width=500, height=500, location=no, status=no, scrollbars=no, resizable=no, left=500, top=100' );"  />
				<div class='inner'>
					<div class='table'>
						<span class='tr ClickPs'> 
							<span class='td'>1</span> 
							<span class='td type2'>
								<span class='type01'>title</span>
							</span> 
							<span class='td'>Date</span>
							<span class='td'>Writer</span>
						</span>
						<div class='ps'>
							<div class='ps_sub2'>Content</div>
						</div>
					</div>
					<div class='paging'>
						<span class='box'><span class="btn_pageprev opacity">
								<a href="javascript:;"> <img class="paging_pc"
									src="../../Images/Ver1/Common/btn_board_prev.gif" /><img
									class="paging_mobile"
									src="../../Images/Ver1/Common/btn_board_prev_m.gif" /></a>
						</span><span class="txt_pagenum"> <a href="javascript:;"
								class="btn_pageon">1</a></span><span class="txt_pagenum"> <a
								href="javascript:;" class="btn_pageoff" onclick="fnGoPsPage(2)">2</a></span><span
							class="btn_pagenext opacity"> <a href="javascript:;"
								onclick="alert('마지막 페이지입니다.');"> <img class="paging_pc"
									src="../../Images/Ver1/Common/btn_board_next.gif" /><img
									class="paging_mobile"
									src="../../Images/Ver1/Common/btn_board_next_m.gif" /></a></span></span>
					</div>
				</div>

			</section>

			<section class="item_content productqna">
				<input class='btnOverlay btnProductQnA' type='button' value='Q&A작성' onclick="window.open('qna.jsp', '질문등록', 'width=500, height=500, location=no, status=no, scrollbars=no, resizable=no, left=500, top=100' );"/>
				<div class='inner'>
					<div class='table'>
						<span class='tr ClickQna'> 
							<span class='td'>답변완료</span> 
							<span class='td type2'>title</span> 
							<span class='td'>date</span>
							<span class='td'>writer</span>
						</span>
						<div class='qna'>
							<span class='qna_q'>구매고객 CONTENT</span> 
							<span class='qna_a'>판매자 CONTENT</span>
						</div>
					</div>
					</div>
					<div class='paging'>
						<span class='box'><span class="btn_pageprev opacity">
								<a href="javascript:;"> <img class="paging_pc"
									src="../../Images/Ver1/Common/btn_board_prev.gif" /><img
									class="paging_mobile"
									src="../../Images/Ver1/Common/btn_board_prev_m.gif" /></a>
						</span><span class="txt_pagenum"> <a href="javascript:;"
								class="btn_pageon">1</a></span><span class="txt_pagenum"> <a
								href="javascript:;" class="btn_pageoff" onclick="fnGoQnaPage(2)">2</a></span><span
							class="txt_pagenum"> <a href="javascript:;"
								class="btn_pageoff" onclick="fnGoQnaPage(3)">3</a></span><span
							class="txt_pagenum"> <a href="javascript:;"
								class="btn_pageoff" onclick="fnGoQnaPage(4)">4</a></span><span
							class="txt_pagenum"> <a href="javascript:;"
								class="btn_pageoff" onclick="fnGoQnaPage(5)">5</a></span><span
							class="btn_pagenext"> <a href="javascript:;"
								onclick="fnGoQnaPage(6);"> <img class="paging_pc"
									src="../../Images/Ver1/Common/btn_board_next.gif" /><img
									class="paging_mobile"
									src="../../Images/Ver1/Common/btn_board_next_m.gif" /></a></span></span>
					</div>
				</section>
			</div>

			

			<input type="hidden" name="itemidx" value="2012140130" /> 
			<input type="hidden" name="itemoptioncd" value="N" /> 
			<input type="hidden" name="itemprice" value="${content.productPrice}" /> 
			<input type="hidden" name="type" />
			<input type="hidden" name="opcnt" />
			
	<section class="item_content productqna">
		<input class='btnOverlay btnProductQnA' type='button' value='Q&A작성' data='btnProductQnA'>/>
		<div class='inner'>
			<div class='table'>
				<span class='tr ClickQna'> <span class='td'>답변완료</span> <span
					class='td type2'>배송조회가 안되요</span> <span class='td'>2020-12-24</span>
					<span class='td'>gue**</span>
				</span>
				<div class='qna'>
					<span class='qna_q'>송장반호가 나왔는데 왜 배송조회가 안되는건가요?물건을 보냈다는 카톡은
						왔는데 배송조회하면 조회가 안되요...</span> <span class='qna_a'>고객님 안녕하세요.<br />비회원으로
						문의 글을 남겨주셔서 고객님의 주문내역 확인이 어렵습니다. ㅠㅠ<br />주문자 성함 혹은 주문번호를 확인해 주시거나
						[고객감동센터 1577-9081]로 문의를 부탁드립니다. <br />감사합니다. <br />
					<br /></span>
				</div>
			</div>
			<div class='table'>
				<span class='tr ClickQna'> <span class='td'>답변완료</span> <span
					class='td type2'>상품문의</span> <span class='td'>2020-12-23</span> <span
					class='td'>gmark**</span>
				</span>
				<div class='qna'>
					<span class='qna_q'>오늘발송합니까?검수해서 새상품으로 발송바랍니다.</span> <span
						class='qna_a'>고객님 안녕하세요.<br />주문하신 상품은 12월 23일 출고를
						도와드렸습니다.<br />상품 출고 후 보통 1~2일 안에 배송이 완료되지만&#44; 택배사 물류 사정으로 인하여
						배송일은 지연될 수 있는 점 양해 부탁드리며<br />운송장 번호를 확인 시 상품은 12월 26일 배송 완료된 것으로
						확인되고 있습니다. <br />감사합니다. <br /></span>
				</div>
			</div>
			<div class='paging'>
				<span class='box'><span class="btn_pageprev opacity">
						<a href="javascript:;"> <img class="paging_pc"
							src="/Images/Ver1/Common/btn_board_prev.gif" /><img
							class="paging_mobile"
							src="/Images/Ver1/Common/btn_board_prev_m.gif" /></a>
				</span><span class="txt_pagenum"> <a href="javascript:;"
						class="btn_pageon">1</a></span><span class="txt_pagenum"> <a
						href="javascript:;" class="btn_pageoff" onclick="fnGoQnaPage(2)">2</a></span><span
					class="txt_pagenum"> <a href="javascript:;"
						class="btn_pageoff" onclick="fnGoQnaPage(3)">3</a></span><span
					class="txt_pagenum"> <a href="javascript:;"
						class="btn_pageoff" onclick="fnGoQnaPage(4)">4</a></span><span
					class="txt_pagenum"> <a href="javascript:;"
						class="btn_pageoff" onclick="fnGoQnaPage(5)">5</a></span><span
					class="btn_pagenext"> <a href="javascript:;"
						onclick="fnGoQnaPage(6);"> <img class="paging_pc"
							src="/Images/Ver1/Common/btn_board_next.gif" /><img
							class="paging_mobile"
							src="/Images/Ver1/Common/btn_board_next_m.gif" /></a></span></span>
			</div>
		</div>
	</section>
	<jsp:include page="../inc/footer.jsp" />
</body>
</html>
