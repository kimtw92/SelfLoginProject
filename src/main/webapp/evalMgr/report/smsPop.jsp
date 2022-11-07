<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%  
// prgnm : 평가담당자 > 과제물관리 > 미제출자관리
// date : 2008-09-01
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
	DataMap endDate=(DataMap)request.getAttribute("endDate");
	endDate.setNullToInitialize(true);
	DataMap stuList=(DataMap)request.getAttribute("stuList");
	stuList.setNullToInitialize(true);
	
	String listStr="";
	for(int i=0;i<stuList.keySize("userno");i++){
		listStr+="<tr>";
		listStr+="<td>"+(i+1)+"</td>";
		listStr+="<td><INPUT type='checkbox' CHECKED value='"+stuList.getString("userno",i)+"' name='h_resno[]'>"+stuList.getString("name",i)+"</td>";
		listStr+="<td>"+stuList.getString("hp",i)+"</td>";
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
<form name="pform" method="post" action="/evalMgr/report.do">

<input type="hidden" name="commGrcode" value="<%=requestMap.getString("commGrcode") %>">
<input type="hidden" name="commGrseq" value="<%=requestMap.getString("commGrseq") %>">
<input type="hidden" name="commSubj" value="<%=requestMap.getString("commSubj") %>">
<input type="hidden" name="classno" value="<%=requestMap.getString("classno") %>">
<input type="hidden" name="dates" value="<%=requestMap.getString("dates") %>">
<input type="hidden" name="mode" value="">
<input type="hidden" value="" name="msg">
<input type="hidden" value="0" name="total">

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
			<!-- sms  -->
			<div class="smsset01">
				<div class="iconset">
					<img src="../images/sms_icon01.gif" class="icon1" />
					<img src="../images/sms_icon02.gif" />
				</div>
				<textarea class="textarea_sms" name="txtMessage" onKeyUp="javascript:checkShrtMsgLen(this)"  onFocus="javascript:checkShrtMsgLen(this)">name님 (교육원) grname과정 <%=endDate.getString("submedDate") %>일까지 과제물 미제출시 수료가 되지 않습니다.
				</textarea>
				<div class="txt"><span class="txt_red" id="sp1">&nbsp;</span> / 80 Byte</div>
			</div>
			<!-- //sms  -->
			<div class="h5"></div>

			<!-- 상단 닫기 버튼  -->
			<table class="btn01">
				<tr>
					<td class="left vb">* 수신거부자 제외</td>
					<td class="right" style="padding-right:10px;">
						<input type="button" value="SMS 발송" onclick="javascript:submitForm();" class="boardbtn1">
						<input type="button" value="닫기" onclick="javascript:window.close();" class="boardbtn1">
					</td>
				</tr>
			</table>
			<!--// 상단 닫기 버튼  -->
			<div class="h10"></div>

			<!-- 리스트  -->
			<table class="datah01">
				<thead>
				<tr>
					<th width="60">번호</th>
					<th>
						<input type="checkbox" class="chk_01" id="all" value="Y" CHECKED onclick="javascript:allCheck();">
						이름
					</th>
					<th class="br0">핸드폰 번호</th>
				</tr>
				</thead>

				<tbody>
				<%=listStr %>
				</tbody>
			</table>
			<!-- //리스트  -->
		</td>
	</tr>
</table>
</form>
</body>
</html>