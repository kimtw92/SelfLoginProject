<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 과목 등록 및 수정시 콘텐츠 매핑
// date  : 2008-09-01
// auth  : LYM
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
	
	//DataMap contentMappingListMap = (DataMap)request.getAttribute("COTENTMAPPING_LIST_DATA");
	//contentMappingListMap.setNullToInitialize(true);

	//LCMS 콘텐츠 목록
	DataMap lcmsListMap = (DataMap)request.getAttribute("LCMSCONTENT_LIST_DATA");
	lcmsListMap.setNullToInitialize(true);
	
	String tmpStr = "";

	String lcmsSelStr = "";
	
	for(int i=0; i < lcmsListMap.keySize("ctId"); i++)
		lcmsSelStr += "<option value='" + lcmsListMap.getString("ctId", i) + "' " + tmpStr + ">" + lcmsListMap.getString("ctName", i) + "</option>";


%>




<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->

<script language="JavaScript" type="text/JavaScript">
<!--
	
function go_list() {

	//var form = document.subjectMappingForm;
	var ctId = $F("categoryCode");
	getScormList(ctId);

	//전체 선택 
	$("checkAll").checked = false;
}





// Ajax관련... 콘텐츠 org리스트 추출
function getScormList(ctId) {
	
	var objAjax = new Object();
	objAjax.url = "/baseCodeMgr/subj.do";
	objAjax.pars = "mode=ajax_exec&qu=content"+"&ctId="+ ctId;
	objAjax.aSync = true; 
	objAjax.targetDiv = "scormListByCategory";
	objAjax.successMsg = "";
	objAjax.successFunc = "";

	go_ajaxCommonObj(objAjax); //Ajax 통신.

}


//적용
function go_apply() {


	if (confirm('적용하시겠습니까?')){
	
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
		
		
		opener.document.pform.scormMappingName.value = "";
		opener.document.pform.arrayOrgDir.value = "";
		//opener.document.forms[0].arrayItemId.value = "";
		
		orgIdValue = document.getElementsByName('arrayOrgId_right');

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




var orgCnt = 0;
var itemCnt = 0;
// > 버튼
function left2Right() {
	
	var thisForm = document.sform;
	
	var rightTable = $("rightTable");
	var oContent = new Object();
	var oOrg = new Array();
	var oItem = new Array();
	
	var cnt = thisForm.elements.length;
	var checkCnt = 0; //
	
	var orgPosition = 0;
	var itemPostion = new Array();
	var positionCnt = 0;

	//alert("thisForm.elements.length" + cnt);

	for (var i=0; i<cnt; i++) {
		
		var checkField = thisForm.elements[i];
		
		if (checkField.type == 'checkbox') {
			
			if (checkField.name.search('array') != -1) {
				
				if (checkField.checked) {
					
					checkCnt++;
					if (checkField.name.search('arrayOrgId_left') != -1) {
						if (!checkField.disabled) {
							//alert("orgCnt : "+orgCnt);
							//alert("checkField.value : "+checkField.value);
							oOrg[orgCnt] = "<tr><td><input name=\"arrayOrgId_right\" type=\"checkbox\" value=\""+checkField.value+"\">";
							oOrg[orgCnt] += "<input type=\"hidden\" name=\"arrayOrgId\" id=\"org&"+(orgCnt+1)+"\" value=\""+checkField.value+"\"/></td></tr>";
							orgCnt = orgCnt + 1;
						} else {
							var orgSize = thisForm.orgSize.value;
							var formOrgId;
							
							for (var k=1 ; k<=orgSize ; k++) {
								formOrgId = 'org&' + k;
								if ($(formOrgId) != undefined)
									if ($(formOrgId).checked) 
										orgPosition = k;
							}
						}
					} 
				}
			} else {

				inputName = null;

			}
		}
	}
	if (checkCnt != 0) {
		oContent.org = oOrg;
		//oContent.item = oItem;
		
		//insertTR(rightTable, oContent, orgPosition, itemPostion);
		insertTR(rightTable, oContent, orgPosition);
		// 좌측의 선택된 체크박스 unChecked 한다.
		checkDisable();
		
	} else {
		alert("콘텐츠를 선택해 주세요.");
	}
}

// < 버튼
function right2Left() {
	
	var thisForm = document.sform;
	var orgIdValue;
	var itemIdValue;
	var replaceValue;
	var replaceValue2;
	var splitName;
	var splitName2;
	var regexp=/,,/g;
	
	var rightTable = $("rightTable");
	var orgCheck = document.getElementsByName('arrayOrgId_right');
	//var itemCheck = document.getElementsByName('arrayItemId_right');
	var deleteCheck = new Array();
	var deleteCnt = 0;
	
	var rowLength = rightTable.rows.length;
	//alert("처음 : "+orgCheck.length);
	
	for (var i=0 ; i<orgCheck.length ; i++) {
		if (orgCheck[i].checked) {
		
			orgIdValue = orgCheck[i].value;
			//alert("orgIdValue = " + orgIdValue);

			replaceValue = orgIdValue.replace(regexp, '|');
			splitName = replaceValue.split('|');
			
			// organization 의 TR 위치를 구한다.
			for (var m=0 ; m < rowLength ; m++) {
				if (rightTable.rows[m] != null) {
					if (rightTable.rows[m].id == splitName[0]) {
						deleteCheck[deleteCnt] = m;
						deleteCnt++;
					}
				}
			}

			replaceValue = '';
			splitName = '';
		}
	}
	for (var k=deleteCheck.length-1 ; k>-1 ; k--) {
		// 왼쪽 테이블의 checkBox 디저블 된 것을 풀어준다.
		checkAbleOfLeftTable(rightTable.rows[deleteCheck[k]].id)
		// TR 을 거꾸로 삭제해준다.
		rightTable.deleteRow(deleteCheck[k]);
	}
}

// 위로
function go_up() {
	
	var returnObject = checkChild(true);
	
	var splitValue;
	var trCnt = 0;
	var trId;
	var noCheckTr = 0;
	
	var rightTable = $("rightTable");
	var newRow;
	var newCell;
	var settingHtml;
	
	if (!returnObject) {
		return;
	} else {
		
		for (var i=0 ; i<returnObject.length ; i++) {
			//alert("returnObject["+i+"]: "+returnObject[i]);
			splitValue = returnObject[i].split('|');
			trCnt = splitValue[0];
			trId = splitValue[1];
			noCheckTr = splitValue[2];
			//alert("trCnt : "+trCnt);
			//alert("noCheckTr : "+noCheckTr);
			
			// 선택된 TR의 HTML 값 가져오기.
			settingHtml = rightTable.rows[trCnt].innerHTML;
			// 선택된 TR의 삭제.
			rightTable.deleteRow(trCnt);
			
			// 선택된 organization 의 위에 row 생성.
			//alert("parseInt(noCheckTr): "+parseInt(noCheckTr));
			newRow = rightTable.insertRow(parseInt(noCheckTr));
			newRow.id = trId;
			newCell = insertCell(newRow);
			
			newCell.innerHTML = settingHtml;
		}
	}
}

//아래로
function go_down() {
	
	var returnObject = checkChild(false);
	
	var splitValue;
	var trCnt = 0;
	var trId;
	var noCheckTr = 0;
	
	var rightTable = $("rightTable");
	var newRow;
	var newCell;
	var settingHtml;
	
	if (!returnObject) {
		return;
	} else {
		
		for (var i=0 ; i<returnObject.length ; i++) {
			//alert("returnObject["+i+"]: "+returnObject[i]);
			splitValue = returnObject[i].split('|');
			trCnt = splitValue[0];
			trId = splitValue[1];
			noCheckTr = splitValue[2];
			
			// 선택된 TR의 HTML 값 가져오기.
			settingHtml = rightTable.rows[trCnt].innerHTML;
			// 선택된 TR의 삭제.
			rightTable.deleteRow(trCnt);
			
			// 선택된 organization 의 위에 row 생성.
			newRow = rightTable.insertRow(parseInt(noCheckTr));
			newRow.id = trId;
			newCell = insertCell(newRow);
			
			newCell.innerHTML = settingHtml;
		}
	}
}


function checkChild(isUp) {
	
	var thisForm = document.sform;
	var orgIdValue;
	var itemIdValue;
	var replaceValue;
	var replaceValue2;
	var splitName;
	var splitName2;
	var regexp=/,,/g;
	
	var rightTable = $("rightTable");
	var orgCheck = document.getElementsByName('arrayOrgId_right');
	//var itemCheck = document.getElementsByName('arrayItemId_right');
	
	var checkArr = new Array();
	var checkCnt = 0;
	
	var rowLength = rightTable.rows.length;
	
	var orgCheckCnt = 0;
	var orgCheckCnt2 = 0;
	var orgIndex = 0;
	var itemIndex = 0;
	var orgValue;
	var noCheckValue = new Array();
	var noCheckIndex = 0;
	var itemValue = new Array();
	
	for (var i=0 ; i < orgCheck.length ; i++) {
		
		if (orgCheck[i].checked) {
			orgCheckCnt++;
	
			orgIdValue = orgCheck[i].value;
			
			replaceValue = orgIdValue.replace(regexp, '|');
			splitName = replaceValue.split('|');
	
			// organization 의 TR 위치를 구한다.
			for (var m=0 ; m<rowLength ; m++) {
				if (rightTable.rows[m] != null) {
					if (rightTable.rows[m].id == splitName[0]) {
						orgIndex = m;
						orgValue = splitName[0];
					}
				}
			}
			orgCheckCnt2 = i;
			//alert("orgCheckCnt2 : "+orgCheckCnt2);
		} else {
			orgIdValue = orgCheck[i].value;

			//alert(orgIdValue);
			replaceValue = orgIdValue.replace(regexp, '|');
			splitName = replaceValue.split('|');

			// 체크안된 organization 하위 sco 갯수.
			noCheckValue[i] = noCheckIndex;
		}
	}
	if (orgCheckCnt > 1) {
		alert("이동할 회차를 하나 이상 선택하셨습니다.");
		return false;
		
	} else {
		if (isUp && orgCheckCnt2 == 0) {
			alert("더 이상 순서를 위로 올릴 수 없습니다.");
			return false;
		} else if (!isUp && orgCheckCnt2 == (orgCheck.length-1)) {
			alert("더 이상 순서를 아래로 내릴 수 없습니다.");
			return false;
		} else {
		
			var totalOrg = orgCheck.length;

			if (isUp) {
				if (orgCheckCnt2 > 1) {
					// 선택안된 orga 에서 선택된 orga 바로 위의 orga 에서 그 위의 orga 을 제외한 sco 갯수 가져오기.
					var idx = noCheckValue[orgCheckCnt2-1] - noCheckValue[orgCheckCnt2-2];
					// -1 은 항상 up 을 할 때 1개의 orga 를 뺀다.
					// orgIndex-idx-1 ==> 자신의 tr위치 - 상위 sco갯수 - orga갯수
					checkArr[checkCnt] = orgIndex + "|" + orgValue + "|" + (orgIndex-idx-1);	// tr위치 | tr아이디.
					checkCnt++;
				} else {
					checkArr[checkCnt] = orgIndex + "|" + orgValue + "|" + (orgIndex-noCheckValue[orgCheckCnt2-1]-1);	// tr위치 | tr아이디.
					checkCnt++;
				}
			} else {
				if (orgCheckCnt2 > 0) {
					// 선택안된 orga 에서 선택된 orga 바로 아래의 orga 에서 선택된 orga 위의 orga 을 제외한 sco 갯수 가져오기.
					var idx = noCheckValue[orgCheckCnt2+1] - noCheckValue[orgCheckCnt2-1];
					// +1 은 항상 down 을 할 때 1개의 orga 를 더한다.
					// orgIndex+idx+itemIndex+1 ==> 자신의 tr위치 + 하위 sco갯수 + 자신의 sco갯수 + orga갯수
					checkArr[checkCnt] = orgIndex + "|" + orgValue + "|" + (orgIndex+idx+itemIndex+1);	// tr위치 | tr아이디.
					//checkArr[checkCnt] = orgIndex + "|" + orgValue + "|" + (orgIndex+idx+1);	// tr위치 | tr아이디.
					checkCnt++;
				} else {
					checkArr[checkCnt] = orgIndex + "|" + orgValue + "|" + (orgIndex+noCheckValue[orgCheckCnt2+1]+1+itemIndex);	// tr위치 | tr아이디.
					checkCnt++;
				}
			}

			return checkArr;
		}
	}
}



//function insertTR(oTable, oContent, orgPosition, itemPostion){
function insertTR(oTable, oContent, orgPosition){
	
	var rowLength = oTable.rows.length;
	var targetRow = oTable.rows[rowLength-1];
	
	var newRow;
	var newCell;
	
	var oOrg = oContent.org;
	var oItem = oContent.item;
	
	var replaceValue;
	var splitName;
	var replaceValue2;
	var splitName2;
	var regexp=/,,/g;
	
	var orgIdValue;
	var itemIdValue;
	var textHtml = '';
	var positionCnt = 0;
	
	for (var j=0 ; j<oOrg.length ; j++) {
		if (oOrg[j] != undefined) {
			
			orgIdValue = oOrg[j].substring(oOrg[j].lastIndexOf('=')+2, oOrg[j].lastIndexOf('/')-9);
			replaceValue = orgIdValue.replace(regexp, '|');
			splitName = replaceValue.split('|');
			
			newRow = oTable.insertRow();
			newRow.id = splitName[0];
			newCell = insertCell(newRow);
			

			newCell.innerHTML = oOrg[j] + splitName[1]; // + splitName[0];

			replaceValue = '';
			splitName = '';
		}
	}

	return newRow;
}




//obj Cell 추가
function insertCell(oRow){
	oCell = oRow.insertCell();
	return oCell;
}

//왼쪽의 체크된 항목 disible 시키기.
function checkDisable() {
	
	var thisForm = document.sform;
	var cnt = thisForm.elements.length;
	
	for (var i=0; i<cnt; i++) {
		
		var checkField = thisForm.elements[i];
		
		if (checkField.type == 'checkbox') {
			if (checkField.name.search('_left') != -1) {
				if (checkField.checked) {
					checkField.checked = '';
					checkField.disabled = true;
				}
			}
		}
	}
}
//왼쪽 항목의 값을 풀어줌.
function checkAbleOfLeftTable(idValue) {
		
	var thisForm = document.sform;
	var orgIdValue;
	var itemIdValue;
	var replaceValue;
	var splitName;
	var regexp=/,,/g;
	
	var leftTable = $("leftTable");
	var orgCheck = document.getElementsByName('arrayOrgId_left');

	for (var i=0 ; i<orgCheck.length ; i++) {
		
		orgIdValue = orgCheck[i].value;
			
		replaceValue = orgIdValue.replace(regexp, '|');
		splitName = replaceValue.split('|');
		
		if (idValue == splitName[0]) {
			orgCheck[i].disabled = false;
		}
	}
	replaceValue = '';
	splitName = '';
	
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
//-->
</script> 



<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<form id="sform" name="sform" method="post">

<input type="hidden" name="mode" id="mode" value="">


<table cellspacing="0" cellpadding="0" border="0" width="100%" height="100%">
	<tr><td height="4" bgcolor="#0081C4" nowrap></td></tr>
	<tr>
		<td height="45" bgcolor="#FFFFFF" style="padding-left:10px" nowrap>
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
						<!-- 좌측 테이블 시작 -->
						<table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#B1B9A6">
							<tr>
								<td height="30" bgcolor="#F3F6F0">
									<table width="90%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="4%" height="28">&nbsp;</td>
											<td align="left" class="a_left">
												<select name="categoryCode" id="categoryCode" onchange="javascript:go_list();">
													<option value="0" selected>::분류선택::</option>
													<%= lcmsSelStr %>
												</select>

												<input type="checkbox" name="checkAll" onClick="leftCheckAll();">전체
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
													<table id="leftTable" width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
														<div id="scormListByCategory" STYLE="width:300;height:280;overflow:auto;padding:0px;border:0px"></div>
													</table>
													<!-- END : 리스트영역 테이블 -->
												</td>
											</tr>
										</table>
								</td>
							</tr>
						</table>
						<!-- 좌측 테이블 끝 -->
					</td>
					<!-- 추가 버튼  -->
					<td colspan="2" height="15" align="center">
						<table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#B1B9A6">
							<tr bgcolor="#FFFFFF">
								<td height="30" align="center">
									<a href="javascript:left2Right();"><img src="/images/img_but_01.gif" width="24" height="23" border="0"></a>
								</td>
							</tr>
							<tr bgcolor="#FFFFFF">
								<td height="30" align="center">
									<a href="javascript:right2Left();"><img src="/images/img_but_02.gif" width="24" height="23" border="0"></a>
								</td>
							</tr>
						</table>							
					</td>
					<td colspan="2" height="15" align="left">
						<!-- 우측 테이블 시작 -->
						<table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#C2B09D">
							<tr>
								<td height="30" bgcolor="#F3F6F0">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="4%" height="28">&nbsp;</td>
											<td align="left" class="dotum12_brown">선택된 회차</td>
											<td height="30" align="right" valign="center">
												<a href="javascript:go_up();"><img src="/images/img_but_03.gif" width="24" height="23" border="0"></a>
												<a href="javascript:go_down();"><img src="/images/img_but_04.gif" width="24" height="23" border="0"></a>
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
									<div STYLE="width:300;height:280;overflow:auto;padding:0px;border:0px">
										<table id="rightTable" width="100%" border="0" cellpadding="0" cellspacing="0">
											<tr><td></td></tr>
										</table>
									</div>
								</td>
							</tr>
						</table>
					</td>
					<!-- 우측 테이블 끝 -->
				</tr>
			</table>
		</td>


	</tr>
	<tr>
		<td height="50" align="center" nowrap>
			<input type="button" name="btnCancel" value="적 용" onclick="go_apply();" class="boardbtn1">
			<input type="button" name="btnCancel" value="닫 기" onclick="self.close();" class="boardbtn1">
		</td>
	</tr>
</table>



</form>
</body>