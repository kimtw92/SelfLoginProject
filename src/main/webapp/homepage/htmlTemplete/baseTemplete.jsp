<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
// prgnm 	: html templete
// date		: 2008-08-08
// auth 	: kang
%>

<%@ include file="/commonInc/include/commonImport.jsp" %>
<%@ include file="/commonInc/include/comInclude.jsp" %>

<%

	//request 데이터
	DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
	requestMap.setNullToInitialize(true);
	
	
	StringTokenizer st = null;
	String htmlContent = "";
	String topMenu = "";
	String leftMenu = "";
	String leftIndex = "";
	
	DataMap htmlMap = (DataMap)request.getAttribute("HTML_DATA");
	if(htmlMap == null) htmlMap = new DataMap();
	htmlMap.setNullToInitialize(true);
	
	if(htmlMap.keySize("htmlId") > 0){		
		for(int i=0; i < htmlMap.keySize("htmlId"); i++){
			st = new StringTokenizer( htmlMap.getString("menuid", i) ,"-");
			htmlContent = StringReplace.convertHtmlDecode(htmlMap.getString("htmlContent", i));
			
			topMenu = st.nextToken();
			leftMenu = st.nextToken();
			leftIndex = st.nextToken();
			
		}
	}

%>


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
				<jsp:param name="topMenu" value="<%= topMenu %>" />
			</jsp:include>
			<!--[e] header -->						
			
			<div id="middle">			
				<!--[s] left -->
				<jsp:include page="/commonInc/include/comLeftMenu.jsp" flush="false">
					<jsp:param name="leftMenu" value="<%= leftMenu %>" />
					<jsp:param name="leftIndex" value="<%= leftIndex %>" />
				</jsp:include>
				<!--[e] left -->
				
				<%= htmlContent.replaceAll("<p>","").replaceAll("</p>","") %>
				
				
				
	
				
				
				
				
				
				<div class="spaceBtt"></div>
			</div>			
		</div>
		<!--[s] quick -->
		<jsp:include page="/commonInc/include/comQuick.jsp" flush="false"/>
		<!--[e] quick -->
	</div>
	<!--[s] footer -->
	<jsp:include page="/commonInc/include/comFoot.jsp" flush="false"/>
	<!--[e] footer -->
</div>

</form>
</body>				