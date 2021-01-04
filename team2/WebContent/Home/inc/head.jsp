<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<title>SS Market</title>
<% request.setCharacterEncoding("utf-8"); %>   
	<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
	<meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<meta http-equiv="Content-Script-Type" content="text/javascript" />
	<meta http-equiv="Content-Style-Type" content="text/css" />
	<meta http-equiv="cache-control" content="no-cache" />
	<meta http-equiv="pragma" content="no-cache" />
	<meta http-equiv="Expire" content="-1">
	<meta property="og:title" content="상상마켓">
	<meta property="og:type" content="website">
	<meta property="og:url" content="http://www.sangsangmarket.com/">
	<link rel="shortcut icon" href="${contextPath}/Images/Ver1/Icon/ssmkt.ico" />
	<link href="${contextPath}/Images/Ver1/Icon/icon180.png" rel="apple-touch-icon-precomposed" />
	<link rel="stylesheet" type="text/css" href="${contextPath}/Home/Css/Common/Common.css" />
	<link rel="stylesheet" type="text/css" href="${contextPath}/Home/Css/Common/swiper.min.css" />
	<script type="text/javascript" src="${contextPath}/Home/Js/Common/jquery-1.11.3.min.js"></script>
	<script type="text/javascript" src="${contextPath}/Home/Js/Common/Common.js"></script>
	<script type="text/javascript" src="${contextPath}/Home/Js/Common/swiper_r.min.js"></script> 
	<link rel="stylesheet" type="text/css" href="${contextPath}/Home/Css/Common/Index.css" />
	<link rel="stylesheet" type="text/css" href="${contextPath}/Home/Css/Common/FlexSliderIndex.css" />
	<script type="text/javascript" src="${contextPath}/Home/Js/Common/jquery.flexslider-min.js" charset="utf-8"></script> 
	<link rel="stylesheet" type="text/css" href="${contextPath}/Home/Css/Common/swiper.min.css" />
	<link rel="stylesheet" type="text/css" href="${contextPath}/Home/Css/Member/Member.css" />
	<link rel="stylesheet" type="text/css" href="${contextPath}/Home/Css/Common/Item.css" />
	<script type="text/javascript" src="${contextPath}/Home/Js/Common/swiper.min.js"></script>
	<script type="text/javascript" src="${contextPath}/Home/Js/Common/jquery.rwdImageMaps.min.js"></script>
	<script type="text/javascript" src="${contextPath}/Home/Js/Common/jquery.bxslider.ABIndex.js"></script>
	<script type="text/javascript">
		var WinKind;
		$(document).ready(function(){
			$('img[usemap]').rwdImageMaps();
			
		fnMenuCharacter = function(x){
			var srcOn = $("#MenuCharacter"+x).attr("srcon");
			var srcOff = $("#MenuCharacter"+x).attr("srcoff");
			var srcNow = $("#MenuCharacter"+x).attr("src");
			if (srcNow!=srcOn) {
				for (var i=1; i<=4; i++) {
					if (i!=x) {
						$("#MenuCharacter"+i).attr("src",$("#MenuCharacter"+i).attr("srcoff"));
						$("#CharacterList"+i).css("display","none");
					}
				}
				$("#MenuCharacter"+x).attr("src",$("#MenuCharacter"+x).attr("srcon"));
				$("#CharacterList"+x).css("display","block");
			}
		}
			
			var token = "2993198200.7efd5c1.43f329e4f4704fdc8a28d4b395c2d938";  	   	
			$.ajax({
				type:"get",  
				dataType: "jsonp",  
				cache: false,  
				url: "https://api.instagram.com/v1/users/self/media/recent/?access_token=" + token,
				success: function(response) {
					var instaHtml = "";
					for (var i = 0; i < response.data.length; i++) {
						instaHtml += "<li class=\"num"+(i+1)+"\"><a href=\"" + response.data[i].link + "\" target=\"_blank\" ><div style=\"background-image:url(" + response.data[i].images.standard_resolution.url + ");\"></div></a></li>";
						if (i >= 5) {
							break;
						}
					}
					$("#InstagramListUl").empty().html(instaHtml);
					$("#InstagramListUl > li").css("height",$("#InstagramListUl > li").width());
				}
			});
			$( window ).resize( function() {
				$("#InstagramListUl > li").css("height",$("#InstagramListUl > li").width());
			});
		});
		</script>