<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 강사관리 카테고리별 리스트
// date  : 2008-06-20
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
	
	String tmpSelected = "";
	
	sbBirthSelectBox.append("<select name=\"searchBirth\"  id=\"searchBirth\"  style=\"width:130px\">");
	sbBirthSelectBox.append("	<option value=\"\">**선택하세요**</option>");
	for(int i=30; i <= 99; i++){
		
		if( requestMap.getString("searchBirth").equals( String.valueOf(i) )  ){
			tmpSelected = "selected";
		}else{
			tmpSelected = "";
		}
		
		sbBirthSelectBox.append("<option value=\"" + i + "\" " + tmpSelected + ">" + i + "년</option>");
	}
	sbBirthSelectBox.append("</select>");
	
	
	// 카테고리별 리스트
	StringBuffer sbListHtml = new StringBuffer();
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	if(listMap == null) listMap = new DataMap();
	listMap.setNullToInitialize(true);
	
	
	// 페이징
	PageNavigation pageNavi = (PageNavigation)listMap.get("PAGE_INFO");
	int pageNum = pageNavi.getTotalCnt() - (requestMap.getInt("currPage") - 1) * requestMap.getInt("rowSize");
	
	String pageStr = "";
	String param = "";
	
	String tmpSubj = "";
	String tmpSubjId = "";
	int tmpSubjCount = 0;
	
	if(listMap.keySize("userno") > 0){		
		for(int i=0; i < listMap.keySize("userno"); i++){
			
			// 강의과목
			tmpSubjCount = 0;
			for(int j=1; j < 8; j++){
				tmpSubjId = "subj" + j;
				
				if( !listMap.getString(tmpSubjId, i).equals("")){
					if(tmpSubjCount == 0){
						tmpSubj = listMap.getString(tmpSubjId, i);
					}else{
						tmpSubj += "," + listMap.getString(tmpSubjId, i);
					}
					tmpSubjCount++;
				}else{
					tmpSubj += "&nbsp;";
				}
			}
			
			
			sbListHtml.append("<tr bgcolor=\"#FFFFFF\" height=\"25\">");
			
			sbListHtml.append("	<td align=\"center\" class=\"tableline11\" rowspan=\"2\">" + (pageNum - i) + "</td>");
			sbListHtml.append("	<td align=\"center\" class=\"tableline11\" rowspan=\"2\"> <a href=\"javascript:go_popView('"+listMap.getString("userno", i)+"');\">" + listMap.getString("name", i) + "</a></td>");
			sbListHtml.append("	<td align=\"center\" class=\"tableline11\" >" + Util.getValue( listMap.getString("history", i) ,"&nbsp;") + "</td>");
			sbListHtml.append("	<td align=\"center\" class=\"tableline11\" >" + Util.getValue( listMap.getString("tposition", i) ,"&nbsp;") + "</td>");
			sbListHtml.append("	<td align=\"center\" class=\"tableline11\" >" + Util.getValue( listMap.getString("hp", i) ,"&nbsp;") + "</td>");
			
			
			param = "javascript:fnTutorInfo('" + listMap.getString("userno", i) + "');";
			sbListHtml.append("	<td align=\"center\" class=\"tableline11\" rowspan=\"2\"><a href=\"" + param + "\">수정</a></td>");
			
			
			if( listMap.getString("disabled", i).equals("N") ){
				param = "javascript:fnDisabled('Y','" + listMap.getString("userno", i) + "');";
			}else{
				param = "javascript:fnDisabled('N','" + listMap.getString("userno", i) + "');";
			}			
			sbListHtml.append("	<td align=\"center\" class=\"tableline21\" rowspan=\"2\"><a href=\"" + param + "\">" + Util.getValue( listMap.getString("disabled", i) ,"&nbsp;") + "</a></td>");
			
			sbListHtml.append("</tr>");
			
			sbListHtml.append("<tr bgcolor=\"#FFFFFF\" height=\"25\">");
			sbListHtml.append("	<td align=\"center\" class=\"tableline11\" >" + tmpSubj + "</td>");
			sbListHtml.append("	<td align=\"center\" class=\"tableline11\" >" + Util.getValue( listMap.getString("jikwi", i) ,"&nbsp;") + "</td>");
			sbListHtml.append("	<td align=\"center\" class=\"tableline11\" ><a href=\"mailto:" + listMap.getString("email", i) + "\">" + Util.getValue( listMap.getString("email", i) ,"&nbsp;") + "</a></td>");
			sbListHtml.append("</tr>");
		}
		
		pageStr += pageNavi.showFirst();
		pageStr += pageNavi.showPrev();
		pageStr += pageNavi.showPage();
		pageStr += pageNavi.showNext();
		pageStr += pageNavi.showLast();
		
		
	}else{
		sbListHtml.append("<tr bgcolor=\"#FFFFFF\" height=\"200\">");
		sbListHtml.append("	<td align=\"center\" class=\"tableline21\" colspan=\"100%\">데이타가 없습니다.</td>");
		sbListHtml.append("</tr>");
	}

	
	
%>


<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->


<script language="JavaScript">
<!--

// 검색
function fnSearch(){
	$("mode").value = "categoty";
	$("currPage").value = "1";
	pform.action = "tutor.do";
	pform.submit();
}

// 페이지 이동
function go_page(page) {
	$("currPage").value = page;
	pform.action = "tutor.do";
	pform.submit();
}

function fnTutorExcel() {
    var param = Form.serialize($("pform"));
    param = param.replace("mode=categoty", "mode=tutor_excel");
    window.open("tutor.do?" + param,'excel','');

}

// 권한변경
function fnDisabled(disabled, userNo){
	
	if(confirm("변경하시겠습니까 ?")){

		var url = "tutor.do";
		var pars = "mode=changeAuth";		
		pars += "&disabled=" + disabled;
		pars += "&userNo=" + userNo;
		
		var myAjax = new Ajax.Request(			
				url, 
				{
					method: "post", 
					parameters: pars,
					onLoading : function(){					
					},
					onSuccess : function(){
						alert("변경되었습니다.");
						go_page($F("currPage"));
						opener.fnSearch("page");
					},
					onFailure : function(){
						alert("변경중 오류가 발생했습니다.");
					}
				}
			);
	}
	
}

// 정보변경
function fnTutorInfo(userNo){
	
	$("mode").value = "regForm";
	pform.action = "tutor.do?type=3&userno=" + userNo;
	pform.submit();
	
}

// 강사등록
function fnTutorForm(){

	$("mode").value = "regForm";
	pform.action = "tutor.do";
	pform.submit();

}

//강사 상세  정보 팝업  페이지
//function go_popView(userNo){
//	
//	$("mode").value = "tutorPopView";
//	var popWindow = popWin('about:blank', 'majorPop11', '700', '800', '1', '0')
//	pform.action = "tutor.do?type=3&userno=" + userNo;
//	pform.target = "majorPop11";
//	pform.submit();
//	$("mode").value="";
//	pform.target = "";
//
//}

//강사정보 팝업
function go_popView(userno){

	var url = "/tutorMgr/tclass.do";
	url += "?mode=infoPop";
	url += "&userno=" + userno;
	
	pwinpop = popWin(url,"infoPop","800","700","yes","no");

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
							
							
	$("searchJob").value = "<%=requestMap.getString("searchJob")%>";
	$("searchAddr").value = "<%=requestMap.getString("searchAddr")%>";
	$("searchSchool").value = "<%=requestMap.getString("searchSchool")%>";
	$("searchSubjNm").value = "<%=requestMap.getString("searchSubjNm")%>";
	$("searchTname").value = "<%=requestMap.getString("searchTname")%>";

//-->
</script>
<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<form id="pform" name="pform" method="post" >

<input type="hidden" name="menuId" 		id="menuId"		value="<%= requestMap.getString("menuId") %>">
<input type="hidden" name="mode"		id="mode"		value="<%= requestMap.getString("mode") %>">

<!-- 페이징 -->
<input type="hidden" name="currPage" 	id="currPage"	value="<%= requestMap.getString("currPage")%>">

<input type="hidden" name="type"		id="type" >


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
									<br><br>
									<input type="button" value="엑 셀" onclick="fnTutorExcel();" class="boardbtn1">
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
								<td align="left" class="tableline11" bgcolor="#FFFFFF" style="padding:0 0 0 9" >
									<input type="text" name="searchSubjNm" id="searchSubjNm" size="14" style="width:130px" onKeyPress="if(event.keyCode == 13) { fnSearch(); return false;}">
								</td>
								<td align="center" class="tableline11"><strong>이름</strong></td>
								<td align="left" class="tableline11" bgcolor="#FFFFFF" style="padding:0 0 0 9" colspan="3">
									<input type="text" name="searchTname" id="searchTname" size="15" onKeyPress="if(event.keyCode == 13) { fnSearch(); return false;}">
								</td>
							</tr>														
							<tr bgcolor="#375694"><td height="2" colspan="100%"></td></tr>
						</table>
						<!--[e] 검색 -->
					
					
						<!--[s] 리스트  -->
						<br>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr bgcolor="#375694"><td height="2" colspan="100%"></td></tr>
							
							<tr height="30" bgcolor="#5071B4" align="center">
								<td width="50" rowspan="2" class="tableline11 white"><b>번호</b></td>
								<td width="70" rowspan="2" class="tableline11 white"><b>성명</b></td>
								<td class="tableline11 white" ><b>전공</b></td>
								<td class="tableline11 white"><b>소속</b></td>
								<td class="tableline11 white"><b>핸드폰</b></td>
								<td width="50" rowspan="2" class="tableline11 white"><b>수정</b></td>
								<td width="50" rowspan="2" class="tableline11 white"><b>권한<br>없음</b></td>
							</tr>
							<tr height="30" bgcolor="#5071B4" align="center">
								<td class="tableline11 white"><b>강의과목</b></td>
								<td class="tableline11 white"><b>직위</b></td>
								<td class="tableline11 white"><b>E-Mail</b></td>
							</tr>
							
							<%= sbListHtml.toString() %>
							
							<tr bgcolor="#375694"><td height="2" colspan="100%"></td></tr>
						</table>
						
						<!--[s] 페이징 -->
						<br>						
						<div class="paging">
							<%=pageStr%>
						</div>
						
						<!--[e] 페이징 -->
					
					
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

