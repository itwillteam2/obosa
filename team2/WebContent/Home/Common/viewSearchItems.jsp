<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="ko">

<head>
<jsp:include page="/Home/inc/head.jsp" />
<script type="text/javascript">
	for(var i=1; i<5; i++){
		$(document).on("change", "[name=ord"+i+"]",function() {
			var ord = $(this).val();
			var category = "all";
			
			if($("#all").css("display") != "none"){
				category = "all";
			}else if($("#living").css("display") != "none"){
				category = "living";
			}else if($("#crafts").css("display") != "none"){
				category = "crafts";
			}else if($("#fancy").css("display") != "none"){
				category = "fancy";
			}
			
			location.href="${contextPath}/common/viewSearchItems.do?ord="+ord+"&category="+category+"&type="+category+"&kwd="+${kwd};
		});
	}

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
	
	
	
	$(document).ready(function(){
		if("${category}"=="" || "${category}" == null || "${category}" =="all"){
			$("#alla").css("color", "red");
			
			$("#living").css("display", "none");
			$("#crafts").css("display", "none");
			$("#fancy").css("display", "none");
		}else if("${category}" == "living"){
			$("#all").css("display", "none");
			$("#living").css("display", "");
			$("#crafts").css("display", "none");
			$("#fancy").css("display", "none");
			
			$("#alla").css("color", "");
			$("#livinga").css("color", "red");
			$("#craftsa").css("color", "");
			$("#fancya").css("color", "");
		}else if("${category}" == "crafts"){
			$("#all").css("display", "none");
			$("#living").css("display", "none");
			$("#crafts").css("display", "");
			$("#fancy").css("display", "none");
			
			$("#alla").css("color", "");
			$("#livinga").css("color", "");
			$("#craftsa").css("color", "red");
			$("#fancya").css("color", "");
		}else if("${category}" == "fancy"){
			$("#all").css("display", "none");
			$("#living").css("display", "none");
			$("#crafts").css("display", "none");
			$("#fancy").css("display", "");
			
			$("#alla").css("color", "");
			$("#livinga").css("color", "");
			$("#craftsa").css("color", "");
			$("#fancya").css("color", "red");
		}
		
		$("#kwd").val("${kwd}");
		
		var type='${type}';
		if(type == "living"){
			$("#all").css("display", "none");
			$("#living").css("display", "");
			$("#crafts").css("display", "none");
			$("#fancy").css("display", "none");
			
			$("#alla").css("color", "");
			$("#livinga").css("color", "red");
			$("#craftsa").css("color", "");
			$("#fancya").css("color", "");
		}else if(type == "crafts"){
			$("#all").css("display", "none");
			$("#living").css("display", "none");
			$("#crafts").css("display", "");
			$("#fancy").css("display", "none");
			
			$("#alla").css("color", "");
			$("#livinga").css("color", "");
			$("#craftsa").css("color", "red");
			$("#fancya").css("color", "");
		}else if(type == "fancy"){
			$("#all").css("display", "none");
			$("#living").css("display", "none");
			$("#crafts").css("display", "none");
			$("#fancy").css("display", "");
			
			$("#alla").css("color", "");
			$("#livinga").css("color", "");
			$("#craftsa").css("color", "");
			$("#fancya").css("color", "red");
		}
	});
	
	function fnSelectAll(){
		$("#all").css("display", "");
		$("#living").css("display", "none");
		$("#crafts").css("display", "none");
		$("#fancy").css("display", "none");
		
		$("#alla").css("color", "red");
		$("#livinga").css("color", "");
		$("#craftsa").css("color", "");
		$("#fancya").css("color", "");
	}
	
	function fnSelectLiving(){
		$("#all").css("display", "none");
		$("#living").css("display", "");
		$("#crafts").css("display", "none");
		$("#fancy").css("display", "none");
		
		$("#alla").css("color", "");
		$("#livinga").css("color", "red");
		$("#craftsa").css("color", "");
		$("#fancya").css("color", "");
	}
	
	function fnSelectCrafts(){
		$("#all").css("display", "none");
		$("#living").css("display", "none");
		$("#crafts").css("display", "");
		$("#fancy").css("display", "none");
		
		$("#alla").css("color", "");
		$("#livinga").css("color", "");
		$("#craftsa").css("color", "red");
		$("#fancya").css("color", "");
	}
	
	function fnSelectFancy(){
		$("#all").css("display", "none");
		$("#living").css("display", "none");
		$("#crafts").css("display", "none");
		$("#fancy").css("display", "");
		
		$("#alla").css("color", "");
		$("#livinga").css("color", "");
		$("#craftsa").css("color", "");
		$("#fancya").css("color", "red");
	}
	
	function allPageMove(page){
		var ord=$("#ord1").val();
		location.href="http://localhost:8080/${contextPath}/common/viewSearchItems.do?allPageNO="+page+"&ord="+ord+"&category=all&type=all&kwd=${kwd}";
	}
	
	function livingPageMove(page){
		var ord=$("#ord2").val();
		location.href="http://localhost:8080/${contextPath}/common/viewSearchItems.do?livingPageNO="+page+"&ord="+ord+"&category=living&type=living&kwd=${kwd}";
	}
	
	function craftsPageMove(page){
		var ord=$("#ord3").val();
		location.href="http://localhost:8080/${contextPath}/common/viewSearchItems.do?craftsPageNO="+page+"&ord="+ord+"&category=crafts&type=crafts&kwd=${kwd}";
	}
	
	function fancyPageMove(page){
		var ord=$("#ord4").val();
		location.href="http://localhost:8080/${contextPath}/common/viewSearchItems.do?fancyPageNO="+page+"&ord="+ord+"&category=fancy&type=fancy&kwd=${kwd}";
	}
</script>
</head>
<body>

	<jsp:include page="/Home/inc/hdr_menu.jsp" />


	<div class="wrap">
		<section class="sec_header">
			<div class="inner"></div>
		</section>
		<div>
			<h1>상품 검색 결과</h1>
			<div class="categories">
				<a href="javascript:fnSelectAll();" id="alla">전체</a> &nbsp;&nbsp;&nbsp; | &nbsp;&nbsp;&nbsp; 
				<a href="javascript:fnSelectLiving();" id="livinga">리빙</a> &nbsp;&nbsp;&nbsp; | &nbsp;&nbsp;&nbsp; 
				<a href="javascript:fnSelectCrafts();" id="craftsa">공예</a> &nbsp;&nbsp;&nbsp; | &nbsp;&nbsp;&nbsp; 
				<a href="javascript:fnSelectFancy();" id="fancya">문구</a>
			</div>
			<section class="sec_cont">
				<form name="frm">
					<input type="hidden" name="page" value="1" />
					<div class="inner">
						<div id="all">
							<div class="info">
								<c:choose>
									<c:when test="${searchCount>0}">
										<span class="count">총 <strong>${searchCount}</strong>개의 상품이 조회되었습니다.</span>
										<span class="selectbox"> 
											<c:choose>
												<c:when test="${category == 'all'}">
													<select name="ord1" id="ord1">
														<option value="신상품순" <c:if test="${ord=='신상품순'}">selected=selected</c:if>>신상품순</option>
														<option value="낮은가격순" <c:if test="${ord=='낮은가격순'}">selected=selected</c:if>>낮은가격순</option>
														<option value="높은가격순" <c:if test="${ord=='높은가격순'}">selected=selected</c:if>>높은가격순</option>
													</select>
												</c:when>
												<c:otherwise>
													<select name="ord1" id="ord1">
														<option value="신상품순" selected="selected">신상품순</option>
														<option value="낮은가격순">낮은가격순</option>
														<option value="높은가격순">높은가격순</option>
													</select>
												</c:otherwise>
											</c:choose>
										</span>
									</c:when>
									<c:otherwise>
										<span class="count">총 <strong>0</strong>개의 상품이 조회되었습니다.</span>
									</c:otherwise>
								</c:choose>
								<ul class='itemList'>
								<c:forEach var="searchList" items="${searchList}">
									<li>
									<span class="img"> <!-- 사진 클릭했을때 그 인덱스값으로 가기 -->
										<a href="${contextPath}/${searchList.category}/viewContent.do?fd=living&num=${searchList.num}&productImageName=${searchList.productImageName1}">
												<!-- 이미지 불러오기 --> 
												<img src="${contextPath}/download.do?fd=${searchList.category}&num=${searchList.num}&productImageName=${searchList.productImageName1}">
										</a> 
										<span class="hover"> <span class="wish "
											data-itemidx="2012110629"></span> <span class="cart"
											data-itemidx="2012110629" data-opidx="" data-itemoptioncd="N"></span>
										<span class="ps" data-itemidx="2012110629">0</span>
										</span>
									</span> 
										<span class="iteminfo"> 
											<span class="text"> <!-- 제목 클릭했을때 그 인덱스값으로 가기 -->
												<a href="/home/shop/itemdetail.asp?itemidx=2012110629" title="미니파우치 뽀글 지퍼주머니 체리 (37002942)">
														${searchList.productName} <!-- 제목  -->
												</a>
											</span> 
											<span class="price"> <!-- 상품 가격 --> 
												<span class="won">${searchList.productPrice}<strong>원</strong></span>
											</span>
											<span class="stampicon new"></span>
										</span>
									</li>
								</c:forEach>
							</ul>
							<div class="clear"></div>
							<div class='paging'>
								<span class='box'>
									<!-- 번호 -->							
							        <span class="btn_pageprev"><a href="javascript:allPageMove(${allPaging.prevPage})"><img class="paging_pc" src="${contextPath}/Images/Ver1/Common/btn_board_prev.gif" /></a></span>
									<c:forEach var="i" begin="${allPaging.startPage}" end="${allPaging.endPage}" step="1">
										<c:choose>
											<c:when test="${i eq allPaging.pageNo}">
												<span class="txt_pagenum"><a href="javascript:allPageMove(${i})">${i}</a></span>
											</c:when>
											<c:otherwise>
												<span class="txt_pagenum"><a href="javascript:allPageMove(${i})">${i}</a></span>
											</c:otherwise>
										</c:choose>
									</c:forEach>
																<!-- 번호 -->
									<span class="btn_pagenext"><a href="javascript:allPageMove(${allPaging.nextPage})"><img class="paging_pc" src="${contextPath}/Images/Ver1/Common/btn_board_next.gif" /></a></span>
								</span>
							</div>
						</div>
						</div>
						
						<div id="living">
							<div class="info">
								<c:choose>
									<c:when test="${livingCount>0}">
										<span class="count">총 <strong>${livingCount}</strong>개의 상품이 조회되었습니다.</span>
										<span class="selectbox"> 
											<c:choose>
												<c:when test="${category == 'living'}">
													<select name="ord2" id="ord2">
														<option value="신상품순" <c:if test="${ord=='신상품순'}">selected=selected</c:if>>신상품순</option>
														<option value="낮은가격순" <c:if test="${ord=='낮은가격순'}">selected=selected</c:if>>낮은가격순</option>
														<option value="높은가격순" <c:if test="${ord=='높은가격순'}">selected=selected</c:if>>높은가격순</option>
													</select>
												</c:when>
												<c:otherwise>
													<select name="ord2" id="ord2">
														<option value="신상품순" selected="selected">신상품순</option>
														<option value="낮은가격순">낮은가격순</option>
														<option value="높은가격순">높은가격순</option>
													</select>
												</c:otherwise>
											</c:choose>
										</span>
									</c:when>
									<c:otherwise>
										<span class="count">총 <strong>0</strong>개의 상품이 조회되었습니다.</span>
									</c:otherwise>
								</c:choose>
								<ul class='itemList'>
									<c:forEach var="searchLiving" items="${searchLiving}">
										<li>
										<span class="img"> <!-- 사진 클릭했을때 그 인덱스값으로 가기 -->
											<a href="${contextPath}/living/viewContent.do?fd=living&num=${searchLiving.num}&productImageName=${searchLiving.productImageName1}">
													<!-- 이미지 불러오기 --> 
													<img src="${contextPath}/download.do?fd=living&num=${searchLiving.num}&productImageName=${searchLiving.productImageName1}">
											</a> 
											<span class="hover"> <span class="wish "
												data-itemidx="2012110629"></span> <span class="cart"
												data-itemidx="2012110629" data-opidx="" data-itemoptioncd="N"></span>
											<span class="ps" data-itemidx="2012110629">0</span>
											</span>
										</span> 
											<span class="iteminfo"> 
												<span class="text"> <!-- 제목 클릭했을때 그 인덱스값으로 가기 -->
													<a href="/home/shop/itemdetail.asp?itemidx=2012110629" title="미니파우치 뽀글 지퍼주머니 체리 (37002942)">
															${searchLiving.productName} <!-- 제목  -->
													</a>
												</span> 
												<span class="price"> <!-- 상품 가격 --> 
													<span class="won">${searchLiving.productPrice}<strong>원</strong></span>
												</span>
												<span class="stampicon new"></span>
											</span>
										</li>
									</c:forEach>
								</ul>
								<div class="clear"></div>
								<div class='paging'>
									<span class='box'>
										<!-- 번호 -->							
								        <span class="btn_pageprev"><a href="javascript:livingPageMove(${livingPaging.prevPage})"><img class="paging_pc" src="${contextPath}/Images/Ver1/Common/btn_board_prev.gif" /></a></span>
										<c:forEach var="i" begin="${livingPaging.startPage}" end="${livingPaging.endPage}" step="1">
											<c:choose>
												<c:when test="${i eq livingPaging.pageNo}">
													<span class="txt_pagenum"><a href="javascript:livingPageMove(${i})">${i}</a></span>
												</c:when>
												<c:otherwise>
													<span class="txt_pagenum"><a href="javascript:livingPageMove(${i})">${i}</a></span>
												</c:otherwise>
											</c:choose>
										</c:forEach>
																	<!-- 번호 -->
										<span class="btn_pagenext"><a href="javascript:livingPageMove(${livingPaging.nextPage})"><img class="paging_pc" src="${contextPath}/Images/Ver1/Common/btn_board_next.gif" /></a></span>
									</span>
								</div>
							</div>
						</div>
						
						<div id="crafts">
							<div class="info">
								<c:choose>
									<c:when test="${craftsCount>0}">
										<span class="count">총 <strong>${craftsCount}</strong>개의 상품이 조회되었습니다.</span>
										<span class="selectbox"> 
										<c:choose>
												<c:when test="${category == 'crafts'}">
													<select name="ord3" id="ord3">
														<option value="신상품순" <c:if test="${ord=='신상품순'}">selected=selected</c:if>>신상품순</option>
														<option value="낮은가격순" <c:if test="${ord=='낮은가격순'}">selected=selected</c:if>>낮은가격순</option>
														<option value="높은가격순" <c:if test="${ord=='높은가격순'}">selected=selected</c:if>>높은가격순</option>
													</select>
												</c:when>
												<c:otherwise>
													<select name="ord3" id="ord3">
														<option value="신상품순" selected="selected">신상품순</option>
														<option value="낮은가격순">낮은가격순</option>
														<option value="높은가격순">높은가격순</option>
													</select>
												</c:otherwise>
											</c:choose>
									</span>
									</c:when>
									<c:otherwise>
										<span class="count">총 <strong>0</strong>개의 상품이 조회되었습니다.</span>
									</c:otherwise>
								</c:choose>
								<ul class='itemList'>
									<c:forEach var="searchCrafts" items="${searchCrafts}">
										<li>
										<span class="img"> <!-- 사진 클릭했을때 그 인덱스값으로 가기 -->
											<a href="${contextPath}/crafts/viewContent.do?fd=living&num=${searchCrafts.num}&productImageName=${searchCrafts.productImageName1}">
													<!-- 이미지 불러오기 --> 
													<img src="${contextPath}/download.do?fd=crafts&num=${searchCrafts.num}&productImageName=${searchCrafts.productImageName1}">
											</a> 
											<span class="hover"> <span class="wish "
												data-itemidx="2012110629"></span> <span class="cart"
												data-itemidx="2012110629" data-opidx="" data-itemoptioncd="N"></span>
											<span class="ps" data-itemidx="2012110629">0</span>
											</span>
										</span> 
											<span class="iteminfo"> 
												<span class="text"> <!-- 제목 클릭했을때 그 인덱스값으로 가기 -->
													<a href="/home/shop/itemdetail.asp?itemidx=2012110629" title="미니파우치 뽀글 지퍼주머니 체리 (37002942)">
															${searchCrafts.productName} <!-- 제목  -->
													</a>
												</span> 
												<span class="price"> <!-- 상품 가격 --> 
													<span class="won">${searchCrafts.productPrice}<strong>원</strong></span>
												</span>
												<span class="stampicon new"></span>
											</span>
										</li>
									</c:forEach>
								</ul>
								<div class="clear"></div>
								<div class='paging'>
									<span class='box'>
										<!-- 번호 -->							
								        <span class="btn_pageprev"><a href="javascript:craftsPageMove(${craftsPaging.prevPage})"><img class="paging_pc" src="${contextPath}/Images/Ver1/Common/btn_board_prev.gif" /></a></span>
										<c:forEach var="i" begin="${craftsPaging.startPage}" end="${craftsPaging.endPage}" step="1">
											<c:choose>
												<c:when test="${i eq craftsPaging.pageNo}">
													<span class="txt_pagenum"><a href="javascript:craftsPageMove(${i})">${i}</a></span>
												</c:when>
												<c:otherwise>
													<span class="txt_pagenum"><a href="javascript:craftsPageMove(${i})">${i}</a></span>
												</c:otherwise>
											</c:choose>
										</c:forEach>
																	<!-- 번호 -->
										<span class="btn_pagenext"><a href="javascript:craftsageMove(${craftsPaging.nextPage})"><img class="paging_pc" src="${contextPath}/Images/Ver1/Common/btn_board_next.gif" /></a></span>
									</span>
								</div>
							</div>
						</div>
						
						<div id="fancy">
							<div class="info">
								<c:choose>
									<c:when test="${fancyCount>0}">
										<span class="count">총 <strong>${fancyCount}</strong>개의 상품이 조회되었습니다.</span>
										<span class="selectbox"> 
											<c:choose>
												<c:when test="${category == 'fancy'}">
													<select name="ord4" id="ord4">
														<option value="신상품순" <c:if test="${ord=='신상품순'}">selected=selected</c:if>>신상품순</option>
														<option value="낮은가격순" <c:if test="${ord=='낮은가격순'}">selected=selected</c:if>>낮은가격순</option>
														<option value="높은가격순" <c:if test="${ord=='높은가격순'}">selected=selected</c:if>>높은가격순</option>
													</select>
												</c:when>
												<c:otherwise>
													<select name="ord4" id="ord4">
														<option value="신상품순" selected="selected">신상품순</option>
														<option value="낮은가격순">낮은가격순</option>
														<option value="높은가격순">높은가격순</option>
													</select>
												</c:otherwise>
											</c:choose>
										</span>
									</c:when>
									<c:otherwise>
										<span class="count">총 <strong>0</strong>개의 상품이 조회되었습니다.</span>
									</c:otherwise>
								</c:choose>
								<ul class='itemList'>
									<c:forEach var="searchFancy" items="${searchFancy}">
										<li>
										<span class="img"> <!-- 사진 클릭했을때 그 인덱스값으로 가기 -->
											<a href="${contextPath}/fancy/viewContent.do?fd=living&num=${searchFancy.num}&productImageName=${searchFancy.productImageName1}">
													<!-- 이미지 불러오기 --> 
													<img src="${contextPath}/download.do?fd=fancy&num=${searchFancy.num}&productImageName=${searchCrafts.productImageName1}">
											</a> 
											<span class="hover"> <span class="wish "
												data-itemidx="2012110629"></span> <span class="cart"
												data-itemidx="2012110629" data-opidx="" data-itemoptioncd="N"></span>
											<span class="ps" data-itemidx="2012110629">0</span>
											</span>
										</span> 
											<span class="iteminfo"> 
												<span class="text"> <!-- 제목 클릭했을때 그 인덱스값으로 가기 -->
													<a href="/home/shop/itemdetail.asp?itemidx=2012110629" title="미니파우치 뽀글 지퍼주머니 체리 (37002942)">
															${searchFancy.productName} <!-- 제목  -->
													</a>
												</span> 
												<span class="price"> <!-- 상품 가격 --> 
													<span class="won">${searchFancy.productPrice}<strong>원</strong></span>
												</span>
												<span class="stampicon new"></span>
											</span>
										</li>
									</c:forEach>
								</ul>
								<div class="clear"></div>
								<div class='paging'>
									<span class='box'>
										<!-- 번호 -->							
								        <span class="btn_pageprev"><a href="javascript:fancyPageMove(${fancyPaging.prevPage})"><img class="paging_pc" src="${contextPath}/Images/Ver1/Common/btn_board_prev.gif" /></a></span>
										<c:forEach var="i" begin="${fancyPaging.startPage}" end="${fancyPaging.endPage}" step="1">
											<c:choose>
												<c:when test="${i eq fancyPaging.pageNo}">
													<span class="txt_pagenum"><a href="javascript:fancyPageMove(${i})">${i}</a></span>
												</c:when>
												<c:otherwise>
													<span class="txt_pagenum"><a href="javascript:fancyPageMove(${i})">${i}</a></span>
												</c:otherwise>
											</c:choose>
										</c:forEach>
																	<!-- 번호 -->
										<span class="btn_pagenext"><a href="javascript:fancyPageMove(${fancyPaging.nextPage})"><img class="paging_pc" src="${contextPath}/Images/Ver1/Common/btn_board_next.gif" /></a></span>
									</span>
								</div>
							</div>
						</div>
					</div>
				</form>
			</section>
		</div>
	</div>
	<jsp:include page="/Home/inc/footer.jsp" />
</body>
</html>
