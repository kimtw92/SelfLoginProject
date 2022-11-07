<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%  
// prgnm : 평가담당자 > 평가결과분석 > 평균추이도 > 과정평균추이도
// date : 2008-08-13
// auth : CHJ
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
	DataMap grCodeMap = (DataMap)request.getAttribute("grcodeMap");
	String optionStr="";
	
	for(int i=0;i<grCodeMap.keySize("grcode");i++){
		if(grCodeMap.getString("grcode",i).equals(requestMap.getString("commGrcode"))){
			optionStr +="<option value='"+grCodeMap.getString("grcode",i)+"'selected>"+grCodeMap.getString("grcodenm",i)+"</option>";
		}else{
			optionStr +="<option value='"+grCodeMap.getString("grcode",i)+"'>"+grCodeMap.getString("grcodenm",i)+"</option>";
		}
	}
%>
<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->
<html>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>점수별 성적분포도</title>
<head>
<script language="JavaScript" type="text/JavaScript">
<!--	
	//검색
	function go_search(){
		go_list();
	}
	//리스트
	function go_list(){
	
		$("mode").value = "courseHistory";
	
		pform.action = "/evalMgr/evalAnaly.do";
		pform.submit();
	}
	
	function search() {
		var form  = document.pform;
		var startyear  = form.startyear.value;
		var endyear   = form.endyear.value;
		var commGrcode   = form.commGrcode.value;

		if(commGrcode =="") {
			alert('과정명을 입력하세요');
			form.commGrcode.focus();
			return false;
		}
		if(startyear =="") {
			alert('시작년을 입력하세요');
			form.startyear.focus();
			return false;
		}
		if(endyear == "" ) {
			alert('종료년을 입력하세요');
			form.endyear.focus();
			return false;
		}
		embedAI('AIREPORT', "http://<%= Constants.AIREPORT_URL %>/report/report_56.jsp?p_startyear=" + startyear + "&p_endyear=" + endyear + "&p_grcode=" + commGrcode );  
	}
//-->
</script>
<script language="JavaScript" src="/AIViewer/AIScript.js"></script>
</head>
<body>
<form id="pform" name="pform" method="post">
	<input type="hidden" name="commYear" 			value="">
	<input type="hidden" name="menuId"				value="<%= requestMap.getString("menuId") %>">
	<input type="hidden" name="mode"					value="<%= requestMap.getString("mode") %>">
	<input type="hidden" name="qu"						value="">
	
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
						<img src="/images/bullet003.gif" width="11" height="11" align="bottom">&nbsp;<strong>과정평균추이도</strong>
					</td>
				</tr>
			</table>
			<!--// subTitle -->


			<!--[s] Contents Form  -->
			<table width="90%" align="center">
			<tr>
				<td>
					<table class="search01" align="center">			
					<tr>
						<th width="80" class="bl0">
							과정명 :
						</th>
						<td>
							<select name="commGrcode" style="font-size:12px">
								<option value="">** 선택 **</option>							
								<%=optionStr %>
							</select>
						</td>
						<th>
							기간 
						</th>
						<td>
							<input type="text" name="startyear" value="<%=requestMap.getString("startyear") %>" size=4 maxlength=4> ~ <input type=text name=endyear value="<%=requestMap.getString("endyear") %>" size=4 maxlength=4>
						</td>
						<td>
							<input type="button" value="조회" class="boardbtn1" onclick="search()">
						</td>	
					</tr>
					</table>				
				</td>
			</tr>			
			<tr>
				<td>
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td>&nbsp;</td>
						<td>
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td>
						                <iframe name="AIREPORT" src="#" width="100%" height="600" frameborder="0" border="1"></iframe>
								</td>
							</tr>						
							</table>
						</td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
					</tr>
					</table>
				</td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td>		
					<!--[e] Contents Form  -->
					<!-- space --><table width="100%" height="30"><tr><td></td></tr></table>				                            
				</td>
			</tr>
			</table>
		</td>
	</tr>
	</table>
</form>

<!--[s] bottom -->
<jsp:include page="/commonInc/include/commonAdminBottom.jsp" flush="false"/>
<!--[e] bottom -->
</body>
</html>
<script language="JavaScript" type="text/JavaScript">
<!--
	document.write(tagAIGeneratorOcx);
//-->
</script>