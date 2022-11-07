<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 강사등급별실적
// date  : 2008-08-07
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
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	if(listMap == null) listMap = new DataMap();
	listMap.setNullToInitialize(true);

	if(listMap.keySize("levelName") > 0){		
		for(int i=0; i < listMap.keySize("levelName"); i++){
			
			sbListHtml.append("<tr>");
			sbListHtml.append("	<td>" + listMap.getString("levelName", i) + "</td>");
			sbListHtml.append("	<td>" + Util.moneyFormValue(listMap.getString("tutorCnt", i)) + "</td>");
			sbListHtml.append("	<td>" + Util.moneyFormValue(listMap.getString("stuScnt", i)) + "</td>");
			sbListHtml.append("	<td>" + Util.moneyFormValue(listMap.getString("lectime", i)) + "</td>");
			sbListHtml.append("	<td class=\"br0\">" + Util.moneyFormValue(listMap.getString("gmoney", i)) + "</td>");
			sbListHtml.append("</tr>");			
		}
	}else{
		sbListHtml.append("<tr><td style=\"height:100px\" colspan=\"5\">검색된 결과가 없습니다.</td></tr>");
	}
	
	
%>


<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->


<script language="JavaScript">
<!--

function fnSearch(){

	if(NChecker($("pform"))){
	
		if( $F("sDate") > $F("eDate") ){
			alert("시작일이 종료일보다 낮을수 없습니다.")
			return false;
		}else{
			$("mode").value = "tlevel";		
			pform.action = "/tutorMgr/stati.do";				
			pform.submit();
		}
	}

}


//-->
</script>
<script for="window" event="onload">
<!--

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
						<img src="/images/bullet003.gif"  align="bottom">&nbsp;<strong>강사등급별실적</strong>
					</td>
				</tr>
			</table>
			<!--[e] subTitle -->
			
			<div class="h10"></div>
			<!--[s] Contents Form  -->
			<table cellspacing="0" cellpadding="0" border="0" width="100%"
				class="contentsTable">
				<tr>
					<td>
						<!-- 검색  -->
						<table class="search01">
							<tr>
								<th width="80" class="bl0">
									기간
								</th>
								<td>
									<input type="text" class="textfield" name="sDate" value="<%=requestMap.getString("sDate")%>" style="width:70px" readonly required="true!시작일이 없습니다."/>
									<img style="cursor:hand" onclick="fnPopupCalendar('pform','sDate');" src="../images/icon_calen.gif" alt="" />
									~
									<input type="text" class="textfield" name="eDate" value="<%=requestMap.getString("eDate")%>" style="width:70px" readonly required="true!종료일이 없습니다."/>
									<img style="cursor:hand" onclick="fnPopupCalendar('pform','eDate');" src="../images/icon_calen.gif" alt="" />
								</td>
								<td width="100" class="btnr">
									<input type="button" value="검색" onclick="fnSearch();" class="boardbtn1">
								</td>
							</tr>
						</table>
						<!--//검색  -->	
						<div class="space01"></div>	

						<!--[s] 리스트  -->
						<table class="datah01">
							<colgroup>
								<col width="" />
								<col width="" />
								<col width="" />
								<col width="" />
								<col width="" />
							</colgroup>
							<thead>
							<tr>
								<th>등급</th>
								<th>강사</th>
								<th>교육인원</th>
								<th>강의시간</th>
								<th class="br0">강사료</th>
							</tr>
							</thead>

							<tbody>
							
							<%= sbListHtml.toString() %>
							
							</tbody>
						</table>
						<!--//[e] 리스트  -->
						<div class="space01"></div>
						
					</td>
				</tr>
			</table>
			<!--//[e] Contents Form  -->
			<div class="space_ctt_bt"></div>
			
			
		</td>
    </tr>
</table>

<!--[s] bottom -->
<jsp:include page="/commonInc/include/commonAdminBottom.jsp" flush="false"/>
<!--[e] bottom -->

</form>
</body>			