$(document).ready(function() {
  var placeholderTarget = $('.content input[type="text"]');
  var placeholderTarget2 = $('.content input[type="password"]');
  
  placeholderTarget.on('focus', function(){
    $(this).siblings('#fade1').fadeOut('fast');
  });

  placeholderTarget.on('focusout', function(){
    if($(this).val() == ''){
      $(this).siblings('#fade1').fadeIn('fast');
    }
  });
  
  placeholderTarget2.on('focus', function(){
    $(this).siblings('#fade2').fadeOut('fast');
  });

  placeholderTarget2.on('focusout', function(){
    if($(this).val() == ''){
      $(this).siblings('#fade2').fadeIn('fast');
    }
  });
});
  
$('.tabs .tab').click(function(){
    if ($(this).hasClass('signin')) {
        $('.tabs .tab').removeClass('active');
        $(this).addClass('active');
        $('.cont').hide();
        $('.signin-cont').show();
    } 
    if ($(this).hasClass('signup')) {
        $('.tabs .tab').removeClass('active');
        $(this).addClass('active');
        $('.cont').hide();
        $('.signup-cont').show();
    }
});
$('.lform').click(function(){
    $('.container').fadeToggle();
    $('.signup').removeClass('active');
    $('.signin').addClass('active');
    $('.cont').hide();
    $('.signin-cont').show();
});
$('.close').click(function(){
    $('.container').fadeOut();
});

$('.lform2').click(function(){
    $('.container').fadeToggle();
    $('.signin').removeClass('active');
    $('.signup').addClass('active');
    $('.cont').hide();
    $('.signup-cont').show();
});

$(function(){		
	$(".submit").click(function(){
		if($("#id").val()==""){
			alert("아이디를 입력해주세요.");
			$("#id").focus();
			return false;				
		};
		if($("#pw").val()==""){
			alert("비밀번호를 입력해주세요.");
			$("#pw").focus();
			return false;
		};
	});	
	return false;
});

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
		if($("#name2").val()==""){
			alert("이름을 입력해주세요.");
			$("#name2").focus();
			return false;				
		};
		if($("#address2").val()==""){
			alert("주소를 입력해주세요.");
			$("#address2").focus();
			return false;				
		};
	});	
	return false;
});

