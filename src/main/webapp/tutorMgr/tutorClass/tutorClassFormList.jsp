<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 강사지정 등록 리스트
// date  : 2008-06-27
// auth  : kang
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
	
	
	String modeType = requestMap.getString("modeType");	// insert, update
	
	
	// update 시 검색창 안보이게 한다.
	String searchDisplay = "";
	if(modeType.equals("update")){
		searchDisplay = "style='display:none'";
	}
	
	
	// 검색 조건
	String searchGubun = requestMap.getString("searchGubun");
	String searchAddr = requestMap.getString("searchAddr");
	String searchType = Util.getValue( requestMap.getString("searchType"), "name");
	String searchTxt = requestMap.getString("searchTxt");
	
	
	// 셀렉트 박스 선택용
	String strGubunSelected = "";
	String[] aryTgubunSelected = new String[2];	
	String[] aryCarSelected = new String[2];
	String strClassRoomSelected = "";
	
	
	
	
	
	
	// 강사 담당분야
	StringBuffer sbTutorGubunHtml = new StringBuffer();
	DataMap tutorGubunMap = (DataMap)request.getAttribute("TUTOR_GUBUN_LIST");
	if(tutorGubunMap == null) tutorGubunMap = new DataMap();
	tutorGubunMap.setNullToInitialize(true);

	sbTutorGubunHtml.append("<select name=\"searchGubun\" id=\"searchGubun\" style=\"width:120px\" >");
	sbTutorGubunHtml.append("	<option value=\"\">**선택하세요**</option>");
	
	if(tutorGubunMap.keySize("gubun") > 0){
		for(int i=0; i < tutorGubunMap.keySize("gubun"); i++){
			
			if(tutorGubunMap.getString("gubun",i).equals( searchGubun ) ){
				strGubunSelected = "selected";
			}else{
				strGubunSelected = "";
			}
			
			sbTutorGubunHtml.append("<option value=\"" + tutorGubunMap.getString("gubun",i) + "\" " + strGubunSelected + " >" + tutorGubunMap.getString("gubunnm",i) + "</option> ");
		}
	}else{
		sbTutorGubunHtml.append("	<option value=\"\">등록된 분야없음</option>");
	}
	sbTutorGubunHtml.append("</select>");
	
	
	
	// 강의실
	DataMap classRoomMap = (DataMap)request.getAttribute("CLASSROOM_LIST");
	if(classRoomMap == null) classRoomMap = new DataMap();
	classRoomMap.setNullToInitialize(true);
	
	
	// 과목명
	DataMap subjNameRowMap = (DataMap)request.getAttribute("SUBJNM_ROW");
	if(subjNameRowMap == null) subjNameRowMap = new DataMap();
	subjNameRowMap.setNullToInitialize(true);
	String subjName = subjNameRowMap.getString("subjnm");
	
	
	
	// 리스트
	StringBuffer sbListHtml = new StringBuffer();
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	if(listMap == null) listMap = new DataMap();
	listMap.setNullToInitialize(true);
	
	// 페이징
	PageNavigation pageNavi = (PageNavigation)listMap.get("PAGE_INFO");
	int pageNum = pageNavi.getTotalCnt() - (requestMap.getInt("currPage") - 1) * requestMap.getInt("rowSize");
	
	String pageStr = "";
	String param = "";
	
	int rowIndex = 1;
	
	String strSelectHtmlByTgugun = "";			// 리스트에 표시할 강사구분
	String strSelectHtmlByCarReserveYn = "";	// 배차유무
	String strSelectHtmlByClassRoom = "";		// 강의실
	
	if(listMap.keySize("userno") > 0){		
		for(int i=0; i < listMap.keySize("userno"); i++){
			
			
			
			// 강사구분
			if( listMap.getString("tgubun",i).equals("0") ){
				aryTgubunSelected[0] = "";
				aryTgubunSelected[1] = "selected";				
			}else{

				aryTgubunSelected[0] = "selected";
				aryTgubunSelected[1] = "";
			}
			strSelectHtmlByTgugun =  "<select name=\"tgubun\" id=\"tgubun_" + rowIndex + "\"  >";
			strSelectHtmlByTgugun += "	<option value=\"1\" " + aryTgubunSelected[0] + " >주강사</option>";
			strSelectHtmlByTgugun += "	<option value=\"0\" " + aryTgubunSelected[1] + " >보조강사</option>";
			strSelectHtmlByTgugun += "</select>";
			
			
									
			// 배차유무
			if( listMap.getString("carReserveYn",i).equals("Y") ){				
				aryCarSelected[0] = "";
				aryCarSelected[1] = "selected";
			}else{
				aryCarSelected[0] = "selected";
				aryCarSelected[1] = "";
			}
			strSelectHtmlByCarReserveYn =  "<select name=\"carReserveYn\" id=\"carReserveYn_" + rowIndex + "\"  >";
			strSelectHtmlByCarReserveYn += "	<option value=\"N\" " + aryCarSelected[0] + " >N</option>";
			strSelectHtmlByCarReserveYn += "	<option value=\"Y\" " + aryCarSelected[1] + " >Y</option>";
			strSelectHtmlByCarReserveYn += "</select>";
			
			
			
			// 강의실 셀렉트박스(제거됨)
			strSelectHtmlByClassRoom =  "<select name=\"classroomNo\" id=\"classroomNo_" + rowIndex + "\"  >";
			strSelectHtmlByClassRoom += "	<option value=\"\" selected></option>";
			
			//if(classRoomMap.keySize("classroomNo") > 0){				
			//	for(int k=0; k < classRoomMap.keySize("classroomNo"); k++){					
			//		if( classRoomMap.getString("classroomNo", k).equals( listMap.getString("classroomNo",i) ) ){
			//			strClassRoomSelected = "selected";
			//		}else{
			//			strClassRoomSelected = "";
			//		}					
			//		strSelectHtmlByClassRoom += "	<option value=\"" + classRoomMap.getString("classroomNo", k) + "\" " + strClassRoomSelected + " >" + classRoomMap.getString("classroomName", k) + "</option>";
			//	}			
			//}
			
			strSelectHtmlByClassRoom += "</select>";
			
			
			sbListHtml.append("<tr style=\"height:25px\">");
			
			sbListHtml.append("	<td align=\"center\" >" + rowIndex + "</td>");
			sbListHtml.append("	<td align=\"center\" >" + listMap.getString("resno", i) + "</td>");
			sbListHtml.append("	<td align=\"center\" ><a href=\"javascript:fnPrintInfo('" + listMap.getString("userno", i) + "')\">" + listMap.getString("name", i) + "</a></td>");
			sbListHtml.append("	<td align=\"center\" >" + listMap.getString("gubunnm", i) + "</td>");
			
			sbListHtml.append("	<td align=\"center\" >");
			sbListHtml.append(strSelectHtmlByTgugun);
			sbListHtml.append("	</td>");
			
			sbListHtml.append("	<td align=\"center\" style=\"display:none\" >");			
			sbListHtml.append(strSelectHtmlByClassRoom.toString());			
			sbListHtml.append("	</td>");
			
			sbListHtml.append("	<td align=\"center\" >");
			sbListHtml.append("		<input type=\"button\" value=\"파일\" onclick=\"fnFileUploadPop('groupfileNo_" + rowIndex + "','" + listMap.getString("groupfileNo", i) + "');\" class=\"boardbtn1\"> ");
			sbListHtml.append("	</td>");
			
			sbListHtml.append("	<td align=\"center\" style=\"display:none\" >");
			sbListHtml.append(strSelectHtmlByCarReserveYn);
			sbListHtml.append("	</td>");
			
			sbListHtml.append("	<td align=\"center\" class=\"br0\" >");
			
			if( modeType.equals("insert") ){
				sbListHtml.append("		<input type=\"button\" value=\"입 력\" onclick=\"fnSave('" + rowIndex + "');\" class=\"boardbtn1\"> ");
			}else{
				sbListHtml.append("		<input type=\"button\" value=\"수 정\" onclick=\"fnSave('" + rowIndex + "');\" class=\"boardbtn1\"><br> ");
				sbListHtml.append("		<input type=\"button\" value=\"삭 제\" onclick=\"fnDelete('" + rowIndex + "');\" class=\"boardbtn1\"> ");
			}
									
			sbListHtml.append("		<input type=\"hidden\" name=\"groupfileNo\" id=\"groupfileNo_" + rowIndex + "\" value=\"" + listMap.getString("groupfileNo", i) + "\" > ");
			sbListHtml.append("		<input type=\"hidden\" name=\"tuserno\" id=\"tuserno_" + rowIndex + "\" value=\"" + listMap.getString("userno", i) + "\" > ");
			sbListHtml.append(" </td>");
			
			
			sbListHtml.append("</tr>");
			
			rowIndex++;
			
		}
		
		pageStr += pageNavi.showFirst();
		pageStr += pageNavi.showPrev();
		pageStr += pageNavi.showPage();
		pageStr += pageNavi.showNext();
		pageStr += pageNavi.showLast();
		
	}else{
		sbListHtml.append("<tr>");
		sbListHtml.append("	<td align=\"center\" style=\"height:100px\" colspan=\"100%\" class=\"br0\">검색결과가 없습니다.</td>");
		sbListHtml.append("</tr>");
	}
	
	
	
%>

<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->


<script language="JavaScript">
<!--


// 페이지 이동
function go_page(page) {

	$("currPage").value = page;
	
	pform.action = "/tutorMgr/tclass.do";
	pform.submit();
}

// 저장
function fnSave(pindex){

	var param = "";
	
	if(confirm("저장하시겠습니까 ?")){
	
		$("s_tuserno").value = $F("tuserno_" + pindex);
		$("s_tgubun").value = $F("tgubun_" + pindex);
		$("s_classroomNo").value = $F("classroomNo_" + pindex);
		$("s_carReserveYn").value = $F("carReserveYn_" + pindex);
		$("s_groupfileNo").value = $F("groupfileNo_" + pindex);
		
		
		$("mode").value = $F("modeType");
		pform.action = "/tutorMgr/tclass.do";
		pform.submit();
		
	}

}

// 삭제
function fnDelete(pindex){

	if(confirm("삭제하시겠습니까 ?")){
	
		$("s_tuserno").value = $F("tuserno_" + pindex);
		
		$("mode").value = "delete";
		pform.action = "/tutorMgr/tclass.do";
		pform.submit();
	}

}

// 검색
function fnSearch(){

	$("currPage").value = "1";

	<% if(modeType.equals("insert")){ %>
		pform.action = "/tutorMgr/tclass.do";
		pform.submit();
	<% } %>
}

// 파일업로드 팝업
function fnFileUploadPop(obj, groupfileNo){

	var url = "/commonInc/commonFileUploadPop.do";
	url += "?mode=form";
	url += "&retObj=pform." + obj;
	url += "&groupfileNo=" + groupfileNo;
	
	pwinpop = popWin(url,"cPop","600","400","yes","yes");
	

}

// 파일 저장 후 처리내용
function fnFileUploadOk(){
	
	alert("파일이 업로드 되었습니다. 반드시 저장버튼을 클릭해서 저장해야 합니다.");
}


// 강사정보 팝업
function fnPrintInfo(userno){

	var url = "/tutorMgr/tclass.do";
	url += "?mode=infoPop";
	url += "&userno=" + userno;
	
	pwinpop = popWin(url,"infoPop","800","700","yes","no");

}

//-->
</script>
<script for="window" event="onload">
<!--

	$("searchAddr").value = "<%= searchAddr %>";
	$("searchType").value = "<%= searchType %>";

//-->
</script>

<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<form id="pform" name="pform" method="post" >

<input type="hidden" name="menuId" 		id="menuId"		value="<%= requestMap.getString("menuId") %>">
<input type="hidden" name="mode"		id="mode"		value="<%= requestMap.getString("mode") %>">
<input type="hidden" name="modeType"	id="modeType"		value="<%= requestMap.getString("modeType") %>">

<!-- 페이징용 -->
<input type="hidden" name="currPage" 	id="currPage"	value="<%= requestMap.getString("currPage")%>">

<input type="hidden" name="grcode" 			id="grcode"		value="<%= requestMap.getString("grcode") %>" >
<input type="hidden" name="grseq" 			id="grseq"		value="<%= requestMap.getString("grseq") %>" >
<input type="hidden" name="subj" 			id="subj"		value="<%= requestMap.getString("subj") %>" >
<input type="hidden" name="classno" 		id="classno"	value="<%= requestMap.getString("classno") %>" >
<input type="hidden" name="s_tuserno" 		id="s_tuserno" >
<input type="hidden" name="s_tgubun" 		id="s_tgubun" >
<input type="hidden" name="s_groupfileNo" 	id="s_groupfileNo" >
<input type="hidden" name="s_resourceNo" 	id="s_resourceNo" >
<input type="hidden" name="s_carReserveYn" 	id="s_carReserveYn" >
<input type="hidden" name="s_classroomNo" 	id="s_classroomNo" >



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

			<!--[s] subTitle -->
			<table width="100%" height="10"><tr><td></td></tr></table>
			<table width="100%" border="0" cellspacing="0" cellpadding="0" class="contentsSubTitleTable">			
				<tr>
					<td height="20">
						<img src="/images/bullet003.gif"  align="bottom">&nbsp;<strong>강사지정</strong>
					</td>
				</tr>
			</table>
			<!--[e] subTitle -->


			<!--[s] Contents Form  -->
			<div class="h10"></div>
			
			<table cellspacing="0" cellpadding="0" border="0" width="100%" class="contentsTable">
				<tr>
					<td>
						<!-- 검색 -->
						<table class="search01" <%= searchDisplay %> >
							<tr>
								<th class="bl0">선택 과목명</th>
								<td colspan="2"><b><%= subjName %></b></td>
							</tr>
							<tr>
								<th width="80" class="bl0">담당분야</th>
								<td>
									<%= sbTutorGubunHtml.toString() %>
								</td>
								<td width="100" class="btnr" rowspan="2">
									<input type="button" value="검 색" onclick="fnSearch();" class="boardbtn1">
								</td>
							</tr>
							<tr>
								<th width="80" class="bl0">지역</th>
								<td rowspan="2">
									<select name="searchAddr" id="searchAddr">
										<option value="">전체</option>
										<option value="서울">서울특별시</option>
										<option value="인천">인천광역시</option>
										<option value="대전">대전광역시</option>
										<option value="대구">대구광역시</option>
										<option value="부산">부산광역시</option>
										<option value="광주">광주광역시</option>
										<option value="부산">부산광역시</option>
										<option value="울산">울산광역시</option>
										<option value="경기">경기도</option>
										<option value="강원">강원도</option>
										<option value="충북">충청북도</option>
										<option value="충남">충청남도</option>
										<option value="경북">경상북도</option>
										<option value="경남">경상남도</option>
										<option value="전북">전라북도</option>
										<option value="전남">전라남도</option>
										<option value="제주">제주도</option>
									</select>
									&nbsp;
									<select name="searchType" id="searchType">
										<option value="name">성명
										<option value="resno">주민번호
									</select>
									&nbsp;
									<input type="text" class="textfield" name="searchTxt" id="searchTxt" value="<%= searchTxt %>"  style="width:100px" onKeyPress="if(event.keyCode == 13) { fnSearch(); return false;}" />
								
								</td>
							</tr>
							
						</table>
						<!--//검색 -->
						<div class="space01"></div>
						
						<!-- 리스트  -->
						<table class="datah01">
							<thead>
							<tr>
								<th>No</th>
								<th>주민등록번호</th>
								<th>이름</th>
								<th>담당분야</th>
								<th>강사구분</th>
								<th style="display:none" >강의실</th>
								<th>첨부파일</th>
								<th style="display:none" >배차유무</th>
								<th class="br0">처리</th>
							</tr>
							</thead>

							<tbody>
							<%= sbListHtml.toString() %>
							</tbody>
						</table>
						<!--//리스트  -->	
						<div class="h5"></div>
						
						<!--[s] 페이징 -->
						<br>						
						<div class="paging">
							<%=pageStr%>
						</div>						
						<!--[e] 페이징 -->
						
					</td>
				</tr>
			</table>
			
						
			<div class="space_ctt_bt"></div>
			<!--[e] Contents Form  -->
				                            
        </td>
    </tr>
</table>

<!--[s] bottom -->
<jsp:include page="/commonInc/include/commonAdminBottom.jsp" flush="false"/>
<!--[e] bottom -->

</form>
</body>
