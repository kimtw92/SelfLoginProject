<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 사이버교육통계
// date  : 2008-08-05
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
	
	String rgrayn = Util.getValue(requestMap.getString("rgrayn"),"");
	String grseq = Util.getValue(requestMap.getString("grseq"),"");
	
	
	String bgColor = "";
	
	StringBuffer sbListHtml = new StringBuffer();
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	DataMap listMapTotal = (DataMap)request.getAttribute("LIST_DATA_TOTAL");
	

	if(listMap == null) listMap = new DataMap();
	listMap.setNullToInitialize(true);

	if(listMapTotal == null) listMapTotal = new DataMap();
	listMapTotal.setNullToInitialize(true);
	

	if(listMap.keySize("grcode") > 0){		
		sbListHtml.append("<tr bgcolor='#122cc1'>");		
		sbListHtml.append("	<td style=\"text-align:center\">&nbsp;<b>" + listMapTotal.getString("grcodeCnt", 0) + "개 과정 </b></td>");
		sbListHtml.append("	<td><b>"+listMapTotal.getString("manResucntCnt", 0)+"</b></td>");
		sbListHtml.append("	<td><b>"+listMapTotal.getString("woResucntCnt", 0)+"</b></td>");
		sbListHtml.append("	<td class=\"br0\"><b>"+listMapTotal.getString("totalCnt", 0)+"</b></td>");
		sbListHtml.append("</tr>");		

		for(int i=0; i < listMap.keySize("grcode"); i++){
			
			
			// tr 배경색
			if(i%2==0){
				bgColor = "bgcolor=\"#c3cccc\"";			
			}else{
				bgColor = "";
			}
			
			sbListHtml.append("<tr " + bgColor + " >");
			
			sbListHtml.append("	<td style=\"text-align: left\">&nbsp;" + listMap.getString("grcodeniknm", i) + "</td>");	

			sbListHtml.append("	<td>" + listMap.getString("manResucnt", i) + "</td>");
			sbListHtml.append("	<td>" + listMap.getString("woResucnt", i) + "</td>");
			sbListHtml.append("	<td class=\"br0\">"+listMap.getString("totno", i)+"</td>");

			sbListHtml.append("</tr>");												
		}
	}
	
	
%>

<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->

<script language="JavaScript">
<!--

// 검색
function fnSearch(){
	if(NChecker($("pform"))){
		if($("grseq").value == "") {
			alert("기수정보를 입력해주세요.");
			$("grseq").focus();
			return;
		}

		$("mode").value = "courseRgister";
		pform.action = "/statisMgr/stats.do";
		pform.submit();
	}
}

// 엑셀출력
function fnExcel(){
	if(NChecker($("pform"))){
		if($("grseq").value == "") {
			alert("기수정보를 입력해주세요.");
			$("grseq").focus();
			return;
		}

		$("mode").value = "courseRgisterExcel";
		pform.action = "/statisMgr/stats.do";
		pform.submit();
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
						<img src="/images/bullet003.gif"  align="bottom">&nbsp;<strong>과정별 등록현황</strong>
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
						<!-- tab -->
						<jsp:include page="topMenu.jsp" flush="false">
							<jsp:param name="tabIndex" value="12" />
						</jsp:include>
						<!-- //tab -->
						<div class="space01"></div>

						<!-- 검색  -->
						<table class="search01">
							<tr>
								<th width="80" class="bl0">
									검색 조건
								</th>
								<td>
									수료 포함 여부
									<select id="rgrayn" name="rgrayn">
									     <option value="" <%= "".equals(rgrayn) ? "selected":"" %>>전체</option>
									     <option value="N" <%= "N".equals(rgrayn) ? "selected":"" %>>미수료자만</option>
										 <option value="Y" <%= "Y".equals(rgrayn) ? "selected":"" %>>수료자만</option>									     
									</select>
									기수 입력
									<input type="text" class="textfield" name="grseq" id="grseq" maxlength="6" value="<%=grseq%>" style="width:60px" />
								</td>
								<td width="150" class="btnr">
									<input type="button" value="조회" onclick="fnSearch();" class="boardbtn1" />
									<input type="button" value="엑셀출력" onclick="fnExcel();" class="boardbtn1" />
								</td>
							</tr>
						</table>
						<!--//검색  -->	
						<div class="space01"></div>

						<!-- 리스트  -->
						<table class="datah01">
                            <colgroup>
                                <col width="40%" />
                                <col width="" />
                                <col width="" />
                                <col width="" />
                                <col width="" />
                                <col width="" />
                            </colgroup>
							<thead>							
							<tr>
								<th rowspan="2">과정명</th>
								<th colspan="2">성별</th>
								<th colspan="2">합계</th>
							</tr>
                            <tr>
								<th>남</th>
								<th>여</th>
                                <th>남여합</th>
							</tr>
							</thead>

							<tbody>
							<%= sbListHtml.toString() %>                            
							</tbody>
						</table>
						<!--//리스트  -->	
						<div class="h5"></div>
            						
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