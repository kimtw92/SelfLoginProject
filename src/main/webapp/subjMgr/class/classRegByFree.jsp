<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 자유분반 리스트
// date  : 2008-06-11
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

			
	// 분반 갯수 목록
	String strSubjClassHtml = "";
	DataMap subjClassMap = (DataMap)request.getAttribute("SUBJCLASS_LIST");
	if(subjClassMap == null) subjClassMap = new DataMap();
	subjClassMap.setNullToInitialize(true);
			
	if(subjClassMap.keySize("classno") > 0){
		strSubjClassHtml = "<select name=\"selSubjClass\" id=\"selSubjClass\" style=\"width:100px;\" >";
		for(int j=0; j < subjClassMap.keySize("classno"); j++){
			strSubjClassHtml += "	<option value=\"" + subjClassMap.getString("classno",j) + "\" >" + subjClassMap.getString("classnm",j) + "</option>";
		}
		strSubjClassHtml += "</select>";
	}
	
	// 리스트
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	if(listMap == null) listMap = new DataMap();
	listMap.setNullToInitialize(true);
	
	StringBuffer sbListHtml = new StringBuffer();
	
	if(listMap.keySize("eduno") > 0){		
		for(int i=0; i < listMap.keySize("eduno"); i++){
			sbListHtml.append("<tr bgcolor=\"#FFFFFF\" height=\"25\">");
			sbListHtml.append("	<td align=\"center\" class=\"tableline11\">" + listMap.getString("eduno",i) + "</td>");
			sbListHtml.append("	<td align=\"center\" class=\"tableline11\">");			
			sbListHtml.append("		<input type=\"checkbox\" name=\"chk\" id=\"chk_" + i + "\" >");
			sbListHtml.append("		<input type=\"hidden\" name=\"txtUser_" + i + "\" id=\"txtUser_" + i + "\" value=\"" + listMap.getString("userno",i) + "\">    ");
			sbListHtml.append("	</td>");			
			sbListHtml.append("	<td align=\"center\" class=\"tableline11\">" + listMap.getString("classnm",i) + "</td>");
			sbListHtml.append("	<td align=\"center\" class=\"tableline11\">" + listMap.getString("name",i) + "</td>");
			sbListHtml.append("	<td align=\"center\" class=\"tableline11\">" + Util.getValue( listMap.getString("sex",i), "&nbsp;") + "</td>");
			sbListHtml.append("	<td align=\"center\" class=\"tableline11\">" + listMap.getString("resno",i) + "</td>");
			sbListHtml.append("	<td align=\"center\" class=\"tableline11\">" + listMap.getString("deptnm",i) + "</td>");
			sbListHtml.append("	<td align=\"center\" class=\"tableline21\">" + listMap.getString("jiknm",i) + "</td>");
			sbListHtml.append("</td>");
			
		}
	}else{
		sbListHtml.append("<tr bgcolor=\"#FFFFFF\" height=\"100\">");
		sbListHtml.append("	<td align=\"center\" class=\"tableline21\" colspan=\"100%\">데이타가 없습니다.</td>");		
		sbListHtml.append("</tr>");
	}
	
	
	
	
%>

<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->


<script language="JavaScript">
<!--

// 저장
function fnSave(){

	var i=0;
	var tmpi = 0;
	var chkData = "";
	var objId = "";
	
	for(i=0; i < pform.elements.length; i++){		
		if(pform.elements[i].name == "chk"){
											
			if( Form.Element.getValue(pform.elements[i].id) != null ){			
				tmp = pform.elements[i].id.split("_");
				
				objId = "txtUser_" + tmp[1];
				
				if(tmpi == 0){
					chkData = $F(objId);
				}else{
					chkData += "|" + $F(objId);
				}
				
				tmpi += 1;		
			}
		}
	}
	
	$("chkData").value = chkData;
	
	if( $F("chkData") == "" ){
		alert("사용자를 선택하세요.");
	}else{
		
		if(confirm("선택하신 정보로 반을 편성하시겠습니까?")){
			$("mode").value = "saveByFree";
			pform.action = "class.do";
			pform.submit();
		}
	}
}

// 반지정정보보기
function fnClassList(){
	$("mode").value = "classList";
	pform.action = "class.do";
	pform.submit();
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

<input type="hidden" name="chkData"		id="chkData"		value="">


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
						<img src="/images/bullet003.gif"  align="bottom">&nbsp;<strong>자유분반 리스트</strong>
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
							<tr height="10"><td colspan="100%"></td></tr>
							<tr>
								<td align="right" width="90%">반 선택 :</td>
								<td align="left" style="padding:0 0 0 9"><%= strSubjClassHtml %></td>								
							</tr>
							<tr height="5"><td colspan="100%"></td></tr>
						</table>
						
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr bgcolor="#375694"><td height="2" colspan="100%"></td></tr>
							<tr height="28" bgcolor="#5071B4">
								<td width="50" align="center" class="tableline11 white"><strong>교번</strong></td>
								<td width="70" align="center" class="tableline11 white"><strong>변경반</strong></td>
								<td align="center" class="tableline11 white"><strong>지정반</strong></td>
								<td width="80" align="center" class="tableline11 white"><strong>이름</strong></td>
								<td width="50" align="center" class="tableline11 white"><strong>성별</strong></td>
								<td align="center" class="tableline11 white"><strong>주민번호</strong></td>								
								<td align="center" class="tableline11 white"><strong>기관명</strong></td>
								<td align="center" class="tableline21 white"><strong>직급명</strong></td>								
							</tr>
							
							<%= sbListHtml.toString() %>
							
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
