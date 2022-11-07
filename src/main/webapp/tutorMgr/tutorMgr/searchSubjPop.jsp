<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 과목검색 팝업
// date  : 2008-06-23
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
	
	
	// 검색결과
	StringBuffer sbListHtml = new StringBuffer();
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	if(listMap == null) listMap = new DataMap();
	listMap.setNullToInitialize(true);
	
	String param = "";
	
	if(listMap.keySize("subj") > 0){		
		for(int i=0; i < listMap.keySize("subj"); i++){
			
			param = "javascript:fnRetValue('" + listMap.getString("subj", i) + "');";
			
			sbListHtml.append("<tr style=\"height:25px\">");
			
			sbListHtml.append("	<td align=\"center\" >" + listMap.getString("subj", i) + "</td>");
			sbListHtml.append("	<td align=\"center\" ><a href=\"" + param + "\">" + listMap.getString("subjnm", i) + "</a></td>");
			
			sbListHtml.append("</tr>");
		}
	}else{
		sbListHtml.append("<tr>");
		sbListHtml.append("	<td align=\"center\" style=\"height:200px\" colspan=\"4\">검색결과가 없습니다.</td>");
		sbListHtml.append("</tr>");
	}
	
	
%>

<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->

<script language="JavaScript" type="text/JavaScript">
<!--

function fnSearch(){

	if(NChecker($("sform"))){
	
		sform.action = "tutor.do";
		sform.submit();
	}
}

function fnCancel(){
	self.close();
}

function fnRetValue(subj){
	opener.pform.<%=requestMap.getString("obj")%>.value = subj;
	fnCancel();
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
<input type="hidden" name="mode" id="mode" value="<%=requestMap.getString("mode")%>">

<input type="hidden" name="obj" id="obj" value="<%=requestMap.getString("obj")%>">

<table cellspacing="0" cellpadding="0" border="0" width="100%" height="100%">
	<tr><td height="4" bgcolor="#0081C4" nowrap></td></tr>
	<tr>
		<td height="45" bgcolor="#FFFFFF" style="padding-left:10px" nowrap>
			<!--[s] 타이틀 영역-->
			<table cellspacing="0" cellpadding="0" border="0">
				<tr>
					<td width="15" align="left"><img src="/images/bullet_pop.gif" width="10" height="22" border="0"></td>
					<td><font color="#000000" style="font-weight:bold; font-size:13px">과목 검색</font></td>
				</tr>
			</table>
			<!--[e] 타이틀 영역-->
		</td>
	</tr>
	<tr>
		<td height="100%" class="popupContents" valign="top" bgcolor="#E4E3E4">
		
			<!--[s] contents  -->
			<table class="tab01">				
				<tr>
					<td align="center">
						과목명 : 
						<input type="text" name="searchTxt" id="searchTxt" required="true!검색어가 없습니다." value="<%=requestMap.getString("searchTxt") %>" onKeyPress="if(event.keyCode == 13) { fnSearch(); return false;}">
						<input type="button" value="검색" class="boardbtn1" onclick="fnSearch();">
					</td>
				</tr>
			</table>
			
			<br>
			<div id="divTable">
				<table class="datah01">
					<thead>
					<tr>
						<th>과목코드</th>
						<th>과목명</th>
					</tr>
					</thead>
					<tbody>
					
					<%= sbListHtml.toString() %>
					
					</tbody>              
				</table>
			</div>
			
			<!--[e] contents -->
			
		</td>
	</tr>
	<tr>
		<td height="50" align="center" nowrap>			
			<input type="button" name="btnCancel" value="닫 기" onclick="fnCancel();" class="boardbtn1">
		</td>
	</tr>
</table>


</form>
</body>