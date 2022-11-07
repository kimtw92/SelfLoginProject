/**
 * GNB
 * @package	{ixGnb}
 * @version 2013.04.09 (jslee)
*/

if ( ixGnb ) throw new Error('[ixError] "ixGnb"가 이미 존재하여 충돌이 발생!');

// ============================================================== //
// =====================	ixGnb		========================= //
// ============================================================== //

var ixGnb = (function () {
	var GNB_DURATION = 300;
	
	var _$gnb = $( 'div.gnbFrame ul.topNavi:first' ),
		_$depth1_btns = $( 'div.gnbFrame ul.topNavi li a.d1' ),
		_$depth2s = $( 'div.gnbFrame div.depth02' ),
		_$depth1_imgs = _$depth1_btns.find( 'img' );

	var _delay = null,
		_openIndex = -1,
		_isOpening = false,
		_isClosing = false,
		_isCloseBtnClick = false;

	// ===============	Private Methods	=============== //

	function mouseHandler (e) {
		if ( e.type == 'mouseover' || e.type == 'focusin' ) {
			if (!_isCloseBtnClick) over( e.data.parentIndex );
		} else {
			_delay.start();
		}
	}
	
	function timerHandler (e) {
		out( true );
	}
	
	function over ( idx ) {	
		_delay.stop();
		_isClosing = false;

		if ( _openIndex != idx ) out();		

		var depth1Img = _$depth1_imgs[idx],
			imgPath = $( depth1Img ).attr( 'src' );
		$( depth1Img ).attr( 'src', imgPath.replace( '_off.', '_on.' ) );

		var depth2 = _$depth2s[idx];
		$( depth2 ).css( { display: 'block' } );
	
		if ( !_isOpening ) {
			_isOpening = true;
			_$gnb.animate( {height: '280px'}, { queue: false, duration: GNB_DURATION, complete: gnbOpenComplete } );
		}
		
		_openIndex = idx;
	}
	
	function out ( slide ) {
		if ( _openIndex < 0 ) return;
	
		_isClosing = true;

		var depth1Img = _$depth1_imgs[_openIndex],
			imgPath = $( depth1Img ).attr( 'src' );
		$( depth1Img ).attr( 'src', imgPath.replace( '_on.', '_off.' ) );

		
		if ( slide ) {
			_$gnb.animate( {height: '80px'}, { queue: false, duration: GNB_DURATION, complete: gnbCloseComplete } );
		} else {
			gnbCloseComplete();
		}
	}
	
	function gnbOpenComplete () {
		_isOpening = false;

	}
	
	function gnbCloseComplete () {
		if ( !_isClosing ) return;
		$( _$depth2s[_openIndex] ).css( 'display', 'none' );
		_isClosing = false;
		_openIndex = -1;
		if (_isCloseBtnClick) _isCloseBtnClick = false;
	}
	
	function closeBtnClickHandler (e) {
		//console.log ( 'click closebtn', e.data.parentIndex );
		_isCloseBtnClick = true;
		out( true );
		return false;
	}
	// ===============	Public Methods	=============== //
	return {
		//초기세팅
		init: function () {
			var depth1Num = _$depth1_btns.length;
			
			_delay = new ixGnb.Delay( 500, timerHandler );
			
			for ( var i = 0; i < depth1Num; ++i ) {
				var depth2 = _$depth2s[i];
				
				$( depth2 ).on( 'mouseover mouseout', { parentIndex: i }, mouseHandler );
				$( depth2 ).find( 'a' ).on( 'focusin focusout', { parentIndex: i }, mouseHandler );
				$( _$depth1_btns[i] ).on( 'mouseover mouseout focusin focusout', { parentIndex: i }, mouseHandler );				
			}
			$( _$depth2s ).find( 'p.btn' ).on( 'click', { parentIndex: i } , closeBtnClickHandler );	
		}
	}
}());

// =====================	Timer		========================= //

ixGnb.Delay = function ( delay, callback ) {
	var _interval = null,
		_this = this;
	
	// ===============	Private Methods	=============== //
	function handler (e) {
		callback.call( this, {type: 'timer'} );
	}
	
	// ===============	Public Methods	=============== //
	this.start = function () {
		if ( _interval ) _this.stop();
		_interval = setTimeout( handler, delay );
	};
	
	this.stop = function () {
		if ( _interval ) clearTimeout( _interval );
		_interval = null;
	};
};


//실행
ixGnb.init();
