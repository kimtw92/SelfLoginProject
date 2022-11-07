<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 특수권한등록
// date : 2008-06-04
// auth : 정윤철
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
	LoginCheck loginChk = new LoginCheck();
	String navigationStr = loginChk.NavigationCreate(memberInfo, navigationMap);
	////////////////////////////////////////////////////////////////////////////////////
	
	
	//기관코드 셀렉트박스 데이터
	DataMap selectBoxMap = (DataMap)request.getAttribute("DEPT_DATA");
	selectBoxMap.setNullToInitialize(true);
	
	//특수권한 체크박스 데이터
	DataMap checkBoxMap = (DataMap)request.getAttribute("GADMIN_DATA");
	checkBoxMap.setNullToInitialize(true);
	
	//기관코드 셀렉트박스
	StringBuffer option = new StringBuffer();
	if(selectBoxMap.keySize("dept") > 0) {
		for(int i=0; selectBoxMap.keySize("dept") > i; i++){
			option.append("<option value=\""+selectBoxMap.getString("dept",i)+"\">"+selectBoxMap.getString("deptnm",i)+"</option>");
		}
	}
	
	
	//특수권한 체크박스 
	StringBuffer checkBox = new StringBuffer();
	
	if(checkBoxMap.keySize() > 0){
		for(int i=0;checkBoxMap.keySize() > i; i++){
			checkBox.append("<input type =\"checkbox\" name = \"gadmin\" value=\""+checkBoxMap.getString("gadmin",i)+"\">&nbsp;" + checkBoxMap.getString("gadminnm",i)+"<br>");
		}
	}else{
		checkBox.append("등록된 특수권한이 없습니다.");
	}
%>

<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->

<script language="JavaScript" type="text/JavaScript">
/****************************************************************부서명, 부서코드 AJAX***************************************************/
//상세분류코드 가져오기.
function go_partCode(dept){
	var url = "/member/member.do";
	var pars = "?mode=ajaxPartCode&dept="+dept;
	var divId = "partCodeDIV";

	var myAjax = new Ajax.Updater(
		{success:divId},
		url, 
		{
			method: "get", 
			parameters: pars,
			onFailure: fnFailureByAjaxMainSubCode
		}
	);

}

function fnFailureByAjaxMainSubCode(request){
	alert("부서코드 가져오는 도중 오류가 발생했습니다.");
}

//로딩시.
onload = function()	{

	//부서코드 
	var dept = "<%=selectBoxMap.getString("dept")%>";
	//$("dept").value = dept;

	if(dept != ""){
		go_partCode($F("dept"));
	}else{
		go_partCode('');
	}
}

function getPart(objValue, objText) {
    if(objValue == ""){
		$("partnm").value = "";
		document.pform.partnm.focus();
	}else{
		$("partcd").value = objValue;
		$("partnm").value = objText;
	}
}

/****************************************************************부서명, 부서코드 AJAX***************************************************/

//회원검색 팝업
function goPop(){
	
	$("mode").value = "memberSearchList";
	$("qu").value = "";
	pform.action = "/member/member.do";
	var popWindow = popWin('about:blank', 'majorPop11', '600', '500', 'yes', 'no');
	pform.target = "majorPop11";
	pform.submit();
	pform.target = ""; 

}

function goExec(){
	if($("userno").value=="" || $("userno").value== null){
		alert("회원검색을 하신 후 등록 하여주십시오.");
		return false;
	}
	if(confirm("저장 하시겠습니까?")){
		$("mode").value = "adminExec";
		$("qu").value = "insertAdmin";
		pform.action = "/member/member.do";
		pform.submit();
	}
}

function goList(){
	$("mode").value = "adminList";
	pform.action = "/member/member.do";
	pform.submit();
}
</script>


<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >
<form id="pform" name="pform" method="post">
	<input type="hidden" name="qu" value="">
	<input type="hidden" name="mode" value="exec">
	<input type="hidden" name="menuId" value="<%=requestMap.getString("menuId") %>">
	<!-- 유저 검색후 선택된 유저의 번호가 들어온다. -->
	<input type="hidden" name="userno" value="">
	
<table cellspacing="0" cellpadding="0" border="0" width="100%" height="100%">
    <tr>
        <td width="211" height="86" valign="bottom" align="center" nowrap><img src="/images/incheon_logo.gif" width="192" height="56" border="0"></td>
        <td width="8" valign="top" nowrap><img src="/images/lefttop_bg.gif" width="8" height="86" border="0"></td>
        <td width="100%">
            <!--[s] 공통 top include -->
            <jsp:include page="/commonInc/include/commonAdminTopMenu.jsp" flush="false"/>
            <!--[e] 공통 top include -->
        </td>
    </tr>
    <tr>
        <td height="100%" valign="top" align="center" class="leftMenuIllust">
            <!--[s] 공통 Left Menu  -->
            <jsp:include page="/commonInc/include/commonAdminLeftMenu.jsp" flush="false"/>            	
            <!--[e] 공통 Left Menu  -->
        </td>

        <td colspan="2" valign="top" class="leftMenuBg">
          
            <!--[s] 경로 네비게이션-->
            <%= navigationStr %>            
            <!--[e] 경로 네비게이션-->
                                    
			<!--[s] 타이틀 -->
			<jsp:include page="/commonInc/include/commonAdminTitle.jsp" flush="false"/>
			<!--[e] 타이틀 -->

			<!--[s] subTitle -->
			<table width="100%" height="10"><tr><td></td></tr></table>
			<table width="100%" border="0" cellspacing="0" cellpadding="0" class="contentsSubTitleTable">			
				<tr>
					<td height="20">
						<img src="/images/bullet003.gif"  align="bottom">&nbsp;<strong>특수권한자등록</strong>
					</td>
				</tr>
			</table>
			<!--[e] subTitle -->

			<!--[s] Contents Form  -->
			<table cellspacing="0" cellpadding="0" border="0" width="100%" class="contentsTable">
				<tr>
					<td>
										
										
										
										
                        <!---[s] content -->

						<!-- space --><table width="100%" height="10"><tr><td></td></tr></table>
						<table width="95%" border="0" cellpadding="0" cellspacing="0" style = "margin-left:10">
							<tr>
								<td height="2" colspan="100%" bgcolor="#375694" style="" ></td>
							</tr>

							<tr>
								<td height="28" class="tableline11 " bgcolor="E4EDFF" align="center" ><b>담당기관</td>
								<td class="tableline21 " bgcolor="#FFFFFF" style="padding-left:10px;">
									<select name = "dept" onchange="go_partCode(this.value);" style="width:200px">
										<option value="" selected="selected">--- 선택하세요 ---</option>
										<%= option.toString() %>
									</select>
								</td>
							</tr>
							
							<tr style="block">
								<td height="28" class="tableline11 " bgcolor="E4EDFF" align="center"><b>담당부서</td>
								<td class="tableline21 " bgcolor="#FFFFFF" style="padding-left:10px;">
									<div name="partCodeDIV" id="partCodeDIV">
											
									</div>
								</td>
							</tr>
							
							
							<tr>
								<td height="28" class="tableline11 " bgcolor="E4EDFF" align="center" ><b>이름</td>
								<td style="padding-left:10px;" class="tableline21 " bgcolor="#FFFFFF">
								<input type = text name ="name" class="textfield" size="20" onClick="goPop();" style="cursor:Hand" size ="10" maxlength ="10" readonly> <input type = button value = "회원검색" class = "boardbtn1" onClick="goPop();"></td>
							</tr>
							<tr>
								<td height="28" class="tableline11 " bgcolor="E4EDFF" align="center"><b>생년월일</td>
								<td style="padding-left:10px;" class="tableline21 " bgcolor="#FFFFFF">
									<input type = text name = "resno" class="textfield" size="20"  maxlength ="13" readonly></td>
							</tr>
							<tr>
								<td height="28" class="tableline11 " bgcolor="E4EDFF" align="center"><b>권한선택</td>
								<td style="padding-left:10px;" class="tableline21 " bgcolor="#FFFFFF"><%=checkBox.toString() %></td>
							</tr>
							<tr>
								<td height="2" colspan="100%" bgcolor="#375694" style="" ></td>
							</tr>
						</table>
							<br>
						<table width="95%" border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td colspan = 2 align = center>
									<input type ="button" value = "저장" class="boardbtn1" onClick = "goExec();">
									<input type ="button" value = "목록" class="boardbtn1" onClick = "goList();">
								</td>
							</tr>
						</table>
                        <!---[e] content -->
                        
					</td>
				</tr>
			</table>
			<!--[e] Contents Form  -->
				                            
        </td>
    </tr>
</table>

<!--[s] bottom -->
<jsp:include page="/commonInc/include/commonAdminBottom.jsp" flush="false"/>
<!--[e] bottom -->
	
</form>
</body>






