<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>결제시스템</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
</head>
<body>
    <script>
    $(function(){
        var IMP = window.IMP; // 생략가능
        IMP.init('iamport'); // 'iamport' 대신 부여받은 "가맹점 식별코드"를 사용
        var msg;
        
        IMP.request_pay({
            pg : 'inicis',
            pay_method : 'card',
            merchant_uid : 'merchant_' + new Date().getTime(),
            name : '${paymentMap.productName}',
            amount : '${paymentMap.totalPrice}',
            buyer_email : '${paymentMap.email}',
            buyer_name : '${paymentMap.name}',
            buyer_tel : '${paymentMap.cpnum}',
            buyer_addr : '${paymentMap.address}',
            buyer_postcode : '${paymentMap.postcode}',
            m_redirect_url : 'http://www.naver.com'
        }, function(rsp) {
            if (rsp.success ) {
                //[1] 서버단에서 결제정보 조회를 위해 jQuery ajax로 imp_uid 전달하기
                jQuery.ajax({
                    url: "/payments/complete", //cross-domain error가 발생하지 않도록 주의해주세요
                    type: 'POST',
                    dataType: 'json',
                    data: {
                        imp_uid : rsp.imp_uid
                        //기타 필요한 데이터가 있으면 추가 전달
                    }
                }).done(function(data) {
                    //[2] 서버에서 REST API로 결제정보확인 및 서비스루틴이 정상적인 경우
                    if ( everythings_fine ) {
                        msg = '결제가 완료되었습니다.';
                        msg += '\n고유ID : ' + rsp.imp_uid;
                        msg += '\n상점 거래ID : ' + rsp.merchant_uid;
                        msg += '\결제 금액 : ' + rsp.paid_amount;
                        msg += '카드 승인번호 : ' + rsp.apply_num;
                        alert(msg);
                    } else {
                    	msg + '결제에 실패하였습니다.';
                        alert(msg);
                    }
                });
                //성공시 이동할 페이지
                document.success.submit();
            } else {
                msg = '결제에 실패하였습니다.';
                msg += '에러내용 : ' + rsp.error_msg;
                alert(msg);
                //실패시 이동할 페이지
                location.href="${paymentMap.recentURI}";
            }
        });
    });
    </script> 
    <form action="${contextPath}/common/success.do" name="success"method="post">
    	<input type="hidden" name="oname" value="${paymentMap.oname}">
    	<input type="hidden" name="email" value="${paymentMap.email}">
    	<input type="hidden" name="cpnum" value="${paymentMap.cpnum}">
    	<input type="hidden" name="address" value="${paymentMap.address}">
    	<input type="hidden" name="postcode" value="${paymentMap.postcode}">
    	<input type="hidden" name="productName" value="${paymentMap.productName}">
    	<input type="hidden" name="qty" value="${paymentMap.qty}">
    	<input type="hidden" name="totalPrice" value="${paymentMap.totalPrice}">
    	<input type="hidden" name="fd" value="${paymentMap.fd}">
    	<input type="hidden" name="num" value="${paymentMap.num}">
    	<input type="hidden" name="productImageName" value="${paymentMap.productImageName}">
    	<input type="hidden" name="point" value="${paymentMap.point}">
    	<input type="hidden" name="gainPoint" value="${paymentMap.gainPoint}">
    	<input type="hidden" name="usingPoint" value="${paymentMap.usingPoint}">
    </form>
</body>
</html>
