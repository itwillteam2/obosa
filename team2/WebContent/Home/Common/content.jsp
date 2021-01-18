<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	request.setCharacterEncoding("utf-8");
	String num = request.getParameter("num");
	pageContext.setAttribute("newLineChar", "\n");
%>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />

<!DOCTYPE html>
<html lang="ko">
<head>
<jsp:include page="/Home/inc/head.jsp"/>
<link rel="stylesheet" type="text/css" href="${contextPath}/Home/Css/Shop/ItemDetail.css">
<link rel="stylesheet" type="text/css" href="${contextPath}/Home/Css/Shop/ScrollBar.css"/>

<script type="text/javascript">
function payment(){
	var id = "${id}";
	var qty = $("#stockqty").val();
	if(id == "" || id == null){
		alert("로그인 해 주세요.");
		return;
	}
	location.href='${contextPath}/common/payment.do?fd=${content.category}&num=${content.num}&qty='+qty;
}

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
	

	$(document).on("click", ".ClickPs", function() {
		if ($(this).next("div").css("display") == "none") {
			$(this).next("div").css("display", "block");
		} else {
			$(this).next("div").css("display", "none");
		}
	});

	$(document).on("click",".ClickQna", function(){
		
		if ($(this).next("div").css("display") == "none") {
			$(this).next("div").css("display", "block");
		} else {
			$(this).next("div").css("display", "none");
		}
	
	});

	$(document).on("click", ".btnDelItem", function() {
		 $("form").attr("action", "${contextPath}/${content.category}/ToUpdateContent.do").submit();
	});
	$(document).on("click", ".btnDelItem", function() {
		 $("form").attr("action", "${contextPath}/${content.category}/deleteContent.do").submit();
	});
	
	function PageMove(page){
		location.href="${contextPath}/${content.category}/viewContent.do?num=${content.num}&pageNO="+page
	}
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
				<div class="inner togglebox on">
					<span class="pdtName pc" style="margin-bottom:30px">${content.productName}</span>
					<div class="pdtInfo">
						<span class="pdtRight pdtseller">
							<span>${content.sellerName}</span>
						</span>
						<span class="pdtRight pdtSaleprice"> 		
							<span class="saleprice N">${content.productPrice}</span>
						</span> 
						<span class="pdtRight pdtDeliveryprice">
							<span class="deliverytext">${content.shipping_fee} </span>
						</span> 
						<span class="pdtRight pdtpt"> 
							<span>${content.point}점</span>
						</span> 
						<div class="pdtOrderLayer">
						<c:choose>
			 				<c:when test="${sessionScope.memtype != 'seller'}">
						
							<span class="btnOrderList"></span> 
							<span class="pdtRight pdtQty pdtQtyLayer"> 
								<span class="ipt_layer"> 
									<input type="button" class="btnStockQty Minus" value="-" /> 
									<input type="button" class="btnStockQty Plus" value="+" /> 
									<input type="tel" id="stockqty" name="stockqty" value="1" maxlength="4" onkeypress="fnOnlyNumber(this);" />
								</span>
							</span> 
							<span class="pdtRight pdtTotalPrice"> 
								<span class="totalprice"> ${content.productPrice}원 </span>
							</span> 
							<span class="pdtRight pdtBtnList"> 
							    <span class="btnCart">
								   <input type="button" value="장바구니 담기" />
								</span> 
								<span class="btnOrder">
									<input type="button" value="바로 구매하기" onclick="payment()"/>
								</span> 
							</span>
						   </c:when>
						<c:otherwise>	
							<span class="pdtRight pdtQty pdtQtyLayer"> 
							   100  개
							</span> 
								<span class="pdtRight pdtBtnList" > 
								<span class="btnModItem">
								    <input type="button"  class="btnModItem" value="상품 수정" />
								    <input type="hidden" name="num" value="${content.num}" />
								</span> 
								<span class="btnDelItem">
									<input type="button" value="상품 삭제" />
								</span> 
								</span>
						</c:otherwise>
						</c:choose>
						</div>
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
				<c:if test="${sessionScope.name != content.sellerName }">
					<input class='btnOverlay btnProductQnA' type='button' value='상품후기 작성'  onclick="window.open('${contextPath}/Home/Common/review.jsp?category=${content.category}&num=<%=num %>', '상품후기등록', 'width=500, height=500, location=no, status=no, scrollbars=no, resizable=no, left=500, top=100' );"  />
				</c:if>
				<div class='inner'>
					<div class='table'>
					<c:forEach var="Rep" items="${ReppagingList}">
						<span class='tr ClickPs'> 
							<span class='td'>${Rep.rnum}</span> 
							<span class='td type2'>
								<span class='type01'>${Rep.title}</span>
							</span> 
							<span class='td'><fmt:formatDate value="${Rep.date}" /></span>
							<span class='td'>${Rep.writer }</span>
						</span>
						<div class='ps on'>
							<div class='ps_sub2'>${fn:replace(Rep.content, newLineChar, "<br/>")}</div>
						</div>
					</c:forEach>	
					</div>
					<div class="paging">
						<span class="box">
							<span class="btn_pageprev"><a href="javascript:PageMove(${paging.prevPage})"><img class="paging_pc" src="${contextPath}/Images/Ver1/Common/btn_board_prev.gif" /></a></span>
								<c:forEach var="i" begin="${paging.startPage}" end="${paging.endPage}" step="1">
									<c:choose>
										<c:when test="${i eq paging.pageNo}">
											<span class="txt_pagenum"><a href="javascript:PageMove(${i})" class="btn_pageon">${i}</a></span>
										</c:when>
										<c:otherwise>
											<span class="txt_pagenum"><a href="javascript:PageMove(${i})">${i}</a></span>
										</c:otherwise>
									</c:choose>
								</c:forEach>
							<span class="btn_pagenext"><a href="javascript:PageMove(${paging.nextPage})"><img class="paging_pc" src="${contextPath}/Images/Ver1/Common/btn_board_next.gif" /></a></span>
						</span>
					</div>
				</div>

			</section>

			<section class="item_content productqna">
				<c:if test="${content.sellerName != sessionScope.name }">
					<input class='btnOverlay btnProductQnA' type='button' value='Q&A작성' onclick="window.open('${contextPath}/Home/Common/qna.jsp?category=${content.category}&num=<%=num %>', '질문등록', 'width=500, height=500, location=no, status=no, scrollbars=no, resizable=no, left=500, top=100' );"/>
				</c:if>
				<div class='inner'>
					<div class='table'>
						<c:forEach var="Qna" items="${QnaPagingJoinList}" varStatus="status">
						<span class='tr ClickQna'>
							<c:choose>
								<c:when test="${Qna.complete == 1}"> 
									<span class='td'>답변완료</span>
								</c:when>
								<c:otherwise>
									<span class='td'>답변대기</span>
								</c:otherwise>
							</c:choose> 
							<span class='td type2'>${Qna.title }</span> 
							<span class='td'><fmt:formatDate value="${Qna.date}" /></span>
							<span class='td'>${Qna.writer }</span>
						</span>
						<div class='qna on'>
							<span class='qna_q'>${fn:replace(Qna.content, newLineChar, "<br/>")}</span>
							
							<c:choose>
								<c:when test="${Qna.complete == 1}"> 
									<span class='qna_a'>${fn:replace(Qna.rcontent, newLineChar, "<br/>")}</span>
										<c:if test="${content.sellerName == sessionScope.name }"> 
										<span class="buttonreply" style="float:right;" onclick="window.open('${contextPath}/Home/Common/qnaReplyModify.jsp?category=${content.category}&qrnum=${Qna.qrnum}&num=${content.num}', 
										'Q&A답변수정', 'width=500, height=400, location=no, status=no, scrollbars=no, resizable=no, left=500, top=100' );">
										Q&A 답변 수정</span>
										<span class="buttonreply" style="float:right;" onclick="location.href='${contextPath}/Home/Common/qnaReplyDelete.jsp?category=${content.category}&qrnum=${Qna.qrnum}&num=${content.num}'">
										Q&A 답변 삭제</span>
										</c:if>
								</c:when>
								<c:otherwise>
									<span class='qna_a'>&nbsp;</span>
									<c:if test="${content.sellerName == sessionScope.name }"> 
									<span class="buttonreply" style="float:right;" onclick="window.open('${contextPath}/Home/Common/qnaReply.jsp?category=${content.category}&qnum=${Qna.qnum}', 
									'Q&A답변등록', 'width=500, height=400, location=no, status=no, scrollbars=no, resizable=no, left=500, top=100' );">
									Q&A 답변 작성</span>
									</c:if>
								</c:otherwise>
							</c:choose> 			
						</div>
						</c:forEach>
					</div>
					</div>
					<div class="paging">
						<span class="box">
							<span class="btn_pageprev"><a href="javascript:PageMove(${paging.prevPage})"><img class="paging_pc" src="${contextPath}/Images/Ver1/Common/btn_board_prev.gif" /></a></span>
								<c:forEach var="i" begin="${paging.startPage}" end="${paging.endPage}" step="1">
									<c:choose>
										<c:when test="${i eq paging.pageNo}">
											<span class="txt_pagenum"><a href="javascript:PageMove(${i})" class="btn_pageon">${i}</a></span>
										</c:when>
										<c:otherwise>
											<span class="txt_pagenum"><a href="javascript:PageMove(${i})">${i}</a></span>
										</c:otherwise>
									</c:choose>
								</c:forEach>
							<span class="btn_pagenext"><a href="javascript:PageMove(${paging.nextPage})"><img class="paging_pc" src="${contextPath}/Images/Ver1/Common/btn_board_next.gif" /></a></span>
						</span>
					</div>
				</section>
			</div>
			<input type="hidden" name="itemidx" value="2012140130" /> 
			<input type="hidden" name="itemoptioncd" value="N" /> 
			<input type="hidden" name="itemprice" value="${content.productPrice}" /> 
			<input type="hidden" name="type" />
			<input type="hidden" name="opcnt" />
	<jsp:include page="../inc/footer.jsp" />
</body>
</html>
