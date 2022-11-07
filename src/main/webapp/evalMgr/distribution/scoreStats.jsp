<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%  
// prgnm : 평가담당자 > 평가통계관리 > 성적분포도 > 점수별
// date : 2008-07-31
// auth : CHJ
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
	
	DataMap paramData=null;
	DataMap optionList=null;
	String optionStr="";
	String param="";
	if(!requestMap.getString("commGrcode").equals("") && !requestMap.getString("commGrseq").equals("")){
		optionList=(DataMap)request.getAttribute("optionList");
		optionList.setNullToInitialize(true);		
		
		if(!optionList.isEmpty()){
			for(int i=0;i<optionList.keySize("subj");i++){
				if(requestMap.getString("commSubj").equals(optionList.getString("subj",i))){		
					optionStr +="<option value='"+optionList.getString("subj",i)+"' selected>"+optionList.getString("lecnm",i)+"</option>";
				}else{
					optionStr +="<option value='"+optionList.getString("subj",i)+"'>"+optionList.getString("lecnm",i)+"</option>";
				}
			}
		}
	}
	
	if(!requestMap.getString("commGrcode").equals("") && !requestMap.getString("commGrseq").equals("") && !requestMap.getString("commSubj").equals("")){ 
		paramData=(DataMap)request.getAttribute("paramData");
		paramData.setNullToInitialize(true);
		param   ="p_title=test&p_grcode="+requestMap.getString("commGrcode");
		param +="&p_grseq="+requestMap.getString("commGrseq")+"&p_selsubj="+requestMap.getString("commSubj");
		param +="&p_selsubj_cnt=0&p_exampoint="+paramData.getString("exampoint")+"&p_spreportpoint="+paramData.getString("spreportpoint");
		param +="&p_coreportpoint="+paramData.getString("coreportpoint")+"&p_gunpoint="+paramData.getString("gunpoint");
		param +="&p_steppoint="+paramData.getString("steppoint")+"&p_quizpoint="+paramData.getString("quizpoint");
	}
%>
<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->
<html>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>점수별 성적분포도</title>
<head>
<script language="JavaScript" type="text/JavaScript">
<!-- 
	//로딩시.
	onload = function()	{
	
		//상단 Onload시 셀렉트 박스 선택.
		var commYear	= "<%= requestMap.getString("commYear") %>";
		var commGrCode	= "<%= requestMap.getString("commGrcode") %>";
		var commGrSeq	= "<%= requestMap.getString("commGrseq") %>";
		
		//*********************** reloading 하려는 항목을 적어준다. 리로딩을 사용하지 않으면 "" 그렇지 않으면(grCode, grSeq, subj)
		var reloading = "grSeq"; 
	
	
		/****** body 상단의 년도, 과정, 기수, 과목등의 select box가 있을경우 밑에 내용 실행. */
		getCommYear(commYear); //년도 생성.
		getCommOnloadGrCode(reloading, commYear, commGrCode);
		getCommOnloadGrSeq(reloading, commYear, commGrCode, commGrSeq);
//		getCommOnloadSubj(reloading, commYear, commGrCode, commGrSeq, commSubj);	// 과목
	
	}
	
	//comm Selectbox선택후 리로딩 되는 함수.
	function go_reload(){
		go_list();
	}
	//검색
	function go_search(){

		go_list();
	}
	//리스트
	function go_list(){
		$("mode").value = "list";
	
		pform.action = "/evalMgr/distribution.do";
		pform.submit();
	
	}
//-->
</script>
<script language="JavaScript" src="/AIViewer/AIScript.js"></script>

</head>
<body>
<form id="pform" name="pform" method="post">
	<input type="hidden" name="menuId"				value="<%= requestMap.getString("menuId") %>">
	<input type="hidden" name="mode"					value="<%= requestMap.getString("mode") %>">
	<input type="hidden" name="qu"						value="">
	
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


			<!-- subTitle -->
			<!-- space --><table width="100%" height="10"><tr><td></td></tr></table>
			<table width="100%" border="0" cellspacing="0" cellpadding="0" class="contentsSubTitleTable">
				<tr>
					<td height="20">
						<img src="/images/bullet003.gif" width="11" height="11" align="bottom">&nbsp;<strong>점수별</strong>
					</td>
				</tr>
			</table>
			<!--// subTitle -->


			<!--[s] Contents Form  -->
			<table width="90%" align="center" border="0">
			<tr>
				<td>
					<table class="search01" align="center" border="0">			
					<tr>
						<th width="80" class="bl0">
							년도
						</th>
						<td width="20%">
							<div id="divCommYear" class="commonDivLeft">										
								<select name="commYear" onChange="getCommGrCode('subj');" class="mr10">
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
						<td width="100" class="btnr" rowspan="2">
							<input type="button" value="검색" onclick="go_search();" class="boardbtn1">
						</td>
					</tr>
					<tr>
						<th class="bl0">
							기수명
						</th>
						<td>
							<div id="divCommGrSeq" class="commonDivLeft">
								<select name="commGrseq" class="mr10" onChange="javascript:go_search();">
									<option value="">**선택하세요**</option>
								</select>
							</div>
						</td>
						<th class="bl0">
							과목
						</th>
						<td>
							<div id="divCyberCommSubj" class="commonDivLeft">										
								<select name="commSubj" style="width:250px;font-size:12px">
									<option value="">**선택하세요**</option>
									<%=optionStr %> 	
								</select>
							</div>
						</td>
					</tr>
					</table>				
				</td>
			</tr>		
			<tr>
				<td>
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td>&nbsp;</td>
						<td>
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td>
						                <iframe name="AIREPORT" src="#" width="100%" height="600" frameborder="0" border='1'></iframe>
								</td>
							</tr>						
							</table>
						</td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
					</tr>
					</table>
				</td>
				<td>&nbsp;</td>
			</tr>			
			<tr>
				<td>		
					<!--[e] Contents Form  -->
					<!-- space --><table width="100%" height="30"><tr><td></td></tr></table>				                            
				</td>
			</tr>
			</table>
		</td>
	</tr>
	</table>
</form>
<!--[s] bottom -->
<jsp:include page="/commonInc/include/commonAdminBottom.jsp" flush="false"/>
<!--[e] bottom -->
</body>
</html>
<script language="JavaScript" type="text/JavaScript">
<!--
	document.write(tagAIGeneratorOcx);

	<%=(String)request.getAttribute("reportString")%>

	function report_dis1(){
		embedAI("AIREPORT", "http://<%= Constants.AIREPORT_URL %>/report/report_58.jsp?<%=param%>");
 	}
//-->
</script>
