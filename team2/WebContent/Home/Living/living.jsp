<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>







<!DOCTYPE html>
<html lang="ko">

<head>
<jsp:include page="/Home/inc/head.jsp"/>
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

	<jsp:include page="/Home/inc/hdr_menu.jsp" />


	<div class="wrap">
		<section class="sec_header">
			<div class="inner"></div>
		</section>

		<section class="sec_cont">
			<form name="frm">
				<input type="hidden" name="page" value="1" />

				<div class="inner">

					<div class="info">
						<span class="result">총 <strong>${totalCountList}</strong>개의 상품이 조회되었습니다.
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
						<li>
							<span class='img'> 
								<a href='#'>
									<img src='https://www.poom.co.kr/Upload2/Product/202012/2012150253_detail1.jpg?cmd=thumb&amp;w=270&amp;h=270&amp;fit=true' />
								</a> 
							</span> 
							<span class='iteminfo'> 
								<span class='text'>
								<a href='#'>JELLY뻐 너만콬콬 사랑할꼬야 콜라젤리 (24009448)</a></span> 
								<span class='price won'><span class='won'>3,300<strong>원</strong></span></span>
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
	<jsp:include page="/Home/inc/footer.jsp" />

</body>
</html>
