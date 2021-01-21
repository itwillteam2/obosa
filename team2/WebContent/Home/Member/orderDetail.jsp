<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<jsp:include page="/Home/inc/head.jsp"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="${contextPath}/Home/Css/Common/order.css" />
<title>Insert title here</title>
</head>
<body>
	<jsp:include page="../inc/hdr_menu.jsp" />
	<div id="CommonHeaderArea"></div>
	<div id="CommonHeader_M"></div>
	<h1>주문 상세</h1>
	<table id="detailTable">
		<tr>
			<td class="th">주문번호</td>
			<td>${vo.num}</td>
			<td class="th">주문일자</td>
			<td>${vo.orderDate}</td>
		</tr>
		<tr>
			<td class="th">상품명</td>
			<td>
				${vo.productName}<br><br>
				수량 : ${vo.quantity}개
			</td>
			<td class="th">가격</td>
			<td>
				총 ${vo.price + vo.point}<br>
				포인트 ${vo.point} 사용<br>
				배송비 ${vo.shipping_fee}<br>
				<br>
				결제하신 금액 : ${vo.price}
			</td>
		</tr>
		<tr>
			<td class="th">배송지</td>
			<td>
				${vo.postcode}&nbsp;&nbsp;${vo.address}<br>
				${vo.name}
			</td>
			<td class="th">전화번호</td>
			<td>${vo.cpnum}</td>
		</tr>
		<tr>
			<td colspan="4" class="th">판매자</td>
		</tr>
		<tr>
			<td>${vo.sellerName }</td>
			<td>
				${seller.postcode}<br>
				${seller.addr1} ${seller.addr2}
			</td>
			<td>
				${seller.pnum}<br>
				${seller.cpnum}<br>
			</td>
			<td>
				${seller.email}
			</td>
		</tr>
	</table>
	<input type="button" value="목록으로" class="listBtn" 
	onclick="location.href='${contextPath}/member/orderList.do'">
	<jsp:include page="../inc/footer.jsp" />
</body>
</html>