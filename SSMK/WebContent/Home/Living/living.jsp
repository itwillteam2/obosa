<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="ko">

<!-- Mirrored from www.artboxmall.com/home/shop/category.asp by HTTrack Website Copier/3.x [XR&CO'2014], Thu, 24 Dec 2020 05:44:06 GMT -->
<!-- Added by HTTrack -->
<meta http-equiv="content-type" content="text/html;charset=utf-8" />
<!-- /Added by HTTrack -->
<head>

<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />

<meta http-equiv="Content-Script-Type" content="text/javascript" />
<meta http-equiv="Content-Style-Type" content="text/css" />
<title>SSMarket</title>


<link rel="stylesheet" type="text/css" href="${contextPath}/T2_tmp/Home/Css/Common/Item.css">
<script type="text/javascript" src="${contextPath}/T2_tmp/Home/Js/Common/swiper.min.js"></script>
<link href="${contextPath}/T2_tmp/Home/Css/Common/Common.css" type="text/css" rel="stylesheet" />
<link href="${contextPath}/T2_tmp/Home/Css/Common/swiper.min.css" type="text/css" rel="stylesheet" />
<script type="text/javascript" src="${contextPath}/T2_tmp/Home/Js/Common/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="${contextPath}/T2_tmp/Home/Js/Common/Common.js"></script>
<script type="text/javascript" src="${contextPath}/T2_tmp/Home/Js/Common/swiper_r.min.js"></script>

<script type="text/javascript">
	$(document)
			.on(
					"change",
					"[name=ord]",
					function() {

						GA_event("카테고리", $(".category").text() + "_정렬", $(
								"select[name=ord] option:selected").text());
						$("[name=page]").val("1");
						$("[name=frm]")
								.attr("action",
										"https://www.artboxmall.com/home/shop/category.asp")
								.attr("target", "_self").attr("method", "get")
								.submit();
					});

	function fnGoPage(page) {
		$("[name=page]").val(page);
		$("[name=frm]").attr("action",
				"https://www.artboxmall.com/home/shop/category.asp").attr(
				"target", "_self").attr("method", "get").submit();
	}

	$(document).on({
		mouseenter : function() {
			$(this).find(".hover").addClass("on");
		},
		mouseleave : function() {
			$(this).find(".hover").removeClass("on");
		}
	}, ".itemList>li");

	$(document)
			.on(
					"click",
					".hover>.wish",
					function() {

						alert("회원 전용 서비스입니다.");
						location.href = "https://www.artboxmall.com:443/Home/Member/Login.asp?rtnURL=%2Fhome%2Fshop%2Fcategory%2Easp";

					});

	$(document).on(
			"click",
			".hover>.cart",
			function() {

				var where = $(this);

				if ($(this).attr("data-itemoptioncd") == "Y") {
					$(".overlay").addClass("on");
					$(".btnGoItemDetail").click(
							function() {
								$(location).attr(
										"href",
										"https://www.artboxmall.com/home/shop/itemdetail.asp?itemidx="
												+ where.attr("data-itemidx"));
							});
				} else {

					var param = "";
					param += "type=ItemDetailCART";
					param += "&type2=ListCart";
					param += "&opcnt=1";
					param += "&itemidx=" + $(this).attr("data-itemidx");
					param += "&opidx=" + $(this).attr("data-opidx");
					param += "&itemoptioncd="
							+ $(this).attr("data-itemoptioncd");
					param += "&stockqty=1";

					var request = $.ajax({
						url : "/home/shop/QtyCheck_P.xmls.asp",
						type : "post",
						data : param
					});

					request.done(function(response, textStatus, jqXHR) {
						eval(response);

						if (result == "on") {
							where.addClass("on");
						} else {
							where.removeClass("on")
						}

					});
				}

			});

	$(document).on(
			"click",
			".hover>.ps",
			function() {
				$(location).attr(
						"href",
						"https://www.artboxmall.com/home/shop/itemdetail.asp?itemidx="
								+ $(this).attr("data-itemidx") + "&ps=go");
			});

	$(document).on("click", ".overlay_close,.btnGoShopping", function() {
		$(".overlay").removeClass("on");
	});
</script>
</head>
<body>

	<jsp:include page="../inc/header.jsp" />

	<div id="CommonHeaderArea"></div>
	<div id="CommonHeader_M"></div>

	<a class="btn_top" href="javascript:;"><img
		src="https://www.artboxmall.com/Images/Ver1/Common/btn_top.png"></a>
	<script type="text/javascript">
		$(document).on("click", ".btn_top", function() {
			$("html, body").animate({
				scrollTop : 0
			}, 200);
		});
	</script>
	<!-- Google Tag Manager (noscript) -->
	<noscript>
		<iframe src="https://www.googletagmanager.com/ns.html?id=GTM-KFBFR72"
			height="0" width="0" style="display: none; visibility: hidden"></iframe>
	</noscript>
	<!-- End Google Tag Manager (noscript) -->

	<div class="wrap">
		<section class="sec_header">
			<div class="inner"></div>
		</section>

		<section class="sec_cont">
			<form name="frm">
				<input type="hidden" name="page" value="1" />

				<div class="inner">

					<div class="info">
						<span class="result">총 <strong>4591</strong>개의 상품이 조회되었습니다.
						</span> <span class="selectbox"> <select name="ord">
								<option value="o1" selected="selected">신상품순</option>
								<option value="o5">인기상품순</option>
								<option value="o2">낮은가격순</option>
								<option value="o3">높은가격순</option>
								<option value="o4">높은할인율순</option>
								<option value="o6">상품평순</option>
						</select>
						</span>
					</div>
					<ul class='itemList'>
						<li><span class='img'> <a
								href='https://www.artboxmall.com/home/shop/itemdetail.asp?itemidx=2012150253'
								onclick='GA_event("카테고리", "_상품", "JELLY뻐 너만콬콬 사랑할꼬야 콜라젤리 (24009448)"); GA_onclick("카테고리_", "2012150253", "JELLY뻐 너만콬콬 사랑할꼬야 콜라젤리 (24009448)", "아트박스", "", "3300", "#32", "0");'>
									<img
									src='https://www.poom.co.kr/Upload2/Product/202012/2012150253_detail1.jpg?cmd=thumb&amp;w=270&amp;h=270&amp;fit=true' />
							</a> <span class='hover'><span class='wish '
									data-itemidx='2012150253'></span><span class='cart '
									data-itemidx='2012150253' data-opidx='' data-itemoptioncd='N'></span><span
									class='ps' data-itemidx='2012150253'>0</span></span>
						</span> <span class='iteminfo'> <span class='text'><a
									href='https://www.artboxmall.com/home/shop/itemdetail.asp?itemidx=2012150253'
									title='JELLY뻐 너만콬콬 사랑할꼬야 콜라젤리 (24009448)'>JELLY뻐 너만콬콬
										사랑할꼬야 콜라젤리 (24009448)</a></span> <span class='price'><span
									class='won'>3,300<strong>원</strong></span></span><span
								class="stampicon new"></span>
						</span></li>
						<li><span class='img'> <a
								href='https://www.artboxmall.com/home/shop/itemdetail.asp?itemidx=2012150250'
								onclick='GA_event("카테고리", "_상품", "JELLY뻐 우리사랑에 한계란없지 사우어프라이드 에그젤리 (24009445)"); GA_onclick("카테고리_", "2012150250", "JELLY뻐 우리사랑에 한계란없지 사우어프라이드 에그젤리 (24009445)", "아트박스", "", "3300", "#31", "0");'>
									<img
									src='https://www.poom.co.kr/Upload2/Product/202012/2012150250_detail1.jpg?cmd=thumb&amp;w=270&amp;h=270&amp;fit=true' />
							</a> <span class='hover'><span class='wish '
									data-itemidx='2012150250'></span><span class='cart '
									data-itemidx='2012150250' data-opidx='' data-itemoptioncd='N'></span><span
									class='ps' data-itemidx='2012150250'>0</span></span>
						</span> <span class='iteminfo'> <span class='text'><a
									href='https://www.artboxmall.com/home/shop/itemdetail.asp?itemidx=2012150250'
									title='JELLY뻐 우리사랑에 한계란없지 사우어프라이드 에그젤리 (24009445)'>JELLY뻐
										우리사랑에 한계란없지 사우어프라이드 에그젤리 (24009445)</a></span> <span class='price'><span
									class='won'>3,300<strong>원</strong></span></span><span
								class="stampicon new"></span>
						</span></li>
						<li><span class='img'> <a
								href='https://www.artboxmall.com/home/shop/itemdetail.asp?itemidx=2012150246'
								onclick='GA_event("카테고리", "_상품", "JELLY뻐 너랑나랑 알콩달콩 젤리빈스젤리 (24009443)"); GA_onclick("카테고리_", "2012150246", "JELLY뻐 너랑나랑 알콩달콩 젤리빈스젤리 (24009443)", "아트박스", "", "3300", "#30", "0");'>
									<img
									src='https://www.poom.co.kr/Upload2/Product/202012/2012150246_detail1.jpg?cmd=thumb&amp;w=270&amp;h=270&amp;fit=true' />
							</a> <span class='hover'><span class='wish '
									data-itemidx='2012150246'></span><span class='cart '
									data-itemidx='2012150246' data-opidx='' data-itemoptioncd='N'></span><span
									class='ps' data-itemidx='2012150246'>0</span></span>
						</span> <span class='iteminfo'> <span class='text'><a
									href='https://www.artboxmall.com/home/shop/itemdetail.asp?itemidx=2012150246'
									title='JELLY뻐 너랑나랑 알콩달콩 젤리빈스젤리 (24009443)'>JELLY뻐 너랑나랑
										알콩달콩 젤리빈스젤리 (24009443)</a></span> <span class='price'><span
									class='won'>3,300<strong>원</strong></span></span><span
								class="stampicon new"></span>
						</span></li>
						<li><span class='img'> <a
								href='https://www.artboxmall.com/home/shop/itemdetail.asp?itemidx=2012150232'
								onclick='GA_event("카테고리", "_상품", "와이어 자물쇠 시바 (26013611)"); GA_onclick("카테고리_", "2012150232", "와이어 자물쇠 시바 (26013611)", "아트박스", "", "4200", "#29", "0");'>
									<img
									src='https://www.poom.co.kr/Upload2/Product/202012/2012150232_detail1.jpg?cmd=thumb&amp;w=270&amp;h=270&amp;fit=true' />
							</a> <span class='hover'><span class='wish '
									data-itemidx='2012150232'></span><span class='cart '
									data-itemidx='2012150232' data-opidx='' data-itemoptioncd='N'></span><span
									class='ps' data-itemidx='2012150232'>0</span></span>
						</span> <span class='iteminfo'> <span class='text'><a
									href='https://www.artboxmall.com/home/shop/itemdetail.asp?itemidx=2012150232'
									title='와이어 자물쇠 시바 (26013611)'>와이어 자물쇠 시바 (26013611)</a></span> <span
								class='price'><span class='won'>4,200<strong>원</strong></span></span><span
								class="stampicon new"></span>
						</span></li>
						<li><span class='img'> <a
								href='https://www.artboxmall.com/home/shop/itemdetail.asp?itemidx=2012150231'
								onclick='GA_event("카테고리", "_상품", "와이어 자물쇠 보스 (26013610)"); GA_onclick("카테고리_", "2012150231", "와이어 자물쇠 보스 (26013610)", "아트박스", "", "4200", "#28", "0");'>
									<img
									src='https://www.poom.co.kr/Upload2/Product/202012/2012150231_detail1.jpg?cmd=thumb&amp;w=270&amp;h=270&amp;fit=true' />
							</a> <span class='hover'><span class='wish '
									data-itemidx='2012150231'></span><span class='cart '
									data-itemidx='2012150231' data-opidx='' data-itemoptioncd='N'></span><span
									class='ps' data-itemidx='2012150231'>0</span></span>
						</span> <span class='iteminfo'> <span class='text'><a
									href='https://www.artboxmall.com/home/shop/itemdetail.asp?itemidx=2012150231'
									title='와이어 자물쇠 보스 (26013610)'>와이어 자물쇠 보스 (26013610)</a></span> <span
								class='price'><span class='won'>4,200<strong>원</strong></span></span><span
								class="stampicon new"></span>
						</span></li>
						<li><span class='img'> <a
								href='https://www.artboxmall.com/home/shop/itemdetail.asp?itemidx=2012150229'
								onclick='GA_event("카테고리", "_상품", "커플 자물쇠 하트 (26013609)"); GA_onclick("카테고리_", "2012150229", "커플 자물쇠 하트 (26013609)", "아트박스", "", "7200", "#27", "0");'>
									<img
									src='https://www.poom.co.kr/Upload2/Product/202012/2012150229_detail1.jpg?cmd=thumb&amp;w=270&amp;h=270&amp;fit=true' />
							</a> <span class='hover'><span class='wish '
									data-itemidx='2012150229'></span><span class='cart '
									data-itemidx='2012150229' data-opidx='' data-itemoptioncd='N'></span><span
									class='ps' data-itemidx='2012150229'>0</span></span>
						</span> <span class='iteminfo'> <span class='text'><a
									href='https://www.artboxmall.com/home/shop/itemdetail.asp?itemidx=2012150229'
									title='커플 자물쇠 하트 (26013609)'>커플 자물쇠 하트 (26013609)</a></span> <span
								class='price'><span class='won'>7,200<strong>원</strong></span></span><span
								class="stampicon new"></span>
						</span></li>
						<li><span class='img'> <a
								href='https://www.artboxmall.com/home/shop/itemdetail.asp?itemidx=2012150228'
								onclick='GA_event("카테고리", "_상품", "JELLY뻐 나는애플 너는뷰티플 사우어사과링젤리 (24009456)"); GA_onclick("카테고리_", "2012150228", "JELLY뻐 나는애플 너는뷰티플 사우어사과링젤리 (24009456)", "아트박스", "", "3300", "#26", "0");'>
									<img
									src='https://www.poom.co.kr/Upload2/Product/202012/2012150228_detail1.jpg?cmd=thumb&amp;w=270&amp;h=270&amp;fit=true' />
							</a> <span class='hover'><span class='wish '
									data-itemidx='2012150228'></span><span class='cart '
									data-itemidx='2012150228' data-opidx='' data-itemoptioncd='N'></span><span
									class='ps' data-itemidx='2012150228'>0</span></span>
						</span> <span class='iteminfo'> <span class='text'><a
									href='https://www.artboxmall.com/home/shop/itemdetail.asp?itemidx=2012150228'
									title='JELLY뻐 나는애플 너는뷰티플 사우어사과링젤리 (24009456)'>JELLY뻐 나는애플
										너는뷰티플 사우어사과링젤리 (24009456)</a></span> <span class='price'><span
									class='won'>3,300<strong>원</strong></span></span><span
								class="stampicon new"></span>
						</span></li>
						<li><span class='img'> <a
								href='https://www.artboxmall.com/home/shop/itemdetail.asp?itemidx=2012150221'
								onclick='GA_event("카테고리", "_상품", "JELLY뻐 너를정말사랑하지렁 미니사우어 웜스젤리 (24009454)"); GA_onclick("카테고리_", "2012150221", "JELLY뻐 너를정말사랑하지렁 미니사우어 웜스젤리 (24009454)", "아트박스", "", "3300", "#25", "0");'>
									<img
									src='https://www.poom.co.kr/Upload2/Product/202012/2012150221_detail1.jpg?cmd=thumb&amp;w=270&amp;h=270&amp;fit=true' />
							</a> <span class='hover'><span class='wish '
									data-itemidx='2012150221'></span><span class='cart '
									data-itemidx='2012150221' data-opidx='' data-itemoptioncd='N'></span><span
									class='ps' data-itemidx='2012150221'>0</span></span>
						</span> <span class='iteminfo'> <span class='text'><a
									href='https://www.artboxmall.com/home/shop/itemdetail.asp?itemidx=2012150221'
									title='JELLY뻐 너를정말사랑하지렁 미니사우어 웜스젤리 (24009454)'>JELLY뻐
										너를정말사랑하지렁 미니사우어 웜스젤리 (24009454)</a></span> <span class='price'><span
									class='won'>3,300<strong>원</strong></span></span><span
								class="stampicon new"></span>
						</span></li>
					</ul>
					<div class="clear"></div>
					<div class='paging'>
						<span class='box'><span class="btn_pageprev opacity">
								<a href="javascript:;"> <img class="paging_pc"
									src="https://www.artboxmall.com/Images/Ver1/Common/btn_board_prev.gif" /><img
									class="paging_mobile"
									src="https://www.artboxmall.com/Images/Ver1/Common/btn_board_prev_m.gif" /></a>
						</span><span class="txt_pagenum"> <a href="javascript:;"
								class="btn_pageon">1</a></span><span class="txt_pagenum"> <a
								href="javascript:;" class="btn_pageoff" onclick="fnGoPage(2)">2</a></span><span
							class="txt_pagenum"> <a href="javascript:;"
								class="btn_pageoff" onclick="fnGoPage(3)">3</a></span><span
							class="txt_pagenum"> <a href="javascript:;"
								class="btn_pageoff" onclick="fnGoPage(4)">4</a></span><span
							class="txt_pagenum"> <a href="javascript:;"
								class="btn_pageoff" onclick="fnGoPage(5)">5</a></span><span
							class="btn_pagenext"> <a href="javascript:;"
								onclick="fnGoPage(6);"> <img class="paging_pc"
									src="https://www.artboxmall.com/Images/Ver1/Common/btn_board_next.gif" /><img
									class="paging_mobile"
									src="https://www.artboxmall.com/Images/Ver1/Common/btn_board_next_m.gif" /></a></span></span>
					</div>
				</div>
			</form>
		</section>
	</div>
	<jsp:include page="../inc/footer.jsp" />

</body>
</html>
