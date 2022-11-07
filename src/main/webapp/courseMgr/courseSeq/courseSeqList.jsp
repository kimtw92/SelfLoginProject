<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 과정기수관리 리스트.
// date : 2008-06-10
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


	//년도 SELECTBOX 리스트
	DataMap yearListMap = (DataMap)request.getAttribute("YEAR_LIST_DATA");
	yearListMap.setNullToInitialize(true);

	String yearSelectBoxStr = "";
	for(int i=0; i < yearListMap.keySize("year"); i++){
		yearSelectBoxStr += "<option value=\"" + yearListMap.getString("year", i) + "\">" + yearListMap.getString("year", i) + "</option>";
	}

	//과정기수 리스트.
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	listMap.setNullToInitialize(true);

	StringBuffer listStr = new StringBuffer(); //리스트 결과 변수.
	String tmpGrcode = ""; //과정코드
	String tmpGrSeq = ""; //과정기수코드
	String tmpStr = "";

	//과정별 리스트.
	for(int i=0; i < listMap.keySize("grcode"); i++){

		tmpStr = "";

		tmpGrcode = listMap.getString("grcode", i);	
		tmpGrSeq = listMap.getString("grseq", i);	

		listStr.append("\n<tr>");

		//과정명
		listStr.append("\n	<td rowspan='" + listMap.getString("subjCount", i) + "'>" + listMap.getString("grcodenm", i) + "</td>");
		
		//과정기수
		String modifyGrSeq = "<a href=\"javascript:go_modify('"+tmpGrSeq+"');\">" + listMap.getString("grseq", i) + "</a>";
		if( !memberInfo.getSessClass().equals(Constants.ADMIN_SESS_CLASS_COURSEMAN) ){
			tmpStr += "<br><br><a href=\"javascript:go_addGrseq('"+tmpGrSeq+"');\">[기수추가]</a>";
			tmpStr += "<br><br><a href=\"javascript:go_addSubj('"+tmpGrSeq+"');\">[과목추가]</a>";
			tmpStr += "<br><br><a href=\"javascript:go_deleteSubj('"+tmpGrSeq+"', 'ALL');\">[전체과목삭제]</a>";
			tmpStr += "<br><br><a href=\"javascript:go_copySubj('"+tmpGrcode+"', '"+tmpGrSeq+"');\">[이전과목복사]</a>";
			tmpStr += "<br><br><a href=\"javascript:go_copyPrevGrSeq('"+tmpGrcode+"', '"+tmpGrSeq+"');\">[이전기수정보복사]</a>";
			tmpStr += "<br><br><a href=\"javascript:go_fileForm('"+tmpGrcode+"', '"+tmpGrSeq+"');\">[첨부파일 " + (listMap.getInt("groupfileNo", i) > 0 ? "O" : "X")+ "]</a>";
		}
		listStr.append("\n	<td rowspan='" + listMap.getString("subjCount", i) + "'>" + modifyGrSeq + tmpStr + "</td>");
		
		//동기모임
		//tmpStr = (listMap.getString("cafeYn", i).equals("Y") ? "완료" : "<a href=\"javascript:go_addCafe('"+tmpGrSeq+"');\">생성</a>");
		//listStr.append("\n	<td align='center' class='tableline11' rowspan='" + listMap.getString("subjCount", i) + "'>" + tmpStr + "</td>");
		
		//과목리스트중 기본 과목정보 담겨져 있는 map추출. (일반,선택 과목 모두 이맵안에 SUBJ_REF_LIST_MAP map에 들어있다.)
		DataMap subjList = (DataMap)listMap.get("SUBJ_LIST_MAP", i);
		if(subjList == null) subjList = new DataMap();
		subjList.setNullToInitialize(true);

		for(int j=0; j < subjList.keySize("subj"); j++){
			
			//과목 리스트 담겨져 있는 map추출.
			DataMap subjRefList = (DataMap)subjList.get("SUBJ_REF_LIST_MAP", j);
			if(subjRefList == null) subjRefList = new DataMap();
			subjRefList.setNullToInitialize(true);
			
			if(j > 0){ //처음만 빼고
				listStr.append("\n<tr>");
			}
			for(int k=0; k < subjRefList.keySize("subj"); k++){
				
				if(k > 0){ //처음만 빼고
					listStr.append("\n<tr>");
				}else{

					//과목구분
					if( subjList.getString("lecType", j).equals("S") ) 
						tmpStr = "일반";
					else if( subjList.getString("lecType", j).equals("P") ) 
						tmpStr = "선택<br>(<a href=\"javascript:go_modifySubj('"+tmpGrSeq+"', '"+subjList.getString("refSubj", j)+"');\">"+subjList.getString("refSubjnm", j)+"</a>)";
					else 
						tmpStr = "&nbsp;";
					listStr.append("\n	<td rowspan='" + subjRefList.keySize("subj") + "'>" + tmpStr + "</td>");

				}
				
				//과목분류
				if( subjRefList.getString("subjtype", k).equals("Y") ) tmpStr = "사이버";
				else if (subjRefList.getString("subjtype", k).equals("N") ) tmpStr = "집합";
				else if (subjRefList.getString("subjtype", k).equals("S") ) tmpStr = "특수";
				else if (subjRefList.getString("subjtype", k).equals("M") ) tmpStr = "동영상";
				else tmpStr = "";
				listStr.append("\n	<td>" + tmpStr + "</td>");

				//과목명
				tmpStr = "<a href=\"javascript:go_modifySubj('"+tmpGrSeq+"', '"+subjRefList.getString("subj", k)+"');\">" + subjRefList.getString("subjnm", k) + "</a>&nbsp;";
				listStr.append("\n	<td>" + tmpStr + "</td>");

				//평가 계획
				if (listMap.getString("grgubun", i).equals("C")) {
					tmpStr = "<a href=\"javascript:go_evlinfoSubjForm('"
				             + subjRefList.getString("subj", k)
				             + "', '"
				             + tmpGrcode
				             + "', '"
				             + tmpGrSeq
				             + "', '"
				             + subjRefList.getString("ptype", k)
				             + "', '"
				             + subjRefList.getString("evlYn")
				             + "', '"
				             + subjRefList.getString("gakpoint", k)
				             + "', '"
				             + subjRefList.getString("jupoint", k)
				             + "');\">"
				             + subjRefList.getString("ptypenm", k) + "/" + subjRefList.getString("evlYn") + "</a>";
/*
					tmpStr = "<a href=\"/courseMgr/courseSeq.do?mode=evlinfoSubjForm"
							+ "&menuId=" + requestMap.getString("menuId")
							+ "&subj=" + subjRefList.getString("subj", k)
							+ "&commYear=" + requestMap.getString("year")
							+ "&commGrcode=" + tmpGrcode
							+ "&commGrseq=" + tmpGrSeq
							+ "&ptype=" + subjRefList.getString("ptype", k)
							+ "&cboAuth=" + requestMap.getString("cboAuth")
// 							+ "&selYear=" + requestMap.getString("selYear")
// 							+ "&selGrSeq=" + requestMap.getString("selGrSeq")
							+ "\">" + subjRefList.getString("ptypenm", k) + "/" + subjRefList.getString("evlYn") + "</a>";
*/
				} else {
// 					tmpStr = "<a href=\"javascript:alert('집합');\">" + subjRefList.getString("ptypenm", k) + "/" + subjRefList.getString("evlYn") + "</a>";
					tmpStr = "<a href=\"javascript:go_evlinfoSubjOffForm('"
							 + subjRefList.getString("subj", k)
				             + "', '"
				             + tmpGrcode
				             + "', '"
				             + tmpGrSeq
				             + "', '"
				             + subjRefList.getString("ptype", k)
							 + "');\">" 
				             + subjRefList.getString("ptypenm", k) + "/" + subjRefList.getString("evlYn") + "</a>";
				}
				listStr.append("\n	<td>" + tmpStr + "</td>");
				
				//인원
				tmpStr = subjRefList.getString("count1", k) + "/" + subjRefList.getString("count2", k) + "/" + subjRefList.getString("count3", k);
				listStr.append("\n	<td>" + tmpStr + "</td>");

				//교육기간
				tmpStr = subjRefList.getString("started", k) +  " ~<br>" + subjRefList.getString("enddate", k) + "&nbsp;";
				listStr.append("\n	<td>" + tmpStr + " </td>");

				//교육
				listStr.append("\n	<td>" + subjRefList.getString("preed", k) + "&nbsp;</td>");

				//반영
				if( !memberInfo.getSessClass().equals(Constants.ADMIN_SESS_CLASS_COURSEMAN) ){
					//완결
					listStr.append("\n	<td>" + subjRefList.getString("closing", k) + "&nbsp;</td>");
					tmpStr = "<a href=\"javascript:go_deleteSubj('"+tmpGrSeq+"', '" + subjRefList.getString("subj", k) + "');\" >삭제</a>&nbsp;";
					listStr.append("\n	<td class='br0'>" + tmpStr + "</td>");
				}else{
					//완결
					listStr.append("\n	<td class='br0'>" + subjRefList.getString("closing", k) + "&nbsp;</td>");
				}

				listStr.append("\n</tr>");
			}
			
		}
		//과정기수는 있지만 과목이 없는 경우(예외처리)
		if(subjList.keySize("subj") <= 0){
			listStr.append("<td colspan='8'>&nbsp;</td></tr>");
		}
		

	}

	//row가 없으면.
	if( listMap.keySize("grcode") <= 0){

		listStr.append("<tr>");
		listStr.append("	<td colspan='100%' style=\"height:100px\" class=\"br0\">등록된 과정이 없습니다.</td>");
		listStr.append("</tr>");

	}
	
	// 과목수정시 과목운영 메뉴 가기 위한 코드임
	// 2008-09-30 수정 : kang
	String tmpSubjMenuId = "";
	if( memberInfo.getSessCurrentAuth().equals("0") || memberInfo.getSessCurrentAuth().equals("2") ){
		// 시스템관리자, 과정운영자
		tmpSubjMenuId = "?menuId=3-1-1";
	}else if( memberInfo.getSessCurrentAuth().equals("A")){
		// 과정장
		tmpSubjMenuId = "?menuId=2-1-1";
	}else{
		tmpSubjMenuId = "";
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

	pform.action = "/courseMgr/courseSeq.do";
	pform.submit();

}


//과정 목록 리스트 가져오기.
function go_ajaxGrcode(year, grcode){

	var url = "/courseMgr/courseSeq.do";
	var pars = "mode=ajax_grcode&year="+year+"&grcode="+grcode;
	var divId = "divGrcode";

	var myAjax = new Ajax.Updater(
		{success:divId},
		url, 
		{
			asynchronous : false,
			method: "get", 
			parameters: pars,
			onFailure : function(){
				alert("Select 생성시 오류가 발생했습니다.");
			}
		}
	);

}


//개설과정 추가
function go_addGrcode(){

	$("mode").value = "grcode_form";

	pform.action = "/courseMgr/courseSeq.do";
	pform.submit();

}


//과정 기수 수정.
function go_modify(grseq){

	$("mode").value = "form";
	$("qu").value = "update";
	$("grseq").value = grseq;

	pform.action = "/courseMgr/courseSeq.do";
	pform.submit();

}

//기수 추가
function go_addGrseq(grseq){

	if(confirm("과정기수를 추가하시겠습니까?")) {
		$("mode").value = "exec";
		$("qu").value = "insert";
		$("grseq").value = grseq;

		pform.action = "/courseMgr/courseSeq.do";
		pform.submit();
	}

}

//과목 추가.
function go_addSubj(grseq){

	var grcode = $F("grcode");
	var grseq = grseq;
	var mode = "subj_list";
	var menuId = $F("menuId");
	var url = "/courseMgr/courseSeq.do?mode=" + mode + "&grcode=" + grcode + "&grseq=" + grseq + "&menuId=" + menuId;

	popWin(url, "pop_subj", "800", "600", "1", "");

}

//과목 수정.
function go_modifySubj(grseq, subj){

	$("mode").value = "subj_form";
	$("qu").value = "update";

	$("grseq").value = grseq;
	$("subj").value = subj;


	if($F("grcode") == '' || $F("grseq") == '' || $F("subj") == '')	{
		alert("과정, 과정기수, 과목의 선택이 올바르지 않습니다.");
		return;
	} else {

		pform.action = "/courseMgr/courseSeq.do<%= tmpSubjMenuId %>";
		pform.submit();

	}

}


//과목 삭제.
function go_deleteSubj(grseq, subj){

	if(subj == "")	{
		alert('삭제할 과목이 없습니다.');
		return;
	}

    if(confirm("해당 과목-기수의 모든 정보를 삭제하며 되돌릴 수 없습니다.\n\n 삭제하시겠습니까?"))	{

		$("mode").value = "exec";
		$("qu").value = "subj_delete";

		$("grseq").value = grseq;
		$("subj").value = subj;

		if($F("grcode") == '' || $F("grseq") == '' || $F("subj") == '')	{
			alert("삭제할 대상이 아닙니다.");
			return;
		}else{

			pform.action = "/courseMgr/courseSeq.do";
			pform.submit();

		}
	}

}

//이전 과목 복사
function go_copySubj(grcode, grseq){

	var mode = "copy_subj";
	var menuId = $F("menuId");
	var url = "/courseMgr/courseSeq.do?mode=" + mode + "&grcode=" + grcode + "&grseq=" + grseq + "&menuId=" + menuId;

	popWin(url, "pop_copySubj", "500", "300", "1", "");


}

//이전 기수 복사.
function go_copyPrevGrSeq(grcode, grseq){

	var mode = "copy_grseq";
	var menuId = $F("menuId");
	var url = "/courseMgr/courseSeq.do?mode=" + mode + "&grcode=" + grcode + "&grseq=" + grseq + "&menuId=" + menuId;

	popWin(url, "pop_copySubj", "600", "300", "1", "");

}


//파일 추가
function go_fileForm(grcode, grseq){

	var mode = "file_form";
	var menuId = $F("menuId");
	var url = "/courseMgr/courseSeq.do?mode=" + mode + "&grcode=" + grcode + "&grseq=" + grseq + "&menuId=" + menuId;

	popWin(url, "go_fileForm", "550", "500", "0", "0");

}

function go_evlinfoSubjForm(subj, commGrcode, commGrseq, ptype, evlYn, gakpoint, jupoint) {
	if (evlYn == 'N') {
		alert("해당 기수의 평가계획이 입력되어 있지 않아 시험지 생성 화면으로 이동할 수 없습니다.");
	} else if ((Number(gakpoint) + Number(jupoint)) == 0) {
		alert("해당 기수의 평가배점이 입력되어 있지 않아 시험지 생성 화면으로 이동할 수 없습니다.");
	} else {
		$("mode").value = "evlinfoSubjForm";
		
		var param = "";
		param = param + "?" + "subj=" + subj;
		param = param + "&" + "commGrcode=" + commGrcode;
		param = param + "&" + "commGrseq=" + commGrseq;
		param = param + "&" + "ptype=" + ptype;
		
		pform.action = "/courseMgr/courseSeq.do"+param;
		pform.submit();
	}
}

function go_evlinfoSubjOffForm(subj, commGrcode, commGrseq, ptype) {
	$("mode").value = "evlinfoSubjOffForm";
	
	var param = "";
	param = param + "?" + "subj=" + subj;
	param = param + "&" + "grcode=" + commGrcode;
	param = param + "&" + "grseq=" + commGrseq;
	
	pform.action = "/courseMgr/courseSeq.do"+param;
	pform.submit();
}

//로딩시.
onload = function()	{

	//상단 Onload시 셀렉트 박스 선택.
	var year = "<%= requestMap.getString("year") %>";
	$("year").value = year;

	var grcode = "<%= requestMap.getString("grcode") %>";
	//과정 목록
	go_ajaxGrcode(year, grcode);

}

//-->
</script>
<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<form id="pform" name="pform" method="post">
<input type="hidden" name="menuId"				value="<%=requestMap.getString("menuId")%>">
<input type="hidden" name="mode"				value="<%=requestMap.getString("mode")%>">

<input type="hidden" name="grseq"				value="<%=requestMap.getString("grseq")%>">
<input type="hidden" name="subj"				value="<%=requestMap.getString("subj")%>">
<input type="hidden" name="qu"					value="<%=requestMap.getString("qu")%>">

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
			<table width="100%" border="0" cellspacing="0" cellpadding="0" class="contentsTable">
				<tr>
					<td height="20">
						<img src="/images/bullet003.gif" width="11" height="11" align="bottom">&nbsp;<strong>과정기수관리 리스트</strong>
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
						<table class="search01">
							<tr>
								<th width="80" class="bl0">
									년도
								</th>
								<td width="20%">
									<div id="divYear" class="commonDivLeft">										
										<select name="year" onChange="setCommSession('year', this.value);go_ajaxGrcode(this.value, '');" style="width:100px;font-size:12px">
											<%= yearSelectBoxStr %>
										</select>
									</div>
								</td>
								<th width="80">
									과정명
								</th>
								<td>
									<div id="divGrcode" class="commonDivLeft">
										<select name="grcode" style="width:250px;font-size:12px">
											<option value="">**선택하세요**</option>
										</select>
									</div>
								</td>
								<td width="100" class="btnr">
									<input type="button" value="검색" onclick="go_reload();" class="boardbtn1">
								</td>
							</tr>
						</table>
						<!--//검색 -->	
						<div class="space01"></div>

						<!-- 버튼 -->
						<table class="btn01" style="clear:both;">
							<tr>
								<td class="right">
									<input type="button" value="시간표"			class="boardbtn1" onclick="fnGoTimeTableByAdmin();">&nbsp;&nbsp;
									<input type="button" value="강사지정"		class="boardbtn1" onclick="fnGoTutorSetting();">&nbsp;&nbsp;
									<input type="button" value="새로고침"		class="boardbtn1" onclick="go_list();">
								<%
									//권한이 과정운영자 일 경우만.
									if( !memberInfo.getSessClass().equals(Constants.ADMIN_SESS_CLASS_COURSEMAN) ){
								%>
									&nbsp;&nbsp;<input type="button" value="개설과정추가"	class="boardbtn1" onclick="go_addGrcode();">
								<%	
									} // end if
								%>
								</td>
							</tr>
						</table>
						<!-- //버튼  -->

						<div class="space01"></div>
						<div style="float:right;color:blue">(인원:수강신청/1차승인/입교자)</div>
						<div class="h5"></div>

						<table class="datah01">
							<thead>
							<tr>
								<th>과정명</th>
								<th>과정<br>기수</th>
								<th>과목<br>구분</th>
								<th>과목<br />분류</th>
								<th>과목명</th>
								<th>평가<br/>계획</th>
								<th>인원</th>
								<th>교육기간</th>
								<th>교육</th>
								<th>완결</th>
							<%
								//권한이 과정운영자 일 경우만.
								if( !memberInfo.getSessClass().equals(Constants.ADMIN_SESS_CLASS_COURSEMAN) ){
							%>
								<th class="br0">반영</th>
							<%	
								} // end if
							%>
							</tr>
							</thead>

							<tbody>
								<%= listStr.toString() %>
							</tbody>
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

