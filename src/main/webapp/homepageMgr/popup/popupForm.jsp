<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 팝업 폼 
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
	
	//팝업관리 ROW데이터
	DataMap rowMap = (DataMap)request.getAttribute("FORMROW_DATA");
	rowMap.setNullToInitialize(true);
	
	StringBuffer pstr = new StringBuffer();
	for(int i=0; i <= 23; i++){
		String nowTime = "";
		String strSelected = "";
		if (i <10){
			nowTime = "0"+i;
		} else {
			nowTime = ""+i;
		}
		if (nowTime.equals(rowMap.getString("pstrDateh"))){
			strSelected = "selected";
		} 
		pstr.append("<option value=\""+i+"\" "+strSelected+" >"+i+"</option>");
	}
	
	StringBuffer estr = new StringBuffer();
	for(int i=1; i <= 24; i++){
		String nowTime = "";
		String strSelected = "";
		if (i <10){
			nowTime = "0"+i;
		} else {
			nowTime = ""+i;
		}
		if (nowTime.equals(rowMap.getString("pendDateh"))){
			strSelected = "selected";
		} 
		estr.append("<option value=\""+i+"\" "+strSelected+" >"+i+"</option>");
	}

%>

<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->

<script language="JavaScript" type="text/JavaScript">

//등록, 수정
function go_save(qu){

	if($("title").value == ""){
		alert("이벤트 제목을 입력하십시오.");
		return false;
	}
	
	if($("pstrDate").value == ""){
		alert("시작일을 선택하십시오.");
		return false;
	}else if($("pendDate").value == ""){
		alert("종료일을 선택하십시오.");
		return false;
	}else if($("pstrDate").value > $("pendDate").value ){
		alert("시작일이 종료일보다 작습니다. 다시 선택하십시오.");
		return false;
	}
	
	var popupWidth = $("popupWidth").value;
	var popupHeight = $("popupHeight").value;
	var popupLeft = $("popupLeft").value;
	var popupTop = $("popupTop").value;	

	//창폭 숫자 체크
	if(isNum(popupWidth, "창폭을") == false){
		$("popupWidth").value = "";
		$("popupWidth").focus();
		return false;
	}
	
	//창높이 체크
	if(isNum(popupHeight, "창높이를") == false){
		$("popupHeight").value = "";
		$("popupHeight").focus();
		return false;
	}
	
	//시작가로위치
	if(isNum(popupLeft, "시작 가로 위치를") == false){
		$("popupLeft").value = "";
		$("popupLeft").focus();
		return false;
	}
	
	//창폭 숫자 체크
	if(isNum(popupTop, "시작 세로 위치를") == false){
		$("popupTop").value = "";
		$("popupTop").focus();
		return false;
	}
	
 	var contents = getContents();

		<%if(requestMap.getString("qu").equals("insert")){%>
		if(confirm("등록 하시겠습니까?")){
			
		<%} else if(requestMap.getString("qu").equals("modify")){%>
		if(confirm("수정 하시겠습니까?")){
		
		<%} %>
		
		$("content").value = contents; // 컨트롤에 입력된 내용을 MIME 형식으로 Hidden Field에 입력하여 POST 방식으로 전송한다
	
		$("mode").value = "exec";
		$("qu").value = qu;
		pform.action = "/homepageMgr/popup.do?mode=exec";
		pform.submit();
	}
}
function go_delete(){
	if(confirm("삭제하시겠습니까?")){
		$("mode").value = "exec";
		$("qu").value = "delete";
		pform.action = "/homepageMgr/popup.do?mode=exec";
		pform.submit();
	}
}	
//리스트
function go_list(){
	$("mode").value = "list";
	pform.action = "/homepageMgr/popup.do";
	pform.submit();
}

//로딩시.
onload = function()	{

}
</script>

<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >
<form id="pform" name="pform" method="post" enctype="multipart/form-data">
<input type="hidden" name="mode" value="bbsBoardList">
<input type="hidden" name="qu">
<!-- 메뉴아이디 -->
<input type="hidden" name="menuId" 	value="<%=requestMap.getString("menuId") %>">
<!-- no-->
<input type="hidden" name="no" 	value="<%=requestMap.getString("no") %>">

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
			<table width="100%" border="0" cellspacing="0" cellpadding="0" class="contentsSubTitleTable">			
				<tr>
					<td height="20">
						<img src="/images/bullet003.gif"  align="bottom">&nbsp;<Strong>팝업쓰기</Strong>
					</td>
				</tr>
			</table>
			<!--[e] subTitle -->

			<!--[s] Contents Form  -->
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
											<td  align="center" height="28" width="10%" class="tableline11" bgcolor="#E4EDFF" >
												<strong>이벤트 제목</strong>
											</td>
											<td style="padding-left:10px" class="tableline21">
												<input type="text" class="textfield" name="title" maxlength="50" onkeypress="if(event.keyCode==13){go_save();return false;}" value="<%=rowMap.getString("title") %>" size="100">
											</td>
										</tr>
										<tr>
											<td  align="center" height="28" class="tableline11" bgcolor="#E4EDFF" >
												<strong>이벤트 <br>시작일</strong>
											</td>
											<td style="padding-left:10px" class="tableline21">
												<input  style="cursor: hand;" size="10" class="textfield" type="text" name="pstrDate" onclick="fnPopupCalendar('pform','pstrDate');" value="<%=requestMap.getString("pstrDate") %>" readonly>
												<img style="cursor: hand;" onclick="fnPopupCalendar('pform','pstrDate');" src = "/images/icon_calendar.gif" border = 0 align = absmiddle>
												<select name="pstrDateh"><%=pstr%></select>시
											</td>
										</tr>
										<tr>
											<td  align="center" height="28" class="tableline11" bgcolor="#E4EDFF" >
												<strong>이벤트 <br>종료일</strong>
											</td>
											<td style="padding-left:10px" class="tableline21">
												<input style="cursor: hand;" size="10" class="textfield" onclick="fnPopupCalendar('','pendDate');" type="text" name="pendDate" value="<%=requestMap.getString("pendDate") %>" readonly>
												<img style="cursor: hand;" onclick="fnPopupCalendar('','pendDate');" src = "/images/icon_calendar.gif" border = 0 align = absmiddle>
												<select name="pendDateh"><%=estr%></select>시
											</td>
										</tr>
										
										<tr>
											<td height="28" class="tableline11" bgcolor="#E4EDFF" align="center" width="15%">
												<strong>이벤트  내용</strong>
											</td>
											<td class="tableline21" align="left">
												<!-- Namo Web Editor용 Contents -->
												<!-- 수정 컨텐츠 -->
													<input type="hidden" name="content" id="content" value='<%= StringReplace.convertHtmlEncodeNamo2(rowMap.getString("content"))%>'>
												
													<!-- 스마트 에디터 -->
													<jsp:include page="/se2/SE2.jsp" flush="true" >
														<jsp:param name="contents" value='<%= StringReplace.convertHtmlEncodeNamo2(rowMap.getString("content"))%>'/>
													</jsp:include>

											</td>
										</tr>
										<tr>
											<td align="center" height="28" class="tableline11" bgcolor="#E4EDFF" >
												<strong>창 폭</strong>
											</td>
											<td style="padding-left:10px" class="tableline21">
												<input type="text" class="textfield" maxlength="4" name="popupWidth" value="<%=rowMap.getString("popupWidth") %>">
											</td>
										</tr>
										<tr>
											<td align="center" height="28" class="tableline11" bgcolor="#E4EDFF" >
												<strong>창 높이</strong>
											</td>	
											<td style="padding-left:10px" class="tableline21">
												<input type="text" class="textfield" maxlength="4" name="popupHeight" value="<%=rowMap.getString("popupHeight") %>">
											</td>
										</tr>
										<tr>
											<td align="center" height="28" class="tableline11" bgcolor="#E4EDFF" >
												<strong>시작 <br>가로 위치</strong>
											</td>
											<td style="padding-left:10px" class="tableline21">
												<input type="text" class="textfield" maxlength="4" name="popupLeft" value="<%=rowMap.getString("popupLeft") %>">
											</td>
										</tr>
										<tr>
											<td align="center" height="28" class="tableline11" bgcolor="#E4EDFF" >
												<strong>시작 <br>세로 위치</strong>
											</td>
											<td style="padding-left:10px" class="tableline21">
												<input type="text" class="textfield" maxlength="4" name="popupTop" value="<%=rowMap.getString("popupTop") %>">
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
												<%if(requestMap.getString("qu").equals("insert")){ %>
													<input type=button value='등록' onClick="go_save('<%=requestMap.getString("qu") %>');" class=boardbtn1>
												<%}else{ %>
													<input type=button value='수정' onClick="go_save('<%=requestMap.getString("qu") %>');" class=boardbtn1>
												<%} %>
												<%if(!requestMap.getString("qu").equals("insert")){ %>
													<input type=button value='삭제' onClick="go_delete()" class=boardbtn1>
												<%} %>
												<input type=button value='목록' onClick="go_list()" class=boardbtn1>
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
		<!--[e] Contents Form  -->
	                            
        </td>
    </tr>
</table>

<!--[s] bottom -->
<jsp:include page="/commonInc/include/commonAdminBottom.jsp" flush="false"/>
<!--[e] bottom -->
	
</form>
</body>
<script language="JavaScript" type="text/JavaScript">
	//시작일
	var pstrDateh = "<%=rowMap.getString("pstrDateh")%>";
	pstrDatehLen = $("pstrDateh").options.length
	
	for(var i=0; i < pstrDatehLen; i++) {
		if($("pstrDateh").options[i].value == pstrDateh){
			$("pstrDateh").selectedIndex = i;
		 }
 	 }
 	 
 	//종료일
	var pendDateh = "<%=rowMap.getString("pendDateh")%>";
	pendDatehLen = $("pendDateh").options.length
	
	for(var i=0; i < pendDatehLen; i++) {
		if($("pendDateh").options[i].value == pendDateh){
			$("pendDateh").selectedIndex = i;
		 }
 	 }
 	 
</script>



