<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 설문 미응시자
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

    //발송자 리스트
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	listMap.setNullToInitialize(true); 

	//list
	String listStr = "";
	for(int i=0; i < listMap.keySize("userId"); i++){

		listStr += "\n<tr>";

		//아이디
		listStr += "\n	<td>" + listMap.getString("userId", i) + "</td>";

		//이름
		listStr += "\n	<td>" + listMap.getString("name", i) + "</td>";

		//이메일
		listStr += "\n	<td>" + listMap.getString("email", i) + "</td>";

		//휴대폰
		listStr += "\n	<td>" + listMap.getString("hp", i) + "</td>";

		//집전화
		listStr += "\n	<td>" + listMap.getString("homeTel", i) + "</td>";

		//사무실전화
		listStr += "\n	<td class='br0'>" + listMap.getString("officeTel", i) + "</td>";

		listStr += "\n</tr>";
	}


%>

						
<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->
<script language="JavaScript">
<!--



onload = function()	{


}

//-->
</script>
<script language="javascript" src="/courseMgr/mail/sms.js"></script>

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<form id="pform" name="pform" method="post">
<input type="hidden" name="menuId"				value="<%=requestMap.getString("menuId")%>">
<input type="hidden" name="mode"				value="<%=requestMap.getString("mode")%>">

<input type="hidden" name="qu"					value='<%=requestMap.getString("qu")%>'>

<input type="hidden" name="grcode"				value='<%=requestMap.getString("grcode")%>'>
<input type="hidden" name="grseq"				value='<%=requestMap.getString("grseq")%>'>

<table class="pop01">
	<tr>
		<td class="titarea">
			<!-- 타이틀영역 -->
			<div class="tit">
				<h1 class="h1"><img src="/images/bullet_pop.gif" /> 설문 미응시자</h1>
			</div>
			<!--// 타이틀영역 -->
		</td>
	</tr>
	<tr>
		<td class="con">

			<!-- 리스트  -->
			<table class="datah01">
				<thead>
				<tr>
					<th>아이디</th>
					<th>이름</th>
					<th>이메일</th>
					<th>휴대폰</th>
					<th>집전화</th>
					<th class="br0">사무실전화</th>
				</tr>
				</thead>

				<tbody>
					<%= listStr %>
				</tbody>
			</table>
			<!-- //리스트  -->

			<!-- 닫기 버튼  -->
			<table class="btn02">
				<tr>
					<td class="center">
						<input type="button" value="닫기" onclick="window.close();" class="boardbtn1">
					</td>
				</tr>
			</table>
			<!--// 닫기 버튼  -->
			<div class="h10"></div>


		</td>
	</tr>
</table>

</form>

</body>