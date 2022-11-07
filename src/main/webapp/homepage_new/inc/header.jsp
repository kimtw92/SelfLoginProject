<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/1999/REC-html401-19991224/loose.dtd">
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>인천광역시 인재개발원</title>
<link  type="text/css" href="/homepage_new/css/sub.css" rel="stylesheet" charset="euc-kr">
<link rel="STYLESHEET" type="text/css" href="/homepage_new/css/common.css" />
<link rel="stylesheet" type="text/css" href="/homepage_new/css/content.css" />
<script type="text/javascript" language="javascript" src="/homepage_new/js/navigation.js"></script>
<script type="text/javascript" src="/lib/js/script.js"></script>
<script type="text/javascript" language="javascript" src="/commonInc/js/commonJs.js"></script>
<script type="text/javascript" language="javascript" src="/commonInc/js/prototype-1.6.0.2.js"></script>


<script language = "javascript">
//권한 셀렉트 박스 변경
function fnSelectAuth(){
	
	var pauth = $F("cboAuth");
	var url = "/commonInc/ajax/currentAuthSet.do?mode=auth";
	var pars = "cauth=" + pauth;
	
	var myAjax = new Ajax.Request(
			url, 
			{
				method: "get", 
				parameters: pars, 
				onComplete: fnAuthComplete
			}
		);
}
function fnAuthComplete(originalRequest){

	var cboAuthValue = $F("cboAuth");
	var url = "";
	
	url = fnHomeUrl(cboAuthValue);

	url +="&cboAuth="+$F("cboAuth");
	location.href = url;
}
function initMoving(target, position, topLimit, btmLimit) {
	 if (!target)
	  return false;

	 var obj = target;
	 obj.initTop = position;
	 obj.topLimit = topLimit;
	 obj.bottomLimit = document.documentElement.scrollHeight - btmLimit;
	 obj.style.position = "relative";             
	 obj.top = obj.initTop;
	 obj.left = obj.initLeft;
	 if (typeof(window.pageYOffset) == "number") {
	  obj.getTop = function() {
	   return window.pageYOffset;
	  }
	 } else if (typeof(document.documentElement.scrollTop) == "number") {
	  obj.getTop = function() {
	   return document.documentElement.scrollTop;
	  }
	 } else {
	  obj.getTop = function() {
	   return 0;
	  }
	 }

	 if (self.innerHeight) {
	  obj.getHeight = function() {
	   return self.innerHeight;
	  }
	 } else if(document.documentElement.clientHeight) {
	  obj.getHeight = function() {
	   return document.documentElement.clientHeight;
	  }
	 } else {
	  obj.getHeight = function() {
	   return 500;
	  }
	 }

	 obj.move = setInterval(function() {
	  if (obj.initTop > 0) {
	   pos = obj.getTop() + obj.initTop;
	  } else {
	   pos = obj.getTop() + obj.getHeight() + obj.initTop;
	   //pos = obj.getTop() + obj.getHeight() / 2 - 15;
	  }

	  if (pos > obj.bottomLimit)
	   pos = obj.bottomLimit;
	  if (pos < obj.topLimit)
	   pos = obj.topLimit;

	  interval = obj.top - pos;
	  obj.top = obj.top - interval / 3;
	  obj.style.top = obj.top + "px";
	 }, 30)                        //
	}



document.observe("dom:loaded", function() {
	var html = "<div id='quick_menu'>";
	html += "            <p><img src='/homepage_new/images/common/quick_title.gif' alt='메뉴 바로가기'></p>";
	html += "            <ul>";
	//html += "                <li><a href=\"javascript:popWin('/homepage/studyhelp/learning_guide01.html','ddd','820','515','no','no')\"><img src='/homepage_new/images/common/quick_menu1.gif' alt='학습도우미'></a></li>";
	html += "                <li><a href='/homepage/infomation.do?mode=eduinfo2-3'><img src='/homepage_new/images/common/quick_menu2.gif' alt='연간교육일정'></a></li>";
	html += "                <li><a href='/homepage/support.do?mode=faqList'><img src='/homepage_new/images/common/quick_menu3.gif' alt=''자주하는질문></a></li>";
	//html += "                <li><a href=\"javascript:popWin('http://152.99.42.151/','ccc','658','540','yes','yes')\"><img src='/homepage_new/images/common/quick_menu4.gif' alt='pc 원격지원'></a></li>";
	//html += "                <li><a href=\"javascript:popWin('http://152.99.42.151:81/','ccc','658','540','yes','yes')\"><img src='/homepage_new/images/common/quick_menu4.gif' alt='pc 원격지원'></a></li>";
	html += "                <li><a href='/homepage/introduce.do?mode=eduinfo7-7'><img src='/homepage_new/images/common/quick_menu5.gif' alt='찾아오시는길'></a></li>";
	html += "                <li><a href='javascript:move_cyber();'><img src='/images/common/quick_menu6.gif' alt='인천시민사이버교육센터'></a></li>";
	//html += "                <li><a href=\"https://cad.logodi.go.kr/dc/diagnosis/member/index.do\" target=\"_blank\"><img src=\"../images/common/quick_menu7.gif\" alt=\"역량 시스템\"></a></li>";
	html += "            </ul>";
	html += "            <p><a href='#'><img src='/homepage_new/images/common/quick_bt.gif' alt='페이지 상단으로 이동'></a></p>";
	html += "        </div>";
	$("subContainer").insert(html);
	initMoving(document.getElementById("quick_menu"), 1, 1
			, 1);
});

function move_cyber() {
	
	open ("http://www.cyber.incheon.kr","NewWindow3",
	"left=0, top=0, toolbar=yes, location=yes, directories=no, status=yes, menubar=yes, scrollbars=yes, resizable=yes, width=1024, height=768");
}

function popupEduInfo(){	

		window.open("/homepage/index.do?mode=eduInfo","eduInfo","scrollbars=no,resizable=no,width=710,height=600").focus();
	
}
	



function fnGoMenu(menuNum,htmlId){
	//location.href = "/homepage/html.do?mode=ht&htmlId=" + htmlId;
	if(menuNum == '1') {
		location.href = "/mypage/myclass.do?mode=" + htmlId;	
	} else if(menuNum == '2') {
		location.href = "/homepage/infomation.do?mode=" + htmlId;
	}else if(menuNum == '3') {
		location.href = "/homepage/course.do?mode=" + htmlId;
	}else if(menuNum == '4') {
		//location.href = "/homepage/attend.do?mode=" + htmlId;
		
		if (htmlId == 'cyber') {
			location.href = "/statisMgr/stats.do?mode=cyber";
		} else if (htmlId == 'departBest') {
			location.href = "/statisMgr/stats.do?mode=departBest";
		} else if (htmlId == 'ageBest') {
			location.href = "/statisMgr/stats.do?mode=ageBest";	
		} else if (htmlId == 'genderBest') {
			location.href = "/statisMgr/stats.do?mode=genderBest";
		} else if (htmlId == 'tierBest') {
			location.href = "/statisMgr/stats.do?mode=tierBest";			
		} else if (htmlId == 'languageBest') {
			location.href = "/statisMgr/stats.do?mode=language";
		} else if (htmlId == 'yearof2015') {
			location.href = "/statisMgr/stats.do?mode=2015";
		} else if (htmlId == 'yearof2016') {
			location.href = "/statisMgr/stats.do?mode=2016";
		} else if (htmlId == 'tierBest') {
			location.href = "/statisMgr/stats.do?mode=tierBest";
		} else {
			location.href = "/homepage/attend.do?mode=" + htmlId;
		}
		
		
	}else if(menuNum == '5') {
		location.href = "/homepage/support.do?mode=" + htmlId;
	}else if(menuNum == '6') {
		location.href = "/homepage/ebook.do?mode=" + htmlId;
	}else if(menuNum == '7') {
		location.href = "/homepage/introduce.do?mode=" + htmlId;
	}else if(menuNum == '8') {
		location.href = "/mypage/paper.do?mode=" + htmlId;
	}else if(menuNum == '9') {
		location.href = "/homepage/index.do?mode=" + htmlId;
	}else if(menuNum == '10') {
		location.href = "/homepage/join.do?mode=" + htmlId;
	}	
}
</script>


<script type="text/javascript" language="javascript" src="/commonInc/js/zoominout.js"></script>
<style type="text/css">
#header{
margin-top: 10px;
}
#TopMenu{
margin-top: 5px;
}
</style>
</head>


<body>

  <!-- header-->
   
  <div id="header">  	
       
    <div class="toparea">
      <h1><a href="/">인천광역시 인재개발원</a></h1>
      <div id="menu">
        <dl>
			<dd>
				<a href="http://www.facebook.com/cyberincheon" target="_blank" class="link_area1"><img src="/images/fc.gif" border="0" width="23" height="23"/></a>
				</dd>
				<dd class="link_area">
				<!-- a href="https://twitter.com/cyberincheon" target="_blank"  class="link_area2"><img src="/images/tw.gif" border="0" width="23" height="23"/></a -->
				</dd>
				<dd>
				<a href="#" class="link_area3">
				<iframe src="http://www.facebook.com/plugins/like.php?href=http%3A%2F%2Fwww.facebook.com%2Fcyberincheon&send=false&layout=button_count&width=180&show_faces=false&action=like&colorscheme=light&font=arial&height=21" scrolling="no" frameborder="0" style="border:none; overflow:hidden; width:190px; height:21px;" allowTransparency="true"></iframe>
				</a>
				</dd> 
				<dd>
				<!-- a href="https://twitter.com/share" class="twitter-share-button link_area4" data-url="https://twitter.com/cyberincheon" data-via="cyberincheon" data-lang="ko">트윗하기</a>
				<script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0];if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src="http://platform.twitter.com/widgets.js";fjs.parentNode.insertBefore(js,fjs);}}(document,"script","twitter-wjs");</script -->
			</dd> 

			<dd><a href="javascript:yangZoom()" class="font_basic">기본</a></dd>
			<dd><a href="javascript:zoomIn()" class="font_up">글자크게</a></dd>
			<dd><a href="javascript:zoomOut()" class="font_down">글자작게</a></dd>
			<dd><a href="/homepage/index.do?mode=sitemap" class="sitemap">sitemap</a></dd>
			<dd><a href="/foreign/english/index.html" class="english">English</a></dd>
			<dd><a href="http://www.cyber.incheon.kr/" target="_blank" class="cyberedu">시민 사이버교육</a></dd>
		</dl>
       </div>

		<div id="TopMenu">
					<div id="TopMenuSub">
						<ul>
							<li class="menu1" style="width:90px;">
								<a href="javascript:fnGoMenu(1,'main');"><img id = "menu1Btn" src="/homepage_new/images/main/menua_off.jpg" alt="마이페이지" /></a>
								<div class="TopSubMenu">					
									<ul>
										<li class="first"><a href="javascript:fnGoMenu('1','main');" >나의강의실</a></li>
                            			<li><a href="javascript:fnGoMenu('1','attendList');" >교육신청 및 취소</a></li>
                            			<li><a href="javascript:fnGoMenu('1','completionList');" >수료내역</a></li>
                            			<li><a href="javascript:fnGoMenu('1','myquestion');" >개인정보</a></li>
                            			<li><a href="javascript:fnGoMenu('1','memberout');" >회원탈퇴</a></li>
									</ul>
								</div>
							</li>
							<li class="menu2" style="width:100px;">
								<a href="javascript:fnGoMenu(2,'eduinfo2-1');"><img src="/homepage_new/images/main/menub_off.jpg" alt="교육과정" /></a>
								<div class="TopSubMenu">					
									<ul>
										<li class="first"><a href="javascript:fnGoMenu(2,'eduinfo2-1');" >입교안내</a></li>
                            			<li><a href="javascript:fnGoMenu(2,'eduinfo2-2');" >교육훈련체계</a></li>
                            			<li><a href="javascript:fnGoMenu(2,'eduinfo2-3');" >연간교육일정</a></li>
                            			<li><a href="javascript:fnGoMenu(3,'eduinfo3-1');" >집합교육</a></li>
                            			<li><a href="javascript:fnGoMenu(3,'eduinfo3-4');" >e-러닝</a></li>
                            			<!-- li><a href="javascript:fnGoMenu(5,'opencourse');" >공개강의</a></li -->
									</ul>
								</div>
							</li>
							<li class="menu3" style="width:100px;">
								<a href="javascript:fnGoMenu(4,'attendList');"><img src="/homepage_new/images/main/menuc_off.jpg" alt="교육신청" /></a>
								<div class="TopSubMenu">
									<ul>
												<li class="first"><a href="javascript:fnGoMenu(4,'attendList');">집합교육 신청 및 취소</a></li>
												<li class="first0"><a href="javascript:popupEduInfo();">e-러닝(외국어)</a></li>
												<li class="first1"><a href="http://incheon.nhi.go.kr/">e-러닝(전문)</a></li>
												
									</ul>
								</div>
							</li>
							<li class="menu4" style="width:100px;">
								<a href="javascript:fnGoMenu(5,'uploadbbsList')"><img src="/homepage_new/images/main/menud_off.jpg" alt="참여공간" /></a>
								<div class="TopSubMenu">
									<ul>
										<li class="first"><a href="javascript:fnGoMenu('5','uploadbbsList');">신임인재평가</a></li>
										<li class="first"><a href="javascript:fnGoMenu(5,'requestList');">묻고답하기</a></li>
										<!-- <li><a href="javascript:fnGoMenu(5,'webzine');">포토갤러리-</a></li> -->
										<li class="first"><a href="javascript:fnGoMenu('5','epilogueList');">수강후기</a></li>
										<!--<li><a href="javascript:fnGoMenu(6,'eduinfo6-1');">E-book</a></li> -->
									</ul>
								</div>
							</li>
							<li class="menu5" style="width:100px;">
								<a href="/homepage/renewal.do?mode=eduinfo8-1"><img src="/homepage_new/images/main/menue_off.jpg" alt="교육지원" /></a>
								<div class="TopSubMenu">
									<ul>
										<li class="first"><a href="/homepage/renewal.do?mode=eduinfo8-1"" >분야별교육안내</a></li>
                            			<li><a href="javascript:fnGoMenu(5,'faqList');" >자주하는질문</a></li>
                            			<li><a href="javascript:fnGoMenu(5,'educationDataList');" >자료실</a></li>
                            			<li><a href="/homepage/renewal.do?mode=eduinfotel" >과정별 안내전화</a></li>
                            			<!-- <li><a href="http://152.99.42.138/" target = "_blank" >e-도서관--</a></li> -->
                            			<li><a href="/homepage/renewal.do?mode=readingList" >교육생숙지사항</a></li>
                            			<li><a href="/homepage/renewal.do?mode=courseTimetable" >과정시간표</a></li>
                            			<li><a href="javascript:fnGoMenu(7,'eduinfo7-4');" >식단표</a></li>
									</ul>
								</div>
							</li>
							<li class="menu6">
								<a href="javascript:fnGoMenu('7','eduinfo7-1');"><img src="/homepage_new/images/main/menuf_off.jpg" alt="인재개발원 소개" /></a>
								<div class="TopSubMenu">
									<ul>
										<li class="first"><a href="javascript:fnGoMenu('7','eduinfo7-1');" >인사말</a></li>
                            			<li><a href="/homepage/renewal.do?mode=introduction02" >비전 및 목표</a></li>
                            			<!-- li><a href="javascript:fnGoMenu('7','eduinfo7-8');" >안내동영상</a></li -->
                            			<li><a href="javascript:fnGoMenu('7','eduinfo7-2');" >연혁</a></li>
                            			<li><a href="javascript:fnGoMenu('7','eduinfo7-3');" >조직 및 업무</a></li>
                            			<li><a href="javascript:fnGoMenu('5','noticeList');" >인재개발원 알림</a></li>
                            			<li><a href="javascript:fnGoMenu('7','lawsList');" >법률/조례</a></li>
                            			<li><a href="javascript:fnGoMenu('7','eduinfo7-6');" >시설현황</a></li>
                            			<!-- <li><a href="javascript:fnGoMenu('7','eduinfo7-7');" >찾아오시는길</a></li> -->
									</ul>
								</div>
							</li>
							<li class="menu7">
								<a href="javascript:fnGoMenu('5','epilogueList');"><img src="/homepage_new/images/main/menug_off.jpg" alt="수강후기" /></a>
							</li>
						</ul>
					</div>
			</div>

    </div>
  </div>
  
  <script language = "javascript">
  var TopMenu1 = new fnTopMenu1_Type1;
	TopMenu1.DivName = "TopMenuSub";
	TopMenu1.fnName = "TopMenu1";
	TopMenu1.DefaultMenu = 0;
	TopMenu1.DefaultSubMenu = 0;
	TopMenu1.MenuLength = 7;
	TopMenu1.Start();
  </script>
    