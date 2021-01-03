<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<c:set var="id" value="${sessionScope.id}"/>
<c:set var="recentURI" value="${recentURI}"/>
<c:set var="shopName" value="${vo.shopName}"/>
<c:set var="cpnum" value="${vo.cpnum}"/>
<c:set var="pnum" value="${vo.pnum}"/>
<!DOCTYPE html>
<html lang="ko">
<head>

    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">

    <meta http-equiv="Content-Script-Type" content="text/javascript">
    <meta http-equiv="Content-Style-Type" content="text/css">

    <title>SSMarket</title>
    
	<link href="${contextPath}/T2_tmp/Home/Css/Common/Common.css" type="text/css" rel="stylesheet" />
	<link href="${contextPath}/T2_tmp/Home/Css/Common/swiper.min.css" type="text/css" rel="stylesheet" />
	<script type="text/javascript" src="${contextPath}/T2_tmp/Home/Js/Common/jquery-1.11.3.min.js"></script>
	
	<script type="text/javascript" src="${contextPath}/T2_tmp/Home/Js/Common/Common.js"></script>
	
	<script type="text/javascript" src="${contextPath}/T2_tmp/Home/Js/Common/swiper_r.min.js"></script>
	
	<link rel="stylesheet" type="text/css" href="${contextPath}/T2_tmp/Home/Css/Member/Member.css" />
	<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>

    <script type="text/javascript">
   
    $(document).ready(function(){
    	 var cpnum = "${cpnum}";
    	 var cpnumlist = cpnum.split("-");
    	 var cpnum1 = cpnumlist[0];
    	 var cpnum2 = cpnumlist[1];
    	 var cpnum3 = cpnumlist[2];
         $("#i_memcpnum1").val(cpnum1);
         $("#i_memcpnum2").val(cpnum2);
         $("#i_memcpnum3").val(cpnum3);
         
         var pnum = "${pnum}";
    	 var pnumlist = pnum.split("-");
    	 var pnum1 = pnumlist[0];
    	 var pnum2 = pnumlist[1];
    	 var pnum3 = pnumlist[2];
         $("#i_mempnum1").val(pnum1);
         $("#i_mempnum2").val(pnum2);
         $("#i_mempnum3").val(pnum3);
         
         var shopName = "${shopName}"
         if(shopName == ""){
        	 $("#customer").attr("checked", "checked");
        	 $("#seller").css("display", "none");
        	 $("#sellerl").css("display", "none");
         }else{
        	 $("#seller").attr("checked", "checked");
        	 $("#memname").css('display', "none");
             $("#sellname").css('display', "");
         	 $("#sellnum").css('display', "");
         	 $("#mempnum").css('display', "");
         	 $("#customer").css("display", "none");
         	 $("#customerl").css("display", "none");
         }
        	 
         /* Checkbox change event */
         $('input[name="memtype"]').change(function() {
             $('input[name="memtype"]').each(function() {
                 var value = $(this).val();
                 var checked = $(this).prop('checked');
          		
                 if(checked){
                 	if(value == "customer"){
 	                	$("#memname").css('display', "");
 	                    $("#sellname").css('display', "none");
 	               		$("#sellnum").css('display', "none");
 	               		$("#mempnum").css('display', "none");
                 	}else{
                 		$("#memname").css('display', "none");
                        $("#sellname").css('display', "");
                    	$("#sellnum").css('display', "");
                    	$("#mempnum").css('display', "");
                 	}
                 }});
         });
    
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
            if (this.id=="i_checkmemcpnum1"&&this.value.length>=3) {
                document.getElementById("i_checkmemcpnum2").focus();
            }
            if (this.id=="i_checkmemcpnum2"&&this.value.length>=4) {
                document.getElementById("i_checkmemcpnum3").focus();
            }
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
        				document.getElementById('i_mempostcode').value = data.zonecode;
        				document.getElementById("i_memaddr1").value = addr + extraAddr;
        				// 커서를 상세주소 필드로 이동한다.
        				document.getElementById("i_memaddr2").value = "";
        				document.getElementById("i_memaddr2").focus();
        				
        				}
        			}).open();
        	}
        
        fnCallSixNum = function(mememail){
        	 if (!$("#i_mememail").val()) {
                 alert("이메일을 입력해주세요.");
                 return;
             }
     
             if (!Check_Email($("#i_mememail").val())) {
                 alert("사용할 수 없는 이메일 주소입니다.");
                 return;
             }
             
             if($("#r_mememail").text() == "사용할 수 있는 이메일입니다."){
            	 var email = $("#i_mememail").val();
            	 $("#emailConfirm").css("display", "");
            	 var url="${contextPath}/T2_tmp/Home/Member/emailCheck.jsp?email="+email;
     			open(url,"emailwindow", "statusbar=no, scrollbar=no, menubar=no, width=600, height=130, left=800, top=450" );
             }
        } 
    
        fnCheckSixNum = function(){
    
            var v_sixnum = $("#i_sixnum").val();
    
            if (v_sixnum.length!=5) {
                alert("인증번호 5자리를 입력해주세요.");
                return;
            }
    		
            if(v_sixnum == $("#i_mememail_valid").val()){
            	$("#i_memsixnum_valid").attr("value", "1");
            	alert("메일 인증이 완료되었습니다.");
            	$("#i_sixnum").attr("readonly", "readonly");
            	return;
            }else{
            	alert("인증 번호가 틀립니다.");
            	return;
            }

        }
    
        fnValid = function(id) {
    
            if (id=="i_memid") {
    
                if ($("#i_memid").val().length>=4) {
    
                    if (!Check_Id($("#i_memid").val())) {
                        $("#r_memid").attr("class","red");
                        $("#r_memid").text("아이디는 4~16자 영문과 숫자를 조합해야 합니다.");
                        $("#i_memid_valid").val("");
                        return;
                    }
                    
                    var id = $("#i_memid").val();	
                    
        			$.ajax({
        				type : "post",
        				async : true,
        				url : "http://localhost:8080/team2/dup",
        				dataType : "text",
        				data : {id:id},
        				success : function(data, textStatus){
        					if(data == "usable"){
        						$("#r_memid").attr("class","green");
        	                    $("#r_memid").text("사용할 수 있는 아이디입니다.");
        					}else{
        						$("#r_memid").attr("class","red");
        	                    $("#r_memid").text("사용할 수 없는 아이디입니다.");
        					}
        				},
        				error : function(data, textStatus){
        					alert(data);
        					alert("에러 발생");
        				}
        			});
                
                } else {
                    $("#r_memid").attr("class","null");
                    $("#r_memid").text("");
                    $("#i_memid_valid").val("");
                }
    
            } else if (id=="i_mempwd") {
                if ($("#i_mempwd").val().length>=4) {
    
                    if (!Check_Pw($("#i_mempwd").val())) {
                        $("#r_mempwd").attr("class","red");
                        $("#r_mempwd").text("비밀번호는 4~16자 영문 숫자 조합이어야 합니다.");
                        return;
                    }
    
                    $("#r_mempwd").attr("class","green");
                    $("#r_mempwd").text("사용할 수 있는 비밀번호입니다.");
    
                } else {
                    $("#r_mempwd").attr("class","null");
                    $("#r_mempwd").text("");
                }
    
            } else if (id=="i_mempwd2") {
                if ($("#i_mempwd2").val().length>=4) {
    
                    if ($("#i_mempwd2").val()!=$("#i_mempwd").val()) {
                        $("#r_mempwd2").attr("class","red");
                        $("#r_mempwd2").text("비밀번호가 일치하지 않습니다.");
                        return;
                    }
    
                    $("#r_mempwd2").attr("class","green");
                    $("#r_mempwd2").text("비밀번호가 일치합니다.");
    
                } else {
                    $("#r_mempwd2").attr("class","null");
                    $("#r_mempwd2").text("");
                }
    
            } else if (id=="i_mememail") {
    
                if ($("#i_mememail").val().length>=5) { //a@a.a 최소 5자리
    
                    if (!Check_Email($("#i_mememail").val())) {
                        $("#r_mememail").attr("class","red");
                        $("#r_mememail").text("사용할 수 없는 이메일 주소입니다.");
                        return;
                    }
    
                    var email = $("#i_mememail").val();
                    
         			$.ajax({
         				type : "post",
         				async : true,
         				url : "http://localhost:8080/team2/emailDup",
         				dataType : "text",
         				data : {email:email},
         				success : function(data, textStatus){
         					if(data == "usable"){
         						$("#r_mememail").attr("class","green");
         	                    $("#r_mememail").text("사용할 수 있는 이메일입니다.");
         					}else{
         						$("#r_mememail").attr("class","red");
         	                    $("#r_mememail").text("사용할 수 없는 이메일입니다.");
         					}
         				},
         				error : function(data, textStatus){
         					alert(data);
         					alert("에러 발생");
         				}
         			});
                
                } else {
                    $("#r_mememail").attr("class","null");
                    $("#r_mememail").text("");
                }
            } 
    
        }
    
        fnJoinRe = function(){
            if (confirm("이미 가입하기 버튼을 누르셨습니다. 재시도 하시겠습니까?")){
                setTimeout("fnJoin();",3000);
            }
        }
    
        fnJoin = function(){
    
            if (!$("#i_mempwd").val()) {
                alert("비밀번호를 입력해주세요.");
                $("#r_mempwd").attr("class","null");
                $("#r_mempwd").text("");
                $("#i_mempwd").focus();
                return;
            }
    
            if (!Check_Pw($("#i_mempwd").val())) {
                alert("비밀번호 4~16자 영문 숫자 조합이어야 합니다.");
                $("#r_mempwd").attr("class","null");
                $("#r_mempwd").text("");
                $("#i_mempwd").focus();
                return;
            }
    
            if ($("#i_mempwd2").val()!=$("#i_mempwd").val()) {
                alert("비밀번호가 일치하지 않습니다.");
                $("#r_mempwd2").attr("class","null");
                $("#r_mempwd2").text("");
                $("#i_mempwd2").focus();
                return;
            }
    
            if(document.Join.memtype.value == "seller"){
            	if(!$("#i_sellnum").val()) {
                	alert("사업자등록번호를 입력해주세요.");
                	$("#i_sellnum").focus();
                	return;
                }
            	
            	var RegExp2 = /^\d{3}-\d{2}-\d{5}$/;
                var sellnumCheck = $("#i_sellnum").val();
                if (!RegExp2.test(sellnumCheck)) {
                    alert("사업자등록번호는 - 를 포함하여 공백없이 적어주세요.");
                    $("#i_sellnum").focus();
                    return false;
                }
                
                if (!$("#i_sellname").val()) {
                    alert("상호를 입력해주세요.");
                    $("#i_sellname").focus();
                    return;
                }
                
                if (!$("#i_mempnum1").val()) {
                    alert("유선전화 번호를 입력해주세요.");
                    $("#i_mempnum1").focus();
                    return;
                }
        
                if (!$("#i_mempnum2").val()) {
                    alert("유선전화 번호를 입력해주세요.");
                    $("#i_mempnum2").focus();
                    return;
                }
        
                if (!$("#i_mempnum3").val()) {
                    alert("유선전화 번호를 입력해주세요.");
                    $("#i_mempnum3").focus();
                    return;
                }
                
            }else{
            	if (!$("#i_memname").val()) {
                    alert("이름을 입력해주세요.");
                    $("#i_memname").focus();
                    return;
                }
            	
            	var RegExp = /[^a-zA-Z가-힣0-9\s]/;
                var nameCheck = $("#i_memname").val();
                if (RegExp.test(nameCheck)) {
                    alert("이름에 특수문자는 입력하실 수 없습니다.");
                    $("#i_memname").focus();
                    return false;
                }
            }
    
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
            
           var email = $("#i_mememail").val()
           
           if(email == ""){
        	   alert("이메일을 입력해주세요.");
        	   $("#i_mememail").focus();
               return;
           }
           
           if(email != "${vo.email}"){
               if($("#i_memsixnum_valid").val() != "1"){
                   alert("이메일 인증을 해 주십시오");
                   $("#i_mememail").focus();
                   return;
               }
		   }
    
            if (!Check_Email($("#i_mememail").val())) {
                alert("사용할 수 없는 이메일 주소입니다.");
                $("#r_mememail").attr("class","null");
                $("#r_mememail").text("");
                $("#i_mememail").focus();
                return;
            }
            
            if(email == null){
	            if($("#r_mememail").text() != "사용할 수 있는 이메일입니다."){
	            	alert("사용할 수 없는 이메일입니다.");
	            	$("#i_mememail").focus();
	            }
            }
            
            if(email == null){
	            if($("#i_memsixnum_valid").val() != "1"){
	            	alert("이메일 인증이 완료되지 않았습니다");
	            	$("i_sixnum").focus();
	            	return;
	            }
            }
            
            if(!$("#i_mempostcode").val()){
            	alert("주소를 입력해주세요.");
            	return;
            }
            
            if(!$("#i_memaddr1").val()){
            	alert("주소를 입력해주세요.");
            	return;
            }
            
    		var cpnum = $("#i_memcpnum1").val() + "-" + $("#i_memcpnum2").val() + "-" + $("#i_memcpnum3").val();
    
            $(".JoinButton").attr("href","javascript:fnJoinRe();");
            
            document.Join.submit();
    
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
    </head>
    <body>
<body>
	<jsp:include page="..//inc/header.jsp" />
	<div id="CommonHeaderArea"></div>
	<div id="CommonHeader_M"></div>

<form name="Join" method="post" action="${contextPath}/member/modMember.do">
<div class="JoinWrap">
<input type="hidden" name="recentURI" value="${recentURI}">
<h1>회원정보 변경</h1>
<div class="JoinForm">
    <div class="tableDiv">
        <dl class="trJoin">
            <dt>회원 유형</dt>
            <dd>
            	<p class="null"></p>
                <input type="radio" name="memtype" value="customer" id="customer"> <label id="customerl">일반회원</label>
                <input type="radio" name="memtype" value="seller" id="seller"> <label id="sellerl">판매자</label>
                <p class="null" id="r_memtype"></p>
                <input type="hidden" id="i_memtype_valid" name="memtype_valid">
            </dd>
        </dl>
    </div>
    <div class="tableDiv">
        <dl class="trJoin">
            <dt>아이디</dt>
            <dd>
                <input type="text" id="i_memid" name="memid" value="${id}" readonly>
                <p class="null" id="r_memid"></p>
                <input type="hidden" id="i_memid_valid" name="memid_valid">
            </dd>
        </dl>
        <dl class="trJoin">
            <dt>비밀번호</dt>
            <dd>
                <input type="password" id="i_mempwd" name="mempwd" maxlength="16" placeholder="4~16자 영문 숫자 조합" onkeyup="fnValid(this.id);">
                <p class="null" id="r_mempwd"></p>
            </dd>
        </dl>
        <dl class="trJoin">
            <dt>비밀번호 확인</dt>
            <dd>
                <input type="password" id="i_mempwd2" name="mempwd2" maxlength="16" onkeyup="fnValid(this.id);">
                <p class="null" id="r_mempwd2"></p>
            </dd>
        </dl>
        <dl class="trJoin" id="sellnum" style="display: none;">
            <dt>사업자등록번호</dt>
            <dd>
                <input type="text" id="i_sellnum" name="sellnum" maxlength="12" value="${vo.businessRegNum}">
                <p class="null" id="r_sellnum"></p>
            </dd>
        </dl>
        <dl class="trJoin" id="sellname" style="display: none;">
            <dt>상호</dt>
            <dd>
                <input type="text" id="i_sellname" name="sellname" maxlength="16" value="${vo.shopName}">
                <p class="null" id="r_sellname"></p>
            </dd>
        </dl>
        <dl class="trJoin" id="memname">
            <dt>이름</dt>
            <dd>
                <input type="text" id="i_memname" name="memname" maxlength="16" value="${vo.name}">
                <p class="null" id="r_memname"></p>
            </dd>
        </dl>
    </div>
    <div class="tableDiv">
        <dl class="trJoin" id="mempnum" style="display: none;">
            <dt>유선전화</dt>
            <dd>
                <input type="tel" id="i_mempnum1" name="mempnum1" maxlength="3">
                <p class="null" id="r_mempnum1"></p>
            </dd>
            <dd class="blank">‒</dd>
            <dd>
                <input type="tel" id="i_mempnum2" name="mempnum2" maxlength="4">
                <p class="null" id="r_mempnum2"></p>
            </dd>
            <dd class="blank">‒</dd>
            <dd>
                <input type="tel" id="i_mempnum3" name="mempnum3" maxlength="4">
                <p class="null" id="r_mempnum3"></p>
            </dd>
        </dl>
    </div>
    <div class="tableDiv">
        <dl class="trJoin">
            <dt>휴대전화</dt>
            <dd>
                <input type="tel" id="i_memcpnum1" name="memcpnum1" maxlength="3">
                <p class="null" id="r_memcpnum1"></p>
            </dd>
            <dd class="blank">‒</dd>
            <dd>
                <input type="tel" id="i_memcpnum2" name="memcpnum2" maxlength="4">
                <p class="null" id="r_memcpnum2"></p>
            </dd>
            <dd class="blank">‒</dd>
            <dd>
                <input type="tel" id="i_memcpnum3" name="memcpnum3" maxlength="4">
                <p class="null" id="r_memcpnum3"></p>
            </dd>
        </dl>
    </div>
    <div class="tableDiv">
        <dl class="trJoin">
            <dt>이메일</dt>
            <dd>
                <input type="text" id="i_mememail" name="mememail" maxlength="50" value="${vo.email}" onblur="fnValid(this.id);">
                <input type="hidden" id="i_mememail_valid" name="mememail_valid">
                <p class="null" id="r_mememail"></p>
            </dd>
            <dd class="button">
            	<a href="javascript:fnCallSixNum(document.Join.mememail.value);" id="btnCallSixNum1">이메일 변경</a>
            </dd>
        </dl>
    </div>
    <div class="MobileButton"><a href="javascript:fnCallSixNum();" id="btnCallSixNum2">이메일 변경</a></div>
    <div class="tableDiv">
        <dl class="trJoin" style="display: none;" id="emailConfirm">
            <dt>&nbsp;</dt>
            <dd>
                <input type="tel" id="i_sixnum" name="sixnum" maxlength="5" placeholder="인증번호 5자리">
                <p class="null" id="r_sixnum"></p>
                <input type="hidden" id="i_memsixnum_valid" name="memsixnum_valid">
            </dd>
            <dd class="button">
                <a href="javascript:fnCheckSixNum();">확인</a>
            </dd>
        </dl>
    </div>
    <div class="tableDiv">
        <dl class="trJoin">
            <dt>주소</dt>
            <dd>
                <input type="text" id="i_mempostcode" name="mempostcode" maxlength="5"  value= "${vo.postcode}" readonly>
                <p class="null" id="r_mempostcode"></p>
            </dd>
            <dd class="button">
                <a href="javascript:fnGetAddressInfo();" id="postcode">우편번호 찾기</a>
            </dd>
        </dl>
    </div>
    
    <div class="tableDiv">
        <dl class="trJoin">
            <dt>&nbsp;</dt>
            <dd>
                <input type="text" id="i_memaddr1" name="memaddr1" value="${vo.addr1}" readonly>
                <p class="null" id="r_memaddr1"></p>
            </dd>
        </dl>
    </div>
    <div class="tableDiv">
        <dl class="trJoin">
            <dt>&nbsp;</dt>
            <dd>
                <input type="text" id="i_memaddr2" name="memaddr2" value="${vo.addr2}" placeholder="상세주소">
                <p class="null" id="r_memaddr2"></p>
            </dd>
        </dl>
    </div>
    <a class="JoinButton" href="javascript:fnJoin();">회원정보 수정</a>
    <input type="hidden" name="snslogin" id="i_snslogin" value="N">
</div>
</div>
</form>

<jsp:include page="../inc/footer.jsp" />

</body>
</html>