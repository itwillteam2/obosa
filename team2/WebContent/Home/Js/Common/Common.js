var nowPageURL = window.location.href;

function setComma(number) 
{
	var minusYN = "N";
	if (parseInt(number,10)<0)
	{
		minusYN = "Y";
		number = parseInt(number,10)*-1;
	}

	var nArr = String(number).split("").join(",").split("");
	for (var i=nArr.length-1, j=1; i>=0; i--, j++)
	{
		 if( j%6 != 0 && j%2 == 0)
		 {
			 nArr[i] = "";
		 }
	}
	if (minusYN=="Y")
	{
		return "-"+nArr.join("");
	}
	else
	{
		return nArr.join("");
	}
}

function trim(str)
{
	return str.replace(/^\s*|\s*$/g,"");
}
 



// Internet Explorer 버전 체크
var IEVersionCheck = function() {

	 var word;
	 var version = "N/A";

	 var agent = navigator.userAgent.toLowerCase();
	 var name = navigator.appName;

	 // IE old version ( IE 10 or Lower )
	 if ( name == "Microsoft Internet Explorer" ) word = "msie ";

	 else {
		 // IE 11
		 if ( agent.search("trident") > -1 ) word = "trident/.*rv:";

		 // IE 12  ( Microsoft Edge )
		 else if ( agent.search("edge/") > -1 ) word = "edge/";
	 }

	 var reg = new RegExp( word + "([0-9]{1,})(\\.{0,}[0-9]{0,1})" );
	 if (  reg.exec( agent ) != null  )
		 version = RegExp.$1 + RegExp.$2;

	 return version;
};

// URLencode (Search쪽에서 사용)
function urlencode(str) {
	str = (str + '').toString();
	return encodeURIComponent(str)
		.replace(/!/g, '%21')
		.replace(/'/g, '%27')
		.replace(/\(/g, '%28')
		.replace(/\)/g, '%29')
		.replace(/\*/g, '%2A')
		.replace(/%20/g, '+');
}

function fnCommonSearch(x){
	var kwd, url;
	if (x==1) { //pc

		kwd = document.getElementById("kwd").value.trim();

		if (!kwd) {
			alert("검색어를 입력해주세요");
			document.getElementById("kwd").focus();
		} else {
			url = "/Home/Shop/Category.asp?kwd="+urlencode(kwd);
			location.href = url;
		}

	} else if (x==2) { //mobile

		kwd = document.getElementById("kwd_M").value.trim();

		if (!kwd) {
			alert("검색어를 입력해주세요");
			document.getElementById("kwd_M").focus();
		} else {
			url = "/Home/Shop/Category.asp?kwd="+urlencode(kwd);
			location.href = url;
		}

	}
}

function fnMobileMenuToggle(x){
	if (x==1) { //검색모드 on

		document.getElementById("CommonHeaderMenu_M").style.display="none";
		document.getElementById("CommonHeaderSearch_M").style.display="block";
		document.getElementById("kwd_M").focus();

	} else if (x==2) { //검색모드 off

		document.getElementById("CommonHeaderMenu_M").style.display="block";
		document.getElementById("CommonHeaderSearch_M").style.display="none";
		document.getElementById("kwd_M").blur();

	}
}


function getOffsetTop(el) { // 해당 아이디까지의 높이 (offsetTop 값)
	var top = 0; 
	if (el.offsetParent) { 
		do { 
			top += el.offsetTop; 
		} while (el = el.offsetParent); 
	return [top]; 
	} 
}

function fnLoginBalloon(){
	document.getElementById("LoginBalloon").style.display="none";
}


$(document).ready(function(){

	var ScrollTop = 0;

	if ($("#CommonHeader_M").css("display")=="none"){
		var CommonHeaderHeight = $("#CommonHeader").height();
		$("#CommonHeaderArea").height(CommonHeaderHeight);
	} else {
		var m_CommonHeaderHeight = $("#CommonHeader_M").height();
		$("#CommonHeaderArea_M").height(m_CommonHeaderHeight);
		$("#CommonHeader_M").css("position","absolute");
	}


	$(window).on("scroll", function (){
		ScrollTop = $(window).scrollTop();

		if ($("#CommonHeader_M").css("display")=="none"){ //모바일이 아닐 때만 스크롤 인식
			if (ScrollTop > CommonHeaderHeight) { // 원래는 CommonHeaderHeight/3 인데 이걸로 하면 ie에서 떨림현상 발생
				$("#CommonHeader").css("position","fixed");
				$("#CommonHeader .OtherBrand").css("display","none");
				$("#CommonHeader .MainLogo").css("display","none");
				$("#CommonHeader .MainLogoScroll").css("display","block");
				$("#MyInfoSummary").css("padding-top","23px");
				$("#CommonHeader").css("opacity","0.9");
				$("#CommonHeader").css("padding-bottom","30px");
			//	$("#LoginBalloon").css("visibility","hidden");

				$(".MyInfoSummaryArea").css("top","97px");
				$(".MyInfoSummaryArea").css("z-index","99998");
			//	if (nowPageURL.toLowerCase() === "http://")
			//	{	$(".swiper-container.pc.popmart").css("top","862px"); 		}
			} else {
				$("#CommonHeader").css("position","absolute");
				$("#CommonHeader .OtherBrand").css("display","block");
				$("#CommonHeader .MainLogo").css("display","block");
				$("#CommonHeader .MainLogoScroll").css("display","none");
				$("#CommonHeader").css("opacity","1");
				$("#CommonHeader").css("padding-bottom","0px");
			//	$("#LoginBalloon").css("visibility","visible");

				$(".MyInfoSummaryArea").css("top",(223-ScrollTop)+"px");
				$(".MyInfoSummaryArea").css("z-index","998");
			//	if (nowPageURL.toLowerCase() === "http://")
			//	{	$(".swiper-container.pc.popmart").css("top","988px");		}
			}
			CommonHeaderHeight = $("#CommonHeader").height();
			$("#CommonHeaderArea").height(CommonHeaderHeight);
		} else {
			ScrollTop = $(window).scrollTop();
			if (ScrollTop > m_CommonHeaderHeight) { 
				$("#CommonHeader_M").css("position","fixed");
				$("#CommonHeader_M").css("top","0");
				$("#CommonHeader_M").css("opacity","0.9");
				$("#CommonHeader_M").css("z-index","998");
			} else {
				$("#CommonHeader_M").css("position","absolute");
				$("#CommonHeader_M").css("opacity","1");
			}
			m_CommonHeaderHeight = $("#CommonHeader_M").height();
			$("#CommonHeaderArea_M").height(m_CommonHeaderHeight);
		}
	});

	fnMyInfoSummary = function(x){
		if (x==1) {
			$("#MyInfoSummary").css("display","block");
			$("#MyInfoSummaryIcon").attr("src","/Images/Ver1/Common/top_icon_login_press.png");
		} else if (x==2) {
			$("#MyInfoSummary").css("display","none");
			$("#MyInfoSummaryIcon").attr("src","/Images/Ver1/Common/top_icon_login_logined.png");
		}
	}


});

function fnOnlyNumber(t)
{
	var k = event.keyCode;
	if (k < 48 || k > 57)
	{
		event.returnValue = false;
	}
}

