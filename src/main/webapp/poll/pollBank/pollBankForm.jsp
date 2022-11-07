<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 과정 설문관리 - 설문지 관리 등록 / 수정 폼.
// date : 2008-09-25
// auth : LYM
%>

<!-- [s] commonImport -->
<%@ include file="/commonInc/include/commonImport.jsp" %>
<!-- [e] commonImport -->

<%!
	//보기 유형 가져 오기.
	private String getAnswerKindOption(String answerKind){

		String returnStr = "";
		returnStr += "<option value='1' " + (answerKind.equals("1") ? "selected" : "") + ">단일선택</option>";
		returnStr += "<option value='2' " + (answerKind.equals("2") ? "selected" : "") + ">단일선택+주관식답변</option>";
		returnStr += "<option value='3' " + (answerKind.equals("3") ? "selected" : "") + ">다중선택</option>";
		returnStr += "<option value='4' " + (answerKind.equals("4") ? "selected" : "") + ">주관식답변</option>";

		return returnStr;
	}

%>

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

	//설문 정보
	DataMap rowMap = (DataMap)request.getAttribute("ROW_DATA");
	rowMap.setNullToInitialize(true);
	
	//보기 리스트 START
	DataMap sampList = null;
	if( rowMap.keySize("questionNo") > 0 ){
		sampList = (DataMap)rowMap.get("BANK_SAMP_LIST");
		if(sampList == null) sampList = new DataMap();
		sampList.setNullToInitialize(true);
	}else{
		sampList = new DataMap();
	}
	
	//보기 갯수.
	int sampListCnt = sampList.keySize("questionNo");

	//수정 페이지 인지 여부.
	boolean isModify = false;
	if( requestMap.getString("qu").equals("update") )
		isModify = true;

	String disSampStr = "";
	String disSampStr2 = "";
	String tmpAnswer = "";
	String tmpAnswerKind = "";
	for(int i=1; i <= 10; i++){

		if( i <= sampListCnt ){
			tmpAnswer = sampList.getString("answer", (i-1));
			tmpAnswerKind = sampList.getString("answerKind", (i-1));

			disSampStr += "\n<tr id='q_tr_row_"+i+"'>";
			disSampStr += "\n	<th width='20%'>보기"+i+"</th>";
			disSampStr += "\n	<td colspan='2'>";
			disSampStr += "\n		<select name='lym"+i+"_answerKind' class='mr10' style=\"display:none\" onChange=\"answerKindChange(this, false);\">";
			disSampStr += "\n		" + getAnswerKindOption(tmpAnswerKind);
			disSampStr += "\n		</select>";
			disSampStr += "\n		<textarea class='textarea01' style=\"width:99%;\" name=\"lym"+i+"_answer\">"+tmpAnswer+"</textarea>";
			disSampStr += "\n	</td>";
			disSampStr += "\n</tr>";

		}else{

			disSampStr2 += "\n<tr id='q_tr_row_"+i+"' style='display:none'>";
			disSampStr2 += "\n	<th width='20%'>보기"+i+"</th>";
			disSampStr2 += "\n	<td colspan='2'>";
			disSampStr2 += "\n		<select name='lym"+i+"_answerKind' class='mr10' style=\"display:none\" onChange=\"answerKindChange(this, false);\">";
			disSampStr2 += "\n		" + getAnswerKindOption("");
			disSampStr2 += "\n		</select>";
			disSampStr2 += "\n		<textarea class='textarea01' style=\"width:99%;\" name=\"lym"+i+"_answer\"></textarea>";
			disSampStr2 += "\n	</td>";
			disSampStr2 += "\n</tr>";

		}


	}

	//보기 갯수.
	String answerCntStr = "";
	for(int i=1; i <= 10; i++)
		answerCntStr += "<option value='"+i+"'>"+i+"</option>";

	//최소 선택 개수 Str
	String checkboxCheckedNoStr = "";
	for(int i=0; i <= sampListCnt; i++)
		checkboxCheckedNoStr += "<option value='"+i+"'>"+i+"</option>";
	
%>

<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->

<script language="JavaScript" type="text/JavaScript">
<!--

//리스트
function go_list(){

	$("mode").value = "list";
	$("qu").value = "";
	$("questionNo").value = "";
	$("question").value = "";
	$("checkedQuestion").value = "";
	$("checkedSamp").value = "";
	for(i=1;i<=10;i++){
		$("lym"+i+"_answer").value = "";
	}
	 
	pform.action = "/poll/pollBank.do";
	pform.submit();

}



//추가
function go_add(){


	if( go_inputCheck() && confirm("등록 하시겠습니까?") ){

		$("mode").value = "exec";
		$("qu").value = "insert";

		pform.action = "/poll/pollBank.do";
		pform.submit();
	}

}

//수정
function go_modify(){

	if( go_inputCheck() && confirm("수정 하시겠습니까?") ){

		$("mode").value = "exec";
		$("qu").value = "update";

		pform.action = "/poll/pollBank.do";
		pform.submit();
	}
}

//입력값 체크.
function go_inputCheck(){

	if(!go_commonCheckedCheck(pform.questionGubun)){
		alert("구분을 선택하세요!");
		return false;
	}

	if(!go_commonCheckedCheck(pform.questionCommGubun)){
		alert("공통설문구분을 선택하세요!");
		return false;
	}

	if($F("question") == ""){
		alert("질문을 입력하세요!");
		$("question").focus();
		return false;
	}

	if($F("answerCnt") == ""){
		alert("보기 갯수를 선택하세요!");
		return false;
	}

	return true;

}



//문자 바이트 체크
function fnCharCount(objname, size)
{
	var obj = $(objname);
	if (obj.value.length > size )
	{
		alert(size+"자리가 넘었습니다.");
		obj.value = obj.value.substr(0,size-1);
	}
	$("sizelength").value = obj.value.length;

}


	//LAYER VIEW
	function Q_Tr_View(num, total) {

		for(i=1;i < total; i++) {
			if(i <= num) {
				eval("q_tr_row_"+i+".style.display=''");
			}
			else{
				eval("q_tr_row_"+i+".style.display='none'");
			}
		}
	}

	// 보기 유형을 동일 하게변경 하는 함수
	function answerKindChange(obj, isLoading){
		//alert( [obj, isLoading] );
		 //질문항목의 동기화를 위해 추가
		$("thisAnswerKind").value = obj.value;

		if (obj.value == "2" ) {
			// 라디오 + 주관식이 한개만 되도록
			for ( i = 1; i <= 10; i ++){
				
				obj2 = $("lym"+i+"_answerKind");
				if ( obj2.value == "2" && obj.name != obj2.name){ 
					alert("라디오+객관식형 보기가 1개 이상 존재 할 수 없습니다.");
					$(obj.name).value = "1";
					//상단 셀렉트 동기화
					$("thisAnswerKind").value = "1";
					continue;
				}
			}
			$(obj.name).value = obj.value;
		}

		// 체크박스 유형을때만 최소선택갯수를 선택 할 수 있도록
		if (obj.value != "3") {
			$("ccno").style.display = 'none';
			$("checkboxCheckedNo").disabled = true;
		} else {
			$("ccno").style.display = 'block';
			$("checkboxCheckedNo").disabled = false;
		}

		for ( i = 1; i <= 10 ; i ++)
		{
			obj2 = $("lym"+i+"_answerKind");
			if (obj2.value == "2" && isLoading == true)
				continue;
			if (obj.value == 2 && obj2.value != 2){
				obj2.value = "1";
			} else {
				obj2.value = obj.value;
			}

			if(obj.value != 2){
				obj2.style.display = 'none';
			}else{
				obj2.style.display = 'block';
			}
		}
		// 주관식일때 보기 하나만 보이도록
		if (obj.value == "4" && !isLoading) {
			$("answerCnt").value = "1";
			chgExamCnt(1);
			return;
		}
	}


function chgExamCnt(answerCnt){
	if( $F("thisAnswerKind") == 4){ //주관식 답변의 경우 보기 개수는 1개
		
		$("answerCnt").value = 1;
		Q_Tr_View(1, 10);
		return;
	}

	//최소 선택 갯수
	createCheckBoxChecked(pform.checkboxCheckedNo, $F("answerCnt"));
	//removeAll(pform.checkboxCheckedNo);

	Q_Tr_View($F("answerCnt"), 10);
}


//관련질문 가상 삭제
function delRefQue(){

	$("nowque").style.display = 'none';
	$("checkedNoDel").checked = true;
	$("prevque").style.display = 'none';
}



//보기 등록.
function createCheckBoxChecked(oSelect, answerCnt) {
 
	removeAll(oSelect);
	for(i=0;i<=answerCnt;i++){
		var oOption = document.createElement("OPTION");
		oSelect.options.add(oOption);
		oOption.innerText = ""+i;
		oOption.value = ""+i;
	}

}

//selectBox 삭제
function removeAll(oSelect) {
 
	len = oSelect.options.length;
	for(i = len-1; i >= 0 ; i--) {
		oSelect.remove(i);
	}
}



//관련질문검색
function go_showMiniPop(questionNo){

	var mode = "show_mini";
	var menuId = $F("menuId");
	var url = "/poll/pollBank.do?mode=" + mode + "&menuId=" + menuId + "&questionNo=" + questionNo;

	popWin(url, "pop_showMiniPop", "700", "600", "1", "");

}



//로딩시.
onload = function()	{

	//문자 체크.
	fnCharCount('question', 400 );

	//보기 갯수
	$("answerCnt").value = "<%= sampListCnt > 0 ? (""+sampListCnt) : "" %>";

<%
	if(isModify){ // 수정 일 경우.
%>
		//설문 보기 유형
		$("thisAnswerKind").value = "<%= tmpAnswerKind %>";

		//최소 선택 갯수
		$("checkboxCheckedNo").value = "<%= rowMap.getInt("checkboxCheckedNo") %>";
<%
	}
%>

	// 페이지 로딩시 보기유형을 동일 하게 하기위한 프로세스
	if ( '<%= sampListCnt %>' != '' && '<%= sampListCnt %>' != '0' ) {
		for ( i = 1; i <= <%= sampListCnt %>; i++ ){
			obj = $("lym"+i+"_answerKind");
			if ( obj.value == 2){ //

				for ( k=1; k <= <%= sampListCnt %>; k++ ){
					obj2 = $("lym"+k+"_answerKind");
					obj2.style.display = "";
				}

				$("thisAnswerKind").value = "2";
				//answerKindChange($(obj.name), true);
				break;
			}
		}
		//최소 보기 갯수
		if($F("thisAnswerKind") != "3")
			$("ccno").style.display  = "none";
		else
			$("ccno").style.display  = "";
	}
	if ( $F("questionCheckedNo") > 0 && $F("checkedQuestion") ){
		$("prevque").style.display = '';
	}

}






//-->
</script>





<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<form id="pform" name="pform" method="post" >
<input type="hidden" name="menuId"				value="<%= requestMap.getString("menuId") %>">
<input type="hidden" name="mode"				value="<%= requestMap.getString("mode") %>">
<input type="hidden" name="currPage"			value="<%= requestMap.getString("currPage") %>">
<input type="hidden" name="searchKey"			value="<%= requestMap.getString("searchKey") %>">
<input type="hidden" name="searchValue"			value="<%= requestMap.getString("searchValue") %>">

<input type="hidden" name="qu"					value="<%= requestMap.getString("qu") %>">
<input type="hidden" name="questionNo"			value="<%= requestMap.getString("questionNo") %>">

<input type="hidden" name="questionCheckedNo"	value="<%= rowMap.getInt("questionCheckedNo")%>">
<input type="hidden" name="sampCheckedNo"		value="<%= rowMap.getInt("sampCheckedNo")%>">

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
						<!-- 상단 버튼  -->
						<table class="btn01">
							<tr>
								<td class="right">
									<input type="button" value="관련질문검색" onclick="go_showMiniPop(<%= rowMap.getInt("questionNo") %>);" class="boardbtn1">
								</td>
							</tr>
						</table>
						<!--// 상단 버튼  -->

						<!-- date -->
						<table  class="dataw01">
							<tr>
								<th width="20%">구분</th>
								<td colspan="2">
									<input type="radio" name="questionGubun" value="0" id="questionGubun1" <%= rowMap.getString("questionGubun").equals("0") ? "checked" : "" %>>
									<label for="questionGubun1">
										필수 
									</label>
									<input type="radio" name="questionGubun" value="1" id="questionGubun2" <%= rowMap.getString("questionGubun").equals("1") ? "checked" : "" %>>
									<label for="questionGubun2">
										공통 
									</label>
									<input type="radio" name="questionGubun" value="2" id="questionGubun3" <%= rowMap.getString("questionGubun").equals("2") ? "checked" : "" %>>
									<label for="questionGubun3">
										과목 
									</label>
								</td>
							</tr>
							<tr>
								<th width="20%">공통설문구분</th>
								<td colspan="2">
									<input type="radio" name="questionCommGubun" value="3" id="questionCommGubun1" <%= rowMap.getString("questionCommGubun").equals("3") ? "checked" : "" %>>
									<label for="questionCommGubun1">
										3일이하  
									</label>
									<input type="radio" name="questionCommGubun" value="5" id="questionCommGubun2" <%= rowMap.getString("questionCommGubun").equals("5") ? "checked" : "" %>>
									<label for="questionCommGubun2">
										5일이상 
									</label>
									<input type="radio" name="questionCommGubun" value="4" id="questionCommGubun3" <%= rowMap.getString("questionCommGubun").equals("4") ? "checked" : "" %>>
									<label for="questionCommGubun3">
										사이버 
									</label>
									<input type="radio" name="questionCommGubun" value="0" id="questionCommGubun4" <%= rowMap.getString("questionCommGubun").equals("0") ? "checked" : "" %>>
									<label for="questionCommGubun4">
										기타  
									</label>
								</td>
							</tr>

							<!-- 관련 질문 START -->
							<tr id="nowque" style='display:<%= rowMap.getInt("questionCheckedNo") > 0 ? "visible" : "none"%>;' >
								<th width="20%">관련 질문</th>
								<td>
									현 문제의 보기 번호 : <%= rowMap.getInt("sampCheckedNo") %> 선택시 관련 질문 번호는 : <%= rowMap.getInt("questionCheckedNo") %>
									&nbsp;&nbsp;
									<input type="button" value="관련질문삭제" onclick="delRefQue();" class="boardbtn1">
								</td>
							</tr>
							<tr id="prevque" style='display:none;'>
								<th width="20%">관련 질문</th>
								<td>
									질문 번호
									<input type="text" class="textfield" name="tempQuestionNo" value="<%= rowMap.getInt("questionCheckedNo") %>" style="width:30px" readonly/>&nbsp;
									보기번호
									<input type="text" class="textfield" name="tempSampNo" value="<%= rowMap.getInt("sampCheckedNo") %>" style="width:30px" readonly/>
									관련설문삭제 <input type="checkbox" class="chk" name="checkedNoDel" value="Y" onclick="delRefQue();"> <br>

									질문 <textarea class="textarea01" style="width:90%;" name="checkedQuestion" readonly><%= rowMap.getString("chkQuestion") %></textarea><br>
									보기 <textarea class="textarea01" style="width:90%;" name="checkedSamp" readonly><%= rowMap.getString("chkAnswer") %></textarea>

									<!-- 현 문제의 보기 번호 : <%//= rowMap.getInt("sampCheckedNo") %> 선택시 관련 질문 번호는 : <%//= rowMap.getInt("questionCheckedNo") %> -->
								</td>
							</tr>
							<!-- 관련 질문 END -->


							<tr>
								<th width="20%">질문</th>
								<td colspan="2">
									<textarea class="textarea01" style="width:99%;" name="question" onKeyUp="fnCharCount(this.name,400);"><%= rowMap.getString("question") %></textarea><br>
									<span class="txt_99 mr10">* 질문 내용은 400자 까지만 입력이 가능 합니다.</span>
									<input type="text" class="textfield" name="sizelength" value="0" maxlength="3" style="width:30px" readonly /> 자
								</td>
							</tr>
							<tr>
								<th width="20%">보기 개수</th>
								<td>
									<select name="answerCnt" class="mr10" onChange="chgExamCnt(this.value);">
										<option value="">보기갯수 선택</option>
										<%= answerCntStr %>
									</select>
									설문 보기 유형 
									<select name="thisAnswerKind" class="mr10" onChange="answerKindChange(this, false);">
										<option value="1">단일선택</option>
										<option value="2">단일선택+주관식답변</option>
										<option value="3">다중선택</option>
										<option value="4">주관식답변</option>
									</select>
								</td>
								<td width="30%" style='text-align:left'>
									<div id="ccno" style='display:<%= isModify ? "" : "none" %>'>
										최소선택갯수
										<select name="checkboxCheckedNo" class="mr10">
											<%= checkboxCheckedNoStr %>
										</select>
									</div>
								</td>
							</tr>

							<%= disSampStr %>
							<%= disSampStr2 %>
							
						</table>
						<!-- //date -->

						<!-- 테이블하단 버튼  -->
						<table class="btn01" style="clear:both;">
							<tr>
								<td class="right">
								<%if( requestMap.getString("qu").equals("insert") ){ %>
									<input type="button" value="등록" onclick="go_add();" class="boardbtn1">
								<%}else{ %>
									<input type="button" value="수정" onclick="go_modify();" class="boardbtn1">
								<%}%>
									<input type="button" value="리스트" onclick="go_list();" class="boardbtn1">
								</td>
							</tr>
						</table>
						<!-- //테이블하단 버튼  -->
					</td>
				</tr>
			</table>
			<!--//[e] Contents Form  -->
			<div class="space_ctt_bt"></div>
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

