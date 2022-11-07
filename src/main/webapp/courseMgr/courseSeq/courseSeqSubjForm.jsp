<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 과정기수관리 과목 수정.
// date : 2008-06-18
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
 

 	//과정기수 정보
	DataMap rowMap = (DataMap)request.getAttribute("ROW_DATA");
	rowMap.setNullToInitialize(true);

 	//과정기수 정보
	DataMap grseqMap = (DataMap)request.getAttribute("GRSEQ_ROW_DATA");
	grseqMap.setNullToInitialize(true);

	
	//과목분류
	String subjType = "";
	if(rowMap.getString("subjtype").equals("Y"))
		subjType = "사이버";
	else if(rowMap.getString("subjtype").equals("N"))
		subjType = "집합";
	else if(rowMap.getString("subjtype").equals("S"))
		subjType = "특수";

	//과목분류
	String subjGubun = "";
	if(rowMap.getString("subjgubun").equals("01"))
		subjGubun = "소양분야";
	else if(rowMap.getString("subjgubun").equals("02"))
		subjGubun = "직무분야";
	else if(rowMap.getString("subjgubun").equals("03"))
		subjGubun = "행정및기타";
	else
		subjGubun = "기타";
	
	
	
	
	// 과목수정시 원래 메뉴로 가기 위한 코드임
	// 2008-09-30 수정 : kang
	String tmpSubjMenuId = "";
	if( memberInfo.getSessCurrentAuth().equals("0") || memberInfo.getSessCurrentAuth().equals("2") ){
		// 시스템관리자, 과정운영자		
		tmpSubjMenuId = "2-1-1";
	}else if( memberInfo.getSessCurrentAuth().equals("A")){
		// 과정장		
		tmpSubjMenuId = "1-1-1";	
	}else{
		tmpSubjMenuId = requestMap.getString("menuId");
	}
	
	
	//콘텐츠 매핑정보 가져오기
	String contentMappingStr = "";
	String contentMappingCodeStr = "";
	
	DataMap contentMappingListMap = (DataMap)request.getAttribute("COTENTMAPPING_LIST_DATA");
	contentMappingListMap.setNullToInitialize(true);

	for(int i=0; i < contentMappingListMap.keySize("mappingSeq"); i++){
		contentMappingStr += "[" + contentMappingListMap.getString("dates", i) + "] " + contentMappingListMap.getString("orgTitle", i) + "\n";
		contentMappingCodeStr += contentMappingListMap.getString("orgDir", i) + ",," + contentMappingListMap.getString("orgTitle", i) + "|";
	}

%>


<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->

<script language="JavaScript" type="text/JavaScript">
<!--

//목록으로 
function go_list(){

	$("mode").value = "list";
	$("qu").value = "";
	$("subj").value = "";
	$("grseq").value = "";

	pform.action = "/courseMgr/courseSeq.do";
	pform.submit();
}




//수정
function go_modify(){

	if(NChecker(document.pform)){

		if( $F("started").replace("-", "") > $F("enddate").replace("-", "") ){
			alert("교육기간 종료일이 교육기간 시작일보다 빨라서 등록할수 없습니다.");
			return;
		}
      	// alert($("started").value + ", " + $("enddate").value);
		if( confirm("수정하시겠습니까?") ){

			$("mode").value = "subj_exec";
			$("qu").value = "update";

			pform.action = "/courseMgr/courseSeq.do";
			pform.submit();

		}
	}

}
function fnPopupCalendar_(frm, obj){

	// 현재 obj에 있는 날짜
	var oDate = $F(obj);
	
	result = window.showModalDialog("/commonInc/jsp/calendar.jsp?oDate="+oDate, "calendar", "dialogWidth:256px; dialogHeight:280px; center:yes; status:no;");

	if (result == -1 || result == null || result == ""){
		return;
	}
	
	if(result == "delete"){
		result = "";
	}
    // alert(result.length);
	if(result.length == 8){
		result = result.substring(0,4)+'-'+result.substring(4,6)+'-'+ result.substring(6,8);
	}
	// alert(result);
	try{
		eval(frm+"."+obj+".value = '"+result+"';");		
	}catch(e){
		$(obj).value = result;
	}

}


//로딩시.
onload = function()	{

}

//-->
</script>
<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<form id="pform" name="pform" method="post">
<input type="hidden" name="menuId"				value="<%=tmpSubjMenuId%>">
<input type="hidden" name="mode"				value="<%=requestMap.getString("mode")%>">
<input type="hidden" name="year"				value="<%=requestMap.getString("year")%>">
<input type="hidden" name="qu"					value="<%=requestMap.getString("qu")%>">

<input type="hidden" name="grcode"				value="<%=rowMap.getString("grcode")%>">
<input type="hidden" name="grseq"				value="<%=rowMap.getString("grseq")%>">
<input type="hidden" name="subj"				value="<%=rowMap.getString("subj")%>">


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
						<img src="/images/bullet003.gif" width="11" height="11" align="bottom">&nbsp;<strong>과정기수관리 기수 정보 관리</strong>
					</td>
				</tr>
			</table>
			<!--// subTitle -->

			<!--[s] Contents Form  -->
			<table cellspacing="0" cellpadding="0" border="0" width="100%" class="contentsTable">
				<tr>
					<td>
						<!---[s] content -->


						<!-- space --><table width="100%" height="10"><tr><td></td></tr></table>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td>
									<!-- line --><table width="100%" height="2" cellspacing="0" cellpadding="0" bgcolor="#5378B9"><tr><td></td></tr></table>
									<table width="100%" border="0" cellpadding="1" cellspacing="1" bgcolor="#D6DBE5">

										<tr bgcolor="#FFFFFF">
											<td width="100%" height="28" class="tableline11 dkblue" bgcolor="#E4EDFF" align="center" colspan="4"><%=StringReplace.subString(grseqMap.getString("grseq"), 0, 4)%>년도&nbsp; <%=grseqMap.getString("grcodeniknm")%> &nbsp; <%=StringReplace.subString(grseqMap.getString("grseq"), 4, 6)%>기수&nbsp;<strong><%=rowMap.getString("lecnm")%></strong></td>
										</tr>

										<tr bgcolor="#FFFFFF" height="28">
											<td width="18%" class="tableline11 dkblue" bgcolor="#E4EDFF" align="center"><strong>과목명</strong></td>
											<td class="tableline21" align="left" width="32%" >&nbsp;
												<input type="text" class="textfield" name="lecnm" value="<%=rowMap.getString("lecnm")%>" style="width:90%" required="true!과목명을 입력해주세요." maxlength="50">
											</td>
											<td width="18%" class="tableline11 dkblue" bgcolor="#E4EDFF" align="center" ><strong>과목분류</strong></td>
											<td class="tableline21" align="left" width="32%" >&nbsp;<%= subjType %></td>
										</tr>

										<tr bgcolor="#FFFFFF" height="28">
											<td width="18%" class="tableline11 dkblue" bgcolor="#E4EDFF" align="center"><strong>필수이수진도율</strong></td>
											<td class="tableline21" align="left" width="32%" >&nbsp;
												<input type="text" class="textfield" name="grastep" value="<%=rowMap.getString("grastep")%>" style="width:40" dataform="num!숫자로 입력해주세요." maxlength="3">%
											</td>
											<td width="18%" class="tableline11 dkblue" bgcolor="#E4EDFF" align="center" ><strong>과목구분</strong></td>
											<td class="tableline21" align="left" width="32%" >&nbsp;<%= subjGubun %></td>
										</tr>


										<tr bgcolor="#FFFFFF" height="28" >
											<td class="tableline11 dkblue" bgcolor="#E4EDFF" align="center"><strong>총 일차수</strong></td>
											<td class="tableline21" align="left" width="82%" colspan="3">&nbsp;
												<input type="text" class="textfield" name="tsection" dataform="num!숫자로 입력해주세요." maxlength="3" value="<%=rowMap.getString("tsection")%>" style="width:40">차시
											</td>
										</tr>
										
										<!-- 콘텐츠 매핑정보 -->
										<tr bgcolor="#FFFFFF" height="28">
											<td width="15%" align="center" height="24" class="tableline11 dkblue" bgcolor="#E4EDFF"><strong>매핑정보</strong></td>
											<td class="tableline21111" align="left" width="82%" colspan="3" style="padding:0 0 0 9px;">
												<textarea name="scormMappingName" id="scormMappingName" class="textfield" rows="10" style="height:100px;width:80%" readonly><%= contentMappingStr %></textarea>
												<!-- <input type="hidden" name="oldSubjtype" id="oldSubjtype" value="<%//= subjtype %>"> -->
												<input type="hidden" name="oldArrayOrgDir" id="oldArrayOrgDir" value="<%= contentMappingCodeStr %>">
												<input type="hidden" name="arrayOrgDir" id="arrayOrgDir" value="<%= contentMappingCodeStr %>">
												<!-- <input type="button" value="콘텐츠매핑" onclick="go_contentMapping();" class="boardbtn1" > -->
												</td>
											</tr>										
											<!-- //콘텐츠 매핑정보 -->

										<tr bgcolor="#FFFFFF" height="28" >
											<td class="tableline11 dkblue" bgcolor="#E4EDFF" align="center"><strong>강의시간</strong></td>
											<td class="tableline21" align="left" width="82%" colspan="3">&nbsp;
												<input type="text" class="textfield" name="lessontime" dataform="num!숫자로 입력해주세요." maxlength="5" value="<%=rowMap.getString("lessontime")%>" style="width:40">시간
											</td>
										</tr>

										<tr bgcolor="#FFFFFF" height="28" >
											<td class="tableline11 dkblue" bgcolor="#E4EDFF" align="center"><strong>실기실습시간</strong></td>
											<td class="tableline21" align="left" width="82%" colspan="3">&nbsp;
												<input type="text" class="textfield" name="silgitime" value="<%=rowMap.getString("silgitime")%>" style="width:40" dataform="num!숫자로 입력해주세요." maxlength="5">시간
											</td>
										</tr>

										<tr bgcolor="#FFFFFF" height="28" >
											<td class="tableline11 dkblue" bgcolor="#E4EDFF" align="center"><strong>토의시간</strong></td>
											<td class="tableline21" align="left" width="82%" colspan="3">&nbsp;
												<input type="text" class="textfield" name="torontime" value="<%=rowMap.getString("torontime")%>" style="width:40" dataform="num!숫자로 입력해주세요." maxlength="5">시간
											</td>
										</tr>

										<tr bgcolor="#FFFFFF" height="28" >
											<td class="tableline11 dkblue" bgcolor="#E4EDFF" align="center"><strong>현지실습시간</strong></td>
											<td class="tableline21" align="left" width="82%" colspan="3">&nbsp;
												<input type="text" class="textfield" name="hyuntime" value="<%=rowMap.getString("hyuntime")%>" style="width:40" dataform="num!숫자로 입력해주세요." maxlength="5">시간
											</td>
										</tr>

										<tr bgcolor="#FFFFFF" height="28" >
											<td class="tableline11 dkblue" bgcolor="#E4EDFF" align="center"><strong>시청각시간</strong></td>
											<td class="tableline21" align="left" width="82%" colspan="3">&nbsp;
												<input type="text" class="textfield" name="multitime" value="<%=rowMap.getString("multitime")%>" style="width:40" dataform="num!숫자로 입력해주세요." maxlength="5">시간
											</td>
										</tr>

										<tr bgcolor="#FFFFFF" height="28" >
											<td class="tableline11 dkblue" bgcolor="#E4EDFF" align="center"><strong>기타시간</strong></td>
											<td class="tableline21" align="left" width="82%" colspan="3">&nbsp;
												<input type="text" class="textfield" name="etctime" value="<%=rowMap.getString("etctime")%>" style="width:40" dataform="num!숫자로 입력해주세요." maxlength="5">시간
											</td>
										</tr>



										<tr bgcolor="#FFFFFF" height="28">
											<td  class="tableline11 dkblue" bgcolor="#E4EDFF" align="center"><strong><font color='#FF0000'>*</font>교육기간</strong></td>
											<td class="tableline21" align="left" width="82%" colspan="3">&nbsp;
												<input type="text" class="textfield" name="started" id="started" value="<%=rowMap.getString("started")%>" style="width:70" required="true!교육기간 시작일을 입력해주세요." readonly>
												&nbsp;<img src="/images/icon_calendar.gif" border="0" align="middle" onclick="fnPopupCalendar_('', 'started');" style="cursor:hand;">

												&nbsp; ~ &nbsp;
												<input type="text" class="textfield" name="enddate" id="enddate" value="<%=rowMap.getString("enddate")%>" style="width:70" required="true!교육기간 종료일을 입력해주세요." readonly>
												&nbsp;<img src="/images/icon_calendar.gif" border="0" align="middle" onclick="fnPopupCalendar_('', 'enddate');" style="cursor:hand;">
											</td>
										</tr>


										<tr bgcolor="#FFFFFF" height="28">
											<td width="18%" class="tableline11 dkblue" bgcolor="#E4EDFF" align="center"><strong>1일 차시제한</strong></td>
											<td class="tableline21" align="left" width="32%" >&nbsp;
												<input type="text" class="textfield" name="limit" value="<%=rowMap.getString("limit")%>" style="width:40" dataform="num!숫자로 입력해주세요." maxlength="2">
											</td>
											<td width="18%" class="tableline11 dkblue" bgcolor="#E4EDFF" align="center" ><strong>주차별 필수학습시간</strong></td>
											<td class="tableline21" align="left" width="32%" >&nbsp;
												<input type="text" class="textfield" name="progTime" value="<%=rowMap.getString("progTime")%>" style="width:40" dataform="num!숫자로 입력해주세요." maxlength="4">분
											</td>
										</tr>

									</table>
									<!-- line --><table width="100%" height="2" cellspacing="0" cellpadding="0" bgcolor="#5378B9"><tr><td></td></tr></table>
								</td>
							</tr>
						</table>

						<!-- space --><table width="100%" height="10"><tr><td></td></tr></table>
						<table width="100%" border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td width="100%" align="center">
									<input type="button" class="boardbtn1" value=' 수정 ' onClick="go_modify();" >
									<input type="button" class="boardbtn1" value='취소' onClick="javascript:pform.reset();">
									<input type="button" class="boardbtn1" value='목록' onClick="go_list();">
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

