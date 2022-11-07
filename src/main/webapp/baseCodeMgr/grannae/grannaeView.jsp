<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%  
// prgnm : 시스템관리자 > 과정/콘텐츠관리 > 기초코드관리 > 교육계획 보기.
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


	//과정 정보
	DataMap grRowMap = (DataMap)request.getAttribute("GR_ROW_DATA");
	grRowMap.setNullToInitialize(true);

	//교육계획 상세(TB_GRANNAE)
	DataMap grannaeRowMap = (DataMap)request.getAttribute("GRANNAE_ROW_DATA");
	grannaeRowMap.setNullToInitialize(true);

	//교육계획 상세 소양/직무/행정 리스트(TB_GRANNAE2)
	DataMap grannae2ListMap = (DataMap)request.getAttribute("GRANNAE2_LIST_DATA");
	grannae2ListMap.setNullToInitialize(true);

	//과정 기수 정보.(기간별 인원 및 교육기간)
	DataMap grSeqMap = (DataMap)request.getAttribute("GRSEQ_ROW_DATA");
	grSeqMap.setNullToInitialize(true);


	String soyangStr = ""; //소양
	int soyangCnt = 0;
	String jikmuStr = ""; //직무
	int jikmuCnt = 0;
	String etcStr = ""; //행정/기타
	int etcCnt = 0;

	//소계변수.
	float soyangSum1 = 0.f, soyangSum2 = 0.f, soyangSum3 = 0.f;
	float jikmuSum1 = 0.f, jikmuSum2 = 0.f, jikmuSum3 = 0.f;
	float etcSum1 = 0.f, etcSum2 = 0.f, etcSum3 = 0.f;

	
	for(int i=0; i < grannae2ListMap.keySize("grcode"); i++){

		//소양분야
		if(grannae2ListMap.getInt("annaeGubun", i) == 1){

			soyangStr += "<tr align=center bgcolor='F7F7F7'>";
			soyangStr += "<td align=left>&nbsp;" + grannae2ListMap.getString("annaeTitle", i) + "</td>";
			soyangStr += "<td>&nbsp;" + grannae2ListMap.getString("title1Sub1", i) + "</td>";
			soyangStr += "<td>&nbsp;" + grannae2ListMap.getString("title1Sub2", i) + "</td>";
			soyangStr += "<td>&nbsp;" + grannae2ListMap.getString("title1Sub3", i) + "</td>";
			soyangStr += "<td>&nbsp;" + grannae2ListMap.getString("title1Sub4", i) + "</td>";
			soyangStr += "</tr>";

			//소계내기위해.
			soyangSum1 += Float.parseFloat(Util.getValue(grannae2ListMap.getString("title1Sub1", i), "0"));
			soyangSum2 += Float.parseFloat(Util.getValue(grannae2ListMap.getString("title1Sub2", i), "0"));
			soyangSum3 += Float.parseFloat(Util.getValue(grannae2ListMap.getString("title1Sub3", i), "0"));

			soyangCnt++;

		}

		//직무
		if(grannae2ListMap.getInt("annaeGubun", i) == 2){

			jikmuStr += "<tr align=center bgcolor='F7F7F7'>";
			jikmuStr += "<td align=left>&nbsp;" + grannae2ListMap.getString("annaeTitle", i) + "</td>";
			jikmuStr += "<td>&nbsp;" + grannae2ListMap.getString("title1Sub1", i) + "</td>";
			jikmuStr += "<td>&nbsp;" + grannae2ListMap.getString("title1Sub2", i) + "</td>";
			jikmuStr += "<td>&nbsp;" + grannae2ListMap.getString("title1Sub3", i) + "</td>";
			jikmuStr += "<td>&nbsp;" + grannae2ListMap.getString("title1Sub4", i) + "</td>";
			jikmuStr += "</tr>";

			//소계내기위해.
			jikmuSum1 += Float.parseFloat(Util.getValue(grannae2ListMap.getString("title1Sub1", i), "0"));
			jikmuSum2 += Float.parseFloat(Util.getValue(grannae2ListMap.getString("title1Sub2", i), "0"));
			jikmuSum3 += Float.parseFloat(Util.getValue(grannae2ListMap.getString("title1Sub3", i), "0"));

			jikmuCnt++;

		}

		//행정기타
		if(grannae2ListMap.getInt("annaeGubun", i) == 3){

			etcStr += "<tr align=center bgcolor='F7F7F7'>";
			etcStr += "<td align=left>&nbsp;" + grannae2ListMap.getString("annaeTitle", i) + "</td>";
			etcStr += "<td>&nbsp;" + grannae2ListMap.getString("title1Sub1", i) + "</td>";
			etcStr += "<td>&nbsp;" + grannae2ListMap.getString("title1Sub2", i) + "</td>";
			etcStr += "<td>&nbsp;" + grannae2ListMap.getString("title1Sub3", i) + "</td>";
			etcStr += "<td>&nbsp;" + grannae2ListMap.getString("title1Sub4", i) + "</td>";
			etcStr += "</tr>";

			//소계내기위해.
			etcSum1 += Float.parseFloat(Util.getValue(grannae2ListMap.getString("title1Sub1", i), "0"));
			etcSum2 += Float.parseFloat(Util.getValue(grannae2ListMap.getString("title1Sub2", i), "0"));
			etcSum3 += Float.parseFloat(Util.getValue(grannae2ListMap.getString("title1Sub3", i), "0"));

			etcCnt++;

		}

	}
	

%>

<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->

<script language="JavaScript" type="text/JavaScript">
<!--


//리스트
function go_list(){

	$("mode").value = "list";
	$("qu").value = "";

	pform.action = "/baseCodeMgr/grannae.do";
	pform.submit();

}


//수정
function go_modify(){

	$("mode").value = "form";
	$("qu").value = "update";

	pform.action = "/baseCodeMgr/grannae.do";
	pform.submit();

}
 



//출력하기.
function go_print() {
	popAI("http://<%= Constants.AIREPORT_URL %>/report/test/report_18.jsp?p_grcode=<%=requestMap.getString("grcode")%>&p_year=<%=requestMap.getString("year")%>");
}

//로딩시.
onload = function()	{

	//소양분야
	var obj1= $("A1_1");
	var obj2= $("A1_2");
	var obj3= $("A1_3");

	var sum1 = parseFloat( <%=soyangSum1%> );
	var sum2 = parseFloat( <%=soyangSum2%> );
	var sum3 = parseFloat( <%=soyangSum3%> );

	obj1.innerText= sum1;
	obj2.innerText= sum2;
	obj3.innerText= sum3;


	//직무분야
	obj1= $("A2_1");
	obj2= $("A2_2");
	obj3= $("A2_3");
	sum1= 0; sum2= 0; sum3= 0;

	sum1 = parseFloat( <%=jikmuSum1%> );
	sum2 = parseFloat( <%=jikmuSum2%> );
	sum3 = parseFloat( <%=jikmuSum3%> );

	obj1.innerText= sum1;
	obj2.innerText= sum2;
	obj3.innerText= sum3;


	//행정기타
	obj1= $("A3_1");
	obj2= $("A3_2");
	obj3= $("A3_3");
	sum1= 0; sum2= 0; sum3= 0;

	sum1 = parseFloat( <%=etcSum1%> );
	sum2 = parseFloat( <%=etcSum2%> );
	sum3 = parseFloat( <%=etcSum3%> );

	obj1.innerText= sum1;
	obj2.innerText= sum2;
	obj3.innerText= sum3;


	for(var i=1; i<=3; i++){
		sum=0;
		var obj= $("T"+i);
		for(var j=1; j<=3; j++){
			var tmpObj = $("A"+j+'_'+i);
			if( tmpObj.innerText != '' & !isNaN(tmpObj.innerText)){
				sum += parseFloat(tmpObj.innerText, 10);
			}
		}	
		obj.innerHTML= "<B>"+ sum +"</B>";
	}

}

//-->
</script>
<script language="JavaScript" src="/AIViewer/AIScript.js"></script>

<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<form id="pform" name="pform" method="post">
<input type="hidden" name="menuId"				value="<%=requestMap.getString("menuId")%>">
<input type="hidden" name="mode"				value="<%=requestMap.getString("mode")%>">
<input type="hidden" name="currPage"			value='<%=requestMap.getString("currPage")%>'>
<input type="hidden" name="searchKey"			value='<%=requestMap.getString("searchKey")%>'>
<input type="hidden" name="searchValue"			value='<%=requestMap.getString("searchValue")%>'>

<input type="hidden" name="qu"					value='<%=requestMap.getString("qu")%>'>
<input type="hidden" name="grcode"				value='<%=requestMap.getString("grcode")%>'>
<input type="hidden" name="year"				value='<%=requestMap.getString("year")%>'>

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


			<!--[s] Contents Form  -->
			<table cellspacing="0" cellpadding="0" border="0" width="100%" class="contentsTable">
				<tr>
					<td>
						<!---[s] content -->

						<!-- space --><table width="100%" height="10"><tr><td></td></tr></table>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td>
									<table width="100%" border="0" cellpadding="1" cellspacing="1" bgcolor="#D6DBE5">
										<tr bgcolor="#FFFFFF">
											<td height="28" class="tableline11 dkblue" bgcolor="#E4EDFF" width="15%" align="center"><strong>과정분류</strong></td>
											<td class="tableline21" align="left" width="35%">&nbsp;
												<%=grRowMap.getString("mcodeName")%> 
											</td>
											<td height="28" class="tableline11 dkblue" bgcolor="#E4EDFF" width="15%" align="center"><strong>상세분류</strong></td>
											<td class="tableline21" align="left" width="35%">&nbsp;
												<%=grRowMap.getString("scodeName")%> 
											</td>
										</tr>
										<tr bgcolor="#FFFFFF">
											<td height="28" class="tableline11 dkblue" bgcolor="#E4EDFF" align="center"><strong>과정명</strong></td>
											<td class="tableline21" align="left" width="75%" colspan="3">&nbsp;
												<%=grRowMap.getString("grcodenm")%>
											</td>
										</tr>

										<tr bgcolor="#FFFFFF">
											<td height="28" class="tableline11 dkblue" bgcolor="#E4EDFF" align="center"><strong>교육목표</strong></td>
											<td class="tableline21" align="left" width="75%" colspan="3">&nbsp;
												<%=grannaeRowMap.getString("goal")%>
											</td>
										</tr>

										<tr bgcolor="#FFFFFF">
											<td height="28" class="tableline11 dkblue" bgcolor="#E4EDFF" align="center"><strong>교육대상</strong></td>
											<td class="tableline21" align="left" width="75%" colspan="3">&nbsp;
												<%=grannaeRowMap.getString("target")%>
											</td>
										</tr>

										<tr bgcolor="#FFFFFF">
											<td height="28" class="tableline11 dkblue" bgcolor="#E4EDFF" align="center"><strong>교육인원</strong></td>
											<td class="tableline21" align="left" width="75%" colspan="3">
											<%
												//개설된 차수의 교육인원
												for(int i=0; i < grSeqMap.keySize("grseq"); i++)
													out.print("&nbsp;&nbsp;제 "+grSeqMap.getInt("grseq",i)+" 기 "+grSeqMap.getString("tseat",i)+" 명<br>");
											%>
											</td>
										</tr>

										<tr bgcolor="#FFFFFF">
											<td height="28" class="tableline11 dkblue" bgcolor="#E4EDFF" align="center"><strong>교육기간</strong></td>
											<td class="tableline21" align="left" width="75%" colspan="3">
											<%
												//개설된 차수의 교육기간
												for(int i=0; i < grSeqMap.keySize("grseq"); i++)
													out.print("&nbsp;&nbsp;제 "+grSeqMap.getInt("grseq",i)+" 기 "+grSeqMap.getString("sdate",i)+" ~ "+grSeqMap.getString("edate",i)+"<br>");
												
											%>
											</td>
										</tr>

										<tr bgcolor="#FFFFFF">
											<td height="28" class="tableline11 dkblue" bgcolor="#E4EDFF" align="center"><strong>교육운영</strong></td>
											<td class="tableline21" align="left" width="75%" colspan="3">&nbsp;
												<%=grannaeRowMap.getString("yunyoung")%>
											</td>
										</tr>

										<tr bgcolor="#FFFFFF">
											<td height="28" class="tableline11 dkblue" bgcolor="#E4EDFF" align="center"><strong>교육편성</strong></td>
											<td class="tableline21" align="left" width="75%" colspan="3">


												<!-- 교육 편성 폼 : 시작 -->
												<table width="98%" border="0" cellspacing="02" cellpadding="02" >
													<tr align=center  bgcolor="#e0ffff">
														<td width="10%" rowspan="2">구분</td>
														<td width="15%" rowspan="2">계</td>
														<td width="15%" rowspan="2">소양분야</td>
														<td width="40%" colspan="3" >직무분야</td>
														<td width="20%" rowspan="2">행정및기타</td>
													</tr>

													<tr align=center bgcolor="#87cefa">
														<td>소계</td>
														<td>직무공통</td>
														<td>직무전문</td>
													</tr>
													<tr align=center  bgcolor="#F7F7F7">
														<td bgcolor='#e0ffff'>시간</td>
														<td><%=grannaeRowMap.getFloat("sigange")%></td>
														<td><%=grannaeRowMap.getFloat("sibunya")%></td>
														<td><%=grannaeRowMap.getFloat("sisoge")%></td>
														<td><%=grannaeRowMap.getFloat("sicommon")%></td>
														<td><%=grannaeRowMap.getFloat("sijunmun")%></td>
														<td><%=grannaeRowMap.getFloat("sijunmun")%></td>
													</tr>
													<tr align=center  bgcolor="#F7F7F7">
														<td bgcolor='#e0ffff'>비율</td>
														<td><%=grannaeRowMap.getString("rategange")%></td>
														<td><%=grannaeRowMap.getString("ratebunya")%></td>
														<td><%=grannaeRowMap.getString("ratesoge")%></td>
														<td><%=grannaeRowMap.getString("ratecommon")%></td>
														<td><%=grannaeRowMap.getString("ratejunmun")%></td>
														<td><%=grannaeRowMap.getString("rateetc")%></td>
													</tr>
												</table>
												<!-- 교육 편성 폼 : 끝 -->

											</td>
										</tr>


										<tr bgcolor="#FFFFFF">
											<td height="28" width="99%" class="tableline21 " align="center" colspan="100%" >
						
											
												<!-- 교육 편성 폼 : 시작 -->
												<table width="100%" border="0" cellspacing="02" cellpadding="02" >
													<tr align="center"  bgcolor="#e0ffff">
														<td width="10%" rowspan=2>구분</td>
														<td width="30%" rowspan=2>과목</td>
														<td width="40%" colspan=3 >시간</td>
														<td width="20%" rowspan=2>비고</td>
													</tr>
													<tr align="center" bgcolor="#87cefa">
														<td width="16%">계</td>
														<td width="16%">강의</td>
														<td width="16%">참여식</td>
													</tr>
													<tr align="center" bgcolor="F7F7F7">
														<td colspan=2>합계</td>
														<td id=T1></td>
														<td id=T2></td>
														<td id=T3></td>
														<td></td>
													</tr>
													
													<!-- 소양분야 : 시작 -->
													<tr align=center bgcolor="F7F7F7">
														<td rowspan='<%=soyangCnt+1%>'>소양분야</td>
														<td>소계</td>
														<td id=A1_1></td>
														<td id=A1_2></td>
														<td id=A1_3></td>
														<td></td>
													</tr>
													<%=soyangStr%>
													<!-- 소양분야 : 끝 -->


													<!-- 직무분야 : 시작 -->
													<tr align=center bgcolor="F7F7F7">
														<td rowspan=<%=jikmuCnt+1%>>직무분야</td>
														<td>소계</td>
														<td id=A2_1></td>
														<td id=A2_2></td>
														<td id=A2_3></td>
														<td></td>
													</tr>
													<%=jikmuStr%>
													<!-- 직무분야 : 끝 -->
													
													<!-- 행정기타 : 시작 -->
													<tr align=center bgcolor="F7F7F7">
														<td rowspan=<%=etcCnt+1%>>행정기타</td>
														<td>소계</td>
														<td id=A3_1></td>
														<td id=A3_2></td>
														<td id=A3_3></td>
														<td></td>
													</tr>
													<%=etcStr%>
													<!-- 행정기타 : 끝 -->


												</table>
												<!-- 교육 편성 폼 : 끝 -->

											</td>
										</tr>

									</table>


								</td>
							</tr>

						</table>

						<!-- space --><table width="100%" height="10"><tr><td></td></tr></table>
						<table width="100%" border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td width="100%" align="right">
									<input type="button" class="boardbtn1" value=' 출력 ' onClick="go_print();">
									<input type="button" class="boardbtn1" value=' 수정 ' onClick="go_modify();" >
									<input type="button" class="boardbtn1" value=' 목록 ' onClick="go_list();" >
								</td>
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

<script language="JavaScript">
//AI Report
document.write(tagAIGeneratorOcx);
</script>

</body>

