<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 수료 이력 조회 (팝업)
// date : 2008-06-26
// auth : LYM
%>

<!-- [s] commonImport -->
<%@ include file="/commonInc/include/commonImport.jsp" %>
<!-- [e] commonImport -->

<%
    //request 데이터
	DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
	requestMap.setNullToInitialize(true);       


    //수료이력 리스트
	DataMap rowMap = (DataMap)request.getAttribute("ROW_DATA");
	rowMap.setNullToInitialize(true); 

	//유저 정보.
	DataMap userRowMap = (DataMap)request.getAttribute("USER_ROW_DATA");
	userRowMap.setNullToInitialize(true);

	//기관 리스트
	DataMap deptListMap = (DataMap)request.getAttribute("DEPT_LIST_DATA");
	deptListMap.setNullToInitialize(true);

	String tmpStr = "";

	//기관 selectBox
	String deptSelStr = "";
	for(int i=0; i < deptListMap.keySize("dept"); i++){

		tmpStr = deptListMap.getString("dept", i).equals(rowMap.getString("dept")) ? "selected" : "";
		deptSelStr += "<option value='" + deptListMap.getString("dept", i) + "' "+tmpStr+">" + deptListMap.getString("deptnm", i) + "</option>";
	}

	//수강 신청 정보의 부서정보 없으면 회원의 정보를 가져옴.
	String deptStr = "";
	String partcd = "";
	if(rowMap.getString("deptsub").equals("") && rowMap.getString("partcd").equals("")){
		deptStr = userRowMap.getString("deptsub");
		partcd = userRowMap.getString("partcd");
	}else{
		deptStr = rowMap.getString("deptsub");
		partcd = rowMap.getString("partcd");
	}

%>


						
<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->
<script language="JavaScript">
<!--

//부서 SelectBox Ajax
function go_partCode(dept, partcd){

	var objAjax = new Object();
	objAjax.url = "/courseMgr/lectureApply.do";
	objAjax.pars = "mode=ajax_part"+"&dept="+ dept +"&partcd="+ partcd;
	objAjax.aSync = true; 
	objAjax.targetDiv = "divSelPartcd";

	go_ajaxCommonObj(objAjax); //Ajax 통신.

}

//기관 선택시.
function go_changeDept(dept, partcd){

	go_setPartNm('');
	go_partCode(dept, partcd);
}

//부서명 셋팅.
function go_setPartNm(deptsubnm){
	$("deptsub").value = deptsubnm;
}

//수정하기.
function go_modify()	{

	$("mode").value = "exec";
	$("qu").value = "appinfo_update";

	//휴대폰번호
	//$("hp").value = $("hp1").value + $("hp2").value + $("hp3").value;
	
	var form1 = document.all;
	if(form1.deptsub.value == "") {
		alert("부서명을 입력해주세요.");
		return;
	}
	if(form1.dept.value == "6289999") {
		if(form1.partcd.value == "") {
			alert("공사공단은 집적입력이 되지 않습니다. 부서명을 선택해주세요.");
			return;
		}
	}
	
	pform.action = "/courseMgr/lectureApply.do";
	pform.submit();
}

//수강신청정보 삭제하기
function go_delete() {
	$("mode").value = "exec";
	$("qu").value = "appinfo_delete";

	pform.action = "/courseMgr/lectureApply.do";
	pform.submit();
}


//-->
</script>


<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<form id="pform" name="pform" method="post">
<input type="hidden" name="menuId"				value="<%=requestMap.getString("menuId")%>">
<input type="hidden" name="mode"				value="<%=requestMap.getString("mode")%>">

<input type="hidden" name="qu"					value='<%=requestMap.getString("qu")%>'>

<input type="hidden" name="grcode"				value='<%=requestMap.getString("grcode")%>'>
<input type="hidden" name="grseq"				value='<%=requestMap.getString("grseq")%>'>
<input type="hidden" name="userno"				value='<%=requestMap.getString("userno")%>'>

<table class="pop01">
	<tr>
		<td class="titarea">
			<!-- 타이틀영역 -->
			<div class="tit">
				<h1 class="h1"><img src="/images/bullet_pop.gif" /> 수강생 정보 수정</h1>
			</div>
			<!--// 타이틀영역 -->
		</td>
	</tr>
	<tr>
		<td class="con">
			<!-- date -->
			<table  class="dataw01">
				<tr>
					<th width="20%">이름</th>
					<td><%= userRowMap.getString("name") %></td>
				</tr>
				<tr>
					<th>소속기관명</th>
					<td>
						<select name="dept" onChange="go_changeDept(this.value, '');">
							<%= deptSelStr %>
						</select>
					</td>
				</tr>
				<tr>
					<th>부서명</th>
					<td>
						<div class="commonDivLeft">
							<input type="text" class="textfield" name="deptsub" value="<%= deptStr %>" style="width:150" />&nbsp;
						</div>

						<div id="divSelPartcd" class="commonDivLeft">
							<select name="partcd">
							</select>
						</div>
					</td>
				</tr>
				<tr>
					<th>직급</th>
					<td>
						<input type="text" class="textfield" name="jiknm" value="<%= rowMap.getString("jiknm") %>" style="width:35%" readonly onclick="go_commonSearchJik('pform.jik', 'pform.jiknm');" />
						<input type="hidden" name="jik" value="<%= rowMap.getString("jik") %>">
						<input type="button" value="검색" onclick="go_commonSearchJik('pform.jik', 'pform.jiknm');" class="boardbtn1">
					</td>
				</tr>
				<tr>
					<th>휴대폰번호</th>
					<td><input type="text" class="textfield" id="hp" name="hp" value="<%= userRowMap.getString("hp") %>" style="width:150" /></td>
				</tr>
			</table>
			<!-- //date -->

			<!-- 하단 닫기 버튼  -->
			<table class="btn02">
				<tr>
					<td class="center">
						<input type="button" value="수정" onclick="go_modify();" class="boardbtn1" alt="수정">
						<input type="button" value="삭제" onclick="go_delete();" class="boardbtn1" alt="수강신청정보 삭제">
						<input type="button" value="닫기" onclick="javascript:window.close();" class="boardbtn1">
					</td>
				</tr>
			</table>
			<!--// 하단 닫기 버튼  -->
		</td>
	</tr>
</table>

</form>
<script language="JavaScript">
<!--
	//부서 리스트 가져오기.
	go_partCode( $F("dept"), '<%= partcd %>');

//-->
</script>
</body>
