<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
// prgnm 	: 교육훈련체계
// date		: 2008-08-07
// auth 	: kang
%>

<%@ include file="/commonInc/include/commonImport.jsp" %>

<%

	//request 데이터
	DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
	requestMap.setNullToInitialize(true);

	
	DataMap sampleMap = (DataMap)request.getAttribute("SAMPLE_DATA");
	if(sampleMap == null) sampleMap = new DataMap();
	sampleMap.setNullToInitialize(true);
	
	
	StringBuffer strHtml = new StringBuffer();
	
	if(sampleMap.keySize("userno") > 0){		
		for(int i=0; i < sampleMap.keySize("userno"); i++){
			
			strHtml.append( sampleMap.getString("userno", i) + "," );
			strHtml.append( sampleMap.getString("homeTel", i) + "," );
			strHtml.append( sampleMap.getString("name", i) + "<br>" );
									
		}
	}
	

%>


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
					<jsp:param name="leftMenu" value="1" />
					<jsp:param name="leftIndex" value="2" />
				</jsp:include>
				<!--[e] left -->
				
				
				
				
				
				
				<!-- contentOut s ===================== -->
				<div id="subContentArear">
					<!-- content image -->
					<div id="contImg"><img src="/images/<%= skinDir %>/sub/img_cont00.gif" alt="" /></div>
					<!-- //content image -->
			
					<!-- title/location -->
					<div id="top_title">
						<h1 id="title"><img src="/images/<%= skinDir %>/title/tit_0002.gif" alt="교육훈련체계" /></h1>
						<div id="location">
						<ul> 
							<li class="home"><a href="">HOME</a></li>
							<li>교육안내</li>
							<li class="on">교육훈련체계</li>
						</ul>
						</div>
					</div>
					<!-- title/location -->
					<div class="spaceTop"></div>
			
					<!-- content s ===================== -->
					
					<%= strHtml.toString() %>
					
					
					<div id="content">
						<!-- data -->
						<div class="rGrySet">
						<div class="rGry">
			                <h3 class="h3gra"><img src="/images/<%= skinDir %>/title/tit_000201.gif" class="mr8" alt="교육훈련체계" /></h3>
			                
			                <h4 class="h4txt">기본교육훈련</h4>
							<p>
			                	신규채용후보자 또는 신규채용자에 대하여 공무원으로서 필요한 능력과 자질을 배양할 수 있는<br /> 교육과정 
			                </p>
			
			                <h4 class="h4txt">전문교육훈련</h4>
							<p>
			                	공무원으로서 기본적이고 필수적으로 함양해야 하는 전문지식·기술의 습득 및 향상을 목적으로하는<br /> 1일이상의 교육과정 
			                </p>
			
			                <h4 class="h4txt">기타교육훈련</h4>
							<p>
			                	담당업무와 관련된 교육과정 또는 다양한 전문지식 습득을 위한 1일이상의 교육과정
			                </p>
						</div>
						</div>
						<!-- //data --> 		
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