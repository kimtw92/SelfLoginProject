<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%  
// prgnm : 시스템관리자 > 과정/콘텐츠관리 > 기초코드관리 > 교육계획 등록/수정.
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

%>

<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->

<script language="JavaScript" type="text/JavaScript">
<!--


//리스트
function go_list(){

	$("mode").value = "list";

	pform.action = "/baseCodeMgr/grannae.do";
	pform.submit();

}

//등록
function go_add(){

	$("mode").value = "exec";
	$("qu").value = "insert";

	/*9월 3일 추가자 정윤철 추가사유 시간은 int형이기 때문에 자바단에서 에러가 납니다. 그래서 꼭 값을 넣도록 하였습니다.*/
	if($("time").value > 999){
		alert("인정시간 시간입력이 잘못되었습니다. 다시 입력하여 주십시오.");
		return false;
	}
	
	if($("time").value == ""){
		alert("인정시간을 입력하여 주십시오.");
		return false;
	}
	/******************************************************************************************/

	if(NChecker(document.pform)){

		if(confirm("등록 하시겠습니까?")){
			pform.action = "/baseCodeMgr/grannae.do";
			pform.submit();
		}

	}

}

//수정
function go_modify(){

	$("mode").value = "exec";
	$("qu").value = "update";

	if(NChecker(document.pform)){
		/*9월 3일 추가자 정윤철 추가사유 시간은 int형이기 때문에 자바단에서 에러가 납니다. 그래서 꼭 값을 넣도록 하였습니다.*/
		if($("time").value > 999){
			alert("인정시간 시간입력이 잘못되었습니다. 다시 입력하여 주십시오.");
			return false;
		}
		
		if($("time").value == ""){
			alert("인정시간을 입력하여 주십시오.");
			return false;
		}
		/******************************************************************************************/
		
		if(confirm("수정 하시겠습니까?")){
			pform.action = "/baseCodeMgr/grannae.do";
			pform.submit();
		}

	}

}


//계산.
function calc( gubun, order){

	var tobj  = document.pform.elements('a['+gubun+'][title][]')
	var obj   = document.pform.elements('a['+gubun+ '][title1_sub'+order+ '][]')
	var dobj  = $('A'+gubun+'_'+order);
	var aobj  = $('T'+order);

	var sum= 0
	var flag= false
	for(var i=0; i< tobj.length; i++){
		if( tobj[i].value != '' && obj[i].value != '' & !isNaN(obj[i].value)){
			flag= true
			sum+= parseFloat( obj[i].value)
		}
	}

	if( flag){
		dobj.innerText= sum
		//전체 합계 내서 보여주는 부분 필요
		var sum=0
		for(var i=1; i<=3; i++){
			tmp= document.getElementById('A'+i+'_'+order)
			if( tmp.innerText != '' & !isNaN(tmp.innerText))
				sum+= parseFloat(tmp.innerText)
		}
		aobj.innerHTML= "<B>"+ sum +"</B>"
	}
}


function total_avg() {
  
  // 총계 구하기
  var sibunya   = parseFloat(document.pform.elements('sibunya').value);
  var sicommon  = parseFloat(document.pform.elements('sicommon').value);
  var sijunmun  = parseFloat(document.pform.elements('sijunmun').value);
  var sietc     = parseFloat(document.pform.elements('sietc').value);

  if(isNaN(sibunya)) sibunya  = 0;
  if(isNaN(sicommon)) sicommon  = 0;
  if(isNaN(sijunmun)) sijunmun  = 0;
  if(isNaN(sietc)) sietc  = 0;

  var sigange = (sibunya) + (sicommon) + (sijunmun) + (sietc);
  var sisoge  = (sicommon) + (sijunmun);

  document.pform.elements('sigange').value  = sigange;
  document.pform.elements('sisoge').value   = sisoge;

  // 비율 구하기
  
  if(sigange > 0) {
    document.pform.elements('rategange').value  = (sigange/sigange) * 100;
    document.pform.elements('ratebunya').value  = Math.round((sibunya/sigange) * 100);
    document.pform.elements('ratesoge').value   = Math.round((sisoge/sigange) * 100);
    document.pform.elements('ratecommon').value = Math.round((sicommon/sigange) * 100);
    document.pform.elements('ratejunmun').value = Math.round((sijunmun/sigange) * 100);
    document.pform.elements('rateetc').value    = Math.round((sietc/sigange) * 100);
  }

}


//로딩시.
onload = function()	{

	<%
	//수정시 합계 계산.
	if(requestMap.getString("qu").equals("update")){
		out.print("calc('1','1');");
		out.print("calc('1','2');");
		out.print("calc('1','3');");

		out.print("calc('2','1');");
		out.print("calc('2','2');");
		out.print("calc('2','3');");

		out.print("calc('3','1');");
		out.print("calc('3','2');");
		out.print("calc('3','3');");
	}
	%>

}

//-->
</script>
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
												<textarea name='goal' class="textfield" style="width:95%;height:80px"><%=grannaeRowMap.getString("goal")%></textarea>
											</td>
										</tr>

										<tr bgcolor="#FFFFFF">
											<td height="28" class="tableline11 dkblue" bgcolor="#E4EDFF" align="center"><strong>교육대상</strong></td>
											<td class="tableline21" align="left" width="75%" colspan="3">&nbsp;
												<textarea name='target' class="textfield" style="width:95%;height:80px"><%=grannaeRowMap.getString("target")%></textarea>
											</td>
										</tr>

									<%if( !requestMap.getString("qu").equals("insert") ){%>
										<tr bgcolor="#FFFFFF">
											<td height="28" class="tableline11 dkblue" bgcolor="#E4EDFF" align="center"><strong>교육인원</strong></td>
											<td class="tableline21" align="left" width="75%" colspan="3">
											<%
												String tmpStr = "";
												//개설된 차수의 교육인원
												for(int i=0; i < grSeqMap.keySize("grseq"); i++)
													tmpStr+= "&nbsp;&nbsp;제 "+grSeqMap.getInt("grseq",i)+" 기 "+grSeqMap.getString("tseat",i)+" 명<br>";

												out.print(tmpStr);
											%>
												<input type="hidden" name="inwon" value="<%=tmpStr%>">
											</td>
										</tr>

										<tr bgcolor="#FFFFFF">
											<td height="28" class="tableline11 dkblue" bgcolor="#E4EDFF" align="center"><strong>교육기간</strong></td>
											<td class="tableline21" align="left" width="75%" colspan="3">
											<%
												//개설된 차수의 교육기간
												tmpStr = "";
												for(int i=0; i < grSeqMap.keySize("grseq"); i++)
													tmpStr += "&nbsp;&nbsp;제 "+grSeqMap.getInt("grseq",i)+" 기 "+grSeqMap.getString("sdate",i)+" ~ "+grSeqMap.getString("edate",i)+"<br>";

												out.print(tmpStr);
											%>
												<input type="hidden" name="gigan" value="<%=tmpStr%>">
											</td>
										</tr>
									<%}%>

										<tr bgcolor="#FFFFFF">
											<td height="28" class="tableline11 dkblue" bgcolor="#E4EDFF" align="center"><strong>인정시간</strong></td>
											<td class="tableline21" align="left" width="75%" colspan="3">&nbsp;
												<input type="text" dataform="num!숫자만 입력해야 합니다." class="textfield" name="time" value="<%=grannaeRowMap.getString("time")%>" style="width:50">시간
											</td>
										</tr>

										<tr bgcolor="#FFFFFF">
											<td height="28" class="tableline11 dkblue" bgcolor="#E4EDFF" align="center"><strong>교육운영</strong></td>
											<td class="tableline21" align="left" width="75%" colspan="3">&nbsp;
												<textarea name='yunyoung' class="textfield" style="width:95%;height:80px"><%=grannaeRowMap.getString("yunyoung")%></textarea>
											</td>
										</tr>

										<tr bgcolor="#FFFFFF">
											<td height="28" class="tableline11 dkblue" bgcolor="#E4EDFF" align="center"><strong>교육편성</strong></td>
											<td class="tableline21" align="left" width="75%" colspan="3">&nbsp;


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
														<td><input type=text name='sigange' maxlength="10" class='textfield' style="width:50;ime-mode:disabled" value="<%=grannaeRowMap.getFloat("sigange")%>" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;" readonly></td>
														<td><input type=text name='sibunya' maxlength="10" class='textfield' style="width:50;ime-mode:disabled" value="<%=grannaeRowMap.getFloat("sibunya")%>" onFocusOut="total_avg();" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;"></td>
														<td><input type=text name='sisoge' maxlength="10" class='textfield' style="width:50;ime-mode:disabled" value="<%=grannaeRowMap.getFloat("sisoge")%>" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;" readonly></td>
														<td><input type=text name='sicommon' maxlength="10" class='textfield' style="width:50;ime-mode:disabled" value="<%=grannaeRowMap.getFloat("sicommon")%>" onFocusOut="total_avg();" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;"></td>
														<td><input type=text name='sijunmun' maxlength="10" class='textfield' style="width:50;ime-mode:disabled" value="<%=grannaeRowMap.getFloat("sijunmun")%>" onFocusOut="total_avg();" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;"></td>
														<td><input type=text name='sietc' maxlength="10" class='textfield' style="width:50;ime-mode:disabled" value="<%=grannaeRowMap.getFloat("sijunmun")%>" onFocusOut="total_avg();" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;"></td>
													</tr>
													<tr align=center  bgcolor="#F7F7F7">
														<td bgcolor='#e0ffff'>비율</td>
														<td><input type=text name='rategange' maxlength="10" class='textfield' style="width:50;ime-mode:disabled" value="<%=grannaeRowMap.getString("rategange")%>" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;"></td>
														<td><input type=text name='ratebunya' maxlength="10" class='textfield' style="width:50;ime-mode:disabled" value="<%=grannaeRowMap.getString("ratebunya")%>" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;"></td>
														<td><input type=text name='ratesoge' maxlength="10" class='textfield' style="width:50;ime-mode:disabled" value="<%=grannaeRowMap.getString("ratesoge")%>" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;"></td>
														<td><input type=text name='ratecommon' maxlength="10" class='textfield' style="width:50;ime-mode:disabled" value="<%=grannaeRowMap.getString("ratecommon")%>" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;"></td>
														<td><input type=text name='ratejunmun' maxlength="10" class='textfield' style="width:50;ime-mode:disabled" value="<%=grannaeRowMap.getString("ratejunmun")%>" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;"></td>
														<td><input type=text name='rateetc' maxlength="10"class='textfield' style="width:50;ime-mode:disabled" value="<%=grannaeRowMap.getString("rateetc")%>" onKeypress="if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;"></td>
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
													<tr align="center" bgcolor="F7F7F7">
														<td rowspan=25>소양분야</td>
														<td>소계</td>
														<td id=A1_1></td>
														<td id=A1_2></td>
														<td id=A1_3></td>
														<td></td>
													</tr>

													<script>
													var tr= " <tr align=center bgcolor='F7F7F7'> \
														<td> @ <input type=text name='a[1][title][]' id='a[1][title][]' class='textfield' style='width:80%'></td>\
														<td><input type=text name='a[1][title1_sub1][]' class='textfield' style='width:95%;ime-mode:disabled' onFocusOut=\"calc('1','1')\" onKeypress=\"if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;\"></td>\
															<td><input type=text name='a[1][title1_sub2][]' class='textfield' style='width:95%;ime-mode:disabled' onFocusOut=\"calc('1','2')\" onKeypress=\"if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;\"></td>\
															<td><input type=text name='a[1][title1_sub3][]' class='textfield' style='width:95%;ime-mode:disabled' onFocusOut=\"calc('1','3')\" onKeypress=\"if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;\"></td>\
															<td><input type=text name='a[1][title1_sub4][]' class='textfield' style='width:95%'></td>\
														</tr>"

													var str=''	
													for(var i=0; i<24; i++)
														str+= tr;

													document.write(str);

													//var title= $("a[1][title][]");
													var title=document.pform.elements('a[1][title][]');
													var sub1 = document.pform.elements('a[1][title1_sub1][]');
													var sub2 = document.pform.elements('a[1][title1_sub2][]');
													var sub3 = document.pform.elements('a[1][title1_sub3][]');
													var sub4 = document.pform.elements('a[1][title1_sub4][]');

													<%
														int tempRowCnt = 0;
														//소양분야
														for(int i=0; i < grannae2ListMap.keySize("grcode"); i++){
															if(grannae2ListMap.getInt("annaeGubun", i) == 1){
																
																out.println("title["+tempRowCnt+"].value=\""+grannae2ListMap.getString("annaeTitle", i)+"\";");
																out.println("sub1["+tempRowCnt+"].value=\""+grannae2ListMap.getString("title1Sub1", i)+"\";");
																out.println("sub2["+tempRowCnt+"].value=\""+grannae2ListMap.getString("title1Sub2", i)+"\";");
																out.println("sub3["+tempRowCnt+"].value=\""+grannae2ListMap.getString("title1Sub3", i)+"\";");
																out.println("sub4["+tempRowCnt+"].value=\""+grannae2ListMap.getString("title1Sub4", i)+"\";");
																tempRowCnt++;
															}
														}
													%>

													</script>	
													<!-- 소양분야 : 끝 -->


													<!-- 직무분야 : 시작 -->
													<tr align=center bgcolor="F7F7F7">
														<td rowspan=25>직무분야</td>
														<td>소계</td>
														<td id=A2_1></td>
														<td id=A2_2></td>
														<td id=A2_3></td>
														<td></td>
													</tr>
													<script>
													var tr= " <tr align=center bgcolor='F7F7F7'> \
															<td> @ <input type=text name='a[2][title][]' class='textfield' style='width:80%'></td> \
															<td><input type=text name='a[2][title1_sub1][]' class='textfield' style='width:95%;ime-mode:disabled' onFocusOut=\"calc('2','1')\" onKeypress=\"if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;\"></td>\
															<td><input type=text name='a[2][title1_sub2][]' class='textfield' style='width:95%;ime-mode:disabled' onFocusOut=\"calc('2','2')\" onKeypress=\"if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;\"></td>\
															<td><input type=text name='a[2][title1_sub3][]' class='textfield' style='width:95%;ime-mode:disabled' onFocusOut=\"calc('2','3')\" onKeypress=\"if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;\"></td>\
															<td><input type=text name='a[2][title1_sub4][]' class='textfield' style='width:95%'></td>\
														</tr>";
													var str='';
													for(var i=0; i<24; i++)
														str+= tr;
													document.write( str);

													var title= document.pform.elements('a[2][title][]');
													var sub1= document.pform.elements('a[2][title1_sub1][]');
													var sub2= document.pform.elements('a[2][title1_sub2][]');
													var sub3= document.pform.elements('a[2][title1_sub3][]');
													var sub4= document.pform.elements('a[2][title1_sub4][]');
													
													<%
														tempRowCnt = 0;
														//직무분야
														for(int i=0; i < grannae2ListMap.keySize("grcode"); i++){
															if(grannae2ListMap.getInt("annaeGubun", i) == 2){
																
																out.println("title["+tempRowCnt+"].value=\""+grannae2ListMap.getString("annaeTitle", i)+"\";");
																out.println("sub1["+tempRowCnt+"].value=\""+grannae2ListMap.getString("title1Sub1", i)+"\";");
																out.println("sub2["+tempRowCnt+"].value=\""+grannae2ListMap.getString("title1Sub2", i)+"\";");
																out.println("sub3["+tempRowCnt+"].value=\""+grannae2ListMap.getString("title1Sub3", i)+"\";");
																out.println("sub4["+tempRowCnt+"].value=\""+grannae2ListMap.getString("title1Sub4", i)+"\";");
																tempRowCnt++;
															}
														}
													%>


													</script>
													<!-- 직무분야 : 끝 -->
													
													<!-- 행정기타 : 시작 -->
													<tr align=center bgcolor="F7F7F7">
														<td rowspan=25>행정기타</td>
														<td>소계</td>
														<td id=A3_1></td>
														<td id=A3_2></td>
														<td id=A3_3></td>
														<td></td>
													</tr>
													<script>
													var tr= " <tr align=center bgcolor='F7F7F7'> \
															<td> @ <input type=text name='a[3][title][]' class='textfield' style='width:80%'></td> \
															<td><input type=text name='a[3][title1_sub1][]' class='textfield' style='width:95%;ime-mode:disabled'  onFocusOut=\"calc('3','1')\" onKeypress=\"if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;\"></td>\
															<td><input type=text name='a[3][title1_sub2][]' class='textfield' style='width:95%;ime-mode:disabled'  onFocusOut=\"calc('3','2')\" onKeypress=\"if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;\"></td>\
															<td><input type=text name='a[3][title1_sub3][]' class='textfield' style='width:95%;ime-mode:disabled'  onFocusOut=\"calc('3','3')\" onKeypress=\"if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;\"></td>\
															<td><input type=text name='a[3][title1_sub4][]' class='textfield' style='width:95%'></td>\
														</tr>";
													var str='';
													for(var i=0; i<3; i++)
														str+= tr;
													document.write(str);
													
													
													var title= document.pform.elements('a[3][title][]');
													var sub1= document.pform.elements('a[3][title1_sub1][]');
													var sub2= document.pform.elements('a[3][title1_sub2][]');
													var sub3= document.pform.elements('a[3][title1_sub3][]');
													var sub4= document.pform.elements('a[3][title1_sub4][]');
													

													<%
														tempRowCnt = 0;
														//행정기타
														for(int i=0; i < grannae2ListMap.keySize("grcode"); i++){
															if(grannae2ListMap.getInt("annaeGubun", i) == 3){
																
																out.println("title["+tempRowCnt+"].value=\""+grannae2ListMap.getString("annaeTitle", i)+"\";");
																out.println("sub1["+tempRowCnt+"].value=\""+grannae2ListMap.getString("title1Sub1", i)+"\";");
																out.println("sub2["+tempRowCnt+"].value=\""+grannae2ListMap.getString("title1Sub2", i)+"\";");
																out.println("sub3["+tempRowCnt+"].value=\""+grannae2ListMap.getString("title1Sub3", i)+"\";");
																out.println("sub4["+tempRowCnt+"].value=\""+grannae2ListMap.getString("title1Sub4", i)+"\";");
																tempRowCnt++;
															}
														}
													%>

													</script>
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
								<%if(requestMap.getString("qu").equals("insert")){%>
									<input type="button" class="boardbtn1" value=' 등록 ' onClick="go_add();">
								<%}else if(requestMap.getString("qu").equals("update")){%>
									<input type="button" class="boardbtn1" value=' 수정 ' onClick="go_modify();" >
								<%}%>
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
</body>

