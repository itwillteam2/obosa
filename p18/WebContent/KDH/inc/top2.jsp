<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%
    	request.setCharacterEncoding("utf-8");
    	String id = (String)session.getAttribute("id");
    %>    
<header>
    <div class="header_logo">
        <a href="../index.jsp"><img src="../logo/LOGO.jpg" alt="logo"></a>
    </div>
    <div>
        <ul class="topmenu">
            <li><%=id %>님 환영합니다.</li>
            <li><a href="#" onclick="window.open('../member/modify.jsp', '회원정보수정', 'width=500, height=500 location=no status=no scrollbars=no left=500 top=100' )">개인정보수정</a></li>
            <li><a href="../member/logout.jsp">로그아웃</a></li>
        </ul>
    </div>
    <nav>
        <ul class="nav">
            <li><a href="#">공개</a>
                <ul class="submenu">
                    <li><a href="../Notice.jsp">공지사항</a></li>
                    <li><a href="../Download.jsp">자료실</a></li>
                </ul>
            </li>
            <li><a href="#">참여</a>
                <ul class="submenu">
                    <li><a href="../GuestBook.jsp">방명록</a></li>
                    <li><a href="../PhotoGallery.jsp">사진갤러리</a></li>
                    <li><a href="../Question.jsp">문의하기</a></li>
                    <li><a href="" onclick="window.open('../chat/chat.jsp', '실시간 채팅', 'width=500px, height=500px')">실시간 채팅</a></li>
                </ul>
            </li>
            <li><a href="#">소개</a>
                <ul class="submenu">
                    <li><a href="../SongjungHistory.jsp">송정동 소개</a></li>
                    <li><a href="../Direction.jsp">찾아오시는길</a></li>
                </ul>
            </li>
        </ul>
    </nav>
</header>