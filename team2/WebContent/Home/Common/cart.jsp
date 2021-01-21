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
<script type="text/javascript">
$(document).ready(function(){
	var id = "${id}";
	if(id==""){
		alert("회원 전용 페이지입니다. \n로그인 페이지로 이동합니다.");
		location.href="${contextPath}/member/login.do";
	}	
});

$(document).on("click","#checkAll", function(){
	        $(".bottom").prop("checked",this.checked);
	        var price=totalSum();
		    $("#selTotalPrice").val(price);
});

//주문 수량
	$(document).on("click", ".btnStockQty", function() {
		var obj = $(this).parent().find("input[type=tel]");
        var price = $(this).parent().find("span[class=productPrice]").attr("data-productPrice"); 
        var shipping_fee = $(this).parent().find("span[class=shipping_fee]").attr("data-shipping_fee"); 
        
		if ($(this).hasClass("Minus")) {
			if (parseInt(obj.val(), 10) - 1 <= 0) {
				alert("주문수량은 1 이상이어야 합니다.");
				obj.val("1");
			} else { obj.val(parseInt(obj.val(), 10) - 1); }
		}

		if ($(this).hasClass("Plus")) {	obj.val(parseInt(obj.val(), 10) + 1);}
		var total=price * parseInt(obj.val(), 10) + parseInt(shipping_fee, 10);
		$(this).parents(".pdtOrder").find("input[name='totalPrice']").val(total);
	}); 
	 
// 서브밋 링크 
	// 장바구니 수정
	$(document).on("click", ".btnCart", function() {
		var form = $(this).parent().serialize();
			$.ajax({
				type:"post",
				async:true,
				url:"${contextPath}/cart/modCart.do",  
				data: form,
				contentType: 'application/x-www-form-urlencoded; charset=UTF-8', 
		        dataType: 'html',
				success:function(result,textStatus){ history.go(0);	},
				error:function(result,textStatus){ alert("페이지 새로 고침");	}
				});
	});

// 장바구니 삭제
	$(document).on("click",".btnDelCart", function() {
		var form = $(this).parent().serialize();
		$.ajax({
			type:"post",
			async:true,
			url:"${contextPath}/cart/delCart.do",  
			data: form,
			contentType: 'application/x-www-form-urlencoded; charset=UTF-8', 
	        dataType: 'html',
			success:function(result,textStatus){
				history.go(0);
			},
			error:function(result,textStatus){
				alert("다시 시도해 주시기 바랍니다.");
			}
			});
		});

	// 장바구니 선택 삭제
	$(document).on("click","#selDelete", function() {
		var forms = $('input[name="selCart"]:checked').parent().serialize();
		$.ajax({
			type:"post",
			async:true,
			url:"${contextPath}/cart/delChkCart.do",  
			data: forms,
			contentType: 'application/x-www-form-urlencoded; charset=UTF-8', 
	        dataType: 'html',
			success:function(result,textStatus){
				history.go(0);
			},
			error:function(result,textStatus){
				alert("다시 시도해 주시기 바랍니다.");
			}
			});
		});
		
	// 선택 주문
	$(document).on("click","#selOrder", function() {
		var forms = $('input[name="selCart"]:checked').parent().serialize();
		$.ajax({
			type:"post",
			async:true,
			url:"${contextPath}/cart/",  
			data: forms,
			contentType: 'application/x-www-form-urlencoded; charset=UTF-8', 
	        dataType: 'html',
			success:function(result,textStatus){
				history.go(0);
			},
			error:function(result,textStatus){
				alert("다시 시도해 주시기 바랍니다.");
			}
			});
		});
		
	
	// 상품 주문
	$(document).on("click", ".btnOrder", function() {
			var category = $(this).parent().find("input[name=category]").val();	  
			var pnum= $(this).parent().find("input[name=pnum]").val();
			var qty= $(this).parent().find("input[type=tel]").val();
			location.href="${contextPath}/common/payment.do?fd="+category+"&num="+pnum+"&qty="+qty;
	});
	
	$(document).on("change", "input[name=selCart]", function() {
		$("#checkAll").prop("checked",false);
		var price=totalSum();
	    $("#selTotalPrice").val(price);
	});
	
	function totalSum(){
		var obj = $(".cart").find("input[name=selCart]:checked");
		var totalSum=0;

		obj.each(function(){
	 		result = $(this).siblings().find("input[name=totalPrice]").val();
	 		totalSum +=  parseInt(result, 10);
		});
	 return totalSum;
	}
	
	
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
<input type="text" id="selTotalPrice" value=""/>
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
