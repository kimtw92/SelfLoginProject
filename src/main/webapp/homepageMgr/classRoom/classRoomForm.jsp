<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : FAQ글 수정 등록 폼
// date : 2008-06-05
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
	
	//강의실 ROW데이터
	DataMap rowMap = (DataMap)request.getAttribute("CLASSROMROW_DATA");
	rowMap.setNullToInitialize(true);
%>

<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->

<script language="JavaScript" type="text/JavaScript">

//등록, 수정
function go_save(qu){
var qu = "<%=requestMap.getString("qu")%>";
     
	if($("classroomName").value==""){
		alert("강의실명을 입력하십시오.");
		$("classroomName").focus();
		return false;
	}
	if($("classroomNo").value==""){
		alert("강의실 코드를 입력하십시오.");
		$("classroomNo").focus();
		return false;
	}
	if($("classroomPlace").value==""){
		alert("위치 입력하십시오.");
		$("classroomPlace").focus();
		return false;
	}
	
	
	if(isNum($("classroomFloor").value,'층위치를') == false){
		$("classroomFloor").focus();
		return false;
	}
	
	if($("classroomFloor").value==""){
		alert("층위치 입력하십시오.");
		$("classroomFloor").focus();
		return false;
	}

	if(isNum($("classroomMember").value,'수용인원을') == false){
		$("classroomMember").focus();
		return false;
	}
	
	if($("classroomMember").value==""){
		alert("수용인원 입력하십시오.");
		$("classroomMember").focus();
		return false;
	}
			
	if($("check").value == "N"){
		alert("강의실 코드를 체크하십시오.");

		return false;		
	}
	
	if(qu =="modify"){
		if(confirm("수정 하시겠습니까?")){  
			$("mode").value = "exec";
			$("qu").value=qu;
			pform.action = "/homepageMgr/classRoom.do";
			pform.submit();
		}
	}else{
		if(confirm("등록 하시겠습니까?")){  
			$("mode").value = "exec";
			$("qu").value=qu;
			pform.action = "/homepageMgr/classRoom.do";
			pform.submit();
		}
	}
}

//리스트
function go_list(){
	
	pform.action = "/homepageMgr/classRoom.do";
	pform.submit();
}

//로딩시.
onload = function()	{

}

//코드중복확인 AJAX
function go_chkCode(){
	
	
	//현재 자신의 코드값과 오브젝트 값이 같을경우에는 체크하지 안는다.
	if($("classroomNo").value == "<%=rowMap.getString("classroomNo")%>"){
		$("check").value = "Y";
		alert("사용할 수 있는 코드입니다.");
		return false;
	}
	
	var classroomNo = $("classroomNo").value;
	var url = "/homepageMgr/classRoom.do";
	var pars = "mode=ajaxClassRoomCodeChk&classroomNo="+classroomNo;
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

function keyDown(){
	//강의실 코드 입력시 N
	$("check").value="N";
}

//코드값 중복후 메시지 
function fnSuccessChk(originalRequest){
	
	var returnValue = trim(originalRequest.responseText);
	
	if(returnValue > 0){
		alert("중복된 코드 입니다.\n다시 입력 후 중복확인을 하십시오.	");
		$("classroomNo").value ="";
		$("classroomNo").onfocus();
		$("check").value="N";
		
	}else{
		alert("사용할 수 있는 코드입니다.");
			$("check").value="Y";
	}
	//alert("test = " + );
}

</script>

<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >
<form id="pform" name="pform" method="post">
<input type="hidden" name="mode" value="">
<input type="hidden" name="qu">
<!-- 메뉴아이디 -->
<input type="hidden" name="menuId" 	value="<%=requestMap.getString("menuId") %>">

<!-- 현재 체크 상태를 점검 -->
<input type="hidden" name="check" 	value="N">
<!-- 기존 강의실 코드값을 가지고있는다. -->
<input type="hidden" name="no" value="<%=rowMap.getString("classroomNo")%>">
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
						<img src="/images/bullet003.gif"  align="bottom">&nbsp;<strong>강의실 <%=requestMap.getString("qu").equals("modify") ? "수정" : "등록"%></strong>
					</td>
				</tr>
			</table>
			<!--[e] subTitle -->

			<!--[s] Contents Form  -->
			<table cellspacing="0" cellpadding="0" border="0" width="100%" class="contentsTable">
				<tr>
					<td>
				<tr>
					<td>
			 <!---[s] content -->
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td>
									<table width="100%" border="0" cellpadding="0" cellspacing="0">
										<tr bgcolor="#375694">
											<td height="2" colspan="8"></td>
										</tr>
	
										<tr>
											<td  align="center" height="28" class="tableline11" bgcolor="#E4EDFF" >
												<strong>강의실명</strong>
											</td>
											<td style="padding-left:10px" class="tableline21">
												<input type="text" class="textfield" maxlength="20" name="classroomName" value="<%=rowMap.getString("classroomName") %>">
											</td>
										</tr>
										<tr>
											<td  align="center" height="28" class="tableline11" bgcolor="#E4EDFF" >
												<strong>강의실코드</strong>
											</td>
											<td style="padding-left:10px" class="tableline21">
												<input type="text" class="textfield" name="classroomNo" maxLength="6" onkeyDown="keyDown();" value="<%=rowMap.getString("classroomNo") %>">
												<input type="button" class="boardbtn1" value="코드중복확인" onclick="go_chkCode();">
											</td>
										</tr>
										<tr>
											<td height="28" class="tableline11" bgcolor="#E4EDFF" align="center" width="15%">
												<strong>위치</strong>
											</td>
											<td style="padding-left:10px" class="tableline21" align="left">
												<input type="text" name="classroomPlace" class="textfield" maxlength="3" size="3" value="<%=rowMap.getString("classroomPlace")%>">
											</td>
										</tr>
										<tr>
											<td height="28" class="tableline11" bgcolor="#E4EDFF" align="center" width="15%">
												<strong>층위치</strong>
											</td>
											<td style="padding-left:10px" class="tableline21" align="left">
												<input type="text" name="classroomFloor" maxlength="3" class="textfield" size="3" value="<%=rowMap.getString("classroomFloor")%>">층
											</td>
										</tr>
										<tr>
											<td height="28" class="tableline11" bgcolor="#E4EDFF" align="center" width="15%">
												<strong>수용인원</strong>
											</td>
											<td style="padding-left:10px" class="tableline21" align="left">
												<input type="text" name="classroomMember" maxlength="5" size="6" class="textfield" value="<%=rowMap.getString("classroomMember")%>">명

											</td>
										</tr>
										<tr bgcolor="#375694">
											<td height="2" colspan="8"></td>
										</tr>
										<tr>
											<td height="20" colspan="100%">
											</td>
										</tr>
										<tr>
											<td align='right' height="40" colspan="100%">
												<input type=button value=' 완료' onClick="go_save('<%=requestMap.getString("qu") %>');" class=boardbtn1>
												<input type=button value=' 리스트 ' onClick="go_list()" class=boardbtn1>
										  </td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>	
		<!-- space -->
		<table width="100%" height="10"><tr><td></td></tr></table>
		<!--[e] Contents Form  -->
        </td>
    </tr>
    
  
</table>

<!--[s] bottom -->
<jsp:include page="/commonInc/include/commonAdminBottom.jsp" flush="false"/>
<!--[e] bottom -->
	
</form>
</body>





