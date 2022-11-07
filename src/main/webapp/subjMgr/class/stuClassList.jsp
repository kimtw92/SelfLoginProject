<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 입교자 반편성  리스트
// date  : 2008-06-12
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
	
	
	StringBuffer sbListHtml = new StringBuffer();
	String param = "";
	
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	if(listMap == null) listMap = new DataMap();
	listMap.setNullToInitialize(true);
		
	if(listMap.keySize("grcode") > 0){		
		for(int i=0; i < listMap.keySize("grcode"); i++){

			sbListHtml.append("<tr bgcolor=\"#FFFFFF\" height=\"25\">");
			sbListHtml.append("	<td align=\"center\" class=\"tableline11\">" + (i+1) + "</td>");
			
			if( listMap.getInt("rowspan", i) > 0){
				sbListHtml.append("	<td align=\"center\" class=\"tableline11\" rowspan=\"" + listMap.getString("rowspan", i) + "\" >" + listMap.getString("grcodenm", i) + "</td>");
				sbListHtml.append("	<td align=\"center\" class=\"tableline11\" rowspan=\"" + listMap.getString("rowspan", i) + "\" >" + listMap.getString("grseq", i) + "</td>");
				sbListHtml.append("	<td align=\"center\" class=\"tableline11\" rowspan=\"" + listMap.getString("rowspan", i) + "\" >" + listMap.getString("selLecnm", i) + "</td>");
			}
			
			sbListHtml.append("	<td align=\"center\" class=\"tableline11\">" + listMap.getString("refLecnm", i) + "</td>");
			sbListHtml.append("	<td align=\"center\" class=\"tableline11\">" + listMap.getString("countStuUser", i) + "</td>");
			
			if( listMap.getInt("rowspan", i) > 0){
				sbListHtml.append("	<td align=\"center\" class=\"tableline11\" rowspan=\"" + listMap.getString("rowspan", i) + "\" >" + listMap.getString("countTotal", i) + "</td>");
				
				param = "javascript:fnForm('" + listMap.getString("grcode", i) + "','" + listMap.getString("grseq", i) + "','" + listMap.getString("subj", i) + "'); ";
				
				sbListHtml.append("	<td align=\"center\" class=\"tableline21\" rowspan=\"" + listMap.getString("rowspan", i) + "\" >");
				sbListHtml.append("		<a href=\"" + param + "\">지정하기</a>");
				sbListHtml.append("	</td>");
			}
			
			sbListHtml.append("</tr>");
			
		}
	}else{
		sbListHtml.append("<tr bgcolor=\"#FFFFFF\" height=\"100\">");
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
	pform.action = "class.do";
	pform.submit();
}

// 지정하기
function fnForm(grCode, grSeq, subj){

	var param = "?mode=stuFormList";
	param += "&commYear=" + $F("commYear");
	param += "&commGrcode=" + $F("commGrcode");
	param += "&commGrseq=" + $F("commGrseq");
	//param += "&commSubj=" + subj;
	param += "&grCode=" + grCode;
	param += "&grSeq=" + grSeq;
	param += "&subj=" + subj;
	

	
	pform.action = "class.do" + param;
	pform.submit();

}


//-->
</script>
<script for="window" event="onload">
<!--

	var commYear = "<%= requestMap.getString("commYear") %>";
	var commGrCode = "<%= requestMap.getString("commGrcode") %>";
	var commGrSeq = "<%= requestMap.getString("commGrseq") %>";
	
	var reloading = ""; 

	getCommYear(commYear);														// 년도
	getCommOnloadGrCode(reloading, commYear, commGrCode);						// 과정
	getCommOnloadGrSeq(reloading, commYear, commGrCode, commGrSeq);				// 기수
	

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
						<img src="/images/bullet003.gif"  align="bottom">&nbsp;<strong>입교자 반편성 리스트</strong>
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
								<td align="left" class="tableline11" bgcolor="#FFFFFF" style="padding:0 0 0 9" colspan="3">
									<div id="divCommGrSeq" class="commonDivLeft">
										<select name="commGrseq" style="width:100px;font-size:12px">
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
							<tr height="30" bgcolor="#5071B4">
								<td width="40" align="center" class="tableline11 white"><strong>No</strong></td>
								<td align="center" class="tableline11 white"><strong>과정명</strong></td>
								<td width="60" align="center" class="tableline11 white"><strong>과정기수</strong></td>
								<td align="center" class="tableline11 white"><strong>선택과목명</strong></td>
								<td align="center" class="tableline11 white"><strong>관련과목명</strong></td>
								<td width="60" align="center" class="tableline11 white"><strong>신청인원</strong></td>
								<td align="center" class="tableline11 white"><strong>과정입교<br>인원</strong></td>
								<td align="center" class="tableline21 white"><strong>지정하기</strong></td>
							</tr>
					
							<%= sbListHtml.toString() %>
					
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