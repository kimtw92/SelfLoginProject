<%@ page language="java"  contentType="text/html; charset=UTF-8"%>
<%@ include file="/commonInc/include/comInclude.jsp" %>


<script type="text/javascript" language="javascript" src="/commonInc/js/zoominout.js"></script>
<div class="quick1">
	<div class="optionSet">
		<h3 class="optionTit"><img src="/images/skin1/quick/tit_option.gif" alt="문자옵션" /></h3>
		<p class="zBtn">
		<span class="zoom00"><a href="#" onClick="yangZoom(); return false;" onFocus="blur()" tabindex="3"><img src="/images/skin1/quick/btn_zoom00.gif" alt="기본글자크기 버튼" /></a></span>
		<a href="#" onClick="zoomIn(); return false;" onFocus="blur()" tabindex="1"><span><img src="/images/skin1/quick/btn_zoom01.gif" alt="글자크기확대 버튼" /></span></a>
		<a href="#" onClick="zoomOut(); return false;" onFocus="blur()" tabindex="2"><span><img src="/images/skin1/quick/btn_zoom02.gif" alt="글자크기축소 버튼" /></span></a>
		</p>
	</div>

	<div class="quickSet">
		<div class="quickT" title="Quick Menu">
			<a href=javascript:popWin("/homepage/studyhelp/learning_guide01.html","ddd","820","515","no","no")>
			<img src="/images/skin1/quick/img_q01.gif" alt=""/>
			</a>
			<ul>
				<li><a href="/down/01.hwp"  onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('leftImg101','','/images/skin1/quick/qMenu01r_on.gif',1)"><img src="/images/skin1/quick/qMenu01r.gif" id="leftImg101" alt="2008 교육계획"/></a></li>

				<li><a href="/homepage/infomation.do?mode=eduinfo2-1"  onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('leftImg102','','/images/skin1/quick/qMenu02r_on.gif',1)"><img src="/images/skin1/quick/qMenu02r.gif" id="leftImg102" alt="입교안내"/></a></li>

				<li><a href="/homepage/index.do?mode=worktel"  onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('leftImg103','','/images/skin1/quick/qMenu03r_on.gif',1)"><img src="/images/skin1/quick/qMenu03r.gif" id="leftImg103" alt="업무및전화"/></a></li>

				<!-- <li><a href="/homepage/introduce.do?mode=reservation"  onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('leftImg105','','/images/skin1/quick/qMenu05r_on.gif',1)"><img src="/images/skin1/quick/qMenu05r.gif" id="leftImg105" alt="시설대여신청"/></a></li> -->
				<li><a href="javascript:fnGoMenu('7','reservation');"  onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('leftImg105','','/images/skin1/quick/qMenu05r_on.gif',1)"><img src="/images/skin1/quick/qMenu05r.gif" id="leftImg105" alt="시설대여신청"/></a></li>

				<li class="endQ"><a href="/homepage/introduce.do?mode=eduinfo7-7"  onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('leftImg104','','/images/skin1/quick/qMenu04r_on.gif',1)"><img src="/images/skin1/quick/qMenu04r.gif" id="leftImg104" alt="오시는길"/></a></li>

			</ul>
		</div>
	</div>
	<!--img src="/images/skin1/temp/quick.jpg" alt="" /-->
</div>

<div class="space01"></div>