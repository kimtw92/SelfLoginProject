<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%  
// prgnm : 평가담당자 > 과제물관리 > 미제출자관리
// date : 2008-09-09
// auth : 최형준
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
		
	//////////////////////////////////////////////////////////////////////////////////// 	
	DataMap insertList=(DataMap)request.getAttribute("insertList");
	insertList.setNullToInitialize(true);
	
	String listStr="";
	for(int i=0;i<insertList.keySize("name");i++){
		listStr+="<tr>";
		listStr+="<td>"+(i+1)+"</td>";
		listStr+="<td>"+insertList.getString("name",i)+"</td>";
		listStr+="<td>"+insertList.getString("hp",i)+"</td>";
		listStr+="<td>"+insertList.getString("msg",i)+"</td>";
		listStr+="</tr>";
	}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<!-- [s] commonHtmlTop include 필수 -->
<!-- include 됨. -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<title>인천광역시인재개발원에 오신 것을 환영합니다.</title>

<link href="../commonInc/css/master_style.css" rel="stylesheet" type="text/css">
<link href="../commonInc/css/style2.css" rel="stylesheet" type="text/css">
<link href="../commonInc/css/protoload.css" rel="stylesheet" type="text/css">

<script language="javascript" src="/commonInc/js/prototype-1.6.0.2.js"></script>
<script language="javascript" src="/commonInc/js/sms.js"></script>
<script language="javascript" src="/commonInc/js/commonJs.js"></script>
<script language="javascript" src="/commonInc/js/NChecker.js"></script>
<script language="javascript" src="/commonInc/js/category.js"></script>
<script language="javascript" src="/commonInc/js/protoload.js"></script>
<script language="javascript" src="/commonInc/inno/InnoDS.js"></script>

<script language="JavaScript">
<!--
	
//-->
</script>
</head>
<body>
<form name="pform" method="post" >
<table class="pop01">
	<tr>
		<td class="titarea">
			<!-- 타이틀영역 -->
			<div class="tit">
				<h1 class="h1"><img src="../images/bullet_pop.gif" /> 미제출자 대상 SMS 발송</h1>
			</div>
			<!--// 타이틀영역 -->			
		</td>
	</tr>
	<tr>
		<td class="con">
			<div class="h10"></div>

			<!-- 리스트  -->
			<table class="datah01">
				<thead>
				<tr>
					<th width="40">번호</th>
					<th width="70">이름</th>
					<th class="br0">핸드폰 번호</th>
					<th  class="br0">내용</th>
				</tr>
				</thead>
				<tbody>
				<%=listStr %>
				</tbody>
			</table>
			<!-- //리스트  -->
		</td>
	</tr>
	<tr>
		<td align="center">
			<input class="boardbtn1" type="button" value="리스트" onClick="history.back();">&nbsp;&nbsp;&nbsp;&nbsp;
			<input class="boardbtn1" type="button" value="닫 기" onClick="window.close();">
		</td>
	</tr>
</table>
</form>
</body>
</html>