<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>	


	<div class="clear"></div>
	<div id="CommonFooter">
	<div class="FooterMenu">
		<ul>
			<li class="FooterLink"><a href="#">법적고지</a></li>
			<li class="FooterLink"><a href="#">이용약관</a></li>
			<li class="FooterLink"><a href="#">개인정보처리방침</a></li>
			<li class="FamilySite">
				<select title="패밀리 사이트"
				onchange="if(this.value){window.open(this.value,'_blank');this[0].selected=true;}">
					<option value="">FAMILY SITE</option>
					<option value="#">아이티윌</option>
				</select>
			</li>
			<li class="Facebook"><a
				href="https://www.facebook.com/" target="_blank"
				title="페이스북"><img	src="${contextPath}/Images/Ver1/Common/facebook.png" /></a></li>
			<li class="Instagram"><a
				href="https://www.instagram.com/SangSangMKT/"
				target="_blank" title="인스타그램"><img src="${contextPath}/Images/Ver1/Common/instagram.png" /></a></li>
			<li class="Youtube"><a
				href="https://www.youtube.com/"
				target="_blank" title="유튜브"><img src="${contextPath}/Images/Ver1/Common/youtube.png" /></a></li>
		</ul>
		<div class="clear"></div>
	</div>
	<div class="FooterInfo">
		<ul>
			<li	class="CallCenter"><a href="#"><b class="string">TEAM2 문의전화</b> <b
					class="number">1234-1234</b> 운영시간 09:00 - 18:00, 점심시간 12:30 -
					13:30 <small>*주말 및 공휴일은 1:1 문의/상담을 이용해주세요.</small></a></li>
			<li class="TwoButton"><a href="#">
			<img src="${contextPath}/Images/Ver1/Common/footer_btn1.png" />자주하는 질문</a>
			<a href="#">
			<img src="${contextPath}/Images/Ver1/Common/footer_btn2.png"  />1:1 문의/상담</a></li>
			<li class="Information"><big>(주)TEAM2</big><br />
				부산 아이티윌 2조&nbsp;&nbsp; <br>
				팀원 : 김성훈, 곽서린, 한승원, 김동환, 오소라 <br>
				E-MAIL: team2@naver.com<br><br>
				COPYRIGHT &copy; 가나다라마바사</li>
		</ul>
		<div class="clear"></div>
	</div>
</div>    