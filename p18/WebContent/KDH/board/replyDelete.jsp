<%@page import="board.BoardReplyDAO"%>
<%@page import="board.BoardReplyDTO"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8" trimDirectiveWhitespaces="true"%>
<%
	request.setCharacterEncoding("utf-8");
	
	String rno = request.getParameter("rno");
	String pw = request.getParameter("pw");
	
	BoardReplyDTO dto = new BoardReplyDTO();
	
	dto.setRno(Integer.parseInt(rno));
	dto.setPw(pw);
	
	BoardReplyDAO dao = new BoardReplyDAO();
	int result = dao.delete(dto); 
	
	if(result != 0) out.print("댓글 삭제가 완료되었습니다.");
	else out.print("비밀번호를 확인해주세요.");
%>   