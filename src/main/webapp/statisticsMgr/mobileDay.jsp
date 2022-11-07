<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

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
	
	//리스트 데이터
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	listMap.setNullToInitialize(true);

	//페이지 처리
	PageNavigation pageNavi = (PageNavigation)listMap.get("PAGE_INFO");
	int pageNum = pageNavi.getTotalCnt() - (requestMap.getInt("currPage") - 1) * requestMap.getInt("rowSize");
	
	//페이징 String
	String pageStr = "";
	if(listMap.keySize() > 0){
		pageStr += pageNavi.showFirst();
		pageStr += pageNavi.showPrev();
		pageStr += pageNavi.showPage();
		pageStr += pageNavi.showNext();
		pageStr += pageNavi.showLast();
	}
	
	StringBuffer html = new StringBuffer();
    String dy = "";
	if(listMap.keySize("logdate") > 0){
		for(int i = 0; i < listMap.keySize("logdate"); i++){
            dy = listMap.getString("dy", i);
            if("토".equals(dy) || "일".equals(dy)) {
                dy = "<font color='red'>" + listMap.getString("dy", i) + "</font>";
            }

			html.append("\n	<tr>");
			html.append("\n		<td>"+listMap.getString("logdate", i) + " ( " + dy + " )" +"</td>");
			html.append("\n		<td>"+listMap.getString("nologinsum", i)+"</td>");
			html.append("\n		<td>"+listMap.getString("loginsum", i)+"</td>");
			html.append("\n		<td>"+listMap.getString("total", i)+"</td>");
			html.append("\n	</tr>");
		}
	}else{
		html.append("\n	<tr>");
		html.append("\n		<td class=\"br0\" colspan=\"100%\"style=\"height:100px;text-align:center\">등록된 데이터가 없습니다.</td>");
		html.append("\n	</tr>");		
	}
%>
<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->


<script language="JavaScript" type="text/JavaScript">
function go_list(){
	$("mode").value = "mobileDay";
	pform.action = "/statisMgr/stats.do";
	pform.submit();
}

//페이지 이동
function go_page(page) {
	$("currPage").value = page;
	go_list();
}
//검색
function go_serach(){

	var sYear = $("sDate").value.substr(0,4);
	var eYear = $("eDate").value.substr(0,4);
	
	var sMonth = $("sDate").value.substr(4,6);
	var eMonth = $("eDate").value.substr(4,6);
	var sum = "";

	if((Number(eYear) - Number(sYear)) == 1){
	
		sum = (12 - Number(sMonth)) + Number(eMonth)
		
	}

    if($("eDate").value != "" && $("sDate").value == "") {
		alert("시작 날짜를 입력 하셔야 됩니다.");
		return false;    
    }

	if($("eDate").value == "" && $("sDate").value != "") {
		alert("끝 날짜를 입력 하셔야 됩니다.");
		return false;    
    }

	if($("sDate").value > $("eDate").value){
		alert("검색 시작일자가 마지막일자보다 높습니다. 다시 입력하십시오.");
		return false;
	}
	
	$("currPage").value = "";
	$("mode").value = "mobileDay";
	pform.action = "/statisMgr/stats.do";
	pform.submit();
	
}

// 달력
function fnPopupCalendar2(frm, obj){

	var oDate = $F(obj);

	result = window.showModalDialog("/commonInc/jsp/calendar.jsp?oDate="+oDate, "calendar", "dialogWidth:256px; dialogHeight:280px; center:yes; status:no;");

	if (result == -1 || result == null || result == ""){
		return;	
	}
	
	if(result == "delete"){
		result = "";
	}
			
	try{
	
		if(obj == "sDate"){
			//시작일자 가져오기
			$("tempSdate").value = result;
		}else{
			//마지막일자 가져오기
			$("tempEdate").value = result;
		}
		
		
		if( Form.Element.getValue("gubun") != null ){
			eval(frm+"."+obj+".value = '" + result + "';");		
		}else{
			eval(frm+"."+obj+".value = '" + result.substr(0,6) + "';");		
		}
	
		
	}catch(e){
		$(obj).value = result;
	}
}

//월별,일별
function go_chk(vDate){	
	if(vDate == "date" ){
		//일별
		$("sDate").value = $("tempSdate").value;
		$("eDate").value = $("tempEdate").value;
		
	}else{
		//월별
		$("sDate").value = $("tempSdate").value.substr(0, 6);
		$("eDate").value = $("tempEdate").value.substr(0, 6);
	}
	
}


</script>

<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<form id="pform" name="pform" method="post">
<input type="hidden" name="mode">
<input type="hidden" name="qu">
<input type="hidden" name="menuId" 				value="<%=requestMap.getString("menuId") %>">
<input type="hidden" name="currPage"			value='<%=requestMap.getString("currPage")%>'>
<!-- 임시 날짜 입력 -->
<input type="hidden" name="tempSdate" value="<%=requestMap.getString("tempSdate") %>">
<input type="hidden" name="tempEdate" value="<%=requestMap.getString("tempEdate") %>">

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

			<!--[s] subTitle -->
			<table width="100%" height="10"><tr><td></td></tr></table>
			<table width="100%" border="0" cellspacing="0" cellpadding="0" class="contentsSubTitleTable">			
				<tr>
					<td height="20">
						<img src="/images/bullet003.gif"  align="bottom">&nbsp;<strong>모바일 일별 통계 리스트</strong>
					</td>
				</tr>
			</table>
			<!--[e] subTitle -->
			<div class="space01"></div>
			<!--[s] Contents Form  -->
			<table cellspacing="0" cellpadding="0" border="0" width="100%" class="contentsTable">
				<tr>
					<td>
						<div class="space01"></div>
                        총 회원수 : <font color="red"><%=(Integer)request.getAttribute("mobileMemberCnt")%></font> 명
                        <div class="space01"></div>

                        <!-- search[s] -->
						<table class="search01">
                            <tr>
								<th class="bl0" width="80">
									검색기간
								</th>
								<td colspan="3">
									<input type="text" class="textfield" size="9" style="text-align:center" name="sDate" value="<%=requestMap.getString("sDate")%>"  readonly/>
									<img style="cursor:hand" onclick="fnPopupCalendar2('pform','sDate');" src="/images/icon_calen.gif" alt="" align="middle" />
									~
									<input type="text" class="textfield" size="9" style="text-align:center" name="eDate" value="<%=requestMap.getString("eDate")%>" readonly/>
									<img style="cursor:hand" onclick="fnPopupCalendar2('pform','eDate');" src="/images/icon_calen.gif" alt="" align="middle" />
                                    <input type="button" value="검 색" onclick="go_serach();" class="boardbtn1">
								</td>
							</tr>
						</table>
	                    <!-- search[e] -->
                    					
						<!---[s] content -->
						<div class="space01"></div>
						<!-- 리스트  -->
						<table class="datah01" id="tableData">
							<thead>
							<tr>
								<th>날 자</th>
								<th>방문수(로그인 전)</th>
								<th>방문수(로그인 후)</th>
								<th>총계</th>
							</tr>
							</thead>

							<tbody>
							<tr>
							<%=html.toString() %>
							
							</tr>
							</tbody>
						</table>
						<div class="space01"></div>
                   		<table cellspacing="0" cellpadding="0" border="0" width="100%" class="contentsTable">
                   			<tr>
                   				<td width="100%" align="center" colspan="100%"><%=pageStr%></td>
                   			</tr>
                   		</table>
                   								<div class="space01"></div>
						<!--[e] Contents Form  -->
		        	</td>
		    	</tr>
			</table>
		</td>
	</tr>
</table>
<!--[s] bottom -->
<jsp:include page="/commonInc/include/commonAdminBottom.jsp" flush="false"/>
<!--[e] bottom -->

</form>
</body>


