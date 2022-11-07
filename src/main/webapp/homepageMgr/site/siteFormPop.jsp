<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 사이트관리글 수정 등록 폼
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
	
	//팝업관리 ROW데이터
	DataMap rowMap = (DataMap)request.getAttribute("FORMROW_DATA");
	rowMap.setNullToInitialize(true);
	
	//우편번호 자르기. 기준  하이푼
	String zieCode1 = "";
	String zieCode2 = "";
	if(rowMap.getString("siteZipCode").split("[-]").length > 1){
		String[] zieCode = rowMap.getString("siteZipCode").split("[-]");
		zieCode1  = zieCode[0];
		zieCode2  = zieCode[1];
	}else{
		zieCode1 = rowMap.getString("siteZipCode");
	}
	
%>

<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->

<script language="JavaScript" type="text/JavaScript">

//등록
function go_insert(qu){
	
	var siteZipCode1 = $("siteZipCode1").value;
	var siteZipCode2 = $("siteZipCode2").value;
	var siteZipTel = $("siteZipTel").value;	
    

	if($("siteType").value == ""){
		alert("사이트 구분을 선택하십시오");
		return false;
	}

	if($("siteName").value == ""){
		alert("기관 명을 입력하십시오.");
		return false;
	}

	//우편번호 숫자 체크
	if(isNum(siteZipCode1, "우편번호를") == false){
		$("siteZipCode1").value = "";
		$("siteZipCode1").focus();
		return false;
	}
	
	//우편번호 숫자 체크
	if(isNum(siteZipCode2, "우편번호를") == false){
		$("siteZipCode2").value = "";
		$("siteZipCode2").focus();
		return false;
	}
	
	if(confirm("등록 하시겠습니까?")){
		
		$("mode").value = "exec";
		$("qu").value = qu;
		pform.action = "/homepageMgr/site.do";
		pform.submit();
	}
}

//수정
function go_modify(qu){
	
	
	var siteZipCode1 = $("siteZipCode1").value;
	var siteZipCode2 = $("siteZipCode2").value;
	var siteZipTel = $("siteZipTel").value;	
    

	if($("siteType").value==""){
		alert("사이트 구분을 선택하십시오");
		return false;
	}

	if($("siteName").value==""){
		alert("기관명을 입력하십시오.");
		return false;
	}

	if($("siteZipAddr").value==""){
		alert("사이트 주소를 입력하십시오.");
		return false;		
	}		
			
	//우편번호 숫자 체크
	if(isNum(siteZipCode1, "우편번호를") == false){
		$("siteZipCode1").value = "";
		$("siteZipCode1").focus();
		return false;
	}
	
	//우편번호 숫자 체크
	if(isNum(siteZipCode2, "우편번호를") == false){
		$("siteZipCode2").value = "";
		$("siteZipCode2").focus();
		return false;
	}
	
	if(confirm("수정 하시겠습니까?")){
		
		$("mode").value = "exec";
		$("qu").value = qu;
		pform.action = "/homepageMgr/site.do";
		pform.submit();
	}
}

function go_zip(){
	
  	var wl = (window.screen.width/2) - ((400/2) + 10);
  	var wt = (window.screen.height/2) - ((250/2) + 50);
  	var url = "/search/searchZip.do?zipCodeName1=pform.siteZipCode1&zipCodeName2=pform.siteZipCode2&zipAddr=pform.siteZipAddr";
	window.open(url, "주소검색", "width=400, height=250, left=630, top=350, screenX=630 ,screenY=350");
}

//로딩시.
onload = function()	{

}
</script>

<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >
<form id="pform" name="pform" method="post">
<input type="hidden" name="mode" value="">
<input type="hidden" name="qu">
<!-- 메뉴아이디 -->
<input type="hidden" name="menuId" 	value="<%=requestMap.getString("menuId") %>">
<!-- no-->
<input type="hidden" name="siteNo" 	value="<%=requestMap.getString("siteNo") %>">
<input type="hidden" name="currPage" 	value="<%=requestMap.getString("currPage") %>">

<input type="hidden" name="zipCodeName1" value="pform.siteZipCode1">
<input type="hidden" name="zipCodeName2" value="pform.siteZipCode2">
<input type="hidden" name="zipAddr" value="pform.siteZipAddr">

<table cellspacing="0" cellpadding="0" border="0" width="100%" height="100%">
    <tr>
        <td colspan="2" valign="top" class="leftMenuBg">
			<!--[s] subTitle -->
			<table width="100%" border="0" cellspacing="0" cellpadding="0" class="">
				<tr>
					<td height="45" bgcolor="#FFFFFF" style="padding-left:10px" nowrap>
						<!--[s] 타이틀 영역-->
						<table cellspacing="0" cellpadding="0" border="0">
							<tr>
								<td width="15" align="left"><img src="/images/bullet_pop.gif" width="10" height="22" border="0"></td>
								<td><font color="#000000" style="font-weight:bold; font-size:13px">참고사이트관리 <%=requestMap.getString("qu").equals("modify") ? "수정" : "등록" %></font></td>
							</tr>
						</table>
						<!--[e] 타이틀 영역-->
					</td>
				</tr>			
			</table>
			<!--[e] subTitle -->

			<!--[s] Contents Form  -->
			<table cellspacing="0" cellpadding="0" border="0" width="100%" class="popupContents">
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
											<td align="center" height="28" class="tableline11" bgcolor="#E4EDFF" >
												<strong>분류</strong>
											</td>
											<td style="padding-left:10px" class="tableline21">
												<select name="siteType">
													<option value=""> == 분류명 ==</option>
													<option value="중앙부처교육기관"> 중앙부처교육기관 </option>
													<option value="지방자치단체교육기관 "> 지방자치단체교육기관 </option>
													<option value="민간교육기관"> 민간교육기관</option>
												</select>																																				
											</td>
										</tr>										
										<tr>
											<td align="center" height="28" class="tableline11" bgcolor="#E4EDFF" >
												<strong>기관명 입력</strong>
											</td> 
											<td style="padding-left:10px" class="tableline21">
												<input type="text" class="textfield" maxlength="20" size="23" name="siteName" value="<%=rowMap.getString("siteName") %>" >
											</td>
										</tr>
										<tr> 
											<td align="center" height="28" class="tableline11" bgcolor="#E4EDFF" >
												<strong>링크</strong>
											</td>	
											<td style="padding-left:10px" class="tableline21">
												<input type="text" class="textfield" name="siteUrl" size="23" value="<%=rowMap.getString("siteUrl") %>"  maxlength="40">
											</td>
										</tr>
										<tr>
											<td align="center" height="28" class="tableline11" bgcolor="#E4EDFF" >
												<strong>우편번호</strong>
											</td> 
											<td style="padding-left:10px" class="tableline21">
												<input type="text" class="textfield" maxlength="3" size="4" name="siteZipCode1" onclick="go_zip();" style="cursor:hand();" value="<%=zieCode1 %>" readonly> - 
												<input type="text" class="textfield" maxlength="3" size="4" name="siteZipCode2" onclick="go_zip();" style="cursor:hand();" value="<%=zieCode2 %>" readonly>&nbsp;
												<input type="button" value="주소검색" style="cursor:hand();"  class="boardbtn1" onclick="go_zip();">
											</td>
										</tr>
										<tr>
											<td align="center" height="28" class="tableline11" bgcolor="#E4EDFF" >
												<strong>주소</strong>
											</td>
											<td style="padding-left:10px" class="tableline21">
												<input type="text" class="textfield" size="30" name="siteZipAddr" value="<%=rowMap.getString("siteAddr") %>" readonly>
											</td>
										</tr>
										<tr>
											<td align="center" height="28" class="tableline11" bgcolor="#E4EDFF" >
												<strong>전화번호</strong>
											</td>
											<td style="padding-left:10px" class="tableline21">
												<input type="text" maxlength="20" size="23" class="textfield" name="siteZipTel" value="<%=rowMap.getString("siteTel") %>">
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
											<td align='center' height="40" colspan="100%">
												<%if(requestMap.getString("qu").equals("insert")){ %>
													<input type=button value='등록' onClick="go_insert('insert');" class=boardbtn1>
												<%}else{ %>
													<input type=button value='수정' onClick="go_modify('modify');" class=boardbtn1>
												<%} %>
												<input type=button value='닫기' onClick="self.close();" class=boardbtn1>
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
<script language="JavaScript" type="text/JavaScript">
	//시작일
	var siteType = "<%=rowMap.getString("siteType")%>";
	siteTypeLen = $("siteType").options.length
	
	for(var i=0; i < siteTypeLen; i++) {
		if($("siteType").options[i].value == siteType){
			$("siteType").selectedIndex = i;
		 }
 	 }
 	 
</script>



