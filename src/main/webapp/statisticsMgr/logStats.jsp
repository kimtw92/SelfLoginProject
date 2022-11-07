<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 접속통계
// date  : 2008-08-13
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
	
	String tmpToDay = (String)request.getAttribute("DATE_TODAY");
	String sDate = Util.getValue(requestMap.getString("sDate"),(String)request.getAttribute("DATE_FROM"));
	String eDate = Util.getValue(requestMap.getString("eDate"),(String)request.getAttribute("DATE_TO"));
	String ptype = Util.getValue( requestMap.getString("ptype"),"day");
	
	
	// 리스트
	StringBuffer sbListHtml = new StringBuffer();
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	if(listMap == null) listMap = new DataMap();
	listMap.setNullToInitialize(true);
	
	String txtRegDate = "";
	String bgColor = "";
	
	if(listMap.keySize("regDate") > 0){		
		for(int i=0; i < listMap.keySize("regDate"); i++){
			
			// tr 배경색
			if(listMap.getString("pflag", i).equals("A")){
				bgColor = "bgcolor=\"#cccccc\"";
				txtRegDate = listMap.getString("regDate", i) + " 누계";
			}else if(listMap.getString("pflag", i).equals("B")){
				bgColor = "";
				txtRegDate = listMap.getString("regDate", i);
			}
			
			sbListHtml.append("<tr " + bgColor + " >");
			sbListHtml.append("	<td>" + txtRegDate + "</td>");
			sbListHtml.append("	<td>" + Util.moneyFormValue(listMap.getString("countNlogin", i)) + "</td>");
			sbListHtml.append("	<td>" + Util.moneyFormValue(listMap.getString("countLogin", i)) + "</td>");
			sbListHtml.append("	<td>" + Util.moneyFormValue(listMap.getString("totalCount", i)) + "</td>");
			sbListHtml.append("</tr>");
			
		}
	}
	
	
	
%>

<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->

<script language="JavaScript">
<!--

// 달력
function fnPopupCalendar2(frm, obj){

	var oDate = $F(obj);
	
	result = window.showModalDialog("/commonInc/jsp/calendar.jsp?oDate="+oDate, "calendar", "dialogWidth:256px; dialogHeight:280px; center:yes; status:no;");

	if (result == -1 || result == null || result == ""){
		return;	
	}
			
	try{
	
		if( Form.Element.getValue("ptype1") != null ){
			eval(frm+"."+obj+".value = '" + result + "';");		
		}else{
			eval(frm+"."+obj+".value = '" + result.substr(0,6) + "';");		
		}
	
		
	}catch(e){
		$(obj).value = result;
	}
}

// 구분 변경시
function fnChangeType(){

	sDate = $F("sDate");
	eDate = $F("eDate");

	if( Form.Element.getValue("ptype1") != null ){
		$("sDate").value = "<%= tmpToDay %>";
		$("eDate").value = "<%= tmpToDay %>";
	}else{
		$("sDate").value = sDate.substr(0,6);
		$("eDate").value = eDate.substr(0,6);
	}
}

// 검색
function fnSearch(){
	$("mode").value = "log";
	pform.action = "/statisMgr/stats.do";
	pform.submit();
}

function fnExcel(){
	$("mode").value = "logExcel";
	pform.action = "/statisMgr/stats.do";
	pform.submit();
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
						<img src="/images/bullet003.gif"  align="bottom">&nbsp;<strong>접속통계</strong>
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
							<jsp:param name="tabIndex" value="7" />
						</jsp:include>
						<!-- //tab -->
						<div class="space01"></div>

						<!-- 검색  -->
						<table class="search01">
							<tr>
								<th width="80" class="bl0">
									분석기간
								</th>
								<td>
									<input type="text" class="textfield" name="sDate" id="sDate" value="<%= sDate %>" style="width:60px" readonly/>
									<img style="cursor:hand" onclick="fnPopupCalendar2('pform','sDate');" src="/images/icon_calen.gif" align="middle" />
									~
									<input type="text" class="textfield" name="eDate" id="eDate" value="<%= eDate %>" style="width:60px" readonly/>
									<img style="cursor:hand" onclick="fnPopupCalendar2('pform','eDate');" src="/images/icon_calen.gif" align="middle" />
									
								</td>
								<th width="80" class="bl0">
									구분
								</th>
								<td>
									<input type="radio" name="ptype" id="ptype1" value="day" <%= ptype.equals("day") ? "checked":"" %> onclick="fnChangeType();" ><label for="ptype1">일별</label>
									<input type="radio" name="ptype" id="ptype2" value="month" <%= ptype.equals("month") ? "checked":"" %> onclick="fnChangeType();" ><label for="ptype2">월별</label>
								</td>
								<td width="150" class="btnr">
									<input type="button" value="조회" onclick="fnSearch();" class="boardbtn1" />
                                    <input type="button" value="엑셀출력" onclick="fnExcel();" class="boardbtn1" />
								</td>
							</tr>
						</table>
						<!--//검색  -->	
						<div class="space01"></div>

                        <!-- 리스트 -->
						<table class="datah01">
							<thead>
							<tr>
								<th >일자</th>
								<th >로그인 전</th>
                                <th >로그인 후</th>
								<th class="br0" colspan="14">총 접속수</th>
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