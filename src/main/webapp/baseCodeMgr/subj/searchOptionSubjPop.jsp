<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 선택과목용 과목검색 팝업
// date  : 2008-06-04
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
	
	
%>




<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->

<script language="JavaScript" type="text/JavaScript">


// 검색
function fnSearch(){

	if(!NChecker($("sform"))){
		return;
	}
	
	var url = "subj.do";
	var pars = "mode=subjPopAjax";
	pars += "&searchTxt=" + $F("searchTxt");
	
	var divID = "divList";
	
	var myAjax = new Ajax.Updater(
			{success: divID },
			url, 
			{
				method: "post", 
				parameters: pars,
				onLoading : function(){
					$(document.body).startWaiting('bigWaiting');
				},
				onSuccess : function(){						
					window.setTimeout( $(document.body).stopWaiting.bind( $(document.body) ), 500);
				},
				onFailure : function(){									
					window.setTimeout( $(document.body).stopWaiting.bind( $(document.body) ), 500);
					alert("데이타를 가져오지 못했습니다.");
				}				
			}
		);
}

// 선택한거 보내기
function fnSend(){
	
	var listCount = 0;
	var subjNM_Id = "";
	var tmp;
	
	
	for(i=0; i < sform.elements.length; i++){		
		if(sform.elements[i].name == "sbjCode"){
											
			if( Form.Element.getValue(sform.elements[i].id) != null ){
			
				tmp = sform.elements[i].id.split("_");
				
				subjNM_Id = "sbjNm_" + tmp[1];
				listCount += 1;
				
				opener.fnInsertData(Form.Element.getValue(sform.elements[i].id), $F(subjNM_Id) );
			}
		}
	}
	
	
	if(listCount == 0){
		alert("선택한 과목이 없습니다.");
	}else{
		alert("선택과목이 입력되었습니다.");
		self.close();
	}
	
	
}


// 닫기
function fnCancel(){
	self.close();
}



</script>

<script for="window" event="onload">
	$("searchTxt").focus();
</script>

<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<form id="sform" name="sform" method="post">

<input type="hidden" name="menuId" 	value="<%=requestMap.getString("menuId")%>">
<input type="hidden" name="mode" id="mode" value="">

<table cellspacing="0" cellpadding="0" border="0" width="100%" height="100%">
	<tr><td height="4" bgcolor="#0081C4" nowrap></td></tr>
	<tr>
		<td height="45" bgcolor="#FFFFFF" style="padding-left:10px" nowrap>
			<!--[s] 타이틀 영역-->
			<table cellspacing="0" cellpadding="0" border="0">
				<tr>
					<td width="15" align="left"><img src="/images/bullet_pop.gif" width="10" height="22" border="0"></td>
					<td><font color="#000000" style="font-weight:bold; font-size:13px">선택과목 추가</font></td>
				</tr>
			</table>
			<!--[e] 타이틀 영역-->
		</td>
	</tr>
	<tr>
		<td height="100%" class="popupContents" valign="top" bgcolor="#E4E3E4">
		
			<!--[s] contents  -->
			<br>
			
			<!--[s] 검색 -->
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr bgcolor="#375694"><td height="2" colspan="100%"></td></tr>
				<tr height="28" bgcolor="F7F7F7" >
					<td width="80" align="center" class="tableline11"><strong>과목명</strong></td>
					<td align="left" class="tableline21" bgcolor="#FFFFFF" style="padding:0 0 0 9">
						<input type="text" name="searchTxt" id="searchTxt" class="textfield" size="20" onKeyPress="if(event.keyCode == 13) { fnSearch(); return false;}" required="true!과목명이 없습니다.">
						<input type="button" value="검 색" onclick="fnSearch();" class="boardbtn1">
					</td>
				</tr>
				<tr bgcolor="#375694"><td height="2" colspan="100%"></td></tr>
			</table>
			<!--[e] 검색 -->
			
			<!--[s] list  -->
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr><td height="5" ></td></tr>
				<tr><td><div id="divList"></div></td></tr>				
			</table>
			<!--[e] list  -->
			
			<!--[e] contents -->
		</td>
	</tr>
	<tr>
		<td height="50" align="center" nowrap>
			<input type="button" name="btnCancel" value="선 택" onclick="fnSend();" class="boardbtn1">
			<input type="button" name="btnCancel" value="닫 기" onclick="fnCancel();" class="boardbtn1">
		</td>
	</tr>
</table>


</form>
</body>
		

