<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
	request.setCharacterEncoding("UTF-8");
%>       

<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />   

<!DOCTYPE html>
<html lang="ko">
<head>
<jsp:include page="/Home/inc/head.jsp"/>
 
<link rel="stylesheet" type="text/css" href="${contextPath}/Home/Css/CsCenter/Cscenter.css" />

<script type="text/javascript">

	$(document).ready(function(){

	});

	$(document).on("click", ".file_x", function(){
		var targetNum = $(this).attr("data");
		
		$("[name=txFile"+targetNum+"]").val("");
		$("[name=file"+targetNum+"]").val("");
		$(this).css("display","none");
	});


	function fnItem1FileUpload()
	{
		$("[name=txFile1]").val( $("[name=file1]").val().replace(/^.*\\/, "") );
		$(".file_x[data=1]").css("display", "block");
	}
	function fnItem2FileUpload()
	{
		$("[name=txFile2]").val( $("[name=file2]").val().replace(/^.*\\/, "") );
		$(".file_x[data=2]").css("display", "block");
	}
	function fnItem3FileUpload()
	{
		$("[name=txFile3]").val( $("[name=file3]").val().replace(/^.*\\/, "") );
		$(".file_x[data=3]").css("display", "block");
	}

	// 이메일 체크 정규식

	function isEmail(asValue) {

		var regExp = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;

		return regExp.test(asValue); // 형식에 맞는 경우 true 리턴	

	}

	function InquiryInput(){
		var f = document.Inquiryfrm;

		
		if(f.memname.value == ""){
			alert("이름을 입력해주세요");
			f.memname.focus();
			return false;
		}	
		

		if(f.txPhone1.value == "" || f.txPhone2.value == "" || f.txPhone3.value == ""){
			alert("휴대폰 번호를 입력해주세요.");
			f.txPhone3.focus();
			return false;
		}	

		if(f.txEmail.value.replace(/^\s+|\s+$/g,"") == ""){
			alert("E-Mail을 입력해주세요");
			f.txEmail.focus();
			return false;
		}	

		if (!isEmail(f.txEmail.value))
		{
			alert("E-Mail형식을 확인해 주세요");
			f.txEmail.focus();
			return false;			
		}

		if(f.counselType.value == ""){
			alert("상담 유형을 선택해주시면\n각 상담 유형별 담당자가 좀 더 빠르고 정확한 답변을 드릴 수 있습니다.");
			f.counselType.focus();
			return false;
		}

		if(!f.txSubject.value){
			alert("제목을 입력해주세요.");
			f.txSubject.focus();
			return false;
		}	

		if(f.txSubject.value.length < 2){
			alert("제목을 2자 이상 입력하세요.");
			f.txSubject.focus() ;
			return;	
		}

		if(!f.txContent.value){
			alert("내용을 입력해주세요.");
			f.txContent.focus();
			return false;
		}	


		if(f.txContent.value.length > 32767) {
			alert("문의내용은 32767바이트(한글 약 15000자)를 넘길 수 없습니다.\t");
			return false;
		}
	}

</script>
</head>
<body>
	<jsp:include page="../inc/hdr_menu.jsp" />
	<div id="CommonHeaderArea"></div>
	<div id="CommonHeader_M"></div>

	<div class="wrap" id="ori_wrap">
		<div class="top_title">고객감동센터</div>	
	<div class="MenuBar_Box">
		<ul>
			<li onclick="location.href='${contextPath}/Home/CsCenter/NoticeList.jsp';" >공지사항</li>
			<li onclick="location.href='${contextPath}/Home/CsCenter/InquiryList.jsp';" >상품Q&A</li>
			<li onclick="location.href='${contextPath}/Home/CsCenter/InquiryWrite.jsp';" class="on">1:1 문의/상담</li>
		</ul>
	</div>
	
	<form name="Inquiryfrm" method="post" enctype="multipart/form-data">	
	<div class="warning_box">
		<span>답변 가능 시간은 오전 9:00시부터 오후 6:00시까지입니다. (주말 및 공휴일 제외)</span>
	</div>

	<div class="outter_box">
		<div class="left_box">
			<div>
				<ul>
					<li>*이름</li>
					<li>
							<input type="text" name="memname" value=""/>
					</li>
				</ul>
			</div>
			
			<div>
				<ul>
					<li>*휴대전화</li>
					<li>
						<input type="num" name="txPhone1" maxlength="4" title="연락처를 입력하세요." value=""/>
						<span class="dasi">-</span>
						<input type="num" name="txPhone2" maxlength="4" title="연락처를 입력하세요." value=""/>
						<span class="dasi">-</span>
						<input type="num" name="txPhone3" maxlength="4" title="연락처를 입력하세요." value=""/>
					</li>
				</ul>
			</div>
			<div>
				<ul>
					<li>*이메일</li>
					<li>
						<input type="text" name="txEmail" value=""/>
					</li>
				</ul>
			</div>
			<div class="underline"></div>

			<div>
				<ul>
					<li>*문의분야</li>
					<li>
						<select id="counselType" name="counselType" title="상담유형 선택">
							<option value="" selected="selected">상담유형 선택</option>											
							<option value="01">주문/결제</option>
							<option value="02">배송</option>
							<option value="03">취소/반품/교환</option>
							<option value="04">기타</option>
						</select>
					</li>
				</ul>
			</div>
						
		</div>
		<div class="right_box">

			<div>
				<ul>
					<li>*제목</li>
					<li>
						<input type="text" name="txSubject" />
					</li>
				</ul>
			</div>

			<div>
				<ul>
					<li>*문의내용</li>
					<li class="textbox">
						<textarea type="text" name="txContent"></textarea>
					</li>
				</ul>
			</div>
		</div>
	</div>
	<div class="btn_area">
		<span onclick="history.back(-1);">취소</span>
		<span onclick="InquiryInput();">등록</span>
	</div>
	

	</form>
</div>


	<jsp:include page="../inc/footer.jsp" />
</body>
</html>