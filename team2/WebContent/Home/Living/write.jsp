<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>    
<%
	request.setCharacterEncoding("utf-8");
	String id = (String)session.getAttribute("id");
%>

<!DOCTYPE html>
<html>
<head>
<jsp:include page="/Home/inc/head.jsp"/>
<script type="text/javascript" src="${contextPath}/Home/Js/Common/iscroll.js"></script>
<script type="text/javascript" src="${contextPath}/Home/Js/Common/jquery.sticky.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/feather-icons/4.9.0/feather.min.js"></script>
<link rel="stylesheet" href="${contextPath}/Home/Css/Write/bootstrap.min.css">
<link rel="stylesheet" href="${contextPath}/Home/Css/Write/board.css">

</head>
<script type="text/javascript">

  function change_action(){
	  var form = $("form");
      var action = "${contextPath}/"+$("#productCategoryNo option:selected").val()+"/addLivingItem.do";
      form.attr("action", action);
	  
  }


	function smcheck(){
		var category = $("#productCategoryNo option:selected").val();
		var name = $("#productName").val();
		var price = $("#productPrice").val();
		var quantity = $("#productQuantity").val();
		var shipping_fee = $("#shipping_fee").val();
		var point = $("#point").val();
		var content = $("#productContent").val();
		var image1 = $("#imageLabel1").text();
		var image2 = $("#imageLabel2").text();
		var image3 = $("#imageLabel3").text();
		
		if(category == null || category ==""){
			alert("카테고리를 선택해주세요.");
			$("#productCategoryNo").focus();
			return;
		}
		
		if(name == "" || name == ""){
			alert("상품 이름을 작성해주세요.");
			$("#productName").focus();
			return;
		}
		
		if(price == 0){
			alert("상품 가격을 입력해주세요.");
			$("#productPrice").focus();
			return;
		}
		
		if(quantity == 0){
			alert("상품 수량을 입력해주세요.");
			$("#productQuantity").focus();
			return;
		}
		
		if(shipping_fee == 0){
			alert("배송비를 입력해주세요.");
			$("#shipping_fee").focus();
			return;
		}
		
		if(point == 0){
			alert("포인트를 입력해주세요.");
			$("#point").focus();
			return;
		}
		
		if(content == null || content ==""){
			alert("상세정보를 입력해주세요.");
			$("#productContent").focus();
			return;
		}
		
		if(image1 == "선택된 파일 없음"){
			alert("첫번째 이미지를 첨부해주세요.");
			$("#productImageName1").focus();
			return;
		}
		
		if(image2 == "선택된 파일 없음"){
			alert("두번째 이미지를 첨부해주세요.");
			$("#productImageName2").focus();
			return;
		}
		
		if(image3 == "선택된 파일 없음"){
			alert("세번째 이미지를 첨부해주세요.");
			$("#productImageName3").focus();
			return;
		}
		
		document.fr.submit();
	}
</script>
<body>
<jsp:include page="/Home/inc/hdr_info.jsp"/>

<div>
	<div>
		<h2 style="text-align:center; margin: 30px 0;">상품 등록</h2>
	</div>
</div>
<article class="product" style="width:1200px; margin : 0 auto" >
	<form action="" method="post" enctype="multipart/form-data" name="fr">
		<table class="table">
			<colgroup>
				<col style="width:120px" />
				<col />
			</colgroup>
			<tr>
				<td>
					<input class="form-control" type="hidden" name="sellerName" id="sellerName" value="홍길동" required />
				</td>
			</tr>
			<tr>
				<th class="align-middle">
					<label for="productCategoryNo" class="m-0">카테고리</label>
				</th>
				<td>
					<select class="form-control" name="productCategoryNo" id="productCategoryNo" required onchange="change_action();">
						<option value="">선택하세요</option>
						<option value="living">리빙</option>
						<option value="Crafts">공예</option>										
					</select>
				</td>
			</tr>
			<tr>
				<th class="align-middle">
					<label for="productName" class="m-0">상품 이름</label>
				</th>
				<td>
					<input class="form-control" type="text" name="productName" id="productName" required />
				</td>
			</tr>
			<tr>
				<th class="align-middle">
					<label for="productPrice" class="m-0">가격</label>
				</th>
				<td>
					<div class="form-inline">
						<input class="form-control" type="number" name="productPrice" id="productPrice" min="0" max="10000000000" step="100" value="0" required />
					</div>
				</td>
			</tr>
			<tr>
				<th class="align-middle">
					<label for="productQuantity" class="m-0">수량</label>
				</th>
				<td>
					<div class="form-inline">
						<input class="form-control d-inline-block" type="number" name="productQuantity" id="productQuantity" min="0" max="10000000000" value="0" required />
					</div>
				</td>
			</tr>
			<tr>
				<th class="align-middle">
					<label for="Shipping_fee" class="m-0">배송비</label>
				</th>
				<td>
					<div class="form-inline">
						<input class="form-control d-inline-block" type="number" name="shipping_fee" id="shipping_fee" value="0" min="0" max="10000000000" step="100" required />
					</div>
				</td>
			</tr>
			<tr>
				<th class="align-middle">
					<label for="point" class="m-0">포인트</label>
				</th>
				<td>
					<div class="form-inline">
						<input class="form-control d-inline-block" type="number" name="point" id="point" value="0" min="0" max="10000000000" step="100" required />
					</div>
				</td>
			</tr>
			<tr>
				<th class="align-middle">
					<label for="productContent" class="m-0">상세정보</label>
				</th>
				<td>			
					<textarea class="form-control" name="productContent" id="productContent" cols="40" rows="13" required></textarea>
				</td>
			</tr>
			<tr>
				<th class="align-middle">
					<label class="m-0">이미지1</label>
				</th>
				<td>
					<div class="custom-file">
						<input class="custom-file-input" type="file" name="productImageName1" id="productImageName1" onchange="showPreview(this, 'image')" required />
						<label class="custom-file-label" for="productImageName1" id="imageLabel1">선택된 파일 없음</label>
					</div>
				</td>
			</tr>
			<tr>
				<th class="align-middle">
					<label class="m-0">이미지2</label>
				</th>
				<td>
					<div class="custom-file">
						<input class="custom-file-input" type="file" name="productImageName2" id="productImageName2" onchange="showPreview(this, 'image')" />
						<label class="custom-file-label" for="productImageName2"  id="imageLabel2">선택된 파일 없음</label>
					</div>
				</td>
			</tr>
			<tr>
				<th class="align-middle">
					<label class="m-0">이미지3</label>
				</th>
				<td>
					<div class="custom-file">
						<input class="custom-file-input" type="file" name="productImageName3" id="productImageName3" onchange="showPreview(this, 'image')" />
						<label class="custom-file-label" for="productImageName3"  id="imageLabel3">선택된 파일 없음</label>
					</div>
				</td>
			</tr>
		</table>
		<div class="text-center my-5">
			<button type="button" class="btn btn-secondary" onclick="history.back()">취소</button>
			<button type="button" class="btn btn-primary" onclick="smcheck()">상품 등록하기</button>
		</div>
	</form>
</article>

<script src="${contextPath}/Home/Js/Shop/bs-custom-file-input.js"></script>
<script src="${contextPath}/Home/Js/Shop/lmw-custom-preview.js"></script>
<script src="${contextPath}/Home/Js/Shop/bootstrap.min.js"></script>
<script>	
	$(document).ready(function() {
		bsCustomFileInput.init()
	});
</script>
<jsp:include page="/Home/inc/footer.jsp"/>
</body>
</html>