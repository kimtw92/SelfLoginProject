<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
// prgnm 	: 입교안내
// date		: 2008-08-07
// auth 	: kang
%>

<%@ include file="/commonInc/include/commonImport.jsp" %>
<%@ include file="/commonInc/include/comInclude.jsp" %>
<jsp:include page="/commonInc/include/comHtmlTop.jsp" flush="false">
	<jsp:param name="cssName" value="layout" />
</jsp:include>



<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<form id="pform" name="pform" method="post">

<div id="wrapper">
	<div id="dvwhset">
		<div id="dvwh">
		
			<!--[s] header -->
			<jsp:include page="/commonInc/include/comHeader.jsp" flush="false">
				<jsp:param name="topMenu" value="5" />
			</jsp:include>
			<!--[e] header -->						
			
			<div id="middle">			
				<!--[s] left -->
				<jsp:include page="/commonInc/include/comLeftMenu.jsp" flush="false">
					<jsp:param name="leftMenu" value="4" />
					<jsp:param name="leftIndex" value="8" />
				</jsp:include>
				<!--[e] left -->

	<!-- contentOut s ===================== -->
	<div id="subContentArear">
		<!-- content image -->
		<div id="contImg"><img src="/images/skin1/sub/img_cont03.gif" alt="학습지원" /></div>
		<!-- //content image -->

		<!-- title/location -->
		<div id="top_title">
			<h1 id="title"><img src="/images/skin1/title/tit_0303.gif" alt="웹진" /></h1>
			<div id="location">
			<ul> 
				<li class="home"><a href="">HOME</a></li>
				<li>학습지원</li>
				<li>웹진</li>
				<li class="on">포토갤러리</li>
			</ul>
			</div>
		</div>
		<!-- title/location -->
		<div class="spaceTop"></div>

		<!-- content s ===================== -->
		<div id="content">
			<!-- 포토갤러리_imageTop -->			
			<div class="photoGellImgT"><img src="/images/skin1/sub/img_ptGell01.jpg" alt="포토갤러리" /></div>			
			<!-- //포토갤러리_imageTop -->
			<div class="photoGell">
				<!-- title --> 
				<h2 class="h2L01"><img src="/images/skin1/title/tit_030301.gif" alt="수료기념사진" /></h2>
				<!--div class="txtR">(<span class="txt_org">*</span> 필수입력사항)</div-->
				<!-- //title -->				
				<div class="h5"></div>
				<div class="h2L01Line"></div>

				<!-- data -->
				<div class="photo"><img src="/images/skin1/temp/img_photoG01.jpg" style="width:86px;height:63px;" alt="" /></div>
				<div class="photo"><img src="/images/skin1/temp/img_photoG02.jpg" style="width:86px;height:63px;" alt="" /></div>
				<div class="photo"><img src="/images/skin1/temp/img_photoG03.jpg" style="width:86px;height:63px;" alt="" /></div>
				<div class="photo"><img src="/images/skin1/temp/img_photoG04.jpg" style="width:86px;height:63px;" alt="" /></div>
				<div class="photo"><img src="/images/skin1/temp/img_photoG05.jpg" style="width:86px;height:63px;" alt="" /></div>
				<!-- //data -->
				<div class="h15"></div>
				<!-- data -->
				<div class="photo"><img src="/images/skin1/temp/img_photoG06.jpg" style="width:86px;height:63px;" alt="" /></div>
				<div class="photo"><img src="/images/skin1/temp/img_photoG07.jpg" style="width:86px;height:63px;" alt="" /></div>		
				<!-- //data -->
				<div class="h15"></div>

				<!--[s] 페이징 -->
				<div class="paging_pt">
					<a href="#"><img src='/images/skin1/icon/pg_back02.gif' alt='맨앞으로'></a>
					<a href="#"><img src='/images/skin1/icon/pg_back01.gif' alt='앞으로'></a>
					<ol start="1">
						<li title="현재 1페이지" class="fir">1</li>
						<li><a href="#" title="2페이지">2</a></li>
						<li><a href="#" title="3페이지">3</a></li>
						<li><a href="#" title="4페이지">4</a></li>
						<li><a href="#" title="5페이지">5</a></li>
					</ol>
					<a href="#"><img src='/images/skin1/icon/pg_next01.gif' alt='뒤로'></a>
					<a href="#"><img src='/images/skin1/icon/pg_next02.gif' alt='맨뒤로'></a>		
				</div>
				<!--//[e] 페이징 -->
			</div>
			<!-- 포토갤러리_imageBottom -->			
			<div class="photoGellImgB"><!--img src="/images/skin1/sub/img_ptGell01B.gif" alt="" /--></div>			
			<!-- //포토갤러리_imageBottom -->

			<div class="h80"></div>
		</div>
		<!-- //content e ===================== -->

	</div>
	<!-- //contentOut e ===================== -->


				
																								
				<div class="spaceBtt"></div>
			</div>			
		</div>
		
		<div id="divQuickMenu" style="position:absolute; top:10; left:89%; width:90px; height:264px; z-index:1">
			<!--[s] quick -->
			<jsp:include page="/commonInc/include/comQuick.jsp" flush="false"/>
			<!--[e] quick -->
		</div>
	</div>
	<!--[s] footer -->
	<jsp:include page="/commonInc/include/comFoot.jsp" flush="false"/>
	<!--[e] footer -->
</div>

</form>
</body>