<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 동영상 강의 학습 입력/수정 화면 (팝업)
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

%>


						
<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->

<script language="JavaScript">
<!--

//입력 실행
function go_add()	{

	$("mode").value = "movExec";

	pform.action = "/baseCodeMgr/subj.do";
	pform.submit();

}

//-->
</script>


<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<form id="pform" name="pform" method="post">
<input type="hidden" name="menuId"				value="<%=requestMap.getString("menuId")%>">
<input type="hidden" name="mode"				value="<%=requestMap.getString("mode")%>">
<input type="hidden" name="subj"				value='<%=requestMap.getString("subj")%>'>

<table class="pop01">
	<tr>
		<td class="titarea">
			<!-- 타이틀영역 -->
			<div class="tit">
				<h1 class="h1"><img src="/images/bullet_pop.gif" />동영상강의 학습 입력/수정</h1>
			</div>
			<!--// 타이틀영역 -->
		</td>
	</tr>
	<tr>
		<td class="con">
			<!-- date -->
			<table  class="dataw01">
				<tr>
					<th width="70px">학습명</th>
					<td>
						<input type="text" class="textfield" name="contName" value="" style="width:250" />&nbsp;
					</td>
				</tr>
				<tr>
					<th>학습 URL</th>
					<td>
						<input type="text" class="textfield" name="movUrl" value="" style="width:250" />&nbsp;
					</td>
				</tr>
				<tr>
					<th>학습시간</th>
					<td>
						<input type="text" class="textfield" name="movTime" value="0" style="width:50" maxlength="2" />시간&nbsp;
						<input type="text" class="textfield" name="movMin" value="0" style="width:50" maxlength="2" />분&nbsp;
					</td>
				</tr>
				<tr>
					<th>내용요약</th>
					<td>
						<textarea name="contSummary" class="textfield" style="width:100%;height:380px" class="box" required="true!해설이 없습니다." maxchar="900!글자수가 많습니다." /></textarea>
					</td>
				</tr>
			</table>
			<!-- //date -->

			<!-- 하단 닫기 버튼  -->
			<table class="btn02">
				<tr>
					<td class="center">
						<input type="button" value="등록하기" onclick="go_add();" class="boardbtn1">
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
