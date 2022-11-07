<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 기관별 분반 Type 1
// date  : 2008-06-09
// auth  : kang
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
	LoginCheck loginChk = new LoginCheck();
	String navigationStr = loginChk.NavigationCreate(memberInfo, navigationMap);
	////////////////////////////////////////////////////////////////////////////////////
	
	
	// 과정명
	DataMap grCodeMap = (DataMap)request.getAttribute("GRCODENM");
	if(grCodeMap == null) grCodeMap = new DataMap();
	grCodeMap.setNullToInitialize(true);
	
	// 과목명
	DataMap subjMap = (DataMap)request.getAttribute("SUBJNM");
	if(subjMap == null) subjMap = new DataMap();
	subjMap.setNullToInitialize(true);
	
	
	String strTitle = "";
	strTitle = "년도 : <font color=\"#0080FF\">" + requestMap.getString("commYear") + "</font>"
			+ "&nbsp;&nbsp;&nbsp;과정명 : <font color=\"#0080FF\">" + grCodeMap.getString("grcodenm") + "</font>"
			+ "&nbsp;&nbsp;&nbsp;기수 : <font color=\"#0080FF\">" + requestMap.getString("commGrseq").substring(4,6) + "</font>"
			+ "&nbsp;&nbsp;&nbsp;과목명 : <font color=\"#0080FF\">" + subjMap.getString("subjnm") + "</font>";
			
			
	// 기관별 입교자 리스트
	DataMap deptClassMap = (DataMap)request.getAttribute("DEPTCLASS_LIST");
	if(deptClassMap == null) deptClassMap = new DataMap();
	deptClassMap.setNullToInitialize(true);
	
	// 분반 갯수 목록
	DataMap subjClassMap = (DataMap)request.getAttribute("SUBJCLASS_LIST");
	if(subjClassMap == null) subjClassMap = new DataMap();
	subjClassMap.setNullToInitialize(true);
	
	StringBuffer sbDeptClassListHtml = new StringBuffer();
	String strSubjClassHtml = "";


	
	if(deptClassMap.keySize("dept") > 0){		
		for(int i=0; i < deptClassMap.keySize("dept"); i++){
			
			sbDeptClassListHtml.append("<tr bgcolor=\"#FFFFFF\" height=\"25\">");
			sbDeptClassListHtml.append("	<td align=\"center\" class=\"tableline11\">" + (i+1) + "</td>");
			sbDeptClassListHtml.append("	<td align=\"left\" class=\"tableline11\" style=\"padding:0 0 0 10\">" + deptClassMap.getString("deptnm",i) + "</td>");
			sbDeptClassListHtml.append("	<td align=\"center\" class=\"tableline11\">" + deptClassMap.getString("countUser",i) + " 명</td>");
			sbDeptClassListHtml.append("	<td align=\"center\" class=\"tableline21\">");
			
			
			if(subjClassMap.keySize("classno") > 0){
				strSubjClassHtml = "<select name=\"selSubjClass" + i + "\" id=\"selSubjClass" + i + "\" >";
				for(int j=0; j < subjClassMap.keySize("classno"); j++){
					
					String strSelected = "";
					
					if( deptClassMap.getString("classno",i).equals( subjClassMap.getString("classno",j) ) ){
						strSelected = "selected";
					}else{
						strSelected = "";
					}
					
					strSubjClassHtml += "	<option value=\"" + subjClassMap.getString("classno",j) + "\" " + strSelected + " >" + subjClassMap.getString("classnm",j) + "</option>";
				}
				strSubjClassHtml += "</select>";
			}
						
			sbDeptClassListHtml.append("	" + strSubjClassHtml );
						
			sbDeptClassListHtml.append("		<input type=\"hidden\" name=\"txtDept" + i + "\" id=\"txtDept" + i + "\" value=\"" + deptClassMap.getString("dept",i) + "\">    ");
			sbDeptClassListHtml.append("	</td>");
			sbDeptClassListHtml.append("</tr>");									
		}
	}else{
		sbDeptClassListHtml.append("<tr bgcolor=\"#FFFFFF\" height=\"100\">");
		sbDeptClassListHtml.append("	<td align=\"center\" class=\"tableline21\" colspan=\"100%\">데이타가 없습니다.</td>");		
		sbDeptClassListHtml.append("</tr>");
	}
	
	
%>


<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->


<script language="JavaScript">
<!--

// 반지정정보보기
function fnClassList(){
	$("mode").value = "classList";
	pform.action = "class.do";
	pform.submit();
}

// 저장
function fnSave(){
	if(confirm("선택하신 정보로 반을 편성하시겠습니까?")){
		$("mode").value = "saveByDept1";
		pform.action = "class.do";
		pform.submit();
	}
}

// 타과목동일반구성하기
function fnSetOtherClassPop(){
	if( $F("commGrcode") != "" &&
	    $F("commGrseq") != "" &&
	    $F("commSubj") != "" ){
						
		var url = "class.do";
		url += "?mode=otherPop";
		url += "&commGrcode=" + $F("commGrcode");
		url += "&commGrseq=" + $F("commGrseq");
		url += "&commSubj=" + $F("commSubj");
		url += "&menuId=" + $F("menuId");
		
		pwinpop = popWin(url,"oPop","600","600","yes","yes");
		
		
	}else{
		alert("검색 조건을 모두 선택해야 합니다.");
	}
}


//-->
</script>
<script for="window" event="onload">

</script>


<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<form id="pform" name="pform" method="post" >

<input type="hidden" name="menuId" 		id="menuId"		value="<%= requestMap.getString("menuId") %>">
<input type="hidden" name="mode"		id="mode"		value="<%= requestMap.getString("mode") %>">

<input type="hidden" name="rowCount" 	id="rowCount"	value="<%= deptClassMap.keySize("dept") %>">


<!-- 이전화면 검색조건 -->
<input type="hidden" name="commGrcode" 	id="commGrcode" value="<%= requestMap.getString("commGrcode") %>">
<input type="hidden" name="commGrseq" 	id="commGrseq"	value="<%= requestMap.getString("commGrseq") %>">
<input type="hidden" name="commSubj" 	id="commSubj" 	value="<%= requestMap.getString("commSubj") %>">



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
						<img src="/images/bullet003.gif"  align="bottom">&nbsp;<strong>기관별 분반 리스트</strong>
					</td>
				</tr>
			</table>
			<!--[e] subTitle -->
			
			<!--[s] Contents Form  -->
			<table cellspacing="0" cellpadding="0" border="0" width="100%" class="contentsTable">
				<tr>
					<td>
					
						<br>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr bgcolor="#375694"><td height="2"></td></tr>
							<tr height="30">
								<td align="left" bgcolor="#FFFFFF" style="padding:0 0 0 9">
									<%= strTitle %>
								</td>
							</tr>
							<tr bgcolor="#375694"><td height="2"></td></tr>
						</table>
					
						<br>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr bgcolor="#375694"><td height="2" colspan="100%"></td></tr>
							<tr height="28" bgcolor="#5071B4">
								<td align="center" class="tableline11 white"><strong>일련번호</strong></td>
								<td align="center" class="tableline11 white"><strong>기관명</strong></td>
								<td align="center" class="tableline11 white"><strong>입교현황</strong></td>
								<td align="center" class="tableline21 white"><strong>반 선택</strong></td>
							</tr>
							
							<%= sbDeptClassListHtml.toString() %>
							
							<tr bgcolor="#375694"><td height="2" colspan="100%"></td></tr>
						</table>
						
						<br>
						<table width="100%" border="0" cellpadding="0" cellspacing="0" style="border-collapse:collapse;">
							<tr>
								<td align="right">
									<input type="button" value="타과목 동일 반 구성하기" onclick="fnSetOtherClassPop();" class="boardbtn1">
									&nbsp;
									<input type="button" value="저 장" onclick="fnSave();" class="boardbtn1">
									&nbsp;
									<input type="button" value="반지정정보 보기" onclick="fnClassList();" class="boardbtn1">
								</td>
							</tr>
						</table>
					
						<br><br>
					</td>
				</tr>
			</table>
			<!--[e] Contents Form  -->
				                            
        </td>
    </tr>
</table>

<!--[s] bottom -->
<jsp:include page="/commonInc/include/commonAdminBottom.jsp" flush="false"/>
<!--[e] bottom -->
	
</form>
</body>


