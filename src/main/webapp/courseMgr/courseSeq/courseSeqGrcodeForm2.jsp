<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 개설과정추가. (과정추가)
// date : 2008-06-25
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
 

	//과정 목록리스트
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	listMap.setNullToInitialize(true);

	//기수 리스트 (SELECT BOX 용)
	DataMap grseqListMap = (DataMap)request.getAttribute("GRSEQ_LIST_DATA");
	grseqListMap.setNullToInitialize(true);

	StringBuffer sbListHtml = new StringBuffer(); //목록
	String tmpStr = "";
	if(listMap.keySize("grcode") > 0){
		
		for(int i=0; i < listMap.keySize("grcode"); i++){
	
			sbListHtml.append("<tr bgColor='#FFFFFF'>");
			
			//번호
			sbListHtml.append("<td align='center' class='tableline11' >" + (i+1) + "</td>");
	
			//과정유형
			tmpStr = listMap.getString("grgubun", i).equals("G") ? "오프라인" : "온라인";
			sbListHtml.append("<td align='center' class='tableline11' >" + tmpStr + "</td>");
	
			//과정분류
			if( listMap.getString("grgubun", i).equals("G")  || listMap.getString("mcodeName", i).equals("") )
				tmpStr = "-";
			else
				tmpStr = listMap.getString("mcodeName", i) + " <a href=\"javascript:mcodeChk('grcode[]', 'mcode[]', '"+listMap.getString("mcode", i)+"');\">&nbsp;&nbsp;<font color='blue'>(일괄선택)</font></a>";
			sbListHtml.append("<td align='center' class='tableline11' >" + tmpStr + "</td>");
	
			//상세분류.
			if( listMap.getString("grgubun", i).equals("G")  || listMap.getString("scodeName", i).equals("") )
				tmpStr = "-";
			else
				tmpStr = listMap.getString("scodeName", i) + " <a href=\"javascript:mcodeChk('grcode[]', 'scode[]', '"+listMap.getString("scode", i)+"');\">&nbsp;&nbsp;<font color='blue'>(일괄선택)</font></a>";
			sbListHtml.append("<td align='center' class='tableline11' >" + tmpStr + "</td>");
	
			//과정코드
			sbListHtml.append("<td align='center' class='tableline11' >&nbsp;" + listMap.getString("grcode", i) + "&nbsp;</td>");
	
			//과정명
			sbListHtml.append("<td align='left' class='tableline11' >&nbsp;" + listMap.getString("grcodenm", i) + "&nbsp;</td>");
	
			//선택
			if( listMap.getString("ckGrseq", i).equals("") ){
				tmpStr = "<input type='checkbox' name='grcode[]' value='" + listMap.getString("grcode", i) + "'>";
				tmpStr += "<input type='hidden' name='mcode[]' value='" + listMap.getString("mcode", i) + "'>";
				tmpStr += "<input type='hidden' name='scode[]' value='" + listMap.getString("scode", i) + "'>";
			}else
				tmpStr = "V";
				
			sbListHtml.append("<td align='center' class='tableline21' >" + tmpStr +"</td>");
	
	
			sbListHtml.append("</tr>");
	
		}
	}else{
		sbListHtml.append("<tr>");
		sbListHtml.append("<td colspan=\"100%\" class='tableline21' style=\"text-align:center;height:100px;\">등록된 데이터가 없습니다.</td>");
		sbListHtml.append("</tr>");
	}

	//과정 기수 selectBox
	String selGrseqStr = "";
	
	for(int i=0; i < grseqListMap.keySize("grseq"); i++){

		tmpStr = grseqListMap.getString("grseq", i).equals(requestMap.getString("grseq")) ? "selected" : "";
		selGrseqStr += "<option value='"+grseqListMap.getString("grseq", i)+"' "+tmpStr+">" + StringReplace.subString(grseqListMap.getString("grseq", i), 0, 4) + "-" + StringReplace.subString(grseqListMap.getString("grseq", i), 4, 6) + "</option>";

	}


%>

<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->

<script language="JavaScript" type="text/JavaScript">
<!--

//검색시.
function go_search(){

	if(IsValidCharSearch($F("searchValue"))){
		go_list();
	}
}

//개설과정 추가 리스트.
function go_list(){

	$("mode").value = "grcode_form2";
	pform.action = "/courseMgr/courseSeq.do";
	pform.submit();
}


//일괄선택 클릭시.
function mcodeChk(chkname, mcodename, mcode){

	
	var chkobj = document.getElementsByName(chkname);
	
	var mcodeobj = document.getElementsByName(mcodename);

	
	for(i=0;i<mcodeobj.length;i++){
		
		if(mcodeobj[i].value == mcode){
			
			chkobj[i].checked = !(chkobj[i].checked);
		
		}
	
	}


}



//개설 과정 추가
function go_addGrcode(){

	if($F("grseq") == ""){
		alert("기수를 선택하세요");
		return;
	}

	var bool = false;
	var obj = document.getElementsByName("grcode[]");
	for(i=0;i<obj.length;i++){
		if((obj[i].checked)){
			bool = true;
			break;
		}
	}
	if(!bool){
		alert("과정을 선택하세요");
		return;
	}

	if( confirm("추가하시겠습니까?") ){

		$("mode").value = "grcode_exec";
		$("qu").value = "insert_form2";

		pform.action = "/courseMgr/courseSeq.do";
		pform.submit();

	}
}

//로딩시.
onload = function()	{

}

//Enter 키 입력시 폼 전달시 확인.
function go_submitChk(){
	
	if(IsValidCharSearch($F("searchValue"))){
		pform.submit();
	}
}

//-->
</script>
<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<form id="pform" name="pform" method="post" onSubmit="go_submitChk();return false;">
<input type="hidden" name="menuId"				value="<%=requestMap.getString("menuId")%>">
<input type="hidden" name="mode"				value="<%=requestMap.getString("mode")%>">

<input type="hidden" name="qu"					value="<%=requestMap.getString("qu")%>">

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

						<!--[s] 검색 -->
						<!-- space --><table width="100%" height="10"><tr><td></td></tr></table>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr bgcolor="#375694"><td height="2" colspan="100%"></td></tr>
							<tr height="28" bgcolor="F7F7F7" >
								<td width="100" align="center" class="tableline11"><strong>개설기수선택</strong></td>
								<td width="200" align="left" bgcolor="#FFFFFF" style="padding:0 0 0 9">
									<select name="grseq" onChange="go_search();" style="width:100px;font-size:12px">
										<option value=''>기수선택</option>
										<%= selGrseqStr %>
									</select>
								</td>
								<td width="100" align="center" class="tableline11"><strong>과정검색</strong></td>
								<td width="*" bgcolor="#FFFFFF" align="left">&nbsp;
									<input type='text' name='searchValue' id="searchValue" style='width:100' class="font1" value="<%=requestMap.getString("searchValue")%>">&nbsp;
								</td>
								<td width="100" bgcolor="#FFFFFF" align="center">
									<input type="button" value="검 색" onclick="go_search();" class="boardbtn1">
								</td>
							</tr>
							<tr bgcolor="#375694"><td height="2" colspan="100%"></td></tr>
						</table>
						<!--[e] 검색 -->

						<!-- space --><table width="100%" height="20"><tr><td></td></tr></table>
						<table width="100%" border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td width="100%" align="right">
									<input type="button" value="개설과정추가"	class="boardbtn1" onclick="go_addGrcode();">
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
											<td width="6%" align='center' class="tableline11 white">
												<strong>번호</strong>
											</td>
											<td width="10%" align='center' class="tableline11 white">
												<strong>과정유형</strong>
											</td>
											<td width="18%" align='center' class="tableline11 white">
												<strong>과정분류</strong>
											</td>
											<td width="18%" align='center' class="tableline11 white">
												<strong>상세분류</strong>
											</td>
											<td width="13%" align='center' class="tableline11 white" width="100">
												<strong>과정코드</strong>
											</td>
											<td width="*" align='center' class="tableline11 white">
												<strong>과정명</strong>
											</td>
											<td width="7%" align='center' class="tableline21 white" >
												<input TYPE='checkbox' NAME='allCheck' onClick="allChk('grcode[]');" id="allCheck"><strong><label for="allCheck">선택</label></strong>
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
									<input type="button" value="개설과정추가" class="boardbtn1" onclick="go_addGrcode();">
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

