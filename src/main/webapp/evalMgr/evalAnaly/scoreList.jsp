<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 평가 담당자 > 평가결과관리 > 평가점수조회
// date : 2008-08-01
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
	DataMap totData=(DataMap)request.getAttribute("TOT_DATA");
	totData.setNullToInitialize(true);		
	DataMap avgData=(DataMap)request.getAttribute("AVG_DATA");
	avgData.setNullToInitialize(true);		
	DataMap scoreList=(DataMap)request.getAttribute("SCORE_LIST");
	scoreList.setNullToInitialize(true);		
	
	//자치회 유공자 리스트
	String scoreStr="";
	if(scoreList.keySize("eduno") > 0 ){
		for(int i=0;i<scoreList.keySize("eduno");i++){
			scoreStr +="<tr bgcolor='#FFFFFF'>";
			scoreStr +="<td class='tableline11'><div align='center'>"+scoreList.getString("eduno",i)+"</div></td>";
			scoreStr +="<td class='tableline11'><div align='center'>"+scoreList.getString("name",i)+"</div></td>";
			scoreStr +="<td class='tableline11'><div align='center'>-XXXXXXX</div></td>";
			scoreStr +="<td class='tableline11'><div align='center'>"+scoreList.getString("tstep",i)+"</div></td>";
			scoreStr +="<td class='tableline11'><div align='center'>"+scoreList.getString("avcourse",i)+"</div></td>";
			scoreStr +="<td class='tableline11'><div align='center'>"+scoreList.getString("quizstep",i)+"</div></td>";
			scoreStr +="<td class='tableline11'><div align='center'>"+scoreList.getString("avquiz",i)+"</div></td>";
			scoreStr +="<td class='tableline11'><div align='center'>"+scoreList.getString("avlcount",i)+"</div></td>";
			scoreStr +="<td class='tableline11'><div align='center'>"+scoreList.getString("avreport",i)+"</div></td>";
			scoreStr +="<td class='tableline11'><div align='center'>"+scoreList.getString("sumPoint",i)+"</div></td>";
			scoreStr +="</tr>";
		}
	}else{
		scoreStr +="<tr bgcolor='#FFFFFF'>"; 
		scoreStr +="<td class='tableline11' colspan=15><div align='center'>검색된 내용이 없습니다.</div></td>";
		scoreStr +="</tr>";
	}
%>

<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->
<head>
<script language="JavaScript" type="text/JavaScript">
<!--
	//로딩시.
	onload = function()	{
	
		//상단 Onload시 셀렉트 박스 선택.
		var commYear	= "<%= requestMap.getString("commYear") %>";
		var commGrCode	= "<%= requestMap.getString("commGrcode") %>";
		var commGrSeq	= "<%= requestMap.getString("commGrseq") %>";
		var commSubj	= "<%= requestMap.getString("commSubj") %>";
		
		//*********************** reloading 하려는 항목을 적어준다. 리로딩을 사용하지 않으면 "" 그렇지 않으면(grCode, grSeq, subj)
		var reloading = "subj"; 
	
	
		/****** body 상단의 년도, 과정, 기수, 과목등의 select box가 있을경우 밑에 내용 실행. */
		getCommYear(commYear); //년도 생성.
		getCommOnloadGrCode(reloading, commYear, commGrCode);
		getCommOnloadGrSeq(reloading, commYear, commGrCode, commGrSeq);
		getCommOnloadSubj(reloading, commYear, commGrCode, commGrSeq, commSubj);	// 과목
	
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
	
		$("mode").value = "score";
	
		pform.action = "/evalMgr/evalAnaly.do";
		pform.submit();
	
	}
-->
</script>
</head>
<body>
<form id="pform" name="pform" method="post">
<input type="hidden" name="menuId"				value="<%=requestMap.getString("menuId")%>">
<input type="hidden" name="mode"					value="<%=requestMap.getString("mode")%>">

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
						<img src="/images/bullet003.gif" width="11" height="11" align="bottom">&nbsp;<strong>평가 점수 조회</strong>
					</td>
				</tr>
			</table>
			<!--// subTitle -->


			<!--[s] Contents Form  -->
			<table width="90%" align="center">
			<tr>
				<td>
					<table class="search01" align="center">			
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
								<select name="commGrseq" class="mr10">
									<option value="">**선택하세요**</option>
								</select>
							</div>
						</td>
						<th class="bl0">
							과목
						</th>
						<td>
							<div id="divCommSubj" class="commonDivLeft">										
								<select name="commSubj" style="width:250px;font-size:12px">
									<option value="">**선택하세요**</option>
								</select>
							</div>
						</td>
					</tr>
					</table>				
				</td>
			</tr>
			</table><!-- 검색 부분 종료 -->
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr> 
				<td>
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr> 
							<td>&nbsp;</td>
							<td align="center">
								<table width="90%" border="0" cellpadding="0" cellspacing="0">
									<tr>
										<td colspan="10" align="left">총점:<%=totData.getString("totpoint") %>, 평균:<%=avgData.getString("avgpoint") %></td>
									</tr>
									<tr bgcolor="#375694"> 
										<td height="2" colspan="10"></td>
									</tr>
									<tr bgcolor="#5071B4"  height='28' > 
										<td  align='center' class="tableline11 white" width=80><div align="center"><strong>교번</strong></div></td>
										<td  align='center' class="tableline11 white" width=80><div align="center"><strong>성명</strong></div></td>
										<td  align='center' class="tableline11 white" width=80><div align="center"><strong>주민번호</strong></div></td>
										<td  align='center' class="tableline11 white"><div align="center"><strong>진도율(%)</strong></div></td>
										<td  align='center' class="tableline11 white"><div align="center"><strong>진도율점수</strong></div></td>
										<td  align='center' class="tableline11 white"><div align="center"><strong>차시평가<br>정답율(%)</strong></div></td>
										<td  align='center' class="tableline11 white"><div align="center"><strong>차시평가점수</strong></div></td>
										<td  align='center' class="tableline11 white"><div align="center"><strong>평가점수</strong></div></td>
										<td  align='center' class="tableline11 white"><div align="center"><strong>과제물점수</strong></div></td>
										<td  align='center' class="tableline11 white"><div align="center"><strong>취득점수</strong></div></td>
									</tr>
									<%=scoreStr %>
								</table>
							</td>
							<td></td>
						</tr>
						<tr>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
						</tr>
					</table>
				</td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
			</tr>
			</table>
			<!--[e] Contents Form  -->

			<!-- space --><table width="100%" height="30"><tr><td></td></tr></table>
				                            
        </td>
    </tr>
</table>

<!--[s] bottom -->
<jsp:include page="/commonInc/include/commonAdminBottom.jsp" flush="false"/>
<!--[e] bottom -->
	
</form>
</body>