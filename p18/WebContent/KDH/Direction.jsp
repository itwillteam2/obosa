<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Direction</title>
<link rel="stylesheet" href="css/style.css">
<link rel="stylesheet" href="css/notice.css">
<script src="javascript/jquery-1.12.3.js"></script>
<script src="javascript/script.js" defer="defer"></script>
</head>
<body>
	<jsp:include page="inc/top.jsp" />
	<div class="content">
		<div class="menu">
			<nav>
				<ul class="submenu2">
					<li><a href="SongjungHistory.jsp">송정동 소개</a></li>
					<li><a href="Direction.jsp">찾아오시는길</a></li>
				</ul>
			</nav>
		</div>

		<div class="main2" style="margin-left: 40px; margin-top: 30px;">
			<div>
				<h2 style="text-align: left;">송정동 지도</h2>
				<p style="margin-top: -12px"></p>
				<div id="map" style="width: 100%; height: 400px;"></div>
				<div id="text1">
					<b>주소</b> : 부산광역시 해운대구 송정중앙로21번길 20
				</div>
				<div id="text2">
					<b>Tel</b> : 051.749.5891
				</div>
			</div>
		</div>
	</div>
	<div class="clear"></div>
	<jsp:include page="inc/bottom.jsp" />
	<script type="text/javascript"
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=f5d931d49a252c0f8a84115025b1e0d4&libraries=services"></script>
	<script>
		var mapContainer = document.getElementById('map'), mapOption = {
			center : new kakao.maps.LatLng(33.450701, 126.570667),
			level : 3
		};
		var map = new kakao.maps.Map(mapContainer, mapOption);

		var geocoder = new kakao.maps.services.Geocoder();

		geocoder
				.addressSearch(
						'부산 해운대구 송정중앙로21번길 20 송정동주민센터',
						function(result, status) {

							if (status === kakao.maps.services.Status.OK) {

								var coords = new kakao.maps.LatLng(result[0].y,
										result[0].x);

								var marker = new kakao.maps.Marker({
									map : map,
									position : coords
								});
								var infowindow = new kakao.maps.InfoWindow(
										{
											
										});
								map.setCenter(coords);
							}
						});
	</script>
</body>
</html>