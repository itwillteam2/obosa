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
                    if(data.bname !== '' && /[��|��|��]$/g.test(data.bname)){
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
	//��¥ ���� ������ �����ڰ� ������ �� �ִ� ��ü ����
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
            <li><%=id %>�� ȯ���մϴ�.</li>
            <li><a href="" onclick="window.open('member/modify.jsp', 'ȸ����������', 'width=500, height=500 location=no status=no scrollbars=no left=500 top=100' )">������������</a></li>
            <li><a href="member/logout.jsp">�α׾ƿ�</a></li>
        </ul>
    </div>
    <nav>
        <ul class="nav">
            <li><a href="">����</a>
                <ul class="submenu">
                    <li><a href="Notice.jsp">��������</a></li>
                    <li><a href="Download.jsp">�ڷ��</a></li>
                </ul>
            </li>
            <li><a href="">����</a>
                <ul class="submenu">
                    <li><a href="GuestBook.jsp">����</a></li>
                    <li><a href="PhotoGallery.jsp">����������</a></li>
                    <li><a href="Question.jsp">�����ϱ�</a></li>
                    <li><a href="" onclick="window.open('chat/chat.jsp', '�ǽð� ä��', 'width=500px, height=500px')">�ǽð� ä��</a></li>
                </ul>
            </li>
            <li><a href="">�Ұ�</a>
                <ul class="submenu">
                    <li><a href="SongjungHistory.jsp">������ �Ұ�</a></li>
                    <li><a href="Direction.jsp">ã�ƿ��ô±�</a></li>
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
        <p class="more on"><a href="Notice.jsp">�� ����</a></p>
        <h2 class="on"><a href="#">��������</a></h2>
        <ul class="notice on"> 
	        <%
			if(count > 0){//DB�� ���� ���� �Ѵٸ�
				for(int i = 0; i<list.size(); i++){
					BoardBean bean = list.get(i);
			%>
				<li><a href="board/content.jsp?num=<%=bean.getNum()%>&pageNum=<%=pageNum%>"><%=bean.getSubject() %><span class="day"><%=sdf.format(bean.getDate())%></span></a></li>
			<%		
				}
			}
			%>        
        </ul>
        
        <p class="more"><a href="GuestBook.jsp">�� ����</a></p>
        <h2 class="txt "><a href="#">����</a></h2>
            <ul class="guest ">
            <%
			if(count2 > 0){//DB�� ���� ���� �Ѵٸ�
				for(int i = 0; i<list2.size(); i++){
					GuestBean bean = list2.get(i);
			%>
				<li><a href="guest/content.jsp?num=<%=bean.getNum()%>&pageNum=<%=pageNum%>"><%=bean.getSubject() %><span class="day"><%=sdf.format(bean.getDate())%></span></a></li>
			<%		
				}
			}
			%>        
        </ul>
            
        <p class="more"><a href="PhotoGallery.jsp">�� ����</a></p>   
        <h2 class="gal "><a href="#">������</a></h2>
            <ul class="gallery ">
            <%
			if(count4 > 0){//DB�� ���� ���� �Ѵٸ�
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
        <h2 class="txt ">���</h2>
        <ul class="banner">
            <li><img src="images/banner/corona.jpg" alt="corona"></li>
        </ul>
    </section>

	<section class="con3">
        <p class="more"><a href="Download.jsp">�� ����</a></p>
        <h2 class="on"><a href="#">�ڷ��</a></h2>
        	<ul class="down">
	            <%
				if(count4 > 0){//DB�� ���� ���� �Ѵٸ�
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
        <h2 class="txt ">�����ϱ�</h2>
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
        	<a href="" onclick="window.open('chat/chat.jsp', '�ǽð� ä��', 'width=500px, height=500px')">
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
                            <h3>���ͳ� ��������</h3>
                            <div class="icons_body">
                                <a href="#">�������� �̿�ȳ�</a><br>
                                <a href="#">�������� û��</a><br>
                                <a href="#">��å�Ǹ���</a><br>
                                <a href="#">���ù���</a>
                            </div>
                        </div>
                    </div>
                </td>
                <td>
                    <div class="icon_content">
                        <div class="icons">
                            <div><img src="images/icon/icon2.png" alt="no"></div>
                            <h3>���� �</h3>
                            <div class="icons_body">
                                <a href="#">2020�� �޶����� ����/��å</a><br>
                                <a href="#">�������ȳ�</a><br>
                                <a href="#">�ֿ���� ��ü��</a><br>
                                <a href="#">���� ������ȹ</a>
                            </div>
                        </div>
                    </div>
                </td>
                <td>
                    <div class="icon_content">
                        <div class="icons">
                            <div><img src="images/icon/icon3.png" alt="no"></div>
                            <h3>�ڷγ� ���� �� ����</h3>
                            <div class="icons_body">
                                
                                <a href="https://terms.naver.com/entry.nhn?docId=5916213&cid=66630&categoryId=66630">���� �ڷγ� ���� ��Ģ</a><br>
                                <a href="https://terms.naver.com/entry.nhn?docId=3658229&cid=59325&categoryId=59576">�鿪�� Ű��� ���</a><br>
                                <a href="https://www.idolbom.go.kr/front/main/main.do">���̵��� ���� ����</a><br>
                                <a href="https://corona-live.com/">���� ������ Ȯ��</a>
                                
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
        <h2>������ ���������</h2>
        <div class="travel_img">
            <figure class="snip1200">
              <img src="images/travel/jukdo.jpg" alt="jukdo" />
              <figcaption>
                <p>�׵�����<br>�����������Դϴ�.</p>
                <div class="heading">
                  <h2><span>�׵�����</span></h2>
                </div>
              </figcaption>
              <a href="#"></a>
            </figure>
            <figure class="snip1200">
              <img src="images/travel/station.jpg" alt="jukdo" />
              <figcaption>
                <p>������<br>�����������Դϴ�.</p>
                <div class="heading">
                  <h2><span>������</span></h2>
                </div>
              </figcaption>
              <a href="#"></a>
            </figure>
            <figure class="snip1200">
              <img src="images/travel/sounjung.jpg" alt="jukdo" />
              <figcaption>
                <p>�����ٴ尡<br>�����������Դϴ�.</p>
                <div class="heading">
                  <h2><span>�����ٴ尡</span></h2>
                </div>
              </figcaption>
              <a href="#"></a>
            </figure>
            <figure class="snip1200">
              <img src="images/travel/wildwave.jpg" alt="jukdo" />
              <figcaption>
                <p>WildWave<br>�����������Դϴ�.</p>
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
	            <li><a href="#">��������</a></li>
	            <li><a href="#">��������ó����ħ</a></li>
	            <li><a href="#">����������޹�ħ</a></li>
            </ul>
        </div>
        <div class="fc2">
            <p>copyright:�����ٶ󸶹ٻ������īŸ����</p>
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