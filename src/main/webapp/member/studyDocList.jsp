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

    //기관조회 리스트
	DataMap deptListMap = (DataMap)request.getAttribute("DEPT_LIST_DATA");
	deptListMap.setNullToInitialize(true);

    //학적부 조회 리스트
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	listMap.setNullToInitialize(true);
	
	
	
	StringBuffer html =  new StringBuffer();
	
	
	html.append("<table width=\"100%\" border=\"0\" height=\"\" cellspacing=\"0\" cellpadding=\"0\">");
	html.append("	<tr>");
	html.append("		<td>");
	html.append("			<table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\"><tr bgcolor=\"#5071B4\" height=\"2\"><td></td></tr></table>");
	html.append("			<table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">");
	html.append("				<tr>"); 
	html.append("					<td height=\"30\" colspan=\"100%\"class=\"tableline11\" align=center>");
		html.append("				<a href=\"javascript:go_deptList('studyDocList');\"><font color=red>기관/기간별 조회</font></a>");

	html.append("&nbsp;&nbsp;&nbsp;						&nbsp;&nbsp;&nbsp;						&nbsp;&nbsp;&nbsp;");
	html.append("					<a href=\"javascript:go_presonList('studyPersonList','0');\">개인별 조회</a>");

	html.append("					</td>");
	html.append("					<td rowspan=\"2\"class=\"tableline21\" align=center>	");
	html.append("									<input type=\"button\" class=\"boardbtn1\" value=\"조회\" onclick=\"go_list('deptList','studyDocList')\">	");
	
	//2010.10.19 - woni82
	//학적부 엑셀 다운로드
	html.append("									<input type=\"button\" class=\"boardbtn1\" value=\"excel\" onclick=\"go_excel('deptList','studyDocList')\">	");
	html.append("									</td>");
	
	html.append("				</tr>");
	
		html.append("			<tr>");
		html.append("				<td colspan=\"100%\">");
		html.append("					<table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">");
		html.append("						<tr>");
		if(requestMap.getString("sessClass").equals("0")){
		html.append("							<td class=\"tableline11\" width=\"65\"  align=\"center\" bgcolor=\"#F7F7F7\"><strong> 기관선택 : </strong></td>");
		html.append("							<td class=\"tableline11\" align=\"center\">");

			//시스템 관리자일경우 셀렉박스를 보여준다
			html.append("		<select name =\"aDept\">");
			if(deptListMap.keySize("dept") > 0 ){
					html.append("<option value=\"\">전체기관</option>");
				for(int i=0;deptListMap.keySize("dept") > i; i++){
					html.append("		<option value=\""+deptListMap.getString("dept",i)+"\">"+ deptListMap.getString("deptnm",i)+"</option>");
				}
			}else if(deptListMap.keySize("dept") <= 0){
				html.append("		<option value=\"\">등록된 기관이 없습니다.</option>");
				
			}
		}else if(requestMap.getString("sessClass").equals("C")){
			//부서담당자일경우 자신의 기관코드값을 히든값으로 넣는다.
			html.append("		<input type=\"hidden\" value=\""+requestMap.getString("dept")+"\">");
			
		}else if(requestMap.getString("sessClass").equals("3")){
			//기관담당자일경우 기관코드와 부서코드값을 히든으로 가진다.
			html.append("		<input type=\"hidden\" name=\"aDept\" value=\""+requestMap.getString("dept")+"\">");
			html.append("		<input type=\"hidden\" name=\"aPartcd\" value=\""+requestMap.getString("partcd")+"\">");
		}
		html.append("			</select>");
		html.append("			</td>");
		html.append("		<td class=\"tableline11\"  align=\"center\" width=\"45\" bgcolor=\"#F7F7F7\"><strong> 성명 : </strong></td>");
		html.append("		<td class=\"tableline11\"  align=\"center\" width=\"60\">");
		html.append("			<input type=\"text\" class=\"textfield\" maxlength=\"6\" size=7 name=\"name\" onkeypress=\"if(event.keyCode==13){go_list('deptList','studyDocList');return false;}\" value = \""+requestMap.getString("name")+"\" required=\"true!성명을 입력하십시오.\"> ");
		html.append("		</td>");
		html.append("		<td class=\"tableline11\"  align=\"center\" bgcolor=\"#F7F7F7\"><strong> 교육기간 : </strong></td>");
		html.append("		<td class=\"tableline11\"  align=\"left\" style=\"padding-left:10px\">");
		html.append(" 			<input type = text name =\"sDate\" class=\"textfield\" onclick=\"fnSDate();\" size = 8 maxlength = 8 value = \""+(requestMap.getString("sDate").equals("") ? requestMap.getString("nowDate") : requestMap.getString("sDate"))+"\" readonly>");
		html.append("			<a href = \"javascript:void(0)\" onclick=\"fnSDate();\">");
		html.append("			<img src = \"/images/icon_calendar.gif\" border = 0 align = absmiddle></a> ~");
		html.append("			<input type = text name =\"eDate\" class=\"textfield\" onclick=\"fnSDate();\" size = 8 maxlength = 8 value = \""+(requestMap.getString("eDate").equals("") ? requestMap.getString("nowDate") : requestMap.getString("eDate"))+"\" readonly>");
		html.append("			<a href = \"javascript:void(0)\" onclick=\"fnEDate();\">");
		html.append("			<img src = \"/images/icon_calendar.gif\" border = 0 align = absmiddle></a>");
		html.append("		</td>");
		html.append("	</tr>");
		html.append("	</table>");
		html.append("	</td>");
		
		html.append("	</tr>");
		html.append("	</table>");
		html.append("			<table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">");
		html.append("	<tr bgcolor=\"#5071B4\" height=\"2\"><td colspan=\"100%\"></td></tr>");
		html.append("	<tr><td height=30></td></tr>");
		html.append("	<tr> ");
		html.append("		<td colspan=\"3\">");
		html.append("			<table width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" bgcolor=\"E5E5E5\">");
		html.append("				<tr bgcolor=\"375694\"> ");
		html.append("					<td height=\"2\" colspan=\"12\"></td>");
		html.append("						</tr>");
		html.append("						<tr bgcolor=\"#5071B4\"> ");
		html.append("							<td class=\"tableline11 white\"  align=\"center\" height=28 width=50><div align=\"center\"><strong>성명</strong></td>");
		html.append("							<td class=\"tableline11 white\"  align=\"center\" width=80><div align=\"center\"><strong>성별</strong></td>");
		html.append("							<td class=\"tableline11 white\"  align=\"center\" width=80><div align=\"center\"><strong>생년월일</strong></td>");
		html.append("							<td class=\"tableline11 white\"  align=\"center\"><div align=\"center\"><strong>직급</strong></td>");
		html.append("							<td class=\"tableline11 white\"  align=\"center\"><div align=\"center\"><strong>기관</strong></td>");
		html.append("							<td class=\"tableline11 white\"  align=\"center\"><div align=\"center\"><strong>부서</strong></td>");
		html.append("							<td class=\"tableline11 white\"  align=\"center\"><div align=\"center\"><strong>과정명(기수)</strong></td>");
		html.append("							<td class=\"tableline11 white\"  align=\"center\"><div align=\"center\"><strong>시작일</strong></td>");
		html.append("							<td class=\"tableline11 white\"  align=\"center\"><div align=\"center\"><strong>종료일</strong></td>");
		
		if(!requestMap.getString("sessClass").equals("3")){	
			html.append("						<td class=\"tableline11 white\"  align=\"center\" width=20><strong>석차</strong></td>");
		}
		
		html.append("							<td class=\"tableline11 white\"  align=\"center\"><div align=\"center\"><strong>총점</strong></td>");
		html.append("							<td class=\"tableline11 white\"  align=\"center\"><div align=\"center\"><strong>수료여부</strong></td>");
		html.append("						</tr>");
		
		if(listMap.keySize("rname") > 0){
			for(int i=0; listMap.keySize("rname")>i;i++){
				html.append("				<tr bgcolor=\"#FFFFFF\">");                                                         
				html.append("					<td class=\"tableline11\" height=28><div align=\"center\">"+(listMap.getString("rname",i).equals("") ? "&nbsp;" : listMap.getString("rname",i)) +"</td>");            
						
				html.append("					<td class=\"tableline11\"><div align=\"center\">"+listMap.getString("sex",i)+"</td>");
						
				if(!listMap.getString("birthdate",i).equals("")){
					try{
						html.append("					<td class=\"tableline11\"><div align=\"center\">"+listMap.getString("birthdate",i)+"</td>");
						
					}catch(Exception e){
						html.append("					<td class=\"tableline11\"><div align=\"center\">에러</td>");
					}
					
				}else{
					html.append("					<td class=\"tableline11\"><div align=\"center\">&nbsp;</td>");
					
				}
				
				html.append("					<td class=\"tableline11\"><div align=\"center\">"+(listMap.getString("rjiknm",i).equals("") ? "&nbsp;" : listMap.getString("rjiknm",i))+"</td>");                     
				html.append("					<td class=\"tableline11\"><div align=\"center\">"+(listMap.getString("rdeptnm",i).equals("") ? "&nbsp;" : listMap.getString("rdeptnm",i))+"</td>");                     
				html.append("					<td class=\"tableline11\"><div align=\"center\">"+(listMap.getString("rdeptsub",i).equals("") ? "&nbsp;" : listMap.getString("rdeptsub",i))+"</td>");                     
				          
				html.append("					<td class=\"tableline11\"><div align=\"center\">"+(listMap.getString("grnm",i).equals("") ? "&nbsp;" : listMap.getString("grnm",i))+"("+listMap.getString("grseq",i)+")" +"</td>");                     
				html.append("					<td class=\"tableline11\"><div align=\"center\">"+(listMap.getString("started",i).equals("") ? "&nbsp;" : listMap.getString("started",i))+"</td>");                     
				html.append("					<td class=\"tableline11\"><div align=\"center\">"+(listMap.getString("enddate",i).equals("") ? "&nbsp;" : listMap.getString("enddate",i))+"</td>");                  
				
				if(!requestMap.getString("sessClass").equals("3")){
					html.append("				<td class=\"tableline11\"><div align=\"center\">"+(listMap.getString("seqno",i).equals("") ? "&nbsp;" : listMap.getString("seqno",i))+"</td>");
				}
				
				html.append("					<td class=\"tableline11\"><div align=\"center\">"+(listMap.getString("paccept",i).equals("") ? "&nbsp;" : listMap.getString("paccept",i))+"</td>");
				html.append("					<td class=\"tableline21\" align=\"center\"><div align=\"center\">"+(listMap.getString("rgrayn",i).equals("") ? "&nbsp;" : listMap.getString("rgrayn",i))+"</td>");
			}
		}else{
			html.append("	<!-- space-->");
			html.append("					<tr height=\"300\">");
			html.append("						<td class=\"tablelinlistMap\" bgcolor=\"#FFFFFF\"colspan=\"100%\"><div align=\"center\">");
			html.append("							기관을 선택 또는 교육기관을 선택 또는 성명을 입력하시고 조회버튼을 누르세요.");
			html.append("						</td>");
		}
		
		html.append("						</tr>");
		html.append("				</table>");
		html.append("	<tr bgcolor=\"#375694\" height=\"2\"><td colspan=\"100%\"></td></tr>");
		html.append("			</td>");
		html.append("		</tr>");
		html.append("	</table>");
		html.append("	</td></tr></table>");
		
%>

<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->
<script language="JavaScript" src="/AIViewer/AIScript.js"></script>

<script language="JavaScript" type="text/JavaScript"><!--
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


function go_list(qu,mode,userno,resno,process){
	$("qu").value= qu;
	$("mode").value= mode;
	$("userno").value=userno;
	$("resno").value=resno;
	
	if(IsValidCharSearch($("name").value) == false){
	
		return false;
	}
	
	$("process").value=process;
	
	if($("process").value == "0" && $("qu").value=="personList"){
		$("name").value="";
	}
	if($("process").value == "0" && $("qu").value=="deptList" || $("qu").value=="") {
		$("name").value="";
	}
	
	pform.action  = "/member/member.do";
	pform.submit();
	
}

	//2010.10.19 - woni82
	//엑셀 출력하기.
	function go_excel(qu,mode,userno,resno,process){
		//alert(qu+", "+mode+", "+userno+", "+resno+", "+process);		
		$("qu").value= qu;
		$("mode").value = "studyDocListExcel";
		$("userno").value=userno;
		$("resno").value=resno;	
		if(IsValidCharSearch($("name").value) == false){		
			return false;
		}		
		$("process").value=process;		
		if($("process").value == "0" && $("qu").value=="personList"){
			$("name").value="";
		}
		if($("process").value == "0" && $("qu").value=="deptList" || $("qu").value=="") {
			$("name").value="";
		}
		pform.action = "/member/member.do";
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


--></script>


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

<Div id='popCal' style='POSITION:absolute;visibility:hidden;border:2px ridge;width:10'>
<!-- 달력 선언 -->
</Div>

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
									<%=html.toString() %>
                        <!---[e] content -->
						<!-- space --><table width="100%" height="10"><tr><td></td></tr></table>												
                        
					</td>
				</tr>
			</table>
			<!--[e] Contents Form  -->
			<!-- [s]space -->
			<table cellspacing="0" cellpadding="0" border="0" width="100%"><tr><td height="50"></td></tr></table>
							                            
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
<%if(requestMap.getString("qu").equals("deptList") && requestMap.getString("sessClass").equals("0")){%>
//현재 사용자 권한에 따라서 해당하는 기관을 셀렉트 한다.
var dept = "<%=requestMap.getString("aDept")%>";	
deptLen = $("aDept").options.length
for(var i=0; i < deptLen; i++) {
    if($("aDept").options[i].value == dept){
     	$("aDept").selectedIndex = i;
	 }
}
<%}%>

</SCRIPT>


