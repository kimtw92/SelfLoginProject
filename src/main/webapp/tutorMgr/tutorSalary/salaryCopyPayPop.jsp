<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%  
// prgnm : 외래강사 수당관리 원고료 팝업
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
		$("qu").value = "copyPay";
		$("subMode").value = "insert";
		pform.action = "/tutorMgr/salary.do";
		pform.submit();
	}
}

function go_delete(no){
	$("no").value = no;
	$("mode").value = "salaryPopExec";
	$("qu").value = "copyPay";
	$("subMode").value = "delete";
	pform.action = "/tutorMgr/salary.do";
	pform.submit();
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
				<h1 class="h1"><img src="../images/bullet_pop.gif" /> 원고료수당관리</h1>
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
					<th>장수</th>
					<th>지급금액</th>
					<th class="br0">기능</th>
				</tr>
				</thead>

				<tbody>
				<%if(rowMap.keySize("etcWanno") > 0){ %>
					<%for(int i=0; i < rowMap.keySize("etcWanno"); i++){ %>
					<tr>
						<td><%=rowMap.getString("startCnt",i) %> ~ <%=rowMap.getString("endCnt",i) %></td>
						<td>
							<%=rowMap.getString("amt", i) %>
						</td>
						<td class="br0">
							<a href="javascript:go_delete('<%=rowMap.getString("etcWanno", i) %>')">삭제</a>
						</td>
					</tr>
					<%}//end for
				}//end if %>
				</tbody>
				
				<tr>
					<td bgcolor="#FFFFFF" align = center class="br0" colspan="100%">
						<input class="textfield" type = text size = 3 maxlength = 5 name = "startCnt"> 장 ~ 
						<input class="textfield" type = text size = 3 maxlength = 5 name = "endCnt"> 장
						금액<input class="textfield" type = text size = 8 maxlength = 10 name = "amt">원
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
