<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 시간표 등록/ 수정/ 과목 추가 폼.
// date : 2008-07-30
// auth : LYM
%>

<!-- [s] commonImport -->
<%@ include file="/commonInc/include/commonImport.jsp" %>
<!-- [e] commonImport -->

<%
    //request 데이터
	DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
	requestMap.setNullToInitialize(true);       


	//과정기수 정보.
	DataMap grseqRowMap = (DataMap)request.getAttribute("GRSEQ_ROW_DATA");
	grseqRowMap.setNullToInitialize(true);

	//기수의 강의실 정보
	DataMap grseqClassroomMap = (DataMap)request.getAttribute("GRSEQ_CLASSROOM_ROW_DATA");
	grseqClassroomMap.setNullToInitialize(true);


    //
	DataMap rowMap = (DataMap)request.getAttribute("ROW_DATA");
	rowMap.setNullToInitialize(true); 


	//강사 리스트
	DataMap tutorListMap = (DataMap)request.getAttribute("TUTOR_LIST_DATA");
	tutorListMap.setNullToInitialize(true);

	String tmpStr = "";

	String tutorStr = "";
	String tutorNoStr = "";

	for(int i=0; i < tutorListMap.keySize("userno"); i++){

		if(i > 0){
			tutorStr += "|";
			tutorNoStr += "|";
		}
			
		tutorStr += tutorListMap.getString("name", i);
		tutorNoStr += tutorListMap.getString("userno", i);
	}

	String grseqNm = grseqRowMap.getString("grcodeniknm") + " - " + StringReplace.subString(grseqRowMap.getString("grseq"), 0, 4) + "년 " + StringReplace.subString(grseqRowMap.getString("grseq"), 4, 6) + "기";


%>


						
<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->
<script language="JavaScript">
<!--




// 강의실 지정취소.
function go_classCancel(){

	$("classroomName").value = "";
	$("classroomNo").value = "";
}

// 기수의 강의실 정보 지정.
function go_setGrseqClass(){

	$("classroomName").value = $F("grseqClassName");
	$("classroomNo").value = $F("grseqClassNo");
}


// 과목 검색
function go_searchSubj(){

	var url = "/courseMgr/timeTable.do?mode=search_subj&grcode="+$F("grcode")+"&grseq="+$F("grseq");
	popWin(url, "pop_searchSubj", "500", "600", "1", "");

}

//강사 검색.
function go_searchTutor(){

	if ($F("subj") == "") {
		alert("과목을 먼저 선택하세요.");
		return;
	}

	var parms = "?mode=search_tutor&menuId=" + $F("menuId") + "&grcode=" + $F("grcode") + "&grseq=" + $F("grseq") + "&studydate=" + $F("studydate") + "&studytime=" + $F("studytime") + "&subj=" + $F("subj");
	var url = "/courseMgr/timeTable.do" + parms;

	popWin(url, "pop_searchTutor", "500", "500", "1", "");

}


//과목선택
function go_insert(){

	if( $F("subj") == "" ){
		alert("과목을 지정하세요");
		return;
	}

	if( confirm("등록 하시겠습니까?") ){
		$("mode").value = "exec";
		$("qu").value = "insert";

		pform.action = "/courseMgr/timeTable.do";
		pform.submit();

	}

}

//과목수정
function go_modify(){

	if( $F("subj") == "" ){
		alert("과목을 지정하세요");
		return;
	}

	if( confirm("수정 하시겠습니까?") ){
		$("mode").value = "exec";
		$("qu").value = "update";

		pform.action = "/courseMgr/timeTable.do";
		pform.submit();

	}

}



//과목추가
function go_add(){

	if( $F("subj") == "" ){
		alert("과목을 지정하세요");
		return;
	}

	if( confirm("과목추가 하시겠습니까?") ){

		$("mode").value = "exec";
		$("qu").value = "add";

		pform.action = "/courseMgr/timeTable.do";
		pform.submit();

	}

}
//-->
</script>


<body>

<form id="pform" name="pform" method="post">
<input type="hidden" id="menuId" name="menuId"				value="<%=requestMap.getString("menuId")%>">
<input type="hidden" id="mode" name="mode"				value="<%=requestMap.getString("mode")%>">

<input type="hidden" id="qu" name="qu"					value='<%=requestMap.getString("qu")%>'>

<input type="hidden" id="studyWeek" name="studyWeek"			value="<%=requestMap.getString("studyWeek")%>">
<input type="hidden" id="searchKey" name="searchKey"			value="<%=requestMap.getString("searchKey")%>">

<input type="hidden" id="grcode"	 name="grcode"				value='<%=requestMap.getString("grcode")%>'>
<input type="hidden" id="grseq" name="grseq"				value='<%=requestMap.getString("grseq")%>'>

<input type="hidden" id="studydate" name="studydate"			value='<%=requestMap.getString("studydate")%>'>
<input type="hidden" id="studytime" name="studytime"			value='<%=requestMap.getString("studytime")%>'>

<input type="hidden" id="keySubj"	 name="keySubj"				value='<%=requestMap.getString("subj")%>'>

<table class="pop01">
	<tr>
		<td class="titarea">
			<!-- 타이틀영역 -->
			<div class="tit">
				<h1 class="h1"><img src="/images/bullet_pop.gif" /> 시간표 입력/수정</h1>
			</div>
			<!--// 타이틀영역 -->
		</td>
	</tr>
	<tr>
		<td class="con">
			<!-- date -->
			<table  class="dataw01">
				<tr>
					<th colspan="2"><strong><%= grseqNm %></strong></th>
				</tr>
				<tr>
					<th width="20%">강의요일/교시</th>
					<td><%= DateUtil.convertDate6(requestMap.getString("studydate")) %>일 / <%= requestMap.getString("studytime").replaceAll("[|]", ",")%>교시</td>
				</tr>
				<tr>
					<th>과목검색</th>
					<td>
						<input type="text" class="textfield" id="lecnm" name="lecnm" value="<%= rowMap.getString("lecnm") %>" style="width:35%" readonly />
						<input type="hidden" id="subj" name="subj" value="<%= rowMap.getString("subj") %>">
						<input type="button" value="검색" onclick="go_searchSubj();" class="boardbtn1">
					</td>
				</tr>
				<tr>
					<th>강의실</th>
					<td>
						<input type="text" class="textfield" id="classroomName" name="classroomName" value="<%= rowMap.getString("classroomName") %>" style="width:35%" readonly />
						<input type="hidden" id="classroomNo" name="classroomNo" value="<%= rowMap.getString("classroomNo") %>">
						<input type="button" value="검색" onclick="com_findClassroom('classroomNo', 'classroomName', 'pop_classroom', true);" class="boardbtn1 mr10" />
					<%if(!grseqClassroomMap.getString("classroomNo").equals("")){%>
						<input type="hidden" id="grseqClassNo" name="grseqClassNo"		value='<%=grseqClassroomMap.getString("classroomNo")%>'>
						<input type="hidden" id="grseqClassName" name="grseqClassName"		value='<%=grseqClassroomMap.getString("classroomName")%>'>
						<a href="javascript:go_setGrseqClass();"><span class="txt_blue"><%= grseqClassroomMap.getString("classroomName") %>지정</span></a>
					<%}%>	
						&nbsp;&nbsp;<a href="javascript:go_classCancel();"><span class="txt_blue">지정취소</span></a>
					</td>
				</tr>
				<tr>
					<th>강사검색</th>
					<td>
						<input type="text" class="textfield" id="tusernoName" name="tusernoName" value="<%= tutorStr %>" style="width:35%" readonly />
						<input type="hidden" id="tuserno" name="tuserno" value="<%= tutorNoStr %>">
						<input type="button" value="검색" onclick="go_searchTutor();" class="boardbtn1">
					</td>
				</tr>
			</table>
			<!-- //date -->

			<!-- 하단 닫기 버튼  -->
			<table class="btn02">
				<tr>
					<td class="center">
					<%if(requestMap.getString("qu").equals("insert")){%>
						<input type="button" class="boardbtn1" value='등록' onClick="go_insert();">
					<%}else if(requestMap.getString("qu").equals("update")){%>
						<input type="button" class="boardbtn1" value='수정' onClick="go_modify();" >
					<%}else if(requestMap.getString("qu").equals("add")){%>
						<input type="button" class="boardbtn1" value='추가' onClick="go_add();" >
					<%}%>
						<input type="button" value="닫기" onclick="window.close();" class="boardbtn1">
					</td>
				</tr>
			</table>
			<!--// 하단 닫기 버튼  -->
		</td>
	</tr>
</table>
</form>

</body>
