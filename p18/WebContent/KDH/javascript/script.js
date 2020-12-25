// Java Script Document

jQuery(document).ready(function(){
    $(".nav>li").mouseover(function(){
        $(this).children(".submenu").stop().slideDown();
    });
    $(".nav>li").mouseleave(function(){
        $(this).children(".submenu").stop().slideUp();
    });
    
    start();
})

var imgs = 2;
var now = 0;

function start(){
    $(".imgs>img").eq(0).siblings().hide();
    setInterval(function(){hide();},4000);
};
function hide(){
    now = now==imgs?0:now+=1;
    $(".imgs>img").eq(now-1).fadeOut(2000);
    $(".imgs>img").eq(now).fadeIn(2000);
};



$(".con1 h2").click(function(){
    $(".con1 h2").removeClass("on");
    $(this).addClass("on");
    $(".con1 ul").removeClass("on");
    $(this).next("ul").addClass("on");
    $(".con1 p").removeClass("on");
    $(this).prev("p").addClass("on");
    return false;
});

