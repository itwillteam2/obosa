$(function(){		
	$(".submit2").click(function(){
		if($("#id2").val()==""){
			alert("아이디를 입력해주세요.");
			$("#id2").focus();
			return false;				
		};
		if($("#pw2").val()==""){
			alert("비밀번호를 입력해주세요.");
			$("#pw2").focus();
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

