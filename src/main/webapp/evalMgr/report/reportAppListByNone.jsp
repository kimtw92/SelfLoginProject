<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%  
// prgnm : 평가담당자 > 과제물관리 > 미제출자관리
// date : 2008-09-01
// auth : 최형준
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
	
	//리스트 데이터
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	listMap.setNullToInitialize(true);
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<script language="JavaScript" type="text/JavaScript">
<!--
	//각각의 셀렉박스항목 체크 ajax
	function createSubSelectBox(pmode){
		if(pmode == "year"){		
			var url = "/evalMgr/report.do";
			var pars = "mode=selectReportAjaxList&qu=year";
			var divId = "divYear";
			var myAjax = new Ajax.Updater(
				{success:divId},
				url, 
				{
					asynchronous : false,
					method: "get", 
					parameters: pars,
					onFailure: function(){
						alert("생성시 오류가 발생했습니다.");
					}
				}
			);				
			
			//과정명 항목 지우기.
			if($("divGrcode") && $("commGrcode"))	selectCommBoxReset($("commGrcode"));
			//과정 기수 항목 지우기.
			if($("divGrseq") && $("commGrseq")) selectCommBoxReset($("commGrseq"));
			//반 항목 지우기.
			if($("divClassno") && $("classno")) selectCommBoxReset($("classno"));
						
		}else if(pmode == "grcode"){
			var url = "/evalMgr/report.do";
			var pars = "mode=selectReportAjaxList&qu=grcode&commYear="+$F("commYear");
			var divId = "divGrcode";
			var myAjax = new Ajax.Updater(
				{success:divId},
				url, 
				{
					asynchronous : false,
					method: "get", 
					parameters: pars,
					onFailure: function(){
						alert("생성시 오류가 발생했습니다.");
					}
				}
			);		
			//과정 기수 항목 지우기.
			if($("divGrseq") && $("commGrseq")) selectCommBoxReset($("commGrseq"));
			//반 항목 지우기.
			if($("divClassno") && $("classno")) selectCommBoxReset($("classno"));
			
		}else if(pmode == "grseq"){
			var url = "/evalMgr/report.do";
			var pars = "mode=selectReportAjaxList&qu=grseq&commYear="+$F("commYear")+"&commGrcode="+$F("commGrcode");
			var divId = "divGrseq";
			var myAjax = new Ajax.Updater(
				{success:divId},
				url, 
				{
					asynchronous : false,
					method: "get", 
					parameters: pars,
					onFailure: function(){
						alert("생성시 오류가 발생했습니다.");
					}
				}
			);					
			//과정 기수 항목 지우기.
			if($("divClassno") && $("classno")) selectCommBoxReset($("classno"));
			
		}else if(pmode == "classno"){
			var url = "/evalMgr/report.do";
			var pars = "mode=selectReportAjaxList&qu=classno&commYear="+$F("commYear")+"&commGrcode="+$F("commGrcode")+"&commGrseq="+$F("commGrseq");
			var divId = "divClassno";
			var myAjax = new Ajax.Updater(
				{success:divId},
				url, 
				{
					asynchronous : false,
					method: "get", 
					parameters: pars,
					onFailure: function(){
						alert("생성시 오류가 발생했습니다.");
					}
				}
			);		
		}else if(pmode == "end"){
			var url = "/evalMgr/report.do";
			var pars = "mode=selectReportAjaxList&qu=end&commYear="+$F("commYear")+"&commGrcode="+$F("commGrcode")+"&commGrseq="+$F("commGrseq")+"&classno="+$F("classno");
			var divId = "divEnd";
			var myAjax = new Ajax.Updater(
				{success:divId},
				url, 
				{
					asynchronous : false,
					method: "get", 
					parameters: pars,
					onFailure: function(){
						alert("생성시 오류가 발생했습니다.");
					}
				}
			);		
		}
	}

	//로딩시.
	onload = function()	{

	var commYear = "<%= requestMap.getString("commYear") %>";
	var commGrCode = "<%= requestMap.getString("commGrcode") %>";
	var commGrSeq = "<%= requestMap.getString("commGrseq") %>";
	
	createSubSelectBox('year');		
	
	}	
	
	function go_list(){
		go_search();
	}
	
	function go_search(){
		if($F("classno") == ""){
			alert("반명을 선택해 주시기 바랍니다.");
		}else{
			createSubSelectBox("end");
		}
	}
	
	// sms
	function send_sms(subj, grcode, grseq, classno, dates) {
		if($F("commYear") == ""){
			alert("년도를 입력하세요");
			return;
		}
		if($F("commGrcode") == ""){
			alert("과정을 선택하세요!");
			return;
		}
		if($F("commGrseq") == ""){
			alert("기수를 선택하세요!");
			return;
		}
		if($F("classno") == ""){
			alert("반을 선택하세요!");
			return;
		}
		
		url="/evalMgr/report.do?mode=smsPop";
		pars="&commSubj="+subj+"&commGrcode="+grcode+"&commGrseq="+grseq+"&classno="+classno+"&dates="+dates;
		
		window.open(url+pars,"SMS_POP","width=600,height=400,scrollbars=yes,status=no");
	}
//-->
</script>
</head>
<body>
<form id="pform" name="pform" method="post" action="">	
<input type="hidden" name="menuId"				value="<%=requestMap.getString("menuId")%>">
<input type="hidden" name="mode"					value="<%= requestMap.getString("mode") %>">
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

        <td colspan="100%" valign="top" class="leftMenuBg" align="center"> 
          
            <!--[s] 경로 네비게이션-->
            <%= navigationStr %>            
            <!--[e] 경로 네비게이션-->
                                    
			<!--[s] 타이틀 -->
			<jsp:include page="/commonInc/include/commonAdminTitle.jsp" flush="false"/>
			<!--[e] 타이틀 -->


			<!-- subTitle -->
			<!-- space --><table width="100%" height="10"><tr><td></td></tr></table>
			<table width="100%" border="0" cellspacing="0" cellpadding="0" class="contentsSubTitleTable">
				<tr>
					<td height="20">
						<img src="/images/bullet003.gif" width="11" height="11" align="bottom">&nbsp;<strong>과제물 리스트</strong>
					</td>
				</tr>
			</table>
			<!--// subTitle -->			

			<!--[s] Contents Form  -->	
			<div class="h10"></div>
			<!--[s] Contents Form  -->
			<table cellspacing="0" cellpadding="0" border="0" width="100%" class="contentsTable">
				<tr>
					<td>						
						<div class="h5"></div>

						<!-- 검색  -->
						<table class="search01">
							<tr>
								<th width="80" class="bl0">
									년도
								</th>
								<td width="20%">
								<div id="divYear">
									<select name="commYear" onchange="" class="mr10">
										<option value="">
											**선택하세요**
										</option>										
									</select>
								</div>
								</td>
								<th width="80">
									과정명
								</th>
								
								<td  align="left" class="tableline11" bgcolor="#FFFFFF" style="padding:0 0 0 9">
									<div id="divGrcode">
										<select onchange="" name="commGrcode" class="mr10">
											<option selected value="">
												**선택하세요**
											</option>
										</select>
									</div>
								</td>
								<td rowspan="2" bgcolor="#FFFFFF" width="100" align="center">
									<input type="button" value="검 색" onclick="go_search();" class="boardbtn1">
								</td>
							</tr>
							<tr>
								<th>
									기수명
								</th>
								<td>
								<div id="divGrseq">
									<select onchange="" name="commGrseq" class="mr10">
										<option selected value="">
											**선택하세요**
										</option>
									</select>
								</div>
								</td>						
								<th>
									반명 
								</th>
								<td  align="left" class="tableline11" bgcolor="#FFFFFF" style="padding:0 0 0 9">
									<div id="divClassno">
										<select name="classno" onchange="" class="mr10">
											<option selected value="">
												**선택하세요**
											</option>
										</select>
									</div>
								</td>
							</tr>
						</table>
						<!--//검색  -->	
						<div class="space01"></div>						

						<!--[s] 리스트  -->
						<div id="divEnd">
						<table class="datah01">
							<thead>
							<tr>
								<th>회차</th>
								<th>제목</th>
								<th>과제물 범위</th>
								<th>배점</th>
								<th>출제여부</th>
								<th class="br0">비고</th>
							</tr>
							</thead>							
						</table>
						</div>
						<!--//[e] 리스트  -->
						<div class="space01"></div>					
					</td>
				</tr>
			</table>
			<!--//[e] Contents Form  -->
			<div class="space_ctt_bt"></div>
			<!--[e] Contents Form  -->	
			
			<!-- space --><table width="100%" height="30"><tr><td></td></tr></table>						
		</td>
	</tr>
	</table>
</form>
<!--[s] bottom -->
<jsp:include page="/commonInc/include/commonAdminBottom.jsp" flush="false"/>
<!--[e] bottom -->
</body>
</html>
