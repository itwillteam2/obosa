<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<%
	request.setCharacterEncoding("utf-8");
	String qnum = request.getParameter("qnum");
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
            <h1>Q&A Reply</h1>
            <div class="tabs">
                <span class="tab signup active"><a href="#">QnA답변</a></span>
            </div>
            <div class="content">
                <div class="signup-cont cont">
                    <form action="${contextPath}/<%=category%>/addQnaReply.do" method="post">
                    	<input type="hidden" name="qnum" id="qnum" class="inpt" value="<%=qnum%>">
                    	<input type="hidden" name="category" id="category" class="inpt" value="<%=category %>">
                        <textarea rows="13" cols="36" class="reviewcontent" id="content" name="content"></textarea>
                        <input type="text" name="pw" id="pw" class="inpt" placeholder="Password" style="margin-top:20px;">
                        <div class="submit-wrap">
                            <input type="submit" value="답변 등록" class="submit">
                        </div>
                    </form>            
                </div>
            </div>
        </article>
    </section>
</body>
</html>