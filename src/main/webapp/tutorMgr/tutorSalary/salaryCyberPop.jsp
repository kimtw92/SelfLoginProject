<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%  
// prgnm : 외래강사 수당관리 사이버 팝업
// date : 2008-07-21
// auth : 정 윤철
%>

<!-- [s] commonImport -->
<%@ include file="/commonInc/include/commonImport.jsp" %>
<!-- [e] commonImport -->

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
		
	//리스트 데이터
	DataMap rowMap = (DataMap)request.getAttribute("LIST_DATA");
	rowMap.setNullToInitialize(true);

	
	//기본값
	DataMap cyberRow = (DataMap)request.getAttribute("CYBERROW_DATA");
	cyberRow.setNullToInitialize(true);
	
	
%>
<html>
<head>
<title>인천광역시인재개발원에 오신 것을 환영합니다.</title>

<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->
</head>
<!-- [e] commonHtmlTop include -->

<script language="JavaScript">
<!--
function go_save(){
	if(NChecker($("pform"))){
		$("mode").value = "salaryPopExec";
		$("qu").value = "cyber";
		pform.action = "/tutorMgr/salary.do";
		pform.submit();
	}
}
//-->
</script>

<body>
<form name="pform">
<input type="hidden" name="mode">
<input type="hidden" name="qu">
<input type="hidden" name="menuId" value ="<%=requestMap.getString("menuId") %>" >
<input type="hidden" name="gubun" value="<%=requestMap.getString("gubun") %>">
<input type="hidden" name="salaryType" value="<%=requestMap.getString("salaryType") %>">
<input type="hidden" name="grcode" value="<%=requestMap.getString("grcode") %>">


<table class="pop01">
	<tr>
		<td class="titarea">
			<!-- 타이틀영역 -->
			<div class="tit">
				<h1 class="h1"><img src="../images/bullet_pop.gif" /> 사이버강사수당관리</h1>
			</div>
			<!--// 타이틀영역 -->
		</td>
	</tr>
	<tr>
		<td class="con">

			<!-- 리스트  -->
			<table class="datah01" border="0" cellspacing="0" cellpadding="0">
				<thead>
				<tr>
					<th>등급명</th>
					<th>기본수당</th>
					<th class="br0">초과수당</th>
				</tr>
				</thead>

				<tbody>
				<%for(int i=0; i < rowMap.keySize("gDefaultAmt"); i++){ %>
				<tr>
					<td><%=rowMap.getString("levelName",i) %></td>
					<td>
						<input type="text" class="textfield" maxlength="9" required="true!기본수당을 입력하십시오." dataform="num!숫자만 입력해야 합니다." name="cDefaultAmt" value="<%=rowMap.getString("cDefaultAmt", i) %>" style="width:60px;" />
						<input type="hidden" name="tlevel" maxlength="9" value="<%=rowMap.getString("tlevel",i) %>">
					</td>
					<td class="br0">
						<input type="text" class="textfield" maxlength="9" required="true!기본수당을 입력하십시오." dataform="num!숫자만 입력해야 합니다."  name="cOverAmt" value="<%=rowMap.getString("cOverAmt", i) %>" style="width:60px;" />
					</td>
				</tr>
				<%} %>
				</tbody>
			</table>
			
			<table width="100%" style="border-top:0px solid" class="datah01" border="0" cellspacing="0" cellpadding="0">
			<thead>
				<tr>
					<th rowspan="2">과제물출제수당</th>
					<th>기본 (1시간)</th>
					<td align="left" class="br0">
						<input type="text" class="textfield" maxLength="5" required="true!기본수당을 입력하십시오." dataform="num!숫자만 입력해야 합니다." name="startCnt" value="<%=cyberRow.getString("startCnt", 0) %>" style="width:80px;" />
					</td>
				</tr>
				<tr>
					<th>초과  (1시간)</th>
					<td align="left" class="br0">
						<input type="text" class="textfield" maxLength="5" required="true!기본수당을 입력하십시오." dataform="num!숫자만 입력해야 합니다." name="endCnt" value="<%=cyberRow.getString("endCnt", 0) %>" style="width:80px;" />
					</td>
				</tr>
				<tr>
					<th>질의응답수당</th>
					<td align="left" class="">
						<input type="text" class="textfield" maxLength="5" required="true!기본수당을 입력하십시오." dataform="num!숫자만 입력해야 합니다." name="questionCount" value="<%=cyberRow.getString("startCnt", 1) %>" style="width:80px;" /> 매
					</td>
					<td align="left" class="br0">
						<input type="text" class="textfield" maxLength="5" required="true!기본수당을 입력하십시오." dataform="num!숫자만 입력해야 합니다." name="amt" value="<%=cyberRow.getString("amt",1) %>" style="width:80px;" /> 원
					</td>
				</tr>
				</thead>
			</table>
			<!--//리스트  -->

			<!-- 하단 닫기 버튼  -->
			<table class="btn02">
				<tr>
					<td class="center">
						<input type="button" value="저장" onclick="go_save();" class="boardbtn1">
						<input type="button" value="닫기" onclick="self.close();" class="boardbtn1">
					</td>
				</tr>
			</table>
			<!--// 하단 닫기 버튼  -->
		</td>
	</tr>
</table>
</form>

</body>
