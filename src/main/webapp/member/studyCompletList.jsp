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
	LoginCheck loginChk = new LoginCheck();
	String navigationStr = loginChk.NavigationCreate(memberInfo, navigationMap);
	////////////////////////////////////////////////////////////////////////////////////

    //리스트
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	listMap.setNullToInitialize(true);
	
	StringBuffer html =  new StringBuffer();
	
		//수료이력조회
		if(listMap.keySize("userno") > 0){
			for(int i = 0; listMap.keySize("userno") > i; i++){
				html.append("<tr bgcolor=\"#FFFFFF\"> ");
				html.append("	<td class=\"tableline11\" height=\"28\"><div align=\"center\">"+listMap.getString("grcodeniknm",i)+"</div></td>");
				html.append("	<td class=\"tableline11\"><div align=\"center\">"+listMap.getString("txtGrseq",i)+"</div></td>");
				html.append("	<td class=\"tableline11\"><div align=\"center\">"+listMap.getString("started",i)+"~"+listMap.getString("enddate",i)+"</div></td>");
				html.append("	<td class=\"tableline11\"><div align=\"center\">"+listMap.getString("tdate",i)+"</div></td>");
				html.append("	<td class=\"tableline11\"><div align=\"center\">"+listMap.getString("rdeptnm",i)+"</div></td>");
				html.append("	<td class=\"tableline11\"><div align=\"center\">"+listMap.getString("rjiknm",i)+"</div></td>");
				html.append("	<td class=\"tableline11\"><div align=\"center\">"+listMap.getString("paccept",i)+"</div></td>");
		                                                               
				html.append("	<td class=\"tableline11\"><div align=\"center\">"+listMap.getString("rgrayn",i)+"</div></td>");
				html.append("	<td class=\"tableline21\"><div align=\"center\">"+listMap.getString("rno",i)+"</div></td>");
				html.append("</tr>");
			}

		}else{
			html.append("					<tr bgcolor=\"#FFFFFF\"> ");
			html.append("						<td class=\"tableline11\" colspan=8><div align=\"center\">검색된 내용이 없습니다.</div></td>");
			html.append("					</tr>");
		}
%>

<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->



<script language="JavaScript" type="text/JavaScript">
/*********************************************************** 날짜함수 [s]******************************************************/
// 시작일자
function fnSDate(){

 result = window.showModalDialog("/commonInc/jsp/calendar.jsp","calendar", "dialogWidth:220px; dialogHeight:267px; center:yes; status:no;");
 
 if (result == -1 || result == null || result == "")   return;
 
 
 /*	기본날짜는 오늘날짜이기때문에 삭제하면은 안된다.
 if (result == "DeleteDate"){
  pform.txtStartDate.value = "";
  return;
 }*/
 
 firstList = result.split(";");
 
 if($("eDate").value != ""){
        if($("eDate").value < firstList[0]){
            //기본날짜는 오늘날짜이기때문에 삭제하면은 안된다.
	        //pform.txtEndDate.value = "";
            return;
        }
    }
 
 $("sDate").value = firstList[0];
}

// 종료일자
function fnEDate(){

	result = window.showModalDialog("/commonInc/jsp/calendar.jsp","calendar", "dialogWidth:220px; dialogHeight:267px; center:yes; status:no;");
	
	if (result == -1 || result == null || result == "")   return;
	
	/*	기본날짜는 오늘날짜이기때문에 삭제하면은 안된다.
	if (result == "DeleteDate"){
		pform.txtEndDate.value = "";
		return;
	}*/
	
	firstList = result.split(";");
	
	if($("sDate").value != ""){
	       if($("sDate").value > firstList[0]){
	           alert('종료일이 시작일보다 작습니다. 다시 입력하시기 바랍니다.');
	           //기본날짜는 오늘날짜이기때문에 삭제하면은 안된다.
	           //pform.txtEndDate.value = "";
	           return;
	       }
	   }
	   
	$("eDate").value = firstList[0];
	
}

/*********************************************************** 날 함수 [e]******************************************************/


function go_list(qu,mode){
	$("qu").value= qu;
	$("mode").value= mode;
	
	if(IsValidCharSearch($("name").value) == false){
		$("name").focus();
		return false;
	}
	
	pform.action  = "/member/member.do";
	pform.submit();
	
}

//상단 기관코드별 리스트 링크
function go_deptList(mode){
	location.href="/member/member.do?mode="+mode+"&menuId=<%=requestMap.getString("menuId")%>";
	
}

//상단 개인별 리스트 링크
function go_presonList(mode,process){
	location.href="/member/member.do?mode="+mode+"&menuId=<%=requestMap.getString("menuId")%>&process="+process;
}
</script>
<script language="JavaScript" src="/AIViewer/AIScript.js"></script>

<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<form id="pform" name="pform" method="post">

<input type="hidden" name="qu">
<input type="hidden" name="mode">
<input type="hidden" name="menuId" value=<%=requestMap.getString("menuId") %>>
<!-- 개인 리스트 조회일시 프로세서를 1로 셋시킨다 -->
<input type="hidden" name="process" value="1">
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
						<table width="100%" border="0" height="" cellspacing="0" cellpadding="0">
							<tr bgcolor="#375694">
								<td height="2" colspan="100%"></td>
							</tr>							
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
											<td align="center" width="100" class="tableline11" >
												<input type = text class="textfield" maxlength="8" name ="name" onkeypress="if(event.keyCode==13){go_list('','studyPersonList');return false;}" value = "<%= requestMap.getString("name")%>" required="true!성명을 입력하십시오."> 
											</td>
											<td align="left" width="50" class="tableline21" >
												<input type="button" value="조회" class="boardbtn1" onclick="go_list('','studyPersonList')" >
											</td>
											<td width="" class="tableline21">&nbsp;</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr bgcolor="#375694">
								<td height="2" colspan="100%"></td>
							</tr>
						</table>
						<table><tr><td height="20"></td></tr></table>
						<table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="">
							<tr>
								<td width="100%" colspan="100%">
									<table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="E5E5E5">
										<tr bgcolor="#375694">
											<td height="2" colspan="100%"></td>
										</tr>
						
										<tr bgcolor="#5071B4">
											<td class="tableline11 white" height="28" align="center"><div align="center"><strong>성명</strong></div></td>
											<td class="tableline21 white" colspan=10><div align="center"><strong><%=listMap.getString("rname") %></strong></div></td>
										</tr>
										<tr bgcolor="#5071B4">
											<td class="tableline11 white" height="28" align="center"><div align="center"><strong>주민번호</strong></div></td>
											<td class="tableline21 white" colspan=10><div align="center"><strong><%=requestMap.getString("resno") %></strong></div></td>
										</tr>
										
										<tr bgcolor="#5071B4">
											<td class="tableline11 white"  style="border-bottom-width:0px;" height="28" align="center"><div align="center"><strong>과정</strong></div></td>
											<td class="tableline11 white"  style="border-bottom-width:0px;" align="center"><div align="center"><strong>기수</strong></div></td>
											<td class="tableline11 white"  style="border-bottom-width:0px;" align="center"><div align="center"><strong>교육기간</strong></div></td>
											<td class="tableline11 white"  style="border-bottom-width:0px;" align="center"><div align="center"><strong>총학습일</strong></div></td>
											<td class="tableline11 white"  style="border-bottom-width:0px;" align="center"><div align="center"><strong>기관명</strong></div></td>
											<td class="tableline11 white"  style="border-bottom-width:0px;" align="center"><div align="center"><strong>직급</strong></div></td>
											<td class="tableline11 white"  style="border-bottom-width:0px;" align="center"><div align="center"><strong>점수</strong></div></td>
										
											<td class="tableline11 white"  style="border-bottom-width:0px;" align="center"><div align="center"><strong>수료구분</strong></div></td>
											<td class="tableline21 white"  style="border-bottom-width:0px;" align="center"><div align="center"><strong>수료번호</strong></div></td> 
										</tr>
										<tr bgcolor="#375694">
											<td height="2" colspan="100%"></td>
										</tr>
										
													<%=html.toString() %>
										<tr bgcolor="#375694" height="2"><td colspan="100%"></td></tr>
				                        <!---[e] content -->
										<!-- space -->
									</table>
									<table width="100%" height="50"><tr><td></td></tr></table>												
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<!--[e] Contents Form  -->
				                            
        </td>
    </tr>
</table>

<!--[s] bottom -->
<jsp:include page="/commonInc/include/commonAdminBottom.jsp" flush="false"/>
<!--[e] bottom -->
	
	</form>
</body>



<SCRIPT LANGUAGE="JavaScript">
<!--
<%if(requestMap.getString("qu").equals("deptList")){%>
//현재 사용자 권한에 따라서 해당하는 기관을 셀렉트 한다.
var dept = "<%=requestMap.getString("dept")%>";	
deptLen = $("aDept").options.length
for(var i=0; i < deptLen; i++) {
    if($("aDept").options[i].value == dept){
     	$("aDept").selectedIndex = i;
	 }
}
<%}%>

//AI Report
document.write(tagAIGeneratorOcx);
</SCRIPT>


