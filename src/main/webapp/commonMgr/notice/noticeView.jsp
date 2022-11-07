<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 시스템관리자 > 시스템관리 > 홈페이지 관리 > 개인공지 관리 보기.
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


	//개인공지 상세 정보
	DataMap rowMap = (DataMap)request.getAttribute("ROW_DATA");
	rowMap.setNullToInitialize(true);

	//파일 정보
	String fileStr = "";
	String tmpStr = "";
	DataMap fileMap = (DataMap)rowMap.get("FILE_GROUP_LIST");
	if(fileMap == null)
		fileMap = new DataMap();
	fileMap.setNullToInitialize(true);
	
	for(int i=0; i < fileMap.keySize("groupfileNo"); i++){
		if(!fileStr.equals(""))
			fileStr += "&nbsp;, &nbsp;";

		tmpStr = "javascript:fileDownload("+ fileMap.getInt("groupfileNo", i) + ", "+ fileMap.getInt("fileNo", i) +");";
		fileStr += "<a href=\"" + tmpStr + "\"><b>"+fileMap.getString("fileName", i)+"</b></a>";
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
	$("qu").value = "";	
	pform.action = "/commonMgr/notice.do";
	pform.submit();

}


//수정
function go_modify(){

	$("mode").value = "form";
	$("qu").value = "update";

	pform.action = "/commonMgr/notice.do";
	pform.submit();

}

//삭제
function go_delete(){

	if(confirm("삭제하시겠습니까?")){

		$("mode").value = "exec";
		$("qu").value = "delete";
		pform.action = "/commonMgr/notice.do";
		pform.submit();

	}


}

//로딩시.
onload = function()	{


}

//-->
</script>
<!-- <script language="JavaScript" src="/AIViewer/AIScript.js"></script>-->

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
											<td class="tableline21" align="left" width="75%">&nbsp;
												<%=rowMap.getString("username")%>&nbsp;(<%=rowMap.getString("wuserno")%>)
											</td>
										</tr>
										<tr bgcolor="#FFFFFF">
											<td height="28" class="tableline11 dkblue" bgcolor="#E4EDFF" align="center"><strong>제목</strong></td>
											<td class="tableline21" align="left" width="75%">&nbsp;
												<%=rowMap.getString("title")%>
											</td>
										</tr>

										<tr bgcolor="#FFFFFF">
											<td height="28" class="tableline11 dkblue" bgcolor="#E4EDFF" align="center"><strong>구분</strong></td>
											<td class="tableline21" align="left" width="75%">&nbsp;
												<%=rowMap.getString("notiGubun").equals("P") ? "개인공지" : "그룹공지"%>
											</td>
										</tr>

										<tr bgcolor="#FFFFFF">
											<td height="28" class="tableline11 dkblue" bgcolor="#E4EDFF" align="center"><strong>대상</strong></td>
											<td class="tableline21" align="left" width="75%">&nbsp;
												<%=rowMap.getString("notiPartName")%>
											</td>
										</tr>

										<tr bgcolor="#FFFFFF">
											<td height="28" class="tableline11 dkblue" bgcolor="#E4EDFF" align="center"><strong>내용</strong></td>
											<td class="tableline21" align="left" width="75%" style="padding-left:10;word-break:break-all;">
												<%=StringReplace.convertHtmlDecodeNamo(rowMap.getString("content"))%>
											</td>
										</tr>

										<tr bgcolor="#FFFFFF">
											<td height="28" class="tableline11 dkblue" bgcolor="#E4EDFF" align="center"><strong>첨부파일</strong></td>
											<td class="tableline21" align="left" width="75%" colspan="3">&nbsp;
												<%=fileStr%>
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
									<input type="button" class="boardbtn1" value=' 글수정 ' onClick="go_modify();">
									<input type="button" class="boardbtn1" value=' 글삭제 ' onClick="go_delete();" >
									<input type="button" class="boardbtn1" value=' 목록 ' onClick="go_list();" >
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

