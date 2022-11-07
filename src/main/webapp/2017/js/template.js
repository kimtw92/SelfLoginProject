

jQuery(function(){
$.fn.bnnrRolling = function( _options ){
	return this.each(function(i, n){
		var options = $.extend({}, {
				lists :".list li .thum",
				anchors : ".anchor",
				btnL : ".left", btnR : ".right",
				
				btnStop : ".stop",
				btnAuto : ".auto",
				
				speed : 3000,
				auto : false
			}, _options)

			, $wrap = $(this)
			, $anchors = $wrap.find( options.anchors )
			, $btnL = $wrap.find( options.btnL )
			, $btnR = $wrap.find( options.btnR )
			, $btnStop = $wrap.find( options.btnStop )
			, $btnAuto = $wrap.find( options.btnAuto )
			, $lists = $wrap.find( options.lists )
		
			, active = 0
			, timer
			, auto = ( options.auto ) ? true : false
			, pause = false
			, speed = options.speed;
			
		// event
		$anchors.each(function(i){
			$(this).bind("focus mouseover", function(){
				wrapMouseEnter();
				activeMenu(i);
				return false;
			});
		});

		$btnL.bind("click", btnLClick );
		$btnR.bind("click", btnRClick);
		
		$btnStop.bind("click", btnStopClick );
		$btnAuto.bind("click", btnAutoClick );
		
		// initialize
		$lists.hide();
		show(active);
		
		if( auto ){
			$wrap.bind("mouseenter focusin", wrapMouseEnter );
			$wrap.bind("mouseleave focusout", wrapMouseLeave );
			timerStart();
		}
		
		// function
		function btnLClick(){
			activeMenu("left");
			return false;
		}
		
		function btnRClick(){
			activeMenu("right");
			return false;
		}
		
		function btnStopClick(){ pause = true; }
		function btnAutoClick(){ pause = false;  }
		
		function activeMenu(n){
			if( active === n ) return;
			
			hide( active );

			 if( n == "left" ){			
				active--;
				if( active < 0 ) active = $lists.length - 1;
				
			}else if( n == "right" ){
				active++;
				if( active == $lists.length ) active = 0;
				
			}else if( typeof n === "number" ){
				active = n;
			}
			
			show( active );
		}
		
		// 배너 보이기/감추기 2014.07.11 show함수 수정
		function show( num ){
			$anchors.eq( num ).parent().addClass("current");
			$lists.eq( num ).show();
			
			if( options.shown ){
				options.shown($lists.eq(num));
			}
		}
		
		function hide( num ){
			$lists.eq( num ).hide();
			$anchors.eq( num ).parent().removeClass("current");
		}

		// 자동롤링관련함수
		function timerStart(){
			clearInterval( timer );
			timer = setInterval(function(){
				if( ! pause ) btnRClick();
			}, speed);
		}		
		function wrapMouseEnter(){
			clearInterval( timer );
		}
		function wrapMouseLeave(){
			timerStart();
		}
		
	});
}
});

