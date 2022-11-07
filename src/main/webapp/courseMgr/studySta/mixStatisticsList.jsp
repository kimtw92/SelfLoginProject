<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 혼합교육학습현황
// date : 2008-08-19
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

	//수강생 리스트
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	listMap.setNullToInitialize(true);

	//과목 리스트
	DataMap subjListMap = (DataMap)request.getAttribute("SUBJ_LIST_DATA");
	subjListMap.setNullToInitialize(true);

	//수강생의 과목별 점수 리스트
	DataMap subjStuPointListMap = (DataMap)request.getAttribute("STUPOINT_LIST_DATA");
	subjStuPointListMap.setNullToInitialize(true);

	String tmpStr = "";

	String subjListStr = "";
	int selSubjCnt = 0;
	for(int i=0; i < subjListMap.keySize("subj"); i++){
		
		tmpStr = "";
		if(subjListMap.getString("lecType", i).equals("C")){
			selSubjCnt++;
			tmpStr = "<font color=orange>선택과목</font><br>";
		}
		
		subjListStr += "<th>" + tmpStr + subjListMap.getString("lecnm", i) + "</th>";
		
	}


	
	StringBuffer listStr = new StringBuffer(); //리스트 결과 변수.
	int tmpInt = 0;
	int tmpInt2 = 0;
	double tmpDou = 0;

	for(int i=0; i < listMap.keySize("userno"); i++){

		listStr.append("\n<tr id='LS_"+i+"'>");

		//번호
		listStr.append("\n	<td>" + (i+1) + "</td>");
		
		//CheckBox
		tmpStr = "<input type='checkbox' name=\"userno[]\"	value='" + listMap.getString("userno", i) + "'>";
		listStr.append("\n	<td>" + tmpStr + "</td>");
		
		//성명
		listStr.append("\n	<td>" + listMap.getString("name", i) + "</td>");

		//ID
		listStr.append("\n	<td>" + listMap.getString("userId", i) + "</td>");

		//기관
		if( listMap.getString("deptnm", i).equals("6280000") )
			tmpStr = listMap.getString("deptnm", i);
		else
			tmpStr = listMap.getString("deptnm", i).replace("인천광역시", "");
		listStr.append("\n	<td>" + tmpStr + "</td>");

		//직급
		listStr.append("\n	<td>" + listMap.getString("jiknm", i) + "</td>");

		//전화번호
		listStr.append("\n	<td>" + listMap.getString("hp", i) + "</td>");

		//과목별 점수.
		tmpDou = 0;
		tmpInt2 = 0;
		for(int j=0; j < subjListMap.keySize("subj"); j++){

			tmpInt = 0;
			for(int k=0; k < subjStuPointListMap.keySize("userno"); k++){

				//수강생이 같고 과목 정보가 같으면
				if( listMap.getString("userno", i).equals(subjStuPointListMap.getString("userno", k)) && subjListMap.getString("subj", j).equals(subjStuPointListMap.getString("subj", k)) ){

                	tmpStr = Util.getValue(subjStuPointListMap.getString("disStep", k), "0");

                	try{
                		if(tmpStr.equals("완료")){
                			tmpDou = 100;
                		}else if(tmpStr.equals("진행중") || tmpStr.equals("미진행")){
                			tmpDou = 0;
                		}else{
                			tmpDou = Double.parseDouble(tmpStr);
							tmpStr = "" + HandleNumber.getCommaZeroDeleteNumber(tmpStr); 
						}
                		
                	}catch(Exception ee){
                		tmpDou = 0;
                	}

					if(tmpDou < 80){
						listStr.append("\n	<td style='color:red;font-weight:bold'>" + tmpStr + "</td>");
					}else{
						listStr.append("\n	<td>" + tmpStr + "</td>");
					}

					tmpInt++;
					break;
				}
			}
			//수강생 과목별  정보가 없으면 0
			if(tmpInt == 0){
				listStr.append("\n	<td>-</td>");
				tmpInt2++;
			}


		}
		if(selSubjCnt > 0 && selSubjCnt ==  tmpInt2){
			listStr.append("<script>document.getElementById('LS_" + i + "').style.background='#FBE0E9';</script>");
		}

		listStr.append("\n</tr>");

	} //end for listMap.keySize("dept")


	//row가 없으면.
	if( listMap.keySize("userno") <= 0){

		listStr.append("\n<tr>");
		listStr.append("\n	<td colspan='100%' style=\"height:100px\" class='br0'>검색된 내용이 없습니다.</td>");
		listStr.append("\n</tr>");

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
//검색
function go_search(){

	go_list();
}
//리스트
function go_list(){

	$("mode").value = "mix_list";

	pform.action = "/courseMgr/studySta.do";
	pform.submit();

}

// 엑셀 및 연락처
function go_excel(qu){

	if( $F("commGrcode") == "" ){
		alert("과정을 먼저 선택해 주세요.");
		return;
	}

	if( $F("commGrseq") == "" ){
		alert("기수를 먼저 선택해 주세요.");
		return;
	}

	$("mode").value = "mix_excel";
	$("qu").value = qu;

	pform.action = "/courseMgr/studySta.do";
	pform.submit();

}

//전체 선택.
function listSelectAll(){

	var obj = document.getElementsByName("userno[]");
	
	for(i=0;i<obj.length;i++){

		obj[i].checked = ($("checkAll").checked);
	
	}
}

//SMS 발송
function go_sendSms(){

	if( $F("grcode") == "" ){
		alert("과정을 선택해 주세요.");
		return;
	}
	
	if( $F("grseq") == "" ){
		alert("먼저 기수를 선택후 검색해 주세요.");
		return;
	}

	var obj = document.getElementsByName("userno[]");
	var isPass = false;
	for(i=0; i < obj.length; i++){
		if(obj[i].checked){
			isPass = true;
			break;
		}
	}

	if(!isPass){
		alert("수강생을 선택하세요!");
		return;
	}

	popWin("", "pop_sendSms", "800", "600", "1", "");

	
	$("mode").value = "mix_sms";
	$("qu").value = "";

	pform.action = "/courseMgr/studySta.do";
	pform.target = "pop_sendSms";
	pform.submit();
	pform.target = "";

}


//로딩시.
onload = function()	{

	//상단 Onload시 셀렉트 박스 선택.
	var commYear	= "<%= requestMap.getString("commYear") %>";
	var commGrCode	= "<%= requestMap.getString("commGrcode") %>";
	var commGrSeq	= "<%= requestMap.getString("commGrseq") %>";
	
	//*********************** reloading 하려는 항목을 적어준다. 리로딩을 사용하지 않으면 "" 그렇지 않으면(grCode, grSeq, subj)
	var reloading = ""; 


	/****** body 상단의 년도, 과정, 기수, 과목등의 select box가 있을경우 밑에 내용 실행. */
	getCommYear(commYear); //년도 생성.
	getCommOnloadGrCode(reloading, commYear, commGrCode);
	getCommOnloadGrSeq(reloading, commYear, commGrCode, commGrSeq);

}


//-->
</script>
<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<form id="pform" name="pform" method="post">
<input type="hidden" name="menuId"				value="<%= requestMap.getString("menuId") %>">
<input type="hidden" name="mode"				value="<%= requestMap.getString("mode") %>">
<input type="hidden" name="qu"					value="">

<input type="hidden" name="grseq"				value='<%=requestMap.getString("commGrseq")%>'>
<input type="hidden" name="grcode"				value='<%=requestMap.getString("commGrcode")%>'>

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

			<div class="h10"></div>

			<!--[s] Contents Form  -->
			<table cellspacing="0" cellpadding="0" border="0" width="100%"
				class="contentsTable">
				<tr>
					<td>
						<!-- tab menu -->
						<div class="tabmenu" style="width:100%;">
							<ul class="tabset">
								<a href="javascript:fnGoStudyStaSubjByAdmin();"><li style="cursor:hand;">과목별 학습현황 </li></a>
								<a href="javascript:fnGoStudyStaTotalByAdmin();"><li style="cursor:hand;">전체 학습현황</li></a>
							<%if( memberInfo.getSessClass().equals(Constants.ADMIN_SESS_CLASS_ADMIN) ){%>
								<a href="javascript:fnGoStudyStaCyberByAdmin();"><li style="cursor:hand;">사이버 학습현황</li></a>
								<li class="on">혼합교육 학습현황</li>
								<a href="javascript:fnGoStudyStaOnlineByAdmin();"><li style="cursor:hand;">온라인평가현황</li></a>
							<%}%>
							</ul>
						</div>
						<!-- //tab menu -->
						<div class="space01"></div>

						<!-- 검색 -->
						<table class="search01">
							<tr>
								<th width="80" class="bl0">
									년도
								</th>
								<td width="20%">
									<div id="divCommYear" class="commonDivLeft">										
										<select name="commYear" onChange="getCommGrCode('');" class="mr10">
											<option value="">**선택하세요**</option>
										</select>
									</div>
								</td>
								<th width="80">
									과정명
								</th>
								<td>

									<div id="divCommGrCode" class="commonDivLeft">
										<select name="commGrcode" class="mr10">
											<option value="">**선택하세요**</option>
										</select>
									</div>
								</td>
								<td width="100" class="btnr" rowspan="2">
									<input type="button" value="검색" onclick="go_search();" class="boardbtn1">
								</td>
							</tr>
							<tr>
								<th width="80">
									기수명
								</th>
								<td>
									<div id="divCommGrSeq" class="commonDivLeft">
										<select name="commGrseq" class="mr10">
											<option value="">**선택하세요**</option>
										</select>
									</div>
								</td>
								<th class="bl0">
									진도율
								</th>
								<td>
									<input type='text' name='searchStartpt' style='width:50px' class="font1" onkeyDown="go_commNumCheck()" maxlength="3" value="<%=requestMap.getString("searchStartpt")%>"> ~
									<input type='text' name='searchEndpt' style='width:50px' class="font1" onkeyDown="go_commNumCheck()" maxlength="3" value="<%=requestMap.getString("searchEndpt")%>">
								</td>
							</tr>

						</table>
						<!--//검색 -->	
						<div class="space01"></div>

						<!-- 테이블하단 버튼  -->
						<table class="btn01" style="clear:both;">
							<tr>
								<td class="right">
									<input type="button" value="학습독려 SMS발송" onclick="go_sendSms();" class="boardbtn1">
									<input type="button" value="EXCEL" onclick="go_excel('EXCEL');" class="boardbtn1">
									<input type="button" value="연락처" onclick="go_excel('PHONE');" class="boardbtn1">
								</td>
							</tr>
						</table>
						<!-- //테이블하단 버튼  -->

						<!--[s] 리스트  -->
						<!-- 리스트  -->
						<table class="datah01">
							<thead>
							<tr>
								<th>번호</th>
								<th>
									<input type="checkbox" name="checkAll" onClick="listSelectAll()">
								</th>
								<th>성명</th>
								<th>ID</th>
								<th>기관</th>
								<th>직급</th>
								<th>전화번호</th>
								<%= subjListStr %>
							</tr>
							</thead>

							<tbody>
								<%= listStr.toString() %>
							</tbody>
						</table>
						<!--//리스트  -->	

						<div class="space01"></div>



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

