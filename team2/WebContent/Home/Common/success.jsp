<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<jsp:include page="/Home/inc/head.jsp"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="${contextPath}/Home/Css/Common/payment.css" />
<title>Insert title here</title>
</head>
<body>
	<jsp:include page="../inc/hdr_menu.jsp" />
	<div id="CommonHeaderArea"></div>
	<div id="CommonHeader_M"></div>
	<div class="success">
		<h1>거래에 <b>성공</b>했습니다!</h1>
		<div class="itemInfo">
			<a href="${contextPath}/${paymentMap.fd}/viewContent.do?num=${paymentMap.num}">
				<img src="${contextPath}/download.do?fd=${paymentMap.fd}&num=${paymentMap.num}&productImageName=${paymentMap.productImageName}" />
			</a>
			<span id="content">
				<a href="${contextPath}/${paymentMap.fd}/viewContent.do?num=${paymentMap.num}">
					${paymentMap.productName}
				</a><br>
				${paymentMap.qty}개<br>
				${paymentMap.totalPrice}원
			</span>
		</div>
		<a href="${contextPath}/common/index.do" class="payBtn">홈으로</a>
	</div>
	<jsp:include page="../inc/footer.jsp" />
</body>
</html>