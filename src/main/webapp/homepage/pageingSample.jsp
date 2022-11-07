<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
// prgnm 	: 페이징 셈플
// date		: 2008-08-12
// auth 	: kang
%>

<%@ include file="/commonInc/include/commonImport.jsp" %>
<%@ include file="/commonInc/include/comInclude.jsp" %>
<%

	// 필수, request 데이타
	DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
	requestMap.setNullToInitialize(true);

	
	
	// 리스트
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	listMap.setNullToInitialize(true);
	
	
	// 페이징 필수
	FrontPageNavigation pageNavi = (FrontPageNavigation)listMap.get("PAGE_INFO");
	int pageNum = pageNavi.getTotalCnt() - (requestMap.getInt("currPage") - 1) * requestMap.getInt("rowSize");
	
	
	StringBuffer sbListHtml = new StringBuffer();
	
	String pageStr = "";
	
	if(listMap.keySize("userno") > 0){		
		for(int i=0; i < listMap.keySize("userno"); i++){
			
			sbListHtml.append("<tr height=\"25\">");
			sbListHtml.append("	<td >" + (pageNum - i) + "</td>");
			sbListHtml.append("	<td >" + listMap.getString("userno", i) + "</td>");
			sbListHtml.append("	<td >" + listMap.getString("homeTel", i) + "</td>");
			sbListHtml.append("	<td >" + listMap.getString("name", i) + "</td>");
			sbListHtml.append("</tr>");		
		}
		
		pageStr = pageNavi.FrontPageStr();				
	}else{
		// 리스트가 없을때
	}
%>



<jsp:include page="/commonInc/include/comHtmlTop.jsp" flush="false">
	<jsp:param name="cssName" value="layout" />
</jsp:include>



<script language="JavaScript" type="text/JavaScript">
<!--

// 페이지 이동
function go_page(page) {
	$("currPage").value = page;
	fnList();
}

// 리스트
function fnList(){
	$("mode").value = "pageing";
	pform.action = "/homepage/index.do";
	pform.submit();
}


//-->
</script>




<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<form id="pform" name="pform" method="post">

<!-- 필수 -->
<input type="hidden" name="mode"		value="<%= requestMap.getString("mode") %>">

<!-- 페이징용 -->
<input type="hidden" name="currPage"	value="<%= requestMap.getString("currPage")%>">


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
				
					<!-- content s ===================== -->
					<div id="content">
						<!-- list -->
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<%= sbListHtml.toString() %>
						</table>
						<br><br>
						
						<div class="BtmLine"></div>
						
						<!-- pageing -->
						<div class="paging">
						<%= pageStr %>
						</div>
					
					</div>
				
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