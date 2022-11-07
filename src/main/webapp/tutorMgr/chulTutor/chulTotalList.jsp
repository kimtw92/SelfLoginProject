<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 출강강사 명단 전체 리스트
// date  : 2008-07-10
// auth  : 정윤철
%>

<!-- [s] commonImport -->
<%@ include file="/commonInc/include/commonImport.jsp" %>
<!-- [e] commonImport -->

<%
    //request 데이터
	DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
	requestMap.setNullToInitialize(true);

	// 필수 코딩 내용 //////////////////////////////////////////////////////////////////////
	//로그인된 사용자 정보
	LoginInfo memberInfo = (LoginInfo)request.getAttribute("LOGIN_INFO");
	
    //navigation 데이터
	DataMap navigationMap = (DataMap)request.getAttribute("NAVIGATION_DATA");
	navigationMap.setNullToInitialize(true);
	
	// 상단 navigation
	String navigationStr = LoginCheck.NavigationCreate(memberInfo, navigationMap);
	////////////////////////////////////////////////////////////////////////////////////
	
	//리스트 데이터
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	listMap.setNullToInitialize(true);
	
	//페이지 처리
	PageNavigation pageNavi = (PageNavigation)listMap.get("PAGE_INFO");
	int pageNum = pageNavi.getTotalCnt() - (requestMap.getInt("currPage") - 1) * requestMap.getInt("rowSize");
	

	//과정별 소계 데이터
	DataMap courseList = (DataMap)request.getAttribute("COURSELIST_DATA");
	courseList.setNullToInitialize(true);

	StringBuffer html = new StringBuffer();
	if(listMap.keySize("grcode") > 0 ){

		for(int i=0; i < listMap.keySize(); i++){
			html.append("<tr>");
			html.append("<td align=\"center\">"+(pageNum - i)+"</strong></td>");
			html.append("<td align=\"center\">"+(listMap.getString("strDate", i).equals("") ? "&nbsp" : listMap.getString("strDate",i) )+"~"+(listMap.getString("endDate",i).equals("") ? "&nbsp" : listMap.getString("endDate",i) )+"</td>");
			html.append("<td align=\"center\">"+(listMap.getString("grcodenm", i).equals("") ? "&nbsp" : listMap.getString("grcodenm",i) )+"</td>");
			html.append("<td align=\"center\">"+(listMap.getString("name", i).equals("") ? "&nbsp" : listMap.getString("name",i) )+"</td>");
			
			if(listMap.getString("tgubun", i).equals("1")){
				html.append("<td align=\"center\" width=\"55\">주강사</td>");
				
			}else if(listMap.getString("tgubun", i).equals("0")){
				html.append("<td align=\"center\">보조강사</td>");
				
			}else{
				html.append("<td align=\"center\">&nbsp;</td>");
				
			}
			
			html.append("<td align=\"center\">"+(listMap.getString("ttime", i).equals("") ? "&nbsp" : listMap.getString("ttime", i) )+"</td>");
			html.append("<td align=\"center\">"+(listMap.getString("eduinwon", i).equals("") ? "&nbsp" : listMap.getString("eduinwon", i) )+"</td>");
			html.append("<td align=\"center\" class=\"br0\">&nbsp</td>");
			html.append("</tr>");
		}

		

	}else{
		html.append("<tr>");
		html.append("<td align=\"center\" colspan=\"100%\" class=\"br0\" style=\"height:100px\">등록된 출강강사가 없습니다.</td>");
		html.append("</tr>");	
	}
	
	StringBuffer option = new StringBuffer();
	for(int i=0; courseList.keySize("grcode") > i; i++){
		option.append("<option value=\""+courseList.getString("grcode",i)+"\">"+courseList.getString("grcodenm",i)+"</option>");
		
	}
	
	//페이징 String
	String pageStr = "";
	if(listMap.keySize("grcode") > 0){
		pageStr += pageNavi.showFirst();
		pageStr += pageNavi.showPrev();
		pageStr += pageNavi.showPage();
		pageStr += pageNavi.showNext();
		pageStr += pageNavi.showLast();
	}
	
%>


<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->


<script language="JavaScript">
<!--
//검색
function go_serach(){
	$("mode").value = "totalList";


	if($("sDate").value > $("eDate").value){
		alert("시작일이 종료일보다 낮을수 없습니다.")
		return false;
	}
		

	if(NChecker($("pform"))){
		
		$("currPage").value= "";
		pform.action = "/tutorMgr/chulTutor.do";				
		pform.submit();
	}
}

//페이지 이동
function go_page(page) {
	$("currPage").value = page;
	go_list();
}
//리스트
function go_list(){
	$("mode").value = "totalList";
	pform.action = "/tutorMgr/chulTutor.do";				
	pform.submit();
}

//-->
</script>


<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<form id="pform" name="pform" method="post" >

<input type="hidden" name="menuId" 	value="<%= requestMap.getString("menuId") %>">
<input type="hidden" name="mode"	value="<%= requestMap.getString("mode") %>">
<input type="hidden" name="currPage"			value='<%=requestMap.getString("currPage")%>'>
<input type="hidden" name="qu"		value="">

<table cellspacing="0" cellpadding="0" border="0" width="100%" height="100%">
    <tr>
        <td width="211" height="86" valign="bottom" align="center" nowrap><img src="/images/incheon_logo.gif" width="192" height="56" border="0"></td>
        <td width="8" valign="top" nowrap><img src="/images/lefttop_bg.gif" width="8" height="86" border="0"></td>
        <td width="100%">
            <!--[s] 공통 top include -->
            <jsp:include page="/commonInc/include/commonAdminTopMenu.jsp" flush="false"/>
            <!--[e] 공통 top include -->
        </td>
    </tr>
    
    <tr>
        <td height="100%" valign="top" align="center" class="leftMenuIllust">
            <!--[s] 공통 Left Menu  -->
            <jsp:include page="/commonInc/include/commonAdminLeftMenu.jsp" flush="false"/>            	
            <!--[e] 공통 Left Menu  -->
        </td>

        <td colspan="2" valign="top" class="leftMenuBg">
          
            <!--[s] 경로 네비게이션-->
            <%= navigationStr %>
            <!--[e] 경로 네비게이션-->
                                    
			<!--[s] 타이틀 -->
			<jsp:include page="/commonInc/include/commonAdminTitle.jsp" flush="false" />
			<!--[e] 타이틀 -->

			<!--[s] subTitle -->
			<table width="100%" height="10"><tr><td></td></tr></table>
			<table width="100%" border="0" cellspacing="0" cellpadding="0" class="contentsSubTitleTable">			
				<tr>
					<td height="20">
						<img src="/images/bullet003.gif"  align="bottom">&nbsp;<strong>출강강사관리</strong>
					</td>
				</tr>
			</table> 
			<!--[e] subTitle -->
			<div class="space01"></div>
			<!--[s] Contents Form  -->
			<div class="h10"></div>
			<!--[s] Contents Form  -->
			<table cellspacing="0" cellpadding="0" border="0" width="100%"
				class="contentsTable">
				<tr>
					<td>
						<!--//검색 -->
						<div class="space01"></div>
						<!-- 검색 -->
							<table class="search01">
								<tr>
									<th width="80" class="bl0">
										기간
									</th>
									<td width="30%">
										<input type="text" size="10" class="textfield" name="sDate" value="<%=requestMap.getString("sDate")%>" readonly/>
										<img style="cursor:hand" onclick="fnPopupCalendar('pform','sDate');" src="../images/icon_calen.gif" alt="" />
										~
										<input type="text" size="10" class="textfield" name="eDate" value="<%=requestMap.getString("eDate")%>" readonly/>
										<img style="cursor:hand" onclick="fnPopupCalendar('pform','eDate');" src="../images/icon_calen.gif" alt="" />
									</td>
									<th width="80">
										과목검색  
									</th>
									<td>
										<select name="grcode" class="mr10">
											<option selected  value="">
											**선택하세요**
											</option>
										<%=option.toString() %>
										</select>									
									</td>
									<td width="100" class="btnr" rowspan="2">
										<input type="button" value="검 색" onclick="go_serach();" class="boardbtn1">
									</td>								
								</tr>
							</table>
						<!--//검색 -->
						<div class="space01"></div>
						
						<!--[s] 리스트  -->
						<table class="datah01">
							<thead>
							<tr>
								<th>연번</th>
								<th>연월일(기간)</th>
								<th>과정명</th>
								<th>강사성명</th>
								<th>강사구분</th>
								<th>시간</th>
								<th>교육인원</th>
								<th class="br0">비고</th>
							</tr>
							</thead>

							<tbody>
							<%=html %>
							</tbody>
						</table>
						<!--//[e] 리스트  -->	

						<!-- 페이징 --> 
						<div class="paging">
							<%=pageStr%>
						</div>
						<!-- //페이징 -->
						<div class="space01"></div>
						<!--//[e] 리스트  -->	
					</td>
				</tr>
			</table>
			<!--//[e] Contents Form  -->
			<div class="space_ctt_bt"></div>                         
        </td>
    </tr>
</table>

<!--[s] bottom -->
<jsp:include page="/commonInc/include/commonAdminBottom.jsp" flush="false"/>
<!--[e] bottom -->

</form>
</body>

<script language="JavaScript" type="text/JavaScript">
	//검색 조건 셀렉티드
	var grcode = "<%=requestMap.getString("grcode")%>";
	len = $("grcode").options.length
	
	for(var i=0; i < len; i++) {
		if($("grcode").options[i].value == grcode){
			$("grcode").selectedIndex = i;
		 }
 	 }
</script>