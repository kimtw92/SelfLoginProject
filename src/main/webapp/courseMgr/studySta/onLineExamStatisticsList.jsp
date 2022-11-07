<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 온라인 학습현황
// date : 2008-07-25
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

	//리스트
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	listMap.setNullToInitialize(true);

	//평가 정보
	DataMap examRowMap = (DataMap)request.getAttribute("EXAM_ROW_DATA");
	examRowMap.setNullToInitialize(true);
	
	StringBuffer listStr = new StringBuffer(); //리스트 결과 변수.
	String tmpStr = "";

	for(int i=0; i < listMap.keySize("userno"); i++){

		listStr.append("\n<tr>");

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
		
		//평가응시
		if(listMap.getString("ynEnd", i).equals("Y"))
			tmpStr = "응시완료";
		else if(listMap.getString("ynEnd", i).equals("N"))
			tmpStr = "응시중";
		else
			tmpStr = "미응시";
		listStr.append("\n	<td>" + tmpStr + "</td>");
		
		
		//1차, 2차 점수
		String strScore1 = "";
		String strScore2 = "";
		String[] tmpArr = listMap.getString("tryInfo", i).split("_");
		try{
			if(tmpArr[0].equals("0")){
				strScore1 = listMap.getString("score", i);
				strScore2 = "";
			}else{
				strScore1 = tmpArr[1];
				strScore2 = listMap.getString("score", i);
			}
		}catch(Exception e){
			strScore1 = "";
			strScore2 = "";
		}
		//1차
		listStr.append("\n	<td>" + strScore1 + "</td>");
		//2차
		listStr.append("\n	<td>" + strScore2 + "</td>");
		
		//비고
		if( !examRowMap.getString("idExamKind").equals("0") && !examRowMap.getString("idExamKind").equals("1") ){
			
			double tmpDou = Double.parseDouble(Util.getValue(listMap.getString("allotting", i), "0")) * 0.6;
			
			if( !listMap.getString("score", i).equals("") ){
				if( tmpDou <= Double.parseDouble(listMap.getString("score", i)) )
					tmpStr = "이수";
				else
					tmpStr = "미이수";
			}else
				tmpStr = "미이수";

		}else
			tmpStr = "";
		listStr.append("\n	<td class='br0'>" + tmpStr + "</td>");

		listStr.append("\n</tr>");

	} //end for listMap.keySize("dept")


	//row가 없으면.
	if( listMap.keySize("dept") <= 0){

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

	if( $F("commExam") == "" ){
		if(document.getElementsByTagName("select")[8].lastChild.getAttributeNode("value").nodeValue != ""){
			$("commExam").value = document.getElementsByTagName("select")[8].lastChild.getAttributeNode("value").nodeValue;
		}else {
			alert('평가가 없습니다.');
		}
	}
	
	$("mode").value = "online_list";

	pform.action = "/courseMgr/studySta.do";
	pform.submit();

}


// 엑셀
function go_excel(){

	if( $F("commGrcode") == "" ){
		alert("먼저 과정을 선택해 주세요.");
		return;
	}

	if( $F("commGrseq") == "" ){
		alert("먼저 기수를  선택해 주세요.");
		return;
	}

	if( $F("commExam") == "" ){
		alert("먼저 평가명을  선택해 주세요.");
		return;
	}
	
	$("mode").value = "online_excel";

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

	if( $F("commGrcode") == "" ){
		alert("먼저 과정을 선택해 주세요.");
		return;
	}

	if( $F("commGrseq") == "" ){
		alert("먼저 기수를  선택해 주세요.");
		return;
	}

	if( $F("commExam") == "" ){
		alert("먼저 평가명을  선택해 주세요.");
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

	
	$("mode").value = "online_sms";
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
	var commExam	= "<%= requestMap.getString("commExam") %>";
	
	//*********************** reloading 하려는 항목을 적어준다. 리로딩을 사용하지 않으면 "" 그렇지 않으면(grCode, grSeq, subj)
	var reloading = ""; 


	/****** body 상단의 년도, 과정, 기수, 과목등의 select box가 있을경우 밑에 내용 실행. */
	getCommYear(commYear); //년도 생성.
	getCommOnloadGrCode(reloading, commYear, commGrCode);
	getCommOnloadGrSeq(reloading, commYear, commGrCode, commGrSeq);
	getCommOnloadExam(commGrCode, commGrSeq, commExam);
}


//-->
</script>
<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<form id="pform" name="pform" method="post">
<input type="hidden" name="menuId"				value="<%= requestMap.getString("menuId") %>">
<input type="hidden" name="mode"				value="<%= requestMap.getString("mode") %>">
<input type="hidden" name="qu"					value="">

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
								<a href="javascript:fnGoStudyStaMixByAdmin();"><li style="cursor:hand;">혼합교육 학습현황</li></a>
								<li class="on">온라인평가현황</li>
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
								<th class="bl0">
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
									평가명
								</th>
								<td>
									<div id="divCommExam" class="commonDivLeft">										
										<select name="commExam" class="mr10">
											<!-- <option value="">**선택하세요**</option> -->
										</select>
									</div>
								</td>
							</tr>

						</table>
						<!--//검색 -->	
						<div class="space01"></div>

						<!-- 테이블하단 버튼  -->
						<table class="btn01" style="clear:both;">
							<tr>
								<td class="right">
									<input type="button" value="미응시자 SMS 발송" onclick="go_sendSms();" class="boardbtn1">
									<input type="button" value="EXCEL" onclick="go_excel();" class="boardbtn1">
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
								<th>평가응시</th>
								<th>1차점수</th>
								<th>2차점수</th>
								<th class="br0">비고</th>
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

