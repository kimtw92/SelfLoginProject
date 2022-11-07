<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 강사별 수당내역
// date  : 2008-07-21
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
	
	//강사레벨 리스트
	DataMap tutorLevleMap = (DataMap)request.getAttribute("TUTORLEVEL_LIST_DATA");
	tutorLevleMap.setNullToInitialize(true);
	
	
	StringBuffer option = new StringBuffer();
	if(tutorLevleMap.keySize("tlevel") > 0){
		for(int i=0; tutorLevleMap.keySize("tlevel") > i; i++){
			option.append("<option value=\""+tutorLevleMap.getString("tlevel", i)+"\">"+ tutorLevleMap.getString("levelName" ,i)+"</option>");
		}
	}
	

	
	
	String userno = "";
	int rowCnt = 1;
	int gmoney = 0;
	int pmoney = 0;
	int tmoney = 0;
	int cmoney = 0;

	StringBuffer html = new StringBuffer();
	
	if(listMap.keySize("userno") > 0){
		for(int i=0; listMap.keySize("userno") > i; i++){
			String sTime = "";
			String eTime = "";
			String totalTime = "";
			if(listMap.getInt("totime",i) == (listMap.getInt("maxStudytime",i) - listMap.getInt("minStudytime",i)+1)){
				if(listMap.getInt("minStudytime",i) == 1){
					sTime = "09:00";
					
				}else if(listMap.getInt("minStudytime",i) == 2){
					sTime = "10:00";
					
				}else if(listMap.getInt("minStudytime",i) == 3){
					sTime = "11:00";
					
				}else if(listMap.getInt("minStudytime",i) == 4){
					sTime = "12:00";
					
				}else if(listMap.getInt("minStudytime",i) == 5){
					sTime = "13:00";
					
				}else if(listMap.getInt("minStudytime",i) == 6){
					sTime = "14:00";
					
				}else if(listMap.getInt("minStudytime",i) == 7){
					sTime = "15:00";
					
				}else if(listMap.getInt("minStudytime",i) == 8){
					sTime = "16:00";
					
				}else if(listMap.getInt("minStudytime",i) == 9){
					sTime = "17:00";
					
				}
				
				if(listMap.getInt("maxStudytime",i) == 1){
					eTime = "09:50";
					
				}else if(listMap.getInt("maxStudytime",i) == 2){
					eTime = "10:50";
					
				}else if(listMap.getInt("maxStudytime",i) == 3){
					eTime = "11:50";
					
				}else if(listMap.getInt("maxStudytime",i) == 4){
					eTime = "12:50";
					
				}else if(listMap.getInt("maxStudytime",i) == 5){
					eTime = "13:50";
					
				}else if(listMap.getInt("maxStudytime",i) == 6){
					eTime = "14:50";
					
				}else if(listMap.getInt("maxStudytime",i) == 7){
					eTime = "15:50";
					
				}else if(listMap.getInt("maxStudytime",i) == 8){
					eTime = "16:50";
					
				}else if(listMap.getInt("maxStudytime",i) == 9){
					eTime = "17:50";
					
				}
			}
			
			if(sTime.equals("")){
				totalTime = "-";
			}else{
				totalTime = sTime+"<br>~"+eTime;
			}
			
			//i번째 루프 시작------------------------------------------------------------------------------------------------------------->
			html.append("\n	<tr>");
			
			for(int j = i+1; listMap.keySize("userno") > j; j++){
			//j번째 루프 시작------------------------------------------------------------------------------------------------------------->
				if(listMap.getString("userno", i).equals(listMap.getString("userno", j))){
					//같은 유저넘버가 있을경우 로우 카운터수를 증감을 시킨다.
					rowCnt++;
			
				}else{
					break;
					
				}
			}
			
			for(int j = i; listMap.keySize("userno") > j; j++){
				if(listMap.getString("userno", i).equals(listMap.getString("userno", j))){
					//같은 유저 넘버일경우 해당 값들을 더한다.
					gmoney += listMap.getInt("gmoney",j);
					pmoney += listMap.getInt("pmoney",j);
					tmoney += listMap.getInt("tmoney",j);
					cmoney += listMap.getInt("cmoney",j);
			
				}else{
					break;
					
				}
			}
			
			if(!userno.equals(listMap.getString("userno", i))){
				//위에서 구해진 값들과 로우 카운터 수들을 뿌려준다. 현재 유저넘버와 다를때이기 때문에 한번 밖에 뿌려주지 안는다.
				html.append("\n	<td align=\"center\" rowSpan=\""+rowCnt+"\">"+listMap.getString("name",i)+"&nbsp;</td>");
				html.append("\n	<td align=\"center\" rowSpan=\""+rowCnt+"\">"+listMap.getString("resno",i)+"&nbsp;</td>");
				html.append("\n	<td align=\"center\" rowSpan=\""+rowCnt+"\">"+listMap.getString("tposition",i)+"<br>"+listMap.getString("jikwi", i)+"<br>"+listMap.getString("homeTel", i)+"&nbsp;</td>");
			
			}
			
			//---->유저 넘버와 상관없이 무조건 뿌려준다.[s]	<----
			html.append("\n	<td align=\"center\">"+listMap.getString("grcodenm",i)+"<br>"+listMap.getString("lecnm", i)+"&nbsp;</td>");
			
			if(listMap.getInt("amtGubun", i) <= 2){
				html.append("\n	<td align=\"center\">"+listMap.getString("lecturedate",i)+"&nbsp;</td>");
				html.append("\n	<td align=\"center\">"+listMap.getString("lecturetime",i)+"&nbsp;</td>");
				html.append("\n	<td align=\"center\">"+ totalTime + "</td>");
				
			}else{
				html.append("\n	<td align=\"center\">&nbsp;</td>");
				html.append("\n	<td align=\"center\">&nbsp;</td>");
				html.append("\n	<td align=\"center\">&nbsp;</td>");
				
			}
			//---->유저 넘버와 상관없이 무조건 뿌려준다.[e]	<----			
			
			if(!userno.equals(listMap.getString("userno" , i))){
				//90번째줄 주석과 동일하다.	
				html.append("\n	<td align=\"center\" rowSpan=\""+rowCnt+"\">"+gmoney+"&nbsp;</td>");
				html.append("\n	<td align=\"center\" rowSpan=\""+rowCnt+"\">"+pmoney+"&nbsp;</td>");
				html.append("\n	<td align=\"center\" rowSpan=\""+rowCnt+"\">"+tmoney+"&nbsp;</td>");
				html.append("\n	<td align=\"center\" rowSpan=\""+rowCnt+"\">"+cmoney+"&nbsp;</td>");
				html.append("\n	<td align=\"center\" rowSpan=\""+rowCnt+"\" class=\"br0\">"+listMap.getString("levelName",i)+"&nbsp;</td>");
			}	
			
			html.append("\n	</tr>");
			
			//각각의 값들을 초기화.
			rowCnt = 1;
			gmoney = 0;
			pmoney = 0;
			tmoney = 0;
			cmoney = 0;
			//i번째의 유저 넘버를 넣어준다.
			userno = listMap.getString("userno", i);
			
		}
	}else{
		//값이 없을경우
		html.append("<tr>");
		html.append("<td align=\"center\" class=\"br0\" colspan=\"100%\" style=\"height:100px\">등록된 데이터가 없습니다.</td>");
		html.append("</tr>");		
	}
	
%>


<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->


<script language="JavaScript">
<!--
//월요일체크를 위한 ajax
function go_search(){
	if(IsValidCharSearch($("grcodenm").value) == false){
		return false;
	}

	if(IsValidCharSearch($("tutornm").value) == false){
		return false;
	}
	
	if($("sDate").value > $("sDate").value){
		alert("마지막날짜가 시작날자보다 큽니다. 다시 선택하여 주십시오.");
		return false;
	}
	
	var url = "/tutorMgr/salary.do";
	var pars = "mode=ajaxDateChk&sDate="+$("sDate").value;
	var divId = "classroomDIV";
	var myAjax = new Ajax.Updater(
		{success:divId},
		url, 
		{
			asynchronous : false,
			method: "get", 
			parameters: pars,
			
			onSuccess : fnSuccessChk,
			onFailure: function(){
				alert("오류가 발생했습니다.");
			}
		}
	)

}

//금요일체크를 위한 ajax
function go_chkDate2(){
	
	var url = "/tutorMgr/salary.do";
	var pars = "mode=ajaxDateChk&sDate="+$("eDate").value;
	var divId = "classroomDIV";
	var myAjax = new Ajax.Updater(
		{success:divId},
		url, 
		{
			asynchronous : false,
			method: "get", 
			parameters: pars,
			
			onSuccess : fnSuccessChk2,
			onFailure: function(){
				alert("오류가 발생했습니다.");
			}
		}
	)

}

//월요일 체크
function fnSuccessChk(originalRequest){
	var returnValue = trim(originalRequest.responseText);
	if(returnValue != 2){
		alert("시작날짜는 월요일만 선택가능합니다.	");
		return false;
	}
	
	go_chkDate2();
}

//금요일체크
function fnSuccessChk2(originalRequest){
	var returnValue = trim(originalRequest.responseText);
	if(returnValue != 6){
		alert("마지막날짜는 금요일만 선택가능합니다.	");
		return false;
	}
	
	go_list();
}

//실질적인 검색 시작 
function go_list(){
	if(NChecker($("pform"))){
		$("mode").value = "pluralFormSalaryList";
		pform.action = "/tutorMgr/salary.do";
		pform.submit();
	}
}


function go_excel(){
	$("mode").value = "pluralFormSalaryExcel";
	pform.action = "/tutorMgr/salary.do";
	pform.submit();
}

//-->
</script>


<script for="window" event="onload">

	//검색 조건 셀렉티드
	var tlevle = "<%=requestMap.getString("tlevle")%>";
	len = $("tlevle").options.length;

	for(var i=0; i < len; i++) {
		if($("tlevle").options[i].value == tlevle){
			$("tlevle").selectedIndex = i;
		 }
 	 }
 	 
 	 
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
						<img src="/images/bullet003.gif"  align="bottom">&nbsp;<strong>강사별 수당내역</strong>
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
						<!-- 검색  -->
						<table class="search01">
							<tr>
								<th width="80" class="bl0">
									기간 
								</th>
								<td width="300">
									<input type="text" class="textfield" name="sDate" value="<%=requestMap.getString("sDate")%>" style="width:70px" readonly/>
									<img style="cursor:hand" onclick="fnPopupCalendar('pform','sDate');" src="../images/icon_calen.gif" alt="" />
									~
									<input type="text" class="textfield" name="eDate" value="<%=requestMap.getString("eDate")%>" style="width:70px" readonly/>
									<img style="cursor:hand" onclick="fnPopupCalendar('pform','eDate');" src="../images/icon_calen.gif" alt="" />
								</td>
								<th width="80">
									강사등급
								</th>
								<td>
									<select name="tlevle" class="mr10">
										<option value="">
											**선택하세요**
										</option>
										<%=option.toString() %>
									</select>
								</td>
								<td width="150" class="btnr" rowspan="2">
									<input type="button" value="검색" onclick="go_search();" class="boardbtn1">
									<input type="button" value="EXCEL" onclick="go_excel();" class="boardbtn1">
								</td>
							</tr>
							<tr>
								<th class="bl0">과정명</th>
								<td><input type="text" class="textfield" name="grcodenm" maxlength="30" onkeypress="if(event.keyCode==13){go_search();}"value="<%=requestMap.getString("grcodenm") %>" style="width:200px;" /></td>
								<th width="80">강사명</th>
								<td><input type="text" class="textfield" name="tutornm" maxlength="20" onkeypress="if(event.keyCode==13){go_search();}"value="<%=requestMap.getString("tutornm") %>" style="width:118px;" /></td>
							</tr>
						</table>
						<!--//검색  -->	
						<div class="space01"></div>

						<!-- 리스트  -->
						<table class="datah01">
							<thead>
							<tr>
								<th rowspan="2" width="70">성명</th>
								<th rowspan="2">주민번호</th>
								<th rowspan="2">소속 및 직위<br>(연락처)</th>
								<th colspan="8">구분</th>
								<th class="br0" rowspan="2">강사<br>등급</th>
							</tr>
							<tr>
								<th>과정명/과목</th>
								<th>강의일자</th>
								<th>강의<br>교시</th>
								<th>강의<br>시간</th>
								<th>강사료</th>
								<th>원고료</th>
								<th>출제수당</th>
								<th>사이버강<br>사료</th>
							</tr>
							</thead>
							
							<tbody>
							<%=html.toString() %>
							</tbody>

						</table>
						<!--//리스트  -->
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