<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%  
// prgnm : 기초코드관리 과정분류코드관리
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


	//mainContent List date
	DataMap mainListMap = (DataMap)request.getAttribute("LIST_DATA");
	mainListMap.setNullToInitialize(true);
	
	//subListContent List date
	DataMap subListMap = (DataMap)request.getAttribute("SUBLIST_DATA");
	subListMap.setNullToInitialize(true);

	DataMap mainCodeRow = (DataMap)request.getAttribute("ROW_DATA");
	mainCodeRow.setNullToInitialize(true);
	
	
	//컨텐츠 본문영역 메인 리스트
	StringBuffer mainListHtml = new StringBuffer(); 
	

	String cdGubun = "";
	String majorCode = "";
	String minorCode = "";
	if(mainListMap.keySize("mcodeName") > 0){
		for(int i=0; i < mainListMap.keySize(); i++){ 
	
			cdGubun = mainListMap.getString("cdGubun",i);
			majorCode = mainListMap.getString("majorCode",i);
	
			//과정분류코드 링크 URL
			String link = "cdGubun=";
			link += cdGubun;
			link += "&majorCode=";
			link += majorCode;
			link += "&sub_name=";
			link += mainListMap.getString("mcodeName",i);
			link += "&menuId=";
			link += requestMap.getString("menuId");
			
			//html Content영역 [s]
			mainListHtml.append("<tr>");
			mainListHtml.append("<td align='center'><a href=\"/baseCodeMgr/mainCode.do?"+link +"\">" + "" + cdGubun + majorCode +"</a>");
			mainListHtml.append("<td align='center'>"+mainListMap.getString("mcodeName",i)+"</td>");
			mainListHtml.append("<td align='center'>"+mainListMap.getString("subCount",i)+"</td>");
			mainListHtml.append("<td align='center'>"+mainListMap.getString("useYn",i)+"</td>");
			mainListHtml.append("<td align='center' class='br0'><input type=\"button\" class=\"boardbtn1\" value=\"수정\" onClick=\"go_maincodeForm('update', '" + cdGubun + "', '" + majorCode + "');\" ></td>");
			mainListHtml.append("<tr>");
			//html Content영역 [e]
		}
	}else{
		mainListHtml.append("<tr bgcolor=\"FFFFFF\">");
		mainListHtml.append("<td colspan=\"100%\" style=\"height:100\" align=\"center\" class=\"br0\"> 등록된 데이터가 없습니다.");
		mainListHtml.append("</td>");
		mainListHtml.append("</tr");
	}
	
	
	//컨텐츠 본문영역 서브 리스트
	StringBuffer sbListHtml = new StringBuffer(); 
	
	if(!requestMap.getString("cdGubun").equals("")){
		
		sbListHtml.append("<table width='100%' border='0' class=\"datah01\" cellspacing='0' cellpadding='0'>");
		sbListHtml.append("<tr>");
		sbListHtml.append("<td height=\"50\" colspan='4' class=\"br0\" align=\"center\" valign=\"middle\">");
		sbListHtml.append("<strong>과정분류코드&nbsp;:&nbsp;"+ mainCodeRow.getString("cdGubun")+mainCodeRow.getString("majorCode")+"&nbsp;&nbsp;&nbsp;&nbsp;과정분류명&nbsp;:&nbsp;"+mainCodeRow.getString("mcodeName")+"</strong>");
		sbListHtml.append("</td>");
		sbListHtml.append("</tr>");

		sbListHtml.append("<tr bgcolor=\"#5071B4\">");
		sbListHtml.append("<td height=\"28\" class=\"white\" align=\"center\"><strong>과정상세분류코드</strong></td>");
		sbListHtml.append("<td height=\"28\" class=\"white\" align=\"center\"><strong>과정상세분류명</strong></td>");
		sbListHtml.append("<td height=\"28\" class=\"white\" align=\"center\"><strong>사용여부</strong></td>");
		sbListHtml.append("<td height=\"28\" class=\"br0 white\" align=\"center\"><strong>기능</strong></td>");
		sbListHtml.append("</tr>");
		if(subListMap.keySize("cdGubun") > 0){
			for(int i=0; i < subListMap.keySize("cdGubun"); i++){
				cdGubun = subListMap.getString("cdGubun",i);
				majorCode = subListMap.getString("majorCode",i);
				minorCode = subListMap.getString("minorCode",i);
				
				sbListHtml.append("<tr bgcolor=\"FFFFFF\">");
				sbListHtml.append("<td height=\"28\" align=\"center\">"+subListMap.getString("minorCode",i)+"</td>");
				sbListHtml.append("<td height=\"28\" align=\"center\">"+subListMap.getString("scodeName",i)+"</td>");
				sbListHtml.append("<td height=\"28\" align=\"center\">"+subListMap.getString("useYn",i)+"</td>");
				
				sbListHtml.append("<td align='center' class='br0'><input type=\"button\" class=\"boardbtn1\" value=\"수정\" onClick=\"go_subcodeForm('update', '" + cdGubun + "', '" + majorCode +"', '"+ minorCode + "');\" ></td>");
				//sbListHtml.append("<td height=\"28\" class=\"br0\" align=\"center\"><a href=\"javascript:go_subcodeForm('update', '"+cdGubun+"', '"+majorCode+"', '" + minorCode +"');\"><strong>수정</strong></a></td>");
				sbListHtml.append("</tr>");
				
			}
		}else if(subListMap.keySize("cdGubun") <= 0 && !requestMap.getString("majorCode").equals("")){
			sbListHtml.append("<tr bgcolor=\"FFFFFF\">");
			sbListHtml.append("<td colspan=\"100%\" style=\"height:100\" align=\"center\" class=\"br0\"> 등록된 데이터가 없습니다.");
			sbListHtml.append("</td>");
			sbListHtml.append("</tr");
		}
		sbListHtml.append("</table>");
	}
	
%>

<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->


<script language="JavaScript" type="text/JavaScript">
	
	//과정분류 코드추가
	function go_maincodeForm(tu, cdGubun, majorCode){
		$("mode").value = "majorForm";
		$("tu").value = tu;
		$("cdGubun").value = cdGubun;
		$("majorCode").value = majorCode;
		var popWindow = popWin('about:blank', 'majorPop11', '300', '250', 'no', 'no')
		pform.action = "/baseCodeMgr/mainCode.do";
		pform.target = "majorPop11";
		pform.submit();
		pform.target = "";
	}
	
	//상세분류 코드추가
	function go_subcodeForm(tu, cdGubun, majorCode,minorCode){
		$("mode").value = "minorForm";
		$("tu").value = tu;
		$("cdGubun").value = cdGubun;
		$("majorCode").value = majorCode;
		$("minorCode").value = minorCode;
		pform.action = "/baseCodeMgr/mainCode.do";
		var popWindow = popWin('about:blank', 'majorPop11', '300', '250', 'no', 'no')
		pform.target = "majorPop11";
		pform.submit();
		pform.target = "";
		
	}
	//리플레쉬
	function mainCodeList(mode){
		$("mode").value = "";
		$("cdGubun").value = "";
		$("minorCode").value = "";
		$("majorCode").value = "";
		$("tu").value = "";
				
		pform.action = "/baseCodeMgr/mainCode.do";
		pform.submit();
	}
	
</script>


<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<form id="pform" name="pform" method="post">
<input type="hidden" name="menuId"	 		value="<%=requestMap.getString("menuId")%>">
<input type="hidden" name="mode" 			value="<%=requestMap.getString("mode") %>">

<input type="hidden" name="cdGubun"  		value="">
<input type="hidden" name="minorCode" 		value="">
<input type="hidden" name="majorCode" 		value="">
<input type="hidden" name="tu" 				value="">
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

			<!-- subTitle -->
			<!-- space --><table width="100%" height="10"><tr><td></td></tr></table>
			<table width="100%" border="0" cellspacing="0" cellpadding="0" class="contentsSubTitleTable">
				<tr>
					<td height="20">
						<img src="/images/bullet003.gif" width="11" height="11" align="bottom">&nbsp;<strong>과정분류코드관리</strong>
					</td>
				</tr>
			</table>
			<!--// subTitle -->
			
			<!--[s] Contents Form  -->
			<div class="h10"></div>
			<table cellspacing="0" cellpadding="0" border="0" width="100%" class="contentsTable">
				<tr>
					<td>
										
						<!---[s] content -->

						<!-- space -->
						<div class="space01"></div>		
										
						<!-- 상단 버튼  -->
						<table class="btn01">
							<tr>
								<td align="right" height="28" align="center" width="25%">
									<input type="button" value='과정분류코드추가' onclick="go_maincodeForm('insert', '', '')" class="boardbtn1">&nbsp;&nbsp;
									<input type="button" value='상세분류코드추가' onclick="go_subcodeForm('insert', '', '','')" class="boardbtn1">&nbsp;&nbsp;
									<input type="button" value='리스트' onclick="mainCodeList('list')" class="boardbtn1">&nbsp;&nbsp;
								</td>
							</tr>
							<tr><td height="5"></td></tr>
						</table>						
						<!--// 상단 버튼  -->
						
						<!---[s] mainList -->
						<table width="100%" border="0" cellspacing="0" cellpadding="0" class="datah01">
							<tr height="28" bgcolor="#5071B4">
								<td height="28" align="center" class="white" width="25%"><strong>과정분류코드</strong></td>
								<td height="28" align="center" class="white" width="20%"><strong>과정분류명</strong></td>
								<td height="28" align="center" class="white" width="25%"><strong>상세분류코드수</strong></td>
								<td height="28" align="center" class="white" width="20%"><strong>사용여부</strong></td>
								<td height="28" align="center" class="br0 white" width="10%"><strong>기능</strong></td>
							</tr>

							<%= mainListHtml.toString()%>

						</table>
						<!---[e] mainList -->
						<div class="space01"></div>		
						<!---[s] subList -->
						<%=sbListHtml.toString() %>
						<!---[e] subnList -->
						
						<!---[e] content -->
						
						<!-- space -->
						<div class="space01"></div>		

					</td>
				</tr>
				
			</table>
			<!--[e] Contents Form  -->
		</td>
	</tr>
	<tr>
					<td colspan="100%" class="br0" height="30">&nbsp;</td>
				</tr>
</table>

<!--[s] bottom -->
<jsp:include page="/commonInc/include/commonAdminBottom.jsp" flush="false"/>
<!--[e] bottom -->

</form>
</body>

