///// ZonnInOut //////////////////////////////////////////////////////////////////////////////	
	var nowZoom = 100; // 현재비율
	var maxZoom = 200; // 최대비율
	var minZoom = 100; // 최소비율(현재와 같아야 함)

	// +, - 키를 입력하면 화면 확대, 축소를 한다.
	document.onkeypress = getKey;

	function getKey(keyStroke) {
		isNetscape = (document.layers);
		eventChooser = (isNetscape) ? keyStroke.which : event.keyCode;
		which = String.fromCharCode(eventChooser).toLowerCase();
		which2 = eventChooser;

		var el = event.srcElement;

		if ((el.tagName != "INPUT") && (el.tagName != "TEXTAREA")) {
			if (which == "+") {
				zoomIn();
			} else if (which == "-") {
				zoomOut();
			}
		}
	}

	function yangZoom() {
		document.body.style.zoom = "100%";
		nowZoom = 100;
	}
	
	
        //화면 키운다.
	function zoomIn() {
		  if (typeof document.body.style.maxHeight != "undefined") {
		      // IE 7, Mozilla, Safari, Opera 9
			  
		  } else {
		      // IE 6, older browsers 
			 // alert('인터넷 익스플로러6 이하 버전에서는 화면 확대가 될 경우  \n퀵 메뉴의 위치가 고정됩니다. \n인터넷 익스플로러7 이상버전에서는 정상작동 합니다. ');
		  }
		if (nowZoom < maxZoom) {
			nowZoom += 25; // 25%씩 커진다.
		} else {
			return;
		}

		document.body.style.zoom = nowZoom + "%";
	}
	
	//화면 줄인다.
	function zoomOut() {
		  if (typeof document.body.style.maxHeight != "undefined") {
		      // IE 7, Mozilla, Safari, Opera 9
			  
		  } else {
		      // IE 6, older browsers 
			  // alert('인터넷 익스플로러6 이하 버전에서는 화면 축소가 될 경우  \n퀵 메뉴의 위치가 고정됩니다. \n인터넷 익스플로러7 이상버전에서는 정상작동 합니다. ');
		  }	
		if (nowZoom > minZoom) {
			nowZoom -= 25; // 25%씩 작아진다.
		} else {
			return;
		}

		document.body.style.zoom = nowZoom + "%";
	}