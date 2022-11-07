<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 반 지정 저장 팝업
// date  : 2008-06-07
// auth  : kang
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
	
	
	// 과정명
	DataMap grCodeMap = (DataMap)request.getAttribute("GRCODENM");
	if(grCodeMap == null) grCodeMap = new DataMap();
	grCodeMap.setNullToInitialize(true);
	
	// 과목명
	DataMap subjMap = (DataMap)request.getAttribute("SUBJNM");
	if(subjMap == null) subjMap = new DataMap();
	subjMap.setNullToInitialize(true);
	
	// 수강인원
	DataMap stuLecMap = (DataMap)request.getAttribute("STULEC_COUNT_ROW");
	if(stuLecMap == null) stuLecMap = new DataMap();
	stuLecMap.setNullToInitialize(true);
	
	// 분반 리스트
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	if(listMap == null) listMap = new DataMap();
	listMap.setNullToInitialize(true);
	
	
	StringBuffer sbListHtml = new StringBuffer();
	
	if(listMap.keySize("classno") > 0){
		for(int i=0; i < listMap.keySize("classno"); i++){
			
			sbListHtml.append("<tr bgcolor=\"#FFFFFF\" height=\"25\">");
			sbListHtml.append("	<td align=\"center\" class=\"tableline11\">" + (i+1) + "</td>");
			sbListHtml.append("	<td align=\"left\" class=\"tableline21\" style=\"padding:0 0 0 9\"    >");
			sbListHtml.append("		<input type=\"text\" name=\"classnm" + i + "\" id=\"classnm" + i + "\" size=\"20\" value=\"" + listMap.getString("classnm", i) + "\" required=\"true!반명이 없습니다.\" maxchar=\"20!글자수가 많습니다.\" >");
			sbListHtml.append("	</td>");
			sbListHtml.append("</tr>");
		}
		
	}else{
		sbListHtml.append("<tr bgcolor=\"#FFFFFF\" height=\"100\">");
		sbListHtml.append("	<td align=\"center\" class=\"tableline21\" colspan=\"100%\">데이타가 없습니다.</td>");		
		sbListHtml.append("</tr>");	
	}
	
	
%>


<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->

<script language="JavaScript" type="text/JavaScript">
<!--

// 저장
function fnSave(){

	if(NChecker($("sform"))){
		if(confirm("선택하신 정보로 반을 편성하시겠습니까?")){
			$("mode").value = "insertSubjClass";
			sform.action = "class.do";
			sform.submit();
		}
	}
	
}

// 닫기
function fnCancel(){
	self.close();
}

//-->
</script>
<script for="window" event="onload">
<!--

//-->
</script>

<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<form id="sform" name="sform" method="post">

<input type="hidden" name="menuId" 	value="<%=requestMap.getString("menuId")%>">
<input type="hidden" name="mode" id="mode" value="">


<input type="hidden" name="classCnt" id="classCnt" value="<%= requestMap.getString("classCnt") %>">
<input type="hidden" name="commGrcode" id="commGrcode" value="<%= requestMap.getString("commGrcode") %>">
<input type="hidden" name="commGrseq" id="commGrseq" value="<%= requestMap.getString("commGrseq") %>">
<input type="hidden" name="commSubj" id="commSubj" value="<%= requestMap.getString("commSubj") %>">


<table cellspacing="0" cellpadding="0" border="0" width="100%" height="100%">
	<tr><td height="4" bgcolor="#0081C4" nowrap></td></tr>
	<tr>
		<td height="45" bgcolor="#FFFFFF" style="padding-left:10px" nowrap>
			<!--[s] 타이틀 영역-->
			<table cellspacing="0" cellpadding="0" border="0">
				<tr>
					<td width="15" align="left"><img src="/images/bullet_pop.gif" width="10" height="22" border="0"></td>
					<td><font color="#000000" style="font-weight:bold; font-size:13px">분반구성 관리</font></td>
				</tr>
			</table>
			<!--[e] 타이틀 영역-->
		</td>
	</tr>
	<tr>
		<td height="100%" class="popupContents" valign="top" bgcolor="#E4E3E4">
		
			<!--[s] contents  -->
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr bgcolor="#375694"><td height="2" colspan="100%"></td></tr>
				<tr height="28" bgcolor="F7F7F7" >
					<td width="80" align="center" class="tableline11"><strong>과정명</strong></td>
					<td align="left" class="tableline21" bgcolor="#FFFFFF" style="padding:0 0 0 9">
						<%= grCodeMap.getString("grcodenm") %>
					</td>
				</tr>
				<tr height="28" bgcolor="F7F7F7" >
					<td width="80" align="center" class="tableline11"><strong>과목명</strong></td>
					<td align="left" class="tableline21" bgcolor="#FFFFFF" style="padding:0 0 0 9">
						<%= subjMap.getString("subjnm") %>
					</td>
				</tr>

				<tr height="28" bgcolor="F7F7F7" >
					<td width="80" align="center" class="tableline11"><strong>수강인원</strong></td>
					<td align="left" class="tableline21" bgcolor="#FFFFFF" style="padding:0 0 0 9">
						<%= stuLecMap.getString("cnt") %>&nbsp;명
					</td>
				</tr>
				<tr bgcolor="#375694"><td height="2" colspan="100%"></td></tr>
			</table>
			
			<br>
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr bgcolor="#375694"><td height="2" colspan="100%"></td></tr>
				<tr height="28" bgcolor="#5071B4">
					<td width="20%" align="center" class="tableline11 white"><strong>번 호</strong></td>
					<td align="center" class="tableline21 white"><strong>반 명</strong></td>
				</tr>
				
				<%= sbListHtml.toString() %>
				
				<tr bgcolor="#375694"><td height="2" colspan="100%"></td></tr>
			</table>
			
			<!--[e] contents -->
		</td>
	</tr>
	<tr>
		<td height="50" align="center" nowrap>
			<input type="button" name="btnCancel" value="저 장" onclick="fnSave();" class="boardbtn1">
			&nbsp;&nbsp;
			<input type="button" name="btnCancel" value="닫 기" onclick="fnCancel();" class="boardbtn1">
		</td>
	</tr>
</table>


</form>
</body>
