<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/1999/REC-html401-19991224/loose.dtd">
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>인천광역시 인재개발원</title>
<link  type="text/css" href="/homepage_new/css/sub.css" rel="stylesheet" charset="euc-kr">
<link rel="STYLESHEET" type="text/css" href="/homepage_new/css/common.css" />
<link rel="stylesheet" type="text/css" href="/homepage_new/css/content.css" />
<script type="text/javascript" language="javascript" src="/homepage_new/js/header.js"></script>
<script type="text/javascript" src="/lib/js/script.js"></script>
<script type="text/javascript" language="javascript" src="/commonInc/js/commonJs.js"></script>

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
	html += "                <li><a href=\"javascript:popWin('/homepage/studyhelp/learning_guide01.html','ddd','820','515','no','no')\"><img src='/homepage_new/images/common/quick_menu1.gif' alt=''></a></li>";
	html += "                <li><a href='/homepage/infomation.do?mode=eduinfo2-3'><img src='/homepage_new/images/common/quick_menu2.gif' alt=''></a></li>";
	html += "                <li><a href='/homepage/support.do?mode=faqList'><img src='/homepage_new/images/common/quick_menu3.gif' alt=''></a></li>";
	html += "                <li><a href=\"javascript:popWin('http://152.99.42.151:81/','ccc','658','540','yes','yes')\"><img src='/homepage_new/images/common/quick_menu4.gif' alt=''></a></li>";
	html += "                <li><a href='/homepage/introduce.do?mode=eduinfo7-7'><img src='/homepage_new/images/common/quick_menu5.gif' alt=''></a></li>";
	html += "            </ul>";
	html += "            <p><a href='#'><img src='/homepage_new/images/common/quick_bt.gif' alt='페이지 상단으로 이동'></a></p>";
	html += "        </div>";
	$("subContainer").insert(html);
	initMoving(document.getElementById("quick_menu"), 1, 1, 1);
});

</script>
<script type="text/javascript" language="javascript" src="/commonInc/js/zoominout.js"></script>
</head>

<body>
  <!-- header-->
   
  <div id="header">
    
    	
       
    <div class="toparea">
      <h1><a href="/">인천광역시 인재개발원</a></h1>
      <div id="menu">
    
        <dl>
          			<dd><a href="javascript:yangZoom()" class="font_basic">기본</a></dd>
                    <dd><a href="javascript:zoomIn()" class="font_up">글자크게</a></dd>
                    <dd><a href="javascript:zoomOut()" class="font_down">글자작게</a></dd>
                    <dd><a href="/homepage/index.do?mode=sitemap" class="sitemap">sitemap</a></dd>
                    <dd><a href="/foreign/english/index.html" class="english">English</a></dd>
                    <dd><a href="http://www.cyber.incheon.kr/" target="_blank" class="cyberedu">시민 사이버교육</a></dd>
                </dl>
    
                <ul class="gnb" id="cssmenu1">
                  <li class="menu0_"><a href="#" id="menu0_" >마이페이지</a></li>
                    <li class="menu1"><a href="javascript:fnGoMenu(1,'main');" id="menu1_" onMouseOver="openSub('sub1');" onFocus="openSub('sub1');">마이페이지</a></li>
                        <ul id="sub1">
                  </ul>
                    <li class="menu2"><a href="javascript:fnGoMenu(2,'eduinfo2-1');" id="menu2_" onMouseOver="openSub('sub2');" onFocus="openSub('sub2');">교육과정</a>
                      <ul id="sub2" onMouseOut=" outSub()"onmouseover="openSub('sub2');">
                        	<li><a href="javascript:fnGoMenu(2,'eduinfo2-1');" id="sub2_1">입교안내</a></li>
                            <li><a href="javascript:fnGoMenu(2,'eduinfo2-2');" id="sub2_2">교육훈련체계</a></li>
                            <li><a href="javascript:fnGoMenu(2,'eduinfo2-3');" id="sub2_3">연간교육일정</a></li>
                            <li><a href="javascript:fnGoMenu(3,'eduinfo3-1');" id="sub2_4">집합교육</a></li>
                            <li><a href="javascript:fnGoMenu(3,'eduinfo3-4');" id="sub2_5">사이버교육</a></li>
                            <li><a href="javascript:fnGoMenu(5,'opencourse');" id="sub2_6">공개강의</a></li>
                        </ul>
                    </li>
                    <li class="menu3"><a href="javascript:fnGoMenu(4,'attendList');" id="menu3_" onMouseOver="openSub('sub3');" onFocus="openSub('sub3');">교육신청</a>
                      <ul id="sub3" onMouseOut=" outSub()"onmouseover="openSub('sub3');">
                        <li><a href="javascript:fnGoMenu(4,'attendList');" id="sub3_1">교육신청 및 취소</a></li>
                        </ul>
                    </li>
                    <li class="menu4"><a href="javascript:fnGoMenu(5,'requestList');" id="menu4_" onMouseOver="openSub('sub4');" onFocus="openSub('sub4');">참여공간</a>
                      <ul id="sub4" onMouseOut=" outSub()"onmouseover="openSub('sub4');">
                        	<li><a href="javascript:fnGoMenu(5,'requestList');" id="sub4_1">묻고답하기</a></li>
                            <li><a href="javascript:fnGoMenu(5,'webzine');" id="sub4_2">포토갤러리</a></li>
                            <li><a href="javascript:fnGoMenu(6,'eduinfo6-1');" id="sub4_3">E-book</a></li>
                        </ul>
                    </li>
                    <li class="menu5"><a href="/homepage/renewal.do?mode=eduinfo8-1" id="menu5_" onMouseOver="openSub('sub5');" onFocus="openSub('sub5');">교육지원</a>
                      <ul id="sub5" onMouseOut=" outSub()"onmouseover="openSub('sub5');">
                        	<li><a href="/homepage/renewal.do?mode=eduinfo8-1"" id="sub5_1">분야별교육안내</a></li>
                            <li><a href="javascript:fnGoMenu(5,'faqList');" id="sub5_2">자주하는질문</a></li>
                            <li><a href="javascript:fnGoMenu(5,'educationDataList');" id="sub5_3">자료실</a></li>
                            <li><a href="/homepage/renewal.do?mode=eduinfotel" id="sub5_4">과정별 안내전화</a></li>
                            <li><a href="http://152.99.42.138/" target = "_blank" id="sub5_5">e-도서관</a></li>
                            <li><a href="/homepage/renewal.do?mode=readingList" id="sub5_6">교육생숙지사항</a></li>
                            <li><a href="/homepage/renewal.do?mode=courseTimetable" id="sub5_7">과정시간표</a></li>
                            <li><a href="javascript:fnGoMenu(7,'eduinfo7-4');" id="sub5_8">식단표</a></li>
                        </ul>
                    </li>
                    <li class="menu6"><a href="javascript:fnGoMenu('7','eduinfo7-1');" id="menu6_" onMouseOver="openSub('sub6');" onFocus="openSub('sub6');">인재개발원 소개</a>
                      <ul id="sub6" onMouseOut=" outSub()"onmouseover="openSub('sub6');">
                        	<li><a href="javascript:fnGoMenu('7','eduinfo7-1');" id="sub6_1">인사말</a></li>
                            <li><a href="/homepage/renewal.do?mode=introduction02" id="sub6_2">비전 및 목표</a></li>
                            <!-- li><a href="javascript:fnGoMenu('7','eduinfo7-8');" id="sub6_3">안내동영상</a></li -->
                            <li><a href="javascript:fnGoMenu('7','eduinfo7-2');" id="sub6_4">일반현황</a></li>
                            <li><a href="javascript:fnGoMenu('7','eduinfo7-3');" id="sub6_5">조직 및 업무</a></li>
                            <li><a href="javascript:fnGoMenu('5','noticeList');" id="sub6_6">인재개발원 알림</a></li>
                            <li><a href="javascript:fnGoMenu('7','lawsList');" id="sub6_7">법률/조례</a></li>
                            <li><a href="javascript:fnGoMenu('7','eduinfo7-6');" id="sub6_8">시설현황</a></li>
                        </ul>
                    </li>
                </ul>
            </div>
        </div>
    </div>
    