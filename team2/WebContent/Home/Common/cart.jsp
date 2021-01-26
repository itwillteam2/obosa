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
/**
cart script* 
*/

$(document).ready(function(){
   var id = "${id}";
   if(id==""){
      alert("회원 전용 페이지입니다. \n로그인 페이지로 이동합니다.");
      location.href='${contextPath}/member/login.do';
   }   

   total();
   
});

$(document).on("click","#checkAll", function(){
   $(".bottom").prop("checked",this.checked);
   checkSum();
});

$(document).on("change", "input[name=selCart]", function() {
   $("#checkAll").prop("checked",false);
   checkSum();
});

function checkSum(){
    var price=selTotalSum();
    $(".selTotalPrice").text(price);
}

function selTotalSum(){
   var obj = $(".cart").find("input[name=selCart]:checked");
   var totalSum=0;
   obj.each(function(){
       result = $(this).parent().parent().siblings().find("input[name=totalPrice]").val();
       totalSum +=  parseInt(result, 10);
   });
   total();
 return totalSum;
}

function total(){
   var totalSum=0;
   $("input[name='totalPrice']").each(function(){
       result = $(this).val();
       totalSum +=  parseInt(result, 10);
   });
    $(".cartTotal").text(totalSum);
}

//주문 수량
   $(document).on("click", ".btnStockQty", function() {
      var obj = $(this).parent().find("input[type=tel]");
       var price = $(this).parent().parent().siblings().find("span[class=productPrice]").attr("data-productPrice"); 
       var shipping_fee = $(this).parent().parent().siblings().find("span[class=shipping_fee]").attr("data-shipping_fee"); 
       
      if ($(this).hasClass("Minus")) {
         if (parseInt(obj.val(), 10) - 1 <= 0) {
            alert("주문수량은 1 이상이어야 합니다.");
            obj.val("1");
         } else { obj.val(parseInt(obj.val(), 10) - 1); }
      }

      if ($(this).hasClass("Plus")) {   obj.val(parseInt(obj.val(), 10) + 1);}
      var total=price * parseInt(obj.val(), 10) + parseInt(shipping_fee, 10);
      $(this).parent().parent().siblings('.pdtOrder').find("input[name='totalPrice']").val(total);
   
      checkSum();
   }); 
    
//서브밋 링크 
   // 장바구니 수정
   $(document).on("click", ".btnCart", function() {
      var form = $(this).parent().parent().parent().parent().parent().serialize();
         $.ajax({
            type:"post",
            async:true,
            url:'${contextPath}/cart/modCart.do',  
            data: form,
            contentType: 'application/x-www-form-urlencoded; charset=UTF-8', 
              dataType: 'html',
            success:function(rs){if(rs=="updated"){ alert("수정 되었습니다.");}   },
            error:function(){ alert("페이지 새로 고침");   }
            });
   });

//장바구니 삭제
   $(document).on("click",".btnDelCart", function() {
      var form = $(this).parent().parent().parent().parent().parent().serialize();
      $.ajax({
         type:"post",
         async:true,
         url:'${contextPath}/cart/delCart.do',  
         data: form,
         contentType: 'application/x-www-form-urlencoded; charset=UTF-8', 
           dataType: 'html',
         success:function(){
            history.go(0);
         },
         error:function(){
            alert("다시 시도해 주시기 바랍니다.");
         }
         });
      });

   // 장바구니 선택 삭제
   $(document).on("click","#selDelete", function() {
      var forms = $('input[name="selCart"]:checked').parent().parent().parent().parent().parent().serialize();
      $.ajax({
         type:"post",
         async:true,
         url:'${contextPath}/cart/delChkCart.do',  
         data: forms,
         contentType: 'application/x-www-form-urlencoded; charset=UTF-8', 
           dataType: 'html',
         success:function(){   history.go(0); },
         error:function(){
            alert("다시 시도해 주시기 바랍니다.");
         }
         });
      });
      
   // 선택 주문
   $(document).on("click","#selOrder", function() {
   //   var forms = $('input[name="selCart"]:checked').parent().serialize();
      alert("총 금액 계산만 가능합니다.");
   });
      
   
   // 상품 주문
   $(document).on("click", ".btnOrder", function() {
         var category = $(this).parent().find("input[name=category]").val();     
         var pnum= $(this).parent().find("input[name=pnum]").val();
         var qty= $(this).parent().find("input[type=tel]").val();
         location.href="${contextPath}/common/payment.do?fd="+category+"&num="+pnum+"&qty="+qty;
   });
   

</script>
</head>
<body>
<jsp:include page="../inc/hdr_menu.jsp" />
<div id="CommonHeaderArea"></div>
<div id="CommonHeader_M"></div>
<div id="clear"></div>
<div class="wrap" style="margin : 50px auto;">
<input type="button" id="selDelete" value="선택 삭제"/>
<input type="button" id="selOrder" value="선택 주문"/>
<input type="checkbox" id="checkAll" />
<span class="selTotalPrice"></span>
<span class="cartTotal"></span>
<c:forEach var="cart" items="${cart}">
<div class="line"></div>
<div class="pdt">
<form class="cart" method="post" action="" target="_self">
   <div class="imagePreview">
      <img src="${contextPath}/download.do?fd=${cart.category}&num=${cart.pnum}&productImageName=${cart.productImageName1}" />
   </div>
   <table id="cartTable">
      <tr>
         <td>
            <strong>상품명</strong>
         </td>
         <td class="productName" >
            <strong>${cart.productName}</strong>
         </td>
      </tr>
      <tr>
         <td>
            판매자
         </td>
         <td class="sellerName">
            ${cart.sellerName}
         </td>
      </tr>
      <tr>
         <td>
            가격
         </td>
         <td>
            <span class="productPrice" data-productPrice="${cart.productPrice}">${cart.productPrice}원</span> 
         </td>
      </tr>
      <tr>
         <td>
            배송비
         </td>
         <td>
            <span class="shipping_fee" data-shipping_fee="${cart.shipping_fee}">${cart.shipping_fee}원</span>
         </td>
      </tr>
      <tr>
         <td>
            수량
         </td>
         <td>
            <span class="btnStockQty"></span>
            <input type="button" class="btnStockQty Minus" value="-" /> 
            <input type="tel" class="cartQuantity" name="cartQuantity" value="${cart.cartQuantity}" maxlength="3" />
            <input type="button" class="btnStockQty Plus" value="+" /> 
         </td>
      </tr>
      <tr  class="pdtOrder">
         <td>
            <strong>총 결제 금액</strong>
         </td>
         <td>
            <input type="text" name="totalPrice" value="${cart.totalPrice}"/>원
         </td>
      </tr>
      <tr>
         <td>
            <input type="button" class="bottom btnOrder" value="주문하기" />
         </td>
         <td>
            <input type="checkbox" class="bottom" name="selCart" />
            <input type="button" class="bottom btnDelCart" value="삭제" />
            <input type="button" class="bottom btnCart" value="수정" />
            <input type="hidden" name="pnum" id="pnum" value="${cart.pnum}"/>
			<input type="hidden" name="category" id="pnum" value="${cart.category}"/>
			<input type="hidden" name="customer_id" value="${cart.customer_id}"/>   
			<input type="hidden" name="productName" value="${cart.productName}"/>   
			<input type="hidden" name="sellerName" value="${cart.sellerName}"/>   
         </td>
      </tr>
   </table>
</form>
</div>
<div class="line"></div>
</c:forEach>
</div>
<jsp:include page="../inc/footer.jsp" />
</body>
</html>