<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 교육생(입교자) 조회 - 수강자 정보 수정.
// date : 2008-07-02
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



%>


						
<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->
<script language="JavaScript">
<!--


//수정하기.
function go_modify()	{

	if( $F("dept") == "" ){
		alert('소속기관을 입력해 주십시요');
		return;
	}

	if( NChecker(document.pform) && confirm("수정 하시겠습니까?") ){

		$("mode").value = "exec";
		$("qu").value = "app_update";

		pform.action = "/courseMgr/stuEnter.do";
		pform.submit();

	}

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

			<div class="tit0101">
				<strong class="txt00">소속은 개인정보에서도 변경가능합니다.</strong>
			</div>

			<!-- date -->
			<table  class="dataw01">
				<tr>
					<th width="25%" >소속기관명</th>
					<td>
						<select name="dept">
							<%= deptSelStr %>
						</select>
						<br> <span class="font1">(시산하 및 사업소는 인천광역시 선택)</span>
					</td>
				</tr>
				<tr>
					<th>소속</th>
					<td>
						<input type="text" class="textfield" name="deptsub" value="<%= rowMap.getString("memberDeptsub") %>" style="width:90%" />&nbsp;
					</td>
				</tr>
				<tr>
					<th>직급</th>
					<td>
						<input type="text" class="textfield" name="jiknm" value="<%= rowMap.getString("jiknm") %>" style="width:70%" readonly onclick="go_commonSearchJik('pform.jik', 'pform.jiknm');" required="true!직급을 입력해 주십시요!" />
						<input type="hidden" name="jik" value="<%= rowMap.getString("jik") %>">
						<input type="button" value="검색" onclick="go_commonSearchJik('pform.jik', 'pform.jiknm');" class="boardbtn1">
					</td>
				</tr>
			</table>
			<!-- //date -->

			<!-- 하단 닫기 버튼  -->
			<table class="btn02">
				<tr>
					<td class="center">
						<input type="button" value="정보 수정" onclick="go_modify();" class="boardbtn1">
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
	//go_partCode( $F("dept"), '<%//= partcd %>');

//-->
</script>
</body>
