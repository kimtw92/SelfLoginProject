<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 동영상 강의 분류 입력/수정 화면 (팝업)
// date  : 2009-06-03
// auth  : hwani
%>

<!-- [s] commonImport -->
<%@ include file="/commonInc/include/commonImport.jsp" %>
<!-- [e] commonImport -->

<%
    //request 데이터
	DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
	requestMap.setNullToInitialize(true);       

	//String qu = requestMap.getString("qu");
	
    //수료이력 리스트
	DataMap rowMap = (DataMap)request.getAttribute("ROW_DATA");
	rowMap.setNullToInitialize(true); 
	
	//분류코드 (입력/수정 분기)
	String codeStr = "";
	if("insert".equals(requestMap.getString("qu")))
			codeStr = "* 코드는 자동으로 입력 됩니다.";
	else	codeStr = requestMap.getString("divCode");	
	
	//입력/수정 버튼
	String buttonStr = "";
	if("insert".equals(requestMap.getString("qu")))
		buttonStr = "<input type='button' value='입력' onclick='go_add();' class='boardbtn1'>";
	else
		buttonStr = "<input type='button' value='수정' onclick='go_modify();' class='boardbtn1'>";	
	
%>


						
<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->

<script language="JavaScript">
<!--

//입력 실행
function go_add()	{

	$("mode").value = "divExec";
	$("qu").value   = "insert";

	pform.action = "/movieMgr/movie.do";
	pform.submit();

}

//수정 실행
function go_modify()	{

	$("mode").value = "divExec";
	$("qu").value   = "update";

	pform.action = "/movieMgr/movie.do";
	pform.submit();

}


//-->
</script>


<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<form id="pform" name="pform" method="post">
<input type="hidden" name="menuId"				value="<%=requestMap.getString("menuId")%>">
<input type="hidden" name="mode"				value="<%=requestMap.getString("mode")%>">
<input type="hidden" name="qu"					value='<%=requestMap.getString("qu")%>'>

<input type="hidden" name="divCode"				value='<%=requestMap.getString("divCode")%>'>


<table class="pop01">
	<tr>
		<td class="titarea">
			<!-- 타이틀영역 -->
			<div class="tit">
				<h1 class="h1"><img src="/images/bullet_pop.gif" />동영상강의 분류 입력/수정 </h1>
			</div>
			<!--// 타이틀영역 -->
		</td>
	</tr>
	<tr>
		<td class="con">
			<!-- date -->
			<table  class="dataw01">
				
				<tr>
					<th width="20%">분류코드</th>
					<td><%= codeStr %></td>
				</tr>
				<tr>
					<th>분류명</th>
					<td>
						<input type="text" class="textfield" name="divName" value="<%= rowMap.getString("divName") %>" style="width:150" />&nbsp;
					</td>
				</tr>
			</table>
			<!-- //date -->

			<!-- 하단 닫기 버튼  -->
			<table class="btn02">
				<tr>
					<td class="center">
						<%= buttonStr %>
						<input type="button" value="닫기" onclick="javascript:window.close();" class="boardbtn1">
					</td>
				</tr>
			</table>
			<!--// 하단 닫기 버튼  -->
		</td>
	</tr>
</table>

</form>
</body>
