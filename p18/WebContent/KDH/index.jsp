<%@page import="download.DownloadBean"%>
<%@page import="gallery.GalleryBean"%>
<%@page import="guest.GuestBean"%>
<%@page import="download.DownloadDAO"%>
<%@page import="gallery.GalleryDAO"%>
<%@page import="guest.GuestDAO"%>
<%@page import="board.BoardDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="board.BoardBean"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>Welcome to Songjung</title>
    <link rel="stylesheet" href="css/style.css">
    <script src="javascript/jquery-1.12.3.js"></script>
    <script src="javascript/script.js" defer="defer"></script>
    <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script>
<%
	request.setCharacterEncoding("utf-8");
	String id = (String)session.getAttribute("id");
%> 
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                var addr = ''; 
                var extraAddr = ''; 

                if (data.userSelectedType === 'R') { 
                    addr = data.roadAddress;
                } else { 
                    addr = data.jibunAddress;
                }

                if(data.userSelectedType === 'R'){
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    document.getElementById("sample6_extraAddress").value = extraAddr;
                
                } else {
                    document.getElementById("sample6_extraAddress").value = '';
                }
                document.getElementById('sample6_postcode').value = data.zonecode;
                document.getElementById("sample6_address").value = addr;
                document.getElementById("sample6_detailAddress").focus();
                
            }
        }).open();
    }
</script>

<%
	BoardDAO boardDAO = new BoardDAO();
	GuestDAO guestDAO = new GuestDAO();
	GalleryDAO galleryDAO = new GalleryDAO();
	DownloadDAO downloadDAO = new DownloadDAO();

	int count = boardDAO.getBoardCount();
	int count2 = guestDAO.getGuestCount();
	int count3 = galleryDAO.getGalleryCount();
	int count4 = downloadDAO.getdownloadCount();
	
	int pageSize = 5;
	
	int pageSize2 = 3;
	
	String pageNum = request.getParameter("pageNum");
	
	if(pageNum == null){
		pageNum = "1";
	}
	
	int currentPage = Integer.parseInt(pageNum);
	
	int startRow = (currentPage -1) * pageSize; 
	
	List<BoardBean> list = null; 
	List<GuestBean> list2 = null;
	List<GalleryBean> list3 = null;
	List<DownloadBean> list4 = null;
	
	if(count > 0){
		list = boardDAO.getBoardList(startRow, pageSize);
		list2 = guestDAO.getGuestList(startRow, pageSize);
		list3 = galleryDAO.getGalleryList(startRow, pageSize2);
		list4 = downloadDAO.getdownloadList(startRow, pageSize);
	}
	//날짜 포맷 형식을 개발자가 지정할 수 있는 객체 생성
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");
%>


</head>
<body>
<header>
    <div class="header_logo">
        <a href="index.jsp"><img src="logo/LOGO.jpg" alt="logo"></a>
    </div>
    <div>
        <ul class="topmenu">
            <li><%=id %>님 환영합니다.</li>
            <li><a href="" onclick="window.open('member/modify.jsp', '회원정보수정', 'width=500, height=500 location=no status=no scrollbars=no left=500 top=100' )">개인정보수정</a></li>
            <li><a href="member/logout.jsp">로그아웃</a></li>
        </ul>
    </div>
    <nav>
        <ul class="nav">
            <li><a href="">공개</a>
                <ul class="submenu">
                    <li><a href="Notice.jsp">공지사항</a></li>
                    <li><a href="Download.jsp">자료실</a></li>
                </ul>
            </li>
            <li><a href="">참여</a>
                <ul class="submenu">
                    <li><a href="GuestBook.jsp">방명록</a></li>
                    <li><a href="PhotoGallery.jsp">사진갤러리</a></li>
                    <li><a href="Question.jsp">문의하기</a></li>
                    <li><a href="" onclick="window.open('chat/chat.jsp', '실시간 채팅', 'width=500px, height=500px')">실시간 채팅</a></li>
                </ul>
            </li>
            <li><a href="">소개</a>
                <ul class="submenu">
                    <li><a href="SongjungHistory.jsp">송정동 소개</a></li>
                    <li><a href="Direction.jsp">찾아오시는길</a></li>
                </ul>
            </li>
        </ul>
    </nav>
</header>
<div class="clear"></div>

<div class="imgslide">
    <div class="imgs">
        <img src="images/slide/images(1).jpg" alt="">
        <img src="images/slide/images(2).jpg" alt="">
        <img src="images/slide/images(3).jpg" alt="">
    </div>
</div>
<div class="clear"></div>

<div class="con">
    <section class="con1">
        <p class="more on"><a href="Notice.jsp">더 보기</a></p>
        <h2 class="on"><a href="#">공지사항</a></h2>
        <ul class="notice on"> 
	        <%
			if(count > 0){//DB에 글이 존재 한다면
				for(int i = 0; i<list.size(); i++){
					BoardBean bean = list.get(i);
			%>
				<li><a href="board/content.jsp?num=<%=bean.getNum()%>&pageNum=<%=pageNum%>"><%=bean.getSubject() %><span class="day"><%=sdf.format(bean.getDate())%></span></a></li>
			<%		
				}
			}
			%>        
        </ul>
        
        <p class="more"><a href="GuestBook.jsp">더 보기</a></p>
        <h2 class="txt "><a href="#">방명록</a></h2>
            <ul class="guest ">
            <%
			if(count2 > 0){//DB에 글이 존재 한다면
				for(int i = 0; i<list2.size(); i++){
					GuestBean bean = list2.get(i);
			%>
				<li><a href="guest/content.jsp?num=<%=bean.getNum()%>&pageNum=<%=pageNum%>"><%=bean.getSubject() %><span class="day"><%=sdf.format(bean.getDate())%></span></a></li>
			<%		
				}
			}
			%>        
        </ul>
            
        <p class="more"><a href="PhotoGallery.jsp">더 보기</a></p>   
        <h2 class="gal "><a href="#">갤러리</a></h2>
            <ul class="gallery ">
            <%
			if(count4 > 0){//DB에 글이 존재 한다면
				for(int i = 0; i<list3.size(); i++){
					GalleryBean bean = list3.get(i);
			%>
				<li class="galimg" onclick="location.href='gallery/content.jsp?num=<%=bean.getNum()%>&pageNum=<%=pageNum%>'"><img src="photoUpload/<%=bean.getFilename() %>"></li>
			<%		
				}
			}
			%> 
            </ul>
    </section>
    <section class="con2">
        <h2 class="txt ">배너</h2>
        <ul class="banner">
            <li><img src="images/banner/corona.jpg" alt="corona"></li>
        </ul>
    </section>

	<section class="con3">
        <p class="more"><a href="Download.jsp">더 보기</a></p>
        <h2 class="on"><a href="#">자료실</a></h2>
        	<ul class="down">
	            <%
				if(count4 > 0){//DB에 글이 존재 한다면
					for(int i = 0; i<list4.size(); i++){
						DownloadBean bean = list4.get(i);
				%>
					<li><a href="download/content.jsp?num=<%=bean.getNum()%>&pageNum=<%=pageNum%>"><%=bean.getSubject() %><span class="day"><%=sdf.format(bean.getDate())%></span></a></li>
				<%		
					}
				}
				%> 
            </ul>
    </section>
    <section class="con4">
        <h2 class="txt ">문의하기</h2>
        <ul class="inquire">
        	<li id="inq1">
        	<a href="" onclick="sample6_execDaumPostcode()">
        	<img src="images/inquire/address.png"
        	onmouseover="this.src='images/inquire/address1.png'"
        	onmouseout="this.src='images/inquire/address.png'"></a>
        	</li>
        	<li id="inq2">
        	<a href="Question.jsp"><img src="images/inquire/email.png"
        	onmouseover="this.src='images/inquire/email1.png'"
        	onmouseout="this.src='images/inquire/email.png'"></a>
        	</li>
        	<li id="inq3">
        	<a href="Question2.jsp"><img src="images/inquire/mail.png"
        	onmouseover="this.src='images/inquire/mail1.png'"
        	onmouseout="this.src='images/inquire/mail.png'"></a>
        	</li>
        	<li id="inq4">
        	<a href="" onclick="window.open('chat/chat.jsp', '실시간 채팅', 'width=500px, height=500px')">
        	<img src="images/inquire/chat.png"
        	onmouseover="this.src='images/inquire/chat1.png'"
        	onmouseout="this.src='images/inquire/chat.png'"></a>
        	</li>
        </ul>
    </section>
</div>
<div class="clear"></div>

<div class="service">
        <table>
            <tr>
                <td>
                    <div class="icon_content">
                        <div class="icons">
                            <div><img src="images/icon/icon1.png" alt="no"></div>
                            <h3>인터넷 정보공개</h3>
                            <div class="icons_body">
                                <a href="#">정보공개 이용안내</a><br>
                                <a href="#">정보공개 청구</a><br>
                                <a href="#">정책실명제</a><br>
                                <a href="#">관련법령</a>
                            </div>
                        </div>
                    </div>
                </td>
                <td>
                    <div class="icon_content">
                        <div class="icons">
                            <div><img src="images/icon/icon2.png" alt="no"></div>
                            <h3>구정 운영</h3>
                            <div class="icons_body">
                                <a href="#">2020년 달라지는 제도/시책</a><br>
                                <a href="#">연간행사안내</a><br>
                                <a href="#">주요업무 자체평가</a><br>
                                <a href="#">구정 업무계획</a>
                            </div>
                        </div>
                    </div>
                </td>
                <td>
                    <div class="icon_content">
                        <div class="icons">
                            <div><img src="images/icon/icon3.png" alt="no"></div>
                            <h3>코로나 예방 및 대응</h3>
                            <div class="icons_body">
                                
                                <a href="https://terms.naver.com/entry.nhn?docId=5916213&cid=66630&categoryId=66630">신종 코로나 예방 수칙</a><br>
                                <a href="https://terms.naver.com/entry.nhn?docId=3658229&cid=59325&categoryId=59576">면역력 키우는 방법</a><br>
                                <a href="https://www.idolbom.go.kr/front/main/main.do">아이돌봄 서비스 센터</a><br>
                                <a href="https://corona-live.com/">일일 감염자 확인</a>
                                
                            </div>
                        </div>
                    </div>
                </td>
            </tr>
        </table>
    </div>
<div class="clear"></div>

<hr>
    <div class="travel">
        <h2>송정동 여행관광지</h2>
        <div class="travel_img">
            <figure class="snip1200">
              <img src="images/travel/jukdo.jpg" alt="jukdo" />
              <figcaption>
                <p>죽도공원<br>설명페이지입니다.</p>
                <div class="heading">
                  <h2><span>죽도공원</span></h2>
                </div>
              </figcaption>
              <a href="#"></a>
            </figure>
            <figure class="snip1200">
              <img src="images/travel/station.jpg" alt="jukdo" />
              <figcaption>
                <p>송정역<br>설명페이지입니다.</p>
                <div class="heading">
                  <h2><span>송정역</span></h2>
                </div>
              </figcaption>
              <a href="#"></a>
            </figure>
            <figure class="snip1200">
              <img src="images/travel/sounjung.jpg" alt="jukdo" />
              <figcaption>
                <p>송정바닷가<br>설명페이지입니다.</p>
                <div class="heading">
                  <h2><span>송정바닷가</span></h2>
                </div>
              </figcaption>
              <a href="#"></a>
            </figure>
            <figure class="snip1200">
              <img src="images/travel/wildwave.jpg" alt="jukdo" />
              <figcaption>
                <p>WildWave<br>설명페이지입니다.</p>
                <div class="heading">
                  <h2><span>WildWave</span></h2>
                </div>
              </figcaption>
              <a href="#"></a>
            </figure>
        </div>
    </div>


<footer>
    <div class="flogo">
        <a href="index.jsp"><img src="logo/LOGO.jpg" alt=""></a>
    </div>
    <div class="fcopy">
        <div class="fc1">
        	<ul>
	            <li><a href="#">법적고지</a></li>
	            <li><a href="#">개인정보처리방침</a></li>
	            <li><a href="#">개인정보취급방침</a></li>
            </ul>
        </div>
        <div class="fc2">
            <p>copyright:가나다라마바사아자차카타파하</p>
        </div>
        
    </div>
    <div class="fsns">
            <a href="https://ko-kr.facebook.com/"><img src="images/footer/facebook.png" alt=""></a>
            <a href="https://twitter.com/?lang=ko"><img src="images/footer/twitter.png" alt=""></a>
            <a href="https://www.youtube.com/"><img src="images/footer/youtube.png" alt=""></a>
	</div>
</footer>
</body>
</html>