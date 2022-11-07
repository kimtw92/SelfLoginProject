<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 대상별 교육훈련실적 - 직렬별
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
	String month = requestMap.getString("month");
	
	// 직렬별 테이블 만들기
	StringBuffer sbColHtml = new StringBuffer();
	DataMap colMap = (DataMap)request.getAttribute("COL_DATA");
	if(colMap == null) colMap = new DataMap();
	colMap.setNullToInitialize(true);
	
	if(colMap.keySize("codenm") > 0){		
		for(int i=0; i < colMap.keySize("codenm"); i++){
			if(i == (colMap.keySize("codenm")-1)){
				sbColHtml.append("<th class=\"br0\">" + colMap.getString("codenm",i) + "</th>" );
			}else{
				sbColHtml.append("<th>" + colMap.getString("codenm",i) + "</th>" );	
			}			
		}
	}
	
	int colCount = colMap.keySize("codenm");
	String colName = "";
	String bgColor = "";
	
	// 리스트
	StringBuffer sbListHtml = new StringBuffer();
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	if(listMap == null) listMap = new DataMap();
	listMap.setNullToInitialize(true);
	
	if(listMap.keySize("grcodenm") > 0){		
		for(int i=0; i < listMap.keySize("grcodenm"); i++){
			
			// tr 배경색
			if(listMap.getString("pflag", i).equals("A")){
				bgColor = "bgcolor=\"#cccccc\"";				
			}else if(listMap.getString("pflag", i).equals("B")){
				bgColor = "bgcolor=\"ffcc00\"";
			}else{
				bgColor = "";
			}
			
			sbListHtml.append("<tr " + bgColor + " >");
			
			sbListHtml.append("	<td>" + listMap.getString("gubunnm", i) + "</td>");
			sbListHtml.append("	<td>" + listMap.getString("grcodenm", i) + "</td>");			
			sbListHtml.append("	<td>" + Util.moneyFormValue(listMap.getString("totalSum", i)) + "</td>");
			
			// 직렬갯수 만큼  td 생성
			for(int j=0; j < colCount; j++){
				colName = "col" + (j+1);
				sbListHtml.append("	<td>" + Util.moneyFormValue(listMap.getString(colName, i)) + "</td>");
			}
						
			sbListHtml.append("</tr>");
		}
	}else{
		sbListHtml.append("<tr><td style=\"height:100px\" colspan=\"100%\">데이타가 없습니다.</td></tr>");
	}
	
%>

<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->

<script language="JavaScript">
<!--


// 검색
function fnSearch(){

	var mode = "";

	if(NChecker($("pform"))){
	
		if( Form.Element.getValue("ptype1") != null ){
			mode = "position";
		}else if( Form.Element.getValue("ptype2") != null ){
			mode = "tjikr";
		}else if( Form.Element.getValue("ptype3") != null ){
			mode = "dept";
		}else if( Form.Element.getValue("ptype4") != null ){
			mode = "human";
		}
	
		$("mode").value = mode;
		pform.action = "/statisMgr/stats.do";
		pform.submit();
		
	}
}

// 엑셀출력
function fnExcel(){
	var mode = "";

	if(NChecker($("pform"))){
	
		if( Form.Element.getValue("ptype1") != null ){
		
		}else if( Form.Element.getValue("ptype2") != null ){
			mode = "tjikrExcel";
		}else if( Form.Element.getValue("ptype3") != null ){
		
		}else if( Form.Element.getValue("ptype4") != null ){
			mode = "humanExcel";
		}
	
		$("mode").value = mode;
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
									<input type="radio" name="ptype" id="ptype1" value="position">
									<label for="ptype1">
										직급별
									</label>

                                    <input type="radio" name="ptype" id="ptype2" value="tjikr" checked>
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
									<input type="button" value="엑셀출력" onclick="fnExcel();" class="boardbtn1" />
								</td>
							</tr>
							<tr>
								<th width="80" class="bl0">
									교육년도
								</th>
								<td>
									<input type="text" class="textfield" name="searchYear" id="searchYear" value="<%= searchYear %>" maxlength="4" style="width:50px" required="true!년도가 없습니다." dataform="num!숫자만 입력해야 합니다." />
									<select id="month" name="month" onChange="fnSearch();">
										<option value="" <%= "".equals(month) ? "selected='selected'":""  %> >전체</option>
										<option value="01" <%= "01".equals(month) ? "selected='selected'":""  %>>01</option>
										<option value="02" <%= "02".equals(month) ? "selected='selected'":""  %>>02</option>
										<option value="03" <%= "03".equals(month) ? "selected='selected'":""  %>>03</option>
										<option value="04" <%= "04".equals(month) ? "selected='selected'":""  %>>04</option>
										<option value="05" <%= "05".equals(month) ? "selected='selected'":""  %>>05</option>
										<option value="06" <%= "06".equals(month) ? "selected='selected'":""  %>>06</option>
										<option value="07" <%= "07".equals(month) ? "selected='selected'":""  %>>07</option>
										<option value="08" <%= "08".equals(month) ? "selected='selected'":""  %>>08</option>
										<option value="09" <%= "09".equals(month) ? "selected='selected'":""  %>>09</option>
										<option value="10" <%= "10".equals(month) ? "selected='selected'":""  %>>10</option>
										<option value="11" <%= "11".equals(month) ? "selected='selected'":""  %>>11</option>
										<option value="12" <%= "12".equals(month) ? "selected='selected'":""  %>>12</option>
									</select>
								</td>
							</tr>
						</table>
						<!--//검색  -->	
						<div class="space01"></div>

						<!-- 리스트  -->
						<table class="datah01">
							<thead>
							<tr>
								<th>구분</th>
								<th>과정명</th>
								<th>총계</th>
								<%= sbColHtml.toString() %>
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
			
			
