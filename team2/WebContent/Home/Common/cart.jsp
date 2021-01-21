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
<link rel="stylesheet" type="text/css" href="${contextPath}/Home/Css/Shop/Cart.css" />
<script type="text/javascript" src="${contextPath}/Home/Js/Shop/cart.js"></script>
<script type="text/javascript">
</script>
</head>
<body>
<jsp:include page="../inc/hdr_menu.jsp" />
<div id="CommonHeaderArea"></div>
<div id="CommonHeader_M"></div>
<div id="clear"></div>
<div class="wrap">
<input type="button" id="selDelete" value="선택 삭제"/>
<input type="button" id="selOrder" value="선택 주문"/>
<input type="checkbox" id="checkAll" />
<span class="selTotalPrice"></span>
<c:forEach var="cart" items="${cart}">
<div class="line"></div>
<div class="pdt">
<form class="cart" method="post" action="" target="_self">

	<div class="imagePreview">
		<img src="${contextPath}/download.do?fd=${cart.category}&num=${cart.pnum}&productImageName=${cart.productImageName1}" />
	</div>
	<div class="pdtInfo">
			<span class="productName" >
				${cart.productName}
			</span>
			<span class="sellerName" >
				${cart.sellerName}
			</span>
		<div class="pdtOrder">
				<span class="productPrice" data-productPrice="${cart.productPrice}">${cart.productPrice}</span> 
				<span class="shipping_fee" data-shipping_fee="${cart.shipping_fee}">${cart.shipping_fee}</span>
				<span class="btnStockQty"></span>
				<input type="button" class="btnStockQty Minus" value="-" /> 
				<input type="tel" name="cartQuantity" value="${cart.cartQuantity}" maxlength="3" />
				<input type="button" class="btnStockQty Plus" value="+" /> 
			<span class="totalPrice">
			    <input type="text" name="totalPrice" value="${cart.totalPrice}"/>원
				<input type="hidden" name="pnum" value="${cart.pnum}"/>
				<input type="hidden" name="category" value="${cart.category}"/>
				<input type="hidden" name="customer_id" value="${cart.customer_id}"/>	
				<input type="hidden" name="productName" value="${cart.productName}"/>	
				<input type="hidden" name="sellerName" value="${cart.sellerName}"/>	
			</span>
		</div>
	</div>
	<input type="checkbox" class="bottom" name="selCart" />
	<input type="button" class="bottom btnDelCart" value="삭제" />
	<input type="button" class="bottom btnCart" value="수정" />
	<input type="button" class="bottom btnOrder" value="주문하기" />
</form>
</div>
<div class="line"></div>
</c:forEach>
</div>
<jsp:include page="../inc/footer.jsp" />
</body>
</html>
