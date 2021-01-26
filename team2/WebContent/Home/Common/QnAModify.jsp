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
 <!--  별 추가  -->

		<style type="text/css">
		#grade {display:block;height:50px;margin-top:12px}
		#grade:before{float:left;width:32px;height:32px;margin:10px 45px 10px 15px;content:"Grade";}
		li.grade {float:left;width:32px;height:32px;margin:auto;background-image:url('../../Images/Ver1/Beta/star_bb.png')}
		li.grade.set {background-image:url('../../Images/Ver1/Beta/star_yb.png')}
		
		</style>
		<script type="text/javascript">
			$(document).on("click", ".grade", function() {
				var score = $(this).attr("data-grd");
					$("li.grade").each(function(){
						if($(this).attr("data-grd")<=score){
								$(this).addClass("set");
							}else{
								$(this).removeClass("set");
							}
						});
			$("[name='grade']").val(score);
			}); 
		</script>
 <!--  별 추가  끝 -->
</head>
<body>	
    <section class="container">
        <article class="half">
            <h1>Review</h1>
            <div class="tabs">
                <span class="tab signup active"><a href="#">QnA</a></span>
            </div>
            <div class="content">
                <div class="signup-cont cont">
                    <form action="${contextPath}/<%=category%>/QnAModify.do" method="post">
                    	<input type="hidden" name="qnum" id="qnum" class="inpt" value="<%=qnum%>">
                    	<input type="hidden" name="category" id="category" class="inpt" value="<%=category %>">
                        <input type="text" name="writer" id="writer" class="inpt" value="${sessionScope.id}" readonly>
                        <input type="text" name="title" id="title" class="inpt" placeholder="Title">
                        <input type="password" name="pw" id="pw" class="inpt" placeholder="Password">
                        <textarea rows="9" cols="36" class="reviewcontent" id="content" name="content"></textarea>
                        <div class="submit-wrap">
                            <input type="submit" value="QnA 수정" class="submit">
                        </div>
                    </form>            
                </div>
            </div>
        </article>
    </section>
</body>
</html>