<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<c:set var="recentURI" value="${header.referer}"/>

<!DOCTYPE html>
<html lang="ko">
<head>
<jsp:include page="${contextPath}/Home/inc/head.jsp"/>
</head>
<body>
<jsp:include page="${contextPath}/Home/inc/header.jsp" />
<script type="text/javascript">
	$(document).ready(function(){
	
		$("input[type=tel]").keyup(function(e){
			if (!Check_Number(e.currentTarget.value)) {
				alert("숫자값만 입력가능합니다.");
				this.value="";
			}
			if (this.id=="i_memcpnum1"&&this.value.length>=3) {
				document.getElementById("i_memcpnum2").focus();
			}
			if (this.id=="i_memcpnum2"&&this.value.length>=4) {
				document.getElementById("i_memcpnum3").focus();
			}
		});
	
		$("input[type=radio]").click(function(){
			if ($("#i_findtypeCPNUM").prop("checked")){
				$("#TableCPNUM").css("display","table");
				$("#TableEMAIL").css("display","none");
			} else if ($("#i_findtypeEMAIL").prop("checked")) {
				$("#TableCPNUM").css("display","none");
				$("#TableEMAIL").css("display","table");
			}
		});
	
		fnTabMenu = function(id){
	
			$("#FindInput").css("display","block");
			$("#FindIdResult").css("display","none");
			$("#FindPwResult").css("display","none");
			$("#TableSIXNUM").css("display","none");
	
			if (id=="TabId") {
	
				$("#TabId").attr("class","On");
				$("#TabPw").attr("class","Off");
				$(".TabIdText").css("display","block");
				$(".TabPwText").css("display","none");
	
				$("dl#trMEMID").css("display","none");
	
				$("a#TabIdSubmit").css("display","block");
				$("a#CallSixNum,a#CheckSixNum").css("display","none");
	
			} else if (id="TabPw") {
	
				$("#TabId").attr("class","Off");
				$("#TabPw").attr("class","On");
				$(".TabIdText").css("display","none");
				$(".TabPwText").css("display","block");
	
				$("dl#trMEMID").css("display","table-row");
	
				$("a#TabIdSubmit").css("display","none");
				$("a#CallSixNum,a#CheckSixNum").css("display","block");
			}
		}
	
		fnTabIdSubmit = function(){
	
			var param = "proctype=find_memid";
	
			if (!$("#i_memname").val()) {
				alert("이름을 입력해주세요.");
				$("#i_memname").focus();
				return;
			}
	
			param += "&v_memname=" + encodeURI($("#i_memname").val());
	
			if ($("#i_findtypeCPNUM").prop("checked")){
	
				if (!$("#i_memcpnum1").val()) {
					alert("휴대전화 번호를 입력해주세요.");
					$("#i_memcpnum1").focus();
					return;
				}
	
				if (!$("#i_memcpnum2").val()) {
					alert("휴대전화 번호를 입력해주세요.");
					$("#i_memcpnum2").focus();
					return;
				}
	
				if (!$("#i_memcpnum3").val()) {
					alert("휴대전화 번호를 입력해주세요.");
					$("#i_memcpnum3").focus();
					return;
				}
	
				param += "&v_findtype="+"CPNUM";
				param += "&v_memcpnum=" + ($("#i_memcpnum1").val() + "-" + $("#i_memcpnum2").val() + "-" + $("#i_memcpnum3").val());
	
	
			} else if ($("#i_findtypeEMAIL").prop("checked")) {
	
				if (!$("#i_mememail").val()) {
					alert("이메일을 입력해주세요.");
					$("#i_mememail").focus();
					return;
				}
	
				param += "&v_findtype="+"EMAIL";
				param += "&v_mememail=" + encodeURI($("#i_mememail").val());
	
			}
	
			$.ajax({
				url : "/Home/Member/MemberCheck.xml.asp",
				data : param,
				type : "POST",
				success : function(xml){
					var result = $(xml).find("result").text();
					var message = $(xml).find("message").text();
	
					if (result=="Y") {
	
						$(".FindIdResultInner").html(message);
	
						$("#FindInput").css("display","none");
						$("#FindIdResult").css("display","block");
					} else {
						alert(message);
					}
	
				}
			});
		}
	
		fnTabPwCheck = function(){
	
			$("#TableSIXNUM").css("display","table");
	
			var param = "proctype=find_memid_check";
	
			if (!$("#i_memid").val()) {
				alert("아이디를 입력해주세요.");
				$("#i_memid").focus();
				return;
			}
	
			param += "&v_memid=" + encodeURI($("#i_memid").val());
	
			if (!$("#i_memname").val()) {
				alert("이름을 입력해주세요.");
				$("#i_memname").focus();
				return;
			}
	
			param += "&v_memname=" + encodeURI($("#i_memname").val());
	
			if ($("#i_findtypeCPNUM").prop("checked")){
	
				if (!$("#i_memcpnum1").val()) {
					alert("휴대전화 번호를 입력해주세요.");
					$("#i_memcpnum1").focus();
					return;
				}
	
				if (!$("#i_memcpnum2").val()) {
					alert("휴대전화 번호를 입력해주세요.");
					$("#i_memcpnum2").focus();
					return;
				}
	
				if (!$("#i_memcpnum3").val()) {
					alert("휴대전화 번호를 입력해주세요.");
					$("#i_memcpnum3").focus();
					return;
				}
	
				param += "&v_findtype="+"CPNUM";
				param += "&v_memcpnum=" + ($("#i_memcpnum1").val() + "-" + $("#i_memcpnum2").val() + "-" + $("#i_memcpnum3").val());
	
	
			} else if ($("#i_findtypeEMAIL").prop("checked")) {
	
				if (!$("#i_mememail").val()) {
					alert("이메일을 입력해주세요.");
					$("#i_mememail").focus();
					return;
				}
	
				param += "&v_findtype="+"EMAIL";
				param += "&v_mememail=" + encodeURI($("#i_mememail").val());
	
			}
	
			$.ajax({
				url : "https://www.artboxmall.com:443/Home/Member/MemberCheck.xml.asp",
				data : param,
				type : "POST",
				success : function(xml){
					var result = $(xml).find("result").text();
					var message = $(xml).find("message").text();
	
					if (result=="Y") {
						$("#i_memberidx").val(message);
						fnCallSixNum();
					} else {
						$("#i_memberidx").val("");
						alert(message);
					}
	
				}
			});
		}
	
		fnCallSixNum = function(){
	
			var param = "proctype=find_mempw_check";
	
			if (!$("#i_memname").val()) {
				alert("이름을 입력해주세요.");
				$("#i_memname").focus();
				return;
			}
	
			param += "&v_memname=" + encodeURI($("#i_memname").val());
	
			if ($("#i_findtypeCPNUM").prop("checked")){
	
				if (!$("#i_memcpnum1").val()) {
					alert("휴대전화 번호를 입력해주세요.");
					$("#i_memcpnum1").focus();
					return;
				}
	
				if (!$("#i_memcpnum2").val()) {
					alert("휴대전화 번호를 입력해주세요.");
					$("#i_memcpnum2").focus();
					return;
				}
	
				if (!$("#i_memcpnum3").val()) {
					alert("휴대전화 번호를 입력해주세요.");
					$("#i_memcpnum3").focus();
					return;
				}
	
				param += "&v_findtype="+"CPNUM";
				param += "&v_memcpnum=" + ($("#i_memcpnum1").val() + "-" + $("#i_memcpnum2").val() + "-" + $("#i_memcpnum3").val());
	
	
			} else if ($("#i_findtypeEMAIL").prop("checked")) {
	
				if (!$("#i_mememail").val()) {
					alert("이메일을 입력해주세요.");
					$("#i_mememail").focus();
					return;
				}
	
				param += "&v_findtype="+"EMAIL";
				param += "&v_mememail=" + encodeURI($("#i_mememail").val());
	
			}
	
			$.ajax({
				url : "https://www.artboxmall.com:443/Home/Member/MemberCheck.xml.asp",
				data : param,
				type : "POST",
				success : function(xml){
					var result = $(xml).find("result").text();
					var message = $(xml).find("message").text();
	
					if (result=="Y") {
						$("#CallSixNum").text("인증번호 재발송");
						alert(message);
					} else {
						alert(message);
					}
	
				}
			});
		}
	
		fnCheckSixNum = function(){
			var param = "proctype=join_sixnum_check";
	
			if (!$("#i_sixnum").val()) {
				alert("인증번호 6자리를 입력해주세요.");
				$("#i_sixnum").focus();
				return;
			}
	
			param += "&v_sixnum=" + $("#i_sixnum").val();
			param += "&v_memcpnum="+"Y";
	
			$.ajax({
				url : "https://www.artboxmall.com:443/Home/Member/MemberCheck.xml.asp",
				data : param,
				type : "POST",
				success : function(xml){
					var result = $(xml).find("result").text();
					var message = $(xml).find("message").text();
	
					if (result=="N") {
						alert(message);
					} else {
						alert(message);
						$("#FindInput").css("display","none");
						$("#FindPwResult").css("display","block");
					}
				}
			});
		}
	
		fnTabPwSubmit = function(){
			var param = "proctype=find_mempw_change";
	
	
			if (!$("#i_memberidx").val()) {
				alert("인증값이 유효하지 않습니다. 다시 인증해주세요.");
				return;
			}
			param += "&v_memberidx=" + $("#i_memberidx").val();
	
	
	
			if (!$("#i_mempwd").val()) {
				alert("비밀번호를 입력해주세요.");
				$("#i_mempwd").focus();
				return;
			}
	
			if (!Check_Pw($("#i_mempwd").val())) {
				alert("비밀번호 4~16자 영문 숫자 조합이어야 합니다.");
				$("#i_mempwd").focus();
				return;
			}
	
			if ($("#i_mempwd2").val()!=$("#i_mempwd").val()) {
				alert("비밀번호가 일치하지 않습니다.");
				$("#i_mempwd2").focus();
				return;
			}
			param += "&v_mempwd=" + $("#i_mempwd").val();
	
	
			$.ajax({
				url : "https://www.artboxmall.com:443/Home/Member/MemberCheck.xml.asp",
				data : param,
				type : "POST",
				success : function(xml){
					var result = $(xml).find("result").text();
					var message = $(xml).find("message").text();
	
					if (result=="Y") {
						alert("비밀번호가 변경되었습니다.");
						location.href = "https://www.artboxmall.com:443/Home/Member/Login.asp";
					} else {
						alert(message);
					}
				}
			});
		}
	});
	
	
	
	function Check_Number(str) { // only number
		var reg = /^[0-9]*$/;
		return reg.test(str);
	}
	
	function Check_Id(str) {
		var reg1 = /^[a-zA-Z0-9]{4,16}$/;    // a-z 0-9 중에 4자리 부터 16자리만 허용 한다는 뜻
		var reg4 = /^\d.*/ // 숫자로 시작
	
		return (reg1.test(str)&&!reg4.test(str));
	}
	
	function Check_Pw(str) {
		/*var reg1 = /^[a-z0-9]{4,16}$/;    // a-z 0-9 중에 4자리 부터 16자리만 허용 한다는 뜻
		var reg2 = /[a-z]/g;
		var reg3 = /[0-9]/g;
		
		return (reg1.test(str) && reg2.test(str) && reg3.test(str));*/
		if (str.length<4||str.length>16) {
			return false;
		} else {
			return true;
		}
	}
	
	function Check_Email(str) {
		var exptext = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;
		return (exptext.test(str));
	}
	
	function Check_Date(str) {
		var exptext = /^(19|20)\d{2}(0[1-9]|1[012])(0[1-9]|[12][0-9]|3[0-1])$/;
		return (exptext.test(str));
	}
	</script>
<form name="FindIdPw" method="post">

<div class="FindIdPwWrap">
<h1>아이디/비밀번호 찾기</h1>
<div class="FindIdPwForm">
<div class="FindIdPwTab">
	<a href="javascript:fnTabMenu('TabId');" id="TabId" class="On">아이디 찾기</a>
	<a href="javascript:fnTabMenu('TabPw');" id="TabPw" class="Off">비밀번호 찾기</a>
	<div class="clear"></div>
</div>
<h2 class="TabIdText">- 회원정보에 입력한 휴대전화 번호/이메일 주소로 아이디를 찾을 수 있습니다.<br>- 개인 정보 보호를 위해 아이디 뒷자리는 *로 표시됩니다.</h2>
<h2 class="TabPwText">- 회원정보에 입력한 휴대전화 번호/이메일 주소로 인증이 가능합니다.<br>- 본인인증 후, 새로운 비밀번호를 입력해 주세요. </h2>

<div id="FindInput">
	<div class="tableDiv">
		<dl class="trFindType">
			<dd>
				<input type="radio" id="i_findtypeCPNUM" name="findtype" value="CPNUM" checked="checked"> 휴대전화
				&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="radio" id="i_findtypeEMAIL" name="findtype" value="EMAIL"> 이메일
			</dd>
		</dl>
		<dl class="trJoin" id="trMEMID">
			<dd>
				<input type="text" id="i_memid" name="memid" maxlength="16" placeholder="아이디를 입력해주세요.">
				<p class="null"></p>
			</dd>
		</dl>
		<dl class="trJoin">
			<dd>
				<input type="text" id="i_memname" name="memname" maxlength="16" placeholder="이름을 입력해주세요.">
				<p class="null"></p>
			</dd>
		</dl>
	</div>
	<div class="tableDiv" id="TableCPNUM">
		<dl class="trJoin">
			<dd>
				<input type="tel" id="i_memcpnum1" name="memcpnum1" maxlength="3">
				<p class="null"></p>
			</dd>
			<dd class="blank">‒</dd>
			<dd>
				<input type="tel" id="i_memcpnum2" name="memcpnum2" maxlength="4">
				<p class="null"></p>
			</dd>
			<dd class="blank">‒</dd>
			<dd>
				<input type="tel" id="i_memcpnum3" name="memcpnum3" maxlength="4">
				<p class="null"></p>
			</dd>
		</dl>
	</div>
	<div class="tableDiv" id="TableEMAIL">
		<dl class="trJoin">
			<dd>
				<input type="text" id="i_mememail" name="mememail" maxlength="50" placeholder="예) example@artbox.co.kr">
				<p class="null"></p>
			</dd>
		</dl>
	</div>
	<a id="TabIdSubmit" href="javascript:fnTabIdSubmit();">확인</a>
	<a id="CallSixNum" href="javascript:fnTabPwCheck();">인증번호 받기</a>
	<div class="tableDiv" id="TableSIXNUM">
		<dl class="trJoin">
			<dd>
				<p class="null"></p>
				<input type="tel" id="i_sixnum" name="sixnum" maxlength="6" placeholder="인증번호 6자리">
			</dd>
			<dd class="blank">&nbsp;</dd>
			<dd class="findpw">
				<p class="null"></p>
				<a id="CheckSixNum" href="javascript:fnCheckSixNum();">인증</a>
			</dd>
		</dl>
	</div>
</div>
<div id="FindIdResult">
	<div class="FindIdResultInner"></div>
	<a id="TabIdLogin" href="https://www.artboxmall.com:443/Home/Member/Login.asp">로그인 화면으로</a>
</div>
<div id="FindPwResult">
	<input type="hidden" id="i_memberidx" name="memberidx">
	<div class="tableDiv">
		<dl class="trJoin">
			<dd>
				<input type="password" id="i_mempwd" name="mempwd" maxlength="16" placeholder="새 비밀번호를 입력해주세요.">
				<p class="null"></p>
			</dd>
		</dl>
		<dl class="trJoin">
			<dd>
				<input type="password" id="i_mempwd2" name="mempwd2" maxlength="16" placeholder="새 비밀번호를 다시 한 번 입력해주세요.">
				<p class="null"></p>
			</dd>
		</dl>
	</div>
	<a id="TabPwSubmit" href="javascript:fnTabPwSubmit();">확인</a>
</div>
</div>
</div>

</form>







<jsp:include page="${contextPath}/Home/inc/footer.jsp"/>
</body>
</html>
