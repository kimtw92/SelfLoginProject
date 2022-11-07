<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 미제출자관리 리스트
// date  : 2008-08-05
// auth  : 최형준
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
	

	if( !requestMap.getString("commGrcode").equals("") &&
		!requestMap.getString("commGrseq").equals("")){
		// 반 리스트
		DataMap classListMap = (DataMap)request.getAttribute("CLASS_LIST");
		if(classListMap == null) classListMap = new DataMap();
		classListMap.setNullToInitialize(true);			
		
		
	}
	
	//리스트
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	listMap.setNullToInitialize(true);
		
	String listStr = "";
		
	for(int i=0; i<listMap.keySize("grcode"); i++){
		listStr += "<tr height='23'>";
			listStr += "<td align='center'>회</td>";
			listStr += "<td align='left'>&nbsp;&nbsp;"+listMap.getString("title",i)+"</td>";
			listStr += "<td align='center'>&nbsp;"+listMap.getString("rpartf",i)+"차시~"+listMap.getString("rpartt",i)+"차시</td>";
			listStr += "<td align='center'>&nbsp;"+listMap.getString("point",i)+"</td>";
			listStr += "<td align='center'>&nbsp;</td>";
			listStr += "<td align='center'><INPUT TYPE='button' value='문자 보내기' class='boardbtn1' onClick='javascript:send_sms('{.subj}', '{.grcode}', '{.grseq}', '{.classno}', '{.dates}');'></td>";
		listStr += "</tr>";
	}

	if( listMap.keySize("grcode") <= 0){

		listStr += "<tr bgColor='#FFFFFF'>";
		listStr += "<td align='center' class='tableline21' colspan='100%' height='100'>등록된 과정코드가 없습니다.</td>";
		listStr += "</tr>";

	}

%>

<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->


<script language="JavaScript">
<!--
	//comm Selectbox선택후 리로딩 되는 함수.
	function go_reload(){
		go_list();
	}

	//리스트
	function go_list(){
	
		$("mode").value = "list";
	
		pform.action = "/subjMgr/report.do";
		pform.submit();
	
	}
//-->
</script>
<script for="window" event="onload">
<!--
	var commYear = "<%= requestMap.getString("commYear") %>";
	var commGrCode = "<%= requestMap.getString("commGrcode") %>";
	var commGrSeq = "<%= requestMap.getString("commGrseq") %>";
	var commSubj = "<%= requestMap.getString("commSubj") %>";
	var commClass="<%= requestMap.getString("commClass")%>";
		
	var reloading = ""; 

	getCommYear(commYear);														// 년도
	getCommOnloadGrCode(reloading, commYear, commGrCode);						// 과정
	getCommOnloadGrSeq(reloading, commYear, commGrCode, commGrSeq);				// 기수
//-->
</script>

<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<form id="pform" name="pform" method="post" >
<input type="hidden" name="menuId"				value="<%=requestMap.getString("menuId")%>">
<input type="hidden" name="mode"				value="<%=requestMap.getString("mode")%>">
<input type="hidden" name="grseq"				value="<%=requestMap.getString("grseq")%>">
<input type="hidden" name="subj"				value="<%=requestMap.getString("subj")%>">


<!-- 페이징용 -->
<input type="hidden" name="currPage" 	id="currPage"	value="<%//= requestMap.getString("currPage")%>">
<%=request.getAttribute("CLASS_LIST") %>
<%=request.getAttribute("LIST_DATA") %>
<%=request.getAttribute("dataListMap") %>
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

			<!-- subTitle -->
			<!-- space --><table width="100%" height="10"><tr><td></td></tr></table>
			<table width="100%" border="0" cellspacing="0" cellpadding="0" class="contentsSubTitleTable">
			<tr>
				<td height="20">
					<img src="/images/bullet003.gif" width="11" height="11" align="bottom">&nbsp;<strong>과제물 리스트</strong>
				</td>
			</tr>
			</table>
			<!--// subTitle -->
			
			<!--[s] Contents -->   			                            
			<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" class="contentsTable" >								
			<tr>
				<td>
				<table width="90%" border="0" cellspacing="0" cellpadding="0" height='80' align='center'>
					<TR>
						<TD><!--[s] 검색 -->
						<br>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr bgcolor="#375694"><td height="2" colspan="100%"></td></tr>
							<tr height="28" bgcolor="F7F7F7" >
								<td width="80" align="center" class="tableline11"><strong>년 도</strong></td>
								<td align="left" class="tableline11" bgcolor="#FFFFFF" style="padding:0 0 0 9">
									<div id="divCommYear" class="commonDivLeft">										
										<select name="commYear" onChange="getCommGrCode('subj');" style="width:100px;font-size:12px">
											<option value="">**선택하세요**</option>
										</select>
									</div>					
								</td>
								<td width="80" align="center" class="tableline11"><strong>과 정</strong></td>
								<td align="left" class="tableline11" bgcolor="#FFFFFF" style="padding:0 0 0 9">
									<div id="divCommGrCode" class="commonDivLeft">
										<select name="commGrcode" style="width:250px;font-size:12px">
											<option value="">**선택하세요**</option>
										</select>
									</div>
								</td>
							</tr>
							<tr height="28" bgcolor="F7F7F7">
								<td align="center" class="tableline11"><strong>기 수</strong></td>
								<td align="left" class="tableline11" bgcolor="#FFFFFF" style="padding:0 0 0 9">
									<div id="divCommGrSeq" class="commonDivLeft">
										<select name="commGrseq" style="width:100px;font-size:12px">
											<option value="">**선택하세요**</option>
										</select>
									</div>
								</td>								
								<td align="center" class="tableline11"><strong>반</strong></td>
								<td align="left" class="tableline11" bgcolor="#FFFFFF" style="padding:0 0 0 9">
									<div id="divCommClass" class="commonDivLeft">
										<select name="commClass" style="width:150px;font-size:12px" onchange="go_reload()">
											<option value="">**선택하세요**</option>
											<option value="1">1</option>
											<option value="2">2</option>
											<option value="3">3</option>											
										</select>
									</div>
								</td>								
							</tr>														
							<tr bgcolor="#375694"><td height="2" colspan="100%"></td></tr>
						</table>
						<!--[e] 검색 -->
						</TD>
					</TR>
				</TABLE>
				</td>
			</tr>
			<tr><td height="10"></td></tr>
			<tr>
				<td>
					<TABLE width="100%" border="0" align="center" cellpadding="0" cellspacing="0" >
					<tr  bgcolor="#375694" ><td colspan="6"  height="2" ></td></tr>
						<tr height="28"  bgcolor="#5071B4">					
							<td width='8%' align='center' class="tableline11 white"><strong>회차</strong></td>
							<td width="40%" align='center' class="tableline11 white"><strong>제목</strong></td>
							<td width="22%" align='center' class="tableline11 white"><strong>과제물 범위</strong></td>
							<td width="9%" align='center' class="tableline11 white"><strong>배점</strong></td>
							<td width="12%" align='center' class="tableline11 white"><strong>출제여부</strong></td>
							<td width="9%" align='center' class="tableline11 white"><strong>비고</strong></td>
						</tr>
						
						<%= listStr %>
					</table>
				</td>
			</tr>								
			</table>
			<!--[e] Contents -->
		        </td>
		    </tr>
		</table>

<!--[s] bottom -->
<jsp:include page="/commonInc/include/commonAdminBottom.jsp" flush="false"/>
<!--[e] bottom -->

</form>
</body>