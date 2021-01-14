$(function(){		
	$(".submit").click(function(){
		if($("#id2").val()==""){
			alert("아이디를 입력해주세요.");
			$("#id2").focus();
			return false;				
		};
		if($("#title").val()==""){
			alert("제목을 입력해주세요.");
			$("#title").focus();
			return false;
		};
		if($("#pw").val()==""){
			alert("비밀번호를 입력해주세요.");
			$("#pw").focus();
			return false;
		};
		if($("#content").val()==""){
			alert("내용을 입력해주세요.");
			$("#content").focus();
			return false;				
		};	
	});	
	return false;
});

