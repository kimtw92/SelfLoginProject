<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%  
// prgnm : 시스템관리자 > 과정/콘텐츠관리 > 기초코드관리 > 과정코드관리 등록/수정.
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
	DataMap rowMap = (DataMap)request.getAttribute("ROW_DATA");
	rowMap.setNullToInitialize(true);


	//과정분류 리스트
	DataMap mainCodeListMap = (DataMap)request.getAttribute("MAINCODE_LIST_DATA");
	mainCodeListMap.setNullToInitialize(true);

	//과정분류
	String mainCodeStr = "";
	for(int i=0; i < mainCodeListMap.keySize("mcodeName"); i++){
		mainCodeStr += "<option value='"+mainCodeListMap.getString("majorCode", i)+"'>"+mainCodeListMap.getString("mcodeName", i)+"</option>";
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

	pform.action = "/baseCodeMgr/grCode.do";
	pform.submit();

}

//수정
function go_modify(){

	$("mode").value = "exec";
	$("qu").value = "update";

	if(NChecker(document.pform)){

		if(confirm("수정 하시겠습니까?")){
			pform.action = "/baseCodeMgr/grCode.do";
			pform.submit();
		}

	}

}

//삭제
function go_delete(menu_depth_1, menu_depth_2, menu_depth_3, menu_step_no){

	$("mode").value = "exec";
	$("qu").value = "delete";

	if(confirm("삭제하시겠습니까?")){
		pform.action = "/baseCodeMgr/grCode.do";
		pform.submit();
	}

}


//등록
function go_add(){

	$("mode").value = "exec";
	$("qu").value = "insert";

	if(NChecker(document.pform)){
		if($("grPoint").value == ""){
			alert("교육시간을 입력하십시오.");
			return false;
		}
		
		if($("grPoint").value > 9999){
			alert("교육시간입력이 잘못 되었습니다. 다시 입력하여 주십시오.");
			return false;
		
		}
		
		if($("grtime").value > 99 ){
			alert("과정 이수시간 입력이 잘못되었습니다. 다시 입력하여 주십시오.");
			return false;
		
		}
		
		
		
		if(confirm("등록 하시겠습니까?")){
			pform.action = "/baseCodeMgr/grCode.do";
			pform.submit();
		}

	}

}

//상세분류코드 가져오기.
function go_mainSubCode(grtype, grsubcd){
	
	var url = "/baseCodeMgr/mainCode.do";
	var pars = "mode=ajaxSubcode&gubun=G&grtype="+grtype+"&grsubcd="+grsubcd;
	var divId = "mainSubCodeDIV";
	
	/*
	var myAjax = new Ajax.Updater(
		{success:divId},
		url, 
		{
			method: "get", 
			parameters: pars,
			onFailure: fnFailureByAjaxMainSubCode
		}
	);
	*/
	/*
	var myAjax = new Ajax.Updater(
		{success: divId },
		url, 
		{
			method: "post", 
			parameters: pars,
			onLoading : function(){				
			},
			onSuccess : function(){
				alert("test ok");
			},
			onFailure : function(){
				alert("데이타를 가져오지 못했습니다.");
			}				
		}
	);
	*/
	
	var myAjax = new Ajax.Request(
		url, 
		{
			method: "post", 
		    parameters:pars,
		    onLoading : function(){
			},
			onSuccess : function(originalRequest){
				$("mainSubCodeDIV").innerHTML = trim(originalRequest.responseText);
			},
			onFailure : function(){
				$("rid").value = "";					
				alert("삭제시 오류가 발생했습니다.");
			}    
		}
	);

}
function fnFailureByAjaxMainSubCode(request){
	alert("상세코드 가져오는 도중 오류가 발생했습니다.");
}




//로딩시.
onload = function()	{

	//개설년도 셀렉트.
	var mkYear = "<%=!rowMap.getString("mkYear").equals("") ? rowMap.getString("mkYear") : ""+java.util.Calendar.getInstance().get(java.util.Calendar.YEAR)%>";
	$("mkYear").value = mkYear;

	//과정분류 및 상세분류.
	var grtype = "<%=rowMap.getString("grtype")%>";
	var grsubcd = "<%=rowMap.getString("grsubcd")%>";

	if(grtype != ""){
		$("grtype").value = grtype;
		go_mainSubCode($F("grtype"), grsubcd);
	}else{
		go_mainSubCode($F("grtype"), '');
	}

}

//-->
</script>
<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<form id="pform" name="pform" method="post">
<input type="hidden" name="menuId"				value="<%=requestMap.getString("menuId")%>">
<input type="hidden" name="mode"				value="<%=requestMap.getString("mode")%>">
<input type="hidden" name="currPage"			value='<%=requestMap.getString("currPage")%>'>
<input type="hidden" name="searchKey"			value='<%=requestMap.getString("searchKey")%>'>
<input type="hidden" name="searchValue"			value='<%=requestMap.getString("searchValue")%>'>

<input type="hidden" name="qu"					value='<%=requestMap.getString("qu")%>'>
<input type="hidden" name="grcode"				value='<%=rowMap.getString("grcode")%>'>

<input type="hidden" name="rullYn"				value='<%=rowMap.getString("rullYn")%>'>
<input type="hidden" name="musicYn"				value='<%=rowMap.getString("musicYn")%>'>

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


			<!-- subTitle -->
			<!-- space --><table width="100%" height="10"><tr><td></td></tr></table>
			<table width="100%" border="0" cellspacing="0" cellpadding="0" class="contentsSubTitleTable">
				<tr>
					<td height="20">
						<img src="/images/bullet003.gif" width="11" height="11" align="bottom">&nbsp;<strong>과정코드관리 <%= requestMap.getString("qu").equals("insert")? "등록" : "수정" %></strong>
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
									<table width="100%" border="0" cellpadding="0" cellspacing="0" >
										<tr bgcolor="#FFFFFF">
											<td height="28" class="tableline11 dkblue" bgcolor="#E4EDFF" width="15%" align="center"><strong>과정코드</strong></td>
											<td class="tableline21" align="left" width="75%" colspan="3">&nbsp;
												<%=!rowMap.getString("grcode").equals("") ? rowMap.getString("grcode") : "XXXXXXXXX"%> 
											</td>
										</tr>
										<tr bgcolor="#FFFFFF">
											<td height="28" class="tableline11 dkblue" bgcolor="#E4EDFF" align="center"><strong>과정명</strong></td>
											<td class="tableline21" align="left" width="75%" colspan="3">&nbsp;
												<input type="text" class="textfield" name="grcodenm" value="<%=rowMap.getString("grcodenm")%>" maxlength="40" style="width:35%" required="true!과정명을 입력해주세요.">
											</td>
										</tr>

										<tr bgcolor="#FFFFFF">
											<td height="28" class="tableline11 dkblue" bgcolor="#E4EDFF" align="center"><strong>과정분류</strong></td>
											<td class="tableline21" align="left" width="35%" >&nbsp;
												<select name="grtype" onchange="go_mainSubCode(this.value, '');">
													<%=mainCodeStr%>
												</select>
											</td>
											<td height="28" class="tableline11 dkblue" bgcolor="#E4EDFF" align="center" width="15%"><strong>상세분류</strong></td>
											<td class="tableline21" align="left" width="35%" >
												<div name="mainSubCodeDIV" id="mainSubCodeDIV">&nbsp;
													<select name="grsubcd">
													</select>
												</div>
											</td>
										</tr>

										<tr bgcolor="#FFFFFF">
											<td height="28" class="tableline11 dkblue" bgcolor="#E4EDFF" align="center"><strong>과정유형</strong></td>
											<td class="tableline21" align="left" width="75%" colspan="3">&nbsp;
												<input type="radio" class="chk_01" name="grgubun" id="grgubun1" value="G" <%=!rowMap.getString("grgubun").equals("C") ? "checked" : ""%>><label for="grgubun1">집합과정</label>
												<input type="radio" class="chk_01" name="grgubun" id="grgubun2" value="C" <%=rowMap.getString("grgubun").equals("C") ? "checked" : ""%>><label for="grgubun2">사이버과정</label>
											</td>
										</tr>

										<tr bgcolor="#FFFFFF">
											<td height="28" class="tableline11 dkblue" bgcolor="#E4EDFF" align="center"><strong>개설년도</strong></td>
											<td class="tableline21" align="left" width="75%" colspan="3">&nbsp;
												<select name="mkYear">
												<%
												for(int i=1980;i<2016;i++)
													out.print("<option value='"+i+"'>"+i+"</option>");
												%>
												</select>
											</td>
										</tr>

										<tr bgcolor="#FFFFFF">
											<td height="28" class="tableline11 dkblue" bgcolor="#E4EDFF" align="center"><strong>교육시간</strong></td>
											<td class="tableline21" align="left" width="75%" colspan="3">&nbsp;
												<input type="text" class="textfield" dataform="num!숫자만 입력해야 합니다." maxlength="6" name="grPoint" value="<%=rowMap.getString("grPoint")%>" style="width:50">시간
											</td>
										</tr>

										<tr bgcolor="#FFFFFF">
											<td height="28" class="tableline11 dkblue" bgcolor="#E4EDFF" align="center"><strong>사용여부</strong></td>
											<td class="tableline21" align="left" width="75%" colspan="3">&nbsp;
												<input type="radio" class="chk_01" name="useYn" id="useYn1" value="Y" <%=!rowMap.getString("useYn").equals("N") ? "checked" : ""%>><label for="useYn1">YES</label>
												<input type="radio" class="chk_01" name="useYn" id="useYn2" value="N" <%=rowMap.getString("useYn").equals("N") ? "checked" : ""%>><label for="useYn2">NO</label>
											</td>
										</tr>
<!-- 
										<tr bgcolor="#FFFFFF">
											<td height="28" class="tableline11 dkblue" bgcolor="#E4EDFF" align="center"><strong>규정</strong></td>
											<td class="tableline21" align="left" width="75%" colspan="3">&nbsp;
												<input type="radio" class="chk_01" name="rullYn" id="rullYn1" value="Y" <%=!rowMap.getString("rullYn").equals("N") ? "checked" : ""%>><label for="rullYn1">YES</label>
												<input type="radio" class="chk_01" name="rullYn" id="rullYn2" value="N" <%=rowMap.getString("rullYn").equals("N") ? "checked" : ""%>><label for="rullYn2">NO</label>
											</td>
										</tr>

										<tr bgcolor="#FFFFFF">
											<td height="28" class="tableline11 dkblue" bgcolor="#E4EDFF" align="center"><strong>악보이미지</strong></td>
											<td class="tableline21" align="left" width="75%" colspan="3">&nbsp;
												<input type="radio" class="chk_01" name="musicYn" id="musicYn1" value="Y" <%=!rowMap.getString("musicYn").equals("N") ? "checked" : ""%>><label for="musicYn1">YES</label>
												<input type="radio" class="chk_01" name="musicYn" id="musicYn2" value="N" <%=rowMap.getString("musicYn").equals("N") ? "checked" : ""%>><label for="musicYn2">NO</label>
											</td>
										</tr>
 -->
										<tr bgcolor="#FFFFFF">
											<td height="28" class="tableline11 dkblue" bgcolor="#E4EDFF" align="center"><strong>과정이수시간</strong></td>
											<td class="tableline21" align="left" width="75%" colspan="3">&nbsp;
												<input type="text" class="textfield" name="grtime" value="<%=rowMap.getString("grtime")%>" maxlength="6" style="width:50" dataform="num!숫자만 입력해야 합니다.">시간
											</td>
										</tr>

									</table>
									<!-- line --><table width="100%" height="2" cellspacing="0" cellpadding="0" bgcolor="#5378B9"><tr><td></td></tr></table>
								</td>
							</tr>
							<tr>
								<td align='right' height="40">

								</td>
							</tr>
						</table>

						<!-- space --><table width="100%" height="10"><tr><td></td></tr></table>
						<table width="100%" border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td width="100%" align="center">
								<%if(requestMap.getString("qu").equals("insert")){%>
									<input type="button" class="boardbtn1" value=' 등록 ' onClick="go_add();">
								<%}else if(requestMap.getString("qu").equals("update")){%>
									<input type="button" class="boardbtn1" value=' 수정 ' onClick="go_modify();" >
									<input type="button" class="boardbtn1" value=' 삭제 ' onClick="go_delete();">
								<%}%>
									<input type="button" class="boardbtn1" value='리스트' onClick="go_list();">
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