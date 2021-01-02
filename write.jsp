<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>    
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Write</title>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />

<link href="${contextPath}/T2_tmp/Home/Css/Common/Common.css" type="text/css" rel="stylesheet" />
<link href="${contextPath}/T2_tmp/Home/Css/Common/swiper.min.css" type="text/css" rel="stylesheet" />

<script type="text/javascript" src="${contextPath}/T2_tmp/Home/Js/Common/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="${contextPath}/T2_tmp/Home/Js/Common/Common.js"></script>
<script type="text/javascript" src="${contextPath}/T2_tmp/Home/Js/Common/swiper_r.min.js"></script>
	
<script type="text/javascript" src="${contextPath}/T2_tmp/Home/Js/Common/iscroll.js"></script>
<script type="text/javascript" src="${contextPath}/T2_tmp/Home/Js/Common/jquery.sticky.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/feather-icons/4.9.0/feather.min.js"></script>
<link rel="stylesheet" href="../Css/write/bootstrap.min.css">
<link rel="stylesheet" href="../Css/write/board.css">

</head>
<body>
<jsp:include page="../inc/header.jsp"/>
<div id="CommonHeaderArea"></div>
<div id="CommonHeader_M"></div>
<%
	request.setCharacterEncoding("utf-8");
	String id = (String)session.getAttribute("id");
%>
<div>
	<div>
		<h2 style="text-align:center; margin: 30px 0;">상품 등록</h2>
	</div>
</div>
<article class="product" style="width:1200px; margin : 0 auto" >
	<form action="${contextPath}/living/addLiving.do" method="post" enctype="multipart/form-data" >
		<table class="table">
			<colgroup>
				<col style="width:120px" />
				<col />
			</colgroup>
			<tr>
				<th class="align-middle">
					<label for="productCategoryNo" class="m-0">카테고리</label>
				</th>
				<td>
					<select class="form-control" name="productCategoryNo" id="productCategoryNo" required>
						<option value="">선택하세요</option>
							<option value="Living">리빙</option>									
					</select>
				</td>
			</tr>
			<tr>
				<th class="align-middle">
					<label for="productName" class="m-0">이름</label>
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
						<input class="form-control d-inline-block" type="number" name="Shipping_fee" id="Shipping_fee" value="0" min="0" max="10000000000" step="100" required />
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
						<label class="custom-file-label" for="productImageName1">선택된 파일 없음</label>
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
						<label class="custom-file-label" for="productImageName2">선택된 파일 없음</label>
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
						<label class="custom-file-label" for="productImageName3">선택된 파일 없음</label>
					</div>
				</td>
			</tr>
		</table>
		<div class="text-center my-5">
			<button type="button" class="btn btn-secondary" onclick="history.back()">취소</button>
			<button type="submit" class="btn btn-primary">상품 등록하기</button>
		</div>
	</form>
</article>

<script src="${contextPath}/T2_tmp/Home/Js/Shop/bs-custom-file-input.js"></script>
<script src="${contextPath}/T2_tmp/Home/Js/Shop/lmw-custom-preview.js"></script>
<script src="${contextPath}/T2_tmp/Home/Js/Shop/bootstrap.min.js"></script>
<script>	
	$(document).ready(function() {
		bsCustomFileInput.init()
	});
</script>
<jsp:include page="../inc/footer.jsp"/>
</body>
</html>