<%@page import="database.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>Login Form</title>
    <link rel="stylesheet" href="css/login.css">
    <link href="https://fonts.googleapis.com/css2?family=Gaegu&display=swap" rel="stylesheet">
    <script src="javascript/jquery-1.12.3.js"></script>
    <script src="javascript/login.js" defer="defer"></script>
    <link href="https://fonts.googleapis.com/css2?family=Cute+Font&display=swap" rel="stylesheet">
</head>
	<%	
		String id = request.getParameter("id2");
		MemberDAO mdao = new MemberDAO();
		int check = mdao.idCheck(id);
	%>
<body>
    <div class="login">
        <img src="images/login/login.jpg" alt="login">
        <ul class="menu">
            <li class="lform">로그인</li>
            <li class="lform2">회원가입</li>
        </ul>
    </div>

    <section class="container">
        <article class="half">
            <h1>Login</h1>
            <div class="tabs">
                <span class="tab signin active"><a href="#">로그인</a></span>
                <span class="tab signup"><a href="#">회원가입</a></span>
            </div>
            <div class="content">
                <div class="signin-cont cont">
                    <form action="member/loginOK.jsp" method="post">
                        <label for="id" id="fade1">아이디</label>
                        <input type="text" name="id" id="id" class="inpt">

                        <label for="pw" id="fade2">패스워드</label>
                        <input type="password" name="pw" id="pw" class="inpt">
                        <div class="submit-wrap">
                            <input type="submit" value="로그인" class="submit">
                            <a href="#" class="more">비밀번호를 찾으시겠습니까?</a>
                            <a href="#"><input type="button" value="닫기" class="close"></a>
                        </div>
                    </form>
                </div>
                <div class="signup-cont cont">
                    <form action="member/signUp.jsp" method="post">
                    	<div class="inpt" id="check">중복된 아이디입니다.</div>
                    	<div class="inpt" id="check2">사용가능한 아이디입니다.</div>
                        <input type="text" name="id2" id="id2" placeholder="Your ID">
                        <input type="button" value="중복확인" id="idcheck" onclick="location.href='login2.jsp?id2='+$('#id2').val(); return false;">
                        <input type="password" name="pw2" id="pw2" class="inpt" placeholder="Your password">
                        <input type="text" name="name2" id="name2" class="inpt" placeholder="Your Name">
                        <input type="text" name="address2" id="address2" class="inpt" placeholder="Your Address">
                        <div class="submit-wrap">
                            <input type="submit" value="회원가입" class="submit2">
                            <a href="#" class="more">이용약관</a>
                        </div>
                    </form>
                    
                </div>
            </div>
        </article>
    </section>
</body>
</html>