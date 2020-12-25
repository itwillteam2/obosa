<%@page import="board.BoardReplyDAO"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>       
<%
	int no = Integer.parseInt(request.getParameter("num"));
	BoardReplyDAO dao = new BoardReplyDAO();
	
	String id = (String)session.getAttribute("id");
	request.setAttribute("list", dao.list(no));
%>    
<c:forEach items="${list }" var="vo">
	<li class="list-group-item dataRow">
		<div style="border-bottom: 1px solid #ddd ">
			<input type="hidden" class="rno" name="rno" value="${vo.rno}">
			<span class="writer">${vo.writer }</span><span>(${vo.date })</span>
		</div>
		<div><span class="content">${vo.content }</span>
		<c:if test="${vo.writer eq id}">
			<span class="pull-right">
				<button class="replyUpdateBtn btn btn-default btn-xs" style="margin:0;">수정</button>
				<button class="replyDeleteBtn btn btn-default btn-xs" style="margin:0;">삭제</button>
			</span>
		</c:if>
		</div>
	</li>
</c:forEach>