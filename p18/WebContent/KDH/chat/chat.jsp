<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>실시간 채팅</title>
<link rel="stylesheet" href="../bootstrap/css/bootstrap.css">
<link rel="stylesheet" href="../bootstrap/css/custom.css">
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="../bootstrap/js/bootstrap.js"></script>
<script type="text/javascript">
	var lastID = 0;
	function submitFunction(){
		var chatName = $('#chatName').val();
		var chatContent = $('#chatContent').val();
		$.ajax({
			type: "POST",
			async : false,
			url : "./../../chatSubmitServlet", 
			data : {
					chatName : encodeURIComponent(chatName),
					chatContent : encodeURIComponent(chatContent)
			},
			dataType: "text",
			success: function(result){
				if(result == 1){
					autoClosingAlert('#successMessage', 2000);	
				}else if(result == 0){
					autoClosingAlert('#dangerMessage', 2000);
				}else{
					autoClosingAlert('#warningMessage', 2000);
				}
			},
			error : function(request, status, error){
				alert(request.status);
			}
		});
		$('#chatContent').val('');
	}
	function autoClosingAlert(selector, delay){
		var alert = $(selector).alert();
		alert.show();
		window.setTimeout(function(){alert.hide()}, delay);
	}
	
	function chatListFunction(type){
		$.ajax({
			type: "POST",
			url : "./../../chatListServlet", 
			data : {
					listType : type,
			},
			success: function(data){
				if(data == "") return;
				var parsed = JSON.parse(data);
				var result = parsed.result;
				
				for(var i =0; i<result.length; i++){
					addChat(result[i][0].value, result[i][1].value, result[i][2].value);
				}
				lastID = Number(parsed.last);
			}
		});
	};
	function addChat(chatName, chatContent, chatTime){
		$('#chatList').append('<div class="row">' +  
								'<div class="col-lg-12">' + 
								'<div class="media">' + 
								'<div class="media-body">' + 
								'<h4 class="media-heading">' + 
								chatName + 
								'<span class="small pull-right">' + 
								chatTime + 
								'</span>' + 
								'</h4>' + 
								'<p>' + 
								chatContent + 
								'</p>' + 
								'</div>' + 
								'</div>' +
								'</div>' +
								'</div>' +
								'<hr>' );
		$('#chatList').scrollTop($('#chatList')[0].scrollHeight);
	}
	function getInfiniteChat(){
		setInterval(function(){
			chatListFunction(lastID);
		}, 1000);
	}
</script>
<%
	request.setCharacterEncoding("utf-8");
	String id = (String)session.getAttribute("id");
%> 
</head>
<body>
	<div class="container">
		<div class="container bootstrap snippet">
			<div class="row">
				<div class="col-xs-12">
					<div class="portlet portlet-default">
						<div class="portlet-heading">
							<div class="portlet-title">
								<h4>
									<i class="fa fa-circle text-green">실시간 채팅방</i>
								</h4>
							</div>
							<div class="clearfix"></div>
						</div>
						<div id="chat" class="panel-collapse collase in">
							<div id="chatList" class="portlet-body chat-widget"
								style="overflow-y: auto; width: auto; height: 500px;">
								
								
							</div>
							<div class="portlet-footer">
								<div class="row">
									<div class="form-group col-xs-4">
										<input style="height: 40px;" type="text" id="chatName"
											class="form-control" maxlength="8" value="<%=id%>">
									</div>
								</div>
								<div class="row" style="height: 90px">
									<div class="form-group col-xs-10">
										<textarea style="height: 80px;" id="chatContent"class="form-control" placeholder="메시지를 입력하세요" maxlength="100"></textarea>
									</div>
									<div class="form-group col-xs-2">
										<button type="button" class="btn btn-default pull-right"
											onclick="submitFunction()">전송</button>
										<div class="clearfix"></div>
									</div>
								</div>

							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="alert alert-success" id="successMessage"
			style="display: none;">
			<strong>메시지 전송에 성공하였습니다.</strong>
		</div>
		<div class="alert alert-danger" id="dangerMessage"
			style="display: none;">
			<strong>이름과 내용을 모두 입력해주세요</strong>
		</div>
		<div class="alert alert-warning" id="warningMessage"
			style="display: none;">
			<strong>데이터베이스 오류가 발생했습니다.</strong>
		</div>
	</div>
	<script type="text/javascript">
		$(document).ready(function(){
			chatListFunction('ten');
			getInfiniteChat();
		});
	</script>
</body>
</html>