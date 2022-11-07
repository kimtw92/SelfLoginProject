<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 강사등급관리 팝업폼
// date : 2008-06-16
// auth : 정 윤철
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
	
    //navigation 데이터
	DataMap navigationMap = (DataMap)request.getAttribute("NAVIGATION_DATA");
	navigationMap.setNullToInitialize(true);
	
	// 상단 navigation
	String navigationStr = LoginCheck.NavigationCreate(memberInfo, navigationMap);
	////////////////////////////////////////////////////////////////////////////////////
	
	    //request 데이터
	DataMap rowMap = (DataMap)request.getAttribute("TUTORLEVEL_ROW_DATA");
	rowMap.setNullToInitialize(true);
	
%>

<html>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<!-- [s] commonHtmlTop include 필수 -->
	<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
	<!-- [e] commonHtmlTop include -->
	<head>
	
<script language=javascript>
<!--
//코드중복확인 AJAX
function go_chkCode(){
	
	if($("tlevel").value == "" || $("tlevel").value == null){
		alert("코드를 입력하십시오.");
		return false;
	}
	
	var str_data = $("tlevel").value;
	
	//영문 숫자 체크
	if(str_data != "" || str_data != null){
		for(i=0;i<str_data.length;i++){
			if((str_data.charCodeAt(0) > 64 && str_data.charCodeAt(0) < 91) == false){
				$("check").value = "N";
				alert("코드를 정확히 입력하여 주십시오 대문자 A~Z와 '1~9'문자만 허용됩니다.");
				return false;
				breake;
			}else if( (str_data.charCodeAt(1) > 47 && str_data.charCodeAt(1) < 58) == false){
				$("check").value = "N";
				alert("코드를 정확히 입력하여 주십시오 대문자 A~Z와 '1~9'문자만 허용됩니다.");
				return false;
				breake;
			}
		}
	}
		
	//현재 자신의 코드값과 오브젝트 값이 같을경우에는 체크하지 안는다.
	if($("tlevel").value == "<%=rowMap.getString("tlevel")%>"){
		$("check").value = "Y";
		alert("사용할 수 있는 코드입니다.");
		return false;
	}
	
	var url = "/tutorMgr/allowance.do";
	var pars = "mode=ajaxLevelChk&tlevel="+$("tlevel").value;
	var divId = "classroomDIV";
	var myAjax = new Ajax.Updater(
		{success:divId},
		url, 
		{
			asynchronous : false,
			method: "get", 
			parameters: pars,
			
			onSuccess : fnSuccessChk,
			onFailure: function(){
				alert("오류가 발생했습니다.");
			}
		}
	);
	$("check").value="Y";
}

//코드값 중복후 메시지 
function fnSuccessChk(originalRequest){
	var returnValue = trim(originalRequest.responseText);
	if(returnValue > 0){
		alert("중복된 코드 입니다.\n다시 입력 후 중복확인을 하십시오.	");
		$("tlevel").value ="";
		$("tlevel").onfocus();
		$("check").value="N";
		
	}else{
		alert("사용할 수 있는 코드입니다.");
			$("check").value="Y";
	}
	//alert("test = " + );
}

//코드수정시 체크를 다시하도록 하기위해서 N으로 변경
function chg_chkVal(){
	$("check").value = "N";
}

//등록, 수정 실행
function go_save(qu){
	if(NChecker($("pform"))){
		var str_data = $("tlevel").value;
		
		if(qu == "insert"){
			if($("check").value=="N"){
				alert("코드중복체크를 하여주십시오.");
				return false;
			}
		}
		
		//영문 숫자 체크
		if(str_data != "" || str_data != null){
			for(i=0;i<str_data.length;i++){
				if( (str_data.charCodeAt(i) > 47 && str_data.charCodeAt(i) < 58  || str_data.charCodeAt(i) > 64 && str_data.charCodeAt(i) < 91) == false){
					alert("코드는 영문 대문자와 숫자만 입력 가능합니다.");
					return false;
				}
			}
		}
		
		if(qu == "insert"){
			//등록모드
			if( confirm('등록 하시겠습니까?')){
				$("mode").value = "exec";
				$("qu").value = "insert";
				pform.action = "/tutorMgr/allowance.do";
				pform.submit();
			}
		}else if(qu == "modify"){
			//수정모드
			if( confirm('수정 하시겠습니까?')){
				$("mode").value = "exec";
				$("qu").value = "modify";
				pform.action = "/tutorMgr/allowance.do";				
				pform.submit();
			}
		}else{
			alert("잘못된 경로입니다.");
		}
	}
}
//-->
</script>
	</head>
	<body bgcolor="#FFFFFF" text="#000000" leftmargin="0" topmargin="0">
		<form id="pform" name="pform" method="post">
		<input type="hidden" name="mode">
		<input type="hidden" name="qu">
		<input type="hidden" name="menuId" 				value="<%=requestMap.getString("menuId") %>">
		<input type="hidden" name="check" value="N">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr><td height="4" bgcolor="#0081C4" nowrap></td></tr>
				<tr>
					<td height="45" bgcolor="#FFFFFF" class="popupContents "nowrap>
						<!-- [s]타이틀영역-->
						<table cellspacing="0" cellpadding="0" border="0">
							<tr>
								<td width="15" align="left"><img src="/images/bullet_pop.gif" width="10" height="22" border="0"></td>
								<td><font color="#000000" style="font-weight:bold; font-size:13px">등급설정 </font></td>
							</tr>
						</table>
						<!-- [e]타이틀영역-->
					</td>
				</tr>
				<tr>
					<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td style="padding-left:10px">※ 코드입력시 주의사항 : 같은 그룹으로 나타내기 위해서는 앞자리 코드가 같아야 합니다.
									<br>예) A+과 A는 A그룹, C1과 C2는 C그룹
									<br>※ 강사 등급을 한번 등록한 뒤에는 <font color="red">삭제 할 수 없습니다.</font>
									
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td><div class="space01"></div></td>
				</tr>
				<tr>
					<td style="padding-left:10px;padding-right:10px;">
						<table  width="100%" border="0" cellspacing="0" cellpadding="0" class="dataw01">
							<tr>
								<th style="border-left:0px" width="160">코드</th>
								<td style="border-right:0px">
									<input type="text" class="textfield" maxlength="2" name="tlevel" onkeypress="chg_chkVal();" value="<%=requestMap.getString("qu").equals("insert") ? "" : rowMap.getString("tlevel") %>" <%=requestMap.getString("qu").equals("insert") ? "" : "readonly"%> style="width:50px;" />
									<% if(requestMap.getString("qu").equals("insert")){ %>
									&nbsp;<input type="button" style="cursor:hand" value="중복체크" onclick="go_chkCode();" class="boardbtn1">
									<%} %>
								</td>
							</tr>
							<tr>
								<th style="border-left:0px">구분</th>
								<td style="border-right:0px">
									<input type="text" class="textfield" maxlength="12" name="levelName" value="<%=requestMap.getString("qu").equals("insert") ? "" : rowMap.getString("levelName") %>" style="width:150px;" />
								</td>
							</tr>
							<tr>
								<th style="border-left:0px">집합강사 기본수당</th>
								<td style="border-right:0px">
									<input type="text" class="textfield" maxlength="8" name="gDefaultAmt" required="true!기본수당을 입력하십시오." dataform="num!숫자만 입력해야 합니다." value="<%=requestMap.getString("qu").equals("insert") ? "" : rowMap.getString("gDefaultAmt") %>" style="width:100px;" />
								</td>
							</tr>
							<tr>
								<th style="border-left:0px">집합강사 초과수당</th>
								<td style="border-right:0px">
									<input type="text" class="textfield" maxlength="8" name="gOverAmt" required="true!집합강사 초과수당을 입력하십시오." dataform="num!숫자만 입력해야 합니다." value="<%=requestMap.getString("qu").equals("insert") ? "" : rowMap.getString("gOverAmt") %>" style="width:100px;" />
								</td>
							</tr>
							<tr>
								<th style="border-left:0px">사이버강사 기본수당</th>
								<td style="border-right:0px">
									<input type="text" class="textfield" maxlength="8" name="cDefaultAmt" required="true!사이버강사 기본수당을 입력하십시오." dataform="num!숫자만 입력해야 합니다." value="<%=requestMap.getString("qu").equals("insert") ? "" : rowMap.getString("cDefaultAmt") %>" style="width:100px;" />
								</td>
							</tr>
							<tr>
								<th style="border-left:0px">사이버강사 초과수당</th>
								<td style="border-right:0px">
									<input type="text" class="textfield" maxlength="8" name="cOverAmt" dataform="num!숫자만 입력해야 합니다." required="true!사이버강사 초과수당을 입력하십시오." value="<%=requestMap.getString("qu").equals("insert") ? "" : rowMap.getString("cOverAmt") %>" style="width:100px;" />
								</td>
							</tr>
						</table>
					</td>
				</tr>		
				<tr> 
					<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
						   <tr>
				              <td>
								<table width="100%" border="0" cellspacing="0" cellpadding="0">
									<tr height="10">
										<td></td>
									</tr>
									<tr>
										<td width="100%" align="center" colspan="100%">
										<input type="button" onclick="go_save('<%=requestMap.getString("qu") %>');" class="boardbtn1" value="확인">
										<input type="button" onclick="self.close();" class="boardbtn1" value="취소">
										</td>
									</tr>
								</table></td>
				            </tr>
						</table>
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>
