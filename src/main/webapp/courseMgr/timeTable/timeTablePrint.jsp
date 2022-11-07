<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 시간표 출력양식
// date : 2008-08-01
// auth : LYM
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


	//리스트
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	listMap.setNullToInitialize(true);

	String tmpStr = "";

	String[] grcode = {"", "", "", "", ""};
	String[] grseq = {"", "", "", "", ""};
	String[] week = {"", "", "", "", ""};
	String[] title = {"", "", "", "", ""};
	String[] classroom = {"", "", "", "", ""};


	int count = 0;

	for(int i=0; i < listMap.keySize("grcode"); i++){

		count++;

		grcode[i] = listMap.getString("grcode", i);
		grseq[i] = listMap.getString("grseq", i);
		week[i] = listMap.getString("studyweek", i);
		title[i] = listMap.getString("grcodeniknm", i) + " " + StringReplace.subString(listMap.getString("grseq", i), 4, 6) + "기";
		classroom[i] = listMap.getString("classroom_name", i);

		if(count == 4)
			break;
		else if(count == 5)
			break;

	}

	String scriptStr = "";
	String mentStr = "";

	//조회 시만
	if(requestMap.getString("search").equals("GO")){

		if(requestMap.getString("search").equals("GO") && count > 0)
			scriptStr = "window.setTimeout(\"report_pop1('" + count + "')\", 500)";
		else
			mentStr = "<br><br><center>해당기간에 등록된 시간표가 없습니다.</center>";

	}



%>

<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->

<script language="JavaScript" type="text/JavaScript">
<!--

//검색
function go_search(){
	go_list();
}
//리스트
function go_list(){

	$("mode").value = "print";

	pform.action = "/courseMgr/timeTable.do";
	pform.submit();

}



//시간표로 돌아가기
function go_timeTableList(){

	$("mode").value = "list";

	pform.action = "/courseMgr/timeTable.do";
	pform.submit();

}

//AI 출력
function report_pop1(tm_cnt) {
	if (tm_cnt == '5') 
		embedAI('AIREPORT', 'http://<%= Constants.AIREPORT_URL %>/report/report_24.jsp?p_grcode1=<%= grcode[0] %>&p_grseq1=<%= grseq[0] %>&p_week1=<%= week[0] %>&p_type1=<%= requestMap.getString("searchType") %>&p_limit1=&p_tmtitle1=<%= title[0] %>&p_clroom1=<%= classroom[0] %>&p_grcode2=<%= grcode[1] %>&p_grseq2=<%= grseq[1] %>&p_week2=<%= week[1] %>&p_type2=<%= requestMap.getString("searchType") %>&p_limit2=&p_tmtitle2=<%= title[1] %>&p_clroom2=<%= classroom[1] %>&p_grcode3=<%= grcode[2] %>&p_grseq3=<%= grseq[2] %>&p_week3=<%= week[2] %>&p_type3=<%= requestMap.getString("searchType") %>&p_limit3=&p_tmtitle3=<%= title[2] %>&p_clroom3=<%= classroom[2] %>&p_grcode4=<%= grcode[3] %>&p_grseq4=<%= grseq[3] %>&p_week4=<%= week[3] %>&p_type4=<%= requestMap.getString("searchType") %>&p_limit4=&p_tmtitle4=<%= title[3] %>&p_clroom4=<%= classroom[3] %>&p_grcode5=<%= grcode[4] %>&p_grseq5=<%= grseq[4] %>&p_week5=<%= week[4] %>&p_type5=<%= requestMap.getString("searchType") %>&p_limit5=&p_tmtitle5=<%= title[4] %>&p_clroom5=<%= classroom[4] %>');
	else if (tm_cnt == '4') 
		embedAI('AIREPORT', 'http://<%= Constants.AIREPORT_URL %>/report/report_23.jsp?p_grcode1=<%= grcode[0] %>&p_grseq1=<%= grseq[0] %>&p_week1=<%= week[0] %>&p_type1=<%= requestMap.getString("searchType") %>&p_limit1=&p_tmtitle1=<%= title[0] %>&p_clroom1=<%= classroom[0] %>&p_grcode2=<%= grcode[1] %>&p_grseq2=<%= grseq[1] %>&p_week2=<%= week[1] %>&p_type2=<%= requestMap.getString("searchType") %>&p_limit2=&p_tmtitle2=<%= title[1] %>&p_clroom2=<%= classroom[1] %>&p_grcode3=<%= grcode[2] %>&p_grseq3=<%= grseq[2] %>&p_week3=<%= week[2] %>&p_type3=<%= requestMap.getString("searchType") %>&p_limit3=&p_tmtitle3=<%= title[2] %>&p_clroom3=<%= classroom[2] %>&p_grcode4=<%= grcode[3] %>&p_grseq4=<%= grseq[3] %>&p_week4=<%= week[3] %>&p_type4=<%= requestMap.getString("searchType") %>&p_limit4=&p_tmtitle4=<%= title[3] %>&p_clroom4=<%= classroom[3] %>');
	else if (tm_cnt == '3') 
		embedAI('AIREPORT', 'http://<%= Constants.AIREPORT_URL %>/report/report_22.jsp?p_grcode1=<%= grcode[0] %>&p_grseq1=<%= grseq[0] %>&p_week1=<%= week[0] %>&p_type1=<%= requestMap.getString("searchType") %>&p_limit1=&p_tmtitle1=<%= title[0] %>&p_clroom1=<%= classroom[0] %>&p_grcode2=<%= grcode[1] %>&p_grseq2=<%= grseq[1] %>&p_week2=<%= week[1] %>&p_type2=<%= requestMap.getString("searchType") %>&p_limit2=&p_tmtitle2=<%= title[1] %>&p_clroom2=<%= classroom[1] %>&p_grcode3=<%= grcode[2] %>&p_grseq3=<%= grseq[2] %>&p_week3=<%= week[2] %>&p_type3=<%= requestMap.getString("searchType") %>&p_limit3=&p_tmtitle3=<%= title[2] %>&p_clroom3=<%= classroom[2] %>');
	else if (tm_cnt == '2') 
		embedAI('AIREPORT', 'http://<%= Constants.AIREPORT_URL %>/report/report_21.jsp?p_grcode1=<%= grcode[0] %>&p_grseq1=<%= grseq[0] %>&p_week1=<%= week[0] %>&p_type1=<%= requestMap.getString("searchType") %>&p_limit1=&p_tmtitle1=<%= title[0] %>&p_clroom1=<%= classroom[0] %>&p_grcode2=<%= grcode[1] %>&p_grseq2=<%= grseq[1] %>&p_week2=<%= week[1] %>&p_type2=<%= requestMap.getString("searchType") %>&p_limit2=&p_tmtitle2=<%= title[1] %>&p_clroom2=<%= classroom[1] %>');
	else if (tm_cnt == '1') 
		embedAI('AIREPORT', 'http://<%= Constants.AIREPORT_URL %>/report/report_19.jsp?p_grcode1=<%= grcode[0] %>&p_grseq1=<%= grseq[0] %>&p_week1=<%= week[0] %>&p_type1=<%= requestMap.getString("searchType") %>&p_limit1=&p_tmtitle1=<%= title[0] %>&p_clroom1=<%= classroom[0] %>');
	else
		embedAI('AIREPORT', 'http://<%= Constants.AIREPORT_URL %>/report/report_19.jsp?p_grcode1=<%= grcode[0] %>&p_grseq1=<%= grseq[0] %>&p_week1=<%= week[0] %>&p_type1=<%= requestMap.getString("searchType") %>&p_limit1=&p_tmtitle1=<%= title[0] %>&p_clroom1=<%= classroom[0] %>');
}



//로딩시.
onload = function()	{

	<%= scriptStr %>
}

//-->
</script>
<script language="JavaScript" src="/AIViewer/AIScript.js"></script>

<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<form id="pform" name="pform" method="post">
<input type="hidden" name="menuId"				value="<%= requestMap.getString("menuId") %>">
<input type="hidden" name="mode"				value="<%= requestMap.getString("mode") %>">

<input type="hidden" name="search"				value="GO">

<input type="hidden" name="studyWeek"			value="<%=requestMap.getString("studyWeek")%>">
<input type="hidden" name="searchKey"			value="<%=requestMap.getString("searchKey")%>">


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


			<div class="h10"></div>

			<!--[s] Contents Form  -->
			<table cellspacing="0" cellpadding="0" border="0" width="100%"
				class="contentsTable">
				<tr>
					<td>

						<!-- 검색 -->
						<table class="search01">
							<tr>
								<th width="80" class="bl0">
									기간선택
								</th>
								<td width="35%">
									<input type="text" class="textfield" name="searchStarted" value="<%= requestMap.getString("searchStarted") %>" style="width:70px" readonly> <img src="/images/icon_calen.gif" align="middle" onclick="fnPopupCalendar('', 'searchStarted');" style="cursor:hand;"/>
									~
									<input type="text" class="textfield" name="searchEnddate" value="<%= requestMap.getString("searchEnddate") %>" style="width:70px" readonly> <img src="/images/icon_calen.gif" align="middle" onclick="fnPopupCalendar('', 'searchEnddate');" style="cursor:hand;" />
								</td>
								<th width="80">
									구분
								</th>
								<td width="25%">
									<input type="radio" class="chk_01" name="searchType" id="label1" value="M" <%= requestMap.getString("searchType").equals("M") ? "checked" : ""%>><label for="label1">과정운영자용</label>
									<input type="radio" class="chk_01" name="searchType" id="label2" value="S" <%= requestMap.getString("searchType").equals("S") ? "checked" : ""%>><label for="label2">학생용</label>
								</td>
								<td width="100" class="btnr">
									<input type="button" value="검색" onclick="go_search();" class="boardbtn1">
								</td>
							</tr>
						</table>
						<!--//검색 -->	
						<div class="space01"></div>

						<!-- [s] 상단 버튼  -->
						<table class="btn01">
							<tr>
								<td class="right">
									<input type="button" value="시간표 설정" onclick="go_timeTableList();" class="boardbtn1">
								</td>
							</tr>
						</table>
						<!-- //[e] 상단 버튼  -->

						<div class="space01"></div>


						<table width="100%" border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td width="100%" align="right">
									<%= mentStr %>
									<iframe name="AIREPORT" src="#" width="100%" height="600" frameborder="0" frameborder='0'></iframe>
								</td>
							</tr>
						</table>


					</td>
				</tr>
			</table>
			<!--//[e] Contents Form  -->
			<div class="space_ctt_bt"></div>
<!--[ 코딩 끝 ] ------------------------------------------------------------------------------------------------------>



				                            
        </td>
    </tr>
</table>

<!--[s] bottom -->
<jsp:include page="/commonInc/include/commonAdminBottom.jsp" flush="false"/>
<!--[e] bottom -->
	
</form>

<script language="JavaScript">
//AI Report
document.write(tagAIGeneratorOcx);
</script>

</body>

