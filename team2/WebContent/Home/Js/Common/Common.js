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




	fnMyInfoSummary = function(x){
		if (x==1) {
			$("#MyInfoSummary").css("display","block");
			$("#MyInfoSummaryIcon").attr("src","/Images/Ver1/Common/top_icon_login_press.png");
		} else if (x==2) {
			$("#MyInfoSummary").css("display","none");
			$("#MyInfoSummaryIcon").attr("src","/Images/Ver1/Common/top_icon_login_logined.png");
		}
	}




function fnOnlyNumber(t)
{
	var k = event.keyCode;
	if (k < 48 || k > 57)
	{
		event.returnValue = false;
	}
}

	
	$(window).scroll(function() { 
		var didScroll; 
		var ScrollTop = 0;
		var delta=5;
		var CommonHeaderHeight = $("header").outerHeight();
		
		var st = $(this).scrollTop();
		if(Math.abs(ScrollTop - st)<=delta)
			return;
		
		if(st>ScrollTop && st >CommonHeaderHeight){
				$("header").css("height","138px");
				$("#mymenu").css("margin","0 0 0 0");
				$("#CommonHeader .MainLogo").css("display","none");
				$("#CommonHeader .MainLogoScroll").css("display","block");
				$("#CommonHeader .CategoryLarge ul.nav").css("margin","0 0 0 0");
				$("#CommonHeader .CategoryLarge ul.rtMenu").css("margin","0 0 0 0");
				$("header").css("opacity","0.8");
			} else {
				if(st+$(window).height() < $(document).height()) { 
				$("header").css("height","250px")
				$("#mymenu").css("margin","0 0 20px 0");
				$("#CommonHeader .CategoryLarge ul.nav").css("margin","35px 0px 10px 10px");
				$("#CommonHeader .CategoryLarge ul.rtMenu").css("margin","30px 60px 10px 10px");
				$("#CommonHeader .MainLogo").css("display","block");
				$("#CommonHeader .MainLogoScroll").css("display","none");
				$("header").css("opacity","1");
				}
			}
		 lastScrollTop = st;
  		});
	
