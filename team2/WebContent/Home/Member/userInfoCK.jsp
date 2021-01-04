<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<c:set var="recentURI" value="${header.referer}"/>
<c:set var="id" value="${sessionScope.id}"/>
<c:set var="pwd" value="${vo.pwd}"/>

<!DOCTYPE html>
<html lang="ko">
<head>
<jsp:include page="/Home/inc/head.jsp"/>
<script type="text/javascript">

	function fnCheck(){

		var mempwd = document.Check.mempwd.value;

		if (!mempwd) {
			alert("비밀번호를 입력해주세요.");
			$("input[name=mempwd]").focus();
			return;
		}

	if(mempwd != "${pwd}"){
		alert("비밀번호가 일치하지 않습니다.");
		return;
	}
	document.Check.submit();
	}
	
</script>
</head>
<body>
<jsp:include page="/Home/inc/hdr_logo.jsp" />

<form name="Check" method="post" action="${contextPath}/member/userInfo.do">
<input type="hidden" name="recentURI" value="${recentURI}">
<div class="LoginWrap">
	<div class="LoginTitle">비밀번호 확인</div>
	<div class="LoginComment"></div>
	<input type="hidden" name="recentURI" value="${recentURI}">
	<div class="LoginInput"><input type="password" name="mempwd" placeholder="비밀번호를 입력해주세요." maxlength="32" onkeypress="if(event.keyCode==13){fnLogin(1);}" /></div>
	<a class="LoginButton" href="javascript:fnCheck();">확인</a>
</div>
</form>
<jsp:include page="/Home/inc/footer.jsp" />
</body>
</html>
