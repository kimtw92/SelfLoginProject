<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 반편성  리스트
// date  : 2008-06-05
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
	
	
	StringBuffer sbDeptClassListHtml = new StringBuffer();
	StringBuffer sbClassListHtml = new StringBuffer();
	

	String btnClassYN = ""; // 입교자 반지정 버튼 사용여부
	
	int totalUser = 0;
	
	
	if( !requestMap.getString("commGrcode").equals("") &&
		!requestMap.getString("commGrseq").equals("") &&
		!requestMap.getString("commSubj").equals("") ){
	
		// 입교자 반지정 여부
		DataMap rowMap = (DataMap)request.getAttribute("ROWDATA_COUNTSUBJRESULT");
		if(rowMap == null) rowMap = new DataMap();
		rowMap.setNullToInitialize(true);
		
		// 기관별 입교자 리스트
		DataMap listMap = (DataMap)request.getAttribute("DEPTCLASS_LIST");
		if(listMap == null) listMap = new DataMap();
		listMap.setNullToInitialize(true);
		
		// 반 리스트
		DataMap classListMap = (DataMap)request.getAttribute("CLASS_LIST");
		if(classListMap == null) classListMap = new DataMap();
		classListMap.setNullToInitialize(true);
		
		
		// 입교자 반지정 버튼 사용여부
		if(listMap.keySize("dept") > 0){
			if(rowMap.getInt("cnt") > 0){
				btnClassYN = "Y";
			}else{
				btnClassYN = "N";
			}	
		}
		
		
		
		// 기관별 입교자 리스트
		if(listMap.keySize("dept") > 0){
			
			for(int i=0; i < listMap.keySize("dept"); i++){
				
				sbDeptClassListHtml.append("<tr bgcolor=\"#FFFFFF\" height=\"25\">");
				sbDeptClassListHtml.append("	<td align=\"center\" class=\"tableline11\">" + (i+1) + "</td>");
				
				if(listMap.getString("deptnm",i).equals("")){
					sbDeptClassListHtml.append("	<td align=\"left\" class=\"tableline11\" style='padding:0 0 0 10'><font color=\"red\">소속기관 없음 (오류 : 소속기관이 없는 교육생 존재)</font></td>");
				}else{
					sbDeptClassListHtml.append("	<td align=\"left\" class=\"tableline11\" style='padding:0 0 0 10'>" + listMap.getString("deptnm",i) + "</td>");
				}

				
				sbDeptClassListHtml.append("	<td align=\"center\" class=\"tableline21\">" + listMap.getString("countUser",i) + " 명</td>");
				sbDeptClassListHtml.append("</tr>");
				
				totalUser += listMap.getInt("countUser",i);
				
			}
			
			sbDeptClassListHtml.append("<tr bgcolor=\"#FFFFFF\" height=\"25\">");
			sbDeptClassListHtml.append("	<td class=\"tableline11\" colspan=\"2\" align=\"center\"><b>총인원</b></td>");
			sbDeptClassListHtml.append("	<td class=\"tableline21\" align=\"center\"><font color=\"red\"><b>" + totalUser + " 명</b></font></td>");
			sbDeptClassListHtml.append("</tr>");
			
			
		}else{
			sbDeptClassListHtml.append("<tr bgcolor=\"#FFFFFF\" height=\"100\">");
			sbDeptClassListHtml.append("	<td align=\"center\" class=\"tableline21\" colspan=\"100%\">데이타가 없습니다.</td>");		
			sbDeptClassListHtml.append("</tr>");
		}
		
		
		
		// 반 리스트
		if(classListMap.keySize("classno") > 0){
			
			for(int i=0; i < classListMap.keySize("classno"); i++){
				sbClassListHtml.append("<tr bgcolor=\"#FFFFFF\" height=\"25\">");
				sbClassListHtml.append("	<td align=\"center\" class=\"tableline11\">" + (i+1) + "</td>");
				sbClassListHtml.append("	<td align=\"left\" class=\"tableline11\" style='padding:0 0 0 10'>" + classListMap.getString("classnm",i) + "</td>");
				sbClassListHtml.append("	<td align=\"center\" class=\"tableline21\">" + classListMap.getString("countUser",i) + " 명</td>");
				sbClassListHtml.append("</tr>");
			}
			
		}else{
			sbClassListHtml.append("<tr bgcolor=\"#FFFFFF\" height=\"100\">");
			sbClassListHtml.append("	<td align=\"center\" class=\"tableline21\" colspan=\"100%\">데이타가 없습니다.</td>");		
			sbClassListHtml.append("</tr>");
		}
			
		
	}else{
		sbDeptClassListHtml.append("<tr bgcolor=\"#FFFFFF\" height=\"100\">");
		sbDeptClassListHtml.append("	<td align=\"center\" class=\"tableline21\" colspan=\"100%\">데이타가 없습니다.</td>");		
		sbDeptClassListHtml.append("</tr>");
		
		
		sbClassListHtml.append("<tr bgcolor=\"#FFFFFF\" height=\"100\">");
		sbClassListHtml.append("	<td align=\"center\" class=\"tableline21\" colspan=\"100%\">데이타가 없습니다.</td>");		
		sbClassListHtml.append("</tr>");
	}

	
%>



<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->


<script language="JavaScript">
<!--
//상단 comm 셀렉트시 리로딩되는 함수.
function go_reload(){

	fnSearch();
}



// 검색
function fnSearch(){

	if( $F("commGrcode") != "" &&
	    $F("commGrseq") != "" &&
	    $F("commSubj") != "" ){

		pform.action = "class.do";
		pform.submit();
	}else{
		alert("검색 조건을 모두 선택해야 합니다.");
	}

}

// 반지정 현황 보기
function fnClassView(){

	if( $F("commGrcode") != "" &&
	    $F("commGrseq") != "" &&
	    $F("commSubj") != "" ){

		$("mode").value = "classViewList";
		pform.action = "class.do";
		pform.submit();
	}else{
		alert("검색 조건을 모두 선택해야 합니다.");
	}

	
}

// 반갯수 지정 팝업
function fnSetClassPop(){

	if( $F("commGrcode") != "" &&
	    $F("commGrseq") != "" &&
	    $F("commSubj") != "" ){
		
		if(NChecker($("pform"))){
		
			var url = "class.do";
			url += "?mode=classFormPop";
			url += "&classCnt=" + $F("class_cnt");
			url += "&commGrcode=" + $F("commGrcode");
			url += "&commGrseq=" + $F("commGrseq");
			url += "&commSubj=" + $F("commSubj");
			url += "&menuId=" + $F("menuId");
			
			pwinpop = popWin(url,"cPop","400","400","yes","yes");
		
		}
	}else{
		alert("검색 조건을 모두 선택해야 합니다.");
	}
}

// 입교자 반지정
function fnClassReg(){
	if( $F("commGrcode") != "" &&
	    $F("commGrseq") != "" &&
	    $F("commSubj") != "" ){
			$("mode").value = "classReg";
			pform.action = "class.do";
			pform.submit();
	}else{
		alert("검색 조건을 모두 선택해야 합니다.");
	}
}

// 타과목동일반구성하기
function fnSetOtherClassPop(){
	if( $F("commGrcode") != "" &&
	    $F("commGrseq") != "" &&
	    $F("commSubj") != "" ){
						
		var url = "class.do";
		url += "?mode=otherPop";
		url += "&commGrcode=" + $F("commGrcode");
		url += "&commGrseq=" + $F("commGrseq");
		url += "&commSubj=" + $F("commSubj");
		url += "&menuId=" + $F("menuId");
		url += "&modeType=classList";

		
		pwinpop = popWin(url,"oPop","600","600","yes","yes");
		
		
	}else{
		alert("검색 조건을 모두 선택해야 합니다.");
	}
}


//-->
</script>
<script for="window" event="onload">
<!--
	var commYear = "<%= requestMap.getString("commYear") %>";
	var commGrCode = "<%= requestMap.getString("commGrcode") %>";
	var commGrSeq = "<%= requestMap.getString("commGrseq") %>";
	var commSubj = "<%= requestMap.getString("commSubj") %>";
	
	var reloading = ""; 

	getCommYear(commYear);														// 년도
	getCommOnloadGrCode(reloading, commYear, commGrCode);						// 과정
	getCommOnloadGrSeq(reloading, commYear, commGrCode, commGrSeq);				// 기수
	getCommOnloadSubj(reloading, commYear, commGrCode, commGrSeq, commSubj);	// 과목
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
						<img src="/images/bullet003.gif"  align="bottom">&nbsp;<strong>기관별 입교생 리스트</strong>
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
								<td width="80" align="center" class="tableline11"><strong>년 도</strong></td>
								<td align="left" class="tableline11" bgcolor="#FFFFFF" style="padding:0 0 0 9">
									<div id="divCommYear" class="commonDivLeft">										
										<select name="commYear" onChange="getCommGrCode('subj');" style="width:100px;font-size:12px">
											<option value="">**선택하세요**</option>
										</select>
									</div>					
								</td>
								<td width="80" align="center" class="tableline11"><strong>과 정</strong></td>
								<td align="left" class="tableline11" bgcolor="#FFFFFF" style="padding:0 0 0 9">
									<div id="divCommGrCode" class="commonDivLeft">
										<select name="commGrcode" style="width:250px;font-size:12px">
											<option value="">**선택하세요**</option>
										</select>
									</div>
								</td>
								<td rowspan="2" bgcolor="#FFFFFF" width="100" align="center">
									<input type="button" value="검 색" onclick="fnSearch();" class="boardbtn1">
								</td>
							</tr>
							<tr height="28" bgcolor="F7F7F7">
								<td align="center" class="tableline11"><strong>기 수</strong></td>
								<td align="left" class="tableline11" bgcolor="#FFFFFF" style="padding:0 0 0 9">
									<div id="divCommGrSeq" class="commonDivLeft">
										<select name="commGrseq" style="width:100px;font-size:12px">
											<option value="">**선택하세요**</option>
										</select>
									</div>
								</td>
								<td align="center" class="tableline11"><strong>과 목</strong></td>
								<td align="left" class="tableline11" bgcolor="#FFFFFF" style="padding:0 0 0 9">
									<div id="divCommSubj" class="commonDivLeft">										
										<select name="commSubj" style="width:250px;font-size:12px">
											<option value="">**선택하세요**</option>
										</select>
									</div>
								</td>
							</tr>														
							<tr bgcolor="#375694"><td height="2" colspan="100%"></td></tr>
						</table>
						<!--[e] 검색 -->
					
						<br>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr bgcolor="#375694"><td height="2" colspan="100%"></td></tr>
							<tr height="28" bgcolor="#5071B4">
								<td width="10%" align="center" class="tableline11 white"><strong>번 호</strong></td>
								<td width="70%" align="center" class="tableline11 white"><strong>소속기관</strong></td>
								<td width="20%" align="center" class="tableline11 white"><strong>입교인원</strong></td>
							</tr>
							
							<%= sbDeptClassListHtml.toString() %>
							
							<tr bgcolor="#375694"><td height="2" colspan="100%"></td></tr>
						</table>
					
						<br>
						<table width="100%" border="0" cellpadding="0" cellspacing="0" style="border-collapse:collapse;">
							<tr>
								<td align="right">
									<input type="button" value="반지정 현황보기" onclick="fnClassView();" class="boardbtn1">
									&nbsp;
									
									
									<%
										if(btnClassYN.equals("N")){
									%>
										<input type="button" value="입교자 반지정" onclick="fnClassReg();" class="boardbtn1">
									<% 	}else if(btnClassYN.equals("Y")){ %>
										<font color='red'>과목이수로 인해 <br>입교자 반지정이 <br>불가능합니다.</font>
									<% 		
										}										
									%>
								</td>
							</tr>
						</table>
					
					
						<br><br><br>
						위의 인원을 참조하여 구성할 반 갯수를 지정하세요.<br><br>
						반 갯수 지정 : <input type="text" name="class_cnt" id="class_cnt" size="3" maxlength="3" required="true!반 갯수가 없습니다." dataform="num!숫자만 입력해야 합니다.">
						<input type="button" value="확인" onclick="fnSetClassPop();" class="boardbtn1">
						※ 확인 버튼을 클릭하면 반 이름 지정화면이 팝업됩니다. 
						<br><br>
						
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr bgcolor="#375694"><td height="2" colspan="100%"></td></tr>
							<tr height="28" bgcolor="#5071B4">
								<td width="10%" align="center" class="tableline11 white"><strong>번 호</strong></td>
								<td width="70%" align="center" class="tableline11 white"><strong>반명</strong></td>
								<td width="20%" align="center" class="tableline11 white"><strong>인원</strong></td>
							</tr>
							
							<%= sbClassListHtml.toString() %>
							
							<tr bgcolor="#375694"><td height="2" colspan="100%"></td></tr>
						</table>
						
						<br>
						<table width="100%" border="0" cellpadding="0" cellspacing="0" style="border-collapse:collapse;">
							<tr>
								<td align="right">
									<input type="button" value="타 과목 동일반 구성하기 " onclick="fnSetOtherClassPop();" class="boardbtn1">
								</td>
							</tr>
						</table>
						
						<br><br>
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
