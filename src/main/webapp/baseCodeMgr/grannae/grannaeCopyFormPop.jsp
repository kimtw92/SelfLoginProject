<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%  
// prgnm : 시스템관리자 > 과정/콘텐츠관리 > 기초코드관리 > 교육계획 복사 팝업.
%>

<!-- [s] commonImport -->
<%@ include file="/commonInc/include/commonImport.jsp" %>
<!-- [e] commonImport -->

<%
    //request 데이터
	DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
	requestMap.setNullToInitialize(true);       

	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	listMap.setNullToInitialize(true);  

	String yearStr = "";
	for(int i=0; i < listMap.keySize("grcode"); i++){
		yearStr += "<option value='" + listMap.getString("year", i) + "'> " + listMap.getString("year", i) + "</option>";
	}
%>					
						
<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->
<script language="JavaScript">
<!--

//년도에 속한 모든 과정 복사.
function go_addAll(){

	$("mode").value = "copy_exec";

	if( confirm('일괄 복사하시겠습니까?')){ // 등록일때

		pform.action = "/baseCodeMgr/grannae.do";
		pform.submit();
	}

}

//한과정 복사
function go_addOne(){

	$("mode").value = "copy_exec";

	if( confirm('복사 하시겠습니까?')){ // 등록일때

		pform.action = "/baseCodeMgr/grannae.do";
		pform.submit();
	}

}

//-->
</script>


<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<form id="pform" name="pform" method="post">
<input type="hidden" name="menuId"				value="<%=requestMap.getString("menuId")%>">
<input type="hidden" name="mode"				value="<%=requestMap.getString("mode")%>">

<input type="hidden" name="qu"					value='<%=requestMap.getString("qu")%>'>
<input type="hidden" name="grcode"				value='<%=requestMap.getString("grcode")%>'>
<input type="hidden" name="year"				value='<%=requestMap.getString("year")%>'>

<table cellspacing="0" cellpadding="0" border="0" width="100%" height="100%">
	<tr><td height="4" bgcolor="#0081C4" nowrap></td></tr>
	<tr>
		<td height="45" bgcolor="#FFFFFF" style="padding-left:10px" nowrap>
			<!-- 타이틀영역-->
			<table cellspacing="0" cellpadding="0" border="0">
				<tr>
					<td width="15" align="left"><img src="/images/bullet_pop.gif" width="10" height="22" border="0"></td>
					<td><font color="#000000" style="font-weight:bold; font-size:13px">교육계획 복사</font></td>
				</tr>
			</table>
			<!-- /타이틀영역-->
		</td>
	</tr>
	<tr>
		<td height="100%" valign="top">
			<!-- 본문영역-->

			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr bgcolor="#375694">
					<td height="2" colspan="100%"></td>
				</tr>
				<tr height='28' bgcolor="#5071B4">
					<td width="50%" align='center' class="tableline11 white">
						<strong>복사할 년도</strong>
					</td>
					<td width="50%" align='center' class='tableline21' bgColor='#FFFFFF'>
						<select name="copyYear">

						<%if(requestMap.getString("qu").equals("ALL")){%>
							<script language='javascript'>
							<!--
								var paramYear = <%=requestMap.getString("year")%>;
								for(var i=new Date().getYear(); i>= 1985; i--)
									if(paramYear != i)
										document.write("<option value='" + i + "'> " + i + "</option>");
							//-->
							</script>
						<%}else if(requestMap.getString("qu").equals("ONE")){%>
								<%= yearStr %>
						<%}%>
							
						</select>
					</td>
				</tr>
			</table>

			<!-- space --><table width="100%" height="20"><tr><td></td></tr></table>
			<table width="100%" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td width="100%" align="center">
						<%if(requestMap.getString("qu").equals("ALL")){%>
							<input type="button" class="boardbtn1" value='일괄복사' onClick="go_addAll();">
						<%}else if( listMap.keySize("grcode") > 0 && requestMap.getString("qu").equals("ONE")){%>
							<input type="button" class="boardbtn1" value='복사' onClick="go_addOne();" >
						<%}%>
						<input type="button" value='닫기' onClick="self.close();" class="boardbtn1">
					</td>
				</tr>
			</table>

			<!-- /본문영역-->
		</td>
	</tr>
</table>

</form>
<SCRIPT LANGUAGE="JavaScript">
<!--
	<%if( requestMap.getString("qu").equals("ONE") && listMap.keySize("grcode") == 0 ){%>
	alert("이전 등록된 교육계획이 없습니다.");
	window.close();
	<%}%>
//-->
</SCRIPT>
</body>
