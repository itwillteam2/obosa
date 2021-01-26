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
		location.href="${contextPath}/${category}/list.do?ord="+ord;			
});

$(document).on({
	mouseenter : function() {
		$(this).find(".hover").addClass("on");
	
		var obj=$(this).find(".ps");
		var _pnum =obj.attr("data-pnum");
		$.post("${contextPath}/${category}/countRep.do",  
			{pnum:_pnum},
			function(result,textStatus){obj.text(result);
	      });
	
		var grdObj=$(this).find(".hover");
		$.post("${contextPath}/${category}/countAvg.do",  
			{pnum:_pnum},
				function(result,textStatus){
				var score = parseInt(result,10);
				grdObj.children().each(function(){
					if($(this).attr("data-grd")<=score){
							$(this).addClass("on");
						}else{
							$(this).removeClass("on");
						}
				});
		 });
	},
	mouseleave : function() {
		$(this).find(".hover").removeClass("on");
	}
}, ".itemList>li");


// 장바구니 등록
$(document).on(	"click", ".hover>.cart", function() {
	if("${id}"!=""){
	$(location).attr("href",
				"${contextPath}/cart/addCart.do?"
						+"category="+ $(this).attr("data-category") 
						+"&pnum="+ $(this).attr("data-pnum")
						+"&cartQuantity=1");
	
	    cartCount();
	}else{
		alert("회원 전용 서비스 입니다.");
	}
});
	
$(document).on(	"click", ".hover>.ps", function() {
	 var pnum =$(this).attr("data-pnum");
    location.href="${contextPath}/${category}/viewContent.do?&num="+pnum;

});

$(document).on("click", ".overlay_close,.btnGoShopping", function() {
	$(".overlay").removeClass("on");
});

$(document).on("click", ".overlay_close,.btnGoShopping", function() {
	$(".overlay").removeClass("on");
});

$(document).on("click", ".overlay_close,.btnGoShopping", function() {
	$(".overlay").removeClass("on");
});

// 페이지 이동
function PageMove(page){
	var ord = $("#ord option:selected").val();
	location.href="${contextPath}/${category}/list.do?pageNO="+page;
		}


</script>
</head>
<body>
	<jsp:include page="/Home/inc/hdr_menu.jsp" />

	<div class="wrap">
	
		<section class="sec_cont">
			<form name="frm" action="${contextPath}/${category}/list.do">
				<input type="hidden" name="page" value="1" />

				<div class="inner">

					<div class="info">
						<span class="result">총 <strong>${totalCount}</strong>개의 상품이 조회되었습니다.
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
					<c:forEach var="content" items="${contentList}">	
							<li>
								<span class="img"> 
										<!-- 사진 클릭했을때 그 인덱스값으로 가기 -->
										<a href="${contextPath}/${category}/viewContent.do?num=${content.num}">
											<!-- 이미지 불러오기 -->
											<img src="${contextPath}/download.do?fd=${category}&num=${content.num}&productImageName=${content.productImageName1}">
										</a> 
											<span class="hover" id="${content.num}">
												<span class="wish" data-grd="1"></span>	
												<span class="wish" data-grd="2"></span>	
												<span class="wish" data-grd="3"></span>	
												<span class="wish" data-grd="4"></span>	
												<span class="wish" data-grd="5"></span>	
												<span class="cart" data-pnum="${content.num}" data-category="${category}" data-opt="cart"></span>
												<span class="ps" data-pnum="${content.num}" data-category="${category}" data-opt="ps"></span>
											</span>
								</span> 
								<span class="iteminfo"> 
									<span class="text">
										<!-- 제목 클릭했을때 그 인덱스값으로 가기 -->
										<a href="${contextPath}/${category}/viewContent.do?num=${content.num}">
											${content.productName } <!-- 제목  -->
										</a>
									</span>
									 <span class="price">
									 						<!-- 상품 가격 -->
								 		<span class="won">${content.productPrice }<strong>원</strong></span>
							 		</span><span class="stampicon new"></span>
								</span>
							</li>
						</c:forEach>
					</ul>
					<div class="clear"></div>
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
			</form>
		</section>
	</div>
	<jsp:include page="/Home/inc/footer.jsp" />

</body>
</html>
