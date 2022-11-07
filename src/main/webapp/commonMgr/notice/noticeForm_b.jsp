<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 시스템관리자 > 시스템관리 > 홈페이지 관리 > 개인공지 관리 등록/수정.
// date : 2008-05-23
// auth : LYM
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


	//사용자 정보 추출.
	LoginInfo loginInfo = (LoginInfo)request.getAttribute("LOGIN_INFO");

	//개인공지 상세 정보
	DataMap rowMap = (DataMap)request.getAttribute("ROW_DATA");
	rowMap.setNullToInitialize(true);

	//파일 정보
	String fileStr = "";
	DataMap fileMap = (DataMap)rowMap.get("FILE_GROUP_LIST");
	if(fileMap == null)
		fileMap = new DataMap();

	fileMap.setNullToInitialize(true);
	for(int i=0; i < fileMap.keySize("groupfileNo"); i++){
		if(!fileStr.equals(""))
			fileStr += "&nbsp;, &nbsp;";
		fileStr += fileMap.getString("fileName", i);
	}

%>

<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->

<script language="JavaScript" type="text/JavaScript">
<!--


//리스트
function go_list(){

	$("mode").value = "list";

	pform.action = "/commonMgr/notice.do";
	pform.submit();

}

//등록
function go_add(){

	$("mode").value = "exec";
	$("qu").value = "insert";

	if(confirm("등록 하시겠습니까?")){
		pform.action = "/commonMgr/notice.do";
		pform.encoding = "multipart/form-data";
		pform.submit();
	}

}

//수정
function go_modify(){

	$("mode").value = "exec";
	$("qu").value = "update";

	if(confirm("수정 하시겠습니까?")){
		pform.action = "/commonMgr/notice.do";
		pform.submit();
	}

}




//로딩시.
onload = function()	{



}

//-->
</script>

<!-- <SCRIPT LANGUAGE="VBS">
Sub OnLoading()
	document.all("FileUploadMonitor").UploadURL = "http://Localhost/DEXTUploadXSamples/Upload/PostScript.asp"
	document.all("FileUploadMonitor").Items = opener.document.all("FileUploadManager").Items
	document.all("FileUploadMonitor").Properties = opener.document.all("FileUploadManager").Properties
End Sub
</SCRIPT> -->
<!-- <SCRIPT LANGUAGE="VBS" for="FileUploadManager" event="OnTransfer_Click()"> 
	winstyle="height=355,width=445, status=no,toolbar=no,menubar=no,location=no"
	window.open "./FileUploadMonitor.htm",null,winstyle
</SCRIPT> -->

<!-- <body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" onload="OnLoading()" > -->
<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<form id="pform" name="pform" method="post">
<input type="hidden" name="menuId"				value="<%=requestMap.getString("menuId")%>">
<input type="hidden" name="mode"				value="<%=requestMap.getString("mode")%>">
<input type="hidden" name="currPage"			value='<%=requestMap.getString("currPage")%>'>
<input type="hidden" name="searchKey"			value='<%=requestMap.getString("searchKey")%>'>
<input type="hidden" name="searchValue"			value='<%=requestMap.getString("searchValue")%>'>

<input type="hidden" name="qu"					value='<%=requestMap.getString("qu")%>'>
<input type="hidden" name="seq"					value='<%=requestMap.getString("seq")%>'>

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


			<!--[s] Contents Form  -->
			<table cellspacing="0" cellpadding="0" border="0" width="100%" class="contentsTable">
				<tr>
					<td>
						<!---[s] content -->

						<!-- space --><table width="100%" height="10"><tr><td></td></tr></table>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td>
									<table width="100%" border="0" cellpadding="1" cellspacing="1" bgcolor="#D6DBE5">



										<tr bgcolor="#FFFFFF">
											<td height="28" class="tableline11 dkblue" bgcolor="#E4EDFF" width="15%" align="center"><strong>작성자</strong></td>
											<td class="tableline21" align="left" width="75%">&nbsp;<%=loginInfo.getSessName()%></td>
										</tr>

										<tr bgcolor="#FFFFFF">
											<td height="28" class="tableline11 dkblue" bgcolor="#E4EDFF" align="center"><strong>제목</strong></td>
											<td class="tableline21" align="left" width="75%">&nbsp;
												<input type="text" class="textfield" name="title" value="<%=rowMap.getString("title")%>" style="width:50%">
											</td>
										</tr>

										<tr bgcolor="#FFFFFF">
											<td height="28" class="tableline11 dkblue" bgcolor="#E4EDFF" align="center"><strong>구분</strong></td>
											<td class="tableline21" align="left" width="75%">&nbsp;
												<input type="radio" class="textfield" name="notiGubun" id="notiGubun1" value="P" <%=!rowMap.getString("notiGubun").equals("G") ? "checked" : ""%>><label for="grgubun1">개인공지</label>
												<input type="radio" class="textfield" name="notiGubun" id="notiGubun2" value="G" <%=rowMap.getString("notiGubun").equals("G") ? "checked" : ""%>><label for="grgubun2">그룹공지</label>
											</td>
										</tr>

										<tr bgcolor="#FFFFFF">
											<td height="28" class="tableline11 dkblue" bgcolor="#E4EDFF" align="center"><strong>검색</strong></td>
											<td class="tableline21" align="left" width="75%">&nbsp;
												<%=rowMap.getString("notiPartName")%>
											</td>
										</tr>

										<tr bgcolor="#FFFFFF">
											<td height="28" class="tableline11 dkblue" bgcolor="#E4EDFF" align="center"><strong>내용</strong></td>
											<td class="tableline21" align="left" width="75%">
												<textarea name='content' class="textfield" style="width:95%;height:100px"><%=rowMap.getString("content")%></textarea>
											</td>
										</tr>

										<tr bgcolor="#FFFFFF">
											<td height="28" class="tableline11 dkblue" bgcolor="#E4EDFF" align="center"><strong>첨부파일</strong></td>
											<td class="tableline21" align="left" width="75%">&nbsp;
												<%=fileStr%>

												<br><input type="file" class="textfield" name="DEXTUploadX" value="" style="width:50%">
												<br><input type="file" class="textfield" name="DEXTUploadX" value="" style="width:50%">

												<br><input type="text" class="textfield" name="test_text" value="" style="width:50%">
												<br><input type="text" class="textfield" name="test_text" value="" style="width:50%">


												<!-- dextUploadX -->
												<!-- <OBJECT id=FileUploadMonitor CodeBase="http://localhost:8080/commonInc/dextUploadX/DEXTUploadX.cab#version=2,5,1,0" height="355" width="445" classid="CLSID:96A93E40-E5F8-497A-B029-8D8156DE09C5"
												VIEWASTEXT>
												</OBJECT> -->

<!-- 												<OBJECT id="FileUploadManager" codeBase="http://localhost:8080/commonInc/dextUploadX/DEXTUploadX.cab#version=2,5,1,0" height="200" width="450" classid="CLSID:DF75BAFF-7DD5-4B83-AF5E-692067C90316" VIEWASTEXT>
												</OBJECT>  -->



											</td>
										</tr>



									</table>


								</td>
							</tr>

						</table>

						<!-- space --><table width="100%" height="10"><tr><td></td></tr></table>
						<table width="100%" border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td width="100%" align="right">
								<%if(requestMap.getString("qu").equals("insert")){%>
									<input type="button" class="boardbtn1" value=' 등록 ' onClick="go_add();">
								<%}else if(requestMap.getString("qu").equals("update")){%>
									<input type="button" class="boardbtn1" value=' 수정 ' onClick="go_modify();" >
								<%}%>
									<input type="button" class="boardbtn1" value='리스트' onClick="go_list();" >
								</td>
							</tr>
						</table>

						<!---[e] content -->
                        
					</td>
				</tr>
			</table>
			<!--[e] Contents Form  -->

			<!-- space --><table width="100%" height="30"><tr><td></td></tr></table>
				                            
        </td>
    </tr>
</table>

<!--[s] bottom -->
<jsp:include page="/commonInc/include/commonAdminBottom.jsp" flush="false"/>
<!--[e] bottom -->
	
</form>
</body>

