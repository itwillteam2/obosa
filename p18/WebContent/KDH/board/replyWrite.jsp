<%@page import="board.BoardReplyDAO"%>
<%@page import="board.BoardReplyDTO"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8" trimDirectiveWhitespaces="true"%>
<%
	request.setCharacterEncoding("utf-8");
	
	String no = request.getParameter("no");
	String content = request.getParameter("content");
	String writer = request.getParameter("writer");
	String pw = request.getParameter("pw");
	
	BoardReplyDTO dto = new BoardReplyDTO(); 
	
	dto.setNo(Integer.parseInt(no));
	dto.setContent(content);
	dto.setWriter(writer);
	dto.setPw(pw);
	
	BoardReplyDAO dao = new BoardReplyDAO();
	int result = dao.write(dto);
	
	if(result != 0) out.print("댓글 등록이 완료되었습니다.");
	else out.print("입력한 정보를 확인 후 다시 시도해 주세요.");
%>    