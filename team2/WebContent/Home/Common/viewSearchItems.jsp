<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="ko">

<head>
<jsp:include page="/Home/inc/head.jsp" />
<script type="text/javascript">
	// 탭 클릭시 서버와 연결
	$(document).on("click",".ct",function(){
		var navCategory=$(this).attr("data-name");
		$("[name=navCategory]").val(navCategory);
		$(".frm").attr("action","../common/viewSearchItems.do").submit();
	});
	
	// 정렬 기준 변경시 서버와 연결
	
	$(document).on("change","#ord",function(){
		$(this).attr("selected");
		$(".frm").attr("action","../common/viewSearchItems.do").submit();
	});
	
	
	// 해당 탭 색상 및 글자 크기 변경
	$(document).ready(function(){
		var idx = $("[name=navCategory]").val();
		
		$("li[data-name]").each(function(){
			if($(this).attr("data-name")==idx){
				$(this).children().css("color","red");
			}
		});
	});
	
	function allPageMove(page){
		var ord=$("#ord").val();
		location.href="${contextPath}/common/viewSearchItems.do?pageNO="+page+"&ord="+ord+"&navCategory=${navCategory}&kwd=${kwd}";
	}
	
	$(document).ready(function(){
		$("#kwd").val("${kwd}");
	});
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
				<ul>	
					<li class="ct" data-name="all"><a href="javascript:void(0);" >전체</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</li> 
					<li class="ct" data-name="living"><a href="javascript:void(0);" >리빙</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</li> 
					<li class="ct" data-name="crafts"><a href="javascript:void(0);" >공예</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</li> 
					<li class="ct" data-name="fancy"><a href="javascript:void(0);" >문구</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</li>
					<li class="ct" data-name="food"><a href="javascript:void(0);">식품</a></li>
				</ul>
			</div>
			<section class="sec_cont">
				<form class="frm">
					<input type="hidden" name="pageNO" value="${Paging.pageNo}" />
					<input type="hidden" name="kwd" value="${kwd}" />
					<input type="hidden" name="navCategory" value="${navCategory}"/>
					<div class="inner">
						<div id="all">
							<div class="info">
								<c:choose>
									<c:when test="${count>0}">
										<span class="count">총 <strong>${count}</strong>개의 상품이 조회되었습니다.</span>
										<span class="selectbox"> 
											<select name="ord" id="ord">
												<option value="신상품순" <c:if test="${ord=='신상품순'}">selected=selected</c:if>>신상품순</option>
												<option value="낮은가격순" <c:if test="${ord=='낮은가격순'}">selected=selected</c:if>>낮은가격순</option>
												<option value="높은가격순" <c:if test="${ord=='높은가격순'}">selected=selected</c:if>>높은가격순</option>
											</select>
										</span>
									</c:when>
									<c:otherwise>
										<span class="count">총 <strong>0</strong>개의 상품이 조회되었습니다.</span>
									</c:otherwise>
								</c:choose>
								<ul class='itemList'>
								<c:forEach var="list" items="${list}">
									<li>
									<span class="img"> <!-- 사진 클릭했을때 그 인덱스값으로 가기 -->
										<a href="${contextPath}/${list.category}/viewContent.do?fd=${list.category}&num=${list.num}&productImageName=${list.productImageName1}">
											<img src="${contextPath}/download.do?fd=${list.category}&num=${list.num}&productImageName=${list.productImageName1}">
										</a> 
										<span class="hover"> <span class="wish "
											data-itemidx="2012110629"></span> <span class="cart"
											data-itemidx="2012110629" data-opidx="" data-itemoptioncd="N"></span>
										<span class="ps" data-itemidx="2012110629">0</span>
										</span>
									</span> 
										<span class="iteminfo"> 
											<span class="text"> <!-- 제목 클릭했을때 그 인덱스값으로 가기 -->
												<a href="${contextPath}/${list.category}/viewContent.do?fd=${list.category}&num=${list.num}&productImageName=${list.productImageName1}">
														${list.productName} <!-- 제목  -->
												</a>
											</span> 
											<span class="price"> <!-- 상품 가격 --> 
												<span class="won">${list.productPrice}<strong>원</strong></span>
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
							        <span class="btn_pageprev"><a href="javascript:allPageMove(${Paging.prevPage})"><img class="paging_pc" src="${contextPath}/Images/Ver1/Common/btn_board_prev.gif" /></a></span>
									<c:forEach var="i" begin="${Paging.startPage}" end="${Paging.endPage}" step="1">
										<c:choose>
											<c:when test="${i eq Paging.pageNo}">
												<span class="txt_pagenum"><a href="javascript:allPageMove(${i})">${i}</a></span>
											</c:when>
											<c:otherwise>
												<span class="txt_pagenum"><a href="javascript:allPageMove(${i})">${i}</a></span>
											</c:otherwise>
										</c:choose>
									</c:forEach>
																<!-- 번호 -->
									<span class="btn_pagenext"><a href="javascript:allPageMove(${Paging.nextPage})"><img class="paging_pc" src="${contextPath}/Images/Ver1/Common/btn_board_next.gif" /></a></span>
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
