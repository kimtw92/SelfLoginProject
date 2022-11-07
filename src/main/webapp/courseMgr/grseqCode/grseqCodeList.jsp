<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 기수 코드 관리 리스트.
// date : 2008-06-23
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


	//시간표 리스트
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	listMap.setNullToInitialize(true);

	String listStr = "";
	String tmpStr = "";
	for(int i=0; i < listMap.keySize("seq"); i++){

		listStr += "<tr bgColor='#FFFFFF' height='28'>";
		

		listStr += "	<td align='center' class='tableline11' >" + listMap.getString("grYear", i) + "&nbsp;</td>";
		listStr += "	<td align='center' class='tableline11' >" + listMap.getString("seq", i) + "&nbsp;</td>";
		
		tmpStr = listMap.getString("eapplyst", i) + ":00~" + listMap.getString("eapplyed", i) + ":00";
		listStr += "	<td align='center' class='tableline11' >" + tmpStr + "&nbsp;</td>";

		tmpStr = listMap.getString("started", i) + "~" + listMap.getString("enddate", i);
		listStr += "	<td align='center' class='tableline11' >" + tmpStr + "&nbsp;</td>";


		listStr += "	<td align='center' class='tableline11' >" + listMap.getString("tdate", i) + "&nbsp;</td>";
		listStr += "	<td align='center' class='tableline11' >" + listMap.getString("grseqCnt", i) + "&nbsp;</td>";
		listStr += "	<td align='center' class='tableline11' >" + listMap.getString("person", i) + "&nbsp;</td>";

		tmpStr = "<a href=\"javascript:go_modify('" + listMap.getString("grYear", i) + "', '" + listMap.getString("seq", i) + "')\">수정</a>";
		if(listMap.getString("grseqCnt", i).equals("0"))
			tmpStr += " / <a href=\"javascript:go_delete('" + listMap.getString("grYear", i) + "', '" + listMap.getString("seq", i) + "');\">삭제</a>";
		listStr += "	<td align='center' class='tableline21' >"+tmpStr+"</td>";


		listStr += "</tr>";

	}


	//row가 없으면.
	if( listMap.keySize("seq") <= 0){

		listStr += "<tr bgColor='#FFFFFF'>";
		listStr += "	<td align='center' class='tableline21' colspan='100%' height='100'>등록된 기수가 없습니다.</td>";
		listStr += "</tr>";

	}

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

//리스트
function go_list(){

	$("mode").value = "list";

	pform.action = "/courseMgr/grseqCode.do";
	pform.submit();

}

//삭제
function go_delete(grYear, seq){

	if(confirm("삭제하시겠습니까 ?")){
		$("mode").value = "exec";
		$("qu").value = "delete";
	
		$("year").value = grYear;
		$("seq").value = seq;
	
		pform.action = "/courseMgr/grseqCode.do";
		pform.submit();
	}

}

//등록
function go_add(){

	var mode = "form";
	var qu = "insert";
	var menuId = $F("menuId");
	var year = $F("commYear");
	var url = "/courseMgr/grseqCode.do?mode=" + mode + "&menuId=" + menuId + "&qu=" + qu + "&year=" + year;

	popWin(url, "pop_grseqCodeForm", "450", "510", "1", "");


}

//수정
function go_modify(grYear, seq){

	var mode = "form";
	var qu = "update";
	var menuId = $F("menuId");
	var url = "/courseMgr/grseqCode.do?mode=" + mode + "&menuId=" + menuId + "&qu=" + qu + "&year=" + grYear + "&seq=" + seq;

	popWin(url, "pop_grseqCodeForm", "450", "510", "1", "");


}




//로딩시.
onload = function()	{

	//상단 Onload시 셀렉트 박스 선택.
	var commYear = "<%= requestMap.getString("commYear") %>";
	$("commYear").value = commYear;
	//alert(commYear);
	//getCommYear(commYear); //년도 생성.

}

//-->
</script>
<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<form id="pform" name="pform" method="post">
<input type="hidden" name="menuId"				value="<%=requestMap.getString("menuId")%>">
<input type="hidden" name="mode"				value="<%=requestMap.getString("mode")%>">

<input type="hidden" name="qu"					value="<%=requestMap.getString("qu")%>">

<input type="hidden" name="seq"					value="">
<input type="hidden" name="year"				value="">


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

			<!-- subTitle -->
			<!-- space --><table width="100%" height="10"><tr><td></td></tr></table>
			<table width="100%" border="0" cellspacing="0" cellpadding="0" class="contentsSubTitleTable">
				<tr>
					<td height="20">
						<img src="/images/bullet003.gif" width="11" height="11" align="bottom">&nbsp;<strong>기수코드관리 리스트</strong>
					</td>
				</tr>
			</table>
			<!--// subTitle -->

			<!--[s] Contents Form  -->
			<table cellspacing="0" cellpadding="0" border="0" width="100%" class="contentsTable">
				<tr>
					<td>
						<!---[s] content -->

						<!--[s] 검색 -->
						<!-- space --><table width="100%" height="10"><tr><td></td></tr></table>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr bgcolor="#375694"><td height="2" colspan="100%"></td></tr>
							<tr height="28" bgcolor="F7F7F7" >
								<td width="80" align="center" class="tableline11"><strong>년 도</strong></td>
								<td align="left" bgcolor="#FFFFFF" style="padding:0 0 0 9">
									<div id="divCommYear" class="commonDivLeft">										
										<select name="commYear" onChange="go_reload();" style="width:100px;font-size:12px">
											<option value="">** 선택 **</option>
											<script language='javascript'>
											<!--
											for(var i=new Date().getYear()+1; i>= 2005; i--)
												document.write("<option value='" + i + "'> " + i + "</option>");
											//-->
											</script>
										</select>
									</div> &nbsp;
									<input type="button" value="검 색" onclick="go_list();" class="boardbtn1">
								</td>
								<td bgcolor="#FFFFFF" width="100" align="center">
									<input type="button" value="기수코드추가" class="boardbtn1" onclick="go_add();">
								</td>
							</tr>
							<tr bgcolor="#375694"><td height="2" colspan="100%"></td></tr>
						</table>
						<!--[e] 검색 -->


						<!-- space --><table width="100%" height="10"><tr><td></td></tr></table>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td>
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr bgcolor="#375694">
											<td height="2" colspan="100%"></td>
										</tr>
										<tr height='35' bgcolor="#5071B4">
											<td width="6%" align='center' class="tableline11 white">
												<strong>년도</strong>
											</td>
											<td width="6%" align='center' class="tableline11 white">
												<strong>기수</strong>
											</td>
											<td width="30%" align='center' class="tableline11 white">
												<strong>수강신청</strong>
											</td>
											<td width="20%" align='center' class="tableline11 white">
												<strong>교육기간</strong>
											</td>
											<td width="10%" align='center' class="tableline11 white">
												<strong>총학습기간</strong>
											</td>
											<td width="10%" align='center' class="tableline11 white" >
												<strong>개설과정</strong>
											</td>
											<td width="6%" align='center' class="tableline11 white" >
												<strong>정원</strong>
											</td>
											<td width="12%" align='center' class="tableline21 white" >
												<strong>기능</strong>
											</td>
										</tr>

										<%= listStr.toString() %>

									</table>
								</td>
							</tr>
						</table>

						<!---[e] content -->
                        
					</td>
				</tr>
			</table>
			<!--[e] Contents Form  -->

			<!-- space --><table width="100%" height="30"><tr><td></td></tr></table>
				                            
        </td>
    </tr>
</table>

<!--[s] bottom -->
<jsp:include page="/commonInc/include/commonAdminBottom.jsp" flush="false"/>
<!--[e] bottom -->
	
</form>
</body>

