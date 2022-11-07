<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 회원조회 팝업
// date : 2008-06-04
// auth : 정 윤철
%>

<!-- [s] commonImport -->
<%@ include file="/commonInc/include/commonImport.jsp" %>
<!-- [e] commonImport -->

<%
	
    //request 데이터
	DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
	requestMap.setNullToInitialize(true);

	//메인코드 리스트
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	listMap.setNullToInitialize(true);
	
	StringBuffer html = new StringBuffer();
	
	if(listMap.keySize("userno") > 0){
		for(int i=0;listMap.keySize("userno") > i; i++){
			html.append("<tr align = center>");
			html.append("	<td bgcolor = #FFFFFF class=\"tableline11\" height=\"28\">"+(listMap.getString("resno", i).equals("") ? "&nbsp;" : listMap.getString("resno", i))  +"</td>");
			html.append("	<td bgcolor = #FFFFFF class=\"tableline11\" height=\"28\"><a href = \"javascript:\" onClick = \"actOpener('"+listMap.getString("name", i)+"','"+listMap.getString("resno", i)+"','"+listMap.getString("userno", i)+"');\">"+(listMap.getString("name",i).equals("") ? "&nbsp;" : listMap.getString("name",i))+"</a></td>");
			html.append("	<td bgcolor = #FFFFFF class=\"tableline11\" align=\"left\" style=\"padding-left:10px\" height=\"28\">"+(listMap.getString("deptnm", i).equals("") ? "&nbsp;" : listMap.getString("deptnm", i)) +"</td>");
			html.append("	<td bgcolor = #FFFFFF class=\"tableline11\" align=\"left\" style=\"padding-left:10px\" height=\"28\">"+(listMap.getString("deptsub", i).equals("") ? "&nbsp" : listMap.getString("deptsub", i))+"</td>");
			html.append("	<td bgcolor = #FFFFFF class=\"tableline21\" align=\"left\" style=\"padding-left:10px\" height=\"28\">"+(listMap.getString("mjiknm", i).equals("") ? "&nbsp" : listMap.getString("mjiknm", i)) +"</td>");
			html.append("</tr> ");
		}
	}else{
		html.append("<tr><td colspan=\"100%\" height=\"100\" align=\"center\" bgcolor=\"#FFFFFF\"> 데이터가 없습니다.</td></tr> ");
	}

	
%>
<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->
<SCRIPT LANGUAGE="JavaScript">
<!--
function go_search(){
	
	if(IsValidCharSearch($("keyword").value) == false){

		return false;
	}
	pform.action = "/member/member.do";
	$("mode").value="memberSearchList";
	$("qu").value="search";
	pform.submit();
}


function actOpener(name,resno,userno){
	opener.$("name").value = name;
	opener.$("resno").value = resno;
	opener.$("userno").value = userno;
	self.close();
}

//-->
</SCRIPT>

		
	<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
		<form name="pform" action="" method="post">
		<input type="hidden" name="qu" value="">
		<input type="hidden" name="mode" value="">
		<input type="hidden" name="menuId" value="<%=requestMap.getString("menuId") %>">
			
	    <table cellspacing="0" cellpadding="0" border="0" width="100%" height="100%">
	        <tr><td height="4" bgcolor="#0081C4" nowrap></td></tr>
	        <tr>
	            <td height="45" bgcolor="#FFFFFF" style="padding-left:10px" nowrap>
	                <!-- [s]타이틀영역-->
	                <table cellspacing="0" cellpadding="0" border="0">
	                    <tr>
	                    	<td width="15" align="left"><img src="/images/bullet_pop.gif" width="10" height="22" border="0"></td>
							<td><font color="#000000" style="font-weight:bold; font-size:13px">회원검색</font></td>
	                    </tr>
	                </table>
	                <!-- [e]타이틀영역-->
	            </td>
	        </tr>
	        <tr>
	            <td height="100%" class="popupContents " valign="top">
	                <!-- [s]본문영역-->
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr bgcolor="#375694">
							<td height="2" colspan="100%"></td>
						</tr>
						<tr>
							<td class="tableline21" bgcolor="#F7F7F7" colspan="100%" align="center"><input type = radio name ="type" value ='name' checked>이름으로 검색  <input type = "radio" name="type" value='resno' >생년월일로 검색 </td>
						</tr>
						<tr class="tableline11" bgcolor="#F7F7F7" align="center">
							<td colspan="100%">
								<input type = "text" name ="keyword" value="<%=requestMap.getString("keyword") %>" onkeypress="if(event.keyCode==13){go_search();return false;}" size = 20 maxlength=15>
								<input type="button" onclick="go_search();" value = "검색" class="boardbtn1">
							</td>
						</tr>
						
						<tr bgcolor="#375694">
							<td height="2" colspan="100%"></td>
						</tr>
						<%if(requestMap.getString("qu").equals("search")){ %>
						<tr>
							<td colspan =100% bgcolor = #FFFFFF colspan="100%">
									<table width="100%" border="0" cellpadding="0" cellspacing="0" style = "margin-top:10" align = center>
									<tr bgcolor="#375694">
										<td height="2" colspan = 5></td>
									</tr>
									<tr>
										<td height="28" width="100"class="tableline11" bgcolor="#F7F7F7" align="center"><strong>생년월일</strong></td>
										<td height="28" width="60" class="tableline11" bgcolor="#F7F7F7" align="center"><strong>성명</strong></td>
										<td height="28" width="100"class="tableline11" bgcolor="#F7F7F7" align="center"><strong>기관</strong></td>
										<td height="28" width="140"class="tableline11" bgcolor="#F7F7F7" align="center"><strong>부서</strong></td>
										<td height="28" width="100"class="tableline21" bgcolor="#F7F7F7" align="center"><strong>직급</strong></td>
									</tr>
									<!--회원리스트-->
									<%=html.toString() %>
									<!--회원리스트끝-->
									<tr bgcolor="#375694">
										<td height="2" colspan = 5></td>
									</tr>
									<tr><td height="50"></td></tr>
									<tr>
										<td align = center colspan="100%" width="100%"><input type = button class="boardbtn1" value = "닫기" onClick = "self.close();"></td>
									</tr>		
									</table>
									<table>
								<tr>
							<td height="2"></td>
						</tr>
						
					</table>
				</td>
			</tr>
		<%} %>
		</table>
		<!-- [e]본문영역-->
		<!-- space --><tr><td colspan="3" height="10"></td></tr>
											
	</table>
</body>

