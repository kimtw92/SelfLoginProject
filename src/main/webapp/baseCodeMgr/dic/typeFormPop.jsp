<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 용어사전분류코드 등록, 수정 팝업
// date : 2008-05-27
// auth : kang
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
	
	

	String mode = requestMap.getString("mode");
	
	
	String strTitle = "";
	String btnTitle = "";
	String typeReadOnly = "";
	String typenm = "";
	String types = "";
	String strMode = "";
	String chkBtnDisplay = "";
	
	// mode = typeModifyPop 일때
	if(mode.equals("typeModifyPop")){
		DataMap rowMap = (DataMap)request.getAttribute("ROW_DATA");
		if(rowMap != null){
			rowMap.setNullToInitialize(true);
			types = rowMap.getString("types");
			typenm = rowMap.getString("typenm");
			
		}
	}
	
	
	if(mode.equals("typeRegPop")){
		strTitle = "용어분류 등록";
		btnTitle = "등 록";
		strMode = "insertTypes";
	}else{
		strTitle = "용어분류 수정";
		btnTitle = "수 정";
		typeReadOnly = "readonly";
		strMode = "updateTypes";
		chkBtnDisplay = "style='display:none'; ";
		
	}
	
	
%>

<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->

<script language="JavaScript" type="text/JavaScript">

// 등록
function fnReg(){

	if(NChecker($("sform"))){
		if($F("hidTypes") == ""){
			alert("분류코드를 입력하고 중복체크를 하세요.");
			return;
		}
		
		if($F("hidTypes") != $F("types")){
			alert("중복체크한 분류코드와 현재 입력된 분류코드가 다릅니다.");
			return;
		}
		
		$("mode").value = "<%=strMode%>";
		sform.action = "dic.do";
		sform.submit();
		
	}
}

// 취소
function fnCancel(){
	self.close();
}

// 분류코드 중복체크
function fnTypesCheck(){
	
	if("<%=mode%>" != "typeRegPop"){
		return;
	}
	
	var pauth = $F("types");
	var url = "dic.do?mode=typecheck";
	var pars = "types=" + pauth;
	
	if(pauth == ""){
		alert("분류코드를 입력하세요.");
		$("types").focus();
		return ;
	}
	
	var myAjax = new Ajax.Request(
			url, 
			{
				method: "get", 
				parameters: pars, 
				onComplete: fnAuthComplete,
				onFailure: function(){
					alert("데이타를 가져오지 못했습니다.");
				}
			}
		);
}
function fnAuthComplete(originalRequest){

	var countTypes = trim(originalRequest.responseText);
	if(countTypes == ""){
		$("hidTypes").value = "";
		alert("데이타를 가져오지 못했습니다.");
		return;
	}else{
	
		if(parseInt(countTypes) == 0){
			$("hidTypes").value = $F("types");
			alert("사용할 수 있습니다.");
		}else{
			$("hidTypes").value = "";
			alert("중복되는 코드가 있습니다.");
			return;
		}
	}
}

function fnSaveResult(){
}

</script>






<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<form id="sform" name="sform" method="post">

<input type="hidden" name="menuId" 	value="<%=requestMap.getString("menuId")%>">
<input type="hidden" name="mode" id="mode" value="">
<input type="hidden" name="hidTypes" id="hidTypes" value="<%= types %>">


<table cellspacing="0" cellpadding="0" border="0" width="100%" height="100%">
	<tr><td height="4" bgcolor="#0081C4" nowrap></td></tr>
	<tr>
		<td height="45" bgcolor="#FFFFFF" style="padding-left:10px" nowrap>
			<!--[s] 타이틀 영역-->
			<table cellspacing="0" cellpadding="0" border="0">
				<tr>
					<td width="15" align="left"><img src="/images/bullet_pop.gif" width="10" height="22" border="0"></td>
					<td><font color="#000000" style="font-weight:bold; font-size:13px"><%= strTitle %></font></td>
				</tr>
			</table>
			<!--[e] 타이틀 영역-->
		</td>
	</tr>
	<tr>
		<td height="100%" class="popupContents" valign="top" bgcolor="#E4E3E4">
		
			<!--[s] contents -->
			<table width="100%" border="0" cellspacing="0" cellspacing="0" class="popTable" >
				<tr bgcolor="#375694"><td height="2" colspan="2"></td></tr>
				<tr height='28' >
					<td class="title_01" width="40%">분류코드</td>
					<td class="cont_01" width="60%">
						<input type="text" name="types" id="types" class="textfield" maxlength="3" size="4" value="<%= types %>" required="true!분류코드가 없습니다." dataform="num!숫자만 입력해야 합니다." <%=typeReadOnly%> >
						&nbsp;
						<input type="button" name="btnChk"  value="중복확인" onclick="fnTypesCheck();" class="boardbtn1" <%= chkBtnDisplay %>  >
					</td>
				</tr>
				<tr height='28' >
					<td class="title_01">분류명</td>
					<td class="cont_01"><input type="text" name="typenm" id="typenm" class="textfield" value="<%= typenm %>" required="true!분류명이 없습니다." maxchar="30!글자수가 많습니다."></td>
				</tr>								
				<tr bgcolor="#375694"><td height="2" colspan="2"></td></tr>	
			</table>
			<!--[e] contents -->	
							
		</td>
	</tr>
	<tr>
		<td height="50" align="center" nowrap>
			<input type="button" name="btnReg"  value="<%= btnTitle %>" onclick="fnReg();" class="boardbtn1">
			&nbsp;
			<input type="button" name="btnCancel" value="취 소" onclick="fnCancel();" class="boardbtn1">
		</td>
	</tr>
</table>


</form>
</body>
