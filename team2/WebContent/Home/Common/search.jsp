<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="ko">

<head>
<jsp:include page="/Home/inc/head.jsp" />
<script type="text/javascript">
	$(document).ready(function(){
		$("#kwd").val("${kwd}");
	});
	
	// 탭 클릭시 서버와 연결
	$(document).on("click",".ct",function(){
		var navCategory=$(this).attr("data-name");
		$("[name=navCategory]").val(navCategory);
		$(".frm").attr("action","../common/search.do").submit();
	});

	// 정렬 기준 변경시 서버와 연결
	$(document).on("change","#ord",function(){
		$(this).attr("selected");
		$(".frm").attr("action","../common/search.do").submit();
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
	
	function showAll(){
		var navCategory=$("[name=navCategory]").val();
		var ord=$("#ord").val();
		location.href="${contextPath}/common/viewSearchItems.do?kwd=${kwd}&navCategory="+navCategory+"&ord="+ord;
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
				<h1>상점이름 검색 결과</h1>
				<section class="sec_cont">
					<input type="hidden" name="page" value="1" />
					<div class="inner">
						<div class="info">
							<c:choose>
								<c:when test="${shopSearchCount > 0}">
									<span class="result">총 <strong>${shopSearchCount}</strong>개의 상점이 조회되었습니다.</span>
								</c:when>
								<c:otherwise>
									<span class="result">총 <strong>0</strong>개의 상점이 조회되었습니다.</span>
								</c:otherwise>
							</c:choose>
						</div>
						<ul class='itemList'>
							<c:forEach var="shopSearchList" items="${shopSearchList}">
								<span class="iteminfo">
									<a href="${contextPath}/common/viewSearchShop.do?kwd=${kwd}&shopName=${shopSearchList.sellerName}">
										<span class="searchSeller">${shopSearchList.sellerName}</span>
									</a>
								</span>
							</c:forEach>
						</ul>
					</div>
				</section>
			</div>
		<hr>
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
				<form class="frm" method="post">
					<input type="hidden" name="kwd" value="${kwd}">
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
								<c:forEach var="list" items="${list}" end="3">
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
							<c:choose>
								<c:when test="${count>0}">
									<div class="showAll"><a href="javascript:showAll()">결과 전체 보기</a></div>
								</c:when>
							</c:choose>
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
