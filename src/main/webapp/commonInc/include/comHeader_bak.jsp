<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="/commonInc/include/comInclude.jsp" %>
<%
	String topMenu = request.getParameter("topMenu");

	
%>

	<div id="header">
		<!-- webmail sitemap english chinese -->
	    <div class="sMenu">
	        <a href="http://mail.inpia.net" target="_blank"><img src="/images/<%= skinDir %>/menu/top-sMu01.gif" alt="WEBMAIL" /></a>
	        <img src="/images/<%= skinDir %>/menu/topSline.gif" class="sLine" alt="" />
	        <a href="/homepage/index.do?mode=sitemap"><img src="/images/<%= skinDir %>/menu/top-sMu02.gif" alt="사이트맵" /></a>
	        <img src="/images/<%= skinDir %>/menu/topSline.gif" class="sLine" alt="" />
	        <a href="/foreign/english/index.html"><img src="/images/<%= skinDir %>/menu/top-sMu03.gif" alt="English" /></a>
			<img src="/images/<%= skinDir %>/menu/topSline.gif" class="sLine" alt="" />
	        <!-- <a href="/foreign/china/index.html"><img src="/images/<%= skinDir %>/menu/top-sMu04.gif" alt="Chinese" /></a>-->
	    </div>
		<!-- //webmail sitemap english chinese -->
		<div class="h6"></div>
	
		<!--GnbMenu-->
		<div class="topLogo"><a href="/"><img src="/images/<%= skinDir %>/menu/topLogo.gif" alt="지방공무원교육원" /></a></div>
		<div class="gTopMenu">
			<ul id="gtopmenu">
			
				<!-- Gmenu01 -->
		        <li class="top1Menu"><a href="javascript:fnGoMenu(1,'main');" title="마이페이지" onFocus="top2menuView(1);" onMouseOver="top2menuView(1);"><img id="topmainimg1" src="/images/<%= skinDir %>/menu/topMu_1depth01.gif" alt="마이페이지" /></a>
		        </li>
		        <!-- //Gmenu01 -->			

				<!-- Gmenu02 -->
				<li class="top1Menu"><a href="javascript:fnGoMenu(2,'eduinfo2-1');" title="교육안내" onFocus="top2menuView(2);" onMouseOver="top2menuView(2);"><img id="topmainimg2" src="/images/<%= skinDir %>/menu/topMu_1depth02.gif" alt="교육안내" /></a>
					<ul id="top2m2" onMouseOver="top2menuView(2);">
						<li><a href="javascript:fnGoMenu(2,'eduinfo2-1');" class="topsubmenu" title="입교안내"><img src="/images/<%= skinDir %>/menu/topMu_2depth201.gif" alt="입교안내" /></a></li>
						<li><a href="javascript:fnGoMenu(2,'eduinfo2-2');" class="topsubmenu" title="교육훈련체계"><img src="/images/<%= skinDir %>/menu/topMu_2depth202.gif" alt="교육훈련체계" /></a></li>
						<li><a href="javascript:fnGoMenu(2,'eduinfo2-4');" class="topsubmenu" title="교육현황"><img src="/images/<%= skinDir %>/menu/topMu_2depth203.gif" alt="교육현황" /></a></li>
					</ul>
				</li>
				<!-- //Gmenu02 -->
		
				<!-- Gmenu03 -->
				<li class="top1Menu"><a href="javascript:fnGoMenu(2,'eduinfo2-3');" title="교육과정" onFocus="top2menuView(3);" onMouseOver="top2menuView(3);"><img id="topmainimg3" src="/images/<%= skinDir %>/menu/topMu_1depth03.gif" alt="교육과정" /></a>
					<ul id="top2m3" onMouseOver="top2menuView(3);">
						<li><a href="javascript:fnGoMenu(2,'eduinfo2-3');" class="topsubmenu" title="연간교육일정"><img src="/images/<%= skinDir %>/menu/topMu_2depth306.gif" alt="연간교육일정" /></a></li>

						<li><a href="javascript:fnGoMenu(3,'eduinfo3-1');" class="topsubmenu" title="기본교육"><img src="/images/<%= skinDir %>/menu/topMu_2depth301.gif" alt="기본교육" /></a></li>
				
						<li><a href="javascript:fnGoMenu(3,'eduinfo3-3');" class="topsubmenu" title="전문교육"><img src="/images/<%= skinDir %>/menu/topMu_2depth303.gif" alt="전문교육" /></a></li>
				
						<li><a href="javascript:fnGoMenu(3,'eduinfo3-2');" class="topsubmenu" title="기타교육"><img src="/images/<%= skinDir %>/menu/topMu_2depth305.gif" alt="기타교육" /></a></li>
					</ul>
				</li>
				<!-- //Gmenu03 -->
		
				<!-- Gmenu04 -->
				<li class="top1Menu"> <a href="javascript:fnGoMenu(4,'attendList');" title="수강신청" onFocus="top2menuView(4);" onMouseOver="top2menuView(4);"><img id="topmainimg4" src="/images/<%= skinDir %>/menu/topMu_1depth04.gif" alt="수강신청" /></a>
					<ul id="top2m4" onMouseOver="top2menuView(4);">						
						<li><a href="javascript:fnGoMenu(4,'attendList');" class="topsubmenu" title="수강신청"><img src="/images/<%= skinDir %>/menu/topMu_4depth101.gif" alt="수강신청" /></a></li>
						<li><a href="javascript:fnGoMenu(5,'opencourse');" class="topsubmenu" title="공개강의"><img src="/images/<%= skinDir %>/menu/topMu_4depth102.gif" alt="공개강의" /></a></li>
					</ul>
				</li>
				<!-- //Gmenu04 -->
		
				<!-- Gmenu05 -->
				<li class="top1Menu"><a href="javascript:fnGoMenu('5','faqList');" title="학습지원" onFocus="top2menuView(5);" onMouseOver="top2menuView(5);"><img id="topmainimg5" src="/images/<%= skinDir %>/menu/topMu_1depth05.gif" alt="학습지원" /></a>
					<ul id="top2m5" onMouseOver="top2menuView(5);">
						<li><a href="javascript:fnGoMenu(5,'faqList');" class="topsubmenu" title="열린광장"><img src="/images/<%= skinDir %>/menu/topMu_2depth501.gif" alt="열린광장" /></a></li>
						<li><a href="javascript:fnGoMenu(5,'educationDataList');" class="topsubmenu" title="자료실"><img src="/images/<%= skinDir %>/menu/topMu_2depth502.gif" alt="자료실" /></a></li>
						<li><a href="javascript:fnGoMenu(5,'webzine');" class="topsubmenu" title="웹진"><img src="/images/<%= skinDir %>/menu/topMu_2depth503.gif" alt="웹진" /></a></li>
						<li><a href="http://152.99.42.138/" target="_blank" class="topsubmenu" title="e-도서관"><img src="/images/<%= skinDir %>/menu/topMu_2depth507.gif" alt="e-도서관" /></a></li>
					</ul>
				</li>
				<!-- //Gmenu05 -->
		
				<!-- Gmenu06 -->
				<li class="top1Menu"><a href="javascript:fnGoMenu(6,'eduinfo6-1');" title="e-Book" onFocus="top2menuView(6);" onMouseOver="top2menuView(6);"><img id="topmainimg6" src="/images/<%= skinDir %>/menu/topMu_1depth06.gif" alt="e-Book" /></a>
				</li>
				<!-- //Gmenu06 -->
		
				<!-- Gmenu07 -->
				<li class="top1Menu"><a href="javascript:fnGoMenu('7','eduinfo7-1');" title="교육원소개" onFocus="top2menuView(7);" onMouseOver="top2menuView(7);"><img id="topmainimg7" src="/images/<%= skinDir %>/menu/topMu_1depth07.gif" alt="교육원소개" /></a>
					<ul id="top2m7" onMouseOver="top2menuView(7);">
						<li><a href="javascript:fnGoMenu('7','eduinfo7-1');" class="topsubmenu" title="인사말"><img src="/images/<%= skinDir %>/menu/topMu_2depth701.gif" alt="인사말" /></a></li>
						<li><a href="javascript:fnGoMenu('7','eduinfo7-2');" class="topsubmenu" title="일반현황"><img src="/images/<%= skinDir %>/menu/topMu_2depth702.gif" alt="일반현황" /></a></li>
						<li><a href="javascript:fnGoMenu('7','eduinfo7-3');" class="topsubmenu" title="조직및업무"><img src="/images/<%= skinDir %>/menu/topMu_2depth703.gif" alt="조직및업무" /></a></li>
						<li><a href="javascript:fnGoMenu('7','lawsList');" class="topsubmenu" title="법률/조례"><img src="/images/<%= skinDir %>/menu/topMu_2depth705.gif" alt="법률/조례" /></a></li>
						<li><a href="javascript:fnGoMenu('7','eduinfo7-6');" class="topsubmenu" title="시설현황"><img src="/images/<%= skinDir %>/menu/topMu_2depth706.gif" alt="시설현황" /></a></li>
						<li><a href="javascript:fnGoMenu('7','eduinfo7-4');" class="topsubmenu" title="식단표"><img src="/images/<%= skinDir %>/menu/topMu_2depth704.gif" alt="식단표" /></a></li>
						<li><a href="javascript:fnGoMenu('7','eduinfo7-7');" class="topsubmenu" title="찾아오시는길"><img src="/images/<%= skinDir %>/menu/topMu_2depth707.gif" alt="찾아오시는길" /></a></li>
					</ul>
				</li>
				<!-- //Gmenu07 -->
		
				<!-- Gmenu08 -->
				<li class="top1Menu"><a href="http://www.cyber.incheon.kr/" target="_blank" title="시민사이버교육" onFocus="top2menuView(8);" onMouseOver="top2menuView(8);"><img id="topmainimg8" src="/images/<%= skinDir %>/menu/topMu_1depth08_on.gif" alt="시민사이버교육" /></a>		
					<!--ul id="top2m7" onMouseOver="top2menuView(7);"> 
						<li><a href="javascript:void(0);" class="topsubmenu" title="Q&A"><img src="/images/<%= skinDir %>/menu/topMu_2depth701.gif" alt="Q&A" /></a></li>
						<li><a href="javascript:void(0);" class="topsubmenu" title="FAQ"><img src="/images/<%= skinDir %>/menu/topMu_2depth702.gif" alt="FAQ" /></a></li>
						<li><a href="javascript:void(0);" class="topsubmenu" title="교육자료실"><img src="/images/<%= skinDir %>/menu/topMu_2depth703.gif" alt="교육자료실" /></a></li>
					</ul-->
				</li>
				<!-- //Gmenu08 -->
			</ul>
		</div>
		
		<!--//GnbMenu-->
		<div class="qMuSpaceT"></div>						
		
	<%
		// 메인에서만 표시함
		if(topMenu.equals("main")){ 
	%>
		<!-- 플래시_비쥬얼 -->
		<div class="flashArear">
			<!-- <img src="/images/skin1/temp/img_main01.jpg" style="width:388px;height:167px;" alt="" /> -->
			<OBJECT classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,0,0" WIDTH="388" HEIGHT="167" id='mainswf_<%= skinDir %>' ALIGN=""> 
			<PARAM NAME=movie VALUE="/commonInc/swf/flash_main_<%= skinDir %>.swf">
			<PARAM NAME=quality VALUE=high>
			<PARAM NAME=bgcolor VALUE=#FFFFFF>
			<EMBED src="/commonInc/swf/flash_main01_<%= skinDir %>.swf" quality=high bgcolor=#FFFFFF  WIDTH="400" HEIGHT="300" NAME="sample1" ALIGN="" TYPE="application/x-shockwave-flash" PLUGINSPAGE="http://www.macromedia.com/go/getflashplayer"></EMBED> 

			</OBJECT>
		</div>
		<!-- //플래시_비쥬얼 -->
		
		<!-- 교육생숙지사항,분야별교육안내,과정운영계획 -->
		<div class="topContSet">
			<div class="topCont01">
				<h3><img src="/images/<%= skinDir %>/main/txt_topC01.gif" alt="교육생 숙지사항" /></h3>
				<ul>
					<li><a href="/down/01.hwp">2010 교육훈련계획</a></li>
					<li><a href="/down/02.hwp">교육인정시간 기준</a></li>
					<li><a href="/down/03.hwp">사이버교육 운영지침</a></li>
					<li><a href="/down/04.hwp">사이버과정별 안내서</a></li>
				</ul>
			</div>
			<div class="topCont01">
				<h3><img src="/images/<%= skinDir %>/main/txt_topC02.gif" alt="분야별 교육안내" /></h3>
				<ul>
					<li><a href="javascript:fnGoMenu(3,'eduinfo3-1')">기본교육(신규)</a></li>
					<li><a href="javascript:fnGoMenu(3,'eduinfo3-2')">장기교육(핵심,외국어)</a></li>
					<li><a href="javascript:fnGoMenu(3,'eduinfo3-3')">전문교육</a></li>
					<li><a href="javascript:fnGoMenu(3,'eduinfo3-4')">사이버교육</a></li>
				</ul>
			</div>
			<div class="topCont01">
				<h3><img src="/images/<%= skinDir %>/main/txt_topC03.gif" alt="과정운영계획" /></h3>
				<ul>
					<div id="test">
					</div>					
				</ul>
			</div>
			<div class="spaceN"></div>
		</div>
		<!-- //교육생숙지사항,분야별교육안내,과정운영계획 -->
	<%	} %>	
		
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

<%
	if(!topMenu.equals("main")){		
		out.println(" top2menuView(" + topMenu + "); ");		
	}else{
		// 페이지로드시현재위치1차메뉴활성
		out.println("//top2menuHide(0)");
	}
%>

//-->
</script>