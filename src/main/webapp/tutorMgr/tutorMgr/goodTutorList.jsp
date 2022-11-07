<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 우수강사리스트
// date  : 2008-07-10
// auth  : 정윤철
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
	
	//리스트 데이터
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	listMap.setNullToInitialize(true);
	
	StringBuffer html = new StringBuffer();
	StringBuffer munu = new StringBuffer();
	String subCenterTtitle = "";
	if(requestMap.getString("qu").equals("search")){
		subCenterTtitle = "<강의 만족도 "+requestMap.getString("sPer")+"%이상 강사현황>";
		//
		if(listMap.keySize("subjnm") > 0){
			munu.append("<thead>");
			munu.append("<tr>");
			munu.append("<th rowspan=\"2\">과목명</th>");
			munu.append("<th colspan=\"2\">강사</th>");
			munu.append("<th rowspan=\"2\">과정명</th>");
			munu.append("<th colspan=\"4\">강의 만족도</th>");
			munu.append("<th rowspan=\"2\" class=\"br0\">비율(%)</th>");
			munu.append("</tr>");
			munu.append("<tr>");
			munu.append("<th>소속</th>");
			munu.append("<th width=\"50\">강사명</th>");
			munu.append("<th>매우우수</th>");
			munu.append("<th>우수</th>");
			munu.append("<th>보통</th>");
			munu.append("<th>미흡</th>");
			munu.append("</tr>");
			munu.append("</thead>");
				
			for(int i=0; i < listMap.keySize(); i++){
				html.append("<tr>");
				html.append("<td align=\"center\">"+(listMap.getString("subjnm", i).equals("") ? "&nbsp" : listMap.getString("subjnm",i) )+"</td>");
				html.append("<td align=\"center\">"+(listMap.getString("tposition", i).equals("") ? "&nbsp" : listMap.getString("tposition",i) )+"</td>");
				html.append("<td align=\"center\">"+(listMap.getString("name", i).equals("") ? "&nbsp" : listMap.getString("name",i) )+"</td>");
				html.append("<td align=\"center\">"+(listMap.getString("grname", i).equals("") ? "&nbsp" : listMap.getString("grname", i) )+"</td>");
				html.append("<td align=\"center\">"+(listMap.getString("num1", i).equals("") ? "&nbsp" : listMap.getString("num1", i) )+"</td>");
				html.append("<td align=\"center\">"+(listMap.getString("num2", i).equals("") ? "&nbsp" : listMap.getString("num2", i) )+"</td>");
				html.append("<td align=\"center\">"+(listMap.getString("num3", i).equals("") ? "&nbsp" : listMap.getString("num3", i) )+"</td>");
				html.append("<td align=\"center\">"+(listMap.getString("num4", i).equals("") ? "&nbsp" : listMap.getString("num4", i) )+"</td>");
				html.append("<td align=\"center\" class=\"br0\">"+(listMap.getString("rat", i).equals("") ? "&nbsp" : listMap.getString("rat", i) )+"%</td>");
				html.append("</tr>");
			}
		}else{
			html.append("<tr>");
			html.append("<td align=\"center\" colspan=\"100%\" class=\"br0\" style=\"height:100px\">등록된 출강강사가 없습니다.</td>");
			html.append("</tr>");	
		}
	}
%>


<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->


<script language="JavaScript">
<!--
//검색
function go_search(){

	if(NChecker($("pform"))){
		$("mode").value = "goodTutorList";
		$("qu").value = "search";
		pform.action = "/tutorMgr/goodTutor.do";				
		pform.submit();
	}
}

function go_check(qu){
	if($("sPer").value >100){
		alert("100퍼센트이상 입력할 수 없습니다");
		$("sPer").focus;
		return false;
	}
	
	if($("ePer").value >100){
		alert("100퍼센트이상 입력할 수 없습니다");
		return false;
	}

	if(parseInt($F("sPer"))> parseInt($F("ePer"))){
		alert("시작 퍼센트가 마지막 퍼센트 보다 높습니다. 다시입력하여주십시오.");
		return false;
	}
	
	if($("sDate").value == "" || $("sDate").value ==null){
		alert("시작일을 선택하십시오.")
		return false;
	}

	if($("eDate").value == "" || $("eDate").value ==null){
		alert("종료일을 선택하십시오.")
		return false;
	}


	if($("sDate").value > $("eDate").value){
		alert("시작일이 종료일보다 낮을수 없습니다.")
		return false;
	}
	
	if(qu == "search"){
		go_search();
	}else{
		go_excel()
	}
	
}

function go_excel(){
	$("mode").value = "goodTutorexcel"
	
	if($("qu").value == "search" ){
		alert("검색 후 출력하여 주십시오.");
		return false;
	}
	
	if(NChecker($("pform"))){
		pform.action = "/tutorMgr/goodTutor.do";				
		pform.submit();
		
	}
	
}

//-->
</script>


<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<form id="pform" name="pform" method="post" >

<input type="hidden" name="menuId" 	value="<%= requestMap.getString("menuId") %>">
<input type="hidden" name="mode"	value="<%= requestMap.getString("mode") %>">
<input type="hidden" name="qu"		value="">

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
						<img src="/images/bullet003.gif"  align="bottom">&nbsp;<strong>우수강사</strong>
					</td>
				</tr>
			</table> 
			<!--[e] subTitle -->
			<div class="space01"></div>
			<!--[s] Contents Form  -->
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
									분야
								</th>
								<td width="20%">
									<select name="subjgubun" class="mr10">
										<option selected value="">
											**전체**
										</option>
										<option value="01">
											소양분야
										</option>
										<option value="02">
											직무분야
										</option>
										<option value="03">
											행정및기타
										</option>										
									</select>
								</td>
								<th width="80">
									검색기간  
								</th>
								<td>
									<input type="text" class="textfield" name="sDate" value="<%=requestMap.getString("sDate")%>" style="width:100px" readonly/>
									<img style="cursor:hand" onclick="fnPopupCalendar('pform','sDate');" src="../images/icon_calen.gif" alt="" />
									~
									<input type="text" class="textfield" name="eDate" value="<%=requestMap.getString("eDate")%>" style="width:100px" readonly/>
									<img style="cursor:hand" onclick="fnPopupCalendar('pform','eDate');" src="../images/icon_calen.gif" alt="" />
								</td>
								<td width="120" class="btnr" rowspan="2">
									<input type="button" value="검 색" onclick="go_check('search');" class="boardbtn1">
									<input type="button" value="출 력" onclick="go_excel('excel');" class="boardbtn1">
								</td>								
							</tr>
							<tr>
								<th width="80" class="bl0">
									점수
								</th>
								<td colspan="3">
									<input type="text" class="textfield" maxlength="3" dataform="num!숫자만 입력해야 합니다." required="true!퍼센트를 입력하여주십시오." name="sPer" value="<%=requestMap.getString("sPer") %>" style="width:30px" /> % 이상
									~
									<input type="text" class="textfield" maxlength="3" dataform="num!숫자만 입력해야 합니다." required="true!퍼센트를 입력하여주십시오." name="ePer" value="<%=requestMap.getString("ePer") %>" style="width:30px" /> % 이하
								</td>					
							</tr>
						</table>
						<!--//검색 -->
						<div class="space01"></div>
							
						<!-- 상단 버튼  -->
						<table class="btn01">
							<tr>
								<td align=center style='font-fimily:돋움;font-size:18;font-weight:bold'>	<%=subCenterTtitle %> </td>
							</tr>
						</table>
						<!--// 상단 버튼  -->

						<!--[s] 리스트  -->
						<table class="datah01">
							<%=munu.toString() %>
							<tbody>
							<%=html.toString() %>
							</tbody>
						</table>
						<!--//[e] 리스트  -->	
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

<script language="JavaScript" type="text/JavaScript">
	//검색 조건 셀렉티드
	var subjgubun = "<%=requestMap.getString("subjgubun")%>";
	len = $("subjgubun").options.length

	for(var i=0; i < len; i++) {
		if($("subjgubun").options[i].value == subjgubun){
			$("subjgubun").selectedIndex = i;
		 }
 	 }
</script>