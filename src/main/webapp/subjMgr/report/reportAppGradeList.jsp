<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 과제물 평가 리스트
// date  : 2008-07-22
// auth  : 정윤철
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
	
	int date = DateUtil.getYear();
	StringBuffer yserOption  =  new StringBuffer();
	for(int i=date+1; i>= 2000; i--){
		if(i == date){
			yserOption.append("<option value=\""+i+"\" selected>"+i+"</option>");	
			
		}else{
			yserOption.append("<option value=\""+i+"\">"+i+"</option>");	
			
		}
	}
	

%>

<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->


<script language="JavaScript">
<!--

//과제물 평가 리스트
function go_parity(dates){
	$("mode").value="reportAppList";
	$("dates").value=dates;
	pform.action = "/subjMgr/report.do";
	pform.submit();
}

//엑셀
function go_Excel(dates){
	$("mode").value="reportAppExcel";
	$("dates").value=dates;
	pform.action = "/subjMgr/report.do";
	pform.submit();
	
}


//년도 체크
function yearChk(){
	
	//선택한년도
	var year = "<%=requestMap.getString("year")%>";

	//세션년도
	var sessYear = "<%=memberInfo.getSessYear()%>";

	// 세션에 년도가 있으면서 현재 년도가 없을경우 세션년도를 쓴다.
	if("<%= Util.getValue(memberInfo.getSessYear()) %>" != "" && year == ""){
		$("year").value = "<%= Util.getValue(memberInfo.getSessYear()) %>";
		
	}else if(year != ""){
		//현재선택년도가 있을경우 무조건 현재 페이지껄 쓴다.
		$("year").value = year;
		
	}
	createSubSelectBox('grcode');

}


//각각의 셀렉박스항목 체크 ajax
function createSubSelectBox(pmode){
	if(pmode == "grcode"){//과정명
		var url = "/subjMgr/report.do";
		var pars = "mode=reportGradeAppListAjax&qu=grcode&year="+$F("year");
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
	}else if(pmode == "grseq"){//기수명
		var url = "/subjMgr/report.do";
		var pars = "mode=reportGradeAppListAjax&qu=grseq&year="+$F("year")+"&grcode="+$F("grcode");
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
		
	}else if(pmode == "classno"){//반명
		var url = "/subjMgr/report.do";
		var pars = "mode=reportGradeAppListAjax&qu=classno&year="+$F("year")+"&grcode="+$F("grcode")+"&grseq="+$F("grseq");
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
		createSubSelectBox("end");
		
	}else if(pmode == "end"){
		
		var url = "/subjMgr/report.do";
		var pars = "mode=reportGradeAppListAjax&qu=end&year="+$F("year")+"&grcode="+$F("grcode")+"&grseq="+$F("grseq")+"&classno="+$F("classno");
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


//폼페이지 이동
function go_form(qu, dates){
	$("mode").value="form";
	$("qu").value=qu;
	$("dates").value=dates;
	pform.action = "/subjMgr/report.do";
	pform.submit();
	
}

//초기화
function clearAjax(mode){
var id = "";
var qu = "";
	//년도 가 바뀌었을때
	if(mode == "1"){
		for(var i=0; i < 4; i++ ){

			if(i == 0){
				id = "divGrcode";
				qu = "grcode";
				
			}if(i == 1){
				id = "divGrseq";
				qu = "grseq";

			}else if(i == 2){
				id = "divClassno";
				qu = "classno";
				
			}else if(i == 3){
				id = "divEnd";
				qu = "end";
				
			}
			
			var url = "/subjMgr/report.do";
			var pars = "mode=reportGradeAppListAjax&qu="+qu;
			
			var myAjax = new Ajax.Updater(
				{success:id},
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
			createSubSelectBox(qu);
		}

	}else if(mode == "2"){
	//과정이 바뀌었을때 하위 초기화
		for(var i=0; i < 3; i++ ){
			if(i == 0){
				id = "divGrseq";
				qu = "grseq";
				
			}else if(i == 1){
				id = "divClassno";
				qu = "classno";
				
			}else if(i == 2){
				id = "divEnd";
				qu = "end";
				
			}
			
			var url = "/subjMgr/report.do";
			var pars = "mode=reportGradeAppListAjax&qu="+qu;
			
			var myAjax = new Ajax.Updater(
				{success:id},
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
			createSubSelectBox(qu);
		}
		
	}else if(mode == "3"){
	//기수가 바뀌었을때 하위 초기화
		for(var i=0; i < 2; i++ ){
			if(i == 0){
				id = "divClassno";
				qu = "classno";
				
			}else if(i == 1){
				id = "divEnd";
				qu = "end";
				
			}
		
			var url = "/subjMgr/report.do";
			var pars = "mode=reportGradeAppListAjax&qu="+qu;
			
			var myAjax = new Ajax.Updater(
				{success:id},
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
			createSubSelectBox(qu);
		}

	}
}


//로딩시.
onload = function()	{

	/**********************************사용자 페이지에서 선택한 정보 모음[s]*********************************/
	var grcode = "<%=requestMap.getString("grcode")%>";
	var grseq = "<%=requestMap.getString("grseq")%>";
	var classno = "<%=requestMap.getString("classno")%>";
	/**********************************사용자 페이지에서 선택한 정보 모음[e]*********************************/

	/**********************************세션에 정보 모음[s]*********************************/
	//과정
	var sessGrcode = "<%=memberInfo.getSessGrcode()%>";
	//기수
	var sessGrseq = "<%=memberInfo.getSessGrseq()%>";
	//과목
	var sessSubj = "<%=memberInfo.getSessSubj()%>";
	/**********************************세션에 정보 모음[s]*********************************/	

	//연도 체크 ajax
	yearChk();
	
	//각각의 정보들을 체크 후 셀렉티드 결정 
	if(sessGrcode != "" && grcode == ""){
		//세션 과정 코드가 있으면서 현재 페이지의 과정 코드가 없을경우
		grcode = sessGrcode;
		grcodeLen = $("grcode").options.length;
		
		for(var i=0; i < grcodeLen; i++) {
			if($("grcode").options[i].value == sessGrcode){
				$("grcode").selectedIndex = i;
				
			 }
	 	 }
		
		createSubSelectBox("grseq");
		
	}else if(grcode != ""){
		//현제페이지에서 선택한 과정 코드가 있을경우.
		grcode = grcode;
		grcodeLen = $("grcode").options.length;
		
		for(var i=0; i < grcodeLen; i++) {
			if($("grcode").options[i].value == grcode){
				$("grcode").selectedIndex = i;
			 }
	 	 }
		createSubSelectBox("grseq");
	}


	//각각의 정보들을 체크 후 셀렉티드 결정 
	if(sessGrseq != "" && grseq == ""){
		//세션 과정 코드가 있으면서 현재 페이지의 과정 코드가 없을경우
		grseq = sessGrseq;
		grseqLen = $("grseq").options.length;

		for(var i=0; i < grseqLen; i++) {
			if($("grseq").options[i].value == sessGrseq){
				$("grseq").selectedIndex = i;
			 }
	 	 }
		
		createSubSelectBox("classno");
		
	}else if(grseq != ""){
		//현제페이지에서 선택한 과정 코드가 있을경우.
		grseq = grseq;
		grseqLen = $("grseq").options.length;

		for(var i=0; i < grseqLen; i++) {
			if($("grseq").options[i].value == grseq){
				$("grseq").selectedIndex = i;
			 }
	 	 }
		createSubSelectBox("classno");
		
	}

	//각각의 정보들을 체크 후 셀렉티드 결정 
	if(classno != "" || classno != null){
		//현제페이지에서 선택한 과정 코드가 있을경우.
		classnoLen = $("classno").options.length;
		
		for(var i=0; i < classnoLen; i++) {
			if($("classno").options[i].value == classno){
				$("classno").selectedIndex = i;
			 }
	 	 }
	 	 
		createSubSelectBox("end");
	}	
}



function go_gardePop(dates){
	$("mode").value = "gradeList";
	$("dates").value = dates;
	pform.action = "/subjMgr/report.do";
	var popup =popWin('about:blank','majorPop11', '450', '400', 'yes', 'yes');
	pform.target = "majorPop11";
	pform.submit();
	pform.target = "";
}

//-->
</script>


<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<form id="pform" name="pform" method="post" >

<input type="hidden" name="menuId" 	value="<%= requestMap.getString("menuId") %>">
<input type="hidden" name="mode"	value="<%= requestMap.getString("mode") %>">
<input type="hidden" name="qu"		value="">
<input type="hidden" name="dates"		value="">
<!-- 기존 PHP subj를 하드코딩으로 넘겨서 똑같이 넘겼음... 왜이런지는 모름... -->
<input type="hidden" name="subj" value="SUB1000025">
<!-- 과제물평가관리와 출제 관리에서 수정하였을때에 자신이 온곳으로리턴시켜주기위한 구분값 -->
<input type="hidden" name="urlGubun" value="reportGradeAppList">
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
			<jsp:include page="/commonInc/include/commonAdminTitle.jsp" flush="false" />
			<!--[e] 타이틀 -->

			<!--[s] subTitle -->
			<table width="100%" height="10"><tr><td></td></tr></table>
			<table width="100%" border="0" cellspacing="0" cellpadding="0" class="contentsSubTitleTable">			
				<tr>
					<td height="20">
						<img src="/images/bullet003.gif"  align="bottom">&nbsp;<strong>	과제물 평가관리 리스트</strong>
					</td>
				</tr>
			</table> 
			<div class="h10"></div>
			<!--[s] Contents Form  -->
			<table cellspacing="0" cellpadding="0" border="0" width="100%"
				class="contentsTable">
				<tr>
					<td>
						<!-- 검색  -->
						<table class="search01">
							<tr>
								<th width="80" class="bl0">
									년도
								</th>
								<td width="20%">
								<div id="divYear">
									<select name="year" onchange="clearAjax('1');" class="mr10">
										<option value="">
											**선택하세요**
										</option>
										<%=yserOption.toString() %>
									</select>
								</div>
								</td>
								<th width="80">
									과정명
								</th>
								
								<td>
									<div id="divGrcode">
										<select onchange="clearAjax('2');" name="grcode" class="mr10">
											<option selected value="">
												**선택하세요**
											</option>
										</select>
									</div>
								</td>
							</tr>
							<tr>
								<th class="bl0">
									기수명
								</th>
								<td>
								<div id="divGrseq">
									<select onchange="clearAjax('3');" name="grseq" class="mr10">
										<option selected value="">
											**선택하세요**
										</option>
									</select>
								</div>
								</td>

								<th >
									반명 
								</th>
								<td>
								<div id="divClassno">
									<select name="classno" onchange="createSubSelectBox('end');" class="mr10">
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
						
						<div id="divEnd">
						<!-- 리스트  -->
						<table class="datah01">
							<thead>
							<tr>
								<th>회차</th>
								<th width="40%">제목</th>
								<th>과제물 범위</th>
								
								<th>첨부</th>
								<th>평가<br />등급</th>
								<th>배점</th>
								<th>출제여부</th>
								<th class="br0">기능</th>
							</tr>
							</thead>
							
								
						</table>
						</div>
						<!--//리스트  -->	
						<div class="h5"></div>
					</td>
				</tr>
			</table>
			<!--//[e] Contents Form  -->
			<div class="space_ctt_bt"></div>                     
        </td>
    </tr>
</table>

<!--[s] bottom -->
<jsp:include page="/commonInc/include/commonAdminBottom.jsp" flush="false"/>
<!--[e] bottom -->

</form>
</body>