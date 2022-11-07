<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%  
// prgnm : 파일 다운로드 팝업
// date : 2008-06-05
// auth : Lym
%>

<!-- [s] commonImport -->
<%@ include file="/commonInc/include/commonImport.jsp" %>
<!-- [e] commonImport -->

<%
	
	DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
	requestMap.setNullToInitialize(true);
	
	//파일 리스트.
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	listMap.setNullToInitialize(true);
	
	String fileStr = "";
	String tmpStr = "";

	for(int i=0; i < listMap.keySize("groupfileNo"); i++){
		if(!fileStr.equals(""))
			fileStr += "<br>";
		// number 포멧이 스트링 값으로 DataMap 에 저장됨 .. 에러발생...
		tmpStr = "javascript:fileDownload("+ listMap.getString("groupfileNo", i) + ", "+ listMap.getString("fileNo", i) +");";
		fileStr += "<a href=\"" + tmpStr + "\"><b>"+listMap.getString("fileName", i)+"</b></a>";
	}

%>

<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->

<body leftmargin="0" topmargin=0>

<form name="pform">

<table cellspacing="0" cellpadding="0" border="0" width="100%" height="200">
	<tr><td height="4" bgcolor="#0081C4" nowrap></td></tr>
	<tr>
		<td height="45" bgcolor="#FFFFFF" style="padding-left:10px" nowrap>

			<!-- 타이틀영역 -->
			<table cellspacing="0" cellpadding="0" border="0">
				<tr>
					<td width="15" align="left"><img src="/images/bullet_pop.gif" width="10" height="22" border="0"></td>
					<td><font color="#000000" style="font-weight:bold; font-size:13px">파일 다운로드</font></td>
				</tr>
			</table>
			<!--// 타이틀영역 -->
		</td>
	</tr>
	<tr>
		<td height="100%" style="background:#FFFFFF URL(/images/bg_pop.gif) repeat-x; padding:20px; line-height:18px" valign="top">
			
			<!--// 본문영역 -->
			<!-- space --><table width="100%" height="10"><tr><td></td></tr></table>

			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<!-- line --><tr bgcolor="#375694"><td height="2" colspan="100%"></td></tr>

				<tr bgcolor="#5071B4">
					<td width="50" height="100" align="center" class="tableline11 white"><strong>목록</strong></td>
					<td bgcolor="FFFFFF" style="padding : 10 0 10 5">
					<div class="saisin" style="margin: 0px 1px 15px; padding: 1px 8px; border: 1px solid rgb(204, 204, 204); border-image: none; height: 120px; text-align: left; color: rgb(0, 51, 0); line-height: 25px; font-size: 18px; overflow: auto; -ms-overflow-y: auto;">
						<%= fileStr %>
					</div>
						
					</td>
				</tr>

				<!-- line --><tr bgcolor="#375694"><td height="2" colspan="100%"></td></tr>
			</table>
			
			<!--// 본문영역 -->

		</td>
	</tr>
	<tr>
		<td height="50" align="center" nowrap><a href="#" onclick="window.close()"><!-- 닫기 --><img src="/images/btn_popclose.gif" width="54" height="28" border="0"></a></td>
	</tr>
</table>


</form>

</body>
