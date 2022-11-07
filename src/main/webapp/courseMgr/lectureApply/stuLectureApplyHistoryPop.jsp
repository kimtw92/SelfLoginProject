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

	//로그인된 사용자 정보.
	LoginInfo memberInfo = (LoginInfo)request.getAttribute("LOGIN_INFO");

    //수료이력 리스트
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	listMap.setNullToInitialize(true); 

	//유저 정보.
	DataMap userRowMap = (DataMap)request.getAttribute("USER_ROW_DATA");
	userRowMap.setNullToInitialize(true); 

	String listStr = "";
	//String tmpStr = "";
	for(int i=0; i < listMap.keySize("userno"); i++){

		listStr += "\n<tr>";

		listStr += "\n	<td>" + listMap.getString("grcodeniknm", i) + "&nbsp;</td>";
		listStr += "\n	<td>" + listMap.getString("grseqstr", i) + "&nbsp;</td>";
		listStr += "\n	<td>" + listMap.getString("started", i) + "~" + listMap.getString("enddate", i) + "&nbsp;</td>";
		listStr += "\n	<td>" + listMap.getString("tdate", i) + "&nbsp;</td>";
		listStr += "\n	<td>" + listMap.getString("deptnm", i) + "&nbsp;</td>";
		listStr += "\n	<td>" + listMap.getString("jiknm", i) + "&nbsp;</td>";

		if( !memberInfo.getSessClass().equals("3") )
			listStr += "\n	<td>" + listMap.getString("paccept", i) + "&nbsp;</td>";

		listStr += "\n	<td>" + listMap.getString("rgrayn", i) + "&nbsp;</td>";
		listStr += "\n	<td class=\"br0\">" + listMap.getString("rno", i) + "&nbsp;</td>";

		listStr += "</tr>";

	}

	if( listMap.keySize("userno") <= 0){

		listStr += "<tr>";
		listStr += "	<td colspan='100%' class=\"br0\" style=\"height:100px\">수료 이력정보가 없습니다.</td>";
		listStr += "</tr>";

	}

%>
						
<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->

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
				<h1 class="h1"><img src="/images/bullet_pop.gif" /> 수강생 개인별 수료기록</h1>
			</div>
			<!--// 타이틀영역 -->			
		</td>
	</tr>
	<tr>
		<td class="con">
			<div class="tit0101">
				<strong class="txt00"><%= userRowMap.getString("name") %></strong>님의 수료기록입니다. 
			</div>
			<div class="h5"></div>

			<!-- 리스트  -->
			<table class="datah01">
				<thead>
				<tr>
					<th>과정</th>
					<th>기수</th>
					<th>교육기간</th>
					<th>총학습일</th>
					<th>기관명</th>
					<th>직급</th>
				<% if( !memberInfo.getSessClass().equals("3") ){ %>
					<th width="60">점수</th>
				<% } %>
					<th width="60">수료<br />구분</th>
					<th width="60" class="br0">수료<br />번호</th>
				</tr>
				</thead>

				<tbody>
				<%= listStr %>
				</tbody>
			</table>
			<!-- //리스트  -->
			
			<!-- 하단 닫기 버튼  -->
			<table class="btn02">
				<tr>
					<td class="center">
						<a href="#" onclick="window.close()"><!-- 닫기 --><img src="/images/btn_popclose.gif" alt="닫기" /></a>
					</td>
				</tr>
			</table>
			<!--// 하단 닫기 버튼  -->
		</td>
	</tr>
</table>

</form>
</body>
