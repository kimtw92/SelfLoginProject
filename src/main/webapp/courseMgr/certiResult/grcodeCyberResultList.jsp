<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%   
// prgnm : 사이버 과정의 수료/미수료자 명단조회
// date : 2008-08-07
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

	
	String tmpStr = "";	
	
	//리스트
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	listMap.setNullToInitialize(true);

	PageNavigation pageNavi = (PageNavigation)listMap.get("PAGE_INFO");
	int pageNum = pageNavi.getTotalCnt() - (requestMap.getInt("currPage") - 1) * requestMap.getInt("rowSize");


	//기관 리스트 
	DataMap grResultDeptList = (DataMap)request.getAttribute("RESULT_DEPT_LIST_DATA");
	grResultDeptList.setNullToInitialize(true);

	//교육과정 이수자수
	DataMap resultCntMap = (DataMap)request.getAttribute("RESULT_CNT_ROW_DATA");
	resultCntMap.setNullToInitialize(true);
	
	StringBuffer listStr = new StringBuffer(); //리스트 결과 변수.
	for(int i=0; i < listMap.keySize("grcode"); i++){

		listStr.append("\n<tr>");
		
		int tmpSeqno = listMap.getInt("seqno", i); //임시 석차
		String tmpPaccept = Util.getValue(listMap.getString("paccept", i), "0"); // 임시 총점

		String seqno = ""; //석차
		String paccept = ""; //총점
		
		if( memberInfo.getSessClass().equals(Constants.ADMIN_SESS_CLASS_ADMIN)
				|| memberInfo.getSessClass().equals(Constants.ADMIN_SESS_CLASS_DEPT ) ){
			
			seqno = tmpSeqno + "";
			paccept = tmpPaccept;
			
		}else{

			if( tmpSeqno <= 3 && Double.parseDouble(tmpPaccept) >= 60){
				seqno = tmpSeqno + "";
				paccept = tmpPaccept;
			}else{
				seqno = "*";
				if( listMap.getString("rgrayn", i).equals("Y") && Double.parseDouble(tmpPaccept) == 60) paccept = "*";
				else if( listMap.getString("rgrayn", i).equals("Y") && Double.parseDouble(tmpPaccept) > 0) paccept = "60점 이상";
				else paccept = "60점 미만";
			}
			
		}
		
		//No
		listStr.append("\n	<td>" + (pageNum -i) + "</td>");

		//CheckBox
		tmpStr = "<input type='checkbox' name=\"userno[]\"	value='" + listMap.getString("userno", i) + "'>";
		listStr.append("\n	<td>" + tmpStr + "</td>");

		//성명
		listStr.append("\n	<td>" + listMap.getString("rname", i) + "</td>");
		
		listStr.append("\n	<td>" + listMap.getString("userId", i) + "</td>");
		
		tmpStr = listMap.getString("birthdate", i);
		listStr.append("\n	<td>" + tmpStr + "</td>");
		
		listStr.append("\n	<td>" + listMap.getString("sex", i) + "</td>");		
		
		//과정명
		listStr.append("\n	<td>" + listMap.getString("grcodeniknm", i) + "</td>");

		//소속
		listStr.append("\n	<td>" + listMap.getString("rdeptnm", i) + "</td>");
		
		//세부소속기관
		listStr.append("\n	<td>" + listMap.getString("rdeptsub", i) + "</td>");
		
		//직급명
		listStr.append("\n	<td>" + listMap.getString("rjiknm", i) + "</td>");
		
		listStr.append("\n	<td>" + listMap.getString("tstep", i) + "</td>");
		
		listStr.append("\n	<td>" + listMap.getString("avcourse", i) + "</td>");
		
		listStr.append("\n	<td>" + listMap.getString("avlcount", i) + "</td>");
		
		
		//교번
		//listStr.append("\n	<td>" + listMap.getString("eduno", i) + "</td>");
		
		//성적
		listStr.append("\n	<td>" + paccept + "</td>");
		
		//석차
		//listStr.append("\n	<td>" + seqno + "</td>");
		
		//이수시간
		listStr.append("\n	<td>" + listMap.getString("grtime", i) + "</td>");

		//수료
		listStr.append("\n	<td>" + listMap.getString("txtRgrayn", i) + "</td>");
		
		//수료번호
		//listStr.append("\n	<td class='br0'>" + listMap.getString("rno", i) + "</td>");

		listStr.append("\n</tr>");
	
	
	} //end for 

	//row가 없으면.
	if( listMap.keySize("grcode") <= 0){

		listStr.append("\n<tr>");
		listStr.append("\n	<td colspan='100%' class='br0' style='height:100px'>검색된 내용이 없습니다.</td>");
		listStr.append("\n</tr>");

	}

	//select Box 기관 리스트
	String selDetpStr = "";
	
	for(int i=0; i < grResultDeptList.keySize("rdept"); i++){
		
		selDetpStr += "<option value=\"" + grResultDeptList.getString("rdept", i) + "\">" + grResultDeptList.getString("rdeptnm", i) + "</option>";
		
	}
	
	//페이징 String
	String pageStr = "";
	if(listMap.keySize("userno") > 0){
		pageStr += pageNavi.showFirst();
		pageStr += pageNavi.showPrev();
		pageStr += pageNavi.showPage();
		pageStr += pageNavi.showNext();
		pageStr += pageNavi.showLast();
	}
%>

<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->

<script language="JavaScript" type="text/JavaScript">
<!--

function go_page(page) {
	$("currPage").value = page;
	set_list(page);
}

function set_list(page) {
	$("currPage").value = page;
	go_list();
}

//comm Selectbox선택후 리로딩 되는 함수.
function go_reload(){
	go_list();
}

//검색
function go_search(){

	if(IsValidCharSearch($F("searchName"))){
		set_list("");
	}

}
//리스트
function go_list(){
	$("mode").value = "cyber_list";
	pform.action = "/courseMgr/certiResult.do";
	pform.submit();

}

//엑셀 출력하기.
function go_excel(){

	if( $F("commGrseq") == "" ){
		alert("기수를 먼저 선택해 주세요.");
		return;
	}

	$("mode").value = "cyber_excel";
	$("qu").value = "";

	pform.action = "/courseMgr/certiResult.do";
	pform.submit();

}


//SMS 발송
function go_sendSms(){
/*
	if( $F("grcode") == "" || $F("grseq") == "" ){
		alert("과정 또는 과정 기수를 먼저 선택해 주세요.");
		return;
	}
*/
	var obj = document.getElementsByName("userno[]");

	var isPass = false;
	var count = 0;
	for(i=0;i<obj.length;i++){
		if(obj[i].checked){
			count++;
			isPass = true;
		}
	}
	if(count > 2000) {
		alert("2000명까지만 보내실수 있습니다.");
		return;
	}
	if(!isPass){
		alert("발송할 수강생을 선택하세요!");
		return;
	}

	popWin("", "pop_sendSms", "800", "600", "1", "");

	
	$("mode").value = "sms_list";
	$("qu").value = "";

	pform.action = "/courseMgr/certiResult.do";
	pform.target = "pop_sendSms";
	pform.submit();
	pform.target = "";

}

//전체 선택.
function listSelectAll(){

	var obj = document.getElementsByName("userno[]");
	
	for(i=0;i<obj.length;i++){

		obj[i].checked = ($("checkAll").checked);
	
	}
}

//로딩시.
onload = function()	{

	//이수여부
	var searchRgrayn = '<%=requestMap.getString("searchRgrayn")%>';
	$("searchRgrayn").value = searchRgrayn;

	//정렬
	var searchOrder = '<%=requestMap.getString("searchOrder")%>';
	$("searchOrder").value = searchOrder;

	try{
		var searchDept = '<%=requestMap.getString("searchDept")%>';
		$("searchDept").value = searchDept;
	}catch(e){}

	//상단 Onload시 셀렉트 박스 선택.
	var commYear = "<%= requestMap.getString("commYear") %>";
	var commGrCode = "<%= requestMap.getString("commGrcode") %>";
	var commGrSeq = "<%= requestMap.getString("commGrseq") %>";
	
	//*********************** reloading 하려는 항목을 적어준다. 리로딩을 사용하지 않으면 "" 그렇지 않으면(grCode, grSeq, grSubj)
	var reloading = ""; 


	/****** body 상단의 년도, 과정, 기수, 과목등의 select box가 있을경우 밑에 내용 실행. */
	getCommYear(commYear); //년도 생성.
	getCyberCommOnloadGrSeq(reloading, commYear, commGrSeq);
	getCyberCommOnloadGrCode(reloading, commYear, commGrCode, commGrSeq);

}

function go_formChk(){

	go_search();
}
//-->
</script>

<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<form id="pform" name="pform" method="post" onSubmit="go_formChk();return false;">
<input type="hidden" name="menuId"				value="<%= requestMap.getString("menuId") %>">
<input type="hidden" name="mode"				value="<%= requestMap.getString("mode") %>">
<input type="hidden" name="qu"					value="">

<input type="hidden" name="grcode"				value="<%= requestMap.getString("commGrcode") %>">
<input type="hidden" name="grseq"				value="<%= requestMap.getString("commGrseq") %>">
<input type="hidden" name="currPage"			value='<%=requestMap.getString("currPage")%>'>

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

						<!-- 검색 -->
						<table class="search01">
							<tr>
								<th width="80" class="bl0">
									년도
								</th>
								<td width="20%">
									<div id="divCommYear" class="commonDivLeft">										
										<select name="commYear" onChange="getCyberCommGrSeq('');" class="mr10">
											<option value="">**선택하세요**</option>
										</select>
									</div>
								</td>
								<th class="bl0">
									기수명
								</th>
								<td>
									<div id="divCyberCommGrSeq" class="commonDivLeft">
										<select name="commGrseq" class="mr10">
											<option value="">**선택하세요**</option>
										</select>
									</div>
								</td>
								<td width="100" class="btnr" rowspan="4">
									<input type="button" value="검색" onclick="go_search();return false;" class="boardbtn1">
									<input type="button" value="EXCEL" onclick="go_excel();" class="boardbtn1">
								</td>
							</tr>
							<tr>
								<th width="80">
									과정명
								</th>
								<td width="35%">
									<div id="divCyberCommGrCode" class="commonDivLeft">
										<select name="commGrcode" class="mr10">
											<option value="">**선택하세요**</option>
										</select>
									</div>
								</td>
								<th width="80">
									이수여부
								</th>
								<td>
									<select name="searchRgrayn">
										<option value = "">전체</option>
										<option value = "Y">이수</option>
										<option value = "N">미이수</option>
									</select>
								</td>
							</tr>
							<tr>
								<th class="bl0">
									성명
								</th>
								<td>
									<input type='text' name='searchName' style='width:100' class="font1" value="<%=requestMap.getString("searchName")%>">

								</td>
								<th>
									정렬
								</th>
								<td>
									<select name="searchOrder" class="mr10">
										<option value="DEPT">기관</option>
										<option value="JIK">직급</option>
										<option value="NAME">성명</option>
										<option value="PACCEPT">성적</option>
									</select>
								</td>
							</tr>
						<%
						if(memberInfo.getSessClass().equals(Constants.ADMIN_SESS_CLASS_ADMIN)
								|| memberInfo.getSessClass().equals(Constants.ADMIN_SESS_CLASS_COURSE)
								|| memberInfo.getSessClass().equals(Constants.ADMIN_SESS_CLASS_COURSEMAN) ){
						%>
							<tr>
								<th class="bl0">
									기관선택
								</th>
								<td colspan="3">
									<select name="searchDept" class="mr10">
										<option value="">전체조회</option>
										<%= selDetpStr %>
									</select>
								</td>
							</tr>
						<%}%>
						</table>
						<!--//검색 -->	
						<div class="space01"></div>

						<table class="btn01">
							<tr>
								<td class="left">수료인원 :
									<strong class="txt_blue"> <%= resultCntMap.getInt("resultTotalcnt") %> </strong>명   
									<span class="txt_99">(남성 : <strong><%= resultCntMap.getInt("manCnt") %></strong> 명, 여성 : <strong><%= resultCntMap.getInt("womanCnt") %></strong> 명)</span> 
								</td>
								<td class="right">
									<input type="button" value="SMS발송" onclick="go_sendSms();" class="boardbtn1">
								</td>
							</tr>
						</table>
						<div class="h5"></div>
						
						<!--[s] 리스트  -->

						<table class="datah01">
							<thead>
							<tr>
								<th>No</th>
								<th>
									<input type="checkbox" name="checkAll" onClick="listSelectAll()">
								</th>
								<th>성명</th>
								<th>ID</th>
								<th>생년월일</th>
								<th>성별</th>
								<th>과정명</th>
								<th>소속</th>
								<th>세부소속기관</th>
								<th>직급명</th>
								<th>진도율</th>
								<th>진도율점수</th>
								<th>평가점수</th>
								<!--th>교번</th-->
								<th>성적</th>
								<!--th>석차</th-->
								<th>이수<br>시간</th>
								<th>수료</th>
								<!-- th class="br0">수료번호</th -->
							</tr>
							</thead>

							<tbody>
							<%= listStr.toString() %>
							</tbody>
						</table>

						<div class="paging">
							<%=pageStr%>		
						</div>
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

