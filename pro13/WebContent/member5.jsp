
<%@page import="java.util.List"%>
<%@page import="sec01.ex01.MemberDAO"%>
<%@page import="sec01.ex01.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		//request객체 영역에 인코딩 방식 UTF-8로 설정
		request.setCharacterEncoding("UTF-8");
	%>
	
	<%--
		<jsp:setProperty>액션태그에 param속성을 다음과 같이 생략하고
		property속성 값만 지정 하되...
		회원가입창(memberForm.html)의 <input>태그의 name속성값과...
		<jsp:setProperty>태그의  property 속성값이 일치 하면? 
		자동으로 MemberBean객체의 각 객체변수에 입력한 정보들을 자동으로 저장해 준다.
	 --%>
	
	 <jsp:useBean  id="m"  class="sec01.ex01.MemberBean" scope="page"  />
	
	 <jsp:setProperty  name="m"  property="id"  />
	 <jsp:setProperty  name="m"  property="name" />
	 <jsp:setProperty  name="m"  property="pwd"  />
	 <jsp:setProperty  name="m"   property="email" />
	 

	<%	
		//입력한 회원데이터들을 DB에 전송하여 INSERT작업하기 위해 MembmerDAO객체 생성시 
		//기본생성자를 호출해 커넥션풀 얻기
		MemberDAO memberDAO = new MemberDAO();
		
		//입력한 회원데이터들을 DB의 t_member테이블에 INSERT하기 위해 addMember메소드 호출시
		//MemberBean객체를 매개변수로 전달 하여 작업 합니다.
		memberDAO.addMember(m); 
		
		//DB의 테이블에 저장되어 있는 전체 회원정보를 조회하기 위해 MemberDAO의  listMembers()메소드 호출!
		//반환값으로 조회한 회원정보들을 받자
		List membersList = memberDAO.listMembers(); 
		
		out.print(membersList.size());
	
	%>

	<table align="center" width="100%">
		<tr align="center" bgcolor="#99ccff">
			<td width="7%">아이디</td>
			<td width="7%">비밀번호</td>
			<td width="5%">이름</td>
			<td width="11%">이메일</td>
			<td width="5%">가입일</td>
		</tr>
	<%
	//DB에 조회한 회원정보가 없으면?
	if(membersList.size() == 0){
	%>
		<tr>
			<td colspan="5">
				<b>등록된 회원이 없습니다.</b>
			</td>
		</tr>
	<%
	}else{//DB에서 조회한 회원이 있으면?
		//for반복문을 이용해 ArrayList배열에 저장된 MemberBean객체를 하나씩 가져온후..
		//MemberBean객체의 각변수에 저장된  조회한 회원정보들을 getter메소드를 호출해서 얻은후 출력!
		for(int i=0;  i<membersList.size(); i++){
			
			MemberBean bean = (MemberBean)membersList.get(i);
	%>	
		<tr align="center">
			<td><%=bean.getId() %></td>
			<td><%=bean.getPwd() %></td>
			<td><%=bean.getName() %></td>
			<td><%=bean.getEmail() %></td>
			<td><%=bean.getJoinDate() %></td>
		</tr>	
		
	<%		
		}//for끝
	}//else끝
	%>
		<tr height="1" bgcolor="#99ccff">
			<td colspan="5"></td>
		</tr>
	</table>



</body>
</html>







