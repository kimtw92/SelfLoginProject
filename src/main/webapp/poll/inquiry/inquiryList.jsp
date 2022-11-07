<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 설문결과  리스트
// date  : 2008-09-22
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
	if(listMap == null){
		listMap = new DataMap();
	}
	listMap.setNullToInitialize(true);
	
	listMap.setNullToInitialize(true);

	//각 셀렉박스에대한 구분 변수
	//String qu = requestMap.getString("qu");
	
	int date = DateUtil.getYear();
	StringBuffer yserOption  =  new StringBuffer();
	for(int i=date+1; i>= 2000; i--){
		if(i == date){
			yserOption.append("<option value=\""+i+"\" selected>"+i+"</option>");	
			
		}else{
			yserOption.append("<option value=\""+i+"\">"+i+"</option>");	
			
		}
	}
	
	//회차 셀렉트박스 설정 
	StringBuffer grcodeSelectBox = new StringBuffer();
	grcodeSelectBox.append("<select name=\"sequence\" onchange=\"selectInquiryAjax('end')\" class=\"mr10\">");
	grcodeSelectBox.append("<option value=\"\" selected> **선택하세요** </option>");
	if(listMap.keySize("titleNo") > 0 ){
		for(int i=0; i < listMap.keySize("titleNo"); i++){
			grcodeSelectBox.append("<option value=\""+listMap.getString("titleNo", i)+"\">"+listMap.getString("titleSeq",i) +"</option>");
		}
		
	} else {
		grcodeSelectBox.append("<option value=\"\">회차가 없습니다.</option>");
	}		
	grcodeSelectBox.append("</select>");
	
%>

<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->


<script language="JavaScript">
<!--
/*divID*/
var id = "";
/*모드 관련 변수*/
var qu = "";

function go_reload(){
	selectInquiryAjax('sequence');
}

//회차
function selectInquiryAjax(qu){

	if(qu == "sequence"){
		id = "divSequence";
	
	}else if(qu == "end"){
		id = "divEnd";
		
	}
	
	var url = "/poll/inquiryPoll.do";
	var pars = "";
	pars = "mode=inquiryAjax&qu="+qu+"&year="+$("commYear").value+"&grcode="+$("commGrcode").value+"&grseq="+$("commGrseq").value+"&sequence="+$("sequence").value;

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
	
	if(qu == "end"){
		report_print($("minVal").value);
		
	}
}



//온로드되었을때
onload = function()	{
	//상단 Onload시 셀렉트 박스 선택.
	var commYear   = "<%= requestMap.getString("commYear") %>";
	var commGrCode = "<%= requestMap.getString("commGrcode").equals("")  ? memberInfo.getSessGrseq() : requestMap.getString("commGrcode") %>";
	var commGrSeq  = "<%= requestMap.getString("commGrseq").equals("")  ? memberInfo.getSessYear() : requestMap.getString("commGrseq") %>";

	//*********************** reloading 하려는 항목을 적어준다. 리로딩을 사용하지 않으면 "" 그렇지 않으면(grCode, grSeq, grSubj)
	var reloading = "grSeq";

	/****** body 상단의 년도, 과정, 기수, 과목등의 select box가 있을경우 밑에 내용 실행. */
	getCommYear(commYear);											// 년도
	getCommOnloadGrCode(reloading, commYear, commGrCode);			// 과정
	getCommOnloadGrSeq(reloading, commYear, commGrCode, commGrSeq);	// 기수
	//getCommOnloadSubj(reloading, commYear, commGrCode, commGrSeq, commSubj);
}

//-->
</script>

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >

<form id="pform" name="pform" method="post" >
<script language='javascript' src="/AIViewer/AIScript.js"></script>
<input type="hidden" name="menuId" 	value="<%= requestMap.getString("menuId") %>">
<input type="hidden" name="mode"	value="<%= requestMap.getString("mode") %>">
<input type="hidden" name="qu"		value="">
<input type="hidden" name="grcode"				value="<%= requestMap.getString("commGrcode") %>">
<input type="hidden" name="grseq"				value="<%= requestMap.getString("commGrseq") %>">

<table cellspacing="0" cellpadding="0" border="0" width="100%" height="100%">
    <tr>
        <td width="211" height="86" valign="bottom" align="center" nowrap="nowrap"><img src="/images/incheon_logo.gif" width="192" height="56" border="0"></td>
        <td width="8" valign="top" nowrap="nowrap"><img src="/images/lefttop_bg.gif" width="8" height="86" border="0"></td>
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
						<img src="/images/bullet003.gif"  align="bottom">&nbsp;<strong>	설문결과 관리</strong>
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
									<div id="divCommYear" class="commonDivLeft">										
										<select name="commYear" onChange="getCommGrCode('grSeq');" class="mr10">
											<option value="">**선택하세요**</option>
										</select>
									</div>
								</td>
								<th width="80">
									과정명
								</th>
								<td>

									<div id="divCommGrCode" class="commonDivLeft">
										<select name="commGrcode" class="mr10">
											<option value="">**선택하세요**</option>
										</select>
									</div>

								</td>
							</tr>
							<tr>
								<th class="bl0">
									기수명
								</th>
								<td colspan="">
									<div id="divCommGrSeq" class="commonDivLeft">
										<select name="commGrseq" class="mr10">
											<option value="">**선택하세요**</option>
										</select>
									</div>
								</td>
								<th>
									회차
								</th>
								<td colspan="3">
									<div id="divSequence">
									
										<!-- 
										<select name="sequence" class="mr10">
											<option value="">**선택하세요**</option>
										</select>
										-->
										
										<%= grcodeSelectBox.toString() %>
										
									</div>
								</td>
							</tr>
						</table>
						</table>
						<table cellspacing="0" cellpadding="0" border="0" width="100%" class="contentsTable">
							<tr>
								<td>
								 <iframe name="AIREPORT" src="#" width="100%" height="600" frameborder="0" border='1'></iframe>
								</td>
							</tr>
						</table>
						<div id="divEnd">
						
						</div>
					</td>
				</tr>
			</table>

<!--[s] bottom -->
<jsp:include page="/commonInc/include/commonAdminBottom.jsp" flush="false"/>
<!--[e] bottom -->

</form>
</body>
<script>
function report_print(minVal) {
	var form        = document.seldata;
	var a_grcode    = $("commGrcode").value;
	var a_grseq     = $("commGrseq").value;
	var a_title_no  = $("sequence").value;
	var a_set_no    = minVal;
	embedAI('AIREPORT', 'http://<%=Constants.AIREPORT_URL%>/report/report_89.jsp?p_grcode='+a_grcode+'&p_grseq='+a_grseq+'&p_title_no='+a_title_no+'&p_set_no='+a_set_no);
}
</script>

<script>
document.write(tagAIGeneratorOcx);
</script>