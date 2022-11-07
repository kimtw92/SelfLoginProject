<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 평가 담당자 > 평가통계관리 > 평가결과보고
// date : 2008-08-01
// auth : CHJ(DUNET)
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
	DataMap resultMap = (DataMap)request.getAttribute("RESULT_DATA");
	resultMap.setNullToInitialize(true);
	DataMap resultMap2 = (DataMap)request.getAttribute("RESULT_DATA2");
	resultMap2.setNullToInitialize(true);
	DataMap jachiMap = (DataMap)request.getAttribute("JACHI_DATA");
	jachiMap.setNullToInitialize(true);
	DataMap sungjukMap = (DataMap)request.getAttribute("SUNGJUK_DATA");
	sungjukMap.setNullToInitialize(true);

	//자치회 유공자 리스트
	String jachiStr="";
	if(jachiMap.keySize("rname") > 0 ){
		for(int i=0;i<jachiMap.keySize("rname");i++){
			jachiStr +="<tr bgcolor='#FFFFFF'>";
			jachiStr +="<td class='tableline11'><div align='center'>&nbsp;"+jachiMap.getString("masGubun",i)+"</div></td>";
			jachiStr +="<td class='tableline11'><div align='center'>&nbsp;"+jachiMap.getString("eduno",i)+"</div></td>";
			jachiStr +="<td class='tableline11'><div align='center'>&nbsp;"+jachiMap.getString("deptnm",i)+"</div></td>";
			jachiStr +="<td class='tableline11'><div align='center'>&nbsp;"+jachiMap.getString("jiknm",i)+"</div></td>";
			jachiStr +="<td class='tableline11'><div align='center'>&nbsp;"+jachiMap.getString("rname",i)+"</div></td>";
			jachiStr +="<td class='tableline11'><div align='center'>&nbsp;"+jachiMap.getString("sexnm",i)+"</div></td>";
			jachiStr +="<td class='tableline11'><div align='center'>&nbsp;</div></td>";
			jachiStr +="<td class='tableline11'><div align='center'>&nbsp;</div></td>";
			jachiStr +="</tr>";
		}
	}else{
		jachiStr +="<tr bgcolor='#FFFFFF'>"; 
		jachiStr +="<td class='tableline11' colspan=15><div align='center'>검색된 내용이 없습니다.</div></td>";
		jachiStr +="</tr>";
	}
	
	//성적 우수자 리스트
	String sungjukStr="";
	if(sungjukMap.keySize("rname") > 0 ){
		for(int i=0;i<sungjukMap.keySize("rname");i++){
			sungjukStr +="<tr bgcolor='#FFFFFF'>";
			sungjukStr +="<td class='tableline11'><div align='center'>&nbsp;"+sungjukMap.getString("seqno",i)+"</div></td>";
			sungjukStr +="<td class='tableline11'><div align='center'>&nbsp;"+sungjukMap.getString("eduno",i)+"</div></td>";
			sungjukStr +="<td class='tableline11'><div align='center'>&nbsp;"+sungjukMap.getString("deptnm",i)+"</div></td>";
			sungjukStr +="<td class='tableline11'><div align='center'>&nbsp;"+sungjukMap.getString("jiknm",i)+"</div></td>";
			sungjukStr +="<td class='tableline11'><div align='center'>&nbsp;"+sungjukMap.getString("rname",i)+"</div></td>";
			sungjukStr +="<td class='tableline11'><div align='center'>&nbsp;"+sungjukMap.getString("sexnm",i)+"</div></td>";
			sungjukStr +="<td class='tableline11'><div align='center'>&nbsp;"+sungjukMap.getString("age",i)+"</div></td>";
			sungjukStr +="<td class='tableline11'><div align='center'>&nbsp;"+sungjukMap.getString("paccept",i)+"</div></td>";
			sungjukStr +="<td class='tableline11'><div align='center'>&nbsp;</div></td>";
			sungjukStr +="</tr>";
		}
	}else{
		sungjukStr +="<tr bgcolor='#FFFFFF'>"; 
		sungjukStr +="<td class='tableline11' colspan=15><div align='center'>검색된 내용이 없습니다.</div></td>";
		sungjukStr +="</tr>";
	}
%>

<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->

<script language="JavaScript" type="text/JavaScript">
<!--
	//로딩시.
	onload = function()	{
	
		//상단 Onload시 셀렉트 박스 선택.
		var commYear	= "<%= requestMap.getString("commYear") %>";
		var commGrCode	= "<%= requestMap.getString("commGrcode") %>";
		var commGrSeq	= "<%= requestMap.getString("commGrseq") %>";

		var reloading = ""; 
	
	
		/****** body 상단의 년도, 과정, 기수, 과목등의 select box가 있을경우 밑에 내용 실행. */
		getCommYear(commYear); //년도 생성.
		getCommOnloadGrCode(reloading, commYear, commGrCode);
		getCommOnloadGrSeq(reloading, commYear, commGrCode, commGrSeq);
	
	}

//-->
</script>
<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >
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
						<img src="/images/bullet003.gif" width="11" height="11" align="bottom">&nbsp;<strong>평가 결과 보고</strong>
					</td>
				</tr>
			</table>
			<!--// subTitle -->


			<!--[s] Contents Form  -->
			<table cellspacing="0" cellpadding="0" border="0" width="100%" class="contentsTable">
				<tr>
					<td>
						<!---[s] content -->
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr> 
							<td>
								<table width="100%" class="search01" align="center">			
								<tr>
									<th width="60" class="bl0">년도</th>
									<td width="150">
										<div id="divCommYear" class="commonDivLeft">										
											<select name="commYear" onChange="getCommGrCode('subj');" class="mr10">
												<option value="">**선택하세요**</option>
											</select>
										</div>
									</td>
									<th width="60">과정명</th>
									<td>				
										<div id="divCommGrCode" class="commonDivLeft">
											<select name="commGrcode" class="mr10">
												<option value="">**선택하세요**</option>
											</select>
										</div>
				
									</td>																
									<th class="bl0" width="60">기수명</th>
									<td>
										<div id="divCommGrSeq" class="commonDivLeft">
											<select name="commGrseq" class="mr10">
												<option value="">**선택하세요**</option>
											</select>
										</div>
									</td>	
									<td width="100" class="btnr" rowspan="2">
										<input type="submit" value="검색"  class="boardbtn1">
									</td>									
								</tr>
								</table>
								<table width="100%" height="30"><tr><td></td></tr></table>
								<table width="100%"  align="center">
								<h2 class="h2"><img src="../images/bullet003.gif"> 교육기간 : <span class="txt_none"><%=resultMap.getString("started") %> ~ <%=resultMap.getString("enddate") %> (<%=resultMap.getString("gap") %>)주간</span></h2>
								<div class="space01"></div>	

								<h2 class="h2"><img src="../images/bullet003.gif"> 교육구분  : <%=resultMap.getString("gubunnm") %></h2>
								<div class="space01"></div>	
		
								<h2 class="h2"><img src="../images/bullet003.gif"> 교육대상및 인원</h2>
								<h3 class="h3"><img src="../images/icon_arrow01.gif"> 대상:<span class="txt_none"> <%=resultMap.getString("tseat") %> 명</span></h3>
								<h3 class="h3"><img src="../images/icon_arrow01.gif"> 인원:<span class="txt_none"> <%=resultMap2.getString("totCnt") %> 명(남 <%=resultMap2.getString("manCnt") %>명, 여 <%=resultMap2.getString("womanCnt") %>명)</span> </h3>
								<div class="space01"></div>	
		
								<h2 class="h2"><img src="../images/bullet003.gif"> 평가결과:붙임 </h2>
								<div class="space01"></div>	
		
								<h2 class="h2"><img src="../images/bullet003.gif"> 성적결과:평균<%=resultMap2.getString("avgPaccept") %>점 </h2>
								<h3 class="h3"><img src="../images/icon_arrow01.gif"> 최고점: <span class="txt_none"><%=resultMap2.getString("maxPaccept") %></span> </h3>
								<h3 class="h3"><img src="../images/icon_arrow01.gif"> 최하점: <span class="txt_none"><%=resultMap2.getString("minPaccept") %></span></h3>
								<div class="space01"></div>
								
								<h2 class="h2"><img src="../images/bullet003.gif"> 시상</h2>
								<tr>
									<td colspan="10">
										<!-- subTitle -->
										<h3 class="h3"><img src="../images/icon_arrow01.gif"> 자치회 유공자<span class="txt_none">(격려품수여)</span> </h3>
										<!--// subTitle -->
										<div class="h5"></div>								
									</td>
								</tr>
								<tr> 
									<td>&nbsp;</td>
									<td>
										<table width="100%" border="0" cellpadding="0" cellspacing="0">
											<tr bgcolor="#375694"> 
												<td height="2" colspan="10"></td>
											</tr>
											<tr bgcolor="#5071B4"  height='28' > 
												<td  align='center' class="tableline11 white"><div align="center"><strong>구분</strong></div></td>
												<td  align='center' class="tableline11 white"><div align="center"><strong>교번</strong></div></td>
												<td  align='center' class="tableline11 white"><div align="center"><strong>소속</strong></div></td>
												<td  align='center' class="tableline11 white"><div align="center"><strong>직급</strong></div></td>
												<td  align='center' class="tableline11 white"><div align="center"><strong>성명</strong></div></td>
												<td  align='center' class="tableline11 white"><div align="center"><strong>성별</strong></div></td>
												<td  align='center' class="tableline11 white"><div align="center"><strong>격려품</strong></div></td>
												<td  align='center' class="tableline11 white"><div align="center"><strong>비고</strong></div></td>
											</tr>
											<%=jachiStr %>							
										</table>
									</td>
									<td></td>
								</tr>
								<tr>
									<td>&nbsp;</td>
									<td>&nbsp;</td>
									<td>&nbsp;</td>
								</tr>
				
								<!-- subTitle -->
								<tr>
									<td colspan="10">
										<h3 class="h3"><img src="../images/icon_arrow01.gif"> 성적우수자(시상금 수여-계좌입금)</h3>
										<div class="h5"></div>
									</td>
								</tr>
								<tr> 
									<td>&nbsp;</td>
									<td>
										<table width="100%" border="0" cellpadding="0" cellspacing="0">
											<tr bgcolor="#375694"> 
												<td height="2" colspan="10"></td>
											</tr>
											<tr bgcolor="#5071B4"  height='28' > 
												<td align='center' class="tableline11 white"><div align="center"><strong>구분</strong></div></td>
												<td  align='center' class="tableline11 white"><div align="center"><strong>교번</strong></div></td>
												<td  align='center' class="tableline11 white"><div align="center"><strong>소속</strong></div></td>
												<td  align='center' class="tableline11 white"><div align="center"><strong>직급</strong></div></td>
												<td  align='center' class="tableline11 white"><div align="center"><strong>성명</strong></div></td>
												<td  align='center' class="tableline11 white"><div align="center"><strong>성별</strong></div></td>
												<td  align='center' class="tableline11 white"><div align="center"><strong>연령</strong></div></td>
												<td  align='center' class="tableline11 white"><div align="center"><strong>성적</strong></div></td>
												<td  align='center' class="tableline11 white"><div align="center"><strong>시상금</strong></div></td>
											</tr>
				
											<tr> 
												<td class="tableline11"><div align="center">계</div></td>
												<td class="tableline11"><div align="center">&nbsp;</div></td>
												<td class="tableline11"><div align="center"><%=sungjukMap.keySize("rname") %></div></td>
												<td class="tableline11"><div align="center">&nbsp;</div></td>
												<td class="tableline11"><div align="center">&nbsp;</div></td>
												<td class="tableline11"><div align="center">&nbsp;</div></td>
												<td class="tableline11"><div align="center">&nbsp;</div></td>
												<td class="tableline11"><div align="center">&nbsp;</div></td>
												<td class="tableline11"><div align="center">&nbsp;</div></td>
											</tr>
											<%=sungjukStr%>
										</table>
									</td>
									<td></td>
								</tr>
								<tr> 
									<td>&nbsp;</td>
									<td >
										<ul class="coment01">
										  <li>성적이 동점인 경우 인천광역시 지방공무원 평가관리규정 제21조 제2항에 의거 1순위 근태 성적순, 2순위 강사평가 성적순,</li>
										  <li>3순위 자치활동에 공이 많은자 순으로 결정 4순위 연구과제평가 성적이 우수한자, 5순위 연령이 많은자.순으로 결정 </li>
										</ul>									
									</td> 
									<td>&nbsp;</td>
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
						<!---[e] content -->                        
					</td>
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

