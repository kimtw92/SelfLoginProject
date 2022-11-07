<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 동영상 콘텐츠 매핑(팝업)
// date  : 2009-06-08
// auth  : hwani
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
	
	//등록된 동영상 목록
	//DataMap movListMap  = (DataMap)request.getAttribute("MOV_LIST_DATA");
	//movListMap.setNullToInitialize(true);
	
	// 임시 과목코드(시퀀스값)
	String subjCode		= (String)request.getAttribute("SUBJ_CODE");
	
	
	String mode = requestMap.getString("mode");
	String subj = requestMap.getString("subj");
	
	if (mode.equals("contentMappingMovU")){subjCode = subj;}
	
	System.out.println("requestMap ============== " + requestMap);
	System.out.println("mode ============== " + mode);
	System.out.println("subj ============== " + subj);
%>




<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->

<script language="JavaScript" type="text/JavaScript">
<!--

//수정인 경우 화면 로딩시 목록 출력
function go_listForUpdate() {
	
	if("contentMappingMovU" == "<%=mode%>") {
		getMovList("<%=subj%>");
	}
}


function go_list() {

	var subj = $F("subj");
	getMovList(subj);
}


//동영상 리스트
function getMovList(subj) {
	
	var objAjax 		= new Object();
	objAjax.url 		= "/baseCodeMgr/subj.do";
	objAjax.pars 		= "mode=ajax_movContList&subj="+ subj;
	objAjax.aSync 		= true; 
	objAjax.targetDiv 	= "movList";
	objAjax.successMsg 	= "";
	objAjax.failMsg		= "";
	objAjax.successFunc = "";
	objAjax.isLoadingYn	= "Y";
	go_ajaxCommonObj(objAjax); //Ajax 통신.
	
}


//적용
function go_apply() {

	if (confirm('적용하시겠습니까?')) {
	
		var form = document.sform;
		var ischeck = false;
		//var orgSize = form.orgSize.value;
		var orgId;
		var orgIdValue;
		var itemId;
		var itemIdValue;
		var replaceValue;
		var splitName1;
		var splitName2;
		var regexp=/,,/g;
		var subjCode = "<%=subjCode%>";	//과목코드
		
		opener.document.pform.scormMappingName.value = "";
		opener.document.pform.arrayOrgDir.value = "";
		//opener.document.forms[0].arrayItemId.value = "";
		
		orgIdValue = document.getElementsByName('arrayOrgId_left');

		if(subjCode != null)	opener.document.pform.subj.value = subjCode;

		for (var i=0 ; i < orgIdValue.length ; i++) {

			if (orgIdValue[i] != undefined) {
				
				replaceValue = (orgIdValue[i].value).replace(regexp, '|');
				splitName1 = replaceValue.split('|');

				if (opener.document.pform.scormMappingName.value == "") {
					opener.document.pform.scormMappingName.value = '[' + (i+1) + ']' + splitName1[1];
					opener.document.pform.arrayOrgDir.value = orgIdValue[i].value;
				} else {
					opener.document.pform.scormMappingName.value = opener.document.pform.scormMappingName.value + '\n' + '[' + (i+1) + ']' + splitName1[1];
					opener.document.pform.arrayOrgDir.value = opener.document.pform.arrayOrgDir.value + '|' + orgIdValue[i].value;
				}
				ischeck = true;
				
				replaceValue = '';
				splitName1 = '';
				splitName2 = '';
			}
		
		}

		self.close();
	}
}


//동영상 등록 팝업
function go_addForm() {
	
	var mode 	= "contForm";
	var subj	= $F("subj");
	var url 	= "/baseCodeMgr/subj.do?mode=" + mode + "&subj=" + subj;

	popWin(url, "pop_contForm", "500", "600", "0", "0");
}


//동영상 제거
function go_removeCont(contCode) {

	var subj = $F("subj");
	var url = "/baseCodeMgr/subj.do";
	var divID = eval("movList");
	var pars = "mode=deleteMov";	
    pars += "&contCode="+contCode;
	pars += "&subj="+subj;
	
	var myAjax = new Ajax.Updater(
			{success: divID },
			url, 
			{
				method: "post", 
				parameters: pars,
				onLoading : function(){
					// $(document.body).startWaiting('bigWaiting');
				},
				onSuccess : function(){
					// window.setTimeout( $(document.body).stopWaiting.bind( $(document.body) ), 500);
					//동영상 리스트
					getMovList(subj);
				},
				onFailure : function(){					
					// window.setTimeout( $(document.body).stopWaiting.bind( $(document.body) ), 500);
					alert("삭제에 실패했습니다.");
				}				
			}
		);
}


//왼쪽 항목의 값 체크 및 체크해제
function leftCheckAll(idValue) {
		
	var orgCheck = document.getElementsByName('arrayOrgId_left');

	if( orgCheck != undefined && orgCheck.length > 0 ){ //선택할수 있는 obj가 있다면
		
		for (var i=0 ; i<orgCheck.length ; i++) {
			if( !orgCheck[i].disabled )
				orgCheck[i].checked = $("checkAll").checked;
		}
	}
}

function go_close() {
	var subj = $F("subj");
	var url = "/baseCodeMgr/subj.do";
	var divID = eval("movList");
	var pars = "mode=deleteMovBySubj";	
	pars += "&subj="+subj;

	var myAjax = new Ajax.Updater(
			{success: divID },
			url, 
			{
				method: "post", 
				parameters: pars,
				onLoading : function(){
					// $(document.body).startWaiting('bigWaiting');
				},
				onSuccess : function(){
					// window.setTimeout( $(document.body).stopWaiting.bind( $(document.body) ), 500);
					self.close();
					//동영상 리스트
					//getMovList(subj);
				},
				onFailure : function(){					
					// window.setTimeout( $(document.body).stopWaiting.bind( $(document.body) ), 500);
					alert("삭제에 실패했습니다.");
				}				
			}
		);
}


//-->
</script> 



<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="go_listForUpdate()" >

<form id="sform" name="sform" method="post">

<input type="hidden" name="mode" id="mode" value="">
<input type="hidden" name="subj" id="subj" value="<%= subjCode %>">

<table cellspacing="0" cellpadding="0" border="0" width="100%" height="100%">
	<tr><td height="4" bgcolor="#0081C4" nowrap="nowrap"></td></tr>
	<tr>
		<td height="45" bgcolor="#FFFFFF" style="padding-left:10px" nowrap="nowrap" >
			<!--[s] 타이틀 영역-->
			<table cellspacing="0" cellpadding="0" border="0">
				<tr>
					<td width="15" align="left"><img src="/images/bullet_pop.gif" width="10" height="22" border="0"></td>
					<td><font color="#000000" style="font-weight:bold; font-size:13px">콘텐츠 매핑</font></td>
				</tr>
			</table>
			<!--[e] 타이틀 영역-->
		</td>
	</tr>
	<tr>


		<td align="center">
			<table width="100%" border="0" align="left" cellpadding="0" cellspacing="0" background="/images/gra_bg.jpg">
				<tr>
					<td colspan="2" height="15" align="left">
						<!-- [s] 테이블 -->
						<table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#C2B09D">
							<tr>
								<td height="30" bgcolor="#F3F6F0">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="4%" height="28">&nbsp;</td>
											<td align="left" class="dotum12_brown">선택된 동영상강의</td>
											<td height="30" align="right" valign="center">
												<input type="button" name="btnAdd" value="등 록" onclick="go_addForm();" class="boardbtn1">
												<!-- <input type="button" name="btnAdd" value="삭 제" onclick="go_removeCont();" class="boardbtn1"> -->
											</td>
										</tr>
									</table>
								</td>
							</tr>
							
							<tr bgcolor="#FFFFFF">
								<td colspan="2" height="15" align="left">&nbsp;</td>
							</tr>
							
							<tr bgcolor="#FFFFFF">
								<td colspan="2" height="15" align="left">
									<table width="100%" border="0" cellpadding="0" cellspacing="0">
										<tr bgcolor="#FFFFFF">
											<td height="15" align="center">
												<!-- <table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF"> -->
													<div id="movList" name="movList" STYLE="width:100%;height:280;overflow:auto;padding:0px;border:0px"></div>
												<!-- </table> -->
												<!-- END : 리스트영역 테이블 -->
											</td>
										</tr>
									</table>
								</td>
							</tr>			
						</table>
						<!-- [e] 테이블 -->
					</td>
					
				</tr>
							
			</table>
		</td>


	</tr>
	<tr>
		<td height="50" align="center" nowrap="nowrap">
			<input type="button" name="btnCancel" value="적 용" onclick="go_apply();" class="boardbtn1">
			<input type="button" name="btnCancel" value="닫 기" onclick="go_close();" class="boardbtn1">
		</td>
	</tr>
</table>



</form>
</body>