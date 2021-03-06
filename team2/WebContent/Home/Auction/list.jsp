<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="ko">

<head>
<jsp:include page="/Home/inc/head.jsp"/>
<script type="text/javascript">
	$(document).on("change", "[name=ord]",function() {
		var ord = $(this).val();
		location.href="${contextPath}/living/list.do?ord="+ord;
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
			<form name="frm" action="${contextPath }/auction/auctionList.do">
				<input type="hidden" name="page" value="1" />

				<div class="inner">

					<div class="info">
						<span class="result">총 <strong>${listCount}</strong>개의 상품이 조회되었습니다.
						</span> 
						<span class="selectbox"> 
							<select name="ord" id="ord">
								<option value="신상품순" <c:if test="${ord=='신상품순'}">selected=selected</c:if>>신상품순</option>
								<option value="낮은가격순" <c:if test="${ord=='낮은가격순'}">selected=selected</c:if>>낮은가격순</option>
								<option value="높은가격순" <c:if test="${ord=='높은가격순'}">selected=selected</c:if>>높은가격순</option>
							</select>
						</span>
					</div>
					<ul class='itemList'>
						
						<!-- total Auction List -->
						<c:forEach var="auction" items="${articleList}">
							<li>
								<span class="img"> 
										<!-- 사진 클릭했을때 그 인덱스값으로 가기 -->
										<a href="">
											<!-- 이미지 불러오기 -->
											<img src="${contextPath }/">
										</a> 
											<span class="hover">
												<span class="wish " data-itemidx="2012110629"></span>										
												<span class="cart" data-itemidx="2012110629" data-opidx="" data-itemoptioncd="N"></span>
												<span class="ps" data-itemidx="2012110629">0</span>
											</span>
								</span> 
								<span class="iteminfo"> 
									<span class="text">
										<!-- 제목 클릭했을때 그 인덱스값으로 가기 -->
										<a href="" title="">
											 <!-- 제목  -->
										</a>
									</span>
									 <span class="price">
									 						<!-- 상품 가격 -->
								 		<span class="won"><strong>원</strong></span>
							 		</span><span class="stampicon new"></span>
								</span>
							</li>
						</c:forEach>



					
					</ul>
					<div class="clear"></div>
					
					<div class='paging'>
						<span class='box'>
							
							
							<!-- 번호 -->
							
					        <li><a href="javascript:PageMove(${paging.prevPageNo})">앞으로&nbsp; </a></li>



							
							<c:forEach var="i" begin="${paging.startPageNo }" end="${paging.endPageNo }" step="1">
								<c:choose>
									<c:when test="${i eq paging.pageNo }">
										<li class="active"><a href="javascript:PageMove(${i})">${i}</a></li>
									</c:when>
									<c:otherwise>
										<li><a href="javascript:PageMove(${i})">${i}</a></li>
									</c:otherwise>
								</c:choose>
							</c:forEach>
							
							<!-- 번호 -->
							<li><a href="javascript:PageMove(${paging.nextPageNo})">뒤로&nbsp; </a></li>
    					    



							
							
							
						</span>
					</div>
				</div>
			</form>
		</section>
	</div>
	<jsp:include page="/Home/inc/footer.jsp" />

</body>
</html>
