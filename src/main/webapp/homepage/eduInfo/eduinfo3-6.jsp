<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%

	// 필수, request 데이타
	DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
	requestMap.setNullToInitialize(true);

	
	
	// 리스트
	DataMap listMap = (DataMap)request.getAttribute("SEARCH_COURSE_DATA");
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
				//sbListHtml.append("	<td><a href=\"javascript:open_window('win', '/homepage/course.do?mode=courseinfopopup&grcode="+grcode+"&grseq="+grseq+"', 262, 134, 1000, 700, 0, 0, 0, 1, 0);\">" + listMap.getString("grcodenm", i) + "</a></td>");
				sbListHtml.append("	<td><a href=javascript:popWin(\"/homepage/course.do?mode=courseinfopopup&grcode="+grcode+"&grseq="+grseq+"\",\"aaa\",\"603\",\"680\",\"yes\",\"yes\")>" + listMap.getString("grcodenm", i) + "</a></td>");
				sbListHtml.append("	<td>" + listMap.getString("target", i) + "</td>");
				
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
		sbListHtml.append("<tr><td colspan='5'>검색결과가 없습니다.</td></tr>");
	}
%>

<%@ include file="/commonInc/include/commonImport.jsp" %>
<%@ include file="/commonInc/include/comInclude.jsp" %>
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
	$("mode").value = "pageing6";
	pform.action = "/homepage/course.do";
	pform.submit();
}


//-->
</script>
<jsp:include page="/homepage_new/inc/header.jsp" flush="true" ></jsp:include>
    
    <div id="subContainer">
    
    <div class="subNavi_area">
    
      <jsp:include page="/homepage_new/inc/left2.jsp" flush="true" ></jsp:include>
    
      </div>
    
        <div id="contnets_area">
          <div class="sub_visual2">교육과정</div>
            <div class="local">
              <h2>연간교육일정</h2>
                <div class="navi"><img src="/homepage_new/images/common/icon_home.gif" alt="home"> &gt; 교육과정 &gt; <span>연간교육일정</span></div>
            </div>
            <div class="contnets">
            <!-- contnet -->
            <form id="pform" name="pform" method="post">

<!-- 필수 -->
<input type="hidden" name="mode"		value="<%= requestMap.getString("mode") %>">
<input type="hidden" name="coursename"	value="<%= request.getAttribute("courseName") %>">
<!-- 페이징용 -->
<input type="hidden" name="currPage"	value="<%= requestMap.getString("currPage")%>">
<div id="content">
			<!-- data -->
			<table class="bList01">	
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
</form>
            <!-- //contnet -->
          </div>
        </div>
    
    
    </div>

    <jsp:include page="/homepage_new/inc/footer.jsp" flush="true" ></jsp:include>