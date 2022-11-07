<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%  
// prgnm : 평가담당자 > 평가통계관리 > 성적분포도 > 기간별
// date : 2008-07-31
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
	DataMap totMap=(DataMap)request.getAttribute("TOT_DATA");
	totMap.setNullToInitialize(true);	
	DataMap jikMap=(DataMap)request.getAttribute("JIK_DATA");
	jikMap.setNullToInitialize(true);
	DataMap deptMap=(DataMap)request.getAttribute("DEPT_DATA");	
	deptMap.setNullToInitialize(true);
	DataMap ageMap=(DataMap)request.getAttribute("AGE_DATA");
	ageMap.setNullToInitialize(true);	
	DataMap sexMap=(DataMap)request.getAttribute("SEX_DATA");
	sexMap.setNullToInitialize(true);
		
	//직급별 리스트
	String jikStr="";
	for(int i=0;i<jikMap.keySize("dognm");i++){
		jikStr +="<tr bgcolor='ffffff'>";
		jikStr +="<td class='tableline11'><div align='center'><strong>"+jikMap.getString("dognm",i)+"</strong></div></td>";
		jikStr +="<td class='tableline11'><div align='center'><strong>"+jikMap.getString("totStucnt",i)+"명</strong></div></td>";		
		jikStr +="<td class='tableline11'><div align='center'><strong>"+jikMap.getString("tot60low",i)+"명</strong></div></td>";
		jikStr +="<td class='tableline11'><div align='center'><strong>"+jikMap.getString("tot70low",i)+"명</strong></div></td>";
		jikStr +="<td class='tableline11'><div align='center'><strong>"+jikMap.getString("tot80low",i)+"명</strong></div></td>";
		jikStr +="<td class='tableline11'><div align='center'><strong>"+jikMap.getString("tot90low",i)+"명</strong></div></td>";
		jikStr +="<td class='tableline11'><div align='center'><strong>"+jikMap.getString("tot90high",i)+"명</strong></div></td>";
		jikStr +="<td class='tableline11'><div align='center'><strong>"+jikMap.getString("totAvg",i)+"</strong></div></td>";
		jikStr +="<td class='tableline11'><div align='center'><strong>&nbsp;</strong></div></td>";
		jikStr +="</tr>";
	}
	
	//기관별 리스트
	String deptStr="";
	for(int i=0;i<deptMap.keySize("deptnm");i++){
		deptStr +="<tr bgcolor='ffffff'>";
		deptStr +="<td class='tableline11'><div align='center'><strong>"+deptMap.getString("deptnm",i)+"</strong></div></td>";
		deptStr +="<td class='tableline11'><div align='center'><strong>"+deptMap.getString("totStucnt",i)+"명</strong></div></td>";		
		deptStr +="<td class='tableline11'><div align='center'><strong>"+deptMap.getString("tot60low",i)+"명</strong></div></td>";
		deptStr +="<td class='tableline11'><div align='center'><strong>"+deptMap.getString("tot70low",i)+"명</strong></div></td>";
		deptStr +="<td class='tableline11'><div align='center'><strong>"+deptMap.getString("tot80low",i)+"명</strong></div></td>";
		deptStr +="<td class='tableline11'><div align='center'><strong>"+deptMap.getString("tot90low",i)+"명</strong></div></td>";
		deptStr +="<td class='tableline11'><div align='center'><strong>"+deptMap.getString("tot90high",i)+"명</strong></div></td>";
		deptStr +="<td class='tableline11'><div align='center'><strong>"+deptMap.getString("totAvg",i)+"</strong></div></td>";
		deptStr +="<td class='tableline11'><div align='center'><strong>&nbsp;</strong></div></td>";
		deptStr +="</tr>";
	}
		
	//연령별 리스트
	String ageStr="";
	for(int i=0;i<ageMap.keySize("age");i++){
		ageStr +="<tr bgcolor='ffffff'>";
		ageStr +="<td class='tableline11'><div align='center'><strong>"+ageMap.getString("age",i)+"</strong></div></td>";
		ageStr +="<td class='tableline11'><div align='center'><strong>"+ageMap.getString("totStucnt",i)+"명</strong></div></td>";		
		ageStr +="<td class='tableline11'><div align='center'><strong>"+ageMap.getString("tot60low",i)+"명</strong></div></td>";
		ageStr +="<td class='tableline11'><div align='center'><strong>"+ageMap.getString("tot70low",i)+"명</strong></div></td>";
		ageStr +="<td class='tableline11'><div align='center'><strong>"+ageMap.getString("tot80low",i)+"명</strong></div></td>";
		ageStr +="<td class='tableline11'><div align='center'><strong>"+ageMap.getString("tot90low",i)+"명</strong></div></td>";
		ageStr +="<td class='tableline11'><div align='center'><strong>"+ageMap.getString("tot90high",i)+"명</strong></div></td>";
		ageStr +="<td class='tableline11'><div align='center'><strong>"+ageMap.getString("totAvg",i)+"</strong></div></td>";
		ageStr +="<td class='tableline11'><div align='center'><strong>&nbsp;</strong></div></td>";
		ageStr +="</tr>";
	}
		
	//성별 리스트
	String sexStr="";
	for(int i=0;i<sexMap.keySize("sexnm");i++){
		sexStr +="<tr bgcolor='ffffff'>";
		sexStr +="<td class='tableline11'><div align='center'><strong>"+sexMap.getString("sexnm",i)+"</strong></div></td>";
		sexStr +="<td class='tableline11'><div align='center'><strong>"+sexMap.getString("totStucnt",i)+"명</strong></div></td>";		
		sexStr +="<td class='tableline11'><div align='center'><strong>"+sexMap.getString("tot60low",i)+"명</strong></div></td>";
		sexStr +="<td class='tableline11'><div align='center'><strong>"+sexMap.getString("tot70low",i)+"명</strong></div></td>";
		sexStr +="<td class='tableline11'><div align='center'><strong>"+sexMap.getString("tot80low",i)+"명</strong></div></td>";
		sexStr +="<td class='tableline11'><div align='center'><strong>"+sexMap.getString("tot90low",i)+"명</strong></div></td>";
		sexStr +="<td class='tableline11'><div align='center'><strong>"+sexMap.getString("tot90high",i)+"명</strong></div></td>";
		sexStr +="<td class='tableline11'><div align='center'><strong>"+sexMap.getString("totAvg",i)+"</strong></div></td>";
		sexStr +="<td class='tableline11'><div align='center'><strong>&nbsp;</strong></div></td>";
		sexStr +="</tr>";
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
	//로딩시.
	onload = function()	{	
	}
	
	//comm Selectbox선택후 리로딩 되는 함수.
	function go_reload(){
		go_list();
	}
	
	//리스트
	function go_list(){	
		$("mode").value = "date_list";
		pform.action = "/evalMgr/distribution.do";
		pform.submit();	
	}
	
	//교육기간 입력체크
	function check_form(){
		if($("a_started").value =="" || $("a_enddate").value==""){
			alert("교육기간을 입력하세요");
			$("a_started").focus();
		}else{
			go_list();
		}		
	}
//-->
</script>
</head>
<body>
<Div id='popCal' style='POSITION:absolute;visibility:hidden;border:2px ridge;width:10'>
<iframe name="popFrame" src="/popcalendar.htm" frameborder="0" marginwidth=0 marginheight=0 scrolling="no" width=183 height=188></iframe>
</DIV>
<form id="pform" name="pform" method="post">
	<input type="hidden" name="menuId"				value="<%= requestMap.getString("menuId") %>">
	<input type="hidden" name="mode"					value="<%= requestMap.getString("mode") %>">
	<input type="hidden" name="qu"					value="">
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
						<img src="/images/bullet003.gif" width="11" height="11" align="bottom">&nbsp;<strong>기간별</strong>
					</td>
				</tr>
			</table>
			<!--// subTitle -->
			<table width="100%" border="0" cellspacing="0" cellpadding="0" class="contentsSubTitleTable" >
				<tr> 
					<td>&nbsp;</td>
					<td align=right>
						교육기간
						<input type = text name ="a_started" size = 8 maxlength = 8 value = "<%=requestMap.getString("a_started") %>" readonly>
						<a href = "javascript:void(0)" onclick="fnPopupCalendar('', 'a_started');return false" style="cursor:hand;">
							<img src = "/images/icon_calendar.gif" border = 0 align = absmiddle>
						</a> ~
						<input type = text name ="a_enddate" size = 8 maxlength = 8 value = "<%=requestMap.getString("a_enddate") %>" readonly>
						<a href = "javascript:void(0)" onclick="fnPopupCalendar('', 'a_enddate');return false" style="cursor:hand;">
							<img src = "/images/icon_calendar.gif" border = 0 align = absmiddle>
						</a>
					<input type="button" value="검색" class="boardbtn1" onclick="javascript:check_form();">

					</td>
					<td></td>
				</tr>				
				<tr> 
					<td>&nbsp;</td>
					<td>
						<table width="100%" border="0" cellpadding="0" cellspacing="0">
							<tr bgcolor="#375694"> 
								<td height="2" colspan="9"></td>
							</tr>
							<tr bgcolor="#5071B4"  height='28' > 
								<td width="150"  align='center' class="tableline11 white"><div align="center"><strong>구분</strong></div></td>
								<td width="90"   align='center' class="tableline11 white"><div align="center"><strong>계</strong></div></td>
								<td width="90"   align='center' class="tableline11 white"><div align="center"><strong>60%미만</strong></div></td>
								<td width="90"   align='center' class="tableline11 white"><div align="center"><strong>70%미만</strong></div></td>
								<td width="90"   align='center' class="tableline11 white"><div align="center"><strong>80%미만</strong></div></td>
								<td width="90"   align='center' class="tableline11 white"><div align="center"><strong>90%미만</strong></div></td>
								<td width="90"   align='center' class="tableline11 white"><div align="center"><strong>90%이상</strong></div></td>
								<td width="90"   align='center' class="tableline11 white"><div align="center"><strong>평균점수</strong></div></td>
								<td width="50"   align='center' class="tableline11 white"><div align="center"><strong>비고</strong></div></td>
							</tr>

							<tr bgcolor="ffffff"> 
								<td class="tableline11"><div align="center"><strong>인원</strong></div></td>							
								<td class="tableline11"><div align="center"><strong><%=totMap.getString("totStucnt")+"명" %></strong></div></td>							
								<td class="tableline11"><div align="center"><strong><%=totMap.getString("tot60low")+"명" %></strong></div></td>
								<td class="tableline11"><div align="center"><strong><%=totMap.getString("tot70low")+"명" %></strong></div></td>
								<td class="tableline11"><div align="center"><strong><%=totMap.getString("tot80low")+"명" %></strong></div></td>
								<td class="tableline11"><div align="center"><strong><%=totMap.getString("tot90low")+"명" %></strong></div></td>
								<td class="tableline11"><div align="center"><strong><%=totMap.getString("tot90high")+"명" %></strong></div></td>
								<td class="tableline11"><div align="center"><strong><%=totMap.getString("totAvg") %></strong></div></td>
								<td class="tableline11"><div align="center"><strong>&nbsp;</strong></div></td>
							</tr>

							<tr bgcolor="F7F7F7"> 
								<td class="tableline11"><div align="center"><strong>(직급별)</strong></div></td>
								<td class="tableline11" colspan="8">&nbsp;</td>
							</tr>
							<%=jikStr %>
							<tr bgcolor="F7F7F7"> 
								<td class="tableline11"><div align="center"><strong>(기관별)</strong></div></td>
								<td class="tableline11" colspan=8>&nbsp;</td>
							</tr>
							<%=deptStr %>
							<tr bgcolor="F7F7F7"> 
								<td class="tableline11"><div align="center"><strong>(연령별)</strong></div></td>
								<td class="tableline11" colspan=8>&nbsp;</td>
							</tr>
							<%=ageStr %>
							<tr bgcolor="F7F7F7"> 
								<td class="tableline11"><div align="center"><strong>(성별)</strong></div></td>
								<td class="tableline11" colspan=8>&nbsp;</td>
							</tr>
							<%=sexStr %>
						</table>
					</td>
					<td></td>
				</tr>
			</table>
			<!-- space --><table width="100%" height="30"><tr><td></td></tr></table>				                            		
	</td>
</tr>
</table>
<!--[s] bottom -->
<jsp:include page="/commonInc/include/commonAdminBottom.jsp" flush="false"/>
<!--[e] bottom -->
</body>
</html>