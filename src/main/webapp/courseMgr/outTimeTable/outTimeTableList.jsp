<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 외부강사 시간표
// date : 2008-09-10
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


	//요일 정보 (가로)
	DataMap weekDateList = (DataMap)request.getAttribute("WEEK_LIST_MAP");
	weekDateList.setNullToInitialize(true);

	//강의실 정보 (세로)
	DataMap classList = (DataMap)request.getAttribute("CLASS_LIST_MAP");
	classList.setNullToInitialize(true);

	//시간표 리스트
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	listMap.setNullToInitialize(true);

	
	StringBuffer listStr = new StringBuffer(); //리스트 결과 변수.
	String tmpStr = "";
	String[] weekArr = {"일", "월", "화", "수", "목", "금", "토"}; //상단에 표시되는 월,화,수...
	String[] dayArr = {"", "", "", "", "", "", ""}; //상단에 표시되는 월,화,수.. 일자. ex)20080324
	String[] dayComaArr = {"", "", "", "", "", "", ""}; //상단에 표시되는 월,화,수.. 일자. ex)<br>(03.24)
	String[] dayOnlyComaArr = {"", "", "", "", "", "", ""}; //상단에 표시되는 월,화,수.. 일자. ex)03.24
	
	//가로(요일정보) 셋팅.
	String topWeekStr = "";
	for(int i=0 ; i < 7; i++){
		dayArr[i] = weekDateList.getString("date" + (i+1));
		dayComaArr[i] = "<br/>(" + StringReplace.subString(weekDateList.getString("date" + (i+1)), 4, 6) + "." + StringReplace.subString(weekDateList.getString("date" + (i+1)), 6, 8) + ")";
		dayOnlyComaArr[i] = StringReplace.subString(weekDateList.getString("date" + (i+1)), 4, 6) + "." + StringReplace.subString(weekDateList.getString("date" + (i+1)), 6, 8);
		
		topWeekStr += "<th>" + weekArr[i] + dayComaArr[i] + "</th>";
	}
	
	
	//보여질 내용의
	//String[][] viewArr = new String[classList.keySize("classroomNo")][8]; //강의실 갯수, 강의실명+요일수 만큼 배열.
	
	if( classList.keySize("classroomNo") > 0 ){ //등록된 강의실이 있으면
		
		for(int i=0;i < classList.keySize("classroomNo"); i++){ //강의실 갯수만큼
			
			listStr.append("\n<tr>");
			
			//강의실 명 
			listStr.append("\n	<td>" + classList.getString("classroomName", i) + "</td>");
			
			for(int j=0; j < dayArr.length; j++){ //요일 갯수
				
				tmpStr = "";
				for(int k=0; k < listMap.keySize("classNo"); k++){ //외부강사 리스트
					
					if(classList.getString("classroomNo", i).equals(listMap.getString("classNo", k)) //강의실과 일자가 같다면
							&& dayArr[j].equals(listMap.getString("studydate", k)) ){
						
						if( !tmpStr.equals("") )
							tmpStr += "<br><br>";
						
						tmpStr += "<a href=\"javascript:go_modify('"+classList.getString("classroomNo", i)+"', '"+dayArr[j]+"', '"+listMap.getString("seq", k)+"');\" >" + listMap.getString("contents", k) + "<br><font color='green'>" + listMap.getString("studytimeStr", k) + "</font>" + "</a>";
					}

				}
				if( !tmpStr.equals("") )
					tmpStr += "<br><br>";
					
				tmpStr += "<a href=\"javascript:go_add('"+classList.getString("classroomNo", i)+"', '"+dayArr[j]+"');\" ><font color='blue'>추가</font></a>";
				
				//요일 하나당(가로)
				listStr.append("\n	<td>" + tmpStr + "</td>");
				
			}
		}
	}


	

	//주차 TEXT
	String weekTextListStr = "<a href=\"javascript:go_weekMove('"+requestMap.getString("prevMonthDate")+"');\">◁</a> &nbsp; <a href=\"javascript:go_weekMove('"+requestMap.getString("prevWeekDate")+"');\"><<</a> &nbsp;" + dayOnlyComaArr[0] + " ~ " + dayOnlyComaArr[6] + "&nbsp; <a href=\"javascript:go_weekMove('"+requestMap.getString("nextWeekDate")+"');\">>></a> &nbsp; <a href=\"javascript:go_weekMove('"+requestMap.getString("nextMonthDate")+"');\">▷</a>";





%>
<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->

<script language="JavaScript" type="text/JavaScript">
<!--

//comm Selectbox선택후 리로딩 되는 함수.
function go_reload(){
	go_list();
}
function go_search(){
	go_list();
}
//리스트
function go_list(){

	$("mode").value = "list";

	pform.action = "/courseMgr/outTimeTable.do";
	pform.submit();

}

//주차 이동
function go_weekMove(date){

	$("searchDate").value = date;
	go_list();
}



//수정
function go_modify(classNo, studydate, seq){


	var url = "/courseMgr/outTimeTable.do?mode=form&qu=update&classNo=" + classNo + "&studydate=" + studydate + "&seq=" + seq + "&menuId=" + $F("menuId") + "&searchDate=" + $F("searchDate");
	
	popWin(url, "pop_ousideTimeTable", "600", "500", "0", "0");
	
}

//등록
function go_add(classNo, studydate){

	var url = "/courseMgr/outTimeTable.do?mode=form&qu=insert&classNo=" + classNo + "&studydate=" + studydate + "&menuId=" + $F("menuId") + "&searchDate=" + $F("searchDate");
	
	popWin(url, "pop_ousideTimeTable", "600", "500", "0", "0");

}



//로딩시.
onload = function()	{

}

//-->
</script>
<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<form id="pform" name="pform" method="post">
<input type="hidden" name="menuId"				value="<%=requestMap.getString("menuId")%>">
<input type="hidden" name="mode"				value="<%=requestMap.getString("mode")%>">

<input type="hidden" name="qu"					value="<%=requestMap.getString("qu")%>">

<input type="hidden" name="searchDate"			value="<%=requestMap.getString("searchDate")%>">

<input type="hidden" name="classNo"				value="">
<input type="hidden" name="studydate"			value="">
<input type="hidden" name="seq"					value="">

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



			<!--[s] Contents Form  -->
			<div class="h10"></div>


			<table cellspacing="0" cellpadding="0" border="0" width="100%" class="contentsTable">
				<tr>
					<td>
						<!---[s] content -->

						
						<!-- 주 정보 및 이번주 다음주 text -->
						<table class="tab01">
							<tr>
								<td align="center" height="40">
									<b><%= weekTextListStr %></b>
								</td>
						</table>
						
						
						<div class="space01"></div>


						<!--[s] 리스트  -->
						<table class="datah01">
							<thead>
							<tr>
								<th>강의실</th>
								<%= topWeekStr %>
							</tr>
							</thead>

							<tbody>
							<%= listStr.toString() %>
							</tbody>
						</table>
						<!--//[e] 리스트  -->		
                        
					</td>
				</tr>
			</table>
			<!--[e] Contents Form  -->

			<div class="space_ctt_bt"></div>
				                            
        </td>
    </tr>
</table>

<!--[s] bottom -->
<jsp:include page="/commonInc/include/commonAdminBottom.jsp" flush="false"/>
<!--[e] bottom -->
	
</form>
</body>

