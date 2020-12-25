<%@page import="board.BoardDAO"%>
<%@page import="board.BoardBean"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%
    BoardBean bBean = new BoardBean();
	request.setCharacterEncoding("utf-8");
	
	String id = (String)session.getAttribute("id");

	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	
	BoardDAO dao = new BoardDAO();
	
	dao.updateReadCount(num); 
	
	BoardBean boardBean = dao.getBoard(num);
	
	int DBnum = boardBean.getNum();
	int DBReadcount = boardBean.getReadcount();
	String DBName = boardBean.getName();
	Timestamp DBDate = boardBean.getDate();
	String DBSubject = boardBean.getSubject();
	String DBContent = "";
	
	if(boardBean.getContent() != null){
		DBContent = boardBean.getContent().replace("<br>", "\r\n");
	}

	int DBRe_ref = boardBean.getRe_ref();
	int DBRe_lev = boardBean.getRe_lev();
	int DBRe_seq = boardBean.getRe_seq();
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");
	
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Content</title>
    <link rel="stylesheet" href="../css/style.css">
    <link rel="stylesheet" href="../css/notice.css">
    <link rel="stylesheet" href="../css/write.css">
    <script src="../javascript/jquery-1.12.3.js"></script>
    <script src="../javascript/script.js" defer="defer"></script>
    <script src="../javascript/write.js" defer="defer"></script>
    <link rel="stylesheet" href="../bootstrap/css/bootstrap.css">
	<link rel="stylesheet" href="../bootstrap/css/custom.css">
	<script src="../bootstrap/js/bootstrap.js"></script>
	<script type="text/javascript">
		$(function(){
			$("#replyList").load("replyList.jsp?num=" + <%=DBnum%>); 
			
			$("#replyWriteBtn").click(function(){
				update("write");
			});	
			$("#replyUpdateBtn").click(function(){
				update("update");
			});
			
			function update(action){
				var no = $("#no").val();
				var rno = $("#rno").val();
				var content = $("#content2").val();
				var writer = $("#writer").val();
				var pw= $("#pw").val();
				
				var reply = {
						//no : no,
						content : content,
						writer : writer,
						pw : pw
				}
				var url = ""
				if(action=="write"){
					reply.no = no;
					url = "replyWrite.jsp";
				}else {reply.rno = rno;
						url = "replyUpdate.jsp";
					}
					$.ajax({
					type : "post",
					url : url,
					data : reply,
					dataType : "text",
					contentType : "application/x-www-form-urlencoded; charset=utf-8",
					success : function(result, status, xhr){
						/* if(action== "write")
						alert("성공적으로 댓글이 등록되었습니다.");
						else
						alert("성공적으로 댓글이 수정되었습니다"); */
						alert(result);
						$("#replyList").load("replyList.jsp?num=" + <%=DBnum%>); 
			
					},
					error : function(xhr, status, error){
						if(action== "write")
						alert("댓글이 등록하는 중 오류가 발생되었습니다.");
						else
						alert("댓글이 수정하는 중 오류가 발생되었습니다.");
					}
				});
			
				clear();
				$("#replyModal").modal("hide");			
			}
			
			$("#replyResetBtn").click(function(){
				clear();
			});
			
			function clear(){
				$("#content2").val("");
				$("#pw").val("");
			}
			
			$("#replyList").on("click", ".replyUpdateBtn", function(){
				var item = $(this).closest(".dataRow");
				var rno = item.find(".rno").val();
				var content = item.find(".content").text();
				var writer = item.find(".writer").text();
				
				$("#rno").val(rno);
				$("#writer").val(writer);
				$("#content2").val(content);
				$("#replyWriteBtn").hide();
				$("#replyUpdateBtn").show();
				
				$("#pw").attr("type", "password");
				$("#pw").val("");
				$("#replyModal").modal("show");
				
			});
			$("#replyList").on("click", ".replyDeleteBtn", function(){
				var item = $(this).closest(".dataRow");
				var rno = item.find(".rno").val();
				$("#deleteRno").val(rno);
				$("#deletePw").val("");
				$("#replyDeleteModal").modal("show");
			});
			
			
			$("#addReplyBtn").click(function(){
				$("#pw").attr("type", "text");
				$("#pw").val("");
				$("#content2").val("");
				$("#replyWriteBtn").show();
				$("#replyUpdateBtn").hide();
			});
			
			$("#replyDeleteBtn").click(function(){
				var reply = {
						rno : $("#deleteRno").val(),
						pw : $("#deletePw").val()
				}
				
				$.ajax({
					type : "post",
					url : "replyDelete.jsp",
					data : reply,
					dataType : "text",
					success : function(result, status, xhr){
						alert(result);
					},
					error : function(xhr, status, error){
						alert("댓글 삭제 오류");
					}					
				});
				$("#replyDeleteModal").modal("hide");
				$("#replyList").load("replyList.jsp?num=" + <%=DBnum%>);
			});
			
		});
	</script>
</head>
<body>

<jsp:include page="../inc/top2.jsp"/>
	<div class="img">
		<img alt="공지" src="../images/notice/notice.jpg"> 
	</div>
	<div class="content">
		<div class="menu">
			<nav>
				<ul class="submenu2">
					<li><a href="../Notice.jsp">공지사항</a></li>
					<li><a href="../GuestBook.jsp">방명록</a></li>
					<li><a href="../PhotoGallery.jsp">갤러리</a></li>
					<li><a href="../Download.jsp">자료실</a></li>
				</ul>
			</nav>
		</div>
		<div class="main">
			<h2>공지사항</h2>
			<form class="form2" method="post">
				<table class="table">
					<tr class="name">
						<td>
							<label for="name">글번호</label>
							<input type="text" name="name" id="name" value="<%=DBnum %>" readonly />					
						</td>
					</tr>
					<tr class="name">
						<td>
							<label for="name">아이디</label>
							<input type="text" name="name" id="name" value="<%=DBName %>" readonly />					
						</td>
					</tr>
					<tr class="name">
						<td>
							<label for="name">작성일</label>
							<input type="text" name="name" id="name" value="<%=sdf.format(DBDate) %>" readonly />					
						</td>
					</tr>
					<tr class="name">
						<td>
							<label for="name">글제목</label>
							<input type="text" name="name" id="name" value="<%=DBSubject %>" readonly />					
						</td>
					</tr>
					<tr class="content">
						<td><textarea name="content" id="content" class="textarea"><%=DBContent %></textarea><td>
					</tr>
				</table>
				</form>
				
				<div class="panel panel-default">
					<div class="panel-heading">댓글
						<span class="pull-right">
							<button class="btn btn-primary btn-xs" id="addReplyBtn" data-toggle="modal" data-target="#replyModal" style="margin-top : 0;">쓰기</button>
						</span>
					</div>
					<div class="panel-body">
						<ul class="list-group" id="replyList">
							<li class="list-group-item">데이터를 불러오는 중입니다.</li>
						</ul>
					</div>
				</div>

				<!-- Modal -->
				<div class="modal fade" id="replyModal" role="dialog">
					<div class="modal-dialog">

						<!-- Modal content-->
						<div class="modal-content">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal">&times;</button>
								<h3 class="modal-title">댓글 작성</h3>
							</div>
							<div class="modal-body">
								<form id="replyWriteForm">
									<input type="hidden" id="no" name="no" value="<%=DBnum%>">
									<input type="hidden" id="rno" name="rno">
									<div class="form-group">
										<label for="writer">작성자</label>
										<input type="text" class="form-control" id="writer" name="writer" value="<%=id%>" readonly required>
									</div>
									<div class="form-group">
										<label for="pw">비밀번호</label>
										<input type="text" class="form-control" id="pw" name="pw" required>
									</div>
									<div class="form-group">
										<label for="content">내용</label>
										<textarea rows="3" class="form-control" id="content2" name="content" required></textarea>
									</div>
								</form>
							</div>
							<div class="modal-footer">
								<div class="btn-group">
								<button class="btn btn-default" id="replyWriteBtn">쓰기</button>
								<button class="btn btn-default" id="replyUpdateBtn">수정</button>
								<button type="reset" class="btn btn-default" id="replyResetBtn">다시쓰기</button>
								<button type="button" class="btn btn-default"
									data-dismiss="modal">취소</button>
									</div>
							</div>
						</div>

					</div>
				</div>
				
				<!-- Modal -->
				<div class="modal fade" id="replyDeleteModal" role="dialog">
					<div class="modal-dialog">

						<!-- Modal content-->
						<div class="modal-content">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal">&times;</button>
								<h3 class="modal-title">댓글 삭제</h3>
							</div>
							<div class="modal-body">
								<form id="replyWriteForm">
									<input type="hidden" id="deleteRno" name="rno">
									<div class="form-group">
										<label for="deletePw">비밀번호</label>
										<input type="password" class="form-control" id="deletePw" name="pw" required>
									</div>
								</form>
							</div>
							<div class="modal-footer">
								<div class="btn-group">
								<button class="btn btn-default" id="replyDeleteBtn">삭제</button>
								<button type="button" class="btn btn-default"
									data-dismiss="modal">취소</button>
							</div>
							</div>
						</div>

					</div>
				</div>
				
				<%
					if(DBName.equals(id)){
				%>		
						<input type="button" value="글삭제" class="button" id="button" onclick="location.href='delete.jsp?num=<%=DBnum %>&pageNum=<%=pageNum %>'">
						<input type="button" value="글수정" class="button" id="writebutton" onclick="location.href='update.jsp?num=<%=DBnum %>&pageNum=<%=pageNum %>'">		
				<%
					}
				%>	
				
									
					<input type="button" value="답글쓰기" class="button" id="button" onclick="location.href='reWrite.jsp?num=<%=DBnum %>&re_ref=<%=DBRe_ref %>&re_lev=<%=DBRe_lev %>&re_seq=<%=DBRe_seq %>'">
					<input type="button" value="목록으로" class="button" id="button" onclick="location.href='../Notice.jsp?pageNum=<%=pageNum%>'">
				</div>
			</form>
			<div class="clear"></div>
		</div>
	</div>
<div class="clear"></div>	


<jsp:include page="../inc/bottom2.jsp"/>
</body>
</html>