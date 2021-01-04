<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
 <% String id = (String)session.getAttribute("id"); %>   
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/Home/inc/head.jsp"/>

<link rel="stylesheet" type="text/css" href="${contextPath}/Home/Css/Shop/Review.css"/>
<script type="text/javascript" src="${contextPath}/Home/Js/Shop/Review.js"></script>
</head>
<body>	
<jsp:include page="/Home/inc/header.jsp"/>	
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
    <jsp:include page="/Home/inc/footer.jsp"/>
</body>
</html>