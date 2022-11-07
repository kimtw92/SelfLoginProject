<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="/commonInc/include/comInclude.jsp" %>
<%
	String topMenu = request.getParameter("topMenu");
	
%>
<link rel="STYLESHEET" type="text/css" href="/share/css/sub.css" />
<script type="text/javascript" src="/share/js/common.js"></script>
<div id="topheader">
	<div class="topheader">
	
		<div class="toparea">
			<h6><a href="/">인천광역시 인재개발원</a></h6>
			<div id="menu">
			<dl>
				<dd><a href="/homepage/index.do?mode=sitemap" class="sitemap">sitemap</a></dd>
				<dd><a href="/foreign/english/index.html" class="english">English</a></dd>
				<dd><a href="http://www.cyber.incheon.kr/" target="_blank" class="cyberedu">시민 사이버교육</a></dd>
			</dl>
			<ul class="gnb" id="cssmenu1">
				<li class="menu1"><a href="javascript:fnGoMenu(1,'main');" id="menu1_" onmouseover="openSub('sub1');" onfocus="openSub('sub1');">마이페이지</a></li>
					<ul id="sub1">
					</ul>
				<li class="menu2"><a href="javascript:fnGoMenu(2,'eduinfo2-1');" id="menu2_" onmouseover="openSub('sub2');" onfocus="openSub('sub2');">교육안내</a>
					<ul id="sub2">
						<li><a href="javascript:fnGoMenu(2,'eduinfo2-1');" id="sub2_1">입교안내</a></li>
						<li><a href="javascript:fnGoMenu(2,'eduinfo2-2');" id="sub2_2">교육훈련체계</a></li>
						<li><a href="javascript:fnGoMenu(2,'eduinfo2-4');" id="sub2_3">교육현황</a></li>
					</ul>
				</li>
				<li class="menu3"><a href="javascript:fnGoMenu(2,'eduinfo2-3');" id="menu3_" onmouseover="openSub('sub3');" onfocus="openSub('sub3');">교육과정</a>
					<ul id="sub3">
						<li><a href="javascript:fnGoMenu(2,'eduinfo2-3');" id="sub3_1">연간교육일정</a></li>
						<li><a href="javascript:fnGoMenu(3,'eduinfo3-1');" id="sub3_2">기본교육</a></li>
						<li><a href="javascript:fnGoMenu(3,'eduinfo3-3');" id="sub3_3">전문교육</a></li>
						<li><a href="javascript:fnGoMenu(3,'eduinfo3-2');" id="sub3_4">기타교육</a></li>
					</ul>
				</li>
				<li class="menu4"><a href="javascript:fnGoMenu(4,'attendList');" id="menu4_" onmouseover="openSub('sub4');" onfocus="openSub('sub4');">수강신청</a>
					<ul id="sub4">
						<li><a href="javascript:fnGoMenu(4,'attendList');" id="sub4_1">수강신청</a></li>
						<!-- li><a href="javascript:fnGoMenu(5,'opencourse');" id="sub4_2">공개강의</a></li -->
					</ul>
				</li>
				<li class="menu5"><a href="javascript:fnGoMenu('5','faqList');" id="menu5_" onmouseover="openSub('sub5');" onfocus="openSub('sub5');">학습지원</a>
					<ul id="sub5">
						<li><a href="javascript:fnGoMenu(5,'faqList');" id="sub5_1">열린광장</a></li>
						<li><a href="javascript:fnGoMenu(5,'educationDataList');" id="sub5_2">자료실</a></li>
						<li><a href="javascript:fnGoMenu(5,'webzine');" id="sub5_3">포토갤러리</a></li>
						<li><a href="http://152.99.42.138/" target="_blank"  id="sub5_4">e-도서관</a></li>
					</ul>
				</li>
				<li class="menu6"><a href="javascript:fnGoMenu(6,'eduinfo6-1');" id="menu6_" onmouseover="openSub('sub6');" onfocus="openSub('sub6');">e-book</a></li>
					<ul id="sub6">
					</ul>
				<li class="menu7"><a href="javascript:fnGoMenu('7','eduinfo7-1');" id="menu7_" onmouseover="openSub('sub7');" onfocus="openSub('sub7');">인재개발원 소개</a>
					<ul id="sub7">
						<li><a href="javascript:fnGoMenu('7','eduinfo7-1');" id="sub7_1">인사말</a></li>
						<!-- li><a href="javascript:fnGoMenu('7','eduinfo7-8');" id="sub7_8">안내동영상</a></li -->
						<li><a href="javascript:fnGoMenu('7','eduinfo7-2');" id="sub7_2">일반현황</a></li>
						<li><a href="javascript:fnGoMenu('7','eduinfo7-3');" id="sub7_3">조직 및 업무</a></li>
						<li><a href="javascript:fnGoMenu('7','lawsList');" id="sub7_4">법률/조례</a></li>
						<li><a href="javascript:fnGoMenu('7','eduinfo7-6');" id="sub7_5">시설현황</a></li>
						<li><a href="javascript:fnGoMenu('7','eduinfo7-4');" id="sub7_6">식단표</a></li>
						<li><a href="javascript:fnGoMenu('7','eduinfo7-7');" id="sub7_7">찾아오시는 길</a></li>
					</ul>
				</li>
			</ul>
			</div>
		</div>
		
	</div>
</div>
<script language="JavaScript" type="text/JavaScript">
<!--

function fnGoMenu(menuNum,htmlId){
	//location.href = "/homepage/html.do?mode=ht&htmlId=" + htmlId;
	if(menuNum == '1') {
		location.href = "/mypage/myclass.do?mode=" + htmlId;	
	} else if(menuNum == '2') {
		location.href = "/homepage/infomation.do?mode=" + htmlId;
	}else if(menuNum == '3') {
		location.href = "/homepage/course.do?mode=" + htmlId;
	}else if(menuNum == '4') {
		location.href = "/homepage/attend.do?mode=" + htmlId;
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



//-->
</script>