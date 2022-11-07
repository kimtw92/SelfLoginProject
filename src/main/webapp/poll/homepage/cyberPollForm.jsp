<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : cyberPoll관리 폼
// date : 2008-06-05
// auth : 정 윤철
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
	
	// ROW데이터
	DataMap rowMap = (DataMap)request.getAttribute("INQTTLROW_DATA");
	rowMap.setNullToInitialize(true);
	
	//시간
	StringBuffer hh = new StringBuffer();
	//분
	StringBuffer mi = new StringBuffer();
	
	
	for(int i=0; i < 24; i++){
		if(i < 10){
			hh.append("<option value=\"0"+i+"\"> 0"+i+ "</option>");			
			
		}else{
			hh.append("<option value=\""+i+"\"> "+ i +" </option>");			
			
		}

	}
	
	for(int i=0; i < 60; i++){
		if(i < 10){
			mi.append("<option value=\"0"+i+"\"> 0"+i+" </option>");			
			
		}else{
			mi.append("<option value=\""+i+"\">" + i + "</option>");			
			
		}

	}	
	
%>

<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->
<script language="JavaScript" type="text/JavaScript">
			
//타이틀 수정 실행
function go_modify(){
	
	if($("istartDate").value == ""){
		alert("설문시작일을 선택하여 주십시오.");
		return false;
	}
	
	if($("iendDate").value == ""){
		alert("설문 종료일을 선택하여 주십시오.");
		return false;
	}
	
	if(NChecker(document.pform)){
		var contents = getContents(); // naver 에디터에서 컨텐츠를 가지고 온다.
		
		if(contents == "<p>&nbsp;<\/p>" || contents == "<P>&nbsp;<\/P>") {
			alert("내용을 입력하세요");
			return;
		}
	
		if(confirm("수정 하시겠습니까?")){
		
			$("guideText").value = contents; // 컨트롤에 입력된 내용을 MIME 형식으로 Hidden Field에 입력하여 POST 방식으로 전송한다
		
			$("mode").value = "exec";
			$("qu").value = "titleInfoModify";
			pform.action = "/poll/homepage.do?mode=exec";
			pform.submit();
		}
	}
}

//타이틀 등록 실행
function go_insert(){

	if($("istartDate").value == ""){
		alert("설문시작일을 선택하여 주십시오.");
		return false;
	}
	
	if($("iendDate").value == ""){
		alert("설문 종료일을 선택하여 주십시오.");
		return false;
	}
	
	if(NChecker(document.pform)){		
// 		$("guideText").value = trim(wc.TextValue); //나모 폼 체크를하기 위해 값을 가져온다.
		var contents = getContents(); // naver 에디터에서 컨텐츠를 가지고 온다.
	
		if(contents == "<p>&nbsp;<\/p>" || contents == "<P>&nbsp;<\/P>") {
			alert("내용을 입력하세요");
			return;
		}
		
		if(confirm("등록 하시겠습니까?")){
		
			$("guideText").value = contents;
		
			$("mode").value = "exec";
			$("qu").value = "insertTitleInfo";
			pform.action = "/poll/homepage.do?mode=exec";
			pform.submit();
		}
	}	
}

	
//리스트
function go_list(){
	
	pform.action = "/poll/homepage.do";
	pform.submit();
}

//로딩시.
onload = function()	{
	/*
	설문시작일자, 종료일자가 있을경우 체크드 [s]
	*/
	var sdateHh = "<%=rowMap.getString("sdateHh")%>";	
	sdateHhLen = $("sdateHh").options.length
	for(var i=0; i < sdateHhLen; i++) {
	    if($("sdateHh").options[i].value == sdateHh){
	     	$("sdateHh").selectedIndex = i;
		 }
	}
	
	var edateHh = "<%=rowMap.getString("edateHh")%>";	
	edateHhLen = $("edateHh").options.length
	for(var i=0; i < sdateHhLen; i++) {
	    if($("edateHh").options[i].value == edateHh){
	     	$("edateHh").selectedIndex = i;
		 }
	}
	
	var edateMm = "<%=rowMap.getString("edateMm")%>";	
	edateMmLen = $("edateHh").options.length
	for(var i=0; i < sdateHhLen; i++) {
	    if($("edateMm").options[i].value == edateMm){
	     	$("edateMm").selectedIndex = i;
		 }
	}
	
	var sdateMm= "<%=rowMap.getString("sdateMm")%>";	
	sdateMmLen = $("sdateMm").options.length
	for(var i=0; i < sdateHhLen; i++) {
	    if($("sdateMm").options[i].value == sdateMm){
	     	$("sdateMm").selectedIndex = i;
		 }
	}
}
</script>

<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >
<form id="pform" name="pform" method="post" enctype="multipart/form-data">
<input type="hidden" name="mode" value="">
<input type="hidden" name="qu">
<!-- 메뉴아이디 -->
<input type="hidden" name="menuId" 	value="<%=requestMap.getString("menuId") %>">

<input type="hidden" name="titleNo" value="<%=requestMap.getString("titleNo") %>">
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
			<jsp:include page="/commonInc/include/commonAdminTitle.jsp" flush="false"/>
			<!--[e] 타이틀 -->

			<!--[s] subTitle -->
			<table width="100%" height="10"><tr><td></td></tr></table>
			<!--[e] subTitle -->

			<!--[s] content Form  -->
			<table cellspacing="0" cellpadding="0" border="0" width="100%" class="contentsTable">
				<tr>
					<td>
				<tr>
					<td>
			 <!---[s] content -->
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td>
									<table width="100%" border="0" cellpadding="0" cellspacing="0">
										<tr bgcolor="#375694">
											<td height="2" colspan="8"></td>
										</tr>
	
										<tr>
											<td align="center" height="28" class="tableline11" bgcolor="#E4EDFF" >
												<strong>설문주제</strong>
											</td>
											<td style="padding-left:10px" class="tableline21">
												<input type="text" name="title" value="<%=rowMap.getString("title") %>" maxlength="50" size="100" class="textfield" required="true!설문 주제를 입력하세요.">
											</td>
										</tr>
										<tr>
											<td  align="center" height="28" class="tableline11" bgcolor="#E4EDFF" >
												<strong>설문기간</strong>
											</td>
											<td style="padding-left:10px" class="tableline21">
												<input type="text" class="textfield" style="align:center" name="istartDate" value="<%=rowMap.getString("sdate") %>" readonly>
												<a href = "javascript:void(0)" onclick="fnPopupCalendar('pform', 'istartDate');">
													<img src = "/images/icon_calendar.gif" style="cousor:hand;" border = 0 align="absmiddle">
												</a>
												<select name="sdateHh"><%=hh.toString()%></select>시
												<select name="sdateMm"><%=mi.toString()%></select>분
												
												<input type="text" class="textfield" style="align:center" name="iendDate" value="<%=rowMap.getString("edate") %>" readonly>
												<a href = "javascript:void(0)" onclick="fnPopupCalendar('pform', 'iendDate');">
													<img src = "/images/icon_calendar.gif" style="cousor:hand;" border = 0 align="absmiddle">
												</a>
												<select name="edateHh"><%=hh.toString()%></select>시
												<select name="edateMm"><%=mi.toString()%></select>분
												
											</td>
										</tr>
										<tr>
											<td height="28" class="tableline11" bgcolor="#E4EDFF" align="center" width="15%">
												<strong>설문개요</strong>
											</td>
											<td class="tableline21" align="left">
												<!-- Namo Web Editor용 guideTexts -->
												<!-- 수정 컨텐츠 -->
													<input type="hidden" name="guideText" id="guideText" value='<%=StringReplace.convertHtmlEncodeNamo2(rowMap.getString("guideText"))%>'>
													<jsp:include page="/se2/SE2.jsp" flush="true" >
														<jsp:param name="contents" value='<%=StringReplace.convertHtmlEncodeNamo2(rowMap.getString("guideText"))%>'/>
													</jsp:include>

											</td>
										</tr>
									
										<tr bgcolor="#375694">
											<td height="2" colspan="8"></td>
										</tr>
										<tr>
											<td height="20" colspan="100%">
											</td>
										</tr>
										<tr>
											<td align='right' height="40" colspan="100%">
												<%if(requestMap.getString("qu").equals("modify")){ %>
													<input type=button value='수정' onClick="go_modify();" class=boardbtn1>
												<%}else {  %>
													<input type=button value='등록' onClick="go_insert();" class=boardbtn1>
												<%} %>
												<input type=button value=' 리스트 ' onClick="go_list()" class=boardbtn1>
												
											
										  </td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>	
		<!-- space -->
		<table width="100%" height="10"><tr><td></td></tr></table>
		<!--[e] content Form  -->
	                            
        </td>
    </tr>
</table>

<!--[s] bottom -->
<jsp:include page="/commonInc/include/commonAdminBottom.jsp" flush="false"/>
<!--[e] bottom -->
	
</form>
</body>




