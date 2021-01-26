<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<c:set var="recentURI" value="${header.referer}"/>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<jsp:include page="/Home/inc/head.jsp"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="${contextPath}/Home/Css/Common/payment.css" />
<title>Insert title here</title>
</head>
<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<script>
$(document).ready(function(){
	 var cpnum = "${user.cpnum}";
	 var cpnumlist = cpnum.split("-");
	 var cpnum1 = cpnumlist[0];
	 var cpnum2 = cpnumlist[1];
	 var cpnum3 = cpnumlist[2];
    $("#cpnum1").val(cpnum1);
    $("#cpnum2").val(cpnum2);
    $("#cpnum3").val(cpnum3);
    
    $('input[name="pay"]').change(function() {
    	$('input[name="pay"]').each(function() {
            var value = $(this).val();
            var checked = $(this).prop('checked');
            if(checked){
            	if(value == "무통장입금" || value == "에스크로" || value == "휴대폰"){
        			alert("해당 결제방법은 현재 준비중입니다.");
        			$('input[value="카드"]').prop("checked", "checked");
        			return;
        		}
            }
    	});
    });
    
    if($("#insertPoint").change(function(){
    	var now = ${item.productPrice * qty + item.shipping_fee};
    	var point = $("#insertPoint").val();
    	$("#total").text(now - point);
    }));
});
	
fnGetAddressInfo = function(){
	new daum.Postcode({
		oncomplete: function(data) {
			// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

			// 각 주소의 노출 규칙에 따라 주소를 조합한다.
			// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
			var addr = ''; // 주소 변수
			var extraAddr = ''; // 참고항목 변수

			//사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
			if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
				addr = data.roadAddress;
			} else { // 사용자가 지번 주소를 선택했을 경우(J)
				addr = data.jibunAddress;
			}

			// 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
			if(data.userSelectedType === 'R'){
				// 법정동명이 있을 경우 추가한다. (법정리는 제외)
				// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
				if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
					extraAddr += data.bname;
				}
				// 건물명이 있고, 공동주택일 경우 추가한다.
				if(data.buildingName !== '' && data.apartment === 'Y'){
					extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
				}
				// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
				if(extraAddr !== ''){
					extraAddr = ' (' + extraAddr + ')';
				}
			}

			// 우편번호와 주소 정보를 해당 필드에 넣는다.
			document.getElementById('postcode').value = data.zonecode;
			document.getElementById("addr1").value = addr + extraAddr;
			// 커서를 상세주소 필드로 이동한다.
			document.getElementById("addr2").focus();
			}
		}).open();
}

function submitPay(){
	if($("#name").val() == "" || $("#name").val() == null){
		alert("수취인명을 입력해주세요.");
		$("#name").focus();
		return;
	}else if($("#cpnum1").val() == "" || $("#cpnum1").val() == null){
		alert("휴대전화번호를 입력해주세요");
		$("#cpnum1").focus();
		return;
	}else if($("#cpnum2").val() == "" || $("#cpnum2").val() == null){
		alert("휴대전화번호를 입력해주세요");
		$("#cpnum2").focus();
		return;
	}else if($("#cpnum3").val() == "" || $("#cpnum3").val() == null){
		alert("휴대전화번호를 입력해주세요");
		$("#cpnum3").focus();
		return;
	}else if($("#postcode").val() == "" || $("#postcode").val() == null){
		alert("주소를 입력해주세요");
		$("#addrBtn").focus();
		return;
	}else if($("#addr1").val() == "" || $("#addr1").val() == null){
		alert("주소를 입력해주세요");
		$("#addrBtn").focus();
		return;
	}else if($("#addr2").val() == "" || $("#addr2").val() == null){
		alert("주소를 입력해주세요");
		$("#addr2").focus();
		return;
	}else if($("#email").val() == "" || $("#email").val() == null){
		alert("메일을 입력해주세요");
		$("#email").focus();
		return;
	}else{
		var cpnum = $("#cpnum1").val()+"-"+$("#cpnum2").val()+"-"+$("#cpnum3").val();
		$("#cpnum").val(cpnum);
		
		var address = $("#addr1").val() + " " + $("#addr2").val();
		$("#address").val(address);
		
		var now = ${item.productPrice * qty + item.shipping_fee};
		var point = $("#insertPoint").val();
		$("input[type=hidden][name=totalPrice]").val($("#total").text());
		
		document.payForm.submit();
	}
}

function onlyNumber(event) {
	event = event || window.event;
	var keyID = (event.which) ? event.which : event.keyCode;
	if ((keyID >= 48 && keyID <= 57) || (keyID >= 96 && keyID <= 105)
			|| keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39)
		return;
	else
		return false;
}

function removeChar(event) {
	event = event || window.event;
	var keyID = (event.which) ? event.which : event.keyCode;
	if (keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39)
		return;
	else
		event.target.value = event.target.value.replace(/[^0-9]/g, "");
}

function p(){
	$("#insertPoint").val("${user.point}");
	var now = ${item.productPrice * qty + item.shipping_fee};
	var point = $("#insertPoint").val();
	$("#total").text(now - point);
}
</script>
<body>
	<jsp:include page="../inc/hdr_menu.jsp" />
	<div id="CommonHeaderArea"></div>
	<div id="CommonHeader_M"></div>
	<form action="${contextPath}/common/pay.do" name="payForm" method="post">
		<input type="hidden" name="recentURI" value="${recentURI}">
		<div class="payment">
			<h3>주문상품</h3>
			<div class="items">
				<img src="${contextPath}/download.do?fd=${fd}&num=${num}&productImageName=${item.productImageName1}" />
				<input type="hidden" name="fd" value="${fd}">
				<input type="hidden" name="num" value="${num}">
				<input type="hidden" name="productImageName" value="${item.productImageName1}">
				<div id="item">
					${item.sellerName}<br>
					${item.productName}<br>
			</div>
			<div class="clear"></div>
			<input class='btnOverlay btnProductQnA' type='button' value='상품후기 작성'  onclick="window.open('${contextPath}/Home/Common/review.jsp?fd=${fd}&num=${num}', '상품후기등록', 'width=500, height=600, location=no, status=no, scrollbars=no, resizable=no, left=500, top=100' );"  />
			</div>
		</div>
	</form>
	<jsp:include page="../inc/footer.jsp" />
</body>
</html>