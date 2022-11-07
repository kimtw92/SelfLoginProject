<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 대상별 교육훈련실적 - 직급별
// date  : 2008-07-23
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
	
	String searchYear = Util.getValue(requestMap.getString("searchYear"),(String)request.getAttribute("DATE_YEAR"));
	
	String dept = "";
	if( memberInfo.getSessClass().equals("3")){
		dept = Util.getValue( memberInfo.getSessDept() );
	}
	
%>


<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->

<script language="JavaScript" src="/AIViewer/AIScript.js"></script>

<script language="JavaScript">
<!--

document.write(tagAIGeneratorOcx);

// 검색
function fnSearch(){

	var mode = "";

	if(NChecker($("pform"))){
	
		if( Form.Element.getValue("ptype1") != null ){
			fnAIReport();
			
		}else if( Form.Element.getValue("ptype2") != null ){
			mode = "tjikr";
			$("mode").value = mode;
			pform.action = "/statisMgr/stats.do";
			pform.submit();
			
		}else if( Form.Element.getValue("ptype3") != null ){
			mode = "dept";
			$("mode").value = mode;
			pform.action = "/statisMgr/stats.do";
			pform.submit();
			
		}else if( Form.Element.getValue("ptype4") != null ){
			mode = "human";
			$("mode").value = mode;
			pform.action = "/statisMgr/stats.do";
			pform.submit();
		}					
	}
}

function fnAIReport(){

	var param = "";
	var url = "http://<%= Constants.AIREPORT_URL %>/report/report_12.jsp";
	if(NChecker($("pform"))){
	
		param = "?p_year=" + $F("searchYear");
		param += "&p_dept=<%=dept%>";
			
		embedAI('AIREPORT', url + param );		
	}
}


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
						<img src="/images/bullet003.gif"  align="bottom">&nbsp;<strong>대상별 교육훈련실적</strong>
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
							<jsp:param name="tabIndex" value="5" />
						</jsp:include>
						<!-- //tab -->
						<div class="space01"></div>

						<!-- 검색  -->
						<table class="search01">
                            <tr>
								<th width="80" class="bl0">
									대상선택 
								</th>
								<td>
									<input type="radio" name="ptype" id="ptype1" value="position" checked>
									<label for="ptype1">
										직급별
									</label>

                                    <input type="radio" name="ptype" id="ptype2" value="tjikr" >
									<label for="ptype2">
										직렬별
									</label>

									<input type="radio" name="ptype" id="ptype3" value="dept">
									<label for="ptype3">
										소속별
									</label>

									<input type="radio" name="ptype" id="ptype4" value="human">
									<label for="ptype4">
										남여별
									</label>
								</td>
								<td width="130" class="btnr" rowspan="2">
									<input type="button" value="조회" onclick="fnSearch();" class="boardbtn1" />
								</td>
							</tr>
							<tr>
								<th width="80" class="bl0">
									교육년도
								</th>
								<td>
									<input type="text" class="textfield" name="searchYear" id="searchYear" value="<%= searchYear %>" maxlength="4" style="width:50px" required="true!년도가 없습니다." dataform="num!숫자만 입력해야 합니다." />
								</td>
							</tr>
						</table>
						<!--//검색  -->	
						<div class="space01"></div>

						<!-- 리스트  -->
						<iframe name="AIREPORT" src="#" width="100%" height="600" frameborder="0"></iframe>
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

<script language="JavaScript">
<!--
	window.setTimeout("fnSearch()", 500);
//-->
</script>

