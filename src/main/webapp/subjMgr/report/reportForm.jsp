<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 레포트관리폼
// date : 2008-07-22
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
	
	//리스트 데이터
	DataMap rowMap = (DataMap)request.getAttribute("LIST_DATA");
	rowMap.setNullToInitialize(true);
	
	//강사명 데이터
	DataMap tutorMap = (DataMap)request.getAttribute("TUTORROW_DATA");
	tutorMap.setNullToInitialize(true);

	//차시  데이터
	DataMap datesMap = (DataMap)request.getAttribute("DATES_DATA");
	datesMap.setNullToInitialize(true);
	
	
	
	//파일 정보 START
	String fileStr = "";
	String tmpStr = ""; //넘어가는 값.
	
	String totalSubmstDate  = "";
	String totalRepinsDate = "";
	String totalSubmedDate = "";
	if(requestMap.getString("qu").equals("modify")){
		//출제일
		String[] repinsDate = rowMap.getString("repinsDate").split("-");
		String repinsDate1 = repinsDate[0];
		String repinsDate2 = repinsDate[1];
		String repinsDate3 = repinsDate[2];
		totalRepinsDate = repinsDate1 + repinsDate2 + repinsDate3;
		
		//제출일시작일
		// out.println(rowMap.getString("submstDate"));
		String[] submstDate = rowMap.getString("submstDate").split("-");
		String submstDate1 = submstDate[0];
		String submstDate2 = submstDate[1];
		String submstDate3 = submstDate[2];
		totalSubmstDate = submstDate1 + submstDate2 + submstDate3;
		
		//제출 마지막일  SUBMED_TIME
		// out.println(rowMap.getString("submedDate"));
		String[] submedDate = rowMap.getString("submedDate").split("-");
		String submedDate1 = submedDate[0];
		String submedDate2 = submedDate[1];
		String submedDate3 = submedDate[2];
		totalSubmedDate = submedDate1 + submedDate2 + submedDate3;
		// out.println(totalSubmedDate);
		DataMap fileMap = (DataMap)rowMap.get("FILE_GROUP_LIST");
		if(fileMap == null)
			fileMap = new DataMap();
		fileMap.setNullToInitialize(true);
		for(int i=0; i < fileMap.keySize("groupfileNo"); i++){
			
			if(fileMap.getInt("groupfileNo", i)==0){
				continue;
			}
			
			tmpStr = fileMap.getString("groupfileNo", i) + "#" + fileMap.getString("fileNo", i); 
// 			fileStr += "document.InnoDS.AddTempFile('" + fileMap.getString("fileName", i) + "', " + fileMap.getInt("fileSize", i) + ", '" + tmpStr + "');";
// 			fileStr += "g_ExistFiles['" + tmpStr + "'] = false;";

            fileStr += "var input"+i+" = document.createElement('input');\n";
			fileStr += "input"+i+".value='"+fileMap.getString("fileName", i)+"';\n";
			fileStr += "input"+i+".setAttribute('fileNo', '"+tmpStr+"');\n";
			fileStr += "input"+i+".name='existFile';\n";
			fileStr += "multi_selector.addListRow(input"+i+");\n\n";

		}
	
	}
	

	

	
	StringBuffer time = new StringBuffer();
	//시간
	for(int i=1; i < 24; i++){
		if(i < 10){
			time.append("<option value=\"0"+i+"\">0"+i+"</option>");
		}else{
			time.append("<option value=\""+i+"\">"+i+"</option>");	
		}
	}
	
	StringBuffer tutorName = new StringBuffer();
	
	if(tutorMap.keySize("tuserno") > 0){
		//과제출제강사명
		for(int i = 0; tutorMap.keySize("tuserno") > i; i++){
			tutorName.append("<option value=\""+tutorMap.getString("tuserno",i)+"\">"+tutorMap.getString("name", i)+"</option>");
			
		}
	}else{
		tutorName.append("<option value=\"\">출제 강사가 없습니다.</option>");
	}
	
	StringBuffer dates = new StringBuffer();
	//차시
	for(int i = 0; datesMap.keySize() > i; i++){
		dates.append("<option value=\""+datesMap.getString("dates",i)+"\">"+datesMap.getString("dates", i)+"차시</option>");
	}	
	
%>

<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->

<script language="JavaScript" type="text/JavaScript">

//수정시 inno에 기존 파일 넣은 변수 및 함수.
var g_ExistFiles = new Array();
function OnInnoDSLoad(){


}

window.onload = function(){
	<%= fileStr %>
	
}

</script>
<script language="JavaScript">
<!--
function go_save(qu){
	if($("repinsDate").value > $("submstDate").value || $("repinsDate").value > $("submedDate").value){
		alert("제출일이 출제일보다 빠릅니다. 다시 입력하여 주십시오.");
		return false;
		
	}else if($("submstDate").value > $("submedDate").value){
		alert("제출 마지막 날자가 시작일보다 빠릅니다. 다시 입력하여 주십시오.");
		return false;
	}

	if(NChecker($("pform"))){
		if(confirm("저장 하시겠습니까?")){
		 	var contents = getContents();
			$("content").value = trim(contents);
		
		    if(contents == "<p>&nbsp;<\/p>" || contents == "<P>&nbsp;<\/P>") {
				alert("내용을 입력하세요");
				return;
			}
		    
			$("content").value = contents; // 컨트롤에 입력된 내용을 MIME 형식으로 Hidden Field에 입력하여 POST 방식으로 전송한다
			$("mode").value="exec";
			$("qu").value=qu;
			pform.action = "/subjMgr/report.do?mode=exec";
			pform.submit();
		}
	}
}

//리스트페이지 이동
function go_list(){
	//전페이지에 넘어온 곳을 찾기위해서 urlGubun값을 기준으로 다시 되돌아간다.
	$("mode").value="<%=requestMap.getString("urlGubun")%>";
	pform.action = "/subjMgr/report.do?mode=<%=requestMap.getString("urlGubun")%>";
	pform.submit();
}

//-->
</script>
<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<form id="pform" name="pform" method="post" enctype="multipart/form-data">
<input type="hidden" name="mode" value="">
<input type="hidden" name="qu">

<!-- 현재 과제물에대한 기본 정보 모음 -->
<input type="hidden" name="subj" value="<%=requestMap.getString("subj")%>">
<input type="hidden" name="grcode" value="<%=requestMap.getString("grcode")%>">
<input type="hidden" name="grseq" value="<%=requestMap.getString("grseq")%>">
<input type="hidden" name="classno" value="<%=requestMap.getString("classno")%>">
<input type="hidden" name="dates" value="<%=requestMap.getString("dates")%>">
<input type="hidden" name="year" value="<%=requestMap.getString("year")%>">
<input type="hidden" name="luserno" value="<%=memberInfo.getSessNo()%>">
<!-- 과제물평가관리와 출제 관리에서 수정하였을때에 자신이 온곳으로리턴시켜주기위한 구분값 -->
<input type="hidden" name="urlGubun" value="<%=requestMap.getString("urlGubun") %>">
<!-- 메뉴아이디 -->
<input type="hidden" name="menuId" 	value="<%=requestMap.getString("menuId") %>">

<!-- INNO FILEUPLOAD 사용시 UPLOAD 경로 지정해줌.-->
<input type="hidden" name="INNO_SAVE_DIR"		value='<%=Constants.UPLOADDIR_REPORT%>'>

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
						<img src="/images/bullet003.gif"  align="bottom">&nbsp;<strong> 과제물 <%=requestMap.getString("qu").equals("modify") ? "수정" : "등록"%></strong>
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
									<table width="100%" border="0" bordercolor="" cellpadding="0" cellspacing="0">
										<tr bgcolor="#375694">
											<td height="2" colspan="8"></td>
										</tr>
										
										<tr>
											<td style="TEXT-ALIGN:center;padding:0 0 0 0" class="tableline11" width="150" bgcolor="#E4EDFF" height="28" ><strong>제목</strong></td>
											<td class="tableline21" colspan="3" style="padding-left:10px">
												<input name="title" type="text" size="80" class="textfield" maxlength="60" value="<%=rowMap.getString("title")%>" required="true!제목을입력하십시오">
											</td>
										</tr>
										
										<tr>
											<td colspan="100%">
												<table width="100%" border="0" bordercolor="" cellpadding="0" cellspacing="0">
													<tr>
														<td align="center" class="tableline11"  height="28" bgcolor="#E4EDFF" width="150"><strong>과제물 범위</strong></td>
														<td class="tableline11" style="padding-left:10px" width="150">
															<select name=rpartf>
															<%=dates %> 
															</select>
																~
															<select name="rpartt">
															<%=dates %>
															</select>
														</td>
														
														<td class="tableline11" align="center" bgcolor="#E4EDFF" width="150"><strong>출제강사</strong></td>
														<td class="tableline21" style="padding-left:10px">
															<select name="tutorName">
															<%=tutorName.toString() %>
															</select>
														</td>
													</tr>
												</table>
											</td>
										</tr>
										
										<tr>
											<td align="center" class="tableline11" bgcolor="#E4EDFF"><strong>출제일</strong></td>
										 	<td colspan="3" class="tableline21" style="padding-left:10px"><input type="text" size="8" required="true!출제일을 입력하십시오." readonly name="repinsDate" class="textfield" value="<%=totalRepinsDate%>">
										 	<img style="cursor:hand" onclick="fnPopupCalendar('pform','repinsDate');" src="../images/icon_calen.gif" alt="" />
										 	</td>
										</tr>
											
	
	
										
										<tr>
											<td align="center" class="tableline11" bgcolor="#E4EDFF"><strong>제출일</strong></td>
										 	<td colspan="4" class="tableline21" style="padding-left:10px">
										 		<input type="text" name="submstDate" size="8" required="true!출제 시작일을 입력하십시오." readonly class="textfield" value="<%=totalSubmstDate %>">
												<img style="cursor:hand" onclick="fnPopupCalendar('pform','submstDate');" src="../images/icon_calen.gif" alt="" />
										 		
										 		<select name="submstTime">
										 		<%=time.toString() %>
												</select>
												 ~
 										 		<input type="text" name="submedDate" size="8" required="true!출제 마지막일을 입력하십시오." readonly class="textfield" value="<%=totalSubmedDate %>">
												<img style="cursor:hand" onclick="fnPopupCalendar('pform','submedDate');" src="../images/icon_calen.gif" alt="" />
										 		
										 		<select name="submedTime">
										 		<%=time.toString() %>
												</select>
												
										 	</td>
										</tr>
										<tr>
											<td height="28" class="tableline11" bgcolor="#E4EDFF" align="center">
												<strong>내 용</strong>
											</td>
											<td class="tableline21" align="left" colspan="3">
												<!-- 수정 컨텐츠 -->
												<input type="hidden" name="content" id="content" value='<%=StringReplace.convertHtmlEncodeNamo2(rowMap.getString("content"))%>'>
												
												<!-- 스마트 에디터 -->
												<jsp:include page="/se2/SE2.jsp" flush="true" >
													<jsp:param name="contents" value='<%=StringReplace.convertHtmlEncodeNamo2(rowMap.getString("content"))%>'/>
												</jsp:include>

											</td>
										</tr>
										<tr >
											<td height="28" class="tableline11" bgcolor="#E4EDFF" align="center" width="">
												<strong>출제<br>파일</strong>
											</td>
											<td class="tableline21" align="left" colspan="3">&nbsp;

                               				<jsp:include page="/fileupload/multplFileSelector.jsp" flush="true"/>

											</td>
										</tr>	
																				
										<tr bgcolor="#375694">
											<td height="2" colspan="8"></td>
										</tr>
										<tr>
											<td height="20" colspan="100%"></td>
										</tr>
										<tr>
											<td align='right' height="40" colspan="100%">

												<input type=button value=' 완료' onClick="go_save('<%=requestMap.getString("qu") %>');" class=boardbtn1>
												<input type=button value=' 리스트 ' onClick="go_list();" class=boardbtn1>
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
	//차시 셀렉티드
	var rpartf = "<%=rowMap.getString("dates")%>";
	rpartflen = $("rpartf").options.length;

	for(var i=0; i < rpartflen; i++) {
		if($("rpartf").options[i].value == rpartf){
			$("rpartf").selectedIndex = i;
		 }
 	 }
 	 
 	//차시 셀렉티드
	var rpartt = "<%=rowMap.getString("dates")%>";
	rparttLen = $("rpartt").options.length;

	for(var i=0; i < rparttLen; i++) {
		if($("rpartt").options[i].value == rpartt){
			$("rpartt").selectedIndex = i;
		 }
 	 }


 	//강사명셀렉티드
	var tutorName = "<%=tutorMap.getString("tuserno")%>";
	tutorNameLen = $("tutorName").options.length;

	for(var i=0; i < tutorNameLen; i++) {
		if($("tutorName").options[i].value == tutorName){
			$("tutorName").selectedIndex = i;
		 }
 	 }
 	
 	
 	 //출제 시작시간
	var submstTime = "<%=rowMap.getString("submstTime")%>";
	submstTimeLen = $("submstTime").options.length;

	for(var i=0; i < submstTimeLen; i++) {
		if($("submstTime").options[i].value == submstTime){
			$("submstTime").selectedIndex = i;
		 }
 	 } 
 	 
 	//출제 마지막시간
	var submedTime = "<%=rowMap.getString("submedTime")%>";
	submedTimeLen = $("submedTime").options.length;

	for(var i=0; i < submedTimeLen; i++) {
		if($("submedTime").options[i].value == submedTime){
			$("submedTime").selectedIndex = i;
		 }
 	 } 
</script>
