<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<%
	request.setCharacterEncoding("utf-8");
	String num = request.getParameter("num");
	String category = request.getParameter("category");
%>
   
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/Home/inc/head.jsp"/>
<link rel="stylesheet" type="text/css" href="${contextPath}/Home/Css/Shop/Review.css"/>
<script type="text/javascript" src="${contextPath}/Home/Js/Shop/Review.js"></script>

</head>
<body>	
    <section class="container">
        <article class="half">
            <h1>Q&A</h1>
            <div class="tabs">
                <span class="tab signup active"><a href="#">QnA작성</a></span>
            </div>
            <div class="content">
                <div class="signup-cont cont">
                    <form action="${contextPath}/<%=category%>/addQna.do" method="post">
                    	<input type="hidden" name="num" id="num" class="inpt" value="<%=num%>">
                    	<input type="hidden" name="category" id="category" class="inpt" value="<%=category %>">
                        <input type="text" name="writer" id="writer" class="inpt" value="${sessionScope.id}" readonly>
                        <input type="text" name="title" id="title" class="inpt" placeholder="Title">
                        <input type="text" name="pw" id="pw" class="inpt" placeholder="Password">
                        <textarea rows="9" cols="36" class="reviewcontent" id="content" name="content"></textarea>
                        <div class="submit-wrap">
                            <input type="submit" value="질문 등록" class="submit">
                        </div>
                    </form>            
                </div>
            </div>
        </article>
    </section>
</body>
</html>