<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%

	// 필수, request 데이타
	DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
	requestMap.setNullToInitialize(true);

	
	
	// 리스트
	DataMap listMap = (DataMap)request.getAttribute("CYBER_COURSE_DATA");
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
		String yyyy =  new java.text.SimpleDateFormat("yyyy").format(new Date()); 
		String yy = yyyy.substring(2,4);
		int numYY = Integer.parseInt(yy)-1;
		String nextToken = "";
		for(int i=0; i < listMap.keySize("grcode"); i++){
			
				sbListHtml.append("<tr height=\"25\">");
				sbListHtml.append("	<td >" + ((number++)+((requestMap.getInt("currPage")-1)*requestMap.getInt("rowSize"))) + "</td>");
				
				grcode = listMap.getString("grcode", i);
				sbListHtml.append("	<td><a href=javascript:popWin(\"/homepage/course.do?mode=courseinfopopup&grcode="+grcode+"&grseq="+grseq+"\",\"aaa\",\"603\",\"680\",\"yes\",\"yes\")>" + listMap.getString("grcodenm", i) + "</a></td>");
				sbListHtml.append("	<td >" + listMap.getString("target", i) + "</td>");
				java.util.StringTokenizer st = new java.util.StringTokenizer(listMap.getString("edudate", i),",");
				
				sbListHtml.append("<td>");
				while (st.hasMoreTokens()) {
					nextToken = st.nextToken();

					if(String.valueOf(numYY).equals(nextToken.substring(0,2))) {
						continue;
					}
					sbListHtml.append(nextToken+ "<br>");
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
	$("mode").value = "pageing4";
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
                    
            <div style="margin-bottom: -20px;" class="local">
              <h2>e-러닝</h2>
                <div class="navi"><img src="/homepage_new/images/common/icon_home.gif" alt="home"> &gt; 교육과정 &gt; e-러닝 &gt; <span>전문교육</span></div>
            </div>
            <div class="contnets">
            <!-- contnet -->
            
            <h3>e-러닝(전문) 학습안내</h3>
			<a href="http://incheon.nhi.go.kr/"><font color="red"> 2019년부터 e-러닝(전문)은 인천시 나라배움터 사이트에서 학습가능 <br/>나라배움터 학습 사이트 바로가기 : incheon.nhi.go.kr</font></a>
			<br/><br/>
			
			<h3>전문교육</h3>
			<form id="pform" name="pform" method="post">

<!-- 필수 -->
<input type="hidden" id="mode" name="mode"		value="<%= requestMap.getString("mode") %>">

<!-- 페이징용 -->
<input type="hidden" id="currPage" name="currPage"	value="<%= requestMap.getString("currPage")%>">
		<div id="content">
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
				<th class="bl0">번호</th>
				<th>과정명</th>
				<th>교육대상</th>
				<th>교육기간</th>
				<th>교육시간</th>
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
		</div>
</form>
			<jsp:include page="/homepage_new/inc/admin_info.jsp" flush="true" ><jsp:param name="menucode" value="M100009" /></jsp:include>
			<div class="h80"></div>            
            <!-- //contnet -->
          </div>
        </div>
    
    
    </div>

    <jsp:include page="/homepage_new/inc/footer.jsp" flush="true" ></jsp:include>