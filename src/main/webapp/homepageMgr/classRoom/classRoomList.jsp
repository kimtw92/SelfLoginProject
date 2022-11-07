<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 강의실 관리
// date : 2008-06-17
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
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	listMap.setNullToInitialize(true);
	
	StringBuffer html = new StringBuffer();
	if(listMap.keySize("classroomNo") > 0){
		for(int i = 0; listMap.keySize("classroomNo") > i; i++){
			html.append("<tr>");
			html.append("	<td class=\"tableline11\" align=\"center\"><input type=\"checkbox\" id=\"chk_"+i+"\" value=\""+listMap.getString("classroomNo",i)+"\"name=\"chk\"	></td>");
			html.append("	<td class=\"tableline11\" align=\"center\">"+ (i+1) +"</td>");
			html.append("	<td class=\"tableline11\" style=\"padding-left:10px;\"><a href=\"javascript:go_form('modify','"+listMap.getString("classroomNo",i)+"');\">"+(listMap.getString("classroomName",i).equals("") ? "&nbsp;" : listMap.getString("classroomName",i))+"</a></td>");
			html.append("	<td class=\"tableline11\" align=\"center\">"+(listMap.getString("classroomPlace",i).equals("") ? "&nbsp;" : listMap.getString("classroomPlace",i))+"</td>");
			html.append("	<td class=\"tableline11\" align=\"center\">"+(listMap.getString("classroomFloor",i).equals("") ? "&nbsp"  : listMap.getString("classroomFloor",i))+"</td>");
			html.append("	<td class=\"tableline11\" align=\"center\">"+(listMap.getString("classroomNo",i).equals("") ? "&nbsp;" : listMap.getString("classroomNo",i))+"</td>");
			html.append("	<td class=\"tableline21\" align=\"center\">"+(listMap.getString("classroomMember",i).equals("") ? "&nbsp;" : listMap.getString("classroomMember",i))+"명</td>");
			html.append("</tr>");
		}
	}else{
		html.append("<tr>");
		html.append("	<td class=\"tableline21\" align=\"center\" colspan=\"100%\" height=\"300\">등록된 값이 없습니다.</td>");
		html.append("</tr>");
	}
	
%>
<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->

<script language="JavaScript" type="text/JavaScript">
//등록, 수정폼 이동.
function go_form(qu, no){
	//폼이동
	$("mode").value="form";
	$("qu").value=qu;
	$("classroomNo").value=no;
	pform.action = "/homepageMgr/classRoom.do";
	pform.submit();
	
}

//리스트
function go_list(){
	pform.action = "/homepageMgr/classRoom.do";
	pform.submit();
}
//검색
function go_search(){

	if(IsValidCharSearch($("searchValue").value) == false){
		$("searchValue").value = "";
		$("searchValue").focus();
		return false;
	}
	
	$("mode").value="list";
	
	pform.action = "/homepageMgr/classRoom.do";
	pform.submit();
}

//강의실 삭제
function go_delete(){
	var chk = 0;
	for(var i=0; i < pform.elements.length; i++){  
		if(pform.elements[i].name == "chk"){
			var obj= pform.elements[i].id;
			if($(obj).checked == true){
				chk = 1;
			}
			
		}
	}
	if(chk == 0){
		alert("삭제할 항목을 체크하여 주십시오.");
		return false;
	}
	
	if(confirm("삭제 하시겠습니까?")){
		$("mode").value="exec";
		$("qu").value="delete";
		pform.action = "/homepageMgr/classRoom.do";
		pform.submit();
	}
}
//엑셀출력
function go_excle(){
	var inputDate = "";
	
	if(NChecker($("pform"))){
	
		$("mode").value="excel";
		if($("date").value == ""){
			alert("엑섹을 출력 하기 위해선 연월을 입력 하여야 합니다.");
			return false;
		}else{
			inputDate = $F("date");
			if(inputDate.length != 6){
				alert("년월을 다시 입력 하여 주십시오.\n ex:)200101");
				return false;			
			
			}
			
			if(inputDate.substring(4, 5) > 1){
				alert("월을 잘못 입력 하셨습니다. 다시 입력 하여주십시오.");
				return false;		
			}
			
		}
		
		pform.action = "/homepageMgr/classRoom.do";
		pform.submit();
	}
	
}


</script>


<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<form id="pform" name="pform" method="post">
<input type="hidden" name="mode">
<input type="hidden" name="qu">
<input type="hidden" name="menuId" 				value="<%=requestMap.getString("menuId") %>">

<!-- 강의실 넘버 -->
<input type="hidden" name="classroomNo">

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
						<img src="/images/bullet003.gif"  align="bottom">&nbsp;<strong>강의실관리</strong>
					</td>
				</tr>
			</table>
			<!--[e] subTitle -->

			<!--[s] Contents Form  -->
			<table cellspacing="0" cellpadding="0" border="0" width="100%" class="contentsTable">
				<tr>
					<td>
                    
                    <!-- search[s] -->
					<table width="100%" border="0" cellpadding="0" cellspacing="0">
						<tr bgcolor="#5071B4">
							<td colspan="100%" height="2"></td>
						</tr>       
						<tr>
							<td bgcolor="#F7F7F7" height="28" width="100" class="tableline11" align="center"><strong>검색구분</strong></td>
							<td class="tableline21" align="left" width="25%" style="padding-left:10;">
								<select name="selectType">
									<option value="CLASSROOM_NAME">--검색 구분--</option>
									<option value="CLASSROOM_NO">강의실코드</option>
									<option value="CLASSROOM_NAME">강의실명</option>
									<option value="CLASSROOM_FLOOR">층</option>
									<option value="CLASSROOM_PLACE">위치</option>
									<option value="CLASSROOM_MEMBER">수용인원</option>
								</select>&nbsp;&nbsp;
								<input type="text" onkeypress="if(event.keyCode==13){go_search();return false;}" maxlength="20" class="textfield" value="<%=requestMap.getString("searchValue") %>" name="searchValue">
							</td>
							<td class="tableline11" align="left" width=""><input type="button" onclick="go_search();" value="검색" class="boardbtn1"></td>
							<td class="tableline21" align="center" width="20%" rowspan="2"><input type="button" class="boardbtn1" onclick="go_form('insert')" value="추가">&nbsp;<input type="button" class="boardbtn1" onclick="go_delete();" value="삭제"></td>
						</tr>
						<tr>
							<td class="tableline11" bgcolor="#F7F7F7" height="28" width="100" align="center"><strong>연월</strong></td>
							<td class="tableline21" style="padding-left:10"><input type="text" size="7" maxlength="6" name="date" dataform="num!숫자만 입력해야 합니다." class="textfield" value="<%=requestMap.getString("date")%>"> ex:) 200101</td>
							<td class="tableline11" align="left"><input type="button" class="boardbtn1" onclick="go_excle();" value="강의실이용현황 출력"></td>
						</tr>
						       
						<tr bgcolor="#5071B4">
							<td colspan="100%" height="2"></td>
						</tr>
					</table>
                    <!-- search[e] -->
                    					
					<!---[s] content -->
					<!-- space --><table width="100%" height="10"><tr><td></td></tr></table>
					<table width="100%" border="0" cellpadding="0" cellspacing="0">
						  <tr>
							<td height="2" colspan="100%" bgcolor="#375694"></td>
						  </tr>
						<tr bgcolor="#5071B4">
						  <td height="28" width="5%" align="center" class="tableline11 white" ><strong>선택</strong></td>
						  <td class="tableline11 white" align="center" width="5%"><strong>번호</strong></td>
						  <td class="tableline11 white" align="center" width="55%"><strong>강의실</strong></td>
						  <td class="tableline11 white" align="center" width="10%"><strong>위치</strong></td>
						  <td class="tableline11 white" align="center" width="5%"><strong>층</strong></td>
						  <td class="tableline11 white" align="center" width="10%"><strong>코드값</strong></td>
						  <td class="tableline21 white" align="center" width="10%"><strong>수용인원</strong></td>
						</tr>
						                    <%=html.toString() %>
						<tr>
							<td height="2" colspan="100%" bgcolor="#375694"></td>
						</tr>
                    </table>
					<table width="100%" border="0" cellpadding="0" cellspacing="0"><tr><td height="50" colspan="100%"></td></tr></table>
                     <!---[e] content -->
					</td>
				</tr>
			</table>
			<!-- space --><table><tr height="30"><td></td></tr></table>
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
	//검색 조건 셀렉티드
	var selectType = "<%=requestMap.getString("selectType")%>";
	len = $("selectType").options.length
	
	for(var i=0; i < len; i++) {
		if($("selectType").options[i].value == selectType){
			$("selectType").selectedIndex = i;
		 }
 	 }
</script>

