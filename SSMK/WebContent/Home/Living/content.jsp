<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="ko">
<head>

<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />

<meta http-equiv="Content-Script-Type" content="text/javascript" />
<meta http-equiv="Content-Style-Type" content="text/css" />

<title>SSMarket</title>

<link href="${contextPath}/T2_tmp/Home/Css/Common/Common.css" type="text/css" rel="stylesheet" />
<link href="${contextPath}/T2_tmp/Home/Css/Common/swiper.min.css" type="text/css" rel="stylesheet" />

<script type="text/javascript" src="${contextPath}/T2_tmp/Home/Js/Common/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="${contextPath}/T2_tmp/Home/Js/Common/Common.js"></script>
<script type="text/javascript" src="${contextPath}/T2_tmp/Home/Js/Common/swiper_r.min.js"></script>

<link rel="stylesheet" type="text/css" href="${contextPath}/T2_tmp/Home/Css/Shop/ItemDetail.css">
<link rel="stylesheet" type="text/css" href="${contextPath}/T2_tmp/Home/Css/Shop/ScrollBar.css"/>
	
<script type="text/javascript" src="${contextPath}/T2_tmp/Home/Js/Common/iscroll.js"></script>
<script type="text/javascript" src="${contextPath}/T2_tmp/Home/Js/Common/jquery.sticky.js"></script>

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
				alert("�ֹ������� 1 �̻��̾�� �մϴ�.");
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

		$(".pdtOpbox")
				.each(
						function() {

							itemprice = parseInt($("[name=itemprice]").val(),
									10)
									+ parseInt($(this).find("[name=opprice]")
											.val(), 10);

							if ($(this).find("[name=stockqty]").val() == "") {
								$(this).find("[name=stockqty]").val(1);
							}

							stockqty = parseInt($(this).find("[name=stockqty]")
									.val(), 10);
							returnValue += stockqty * itemprice;
						});

		if (itemoptioncd == "N") {
			returnValue = itemprice * parseInt($("[name=stockqty]").val(), 10);
		}

		$(".totalprice").text(setComma(returnValue) + " ��");
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

</script>
</head>
<body>
	<jsp:include page="../inc/header.jsp" />
	<div id="CommonHeaderArea"></div>
	<div id="CommonHeader_M"></div>
	<div class="wrap">
		<form method="post" name="ItemDetail"
			enctype="application/x-www-form-urlencoded" action="" target="proc">

			<section class="iteminfo">
				<div class="inner swiper">
					<div class="swiper-container">
						<ul class="swiper-wrapper">

							<li class="swiper-slide"><img
								src="https://www.poom.co.kr/Upload2/Product/202012/2012140130_detail1.jpg" /></li>

							<li class="swiper-slide"><img
								src="https://www.poom.co.kr/Upload2/Product/202012/2012140130_detail2.jpg" /></li>

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
					<span class="pdtName pc" style="margin-bottom:30px">�������� ������ (20009758)</span>
					<div class="pdtInfo">

						<!-- <img class="pc" style="position:absolute; top:-20px; right:20px;" src="/images/ver1/event/diary2019/pc_img.png" /> -->

						<span class="pdtRight pdtSaleprice"> <span
							class="saleprice N">3,000 ��</span></span> <span
							class="pdtRight pdtDeliveryprice"><span
							class="deliverytext">2,500�� </span></span> <span
							class="pdtRight pdtMileage"> <span>30 ��</span></span> <span
							class="pdtRight pdtCode"><span>2012140130</span></span>

						<div class="pdtOrderLayer">
							<span class="btnOrderList"></span> <span
								class="pdtRight pdtQty pdtQtyLayer"> <span
								class="ipt_layer"> <input type="button"
									class="btnStockQty Minus" value="-" /> <input type="button"
									class="btnStockQty Plus" value="+" /> <input type="tel"
									name="stockqty" value="1" maxlength="4"
									onkeypress="fnOnlyNumber(this);" />
							</span>
							</span> <span class="pdtRight pdtTotalPrice"> <span
								class="totalprice"> 3,000 �� </span>
							</span> 
							<span class="pdtRight pdtBtnList"> <span class="btnCart">
								<input type="button" value="��ٱ��� ���" />
							</span> 
							<span class="btnOrder">
								<input type="button" value="�ٷ� �����ϱ�" /></span> <span class="btnWish off">
							</span>
							<span class="btnOverlay btnShare" data="btnShare"></span>
							</span>
						</div>
					</div>
				</div>
			</section>
		</form>
			<section class="item_content_bar" style="z-index: 997 !important;">
				<div class="inner">
					<div class="tabBar">
						<span class="on">��ǰ��</span> <span>��ǰ�ı�(0)</span> <span>��ǰQ&A(0)</span>
					</div>
				</div>
			</section>

			<section class="item_content on">
				<div class="inner">
					<div class="contentsTopTop">�������� ������ (20009758)</div>
					<div
						style="margin: 0 auto; width: 37px; height: 3px; background-color: #000000;"></div>
					<div class="contentsTopBottom">���� ������ ���⸦ ���� �� �ִ� ���������Դϴ�.</div>
					<div class="content">
						<div align="center" style="margin-top: 45px; padding: 0 30px;">
							<img
								src="https://www.poom.co.kr/Upload2/Event/Img/poom201214510378887597.jpg"
								style="padding-bottom: 10px;"><img
								src="https://www.poom.co.kr/Upload2/Event/Img/poom201214510382532042.jpg"
								style="padding-bottom: 10px;"><img
								src="https://www.poom.co.kr/Upload2/Event/Img/poom201214510399288598.jpg"
								style="padding-bottom: 10px;">
						</div>
					</div>

					<div class="content_info on">
						<span class="btnTrigger">��ȯ/ȯ�� ����</span>
						<div class="delivery type2">
							<span>��ۿϷ� �� 7�� �̳��� ��û�� �� ������, ������ ���� ��ȯ/��ǰ ��û�� �Ұ��� ��
								�ֽ��ϴ�.</span> <span class="type2">��ǰ/��ȯ ���� �Ⱓ�� ����� ���</span> <span
								class="type2">������ �����Ͽ��ų� ������ �ѼյǾ� ��ǰ��ġ�� ������ ������ ���</span> <span
								class="type2">���� �ֹ��� Ȯ���� �� ��ǰ���ۿ� ���� �ֹ����ۻ�ǰ�� ���</span> <span
								class="type2">�Һ��ڰ� å�� �ִ� ������ ��ǰ ���� ��� �Ǵ� �Ѽյ� ���</span> <span
								class="type2">�ð��� ����� ���� ���ǸŰ� ����� ������ ��ǰ ���� ��ġ�� ������ ������
								���</span> <span class="type2">������ ������ ��ȭ ���� ������ �Ѽ��� ���</span> <span>�ܼ����ɿ�
								���� ��ǰ/��ȯ �ù��� ������ �δ��ϼž� �ϸ�, ��ǰ ���� ���� ���Ƿ� �ݼ��ϰų� �������� ���� ��� ��ǰ
								Ȯ���� ����� ȯ���� �Ұ��� �� �� �ֽ��ϴ�.</span>
						</div>
					</div>
				</div>
			</section>

			<section class="item_content postscript">
				<input class='btnOverlay btnProductQnA' type='button' value='��ǰ�ı� �ۼ�'  onclick="window.open('review.jsp', '��ǰ�ı���', 'width=500, height=500, location=no, status=no, scrollbars=no, resizable=no, left=500, top=100' );"  />
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
								onclick="alert('������ �������Դϴ�.');"> <img class="paging_pc"
									src="../../Images/Ver1/Common/btn_board_next.gif" /><img
									class="paging_mobile"
									src="../../Images/Ver1/Common/btn_board_next_m.gif" /></a></span></span>
					</div>
				</div>

			</section>

			<section class="item_content productqna">
				<input class='btnOverlay btnProductQnA' type='button' value='Q&A�ۼ�' onclick="window.open('qna.jsp', '�������', 'width=500, height=500, location=no, status=no, scrollbars=no, resizable=no, left=500, top=100' );"/>
				<div class='inner'>
					<div class='table'>
						<span class='tr ClickQna'> 
							<span class='td'>�亯�Ϸ�</span> 
							<span class='td type2'>title</span> 
							<span class='td'>date</span>
							<span class='td'>writer</span>
						</span>
						<div class='qna'>
							<span class='qna_q'>���Ű� CONTENT</span> 
							<span class='qna_a'>�Ǹ��� CONTENT</span>
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

			

			<input type="hidden" name="itemidx" value="2012140130" /> <input
				type="hidden" name="itemoptioncd" value="N" /> <input type="hidden"
				name="itemprice" value="3000" /> <input type="hidden" name="type" />
			<input type="hidden" name="opcnt" />
			
	<section class="item_content productqna">
		<input class='btnOverlay btnProductQnA' type='button' value='Q&A�ۼ�' data='btnProductQnA'>/>
		<div class='inner'>
			<div class='table'>
				<span class='tr ClickQna'> <span class='td'>�亯�Ϸ�</span> <span
					class='td type2'>�����ȸ�� �ȵǿ�</span> <span class='td'>2020-12-24</span>
					<span class='td'>gue**</span>
				</span>
				<div class='qna'>
					<span class='qna_q'>�����ȣ�� ���Դµ� �� �����ȸ�� �ȵǴ°ǰ���?������ ���´ٴ� ī����
						�Դµ� �����ȸ�ϸ� ��ȸ�� �ȵǿ�...</span> <span class='qna_a'>���� �ȳ��ϼ���.<br />��ȸ������
						���� ���� �����ּż� ������ �ֹ����� Ȯ���� ��ƽ��ϴ�. �Ф�<br />�ֹ��� ���� Ȥ�� �ֹ���ȣ�� Ȯ���� �ֽðų�
						[���������� 1577-9081]�� ���Ǹ� ��Ź�帳�ϴ�. <br />�����մϴ�. <br />
					<br /></span>
				</div>
			</div>
			<div class='table'>
				<span class='tr ClickQna'> <span class='td'>�亯�Ϸ�</span> <span
					class='td type2'>��ǰ����</span> <span class='td'>2020-12-23</span> <span
					class='td'>gmark**</span>
				</span>
				<div class='qna'>
					<span class='qna_q'>���ù߼��մϱ�?�˼��ؼ� ����ǰ���� �߼۹ٶ��ϴ�.</span> <span
						class='qna_a'>���� �ȳ��ϼ���.<br />�ֹ��Ͻ� ��ǰ�� 12�� 23�� ���
						���͵�Ƚ��ϴ�.<br />��ǰ ��� �� ���� 1~2�� �ȿ� ����� �Ϸ������&#44; �ù�� ���� �������� ���Ͽ�
						������� ������ �� �ִ� �� ���� ��Ź�帮��<br />����� ��ȣ�� Ȯ�� �� ��ǰ�� 12�� 26�� ��� �Ϸ�� ������
						Ȯ�εǰ� �ֽ��ϴ�. <br />�����մϴ�. <br /></span>
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
