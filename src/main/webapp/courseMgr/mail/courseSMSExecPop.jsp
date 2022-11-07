<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : SMS 발송 실행
// date : 2008-07-18
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
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	listMap.setNullToInitialize(true); 


	//String tmpStr = "";

	//list
	String listStr = "";
	for(int i=0; i < listMap.keySize("userno"); i++){

		listStr += "\n<tr>";

		//번호
		listStr += "\n	<td>" + (i+1) + "</td>";

		//이름
		listStr += "\n	<td>" + listMap.getString("name", i) + "</td>";
		
		//HP
		listStr += "\n	<td>" + listMap.getString("hp", i) + "</td>";

		//내용
		listStr += "\n	<td class='br0'>" + listMap.getString("msg", i) + "</td>";

		listStr += "\n</tr>";

	}


%>

						
<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->
<script language="JavaScript">
<!--

onload = function()	{

	var sendUserCnt = "<%= listMap.keySize("userno") %>";
	if(sendUserCnt > 0){
		alert("발송되었습니다.");
	}
}

//-->
</script>
<script language="javascript" src="/courseMgr/mail/sms.js"></script>

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<form id="pform" name="pform" method="post">
<input type="hidden" name="menuId"				value="<%=requestMap.getString("menuId")%>">
<input type="hidden" name="mode"				value="<%=requestMap.getString("mode")%>">

<input type="hidden" name="qu"					value='<%=requestMap.getString("qu")%>'>

<table class="pop01">
	<tr>
		<td class="titarea">
			<!-- 타이틀영역 -->
			<div class="tit">
				<h1 class="h1"><img src="/images/bullet_pop.gif" /> SMS 발송 결과</h1>
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
					<th width="60">번호</th>
					<th>
						이름
					</th>
					<th>핸드폰 번호</th>
					<th class="br0">내용</th>
				</tr>
				</thead>

				<tbody>
					<%= listStr %>
				</tbody>
			</table>
			<!-- //리스트  -->

			<div class="h10"></div>

			<!-- 상단 닫기 버튼  -->
			<table class="btn01">
				<tr>
					<td align="center">
						<input type="button" value="닫기" onclick="window.close();" class="boardbtn1">
					</td>
				</tr>
			</table>
			<!--// 상단 닫기 버튼  -->
			<div class="h10"></div>

		</td>
	</tr>
</table>

</form>

</body>
