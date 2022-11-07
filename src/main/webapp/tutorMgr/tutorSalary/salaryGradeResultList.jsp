<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 외래강사 수당관리 등급별 수당내역
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
	//리스트 데이터
	DataMap tseatMap = (DataMap)request.getAttribute("TSEATLIST_DATA");
	tseatMap.setNullToInitialize(true);	
	
	//전체 총계 변수
	int cntTutor = 0;
	int sumSalary = 0;
	int totalTseat = 0;
	
	
	//td박스 스트링 버퍼
	StringBuffer cntTutorHtml = new StringBuffer();
	StringBuffer sumSalaryHtml = new StringBuffer();
	
	
	StringBuffer tseat = new StringBuffer();
	if(listMap.keySize("cntTutor") > 0){
		//데이터가 있을경우 구문을 탄다.
		for(int i =0; 7 > i ; i++){
			cntTutor += listMap.getInt("cntTutor", i);
			sumSalary += listMap.getInt("sumSalary", i);
			totalTseat += tseatMap.getInt("tseat", i);
			
			//TD박스는 총 7개이고 첫번째 박스는 총계의 값이 들어간다. 나머지 6개만큼만 포문을 돌린다.
			//0~6번째까지는 td박스를 생성하고 마지막 7번째의 값은 6번째의 값과 합친다.
			if(i == 6){
				cntTutorHtml.append("<td class=\"br0\">"+NumConv.setComma((listMap.getInt("cntTutor", i) + listMap.getInt("cntTutor", 7))) +"&nbsp;</td>");
				sumSalaryHtml.append("<td class=\"br0\">"+NumConv.setComma(tseatMap.getInt("tseat", i)) +"&nbsp;</td>");
				tseat.append("<td class=\"br0\">"+ NumConv.setComma((listMap.getInt("sumSalary", i) + listMap.getInt("sumSalary", 7))) +"&nbsp;</td>");
				
			}else{
				cntTutorHtml.append("<td>"+NumConv.setComma(listMap.getInt("cntTutor", i)) +"&nbsp;</td>");
				sumSalaryHtml.append("<td>"+NumConv.setComma(tseatMap.getInt("tseat", i)) +"&nbsp;</td>");
				tseat.append("<td>"+NumConv.setComma(listMap.getInt("sumSalary", i)) +"&nbsp;</td>");
				
			}
	
	
		}
	}else{
		//없을경우
		for(int i =0; 7 > i ; i++){
			if(i == 6){
				cntTutorHtml.append("<td class=\"br0\">&nbsp;</td>");
				sumSalaryHtml.append("<td class=\"br0\">&nbsp;</td>");
				tseat.append("<td class=\"br0\">&nbsp;</td>");
			}else{
				cntTutorHtml.append("<td>&nbsp;</td>");
				sumSalaryHtml.append("<td>&nbsp;</td>");
				tseat.append("<td>&nbsp;</td>");	
			}
			

	
		}
	}
	
%>


<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->


<script language="JavaScript">
<!--
//월요일체크를 위한 ajax
function go_search(){
	
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
		$("mode").value = "selectGreadeResultList";
		pform.action = "/tutorMgr/salary.do";
		pform.submit();
	}
}

//-->
</script>


<script for="window" event="onload">
 	 
 	 
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
						<img src="/images/bullet003.gif"  align="bottom">&nbsp;<strong>등급별 수당내역</strong>
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
						<!-- 검색 -->
						<table class="search01">
							<tr>
								<th width="80" class="bl0">
									기간
								</th>
								<td>
									<input type="text" class="textfield" name="sDate" value="<%=requestMap.getString("sDate")%>" style="width:70px" readonly/>
									<img style="cursor:hand" onclick="fnPopupCalendar('pform','sDate');" src="../images/icon_calen.gif" alt="" />
									~
									<input type="text" class="textfield" name="eDate" value="<%=requestMap.getString("eDate")%>" style="width:70px" readonly/>
									<img style="cursor:hand" onclick="fnPopupCalendar('pform','eDate');" src="../images/icon_calen.gif" alt="" />
								</td>
								
								
								
								
								<td width="100" class="btnr">
									<input type="button" value="검 색" onclick="go_search();" class="boardbtn1">
								</td>								
							</tr>
						</table>
						<!--//검색 -->
						<div class="space01"></div>

						<!--[s] 리스트  -->
						<table class="datah01">
							<colgroup>
								<col width="" />
								<col width="70" />
								<col width="70" />
								<col width="70" />
								<col width="70" />
								<col width="70" />
								<col width="70" />
								<col width="70" />
								<col width="70" />
							</colgroup>

							<thead>
							<tr>
								<th>등급</th>
								<th>총계</th>
								<th>특A</th>
								<th>A</th>
								<th>B</th>
								<th>C1</th>
								<th>C2</th>
								<th>D</th>
								<th class="br0">기타</th>
							</tr>
							</thead>

							<tbody>
							<tr>
								<td>인원</td>
								<td><%=NumConv.setComma(cntTutor) %></td>
								<%=cntTutorHtml.toString() %>

							</tr>
							<tr>
								<td>교육인원</td>
								<td><%=NumConv.setComma(totalTseat) %></td>
								<%=sumSalaryHtml.toString() %>

							</tr>
							<tr>
								<td>수당</td>
								<td><%=NumConv.setComma(sumSalary) %></td>
								<%=tseat.toString() %>
							</tr>
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