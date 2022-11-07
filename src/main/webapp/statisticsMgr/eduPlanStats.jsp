<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 교육훈련성적
// date  : 2008-08-04
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
	String statType = Util.getValue(requestMap.getString("statType"),"avg");
	
	
	
	
%>
<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->

<script language="JavaScript" src="/AIViewer/AIScript.js"></script>

<script language="JavaScript">
<!--


// 리스트
function fnDetailAjax(){

	if(NChecker($("pform"))){
		var url = "/statisMgr/stats.do";
		var pars = "";
		
		if( Form.Element.getValue("statType1") != null ){
			pars = "mode=eduAvg";
		}else{
			pars = "mode=eduRange";
		}
		
		pars += "&searchYear=" + $F("searchYear");
	
		var divId = "divList";
		
		var myAjax = new Ajax.Updater(
			{success:divId},
			url, 
			{
				asynchronous : "true",
				method : "get", 
				parameters : pars,
				onLoading : function(){
					$(document.body).startWaiting('bigWaiting');
				},
				onSuccess : function(){					
					window.setTimeout( $(document.body).stopWaiting.bind( $(document.body) ), 500);
				},
				onFailure : function(){	
					window.setTimeout( $(document.body).stopWaiting.bind( $(document.body) ), 500);
					alert("데이타 가져오는데 오류가 발생했습니다.");			
				}
			}
		);
	}
}

// AIReport
function fnAIReport(){

	var param = "";
	var url = "http://<%= Constants.AIREPORT_URL %>";
	
	if(NChecker($("pform"))){
		if( Form.Element.getValue("statType1") != null ){
			popAI(url + "/report/report_10.jsp?p_startyear=" + $F("searchYear"));
		}else{
			popAI(url + "/report/report_11.jsp?p_startyear=" + $F("searchYear"));
		}
	}
}

// 엑셀
function fnExcel(){
	if(NChecker($("pform"))){
		if( Form.Element.getValue("statType1") != null ){
			$("mode").value = "eduAvgExcel";
		}else{
			$("mode").value = "eduRangeExcel";
		}
		
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
						<img src="/images/bullet003.gif"  align="bottom">&nbsp;<strong>교육훈련성적</strong>
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
							<jsp:param name="tabIndex" value="4" />
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
									<input type="radio" name="statType" value="avg" id="statType1" <%= statType.equals("avg") ? "checked" : "" %> >
									<label for="statType1">
										평균성적 
									</label>

                                    <input type="radio" name="statType" value="range" id="statType2" <%= statType.equals("range") ? "checked" : "" %> >
									<label for="statType2">
										성적분포
									</label>
								</td>
                                <td width="200" class="btnr" rowspan="2">
									<input type="button" value="조회" onclick="fnDetailAjax();" class="boardbtn1" />
									<input type="button" value="출력" onclick="fnAIReport();" class="boardbtn1" />
                                    <input type="button" value="EXCEL" onclick="fnExcel();" class="boardbtn1" />
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
						<div id="divList"></div>																		
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
    document.write(tagAIGeneratorOcx);
    
</script>