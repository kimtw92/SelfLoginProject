<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 과정기수관리의 개설과정추가.
// date : 2008-05-21
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
 

	//목록리스트
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	listMap.setNullToInitialize(true);

	StringBuffer sbListHtml = new StringBuffer(); //목록
	String grCode = "";

	for(int i=0; i < listMap.keySize("grcode"); i++){

		grCode = listMap.getString("grcode", i);

		sbListHtml.append("<tr bgColor='#FFFFFF'>");

		sbListHtml.append("<td align='center' class='tableline11' >" + (i+1) + "</td>");
		sbListHtml.append("<td align='center' class='tableline11' >" + listMap.getString("mcodeName", i) + "</td>");
		sbListHtml.append("<td align='center' class='tableline11' >" + listMap.getString("scodeName", i) + "</td>");
		sbListHtml.append("<td align='center' class='tableline11' >" + grCode + "</td>");
		sbListHtml.append("<td align='left' class='tableline11' >&nbsp;" + listMap.getString("grcodenm", i) + "&nbsp;</td>");
		sbListHtml.append("<td align='right' class='tableline11' >&nbsp;" + listMap.getString("grtime", i) + "시간&nbsp;</td>");
		sbListHtml.append("<td align='center' class='tableline11' >"+(!listMap.getString("ckGrseq", i).equals("") ? "V" : "<INPUT TYPE='checkbox' NAME='grcode[]' value='" + grCode + "'>")+"</td>");
		sbListHtml.append("<td align='center' class='tableline21' >"+ (listMap.getString("ckGrseq", i).equals("") ? "-" : "<input type='button' value='삭제' class='boardbtn1' onclick=\"go_delete('"+grCode+"', '"+listMap.getString("grcodenm", i)+"');\">")                  +"</td>");
		sbListHtml.append("</tr>");
	}

	
%>

<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->

<script language="JavaScript" type="text/JavaScript">
<!--

var year = "<%=requestMap.getString("year")%>";
function chkForm(from){
	return true;

}

function go_search(){

	$("mode").value = "grcode_form";
	pform.action = "/courseMgr/courseSeq.do";
	pform.submit();
}


function allChk(objname){
	var obj = document.getElementsByName(objname);
	for(i=0;i<obj.length;i++){
		obj[i].checked = !(obj[i].checked);
	}
}

//삭제.
function go_delete(grcode, grcodenm) {

	$("mode").value = "grcode_exec";
	$("qu").value = "delete";
	$("grcode").value = grcode;

	if( confirm(year+"년 "+grcodenm+"을 삭제하시겠습니까?") ){

		pform.action = "/courseMgr/courseSeq.do";
		pform.submit();

	}
}
//개설 과정 추가.
function go_add(){

	$("mode").value = "grcode_exec";
	$("qu").value = "insert";

	if( confirm("추가하시겠습니까?") ){

		pform.action = "/courseMgr/courseSeq.do";
		pform.submit();

	}
	//alert("add");
}

//로딩시.
onload = function()	{

}

//-->
</script>
<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<form id="pform" name="pform" method="post">
<input type="hidden" name="menuId"				value="<%=requestMap.getString("menuId")%>">
<input type="hidden" name="mode"				value="<%=requestMap.getString("mode")%>">

<input type="hidden" name="year"				value="<%=requestMap.getString("year")%>">
<input type="hidden" name="grcode"				value="">
<input type="hidden" name="qu"					value="<%=requestMap.getString("qu")%>">

<input type="hidden" name="rtn"					value="<%=requestMap.getString("rtn")%>">

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
						<img src="/images/bullet003.gif" width="11" height="11" align="bottom">&nbsp;<strong>과정기수관리 개설과정 추가</strong>
					</td>
				</tr>
			</table>
			<!--// subTitle -->

			<!--[s] Contents Form  -->
			<table cellspacing="0" cellpadding="0" border="0" width="100%" class="contentsTable">
				<tr>
					<td>
						<!---[s] content -->

						<!-- space --><table width="100%" height="20"><tr><td></td></tr></table>
						
						<table width="100%" border="0" cellpadding="0" cellspacing="0">
							<tr><td height="2" bgcolor="#375694" colspan="100%"></td></tr>
							<tr>
								<td bgcolor="F7F7F7" class="tableline11" align="center"><strong>전체과정 :</strong> </td>
								<td class="tableline11" style="padding-left:10px;">
									<input type='text' name='searchValue' id="searchValue" style='width:150' class="font1" value="<%=requestMap.getString("searchValue")%>">&nbsp;&nbsp;
									
								</td>
								<td bgcolor="F7F7F7" align="center" class="tableline11"><strong>개설년도 : </strong></td>
								<td class="tableline11" align="center"><%=requestMap.getString("year")%>년 &nbsp;&nbsp;</td>
								<td class="tableline21" align="center" width="200">
									<input type="button" value="검색" class="boardbtn1" onclick="go_search();">
									<input type="button" value="개설 과정추가" class="boardbtn1" onclick="go_add();">
								</td>
							</tr>
							<tr><td height="2" bgcolor="#375694" colspan="100%"></td></tr>
						</table>
							

						<!-- space --><table width="100%" height="10"><tr><td></td></tr></table>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td>
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr bgcolor="#375694">
											<td height="2" colspan="100%"></td>
										</tr>
										<tr height='28' bgcolor="#5071B4">
											<td align='center' class="tableline11 white">
												<strong>번호</strong>
											</td>
											<td align='center' class="tableline11 white">
												<strong>과정분류</strong>
											</td>
											<td align='center' class="tableline11 white">
												<strong>상세분류</strong>
											</td>
											<td align='center' class="tableline11 white" width="100">
												<strong>과정코드</strong>
											</td>
											<td align='center' class="tableline11 white">
												<strong>과정명</strong>
											</td>
											<td align='center' class="tableline11 white" width="70">
												<strong>이수시간</strong>
											</td>
											<td align='center' class="tableline11 white" width="100">
												<INPUT TYPE='checkbox' NAME='allCheck' onClick="allChk('grcode[]');" id="allCheck"><strong><label for="allCheck">선택</label></strong>
											</td>
											<td align='center' class="tableline21 white" width="100">
												<strong>삭제</strong>
											</td>
										</tr>

										<%=sbListHtml.toString()%>

									</table>

								</td>
							</tr>
						</table>

						<!-- space --><table width="100%" height="10"><tr><td></td></tr></table>
						<table width="100%" border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td width="50%">&nbsp;</td>
								<td width="50%" align="right">
									<input type="button" value="개설 과정추가" class="boardbtn1" onclick="go_add();">&nbsp;&nbsp;
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

