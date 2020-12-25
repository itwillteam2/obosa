// Java Script Document
$(function(){		
	$("#writebutton").click(function(){
		if($("#passwd").val()==""){
			alert("비밀번호를 입력해주세요.");
			$("#passwd").focus();
			return false;				
		};
		if($("#send").val()==""){
			alert("보내는사람을 입력해주세요.");
			$("#send").focus();
			return false;				
		};
		if($("#subject").val()==""){
			alert("제목을 입력해주세요.");
			$("#subject").focus();
			return false;
		};
		if($("#file").val()==""){
			alert("파일을 등록해주세요.");
			$("#file").focus();
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