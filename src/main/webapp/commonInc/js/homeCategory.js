// 프론트용 카테고리 페이지 

var stmnLEFT =  950;			// 스크롤메뉴의 좌측 위치
var stmnGAP1 = 0;				// 페이지 헤더부분의 여백 (이보다 위로는 올라가지 않음)
var stmnGAP2 = 0; 				// 스크롤시 브라우저 상단과 약간 띄움. 필요없으면 0으로 세팅
var stmnBASE = 200; 			// 스크롤메뉴 초기 시작위치 (아무렇게나 해도 상관은 없지만 stmnGAP1과 약간 차이를 주는게 보기 좋음)
var stmnActivateSpeed = 150; 	// 움직임을 감지하는 속도 (숫자가 클수록 늦게 알아차림)
var stmnScrollSpeed = 8; 		// 스크롤되는 속도 (클수록 늦게 움직임)
var stmnTimer;

// 우측 quick menu
function RefreshStaticMenu(){

	var stmnStartPoint, stmnEndPoint, stmnRefreshTimer;

	stmnStartPoint = parseInt($("divQuickMenu").style.top, 10);
	stmnEndPoint = document.documentElement.scrollTop + stmnGAP2;
	if (stmnEndPoint < stmnGAP1){
		stmnEndPoint = stmnGAP1;
	}

	stmnRefreshTimer = stmnActivateSpeed;

	if ( stmnStartPoint != stmnEndPoint ) {
		stmnScrollAmount = Math.ceil( Math.abs( stmnEndPoint - stmnStartPoint ) / 15 );
		$("divQuickMenu").style.top = parseInt($("divQuickMenu").style.top, 10) + ( ( stmnEndPoint<stmnStartPoint ) ? -stmnScrollAmount : stmnScrollAmount );
		stmnRefreshTimer = stmnScrollSpeed;
	}

	stmnTimer = setTimeout ("RefreshStaticMenu();", stmnRefreshTimer);
}

function InitializeStaticMenu(){
	$("divQuickMenu").style.top = document.documentElement.scrollTop + stmnBASE;                        
	RefreshStaticMenu();
	//$("divQuickMenu").style.left = stmnLEFT;
}



// 권한변경시 인덱스
function fnHomeUrl(authValue){
	var url = "/";
	
	if(authValue == "8"){
		url = "/homepage/index.do?mode=homepage";
	}else{
		url = "/index/sysAdminIndex.do?mode=sysAdmin";
	}

	return url;
}

