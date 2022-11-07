<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%  
// prgnm : 기초코드관리 과정분류코드관리 등록, 수정폼
%>

<!-- [s] commonImport -->
<%@ include file="/commonInc/include/commonImport.jsp" %>
<!-- [e] commonImport -->

<%
    //request 데이터
	DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
	requestMap.setNullToInitialize(true);       

	//popContent 단일데이터 
	DataMap rowMap = (DataMap)request.getAttribute("ROW_DATA");
	rowMap.setNullToInitialize(true);
	
	String useYn = "Y";
	
	if(rowMap.keySize("cdGubun") > 0){
		useYn = Util.getValue( rowMap.getString("useYn"),"Y");
		
	}
	
	String tu = requestMap.getString("tu");		
%>
						
<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->
<SCRIPT LANGUAGE="JavaScript">

	function go_add(){

		if( $F("mcodeName") == ""){
			alert("분류명을 입력하여 주십시오.");
			return;
		}else if( confirm('등록 하시겠습니까?')){
			$("mode").value = "majorExec";
			pform.submit();
		}
	}

	function go_modify(){
		if( confirm('수정 하시겠습니까?')){ // 등록일때
			$("mode").value = "majorExec";
			pform.submit();
		}

	}

//-->
</SCRIPT>



<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<form name="pform" action="/baseCodeMgr/mainCode.do" method="post">
<input type="hidden" name="cdGubun" 	value="<%=rowMap.getString("cdGubun") %>">
<input type="hidden" name="majorCode" 	value="<%=rowMap.getString("majorCode")%>">
<input type="hidden" name="tu"		 	value="<%=requestMap.getString("tu")%>">
<input type="hidden" name="mode" 		value="">
<input type="hidden" name="menuId" 		value="<%=requestMap.getString("menuId") %>">
<table cellspacing="0" cellpadding="0" border="0" width="100%" height="100%">
	<tr><td height="4" bgcolor="#0081C4" nowrap></td></tr>
	<tr>
		<td height="45" bgcolor="#FFFFFF" style="padding-left:10px" nowrap>
			<!-- 타이틀영역-->
			<table cellspacing="0" cellpadding="0" border="0">
				<tr>
					<td width="15" align="left"><img src="/images/bullet_pop.gif" width="10" height="22" border="0"></td>
					<td><font color="#000000" style="font-weight:bold; font-size:13px">과정분류 코드 <%=tu.equals("insert")?"등록":"수정"%></font></td>
				</tr>
			</table>
			<!-- /타이틀영역-->
		</td>
	</tr>
	<tr>
		<td height="100%" class="popupContents " valign="top">
			<!-- 본문영역-->
			<table cellspacing="0" cellpadding="0" border="0" width="100%" class="datah01">
				<tr>
					<td class="" height="28" class="tableline11" bgcolor="#E4EDFF"><strong>과정 분류명</strong></td>
					<td class="br0" style="text-align:left;padding-left:10px"><input type="text" class="textfield" maxlength="30" onkeypress="if(event.keyCode==13){go_add();return false;}" name="mcodeName" value="<%=rowMap.getString("mcodeName")%>" <%=tu.equals("insert") ? "" : "readonly"%>></td>
				</tr>
				<tr>
					<td bgcolor="#E4EDFF"><strong>사용여부</strong></td>
					<td class="br0" style="text-align:left;padding-left:10px">
						<input type="radio" name="useYn" id='use_y' value='Y' <%= useYn.equals("Y")? "checked":""   %> >&nbsp;<label for='use_y'>YES</label>&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="radio" name="useYn" value='N' id='use_n' <%= useYn.equals("Y")? "":"checked"   %> >&nbsp;<label for='use_n'>NO</label>
					</td>
				</tr>
			</table>
			<!-- space --><div class="space01"></div>		
			<table cellspacing="0" cellpadding="0" border="0" width="100%" height="">
				<tr>
					<td align='center'>

					<%if( requestMap.getString("tu").equals("insert") ){%>
						<input type="button" value='저장' onclick="go_add()" class="boardbtn1">&nbsp;&nbsp;
					<%}else if(requestMap.getString("tu").equals("update")){%>
						<input type="button" value='수정' onclick="go_modify()" class="boardbtn1">&nbsp;&nbsp;
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
</body>
