<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%  
// prgnm : 시스템관리자 > 과정/콘텐츠관리 > 기초코드관리 > 교육계획 리스트.
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


	StringBuffer sbListHtml = new StringBuffer();
	String grCode = ""; //과정코드.

	for(int i=0; i < listMap.keySize("grcode"); i++){

		grCode = listMap.getString("grcode", i);

		sbListHtml.append("<tr bgColor='#FFFFFF'>");

		sbListHtml.append("<td align='center' class='tableline11' >" + (i+1) + "</td>");
		sbListHtml.append("<td align='center' class='tableline11' >" + listMap.getString("mcodeName", i) + "</td>");
		sbListHtml.append("<td align='center' class='tableline11' >" + listMap.getString("scodeName", i) + "</td>");
		sbListHtml.append("<td align='left' class='tableline11' >&nbsp;" + listMap.getString("grcodenm", i) + "&nbsp;</td>");
		sbListHtml.append("<td align='center' class='tableline11' ><input type='button' value='입력' class='boardbtn1' onclick=\"go_add('"+grCode+"');\" " + (listMap.getInt("existYn", i) > 0 ? "disabled" : "") + "></td>");
		sbListHtml.append("<td align='center' class='tableline11' ><input type='button' value='수정' class='boardbtn1' onclick=\"go_modify('"+grCode+"');\" " + (listMap.getInt("existYn", i) > 0 ? "" : "disabled") + "></td>");
		sbListHtml.append("<td align='center' class='tableline11' ><input type='button' value='복사' class='boardbtn1' onclick=\"go_grannarCopy('ONE', '"+grCode+"');\" ></td>");
		sbListHtml.append("<td align='center' class='tableline21' ><input type='button' value='보기' class='boardbtn1' onclick=\"go_view('"+grCode+"');\" " + (listMap.getInt("existYn", i) > 0 ? "" : "disabled") + "></td>");

		sbListHtml.append("</tr>");


	}

	if( listMap.keySize("grcode") <= 0){

		sbListHtml.append("<tr bgColor='#FFFFFF'>");
		sbListHtml.append("<td align='center' class='tableline11' colspan='100%'>등록된 과정이 없습니다.</td>");

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

	pform.action = "/baseCodeMgr/grannae.do";
	pform.submit();

}

//개설 과정 추가.
function go_grseqAdd(){

	$("mode").value = "grcode_form";
	$("grcode").value = "";
	$("rtn").value = "/baseCodeMgr/grannae.do?mode=list";

	pform.action = "/courseMgr/courseSeq.do";
	pform.submit();

}


//등록
function go_add(grcode){

	$("mode").value = "form";
	$("qu").value = "insert";
	$("grcode").value = grcode;
	pform.action = "/baseCodeMgr/grannae.do";

	pform.submit();

}

//수정
function go_modify(grcode){

	$("mode").value = "form";
	$("qu").value = "update";
	$("grcode").value = grcode;
	pform.action = "/baseCodeMgr/grannae.do";

	pform.submit();

}

//교육계획 복사 팝업.
function go_grannarCopy(qu, grcode){

	popWin("", "grannaeCopyPop", "200", "150", "no","no");

	$("mode").value = "copy_form";
	$("qu").value = qu;
	$("grcode").value = grcode;

	pform.action = "/baseCodeMgr/grannae.do";
	pform.target = "grannaeCopyPop";

	pform.submit();
	pform.target = "";

}


//미리보기.
function go_view(grcode){

	$("mode").value = "view";
	$("grcode").value = grcode;
	pform.action = "/baseCodeMgr/grannae.do";

	pform.submit();

}


//로딩시.
onload = function()	{

	var year = "<%=requestMap.getString("year")%>";
	$("year").value = year;
}

//-->
</script>
<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<form id="pform" name="pform" method="post">
<input type="hidden" name="menuId"				value="<%=requestMap.getString("menuId")%>">
<input type="hidden" name="mode"				value="<%=requestMap.getString("mode")%>">

<input type="hidden" name="qu"					value=''>
<input type="hidden" name="grcode"				value=''>
<input type="hidden" name="rtn"					value=''>

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


			<!--[s] Contents Form  -->
			<table cellspacing="0" cellpadding="0" border="0" width="100%" class="contentsTable">
				<tr>
					<td>
						<!---[s] content -->

						<!-- space --><table width="100%" height="20"><tr><td></td></tr></table>
						<table width="100%" border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td width="100%" align="center">

									<select name="year" id="year" onChange="go_list();">
									<script language='javascript'>
									<!--
										for(var i=new Date().getYear()+1; i>= 1985; i--)
											document.write("<option value='" + i + "'> " + i + "</option>");
									//-->
									</script>
									</select>
									<input type="button" value="개설과정추가" class="boardbtn1" onclick="go_grseqAdd();">&nbsp;&nbsp;
									<input type="button" value="년도별 교육계획 복사" class="boardbtn1" onclick="go_grannarCopy('ALL', '');">
								</td>
							</tr>
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
											<td align='center' class="tableline11 white">
												<strong>과정명</strong>
											</td>
											<td align='center' class="tableline11 white" width="100">
												<strong>입력</strong>
											</td>
											<td align='center' class="tableline11 white" width="100">
												<strong>수정</strong>
											</td>
											<td align='center' class="tableline11 white" width="100">
												<strong>교육계획복사</strong>
											</td>
											<td align='center' class="tableline11 white" width="100">
												<strong>미리보기</strong>
											</td>
										</tr>

										<%= sbListHtml.toString() %>

									</table>
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

