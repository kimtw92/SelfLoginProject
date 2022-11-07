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
	DataMap listMap = (DataMap)request.getAttribute("ETC_COURSE_DATA");
	listMap.setNullToInitialize(true);
	
	
	// 페이징 필수
	FrontPageNavigation pageNavi = (FrontPageNavigation)listMap.get("PAGE_INFO");
	int pageNum = pageNavi.getTotalCnt() - (requestMap.getInt("currPage") - 1) * requestMap.getInt("rowSize");
	
	
	StringBuffer sbListHtml = new StringBuffer();
	
	String pageStr = "";
	
	int number = 1;
	
	if(listMap.keySize("grcode") > 0){
		java.util.StringTokenizer ab = new java.util.StringTokenizer(listMap.getString("grseq", 0),",");
		
		String grseq = "";
		String grcode = "";
		
		if (ab.hasMoreTokens()) {
			grseq = ab.nextToken();
		}
		
		for(int i=0; i < listMap.keySize("grcode"); i++){
				sbListHtml.append("<tr height=\"25\">");
				sbListHtml.append("	<td >" + ((number++)+((requestMap.getInt("currPage")-1)*requestMap.getInt("rowSize"))) + "</td>");
				
				grcode = listMap.getString("grcode", i);
				sbListHtml.append("	<td><a href=javascript:popWin(\"/homepage/course.do?mode=courseinfopopup&grcode="+grcode+"&grseq="+grseq+"\",\"aaa\",\"603\",\"680\",\"yes\",\"yes\")>" + listMap.getString("grcodenm", i) + "</a></td>");
				sbListHtml.append("	<td >" + listMap.getString("target", i) + "</td>");
				
				java.util.StringTokenizer st = new java.util.StringTokenizer(listMap.getString("edudate", i),",");
				
				sbListHtml.append("<td>");
				while (st.hasMoreTokens()) {
					sbListHtml.append(st.nextToken()+ "<br>");
				}
				sbListHtml.append("</td>");
				
				sbListHtml.append("	<td >" + listMap.getString("edutime", i) + "</td>");
				sbListHtml.append("</tr>");
	
		}
		
		pageStr = pageNavi.FrontPageStr();				
	}else{
		// 리스트가 없을때
	}
%>

<%@ include file="/commonInc/include/commonImport.jsp" %>
<%@ include file="/commonInc/include/comInclude.jsp" %>
<jsp:include page="/commonInc/include/comHtmlTop.jsp" flush="false">
	<jsp:param name="cssName" value="layout" />
</jsp:include>

<script type="text/javascript" language="javascript" src="/commonInc/js/commonJs.js"></script>
<script language="JavaScript" type="text/JavaScript">
<!--

// 페이지 이동
function go_page(page) {
	$("currPage").value = page;
	fnList();
}

// 리스트
function fnList(){
	$("mode").value = "pageing5";
	pform.action = "/homepage/course.do";
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
				<jsp:param name="topMenu" value="3" />
			</jsp:include>
			<!--[e] header -->						
			
			<div id="middle">			
				<!--[s] left -->
				<jsp:include page="/commonInc/include/comLeftMenu.jsp" flush="false">
					<jsp:param name="leftMenu" value="2" />
					<jsp:param name="leftIndex" value="4" />
					<jsp:param name="leftSubIndex" value="2" />
				</jsp:include>
				<!--[e] left -->



				<!-- contentOut s ===================== -->
				<div id="subContentArear">
					<!-- content image -->
					<div id="contImg"><img src="/images/<%= skinDir %>/sub/img_cont01.gif" alt="" /></div>
					<!-- //content image -->
			
					<!-- title/location -->
					<div id="top_title">
						<h1 id="title"><img src="/images/<%= skinDir %>/title/tit_otherle.gif" alt="기타교육" /></h1>
						<div id="location">
						<ul> 
							<li class="home"><a href="">HOME</a></li>
							<li>교육과정</li>
							<li class="on">기타교육</li>
						</ul>
						</div>
					</div>
					<!-- title/location -->
					<div class="spaceTop"></div>
			

		<!-- content s ===================== -->
		<div id="content">
			<h2 class="h2L"><img src="/images/skin1/title/tit_r000104.gif" alt="야간교육" /></h2>
			<div class="h9"></div>
			<!-- data -->
			<table class="bList01">	
			<colgroup>
				<col width="50" />
				<col width="143" />
				<col width="*" />
				<col width="136" />
				<col width="98" />
			</colgroup>

			<thead>
			<tr>
				<th class="bl0"><img src="/images/skin1/table/th_no.gif" alt="번호" /></th>
				<th><img src="/images/skin1/table/th_process.gif" alt="과정명" /></th>
				<th><img src="/images/skin1/table/th_learnTxtn.gif" alt="교육대상" /></th>
				<th><img src="/images/skin1/table/th_learnDt.gif" alt="교육기간" /></th>
				<th><img src="/images/skin1/table/th_learnTm.gif" alt="교육시간" /></th>
			</tr>
			</thead>

			<%= sbListHtml.toString() %>	

			</table>
			<!-- //data --> 
			<div class="BtmLine"></div>              

			<!--[s] 페이징 -->
			<div class="paging">
			<%= pageStr %>
			</div>
			<!--//[s] 페이징 -->
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