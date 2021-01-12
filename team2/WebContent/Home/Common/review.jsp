<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<%
	request.setCharacterEncoding("utf-8");
	String num = request.getParameter("num");
%>
   
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/Home/inc/head.jsp"/>
<link rel="stylesheet" type="text/css" href="${contextPath}/Home/Css/Shop/Review.css"/>
<script type="text/javascript" src="${contextPath}/Home/Js/Shop/Review.js"></script>

</head>
<body>	
	<%
		String id = (String)session.getAttribute("id");
	%>
    <section class="container">
        <article class="half">
            <h1>Review</h1>
            <div class="tabs">
                <span class="tab signup active"><a href="#">상품후기</a></span>
            </div>
            <div class="content">
                <div class="signup-cont cont">
                    <form action="${contextPath}/living/addReply.do" method="post">
                    	<input type="hidden" name="num" id="num" class="inpt" value="<%=num%>">
                        <input type="text" name="writer" id="writer" class="inpt">
                        <input type="text" name="pw" id="pw" class="inpt" placeholder="Password">
                        <textarea rows="12" cols="36" class="reviewcontent" id="content"></textarea>
                        <div class="submit-wrap">
                            <input type="submit" value="상품후기 등록" class="submit">
                        </div>
                    </form>            
                </div>
            </div>
        </article>
    </section>
    <
</body>
</html>