<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 강사관리 리스트
// date  : 2008-06-19
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
	
	
	// 출생년도 selectBox
	StringBuffer sbBirthSelectBox = new StringBuffer();
	sbBirthSelectBox.append("<select name=\"searchBirth\"  id=\"searchBirth\"  style=\"width:130px\">");
	sbBirthSelectBox.append("	<option value=\"\">**선택하세요**</option>");
	for(int i=30; i <= 99; i++){
		sbBirthSelectBox.append("<option value=\"" + i + "\">" + i + "년</option>");
	}
	sbBirthSelectBox.append("</select>");
	
	
	// 분야
	StringBuffer sbTutorFieldHtml = new StringBuffer();
	DataMap tutorFieldMap = (DataMap)request.getAttribute("TUTOR_FIELD_DATA");
	if(tutorFieldMap == null) tutorFieldMap = new DataMap();
	tutorFieldMap.setNullToInitialize(true);
	
	String tmp = "";
	String param = "";
	
	if(tutorFieldMap.keySize("gubun") > 0){
		
		for(int i=0; i < tutorFieldMap.keySize("gubun"); i++){
												
			if(tutorFieldMap.getString("colIndex",i).equals("2")){
				
				param = "javascript:fnDetail('" + tutorFieldMap.getString("gubun",i) + "')";
				
				sbTutorFieldHtml.append("<tr bgcolor=\"#FFFFFF\" height=\"35\">");
				sbTutorFieldHtml.append(tmp);
				sbTutorFieldHtml.append("<td align=\"left\" class=\"tableline21\" style=\"padding:0 0 0 10;\">◆&nbsp;<a href=\"" + param + "\">" + tutorFieldMap.getString("gubunnm",i) + "</a><td>");
				
				sbTutorFieldHtml.append("</tr>");
				
				tmp = "";
				
			}else{
				
				param = "javascript:fnDetail('" + tutorFieldMap.getString("gubun",i) + "')";
				
				tmp += "<td align=\"left\" class=\"tableline11\" style=\"padding:0 0 0 10;\">◆&nbsp;<a href=\"" + param + "\">" + tutorFieldMap.getString("gubunnm",i) + "</a><td>";
				
				if(i == tutorFieldMap.keySize("gubun")-1){
					sbTutorFieldHtml.append("<tr bgcolor=\"#FFFFFF\" height=\"35\">");
					sbTutorFieldHtml.append(tmp);
					sbTutorFieldHtml.append("</tr>");
				}				
			}			
		}				
	}else{
		sbTutorFieldHtml.append("<tr bgcolor=\"#FFFFFF\" height=\"100\">");
		sbTutorFieldHtml.append("	<td align=\"left\" class=\"tableline21\">데이타가 없습니다.</td>");
		sbTutorFieldHtml.append("</tr>");
	}
	
	
	// 총 인원 및 등급별 인원수
	StringBuffer sbTutorLevelHtml = new StringBuffer();
	DataMap tutorLevelMap = (DataMap)request.getAttribute("TUTOR_LEVEL_TOTAL");
	if(tutorLevelMap == null) tutorLevelMap = new DataMap();
	tutorLevelMap.setNullToInitialize(true);
	
	int totalCnt = 0;	// 총 인원
	
	if(tutorLevelMap.keySize("tlevel") > 0){		
		for(int i=0; i < tutorLevelMap.keySize("tlevel"); i++){
			
			param = "javascript:fnLevel('" + tutorLevelMap.getString("tlevel", i) + "');";
			
			sbTutorLevelHtml.append("<a href=\"" + param + "\">" + tutorLevelMap.getString("levelName", i) + "</a> : " + tutorLevelMap.getString("cnt", i) + "명&nbsp;&nbsp;&nbsp;"   );
			
			totalCnt += tutorLevelMap.getInt("cnt", i);
		}
	}else{
		sbTutorLevelHtml.append("&nbsp;");
	}
	
	
	// 직업별 강사 분류
	StringBuffer sbTutorJobHtml = new StringBuffer();
	DataMap tutorJobMap = (DataMap)request.getAttribute("TUTOR_JOB_LIST");
	if(tutorJobMap == null) tutorJobMap = new DataMap();
	tutorJobMap.setNullToInitialize(true);
	
	if(tutorJobMap.keySize("year") > 0){		
		for(int i=0; i < tutorJobMap.keySize("year"); i++){
			
			sbTutorJobHtml.append("<tr bgcolor=\"#FFFFFF\" height=\"25\">");
			
			if( tutorJobMap.getString("job", i).equals("교수")){
				sbTutorJobHtml.append("	<td align=\"center\" class=\"tableline11\" rowspan=\"4\">" + tutorJobMap.getString("year", i) + "</td>");
			}
			sbTutorJobHtml.append("	<td align=\"left\" class=\"tableline_left\" >" + Util.moneyFormValue( tutorJobMap.getString("job", i) ) + "</td>");
			sbTutorJobHtml.append("	<td align=\"center\" class=\"tableline11\" >" + Util.moneyFormValue( tutorJobMap.getString("a", i) ) + "</td>");
			sbTutorJobHtml.append("	<td align=\"center\" class=\"tableline11\" >" + Util.moneyFormValue( tutorJobMap.getString("a1", i) ) + "</td>");
			sbTutorJobHtml.append("	<td align=\"center\" class=\"tableline11\" >" + Util.moneyFormValue( tutorJobMap.getString("b", i) ) + "</td>");
			sbTutorJobHtml.append("	<td align=\"center\" class=\"tableline11\" >" + Util.moneyFormValue( tutorJobMap.getString("c1", i) ) + "</td>");
			sbTutorJobHtml.append("	<td align=\"center\" class=\"tableline11\" >" + Util.moneyFormValue( tutorJobMap.getString("c2", i) ) + "</td>");
			sbTutorJobHtml.append("	<td align=\"center\" class=\"tableline11\" >" + Util.moneyFormValue( tutorJobMap.getString("d", i) ) + "</td>");
			sbTutorJobHtml.append("	<td align=\"center\" class=\"tableline21\" >" + Util.moneyFormValue( tutorJobMap.getString("z", i) ) + "</td>");

			sbTutorJobHtml.append("</tr>");
		}
	}else{
		sbTutorJobHtml.append("<tr bgcolor=\"#FFFFFF\" height=\"100\">");
		sbTutorJobHtml.append("	<td align=\"center\" class=\"tableline21\" colspan=\"100%\">데이타가 없습니다.</td>");		
		sbTutorJobHtml.append("</tr>");
	}
	
%>


<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->


<script language="JavaScript">
<!--



// 검색조건 초기화
function fnClear(){

	$("searchTutorGubun").value = "";
	$("searchJob").value = "";
	$("searchAddr").value = "";
	$("searchBirth").value = "";
	$("searchTutorLevel").value = "";
	$("searchSchool").value = "";
	$("searchSubjNm").value = "";
	$("searchTname").value = "";
}

// 검색
function fnSearch(){
	$("mode").value = "categoty";
	pform.action = "tutor.do";
	pform.submit();
}

// 분야별 상세 리스트
function fnDetail(gubun){
	
	fnClear();
	
	$("searchTutorGubun").value = gubun;
	
	$("mode").value = "categoty";
	pform.action = "tutor.do";
	pform.submit();
	
}

// 레벨별 상세 리스트
function fnLevel(level){
	
	fnClear();
	
	$("searchTutorLevel").value = level;
	
	$("mode").value = "categoty";
	pform.action = "tutor.do";
	pform.submit();
}

// 강사등급입력
function fnLevelForm(){	
	fnGoTutorLevelForm();
}

// 강사등록
function fnTutorForm(){

	$("mode").value = "regForm";
	pform.action = "tutor.do";
	pform.submit();

}

//-->
</script>
<script for="window" event="onload">
<!--

	// 담당분야
	fnSingleSelectBoxByAjax("tutorGubun",
							"divTutorGubun", 
							"searchTutorGubun", 
							"gubun", 
							"gubunnm", 
							"<%= requestMap.getString("searchTutorGubun") %>", 
							"130", 
							"true", 
							"false", 
							"false");

	// 강사등급				
	fnSingleSelectBoxByAjax("tutorLevel",
							"divTutorLevel", 
							"searchTutorLevel", 
							"tlevel", 
							"levelName", 
							"<%= requestMap.getString("searchTutorLevel") %>", 
							"110", 
							"true", 
							"false", 
							"false");							

//-->
</script>

<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<form id="pform" name="pform" method="post" >

<input type="hidden" name="menuId" 		id="menuId"		value="<%= requestMap.getString("menuId") %>">
<input type="hidden" name="mode"		id="mode"		value="<%= requestMap.getString("mode") %>">



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
						<img src="/images/bullet003.gif"  align="bottom">&nbsp;<strong>강사관리</strong>
					</td>
				</tr>
			</table>
			<!--[e] subTitle -->
			
			<!--[s] Contents Form  -->
			<table cellspacing="0" cellpadding="0" border="0" width="100%" class="contentsTable">
				<tr>
					<td>
					
						<!--[s] 검색 -->
						<br>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr bgcolor="#375694"><td height="2" colspan="100%"></td></tr>
							<tr height="28" bgcolor="F7F7F7" >
								<td width="80" align="center" class="tableline11"><strong>담당분야</strong></td>
								<td align="left" class="tableline11" bgcolor="#FFFFFF" style="padding:0 0 0 9">
									<div id="divTutorGubun">
										<select name="searchTutorGubun"></select>
									</div>
								</td>
								<td width="80" align="center" class="tableline11"><strong>직업군</strong></td>
								<td align="left" class="tableline11" bgcolor="#FFFFFF" style="padding:0 0 0 9">
									<select name="searchJob" id="searchJob" style="width:110px">
										<option value="">**선택하세요**</option>
										<option value="교수">교수</option>
										<option value="본청 공무원">본청 공무원</option>
										<option value="군구 공무원">군구 공무원</option>
										<option value="중앙/타시도 공무원">중앙/타시도 공무원</option>
										<option value="유관기관">유관기관</option>
										<option value="기타">기타</option>
									</select>
								</td>
								<td width="80" align="center" class="tableline11"><strong>지역</strong></td>
								<td align="left" class="tableline11" bgcolor="#FFFFFF" style="padding:0 0 0 9">
									<select name="searchAddr" id="searchAddr" style="width:110px">
										<option value="">**선택하세요**</option>
										<option value="서울">서울특별시
										<option value="인천">인천광역시
										<option value="대전">대전광역시
										<option value="대구">대구광역시
										<option value="부산">부산광역시
										<option value="광주">광주광역시
										<option value="부산">부산광역시
										<option value="울산">울산광역시
										<option value="경기">경기도
										<option value="강원">강원도
										<option value="충북">충청북도
										<option value="충남">충청남도
										<option value="경북">경상북도
										<option value="경남">경상남도
										<option value="전북">전라북도
										<option value="전남">전라남도
										<option value="제주">제주도
									</select>								
								
								</td>
								<td rowspan="3" bgcolor="#FFFFFF" width="90" align="center">
									<input type="button" value="검 색" onclick="fnSearch();" class="boardbtn1">
									<br><br>
									<input type="button" value="입 력" onclick="fnTutorForm();" class="boardbtn1">
								</td>
							</tr>							
							<tr height="28" bgcolor="F7F7F7">
								<td align="center" class="tableline11"><strong>출생년도</strong></td>
								<td align="left" class="tableline11" bgcolor="#FFFFFF" style="padding:0 0 0 9">
									<%= sbBirthSelectBox.toString() %>
								</td>
								<td align="center" class="tableline11"><strong>강사등급</strong></td>
								<td align="left" class="tableline11" bgcolor="#FFFFFF" style="padding:0 0 0 9">
									<div id="divTutorLevel">
										<select name="searchTutorLevel"></select>
									</div>
								</td>
								<td align="center" class="tableline11"><strong>학력</strong></td>
								<td align="left" class="tableline11" bgcolor="#FFFFFF" style="padding:0 0 0 9">
									<select name="searchSchool" id="searchSchool" style="width:110px">
										<option value="">**선택하세요**</option>
										<option value="01">박사
										<option value="02">석사
										<option value="03">대졸
										<option value="04">대재.퇴,초대졸
										<option value="05">고졸
										<option value="06">중졸이하
										<option value="07">기타
									</select>
								</td>
							</tr>
							<tr height="28" bgcolor="F7F7F7">
								<td align="center" class="tableline11"><strong>출강강의과목</strong></td>
								<td align="left" class="tableline11" bgcolor="#FFFFFF" style="padding:0 0 0 9">
									<input type="text" name="searchSubjNm" id="searchSubjNm" size="14" style="width:130px" onKeyPress="if(event.keyCode == 13) { fnSearch(); return false;}" >
								</td>
								<td align="center" class="tableline11"><strong>이름</strong></td>
								<td align="left" class="tableline11" bgcolor="#FFFFFF" style="padding:0 0 0 9" colspan="3">
									<input type="text" name="searchTname" id="searchTname" size="15" onKeyPress="if(event.keyCode == 13) { fnSearch(); return false;}" >
								</td>
							</tr>														
							<tr bgcolor="#375694"><td height="2" colspan="100%"></td></tr>
						</table>
						<!--[e] 검색 -->
					
						<!--[s] 분야   -->
						<br>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr bgcolor="#375694"><td height="2" colspan="100%"></td></tr>
							<tr height="30" bgcolor="#5071B4">
								<td align="center" class="tableline21 white" colspan="100%"><strong>분 야</strong></td>
							</tr>
							
							<%= sbTutorFieldHtml.toString() %>
							
							<tr bgcolor="#375694"><td height="2" colspan="100%"></td></tr>
						</table>
						<!--[e] 분야   -->
						
						<!--[s] 레벨별 인원  -->
						<br>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr bgcolor="#375694"><td height="2" colspan="100%"></td></tr>
							<tr height="28" bgcolor="F7F7F7" >
								<td width="50%" align="center" class="tableline11"><strong>총인원</strong></td>
								<td width="50%" align="center" class="tableline21" bgcolor="#FFFFFF" style="padding:0 0 0 9">
									<%= Util.moneyFormValue( String.valueOf(totalCnt) ) %> 명
								</td>
							</tr>
							<tr height="28" bgcolor="F7F7F7" >
								<td colspan="100%" align="center" class="tableline21" bgcolor="#FFFFFF" style="padding:0 0 0 9">
									<%= sbTutorLevelHtml.toString() %>
								</td>
							</tr>
							
							<tr bgcolor="#375694"><td height="2" colspan="100%"></td></tr>
						</table>						
						<!--[e] 레벨별 인원  -->
						
						<!--[s] 직업별 강사분류  -->
						<br>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr bgcolor="#375694"><td height="2" colspan="100%"></td></tr>
							<tr height="30" bgcolor="#5071B4">
								<td align="center" class="tableline21 white" colspan="100%"><strong>직업별 강사분류</strong></td>
							</tr>
							<tr height="30" bgcolor="#5071B4">
								<td align="center" class="tableline11 white" colspan="2"><strong>비고</strong></td>
								<td align="center" class="tableline11 white"><strong>특A</strong></td>
								<td align="center" class="tableline11 white"><strong>A</strong></td>
								<td align="center" class="tableline11 white"><strong>B</strong></td>
								<td align="center" class="tableline11 white"><strong>C1</strong></td>
								<td align="center" class="tableline11 white"><strong>C2</strong></td>
								<td align="center" class="tableline11 white"><strong>D</strong></td>
								<td align="center" class="tableline21 white"><strong>자체</strong></td>
							</tr>
							
							<%= sbTutorJobHtml.toString() %>
							
							<tr bgcolor="#375694"><td height="2" colspan="100%"></td></tr>
						</table>
						<!--[e] 직업별 강사분류  -->
						
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td height="50" align="left" nowrap>									
									<input type="button" name="btnCancel" value="강사등급관리" onclick="fnLevelForm();" class="boardbtn1">
								</td>
							</tr>
						</table>
						
						<br><br><br>
					</td>
				</tr>
			</table>
			<!--[e] Contents Form  -->
				                            
        </td>
    </tr>
</table>

<!--[s] bottom -->
<jsp:include page="/commonInc/include/commonAdminBottom.jsp" flush="false"/>
<!--[e] bottom -->

</form>
</body>