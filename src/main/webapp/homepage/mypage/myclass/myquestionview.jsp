<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
// prgnm 	: 입교안내
// date		: 2008-08-07
// auth 	: kang
%>

<%

	// 필수, request 데이타
	DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
	requestMap.setNullToInitialize(true);
	
	// 리스트
	DataMap listMap = (DataMap)request.getAttribute("MY_QUESTION_VIEW");
	listMap.setNullToInitialize(true);

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
				<jsp:param name="topMenu" value="1" />
			</jsp:include>
			<!--[e] header -->						
			
			<div id="middle">			
				<!--[s] left -->
				<jsp:include page="/commonInc/include/comLeftMenu.jsp" flush="false">
					<jsp:param name="leftMenu" value="7" />
					<jsp:param name="leftIndex" value="4" />
					<jsp:param name="leftSubIndex" value="2" />
				</jsp:include>
				<!--[e] left -->



	<!-- contentOut s ===================== -->
	<div id="subContentArear">
		<!-- content image
		<div id="contImg"><img src="/images/skin1/sub/img_cont00.jpg" alt="" /></div>
		//content image -->

		<!-- title/location -->
		<div id="top_title">
			<h1 id="title"><img src="/images/skin1/title/tit_mypage.gif" alt="마이페이지" /></h1>
			<div id="location">
			<ul> 
				<li class="home"><a href="">HOME</a></li>
				<li>마이페이지</li>
				<li>개인정보</li>
				<li class="on">나의 질문</li>
			</ul>
			</div>
		</div>
		<!-- title/location -->
		<div class="spaceTop"></div>

		<!-- content s ===================== -->
		<div id="content">
			<!-- title --> 
			<h2 class="h2L"><img src="/images/skin1/title/tit_info.gif" class="mr8" alt="개인정보" /><img src="/images/skin1/title/tit_myQa.gif" alt="나의 질문" /></h2>
			<!-- //title -->
			<div class="h9"></div>

			<!-- view -->
			<table class="bView01">	
			<tr>
				<th class="bl0">제목</th>
				<td colspan="3">
					<%=listMap.getString("title", 0)%>
				</td>
			</tr>
			<tr>
				<th class="bl0" width="75">날짜</th>
				<td width="320"><%=listMap.getString("regdate", 0)%></td>
				<%
					String group = "";
					
						if(listMap.getString("subj", 0).equals("APPLY")) {
							group = "수강신청의견";
						}else {
							group = "질문방";
						}
					
				%>
				<th width="75">분류</th>
				<td width="100"><%=group%></td>
			</tr>
			<tr>
				<th class="bl0">내용</th>
				<td class="cont" colspan="3">
				<%=listMap.getString("content", 0)%>
				</td>
			</tr>
			</table>	
			<!-- //view -->

			<!-- button -->
			<div class="btnRbtt">			
				<a href="/mypage/myclass.do?mode=myquestion"><img src="/images/skin1/button/btn_list02.gif" alt="리스트" /></a>
			</div>
			<!-- //button -->
			<div class="space"></div>
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