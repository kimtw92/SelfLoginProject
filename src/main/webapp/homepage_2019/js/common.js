//<![CDATA[

$(document).ready(function(){
	// LNB 키보드이동 및 마우스 오버 이벤트
	$(".depth1_list").mouseover(function(){
		$(this).find(".depth2_box").show();
	});
	$(".depth1_list").mouseout(function(){
		$(this).find(".depth2_box").hide();
	});
	$(".depth1").focusin(function(){
		$(".depth2_box").hide();
		$(this).parent().find(".depth2_box").show();
	});
	$(".depth2_box").find(".depth2").last().focusout(function(){
		$(".depth2_box").hide();
	});
	$("html").click(function(){
		$(".depth2_box").hide();
	});

	// quick 키보드이동 및 마우스 오버 이벤트
	$(".quick_box li a").focusin(function(){
		$(this).parent(".quick_box li").css("background","#eeeeee");
	});
	$(".quick_box li a").focusout(function(){
		$(this).parent(".quick_box li").css("background","inherit");
	});

	// bxslider visual
    $('#visual').bxSlider({
		mode:'horizontal',		// 방식:fade, horizontal, vertical
		speed:500,				// 바뀌는데 걸리는 시간
		auto:true,				// 이미지 자동 회전 true, false
		autoControls:true,		// 시작 중지 버튼 보임
		controls:false,			// 이전 다음 버튼 노출 여부
		pager:true,				// 동그라미(불릿)페이지 바로가기 버튼 보임
		captions:false,			// title="타이틀이 보여짐"
		hideControlOnEnd:true,	// 이동 방향에 슬라이드 없을때 화살표 숨기기
		autoHover:false,		// 슬라이드에 마우스 호버시 애니메이션 정지 여부
		moveSlides:1,			// 이동하는 이미지 갯수
		minSlides:1,			// 화면에 보여지는 이미지 최소 갯수
		maxSlides:1,			// 화면에 보여지는 이미지 최대 갯수
		slideWidth:1200,		// 이미지 width
		slideMargin:10,			// 이미지 margin-right
    });

	// TAB 키보드이동 및 마우스 오버 이벤트
	$(".tab_title").click(function(){
		$(".tab_content_box").hide();
		$(this).parent().find(".tab_content_box").show();
		$(".tab_more").hide();
		$(this).parent().find(".tab_more").show();
		$(".tab_title_on").removeClass("tab_title_on");
		$(this).addClass("tab_title_on");
	});
	$(".tab_title").focusin(function(){
		$(".tab_content_box").hide();
		$(this).parent().find(".tab_content_box").show();
		$(".tab_title_on").removeClass("tab_title_on");
		$(this).addClass("tab_title_on");
	});

	// year 키보드이동 및 마우스 오버 이벤트
	$(".month_title").click(function(){
		$(".month_scroll_area").hide();
		$(".month_title").removeClass("month_title_on");
		$(this).parent().find(".month_scroll_area").show();
	});
	$(".month_title").focusin(function(){
		$(".month_scroll_area").hide();
		$(this).parent().find(".month_scroll_area").show();
		$(".month_title").removeClass("month_title_on");
		$(this).addClass("month_title_on");
	});

	// menu_link 키보드이동 및 마우스 오버 이벤트
	$(".menu_quick span").focusin(function(){
		$(this).css("background","#dddddd");
	});
	$(".menu_quick span").focusout(function(){
		$(this).css("background","inherit");
	});
});
//]]>