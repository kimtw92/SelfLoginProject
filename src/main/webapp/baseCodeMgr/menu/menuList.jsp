<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%  
// prgnm : 시스템관리자 > 시스템 관리 > 기타 > 메뉴 관리.
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


	StringBuffer sbListHtml = new StringBuffer(); //목록
	String strAdminHtml = ""; //관리자 select

	//목록리스트
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	listMap.setNullToInitialize(true);

	//관리자 목록
	DataMap adminList = (DataMap)request.getAttribute("LIST_ADMIN_DATA");
	adminList.setNullToInitialize(true);
	
	//목록 리스트
	for(int i=0; i < listMap.keySize("menuGrade"); i++){

		sbListHtml.append("<tr onmouseover=\"this.style.background='#66CC00'\" onmouseout=\"this.style.background='#FFFFFF'\">");

		sbListHtml.append("<td align='center' class='tableline11' "+(listMap.getString("menuStepNo", i).equals("1")?"bgcolor='#dddddd'":"")+" >");
		sbListHtml.append("<input type='text' value='"+listMap.getString("menuName", i)+"' name='menuName_"+i+"' id='menuName_"+i+"' style='width:120' class='font2'></td>");

		sbListHtml.append("<td align='center' class='tableline11' "+(listMap.getString("menuStepNo", i).equals("1")?"bgcolor='#dddddd'":"")+">");
		sbListHtml.append("<input type='text' value='"+listMap.getString("menuUrl", i)+"' name='menuUrl_"+i+"' style='width:210' class='font2'></td>");

		sbListHtml.append("<td align='center' class='tableline11' "+(listMap.getString("menuStepNo", i).equals("1")?"bgcolor='#dddddd'":"")+">");
		sbListHtml.append(listMap.getString("menuStepNo", i)+"</td>");

		sbListHtml.append("<td align='center' class='tableline11' "+(listMap.getString("menuStepNo", i).equals("1")?"bgcolor='#dddddd'":"")+">");
		sbListHtml.append(listMap.getString("menuDepth1", i)+"</td>");

		sbListHtml.append("<td align='center' class='tableline11' "+(listMap.getString("menuStepNo", i).equals("1")?"bgcolor='#dddddd'":"")+">");
		sbListHtml.append(listMap.getString("menuDepth2", i)+"</td>");

		sbListHtml.append("<td align='center' class='tableline11' "+(listMap.getString("menuStepNo", i).equals("1")?"bgcolor='#dddddd'":"")+">");
		sbListHtml.append(listMap.getString("menuDepth3", i)+"</td>");

		sbListHtml.append("<td align='center' class='tableline11' "+(listMap.getString("menuStepNo", i).equals("1")?"bgcolor='#dddddd'":"")+">");
		sbListHtml.append("<input type='text' value='"+listMap.getString("menuSortNo", i)+"' name='menuSortNo_"+i+"' style='width:30' class='font2' required=\"true!정렬순서를 입력해주세요.\"  dataform=\"num!숫자만 입력해야 합니다.\"></td>");

		sbListHtml.append("<td align='center' class='tableline11' "+(listMap.getString("menuStepNo", i).equals("1")?"bgcolor='#dddddd'":"")+">");
		sbListHtml.append("<select name='menuWriteYn_"+i+"' class='font1'>");
		sbListHtml.append("<option value='N' "+ (listMap.getString("menuWriteYn", i).equals("N") ? "selected" : "") +">읽기</option>");
		sbListHtml.append("<option value='Y' "+ (listMap.getString("menuWriteYn", i).equals("Y") ? "selected" : "") +">쓰기</option>");
		sbListHtml.append("</select></td>");
		

		sbListHtml.append("<td align='center' class='tableline11' "+(listMap.getString("menuStepNo", i).equals("1")?"bgcolor='#dddddd'":"")+">");
		sbListHtml.append("<select name='menuUseYn_"+i+"' class='font1'>");
		sbListHtml.append("<option value='N' "+(listMap.getString("menuUseYn", i).equals("N") ? "selected" : "") +">사용안함</option>");
		sbListHtml.append("<option value='Y' "+(listMap.getString("menuUseYn", i).equals("Y") ? "selected" : "") +">사용함</option>");
		sbListHtml.append("</select></td>");

		sbListHtml.append("<td align='center' class='tableline11' "+(listMap.getString("menuStepNo", i).equals("1")?"bgcolor='#dddddd'":"")+">");
		sbListHtml.append("<input type='button' value='수정' class='boardbtn1' onclick=\"go_modify('"+i+"','"+listMap.getString("menuDepth1", i)+"', '"+listMap.getString("menuDepth2", i)+"', '"+listMap.getString("menuDepth3", i)+"', '"+listMap.getString("menuStepNo", i)+"')\">");
		sbListHtml.append("<input type='button' value='삭제' class='boardbtn1' onclick=\"go_delete('"+listMap.getString("menuDepth1", i)+"', '"+listMap.getString("menuDepth2", i)+"', '"+listMap.getString("menuDepth3", i)+"', '"+listMap.getString("menuStepNo", i)+"')\">");
		sbListHtml.append("</td>");

		sbListHtml.append("</tr>");

	}

	//관리자 목록 select
	for(int i=0; i < adminList.keySize("gadmin"); i++){
		strAdminHtml += "<option value='"+adminList.getString("gadmin", i)+"' "+(adminList.getString("gadmin", i).equals(requestMap.getString("menuGrade")) ? "selected" : "") +" >"+adminList.getString("gadminnm", i)+"</option>";
	}

%>

<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->

<script language="JavaScript" type="text/JavaScript">
<!--


//조회
function go_search(){

	var mode = $("mode");
	mode.value = "list";

	var search = $("search");
	search.value = "GO";

	pform.action = "/baseCodeMgr/menu.do";
	pform.submit();

}

//등록
function go_add(){

	var mode = $("mode");
	mode.value = "insert_exec";

	if(NChecker(document.pform)){
	
		switch($F("addMenuStepNo")){
			
			case "2":			
				if($F("addMenuDepth2") == ""){
					alert("2단계를 입력하세요");
					return;
				}			
				break;
				
			case "3":
				
				if($F("addMenuDepth2") == ""){
					alert("2단계를 입력하세요");
					return;
				}
				if($F("addMenuDepth3") == ""){
					alert("3단계를 입력하세요");
					return;
				}
			
				break;
		}
	
	
		if(confirm("등록하시겠습니까?")){
			pform.action = "/baseCodeMgr/menu.do";
			pform.submit();
		}
	}

}


//수정
function go_modify(idx, menu_depth_1, menu_depth_2, menu_depth_3, menu_step_no){

	var mode = $("mode");
	mode.value = "modify_exec";

	var menuDepth1 = $("menuDepth1");
	menuDepth1.value = menu_depth_1;
	var menuDepth2 = $("menuDepth2");
	menuDepth2.value = menu_depth_2;
	var menuDepth3 = $("menuDepth3");
	menuDepth3.value = menu_depth_3;
	var menuStepNo = $("menuStepNo");
	menuStepNo.value = menu_step_no;

	var menuName = $("menuName");
	menuName.value = $F("menuName_"+idx);
	var menuUrl = $("menuUrl");
	menuUrl.value = $F("menuUrl_"+idx);
	var menuSortNo = $("menuSortNo");
	menuSortNo.value = $F("menuSortNo_"+idx);
	var menuWriteYn = $("menuWriteYn");
	menuWriteYn.value = $F("menuWriteYn_"+idx);
	var menuUseYn = $("menuUseYn");
	menuUseYn.value = $F("menuUseYn_"+idx);

	
	if($F("menuName") == ""){
		alert("메뉴명을 입력하세요");
		return;
	}
	
	if($F("menuUrl") == ""){
		alert("메뉴경로를 입력하세요");
		return;
	}
	
	if($F("menuSortNo") == ""){
		alert("정렬순서를 입력하세요");
		return;
	}else{
		if(isNum($F("menuSortNo"),"") == false){
			return;
		}
	}
	
	
	if(confirm("수정하시겠습니까?")){
		pform.action = "/baseCodeMgr/menu.do";
		pform.submit();
	}
	
	
}

//삭제
function go_delete(menu_depth_1, menu_depth_2, menu_depth_3, menu_step_no){

	var mode = $("mode");
	mode.value = "delete_exec";

	var menuDepth1 = $("menuDepth1");
	menuDepth1.value = menu_depth_1;
	var menuDepth2 = $("menuDepth2");
	menuDepth2.value = menu_depth_2;
	var menuDepth3 = $("menuDepth3");
	menuDepth3.value = menu_depth_3;
	var menuStepNo = $("menuStepNo");
	menuStepNo.value = menu_step_no;

	if(confirm("삭제하시겠습니까?")){
		pform.action = "/baseCodeMgr/menu.do";
		pform.submit();
	}

}

//단계 선택시 하위단계 disabled
function changeStep(num){
	for(i=1;i<=3;i++){
		if(i <= num){
			$("addMenuDepth"+i).disabled = false;
		}else{
			$("addMenuDepth"+i).disabled = true;
			$("addMenuDepth"+i).value = "";
		}
	}
}

//-->
</script>
<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<form id="pform" name="pform" method="post">
<input type="hidden" name="menuId" value="<%=requestMap.getString("menuId")%>">
<input type="hidden" name="mode" value="<%=requestMap.getString("mode")%>">
<input type="hidden" name="search" value="">

<input type="hidden" name="menuDepth1" value="">
<input type="hidden" name="menuDepth2" value="">
<input type="hidden" name="menuDepth3" value="">
<input type="hidden" name="menuStepNo" value="">

<input type="hidden" name="menuName" value="">
<input type="hidden" name="menuUrl" value="">
<input type="hidden" name="menuSortNo" value="">
<input type="hidden" name="menuWriteYn" value="">
<input type="hidden" name="menuUseYn" value="">


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
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr bgcolor="#375694">
											<td height="2" colspan="100%"></td>
										</tr>
										<tr height='28' bgcolor="#5071B4">
											<td align='center' class="tableline11 white">
												<strong>메뉴권한</strong>
											</td>
											<td align='center' class="tableline11 white">
												<strong>메뉴명</strong>
											</td>
											<td align='center' class="tableline11 white">
												<strong>메뉴경로</strong>
											</td>
											<td align='center' class="tableline11 white">
												<strong>메뉴단계</strong>
											</td>
											<td align='center' class="tableline11 white">
												<strong>1단계번호</strong>
											</td>
											<td align='center' class="tableline11 white">
												<strong>2단계번호</strong>
											</td>
											<td align='center' class="tableline11 white">
												<strong>3단계번호</strong>
											</td>
											<td align='center' class="tableline11 white">
												<strong>정렬순서</strong>
											</td>
											<td align='center' class="tableline11 white">
												<strong>기능</strong>
											</td>
											<td align='center' class="tableline11 white">
												<strong>사용여부</strong>
											</td>
										</tr>

										<tr bgcolor="#FFFFFF">
											<td align='center' class="tableline11">
												<select name="addMenuGrade" class="font1">
													<%=strAdminHtml%>
												</select>
											</td>
											<td align='center' class="tableline11">
												<input type='text' value='' name='addMenuName' style='width:110' class=font1 required="true!메뉴명을 입력해주세요">
											</td>
											<td align='center' class="tableline11">
												<input type='text' value='' name='addMenuUrl' style='width:190' class=font1 required="true!메뉴경로를 입력해주세요.">
											</td>
											<td align='center' class="tableline11">
												<select name="addMenuStepNo" class="font1" onChange="changeStep(this.value)">
													<option value="1">1단계</option>
													<option value="2">2단계</option>
													<option value="3">3단계</option>
												</select>
											</td>
											<td align='center' class="tableline11">
												<input type='text' value='' name='addMenuDepth1' style='width:30' class=font1 required="true!1단계번호를 입력해주세요." dataform="num!숫자만 입력해야 합니다.">
											</td>
											<td align='center' class="tableline11">
												<input type='text' value='' name='addMenuDepth2' style='width:30' class=font1 DISABLED dataform="num!숫자만 입력해야 합니다.">
											</td>
											<td align='center' class="tableline11">
												<input type='text' value='' name='addMenuDepth3' style='width:30' class=font1 DISABLED dataform="num!숫자만 입력해야 합니다.">
											</td>
											<td align='center' class="tableline11">
												<input type='text' value='' name='addMenuSortNo' style='width:30' class=font1 required="true!정렬순서를 입력해주세요." dataform="num!숫자만 입력해야 합니다.">
											</td>
											<td align='center' class="tableline11">
												<select name="addMenuWriteYn" class="font1">
													<option value="Y">쓰기</option>
													<option value="N">읽기</option>
												</select>
											</td>
											<td align='center' class="tableline11">
												<select name="addMenuUseYn" class="font1">
													<option value="Y">사용함</option>
													<option value="N">사용안함</option>
												</select>
											</td>
										</tr>

									</table>
								</td>
							</tr>
						</table>
						<!-- space --><table width="100%" height="10"><tr><td></td></tr></table>
						<table width="100%" cellpadding="0" cellspacing="0">
							<tr>
								<td align="right"><input type="button" value="입력완료" class="boardbtn1" onclick="go_add();"></td>
							</tr>
						</table>



						<!-- space --><table width="100%" height="20"><tr><td></td></tr></table>
						<table width="100%" cellpadding="0" cellspacing="0">
							<tr>
								<td>
									<select name="menuGrade" class="font1">
										<%=strAdminHtml%>
									</select>
									<input type="button" value="조회" class="boardbtn1" onclick="go_search()">
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
												<strong>메뉴명</strong>
											</td>
											<td align='center' class="tableline11 white">
												<strong>메뉴경로</strong>
											</td>
											<td align='center' class="tableline11 white">
												<strong>메뉴<br>단계</strong>
											</td>
											<td align='center' class="tableline11 white">
												<strong>1단계<br>번호</strong>
											</td>
											<td align='center' class="tableline11 white">
												<strong>2단계<br>번호</strong>
											</td>
											<td align='center' class="tableline11 white">
												<strong>3단계<br>번호</strong>
											</td>
											<td align='center' class="tableline11 white">
												<strong>정렬<br>순서</strong>
											</td>
											<td align='center' class="tableline11 white">
												<strong>기능</strong>
											</td>
											<td align='center' class="tableline11 white">
												<strong>사용여부</strong>
											</td>
											<td align='center' class="tableline11 white">
												<strong>기능</strong>
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

