<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%  
// prgnm : 타 과목 동일 반 구성하기 팝업
// date  : 2008-06-11
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
	
	// 과목명
	DataMap subjMap = (DataMap)request.getAttribute("SUBJNM");
	if(subjMap == null) subjMap = new DataMap();
	subjMap.setNullToInitialize(true);

	// 리스트
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	if(listMap == null) listMap = new DataMap();
	listMap.setNullToInitialize(true);
	
	StringBuffer sbListHtml = new StringBuffer();
	
	if(listMap.keySize("subj") > 0){		
		for(int i=0; i < listMap.keySize("subj"); i++){
			sbListHtml.append("<tr bgcolor=\"#FFFFFF\" height=\"25\">");
			sbListHtml.append("	<td align=\"center\" class=\"tableline11\">");
			sbListHtml.append("		<input type=\"checkbox\" name=\"chk\" id=\"chk_" + i + "\" value=\"" + listMap.getString("subj", i) + "\">");
			sbListHtml.append("	</td>");
			sbListHtml.append("	<td align=\"left\" class=\"tableline21\" style=\"padding:0 0 0 9\">" + listMap.getString("lecnm", i) + "</td>");
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

// 전체 체크
function fnChkAll(){

	var i=0;
	var tmpi = 0;
	var objId = "";
	var tmp = "";
	
	for(i=0; i < sform.elements.length; i++){		
		if(sform.elements[i].name == "chk"){
		
			tmp = sform.elements[i].id.split("_");
			objId = "chk_" + tmp[1];
			
			$(objId).checked = $("chkAll").checked;
			
			tmpi += 1;			
		}
	}
}

// 저장
function fnSave(){

	var i=0;
	var tmpi = 0;
	var chkData = "";
	var objId = "";
	
	for(i=0; i < sform.elements.length; i++){		
		if(sform.elements[i].name == "chk"){
											
			if( Form.Element.getValue(sform.elements[i].id) != null ){			
				tmp = sform.elements[i].id.split("_");
				
				objId = "chk_" + tmp[1];
				
				if(tmpi == 0){
					chkData = $F(objId);
				}else{
					chkData += "|" + $F(objId);
				}
				
				tmpi += 1;		
			}
		}
	}
	
	$("chkData").value = chkData;
		
	
	if( $F("chkData") == "" ){
		alert("과목을 선택하세요.");
	}else{
		
		if(confirm("선택하신 정보로 반을 편성하시겠습니까?")){
			$("mode").value = "saveByOther";
			sform.action = "class.do";
			sform.submit();
		}
	}
}

//-->
</script>
<script for="window" event="onload">
<!--


//-->
</script>

<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<form id="sform" name="sform" method="post">

<input type="hidden" name="menuId"		id="menuId"		value="<%=requestMap.getString("menuId")%>">
<input type="hidden" name="mode" 		id="mode" 		value="">

<input type="hidden" name="chkData"		id="chkData" 	value="">

<input type="hidden" name="commGrcode"	id="commGrcode" value="<%= requestMap.getString("commGrcode") %>">
<input type="hidden" name="commGrseq"	id="commGrseq" 	value="<%= requestMap.getString("commGrseq") %>">
<input type="hidden" name="commSubj"	id="commSubj" 	value="<%= requestMap.getString("commSubj") %>">
<input type="hidden" name="modeType" 	id="modeType" 	value="<%= requestMap.getString("modeType") %>">

<table cellspacing="0" cellpadding="0" border="0" width="100%" height="100%">
	<tr><td height="4" bgcolor="#0081C4" nowrap></td></tr>
	<tr>
		<td height="45" bgcolor="#FFFFFF" style="padding-left:10px" nowrap>
			<!--[s] 타이틀 영역-->
			<table cellspacing="0" cellpadding="0" border="0">
				<tr>
					<td width="15" align="left"><img src="/images/bullet_pop.gif" width="10" height="22" border="0"></td>
					<td><font color="#000000" style="font-weight:bold; font-size:13px">타과목 동일반 구성하기</font></td>
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
				<tr height="20"><td><strong><%= subjMap.getString("subjnm") %></strong> 과목 이외에 다음과 같은 과목이 반이 지정되지 않았습니다.</td></tr>
				<tr height="20"><td>동일하게 분반 처리할 과목을 선택 후 확인을 클릭하세요.</td></tr>
				<tr bgcolor="#375694"><td height="2" colspan="100%"></td></tr>
			</table>
			
			<br>
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr bgcolor="#375694"><td height="2" colspan="100%"></td></tr>
				<tr height="28" bgcolor="#5071B4">
					<td width="15%" align="center" class="tableline11 white">
						<strong>선택</strong>
						<input type="checkbox" name="chkAll" id="chkAll" onclick="fnChkAll();">
					</td>
					<td align="center" class="tableline21 white"><strong>과목명</strong></td>
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
			<input type="button" name="btnCancel" value="닫 기" onclick="self.close();" class="boardbtn1">
		</td>
	</tr>
</table>


</form>
</body>
