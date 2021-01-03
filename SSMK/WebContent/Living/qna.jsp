<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
    
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<link rel="stylesheet" type="text/css" href="${contextPath}/T2_tmp/Home/Css/Shop/Review.css"/>
    <link href="https://fonts.googleapis.com/css2?family=Gaegu&display=swap" rel="stylesheet">
	<script type="text/javascript" src="${contextPath}/T2_tmp/Home/Js/Common/jquery-1.11.3.min.js"></script>
	<script type="text/javascript" src="${contextPath}/T2_tmp/Home/Js/Shop/Review.js"></script>
<title>Q&A</title>
</head>
<body>	
	<%
		String id = (String)session.getAttribute("id");
	%>
    <section class="container">
        <article class="half">
            <h1>Q&A</h1>
            <div class="tabs">
                <span class="tab signup active"><a href="#">Q&A</a></span>
            </div>
            <div class="content">
                <div class="signup-cont cont">
                    <form action="ModifyUp.jsp" method="post">
                        <input type="text" name="id2" id="id2" class="inpt" value="<%=id%>" readonly="readonly">
                        <input type="text" name="pw2" id="pw2" class="inpt" placeholder="Password">
                        <textarea rows="9" cols="36" class="reviewcontent" id="content"></textarea>
                        <div class="submit-wrap">
                            <input type="submit" value="질문 등록" class="submit2">
                        </div>

                    </form>            
                </div>
            </div>
        </article>
    </section>
</body>
</html>