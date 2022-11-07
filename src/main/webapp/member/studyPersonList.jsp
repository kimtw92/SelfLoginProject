<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 학적부관리 인덱스
// date : 2008-05-30
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

    //기관조회 리스트
	DataMap deptListMap = (DataMap)request.getAttribute("SELECTBOX_DATA");
	deptListMap.setNullToInitialize(true);

    //학적부 조회 리스트
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	listMap.setNullToInitialize(true);
	
	
	
	StringBuffer html =  new StringBuffer();
	
		if(requestMap.getString("process").equals("1")){
		html.append("	<tr> ");
		html.append("		<td colspan=\"3\">");
		html.append("			<table width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" bgcolor=\"E5E5E5\">");
		html.append("				<tr bgcolor=\"#375694\"> ");
		html.append("					<td height=\"2\" colspan=\"8\"></td>");
		html.append("				</tr>");
		html.append("				<tr bgcolor=\"#5071B4\"> ");
		html.append("					<td class=\"tableline11 white\" height=\"32\" width=\"60\" align=\"center\"><div align=\"center\"><strong>성명</strong></div></td>");
		html.append("					<td class=\"tableline11 white\"  align=\"center\"><div align=\"center\"><strong>주민번호</strong></div></td>");
		html.append("					<td class=\"tableline11 white\"  align=\"center\"><div align=\"center\"><strong>기관</strong></div></td>");
		html.append("					<td class=\"tableline11 white\"  align=\"center\"><div align=\"center\"><strong>직급</strong></div></td>");
		html.append("					<td class=\"tableline11 white\"  align=\"center\"><div align=\"center\"><strong>과정명<br>(기수)</strong></div></td>");
		
		html.append("					<td class=\"tableline11 white\"  align=\"center\"><div align=\"center\"><strong>수료이력<br>조회</strong></div></td>");
		html.append("					<td class=\"tableline11 white\"  align=\"center\"><div align=\"center\"><strong>학적조회</strong></div></td>");
		html.append("					<td class=\"tableline11 white\"  align=\"center\"><div align=\"center\"><strong>교육확인서</strong></div></td>");
		html.append("				</tr>");
		
			if(listMap.keySize("userno") > 0 ){
				for(int i = 0; listMap.keySize("userno") > i; i++){
					html.append("				<tr bgcolor=\"#FFFFFF\"> ");
					html.append("					<td class=\"tableline11\" height=\"28\"><div align=\"center\">"+listMap.getString("rname",i)+"</div></td>");
					html.append("					<td class=\"tableline11\"><div align=\"center\">"+listMap.getString("rresno",i)+"</div></td>");
					
					html.append("					<td class=\"tableline11\"><div align=\"center\">"+listMap.getString("rdeptnm",i)+"</div></td>");
					html.append("					<td class=\"tableline11\"><div align=\"center\">"+listMap.getString("rjiknm",i)+"</div></td>");
					
					html.append("					<td class=\"tableline11\"><div align=\"center\">"+listMap.getString("grcodenm",i)+"("+listMap.getString("grseq",i)+")"+"</div></td>");
					html.append("					<td class=\"tableline11\"><div align=\"center\"><a href=\"javascript:go_studyCompletList('studyCompletList','"+listMap.getString("userno",i)+"','"+listMap.getString("rresno",i)+"');\">수료이력</a></div></td>");
					html.append("					<td class=\"tableline11\"><div align=\"center\"><a href=\"javascript:go_studySchoolRegList('studySchoolRegList','"+listMap.getString("userno",i)+"','"+listMap.getString("rresno",i)+"');\">학적조회</a></div></td>");
					if(!listMap.getString("rgrayn",i).equals("")){
						html.append("					<td class=\"tableline21\"><div align=\"center\"><a href=\"javascript:report('"+listMap.getString("grcode",i)+"','"+listMap.getString("grseq",i)+"','"+listMap.getString("userno",i)+"','"+memberInfo.getSessNo()+"')\">교육확인서</a></div></td>");
					}else{
						html.append("					<td class=\"tableline21\"><div align=\"center\"></div></td>");						
					}
					html.append("				</tr>");
					
				}
				html.append(" <tr bgcolor=\"#375694\">");
				html.append("<td height=\"2\" colspan=\"100%\"></td>");
				html.append("</tr>");
			}else{
				html.append("					<tr bgcolor=\"#FFFFFF\"> ");
				html.append("						<td class=\"tableline21\" style=\"height:100\" colspan=8><div align=\"center\">검색된 내용이 없습니다.</div></td>");
				html.append("					</tr>");

			}
		}
		html.append("					</td>");
		html.append("					</tr>");
		html.append("					</table>");
%>

<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->



<script language="JavaScript" type="text/JavaScript">
/*********************************************************** 날짜함수 [s]******************************************************/

function go_gubunList(qu,mode){
location.href="/member/member.do?qu="+qu+"&mode="+mode+"&menuId=<%=requestMap.getString("menuId")%>";
}

function go_list(mode,process){
	
	if($("name").value == ""){
		alert("성명을 입력하십시오.");
		return false;
	}
	$("mode").value= mode;
	$("process").value=process;
	
	
	if(IsValidCharSearch($("name").value) == false){
		$("name").focus();
		return false;
	}
	
	if($("process").value == "0"){
		$("name").value="";
	}
	
	pform.action  = "/member/member.do";
	pform.submit();
	
}

//내역서를 출력 하는 이유 등록 팝업 페이지
function report(grcode, grseq, userno, sessNo){
	$("mode").value = "breakdownPop";
	$("grcode").value = grcode;
	$("grseq").value = grseq;
	$("userno").value = userno;
	$("sessNo").value = sessNo;
	$("breakDownGubun").value = "1";
	
	pform.action = "/member/member.do";
	var popup =popWin('about:blank','majorPop11', '600', '200', 'YES', 'no');
	pform.target = "majorPop11";
	pform.submit();
	pform.target = "";
	
}

//AI프로그램 
function report_pop(grcode, grseq, userno) {
 
	if (grcode =='') {
		alert('과정을 선택하세요.');
		return;
	}

	if (grseq =='') {
		alert('기수를 선택하세요.');
		return;
	}

	if (userno =='') {
		alert('올바른 유저를 선택 하세요.');
		return;
	}

	popAI('http://152.99.42.130/report/report_3.jsp?p_grcode='+grcode+'&p_grseq='+grseq+'&p_userno='+userno+'&p_yser='+grseq.substring(0, 4));
}

//상단 기관코드별 리스트 링크
function go_deptList(mode){
	location.href="/member/member.do?mode="+mode+"&menuId=<%=requestMap.getString("menuId")%>";
	
}

//상단 개인별 리스트 링크
function go_presonList(mode,process){
	location.href="/member/member.do?mode="+mode+"&menuId=<%=requestMap.getString("menuId")%>&process="+process;
}


//수료이력조회
function go_studyCompletList(mode,userno,resno){
	$("mode").value= mode;
	$("userno").value=userno;
	$("resno").value=resno;

	pform.action  = "/member/member.do";
	pform.submit();
	
}
//학적조회
function go_studySchoolRegList(mode,userno,resno){

	$("mode").value= mode;
	$("userno").value=userno;
	$("resno").value=resno;

	pform.action  = "/member/member.do";
	pform.submit();
}


onload = function(){
var grcode = "<%=requestMap.getString("grcode")%>";
var grseq = "<%=requestMap.getString("grseq")%>";
var userno = "<%=requestMap.getString("userno")%>";

	if(grcode != "" && grseq != "" && userno != ""){
		report_pop(grcode, grseq, userno)
	}
}

</script>
<script language="JavaScript" src="/AIViewer/AIScript.js"></script>

<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<form id="pform" name="pform" method="post">

<input type="hidden" name="qu">
<input type="hidden" name="mode">
<input type="hidden" name="menuId" value=<%=requestMap.getString("menuId") %>>
<!-- 유저 번호 -->
<input type="hidden" name="userno">
<!-- 유저 주민등록 번호 -->
<input type="hidden" name="resno">
<!-- 현재 페이지의 기능이 폼인지 리스트인지 확인 -->
<input type="hidden" name="process">
<!-- 수정시 필요한 데이터 -->
<input type="hidden" name="grcode">
<input type="hidden" name="grseq">
<!-- 출력내역서 구분 변수-->
<input type="hidden" name="breakDownGubun">
<!-- 세션번호 -->
<input type="hidden" name="sessNo" value="">

<Div id='popCal' style='POSITION:absolute;visibility:hidden;border:2px ridge;width:10'>
<!-- 달력 선언 -->

</DIV>
<div style="display:none">
<script language="JScript" src="/commonInc/js/popcalendar.js"></script>
</div>
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

			<!--[s] Contents Form  -->
			<table cellspacing="0" cellpadding="0" border="0" width="100%" class="contentsTable">
				<tr>
					<td>
                        <!---[s] content -->
						<!-- space --><table width="100%" height="10"><tr><td></td></tr></table>
						<table cellspacing="0" cellpadding="0" border="0" width="100%" class="">
							<tr bgcolor="#5071B4">
								<td height="2" colspan="100%"></td>
							</tr>
							<tr>
								<td>
			                        <!---[s] content -->
			
									<!-- space --><table width="100%" height="10"><tr><td></td></tr></table>
									<table width="100%" border="0" height="" cellspacing="0" cellpadding="0">
										<tr>
											<td>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr> 
														<td height="30" colspan="100%" align=center class="tableline21">
															<a href="javascript:go_deptList('studyDocList');">기관/기간별 조회</a>
															&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
															<a href="javascript:go_presonList('studyPersonList','0');"><font color=red>개인별 조회</font></a>
			
														</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td colspan="100%">
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="33%" class="tableline11">&nbsp;</td>
														<td align="center" width="100" bgcolor="#F7F7F7" colspan="" class="tableline11" >
															<strong>이 름 : </strong>
														</td>
														<td align="center" width="200" class="tableline11" >
															<input type = text size="" class="textfield " maxlength="10" onkeypress="if(event.keyCode==13){go_list('studyPersonList');return false;}" name ="name" value = "<%= requestMap.getString("name")%>" required="true!성명을 입력하십시오."> 
														</td>
														<td align="left" width="50" class="tableline21" >
															<input type="button" value="조회" class="boardbtn1" onclick="go_list('studyPersonList')" >
														</td>
														<td width="" class="tableline21">&nbsp;</td>
													</tr>
												</table>
											</td>
										</tr>
											
										<!-- space -->
										
										<tr bgcolor="#5071B4">
											<td height="2" colspan="100%"></td>
										</tr>
										<tr><td height="20"></td></tr>
								<%=html.toString() %>
										
								</table>
								
                        <!---[e] content -->
						<!-- space --><table width="100%" height="50"><tr><td></td></tr></table>													
                        
								</td>
							</tr>
							
						</table>
					<!--[e] Contents Form  -->
					</td>
				</tr>
			</table>
			</td>
		</tr>
	</table>		                            
	                            

<!--[s] bottom -->
<jsp:include page="/commonInc/include/commonAdminBottom.jsp" flush="false"/>
<!--[e] bottom -->
	
</form>
</body>
<SCRIPT LANGUAGE="JavaScript">
document.write(tagAIGeneratorOcx);
</SCRIPT>