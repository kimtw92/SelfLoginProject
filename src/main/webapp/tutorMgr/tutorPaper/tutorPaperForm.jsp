<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 강사원고관리 등록폼
// date : 2008-08-04
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
	
	//과정명
	DataMap grcodeMap = (DataMap)request.getAttribute("GRCODETLIST_DATA");
	grcodeMap.setNullToInitialize(true);
	
	StringBuffer grcode = new StringBuffer();
	
	if(grcodeMap.keySize() > 0){
		for(int  i = 0; grcodeMap.keySize() > i; i++){
			grcode.append("<option value=\""+grcodeMap.getString("grcode",i)+"\">"+grcodeMap.getString("grcode", i) + grcodeMap.getString("grcodenm", i)+"</option>");
			
		}
	}
	
	
%>

<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->

<script language="JavaScript">
<!--
function go_change(qu, code){
	var pars = "";
	var divId = "";
	if(qu == "grcode"){
		pars = "mode=ajaxPaperList&grcode="+code+"&qu="+qu;
		divId = "grseqDiv";
	
	}else if(qu == "grseq"){
		pars = "mode=ajaxPaperList&grseq="+code+"&qu="+qu+"&grcode="+$F("grcode");
		divId = "subjDiv";
		
	}else if(qu == "subj"){
		pars = "mode=ajaxPaperList&subj="+code+"&qu="+qu+"&grcode="+$F("grcode")+"&grseq="+$F("grseq");
		divId = "tutorNameDiv";
			
	}
	var url = "/tutorMgr/tutorPaper.do";

	var myAjax = new Ajax.Updater(
		{success:divId},
		url, 
		{
			asynchronous : false,
			method: "get", 
			parameters: pars,
			
			onFailure: function(){
				alert("오류가 발생했습니다.");
			}
		}
	)
	
	if(qu == "grcode"){
		go_cencle('clearGrseq');
		go_cencle('clearSubj');
	}
	
	if(qu == "grseq"){
		go_cencle('clearSubj');
	}
}

//상위셀렉트박스 선택시 하위 셀렉박스 초기화
function go_cencle(qu){
	var pars = "";
	var divId = "";
	if(qu == "clearGrseq"){
		pars = "mode=ajaxPaperList&qu="+qu;
		divId = "subjDiv";
		
	}else if(qu == "clearSubj"){
		pars = "mode=ajaxPaperList&qu="+qu;
		divId = "tutorNameDiv";
			
	}
	
	var url = "/tutorMgr/tutorPaper.do";
	var myAjax = new Ajax.Updater(
		{success:divId},
		url, 
		{
			asynchronous : false,
			method: "get", 
			parameters: pars,
			
			onFailure: function(){
				alert("오류가 발생했습니다.");
			}
		}
	)
}

//등록 체크
function go_check(){
	if($F("grcode") == ""){
		alert("과정명을 선택하십시오.");
		return false;
	}
	
	if($F("grseq") == ""){
		alert("과정기수를 선택하십시오.");
		return false;
	}

	if($F("subj") == ""){
		alert("과목코드를 선택하십시오.");
		return false;
	}	
	
	if($F("tutorName") == ""){
		alert("지정강사를 선택하십시오.");
		return false;
	}	
	
	if($F("pDate") == ""){
		alert("원고제출일을 입력하십시오.");
		return false;
	}
	
	
	var url = "/tutorMgr/tutorPaper.do";
	var pars = "mode=ajaxDateChechk&sDate="+$F("pDate")+"&gubun=form";
	var divId = "";
	
	var myAjax = new Ajax.Request(
		url, 
		{
			asynchronous : false,
			method: "get", 
			parameters: pars,
			
			onComplete : go_save,
			onFailure: function(){
				alert("오류가 발생했습니다.");
			}
		}
	);
}

//등록실행
function go_save(originalRequest){
	var returnValue = trim(originalRequest.responseText);
	if(returnValue < 2 || returnValue > 6){
		alert("원고 제출일을 잘못 입력하셨습니다. 월요일~금요일만 지정할 수 있습니다.");
		return false;
	}
	if(NChecker($("pform"))){
		if( confirm('등록하시겠습니까?')){
			$("mode").value="exec";	
			$("qu").value = "insert";
			pform.action = "/tutorMgr/tutorPaper.do";
			pform.submit();
		}
	}
	
}

//리스트 페이지 이동
function go_list(){
	$("mode").value="tutorPaperList";	
	pform.action = "/tutorMgr/tutorPaper.do";
	pform.submit();
}


//-->
</script>
<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<form id="pform" name="pform" method="post">

<input type="hidden" name="mode" value="">
<input type="hidden" name="qu">
<input type="hidden" name="menuId" 				value="<%=requestMap.getString("menuId") %>">
<input type="hidden" name="currPage"			value='<%=requestMap.getString("currPage")%>'>
<input type="hidden" name="sessNo"			value='<%=memberInfo.getSessNo()%>'>


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
						<img src="/images/bullet003.gif"  align="bottom">&nbsp;<strong> 강사원고관리 등록</strong>
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
									<table width="100%" border="0" bordercolor="" cellpadding="0" cellspacing="0">
										<tr bgcolor="#375694">
											<td height="2" colspan="8"></td>
										</tr>
										<tr>
											<td bgcolor="#E4EDFF" height="28" width="150" align="center" class="tableline11">
												<strong>과정명</strong>
											</td>
											<td align="left" style="padding-left:10px" class="tableline21">
												<select name="grcode" onchange="go_change('grcode', this.value)">
												<option value="">**** 선택하세요 ****</option>
												<%=grcode.toString()%>
												</select>
											</td>
										</tr>
										<tr>
											<td bgcolor="#E4EDFF" height="28" width="150" align="center" class="tableline11"><strong>과정 기수</strong></td>
											<td align="left" style="padding-left:10px" class="tableline21">
												<div id="grseqDiv">
													<select name="grseq" onchange="go_change('grseq', this.value)">
													<option value="">**** 선택하세요 ****</option>
													</select>
												</div>
											</td>
										</tr>
										
										<tr>
											<td bgcolor="#E4EDFF" height="28" width="150" class="tableline11" align="center"><strong>과목 코드</strong></td>
											<td align="left" style="padding-left:10px" class="tableline21">
												<div id="subjDiv">
													<select name="subj" onchange="go_change('subj', this.value)">
													<option value="">**** 선택하세요 ****</option>
													</select>
												</div>
											</td>
										</tr>
										
										<tr>
											<td bgcolor="#E4EDFF" class="tableline11" height="28" width="150" align="center"><strong>지정 강사</strong></td>
											<td align="left" style="padding-left:10px" class="tableline21">
												<div id="tutorNameDiv">
													<select name="tutorName">
													<option value="">**** 선택하세요 ****</option>
													</select>
												</div>
											</td>
										</tr>
										<tr>
											<td bgcolor="#E4EDFF" class="tableline11" height="28" width="150" align="center"><strong>원고제출일</strong></td>
											<td align="left" style="padding-left:10px" class="tableline21">
												<input type="text" class="textfield" name="pDate" value="" style="width:100px" readonly/>
												<img style="cursor:hand" onclick="fnPopupCalendar('pform','pDate');" src="../images/icon_calen.gif" alt="" />
											</td>
										</tr>
										<tr>
											<td bgcolor="#E4EDFF" class="tableline11" height="28" width="150" align="center"><strong>원고장수</strong></td>
											<td align="left" style="padding-left:10px" class="tableline21">
												<input type="text" class="textfield" maxlength="5" required="true!원고장수를 입력하십시오." name="pCnt" value="" dataform="num!숫자만 입력해야 합니다." style="width:50px"/> 장
											</td>
										</tr>
										<tr bgcolor="#375694">
											<td height="2" colspan="8"></td>
										</tr>
										<tr>
											<td height="40" align="center" colspan="100%">
												<input type=button value=' 완료' onClick="go_check();" class=boardbtn1>
												<input type=button value=' 리스트 ' onClick="go_list();" class=boardbtn1>
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
</script>



