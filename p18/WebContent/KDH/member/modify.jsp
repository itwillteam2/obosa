<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <link rel="stylesheet" href="../css/modify.css">
    <link href="https://fonts.googleapis.com/css2?family=Gaegu&display=swap" rel="stylesheet">
    <script src="javascript/jquery-1.12.3.js"></script>
    <script src="javascript/login.js" defer="defer"></script>   
<title>Modify</title>
</head>
<body>	
	<%
		String id = (String)session.getAttribute("id");
	%>
    <section class="container">
        <article class="half">
            <h1>Login Modify</h1>
            <div class="tabs">
                <span class="tab signup active"><a href="#">정보수정</a></span>
            </div>
            <div class="content">
                <div class="signup-cont cont">
                    <form action="ModifyUp.jsp" method="post">
                        <input type="text" name="id2" id="id2" class="inpt" value="<%=id%>" readonly="readonly">
                        <input type="text" name="pw2" id="pw2" class="inpt" placeholder="New Password">
                        <input type="text" name="name2" id="name2" class="inpt" placeholder="New Name">
                        <input type="text" name="address2" id="address2" class="inpt" placeholder="New Address">
                        <div class="submit-wrap">
                            <input type="submit" value="회원 수정" class="submit2">
                        </div>
                        <div>    
                            <input type="button" value="회원 탈퇴" class="submit3" onclick="location.href='Delete.jsp'">
                        </div>
                    </form>            
                </div>
            </div>
        </article>
    </section>
</body>
</html>