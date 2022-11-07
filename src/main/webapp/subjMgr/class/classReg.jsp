<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 입교자 반지정 등록 리스트
// date  : 2008-06-09
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
	
	
	// 반 갯수 지정 카운트
	DataMap countSubjClassMap = (DataMap)request.getAttribute("COUNT_SUBJCLASS_ROW");
	if(countSubjClassMap == null) countSubjClassMap = new DataMap();
	countSubjClassMap.setNullToInitialize(true);
	
	String countBySubjclass = Util.getValue( countSubjClassMap.getString("cnt"), "0");	// 반 갯수 지정 카운트
	
	
%>


<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->


<script language="JavaScript">
<!--

function fnCheck(){

	if( $F("commGrcode") != "" &&
	    $F("commGrseq") != "" &&
	    $F("commSubj") != "" ){
	 
	 	return true;
	    
	}else{
		alert("과정, 기수, 과목 모두 선택해야 합니다.");
		return false;
	}
}

// 단일 분반 지정
function fnSingle(){
	if(parseInt($F("countBySubjclass")) > 0){	
		if( fnCheck() == true ){		
			if(confirm("단일반으로 편성하시겠습니까?")) {		
				$("mode").value = "saveBySingle";
				pform.action = "class.do";
				pform.submit();
			}
		}	
	}else{
		alert("반 구성에서 반 갯수를 먼저 생성해야 합니다.");
	}
}

// 분반 설정 화면
function fnForm(mode){
	if(parseInt($F("countBySubjclass")) > 0){	
		if( fnCheck() == true ){					
			$("mode").value = mode;
			pform.action = "class.do";
			pform.submit();			
		}	
	}else{
		alert("반 구성에서 반 갯수를 먼저 생성해야 합니다.");
	}
}





//-->
</script>
<script for="window" event="onload">
	var commYear = "<%= requestMap.getString("commYear") %>";
	var commGrCode = "<%= requestMap.getString("commGrcode") %>";
	var commGrSeq = "<%= requestMap.getString("commGrseq") %>";
	var commSubj = "<%= requestMap.getString("commSubj") %>";
	
	var reloading = ""; 

	getCommYear(commYear);														// 년도
	getCommOnloadGrCode(reloading, commYear, commGrCode);						// 과정
	getCommOnloadGrSeq(reloading, commYear, commGrCode, commGrSeq);				// 기수
	getCommOnloadSubj(reloading, commYear, commGrCode, commGrSeq, commSubj);	// 과목
</script>

<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<form id="pform" name="pform" method="post" >

<input type="hidden" name="menuId" 		id="menuId"		value="<%= requestMap.getString("menuId") %>">
<input type="hidden" name="mode"		id="mode"		value="<%= requestMap.getString("mode") %>">

<input type="hidden" name="countBySubjclass" id="countBySubjclass"	value="<%= countBySubjclass %>">


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
						<img src="/images/bullet003.gif"  align="bottom">&nbsp;<strong>입교자 반지정 리스트</strong>
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
								<td width="10%" align="center" class="tableline11 white"><strong>분반 방법</strong></td>
								<td width="80%" align="center" class="tableline11 white"><strong>조 건</strong></td>
								<td width="10%" align="center" class="tableline21 white"><strong>분 반</strong></td>
							</tr>
							<tr bgcolor="#FFFFFF" height="25">
								<td align="center" class="tableline11" >단일 분반</td>
								<td align="left" class="tableline_left" >강사 1인이 전체 교육생을 담당하는 경우 (반구성에서 1개반으로 지정했을 경우만 가능)</td>
								<td align="center" class="tableline21" ><input type="button" value="지 정" onclick="fnSingle();" class="boardbtn1"></td>
							</tr>
							<tr bgcolor="#FFFFFF" height="25">
								<td align="center" class="tableline11" rowspan="2" >기관별 분반</td>
								<td align="left" class="tableline_left" > 각 기관에 반을 지정하는 방법 (기관수가 많지 않을 때 권장)</td>
								<td align="center" class="tableline21" ><input type="button" value="확 인" onclick="fnForm('dept1');" class="boardbtn1"></td>
							</tr>
							<tr bgcolor="#FFFFFF" height="25">
								<td align="left" class="tableline_left" >각 반에 기관을 지정하는 방법 (기관수가 많을 때 권장)</td>
								<td align="center" class="tableline21" ><input type="button" value="확 인" onclick="fnForm('dept2');" class="boardbtn1"></td>								
							</tr>
							<tr bgcolor="#FFFFFF" height="25">
								<td align="center" class="tableline11" >조건별 분반</td>
								<td align="left" class="tableline_left" >조건을 지정하여 반을 구성하는 경우</td>
								<td align="center" class="tableline21" ><input type="button" value="확 인" onclick="fnForm('option');" class="boardbtn1"></td>
							</tr>
							<tr bgcolor="#FFFFFF" height="25">
								<td align="center" class="tableline11" >자유 분반</td>
								<td align="left" class="tableline_left" >개개인을 임의의 반에 지정하는 경우</td>
								<td align="center" class="tableline21" ><input type="button" value="확 인" onclick="fnForm('free');" class="boardbtn1"></td>
							</tr>
							
							<tr bgcolor="#375694"><td height="2" colspan="100%"></td></tr>
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
