<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%  
// prgnm : 과목 검색 팝업
// date : 2008-06-17
// auth : Lym
%>

<!-- [s] commonImport -->
<%@ include file="/commonInc/include/commonImport.jsp" %>
<!-- [e] commonImport -->

<%
	
	DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
	requestMap.setNullToInitialize(true);
	
	//검색된 과목.
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	listMap.setNullToInitialize(true);
	
	//이미 등록된 과목.
	DataMap selectedMap = (DataMap)request.getAttribute("SELECTED_DATA");
	selectedMap.setNullToInitialize(true);

	String listStr = "";
	String tmpStr = "";


	for(int i=0; i < listMap.keySize("subj"); i++){

		listStr += "<tr bgColor='#FFFFFF' height='20'>";

		//선택
		tmpStr = "<INPUT TYPE=\"checkbox\" NAME=\"subj\" value='" + listMap.getString("subj", i) + "'>";
		listStr += "	<td align='center' class='tableline11' >" + tmpStr + "</td>";

		//과목코드
		if(listMap.getString("selGubun", i).equals("P"))
			tmpStr = "선택";
		else
			tmpStr = "일반";
		listStr += "	<td align='center' class='tableline11' >" + tmpStr + "&nbsp;</td>";

		//과목코드
		listStr += "	<td align='center' class='tableline11' >" + listMap.getString("subj", i) + "&nbsp;</td>";

		//과목유형
		if(listMap.getString("subjtype", i).equals("Y"))
			tmpStr = "사이버";
		else if(listMap.getString("subjtype", i).equals("N"))
			tmpStr = "집합";
		else if(listMap.getString("subjtype", i).equals("S"))
			tmpStr = "특수";
		else if(listMap.getString("subjtype", i).equals("M"))
			tmpStr = "동영상";
		else
			tmpStr = "&nbsp;";
		listStr += "	<td align='center' class='tableline11' >" + tmpStr + "&nbsp;</td>";

		//과목명
		listStr += "	<td align='left' class='tableline21' >&nbsp;" + listMap.getString("subjnm", i) + "</td>";

		listStr += "</tr>";

	}



	//페이징 String
	String pageStr = "";
	String pageSelectStr = "";

	if( !requestMap.getString("search").equals("GO")){

		listStr += "<tr bgColor='#FFFFFF'>";
		listStr += "	<td align='center' class='tableline21' colspan='100%' height='80'>검색을 해주시기 바랍니다.</td>";
		listStr += "</tr>";

	}else{

		//row가 없으면.
		if( listMap.keySize("subj") <= 0){

			listStr += "<tr bgColor='#FFFFFF'>";
			listStr += "	<td align='center' class='tableline21' colspan='100%' height='80'>등록된 과목이 없습니다.</td>";
			listStr += "</tr>";

		}

		//페이지 처리
		PageNavigation pageNavi = (PageNavigation)listMap.get("PAGE_INFO");
		int pageNum = pageNavi.getTotalCnt() - (requestMap.getInt("currPage") - 1) * requestMap.getInt("rowSize");

		if(listMap.keySize("subj") > 0){
			pageStr += pageNavi.showFirst();
			pageStr += pageNavi.showPrev();
			pageStr += pageNavi.showPage();
			pageStr += pageNavi.showNext();
			pageStr += pageNavi.showLast();

			pageSelectStr += "<select name=\"rowSize\" onChange=\"go_list();\">";
			pageSelectStr += "	<option value=\"10\" "+(requestMap.getString("rowSize").equals("10") ? "selected" : "")+">10</option>";
			pageSelectStr += "	<option value=\"20\" "+(requestMap.getString("rowSize").equals("20") ? "selected" : "")+">20</option>";
			pageSelectStr += "	<option value=\"50\" "+(requestMap.getString("rowSize").equals("50") ? "selected" : "")+">50</option>";
			pageSelectStr += "	<option value=\"100\" "+(requestMap.getString("rowSize").equals("100") ? "selected" : "")+">100</option>";
			pageSelectStr += "</select>";
		}

	}

	String selectedStr = "";
	for(int i=0; i < selectedMap.keySize("subj"); i++){
		if((i % 2) == 0){
			selectedStr += "<tr bgColor='#F7F7F7' height='20'>";
		}
		
		
		if(i % 2 == 0){
			selectedStr += "<td class='tableline11' align='center'>"+selectedMap.getString("subjnm", i)+"("+selectedMap.getString("subj", i)+")</td>";
			
		}else{
			selectedStr += "<td class='tableline21' align='center'>"+selectedMap.getString("subjnm", i)+"("+selectedMap.getString("subj", i)+")</td>";
		}
		
		
		if((i % 2) == 1){
			selectedStr += "</tr>";
		}

	}

	if(selectedMap.keySize("subj") > 0 && (selectedMap.keySize("subj") % 2) == 1){
		selectedStr += "	<td>&nbsp;</td>";
		selectedStr += "</tr>";
	}



	//검색 셋팅.
	String searchSubj = "";
	if(requestMap.getString("qu").equals("button"))
		searchSubj = requestMap.getString("searchValue");

	// 한글문자 인덱스
	DataMap indexMap = (DataMap)request.getAttribute("INDEX_DATA");
	indexMap.setNullToInitialize(true);
	StringBuffer sbCharIndex = new StringBuffer();
	
	sbCharIndex.append("<a href=\"javascript:go_searchIndex('');\">전체</a>&nbsp;");
	for(int i=0; i < indexMap.keySize("indexseq"); i++){
		
		sbCharIndex.append("<a href=\"javascript:go_searchIndex('" + indexMap.getString("indexseq", i) + "');\">");
		
		//인덱스 검색이고 값이 map값과 같다면 B태그
		if( requestMap.getString("qu").equals("index") && indexMap.getString("indexseq", i).equals( requestMap.getString("searchValue") ) ){
			sbCharIndex.append("<b>" + indexMap.getString("startchar", i) + "</b>");
		}else{
			sbCharIndex.append( indexMap.getString("startchar", i) );
		}
				
		sbCharIndex.append("</a>&nbsp;");
	}




%>




<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->

<script language="JavaScript">
<!--

//페이지 이동
function go_page(page) {
	$("currPage").value = page;

	pform.action = "/courseMgr/courseSeq.do";
	pform.submit();
}

//인덱스 누를때
function go_searchIndex(indexKey){

	$("qu").value = "index";
	$("searchValue").value = indexKey;

	go_list();
}

//검색 버튼 누를때
function go_searchButton(){
	
	if(IsValidCharSearch($("searchSubj").value) == false){
		return false;
	}
	
	
	$("qu").value = "button";
	$("searchValue").value = $F("searchSubj");

	go_list();

}

//
function go_list() {

	$("currPage").value = "1";
	$("search").value = "GO";
	$("mode").value = "subj_list";
	pform.action = "/courseMgr/courseSeq.do";
	pform.submit();
}

//등록
function go_submit(){

	var isSelect = false;
	var checkBox = pform.subj;

	if(checkBox.length == undefined || checkBox.length == 1){
		if(checkBox.checked){
			isSelect = true;
		}
	}else{
		for( i=0; i < checkBox.length ; i++){
			if(checkBox[i].checked){
				isSelect = true;
			}
		}
	}

	if(!isSelect){
		alert("과목을 하나이상 선택해주세요.");
		return;
	}

	$("mode").value = "subj_exec";
	$("qu").value = "insert";
	pform.action = "/courseMgr/courseSeq.do";
	pform.submit();

	//opener.location.href = "/courseMgr/courseSeq.do";
	//opener.window.go_list();
	//self.close();
}

// 과목등록
function fnSubjReg(mode){

	var menuId = "3-1-1"; //과목 추가 메뉴 아이디. 

	var parms = "?mode=" + mode + "&menuId=" + menuId;
	var url = "/baseCodeMgr/subj.do";
	opener.location.href = url + parms;
	self.close();

}

//로딩시.
onload = function()	{

}

function parentClose() {
	self.close();
	opener.location.href = "/courseMgr/courseSeq.do?mode=list&menuId="+$F("menuId");
}
//-->
</script>

<body leftmargin="0" topmargin=0>

<form name="pform" method="post">
<input type="hidden" name="mode"				value="<%=requestMap.getString("mode")%>">
<input type="hidden" name="menuId" 	value="<%= requestMap.getString("menuId") %>">
<input type="hidden" name="currPage"			value='<%=requestMap.getString("currPage")%>'>

<input type="hidden" name="year"				value='<%=requestMap.getString("year")%>'>
<input type="hidden" name="grcode"				value='<%=requestMap.getString("grcode")%>'>
<input type="hidden" name="grseq"				value='<%=requestMap.getString("grseq")%>'>

<input type="hidden" name="qu"					value='<%=requestMap.getString("qu")%>'>
<input type="hidden" name="search"				value='<%=requestMap.getString("search")%>'>
<input type="hidden" name="searchValue"			value='<%=requestMap.getString("searchValue")%>'>


<table cellspacing="0" cellpadding="0" border="0" width="100%">
	<tr><td height="4" bgcolor="#0081C4" nowrap></td></tr>
	<tr>
		<td height="45" bgcolor="#FFFFFF" style="padding-left:10px" nowrap>

			<!-- 타이틀영역 -->
			<table cellspacing="0" cellpadding="0" border="0">
				<tr>
					<td width="15" align="left"><img src="/images/bullet_pop.gif" width="10" height="22" border="0"></td>
					<td><font color="#000000" style="font-weight:bold; font-size:13px">과정기수관리 과목코드추가</font></td>
				</tr>
			</table>
			<!--// 타이틀영역 -->
		</td>
	</tr>
	<tr>
		<td height="100%" style="background:#FFFFFF URL(/images/bg_pop.gif) repeat-x; padding:20px; line-height:18px" valign="top">
			
			<!--// 본문영역 -->
			<!-- space --><table width="100%" height="10"><tr><td></td></tr></table>


			<!--[s] 검색 -->
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr bgcolor="#375694"><td height="2" colspan="100%"></td></tr>

				<tr height="28" bgcolor="F7F7F7">
					<td width="80" align="center" class="tableline11"><strong>구분</strong></td>
					<td align='left' class="tableline11" bgcolor='#FFFFFF' style="padding:0 0 0 9">&nbsp;
						<select name="searchKey" onChange="go_list();">
							<option value=""  <%= requestMap.getString("searchKey").equals("") ? "selected" : "" %>>과목유형선택</option>
							<option value="Y" <%= requestMap.getString("searchKey").equals("Y") ? "selected" : "" %>>사이버</option>
							<option value="N" <%= requestMap.getString("searchKey").equals("N") ? "selected" : "" %>>집합</option>
							<option value="S" <%= requestMap.getString("searchKey").equals("S") ? "selected" : "" %>>특수</option>
						</select>
					</td>
					<td width="80" align="center" class="tableline11"><strong>과목명</strong></td>
					<td align='left' class="tableline11" bgcolor='#FFFFFF' style="padding:0 0 0 9">
						<input type="text" class="textfield" onkeypress="if(event.keyCode==13){go_searchButton();return false;}" name="searchSubj" value="<%= searchSubj %>" style="width:100">
					</td>
					<td rowspan="2" bgcolor="#FFFFFF" width="100" align="center">
						<input type="button" value="검 색" onclick="go_searchButton();" class="boardbtn1">
					</td>
				</tr>


				<tr height="28" bgcolor="F7F7F7" >
					<td align="center" class="tableline11"><strong>인덱스</strong></td>
					<td align="left" class="tableline11" bgcolor='#FFFFFF' style="padding:0 0 0 9" colspan="3">&nbsp;
						<%= sbCharIndex.toString() %>&nbsp;
					</td>
				</tr>
													
				<tr bgcolor="#375694"><td height="2" colspan="100%"></td></tr>
			</table>
			<!-- space --><table width="100%" height="10"><tr><td></td></tr></table>
			<!--[e] 검색 -->

			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr height="28" >
					<td bgcolor='#FFFFFF'align="right">
						<input type="button" class="boardbtn1" value='일반과목추가' onClick="fnSubjReg('sform');">
						<input type="button" class="boardbtn1" value='선택과목추가' onClick="fnSubjReg('oform');">&nbsp;&nbsp;&nbsp;
						<input type="button" class="boardbtn1" value=' 저장 ' onClick="go_submit();">
						<input type="button" class="boardbtn1" value=' 닫기 ' onClick="javascript:parentClose();">
					</td>
				</tr>
			</table>
			<!-- space --><table width="100%" height="5"><tr><td></td></tr></table>


			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr bgcolor="#375694"><td height="2" colspan="100%"></td></tr>
				<tr height='28' bgcolor="#5071B4">
					<td width="5%" align='center' class="tableline11 white"><strong>선택</strong></td>
					<td width="10%" align='center' class="tableline11 white"><strong>과목구분</strong></td>
					<td width="20%" align='center' class="tableline11 white"><strong>과목코드</strong></td>
					<td width="10%" align='center' class="tableline11 white"><strong>과목유형</strong></td>
					<td width="*" align='center' class="tableline11 white"><strong>과목명</strong></td>
				</tr>

				<%= listStr %>

			</table>

			<!-- space --><table width="100%" height="10"><tr><td></td></tr></table>
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr bgcolor="#ffffff">
					<td width="10" align='left'>&nbsp;</td>
					<td align='center'>
						<%=pageStr%>
					</td>
					<td width="10" align='right'><%=pageSelectStr%></td>
				</tr>
			</table>

			<!--// 본문영역 -->

		</td>
	</tr>
	<tr>
		<td height="20" align="right" nowrap>
			<input type="button" class="boardbtn1" value=' 저장 ' onClick="go_submit();">
			<input type="button" class="boardbtn1" value=' 닫기 ' onClick="javascript:parentClose();">&nbsp;&nbsp;&nbsp;
		</td>
	</tr>

	<tr>
		<td align='center'>
			
			<!-- 지정된 과목 -->
			<!-- space --><table width="100%" height="10"><tr><td></td></tr></table>
			<!-- LINE --><table width="100%"><tr><td height="1" bgcolor="#375694"></td></tr></table>
			<!-- space --><table width="100%" height="10"><tr><td></td></tr></table>

			<table width="60%" border="0" cellspacing="0" cellpadding="0">
				<tr bgcolor="#375694"><td height="2" colspan="100%"></td></tr>
				<tr height='28' bgcolor="#5071B4">
					<td align='center' class="tableline11 white" colspan="100%"><strong>과목명(과목코드)</strong></td>
				</tr>

				<%= selectedStr %>
			</table>

			<!-- space --><table width="100%" height="30"><tr><td></td></tr></table>

			<!--// 지정된 과목 -->

		</td>
	</tr>




</table>

</form>

</body>
