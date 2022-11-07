<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%  
// prgnm : 외래강사 수당관리 출제료 팝업
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
		$("qu").value = "exam";
		$("subMode").value = "insert";
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
<input type="hidden" name="subMode">
<input type="hidden" name="no">


<table class="pop01">
	<tr>
		<td class="titarea">
			<!-- 타이틀영역 -->
			<div class="tit">
				<h1 class="h1"><img src="../images/bullet_pop.gif" /> 출제료 수당관리</h1>
			</div>
			<!--// 타이틀영역 -->
		</td>
	</tr>
	<tr>
		<td class="con">

			<!-- 리스트  -->
			<table class="datah01">
				<tr>
					<th>
						출제료 
						<input type="text" class="textfield" name="amt"  maxlength="5" value="<%=rowMap.getString("amt")%>" style="width:50px;" />
						문제
					</th>
					<td class="br0">
						주관식 
						<input type="text" class="textfield" name="startCnt" maxlength="5" style="width:50px;" value="<%=rowMap.getString("startCnt") %>" /> 원<br />
						객관식 
						<input type="text" class="textfield" name="endCnt" maxlength="5" style="width:50px;" value="<%=rowMap.getString("endCnt") %>"/> 원
					</td>
				</tr>
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
