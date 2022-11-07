<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%  
// prgnm : 평가 담당자 > 평가항목관리 > 평가항목관리 리스트
// date : 2008-08-26
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
	int nevalCnt=requestMap.getInt("nevalCnt");
	int subjcnt=requestMap.getInt("subjcnt");
	int ssubjcnt=requestMap.getInt("ssubjcnt");
	DataMap evalItemEvalCnt=(DataMap)request.getAttribute("evalItemEvalCnt");
	evalItemEvalCnt.setNullToInitialize(true);
	DataMap recordList=(DataMap)request.getAttribute("recordList");
	recordList.setNullToInitialize(true);
	DataMap srecordList=(DataMap)request.getAttribute("srecordList");
	srecordList.setNullToInitialize(true);
	DataMap reprecord=(DataMap)request.getAttribute("reprecord");
	reprecord.setNullToInitialize(true);
	DataMap gradeInfo=(DataMap)request.getAttribute("gradeInfo");
	gradeInfo.setNullToInitialize(true);	
	DataMap reportList=(DataMap)request.getAttribute("reportList");
	reportList.setNullToInitialize(true);
	
%>


<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->
<head>
<script language="JavaScript" type="text/JavaScript">
<!--
	//로딩시.
	onload = function()	{
	
		var commYear = "<%= requestMap.getString("commYear") %>";
		var commGrCode = "<%= requestMap.getString("commGrcode") %>";
		var commGrSeq = "<%= requestMap.getString("commGrseq") %>";
		
		var reloading = ""; 
		getCommYear(commYear);					
		getCommOnloadGrCode(reloading, commYear, commGrCode);									// 과정
		getCommOnloadGrSeq(reloading, commYear, commGrCode, commGrSeq);				// 기수
	
	}
	
	//검색
	function go_search(){
		
		go_list();
	}
	//리스트
	function go_list(){
	
		$("mode").value = "list";
	
		pform.action = "/evalMgr/evalItem.do";
		pform.submit();
	
	}
	
	function go_action(mod){		
		var sumckpoint = 0.00;
		sumckpoint = goConfirm('F');
		if (sumckpoint == -1) {
			return;
		}		
		
		if (sumckpoint != 100) {
			alert("모든 점수의 합이 100점이어야합니다. 입력하신 총점은 "+(sumckpoint)+"점입니다.");
			return;
		}
		
		$("mode").value = mod;		
		pform.action = "/evalMgr/evalItem.do";
		pform.submit();
	}
	
	function OpenEval(he, wi, go_url){
	  var optstr;
		optstr="height="+he+",width="+wi+",location=0,menubar=0,resizable=1,scrollbars=1,status=0,titlebar=0,toolbar=0,screeny=0,left=0,top=0";
		window.open(go_url, "POPWIN", optstr);
	}
	
	function go_gardePop(url){
		window.open(url, 'gradePop', 'status=no,width=450,height=400,scrollbars=yes');
	}	

	function goConfirm(check){
		var i;
		var ch_leccnt =0 ;
		var submgakpoint = 0.00;
		var submjupoint  = 0.00;
		var sublgakpoint = 0.00;
		var subljupoint  = 0.00;
		
		var subngakpoint1 = 0.00;
		var subnjupoint1  = 0.00;
		
		var subngakpoint2 = 0.00;
		var subnjupoint2  = 0.00;
		
		var subngakpoint3 = 0.00;
		var subnjupoint3  = 0.00;
		
		var subngakpoint4 = 0.00;
		var subnjupoint4  = 0.00;
		
		var subngakpoint5 = 0.00;
		var subnjupoint5  = 0.00;
		
		var subreportpoint = 0.00;
		var substeppoint = 0.00;
		var subquizpoint = 0.00;
		var subtotpoint = 0.00;

		var mgakaverage = 0.00;
		var mjuaverage = 0.00;
		var lgakaverage = 0.00;
		var ljuaverage = 0.00;

		var summgakpoint = 0.00;
		var summjupoint  = 0.00;
		var sumlgakpoint = 0.00;
		var sumljupoint  = 0.00;
		
		var sumngakpoint1 = 0.00;
		var sumnjupoint1  = 0.00;
		
		var sumngakpoint2 = 0.00;
		var sumnjupoint2  = 0.00;
		
		var sumngakpoint3 = 0.00;
		var sumnjupoint3  = 0.00;
		
		var sumngakpoint4 = 0.00;
		var sumnjupoint4  = 0.00;
		
		var sumngakpoint5 = 0.00;
		var sumnjupoint5  = 0.00;
		
		var sumreportpoint = 0.00;
		var sumsteppoint = 0.00;
		var sumquizpoint = 0.00;
		var sumtotpoint = 0.00;		// 일반과목 소계총합
		var sumtotpoint2 = 0.00;	// 특수과목 총합
		
		var sumtotpoint3	= 0.00;	// 리포트 점수
		var flag ='0';

		var cur_ref_subj ='';
		var bf_ref_subj ='';
		var cur_grp_point =0;
		var bf_grp_point =0;
		
		ck_form = document.pform;
		
		//일반과목 배점정보
		if(<%=subjcnt%> >= 1){
			// 선택과목
			cur_ref_subj ='';
			bf_ref_subj ='';
			cur_grp_point =0;
			bf_grp_point =0;
			
			for(i=0;i<<%=subjcnt%>;i++){
				
				subreportpoint = Math.round(Number(reportpointObj[i].value)*100)/100;
				substeppoint = Math.round(Number(steppointObj[i].value)*100)/100;
				//subquizpoint = Math.round(Number(quizpointObj[i].value)*100)/100;

				// 중간평가
				submgakpoint =  Math.round(Number(mgakpointObj[i].value) * Number(mgakweightObj[i].value)*100)/100;
				submjupoint = Math.round(Number(mjupointObj[i].value) * Number(mjuweightObj[i].value)*100)/100;
				
				// 최종평가
				sublgakpoint = Math.round(Number(lgakpointObj[i].value) * Number(lgakweightObj[i].value)*100)/100;
				subljupoint = Math.round(Number(ljupointObj[i].value) * Number(ljuweightObj[i].value)*100)/100;

				// 중간평가				
				cal_mgakObj[i].value = submgakpoint;
				cal_mjuObj[i].value = submjupoint;
				                                              
				// 최종평가                                   
				cal_lgakObj[i].value = sublgakpoint;
				cal_ljuObj[i].value = subljupoint;
				
				if (<%=nevalCnt%> >=1) {
					// 상시1회
					subngakpoint1 =Math.round(Number(ngakpoint1Obj[i].value) * Number(ngakweight1Obj[i].value)*100)/100;
					subnjupoint1 = Math.round(Number(njupoint1Obj[i].value) * Number(njuweight1Obj[i].value)*100)/100;

					// 상시1회                                    
					cal_ngak1Obj[i].value = subngakpoint1;
					cal_nju1Obj[i].value = subnjupoint1;
				}

				if (<%=nevalCnt%> >=2) {
					// 상시2회
					subngakpoint2 = Math.round(Number(ngakpoint2Obj[i].value) * Number(ngakweight2Obj[i].value)*100)/100;
					subnjupoint2 = Math.round(Number(njupoint2Obj[i].value) * Number(njuweight2Obj[i].value)*100)/100;
					// 상시2회                                    
					cal_ngak2Obj[i].value = subngakpoint2;
					cal_nju2Obj[i].value = subnjupoint2;
				}
				
				if (<%=nevalCnt%> >=3) {
					// 상시3회
					subngakpoint3 = Math.round(Number(ngakpoint3Obj[i].value) * Number(ngakweight3Obj[i].value)*100)/100;
					subnjupoint3 = Math.round(Number(njupoint3Obj[i].value) * Number(njuweight3Obj[i].value)*100)/100;
					// 상시3회                                    
					cal_ngak3Obj[i].value = subngakpoint3;
					cal_nju3Obj[i].value = subnjupoint3;
				}

				if (<%=nevalCnt%> >=4) {
					// 상시4회
					subngakpoint4 = Math.round(Number(ngakpoint4Obj[i].value) * Number(ngakweight4Obj[i].value)*100)/100;
					subnjupoint4 = Math.round(Number(njupoint4Obj[i].value) * Number(njuweight4Obj[i].value)*100)/100;
					// 상시4회                                    
					cal_ngak4Obj[i].value = subngakpoint4;
					cal_nju4Obj[i].value = subnjupoint4;
				}

				if (<%=nevalCnt%> >=5) {
					// 상시5회
					subngakpoint5 = Math.round(Number(ngakpoint5Obj[i].value) * Number(ngakweight5Obj[i].value)*100)/100;
					subnjupoint5 = Math.round(Number(njupoint5Obj[i].value) * Number(njuweight5Obj[i].value)*100)/100;
					// 상시5회                                    
					cal_ngak5Obj[i].value = subngakpoint5;
					cal_nju5Obj[i].value = subnjupoint5;

				}
		

				// 리포트점수
				reportpointObj[i].value = subreportpoint;
				// 진도율점수
				steppointObj[i].value = substeppoint;
				// 차시평가점수
				//quizpointObj[i].value = subquizpoint;

				if (lec_typeObj[i].value =='C') {
					ch_leccnt++;
				}
				

				// 선택과목을 고려해서 배점을 표시한다.
				cur_ref_subj = ref_subjObj[i].value;
				if (cur_ref_subj =='0' || (cur_ref_subj != '0' && cur_ref_subj != bf_ref_subj) ) {	// 일반과목이거나 선택과목이면서 첫과목인 경우에만 소계를 계산한다.
				
					summgakpoint += submgakpoint;
					summjupoint  += submjupoint;
					sumlgakpoint += sublgakpoint;
					sumljupoint  += subljupoint;
					
					sumngakpoint1 += subngakpoint1;
					sumnjupoint1  += subnjupoint1;

					sumngakpoint2 += subngakpoint2;
					sumnjupoint2  += subnjupoint2;


					sumngakpoint3 += subngakpoint3;
					sumnjupoint3  += subnjupoint3;

					
					sumngakpoint4 += subngakpoint4;
					sumnjupoint4  += subnjupoint4;

					
					sumngakpoint5 += subngakpoint5;
					sumnjupoint5  += subnjupoint5;

					
					sumreportpoint += subreportpoint;
					sumsteppoint += substeppoint;
					//sumquizpoint += subquizpoint;
				}

				totpointObj[i].value=submgakpoint+submjupoint+sublgakpoint+subljupoint+subngakpoint1+subnjupoint1+subngakpoint2+subnjupoint2+subngakpoint3+subnjupoint3+subngakpoint4+subnjupoint4+subngakpoint5+subnjupoint5+subreportpoint+substeppoint;//+subquizpoint;

				bf_ref_subj = cur_ref_subj;
				bf_grp_point	= cur_grp_point;
			}

			if (ch_leccnt > 0 && check=='F') {
				cur_ref_subj ='';
				bf_ref_subj ='';
				cur_grp_point =0;
				bf_grp_point =0;

				// 선택과목들의 배점을 체크한다.
				for(i=0;i<<%=subjcnt%>;i++){
					cur_ref_subj = ref_subjObj[i].value;
					if (cur_ref_subj =='') continue;
					
					cur_grp_point = totpointObj[i].value;
					if (cur_ref_subj == bf_ref_subj) {
						if (cur_grp_point != bf_grp_point) {
							alert('선택과목그룹은 총점이 동일해야 합니다.');
							return -1;
						}
					}

					bf_ref_subj = cur_ref_subj;
					bf_grp_point	= cur_grp_point;
				}
			}
		}
		
		// 일반과목 소계
	    ck_form.p_summgakpoint.value = summgakpoint;
	    ck_form.p_summjupoint.value = summjupoint;
	    ck_form.p_sumlgakpoint.value = sumlgakpoint;
	    ck_form.p_sumljupoint.value = sumljupoint;
    
		if (<%=nevalCnt%> >=1) { 
			ck_form.p_sumngakpoint1.value = sumngakpoint1;
			ck_form.p_sumnjupoint1.value = sumnjupoint1;
   	 	}

		if (<%=nevalCnt%> >=2) { 
			ck_form.p_sumngakpoint2.value = sumngakpoint2;
			ck_form.p_sumnjupoint2.value = sumnjupoint2;
		}

		if (<%=nevalCnt%> >=3) { 
			ck_form.p_sumngakpoint3.value = sumngakpoint3;
			ck_form.p_sumnjupoint3.value = sumnjupoint3;
		}
    
		if (<%=nevalCnt%> >=4) { 
			ck_form.p_sumngakpoint4.value = sumngakpoint4;
			ck_form.p_sumnjupoint4.value = sumnjupoint4;
		}
    
		if (<%=nevalCnt%>>=5) { 
			ck_form.p_sumngakpoint5.value = sumngakpoint5;
			ck_form.p_sumnjupoint5.value = sumnjupoint5;
		}
    
    
	    ck_form.p_sumreportpoint.value = sumreportpoint;
	    ck_form.p_sumsteppoint.value = sumsteppoint;
	    //ck_form.p_sumquizpoint.value = sumquizpoint;


		// 일반과목 소계총합
		
		sumtotpoint = summgakpoint+summjupoint+sumlgakpoint+sumljupoint+sumngakpoint1+sumnjupoint1+sumngakpoint2+sumnjupoint2+sumngakpoint3+sumnjupoint3+sumngakpoint4+sumnjupoint4+sumngakpoint5+sumnjupoint5+sumreportpoint+sumsteppoint;//+sumquizpoint;
		
    	ck_form.p_sumtotpoint.value = sumtotpoint;

		//특수과목 배점정보
		if(<%=ssubjcnt%> >= 1){
		  for(i=0;i<<%=ssubjcnt%>;i++){
		    //ck_form.p_subj2[i].value = ck_form.p_subj2[i].value;
		    //ck_form.p_totpoint2[i].value = ck_form.p_totpoint2[i].value;
		    sumtotpoint2 += Number(totpoint2Obj[i].value);
		  }
		}
		
		// 특수과목 소계
    	ck_form.p_sumtotpoint2.value = sumtotpoint2;

    
	    // 리포트 과목 
	    sumtotpoint3 = Number(ck_form.sp_reportpoint.value);
    
    	ck_form.sp_reportpoint.value = sumtotpoint3;
    
    
		// 총점 (일반과목+특수과목+리포트)
    	ck_form.p_sumtotal.value = sumtotpoint+sumtotpoint2+sumtotpoint3;
    
    	return (sumtotpoint+sumtotpoint2+sumtotpoint3);    
	}
-->
</script>
</head>
<body>
<form id="pform" name="pform" method="post" action="">
<input type="hidden" name="menuId"				value="<%=requestMap.getString("menuId")%>">
<input type="hidden" name="mode"					value="<%= requestMap.getString("mode") %>">
<input type="hidden" name="nevalCnt" 			value="<%=nevalCnt %>">
<input type="hidden" name="dates"	 id="dates"       value="">
<nput type="hidden" name="classno" id="classno"	vaue="">


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
						<img src="/images/bullet003.gif" width="11" height="11" align="bottom">&nbsp;<strong>평가 항목 관리</strong>
					</td>
				</tr>
			</table>
			<!--// subTitle -->			

			<!--[s] Contents Form  -->	
			<table width="90%" border="0" cellspacing="0" cellpadding="0" align="center">
				<tr bgcolor="#375694"><td height="2" colspan="100%"></td></tr>
				<tr height="28" bgcolor="F7F7F7" >
					<td width="80" align="center" class="tableline11"><strong>년 도</strong></td>
					<td align="left" class="tableline11" bgcolor="#FFFFFF" style="padding:0 0 0 9">
						<div id="divCommYear" class="commonDivLeft">										
							<select name="commYear" onChange="getCommGrCode('subj');" style="width:100px;font-size:12px">
								<option value="">**선택하세요**</option>
							</select>
						</div>					
					</td>
					<td width="80" align="center" class="tableline11"><strong>과 정</strong></td>
					<td align="left" class="tableline11" bgcolor="#FFFFFF" style="padding:0 0 0 9">
						<div id="divCommGrCode" class="commonDivLeft">
							<select name="commGrcode" style="width:250px;font-size:12px">
								<option value="">**선택하세요**</option>
							</select>
						</div>
					</td>
					<td rowspan="2" bgcolor="#FFFFFF" width="100" align="center">
						<input type="button" value="검 색" onclick="go_search();" class="boardbtn1">
					</td>
				</tr>
				<tr height="28" bgcolor="F7F7F7">
					<td align="center" class="tableline11"><strong>기 수</strong></td>
					<td align="left" class="tableline11" bgcolor="#FFFFFF" style="padding:0 0 0 9">
						<div id="divCommGrSeq" class="commonDivLeft">
							<select name="commGrseq" style="width:100px;font-size:12px">
								<option value="">**선택하세요**</option>
							</select>
						</div>
					</td>
					<td align="center" class="tableline11"  colspan="2" bgcolor="#FFFFFF">&nbsp;</td>
				</tr>														
				<tr bgcolor="#375694"><td height="2" colspan="100%"></td></tr>
			</table>
			
			<!-- space --><table width="100%" height="30"><tr><td></td></tr></table>
			<!-- 상단 버튼 -->
			<table width="90%"  border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td class="left">				
					(중간 <%=evalItemEvalCnt.getString("mevalYn").equals("Y")?"O":"X" %>, 최종평가 <%=evalItemEvalCnt.getString("levalYn").equals("Y")?"O":"X" %>, 상시평가수 <%=nevalCnt%>회)
				</td>								
				<td align="right" >
					<input type=button class="boardbtn1"  value="평가배점변경" onClick="javascript:OpenEval(400, 500, '/evalMgr/evalItem.do?mode=batchExpoint&menuId=<%= requestMap.getString("menuId") %>&commGrcode=<%=requestMap.getString("commGrcode") %>&commGrseq=<%=requestMap.getString("commGrseq")%>')">
				</td>
			</tr>
			</table>
			<!-- space --><table width="100%" height="10"><tr><td></td></tr></table>			
			<!-- LIST -->
			<table width="90%" border="0" cellpadding="0" cellspacing="0" bgcolor="E5E5E5">
			<tr bgcolor="#375694"> 
				<td height="2" colspan="100%"></td>
			</tr>
			<tr height="28" bgcolor="#5071B4">
				<td align="center" class="tableline11 white"><strong>과목구분</strong></td>
				<td align="center" class="tableline11 white"><strong>과목명</strong></td>
				<td align="center" class="tableline11 white"><strong>중간(객)<br>문제수,배점</strong></td>
				<td align="center" class="tableline11 white"><strong>중간(주)<br>문제수,배점</strong></td>
				<td align="center" class="tableline11 white"><strong>최종(객)<br>문제수,배점</strong></td>
				<td align="center" class="tableline11 white"><strong>최종(주)<br>문제수,배점</strong></td>

				<%if(nevalCnt != 0){ 
					for(int i=1;i<=nevalCnt;i++){%>
						<td align="center" class="tableline11 white"><strong>상시<%=i %><br>(객)</strong></td>
						<td align="center" class="tableline11 white"><strong>상시<%=i %><br>(주)</strong></td>
					<%}
					} %>			

				<td align="center" class="tableline11 white"><strong>과제물<br>점수</strong></td>
				<td align="center" class="tableline11 white"><strong>진도율<br>점수</strong></td>
				<td align="center" class="tableline11 white"><strong>필수<br>이수<br>진도율</strong></td>
				<!-- 
				<td align="center" class="tableline11 white"><strong>차시<br>평가</strong></td>
				<td align="center" class="tableline11 white"><strong>차시<br>평가<br>정답율</strong></td> 
				 -->
				<td align="center" class="tableline11 white"><strong>총점</strong></td>
			</tr>			
			<%for(int i=0;i<recordList.keySize("j");i++){ %>
			<tr bgcolor="FFFFFF"> 
				<input type="hidden" name="p_subj[]" value="<%=recordList.getString("subj",i) %>">
				<input type="hidden" name="p_lec_type[]" value="<%=recordList.getString("lecType",i) %>">
				<input type="hidden" name="p_ref_subj[]" value="<%=recordList.getString("refSubj",i)%>">
				<%if(!recordList.getString("rowspan",i).equals("0")){ %>
					<td rowspan="<%=recordList.getString("rowspan",i) %>" class="tableline11" ><div align="center"><%=recordList.getString("subjGnm",i) %></div></td>
				<%} %>
				<td class="tableline11"><div align="center"><%=recordList.getString("lecnm",i) %></div></td>
				<input type="hidden" name="p_ptype_m[]" value="<%=recordList.getString("ptypem",i) %>">
				<td class="tableline11">
					<div align="center">
						<table width="100%"><tr><td><input type="text" size="1"  maxlength="3" name="p_mgakpoint[]" value="<%=recordList.getString("mgakpoint",i) %>" <%=recordList.getString("readM",i) %> onBlur="javascript:goConfirm();"></td>
						<td><input type="text" size="1" maxlength="5" name="p_mgakweight[]" value="<%=recordList.getString("mgakweight",i) %>" <%=recordList.getString("readM",i) %> onBlur="javascript:goConfirm();"></td>
						</tr>
						<tr><td colspan="2"><input type="text" size="1" maxlength="8" name="p_cal_mgak[]" readonly style="width:30px;border-color:black;border-width:1px"></td></tr></table>
						</div></td>
						<td class="tableline11"><div align="center">
						<table width="100%"><tr><td><input type="text" size="1" maxlength="3" name="p_mjupoint[]" value="<%=recordList.getString("mjupoint",i) %>" <%=recordList.getString("readM",i) %> onBlur="javascript:goConfirm();"></td>
						<td><input type="text" size="1" maxlength="5" name="p_mjuweight[]" value="<%=recordList.getString("mjuweight",i) %>" <%=recordList.getString("readM",i) %> onBlur="javascript:goConfirm();"></td>
						</tr>
						<tr>
						<td colspan="2"><input type="text" size="1" maxlength="8" name="p_cal_mju[]" readonly style="width:30px;border-color:black;border-width:1px"></td>
						</tr>
						</table>
					</div>
				</td>

				<input type="hidden" name="p_ptype_t[]" value="<%=recordList.getString("ptypet",i) %>">
				<td class="tableline11">
				<div align="center">
				<table width=100%>
				<tr>
				<td><input type="text" size="1" maxlength="3" name="p_lgakpoint[]" value="<%=recordList.getString("lgakpoint",i) %>" <%=recordList.getString("readL",i) %> onBlur="javascript:goConfirm();"></td>
				<td><input type="text" size="1" maxlength="5" name="p_lgakweight[]" value="<%=recordList.getString("lgakweight",i) %>" <%=recordList.getString("readL",i) %> onBlur="javascript:goConfirm();"></td>
				</tr>
				<tr>
				<td colspan="2"><input type="text" size="1" maxlength="8" name="p_cal_lgak[]" readonly style="width:30px;border-color:black;border-width:1px"></td>
				</tr>
				</table>
				</div></td>
				<td class="tableline11"><div align="center">
				<table width=100%><tr><td><input type="text" size="1" maxlength="3" name="p_ljupoint[]" value="<%=recordList.getString("ljupoint",i) %>" <%=recordList.getString("readL",i) %> ></td>
				<td><input type="text" size="1" maxlength="5" name="p_ljuweight[]" value="<%=recordList.getString("ljuweight",i) %>" <%=recordList.getString("readL",i) %> onBlur="javascript:goConfirm();"></td>
				</tr>
				<tr><td colspan="2"><input type="text" size="1" maxlength="8" name="p_cal_lju[]" readonly style="width:30px;border-color:black;border-width:1px"></td></tr></table>
				</div></td>
			
			
			<%if(nevalCnt != 0){ 
					for(int j=1;j<=nevalCnt;j++){%>
						<input type="hidden" name="p_ptype_<%=j %>[]" value="<%=recordList.getString("ptype"+j,i) %>">
						<td class="tableline11">
						<div align="center">
							<table width=100%>
							<tr>
								<td><input type="text" size="1" maxlength="3" name="p_ngakpoint<%=j %>[]" value="<%=recordList.getString("ngakpoint"+j,i) %>" <%if(recordList.getString("ptype"+j,i).equals("0") || recordList.getString("ptype"+j,i).equals("3")){%> readonly style="width:30px;border-color:black;border-width:1px" <%}else{ %>style="width:30px;background:yellow"<%} %> onBlur="javascript:goConfirm();"></td>
								<td><input type="text" size="1" maxlength="5" name="p_ngakweight<%=j %>[]" value="<%=recordList.getString("ngakweight"+j,i) %>" <%if(recordList.getString("ptype"+j,i).equals("0") || recordList.getString("ptype"+j,i).equals("3")){%> readonly style="width:30px;border-color:black;border-width:1px" <%}else{ %>style="width:30px;background:yellow"<%} %>  onBlur="javascript:goConfirm();"></td>
							</tr>
							<tr>
								<td colspan=2><input type="text" size="1" maxlength="8" name="p_cal_ngak<%=j %>[]" readonly style="width:30px;border-color:black;border-width:1px"></td>
							</tr>
							</table>
						</div>
						</td>
						<td class="tableline11">
						<div align="center">
							<table width=100%>
							<tr>
								<td><input type="text" size="1" maxlength="3" name="p_njupoint<%=j %>[]" value="<%=recordList.getString("njupoint"+j,i) %>" <%if(recordList.getString("ptype"+j,i).equals("0") || recordList.getString("ptype"+j,i).equals("3")){%> readonly style="width:30px;border-color:black;border-width:1px" <%}else{ %>style="width:30px;background:yellow"<%} %>  onBlur="javascript:goConfirm();"></td>
								<td><input type="text" size="1" maxlength="5" name="p_njuweight<%=j %>[]" value="<%=recordList.getString("njuweight"+j,i) %>" <%if(recordList.getString("ptype"+j,i).equals("0") || recordList.getString("ptype"+j,i).equals("3")){%> readonly style="width:30px;border-color:black;border-width:1px" <%}else{ %>style="width:30px;background:yellow"<%} %> onBlur="javascript:goConfirm();"></td>
							</tr>
							<tr><td colspan="2"><input type="text" size="1" maxlength="8" name="p_cal_nju<%=j %>[]" readonly style="width:30px;border-color:black;border-width:1px"></td>
							</tr>
							</table>
						</div>
						</td>				
			<%	}
				} %>
				<td class="tableline11"><div align="center"><input type=text size=3 maxlength=5 name="p_reportpoint[]" value="<%=recordList.getString("reportpoint",i) %>" <%=recordList.getString("readReport",i) %> onBlur="javascript:goConfirm();"></div></td>
				<td class="tableline11"><div align="center"><input type=text size=3 maxlength=5 name="p_steppoint[]" value="<%=recordList.getString("steppoint",i) %>" <%=recordList.getString("readSteppoint",i) %> onBlur="javascript:goConfirm();"></div></td>
				<td class="tableline11"><div align="center"><input type=text size=3 maxlength=5 name="p_grastep[]" value="<%=recordList.getString("grastep",i) %>" <%=recordList.getString("readGrastep",i) %> onBlur="javascript:goConfirm();"></div></td>
				<!-- 
				<td class="tableline11"><div align="center"><input type=text size=3 maxlength=5 name="p_quizpoint[]" value="<%=recordList.getString("quizpoint",i) %>" <%=recordList.getString("readQuizpoint",i) %> onBlur="javascript:goConfirm();"></div></td>
				<td class="tableline11"><div align="center"><input type=text size=3 maxlength=5 name="p_graquiz[]" value="<%=recordList.getString("graquiz",i) %>" <%=recordList.getString("readGraquiz",i) %> onBlur="javascript:goConfirm();"></div></td>
				 -->
				<td class="tableline11"><div align="center"><input type=text size=3 maxlength=5 name="p_totpoint[]" value="<%=recordList.getString("totpoint",i) %>" readonly style="width:30px;border-color:black;border-width:1px" onBlur="javascript:goConfirm();"></div></td>
			</tr>
			<%}%>
			<tr bgcolor="#FFFFFF"> 
				<td class="tableline11" colspan=2><div align="center"><font color=red>일반과목 평가항목별 총점</font></div></td>
				<td class="tableline11"><div align="center"><input type=text size=6 name="p_summgakpoint" readonly style="width:30px;border-color:black;border-width:1px"></div></td>
				<td class="tableline11"><div align="center"><input type=text size=6 name="p_summjupoint" readonly style="width:30px;border-color:black;border-width:1px"></div></td>
				<td class="tableline11"><div align="center"><input type=text size=6 name="p_sumlgakpoint" readonly style="width:30px;border-color:black;border-width:1px"></div></td>
				<td class="tableline11"><div align="center"><input type=text size=6 name="p_sumljupoint" readonly style="width:30px;border-color:black;border-width:1px"></div></td>
			<%if(nevalCnt != 0){ 
					for(int j=1;j<=nevalCnt;j++){%>
					<td class="tableline11"><div align="center"><input type="text" size="3" name="p_sumngakpoint<%=j %>" readonly style="width:30px;border-color:black;border-width:1px"></div></td>
					<td class="tableline11"><div align="center"><input type=text size=3 name="p_sumnjupoint<%=j %>" readonly style="width:30px;border-color:black;border-width:1px"></div></td>
					<%}
				} %>
				<td class="tableline11"><div align="center"><input type="text" size="3" name="p_sumreportpoint" readonly style="width:30px;border-color:black;border-width:1px"></div></td>
				<td class="tableline11"><div align="center"><input type="text" size="3" name="p_sumsteppoint" readonly style="width:30px;border-color:black;border-width:1px"></div></td>
				<td class="tableline11"><div align="center">&nbsp;</div></td>
				<!-- 
				<td class="tableline11"><div align="center"><input type="text" size="3" name="p_sumquizpoint" readonly style="width:30px;border-color:black;border-width:1px"></div></td>
				<td class="tableline11"><div align="center">&nbsp;</div></td>
				 -->
				<td class="tableline11"><div align="center"><input type="text" size="3" name="p_sumtotpoint" readonly style="width:30px;border-color:black;border-width:1px"></div></td>
			</tr>
			</table>
			
			<!-- space --><table width="100%" height="30"><tr><td></td></tr></table>
			
			<!--[s] 특수과목 리스트  -->
			<table width="90%" border="0" cellpadding="0" cellspacing="0" bgcolor="E5E5E5">
			<tr bgcolor="FFFFFF">
				<td colspan="100%"><h2 class="h2" align="left"><img src="../images/bullet003.gif"> 특수과목</h2></td>
			</tr>
			<tr bgcolor="#375694"> 
				<td height="2" colspan="20"></td>
			</tr>
			<tr height="28" bgcolor="#5071B4">	
				<td align="center" class="tableline11 white"><strong>과목명</strong></td>
				<td align="center" class="tableline11 white"><strong>평가점수</strong></td>				
			</tr>
			<%if(!srecordList.isEmpty()){
				for(int k=0;k<srecordList.keySize("subj");k++){%>
					<input type="hidden" name="p_subj2[]" value="<%=srecordList.getString("subj",k) %>">
					<tr bgcolor="#FFFFFF"> 
						<td class="tableline11"><div align="center"><%=srecordList.getString("lecnm",k) %></div></td>
						<td class="tableline11"><div align="center"><input type=text size=5 maxlength=5 name="p_totpoint2[]" style="background:yellow" value="<%=srecordList.getString("totpoint",k) %>" onBlur="javascript:goConfirm();" ></div></td>
					</tr>
			<%} 
			}%>
			<tr bgcolor="#FFFFFF"> 
				<td class="tableline11"><div align="center"><font color=red>특수과목 총점</font></div></td>
				<td class="tableline11"><div align="center"><input type=text size=5 name="p_sumtotpoint2" readonly  style="border-color:black;border-width:1px"></div></td>
			</tr>
			</table>
						
			<!--//[e] 리스트  -->
			<div class="space01"></div>
			
			<table width="90%" border="0" cellpadding="0" cellspacing="0" bgcolor="E5E5E5">
			<tr bgcolor="FFFFFF">
				<td colspan="100%"><h2 class="h2" align="left"><img src="../images/bullet003.gif"> 과제물</h2></td>
			</tr>
			<tr bgcolor="#375694"> 
				<td height="2" colspan="100%"></td>
			</tr>			
		<%if(reprecord.getString("reportYn").equals("Y")){ %>
			<tr height="28" bgcolor="#5071B4">				
				<td align="center" class="tableline11 white" colspan="3">과제물</td>
				<td align="center" class="tableline11 white"  colspan="2">
					과제물총점수
					<input type="text" name="sp_reportpoint" style="background:yellow" value="<%=reprecord.getString("reportpoint") %>" size="3" maxlength="3" onBlur="javascript:goConfirm();">
					점, <a href="javascript:goRepcnt();"><font color="white">회수설정</font></a>
					<select name="spreport_cnt">
							<%=reprecord.getString("spreportCntopt") %>
					</select>
				</td>
			</tr>
			<tr height="28" bgcolor="#5071B4">		
				<td align="center" class="tableline11 white" >회수</td>
				<td align="center" class="tableline11 white" >반명</td>
				<td align="center" class="tableline11 white" >등급수</td>
				<td align="center" class="tableline11 white" >A등급(만점점수)</td>
				<td align="center" class="tableline11 white" >등급수정</td>
			</tr>
			<%if(!reportList.isEmpty()){ 
					for(int i=0;i<reportList.keySize("classno");i++){%>
						<tr bgcolor="#FFFFFF"> 
							<input type="hidden" name="rp_class" value="<%=reportList.getString("class",i) %>">
							<%if(!reportList.getString("rowspan",i).equals("0")){ %>
							<td class="tableline11" rowspan="<%=reportList.getString("rowspan",i) %>" ><div align="center"><%=reportList.getString("dates",i) %>회</div></td>
							<%} %>
							<td class="tableline11"><div align="center"><%=reportList.getString("classnm",i) %></div></td>
							<td class="tableline11"><div align="center"><%=reportList.getString("grdCnt",i) %></div></td>
							<td class="tableline11"><div align="center"><%=reportList.getString("apoint",i) %></div></td>
							<td class="tableline11"><div align="center">
							<%if(reportList.getString("grdCnt",i).equals("")){ %>
									<INPUT TYPE="button" value='등록' class='boardbtn1' onClick="javascript:go_gardePop('/subjMgr/report.do?mode=gradeList&grcode=<%=requestMap.getString("commGrcode")%>&grseq=<%=requestMap.getString("commGrseq")%>&dates=<%=reportList.getString("dates",i) %>&classno=<%=reportList.getString("classno",i) %>&subj=SUB1000025');">
							<%}else{ %>							
									<INPUT TYPE="button" value='수정' class='boardbtn1' onClick="javascript:go_gardePop('/subjMgr/report.do?mode=gradeList&grcode=<%=requestMap.getString("commGrcode")%>&grseq=<%=requestMap.getString("commGrseq")%>&dates=<%=reportList.getString("dates",i) %>&classno=<%=reportList.getString("classno",i) %>&subj=SUB1000025');">
							<%} %>
							</div></td>
						</tr>
				<%} 
				}else{%>
				<tr bgcolor="#FFFFFF"> 
					<td height=25 bgcolor="#FFFFFF" colspan="100%"><div align="center">출제된 과제물이 없습니다.</div></td>
				</tr>
			<%} 
		}else{%>
			<tr bgcolor="#FFFFFF"> 
				<input type=hidden name="sp_reportpoint" value="0"><input type=hidden name="spreport_cnt" value="0">
				<td height=25 bgcolor="#FFFFFF" colspan="100%"><div align="center">등록된 과제물과목이 없습니다.</div></td>
			</tr>
		<%} %>
			<!-- 테이블하단 버튼   -->						
			<tr bgcolor="#FFFFFF">
				<td height="20"  colspan="100%"></td>
			</tr>
			<tr>
				<td colspan="100%">
					<table class="search01">
					<tr>
						<td class="cen" align="center">
							현재입력하신 총점(일반과목+특수과목+과제물)은
							<input type="text" size="3" name="p_sumtotal" readonly style="border-color:black;border-width:1px">
							점 입니다
						</td>
					</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td height="20" colspan="100%" bgcolor="#FFFFFF"></td>
			</tr>
			<tr>
				<td class="right" align="center" bgcolor="#FFFFFF" colspan="100%">
					<input type="button" value="저장" onclick="go_action('edit');" class="boardbtn1">
				</td>
			</tr>
			</table>
			<!--//[e] 리스트  -->	
			
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
<script language=javascript>
	// 변수선언
	mgakpointObj = document.getElementsByName('p_mgakpoint[]');
	mgakweightObj	= document.getElementsByName('p_mgakweight[]');
	mjupointObj = document.getElementsByName('p_mjupoint[]');
	mjuweightObj	= document.getElementsByName('p_mjuweight[]');
	lgakpointObj = document.getElementsByName('p_lgakpoint[]');
	lgakweightObj	= document.getElementsByName('p_lgakweight[]');
	ljupointObj = document.getElementsByName('p_ljupoint[]');
	ljuweightObj	= document.getElementsByName('p_ljuweight[]');

	if (<%=nevalCnt%> >=1) {
		ngakpoint1Obj = document.getElementsByName('p_ngakpoint1[]');
		ngakweight1Obj	= document.getElementsByName('p_ngakweight1[]');
		njupoint1Obj = document.getElementsByName('p_njupoint1[]');
		njuweight1Obj	= document.getElementsByName('p_njuweight1[]');
	}
	
	if (<%=nevalCnt%>>=2) {
		ngakpoint2Obj = document.getElementsByName('p_ngakpoint2[]');
		ngakweight2Obj	= document.getElementsByName('p_ngakweight2[]');
		njupoint2Obj = document.getElementsByName('p_njupoint2[]');
		njuweight2Obj	= document.getElementsByName('p_njuweight2[]');
	}
	
	if (<%=nevalCnt%>>=3) {
		ngakpoint3Obj = document.getElementsByName('p_ngakpoint3[]');
		ngakweight3Obj	= document.getElementsByName('p_ngakweight3[]');
		njupoint3Obj = document.getElementsByName('p_njupoint3[]');
		njuweight3Obj	= document.getElementsByName('p_njuweight3[]');
	}
	
	if (<%=nevalCnt%>>=4) {
		ngakpoint4Obj = document.getElementsByName('p_ngakpoint4[]');
		ngakweight4Obj	= document.getElementsByName('p_ngakweight4[]');
		njupoint4Obj = document.getElementsByName('p_njupoint4[]');
		njuweight4Obj	= document.getElementsByName('p_njuweight4[]');
	}
	
	if (<%=nevalCnt%>>=5) {
		ngakpoint5Obj = document.getElementsByName('p_ngakpoint5[]');
		ngakweight5Obj	= document.getElementsByName('p_ngakweight5[]');
		njupoint5Obj = document.getElementsByName('p_njupoint5[]');
		njuweight5Obj	= document.getElementsByName('p_njuweight5[]');
	}

	// 리포트점수
	reportpointObj	= document.getElementsByName('p_reportpoint[]');
	// 진도율점수
	steppointObj	= document.getElementsByName('p_steppoint[]');
	// 차시평가점수
	//quizpointObj	= document.getElementsByName('p_quizpoint[]');
	cal_mgakObj	= document.getElementsByName('p_cal_mgak[]');
	cal_mjuObj	= document.getElementsByName('p_cal_mju[]');
	cal_lgakObj	= document.getElementsByName('p_cal_lgak[]');
	cal_ljuObj	= document.getElementsByName('p_cal_lju[]');
	
	if (<%=nevalCnt%> >=1) {
		cal_ngak1Obj	= document.getElementsByName('p_cal_ngak1[]');
		cal_nju1Obj	= document.getElementsByName('p_cal_nju1[]');
	}
	
	if (<%=nevalCnt%>>=2) {
		cal_ngak2Obj	= document.getElementsByName('p_cal_ngak2[]');
		cal_nju2Obj	= document.getElementsByName('p_cal_nju2[]');
	}
	
	if (<%=nevalCnt%>>=3) {
		cal_ngak3Obj	= document.getElementsByName('p_cal_ngak3[]');
		cal_nju3Obj	= document.getElementsByName('p_cal_nju3[]');
	}
	
	if (<%=nevalCnt%>>=4) {
		cal_ngak4Obj	= document.getElementsByName('p_cal_ngak4[]');
		cal_nju4Obj	= document.getElementsByName('p_cal_nju4[]');
	}
	
	if (<%=nevalCnt%> >=5) {
		cal_ngak5Obj	= document.getElementsByName('p_cal_ngak5[]');
		cal_nju5Obj	= document.getElementsByName('p_cal_nju5[]');
	}

	totpointObj	= document.getElementsByName('p_totpoint[]');
	totpoint2Obj	= document.getElementsByName('p_totpoint2[]');
	
	lec_typeObj	= document.getElementsByName('p_lec_type[]');
	ref_subjObj	= document.getElementsByName('p_ref_subj[]');

	onLoad=goConfirm();


	function goRepcnt(){
		
		var repcnt ='';
		
		var f = document.pform;
	
		repcnt = f.spreport_cnt.options[f.spreport_cnt.selectedIndex].value;
			if(confirm("과제물 출제 회수를 "+ repcnt +"회 로 지정하시겠습니까?")) {
			
			$("mode").value = "repcntEdit";
	
			f.action = "/evalMgr/evalItem.do";
			f.submit();
		}
	}
</script>