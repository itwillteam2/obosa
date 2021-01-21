<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<c:set var="orderList" value="${orderList}"/>

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
	<h1>주문 내역</h1>
	<c:choose>
		<c:when test="${empty orderList}">
			<table id="orderTable">
				<tr>
					<th>주문 내역이 존재하지 않습니다.</th>
				</tr>
			</table>
		</c:when>
		<c:otherwise>
			<table id="orderTable">
				<tr>
					<th id="orderNum"><div id="num">주문번호</div></th>
					<th id="order" colspan="2"><div id="list">주문내역</div></th>
					<th id="orderDate"><div id="date">주문일자</div></th>
				</tr>
				<c:forEach var="orderList" items="${orderList}">
					<tr>
						<td>${orderList.num}</td>
						<td class="order">
							상품명 : ${orderList.productName}<br>
							결제액 : ${orderList.price}<br>
						</td>
						<td class="btn">
							<input type="button" value="주문 상세" class="detailBtn" 
							onclick="location.href='${contextPath}/member/orderDetail.do?num=${orderList.num}'">
						</td>
						<td>
							${orderList.orderDate}
						</td>
					</tr>
				</c:forEach>
			</table>
		</c:otherwise>
	</c:choose>
	<jsp:include page="../inc/footer.jsp" />
</body>
</html>