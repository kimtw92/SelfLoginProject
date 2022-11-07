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
	
	
		if(listMap.keySize("userno") > 0){
			for(int i = 0; listMap.keySize("userno") > i; i++){
				String jsLink = "<a href=\"javascript:goForm('"+listMap.getString("userno",i)+"','"+listMap.getString("grcode",i)+"','"+listMap.getString("linkGrseq",i)+"','schoolRegForm','"+listMap.getString("rresno",i)+"');\">"+listMap.getString("grcodeniknm",i)+listMap.getString("jik",i)+"</a>";
				html.append("<tr bgcolor=\"#FFFFFF\">");
				html.append("<td class=\"tableline11\" height=\"28\"><div align=\"center\">"+(listMap.getString("gubunnm",i).equals("") ? "&nbsp" : listMap.getString("gubunnm",i))+"</div></td>");
				html.append("<td class=\"tableline11\"><div align=\"center\">"+(listMap.getString("eduno",i).equals("") ? "&nbsp" : listMap.getString("eduno",i))+"</div></td>");
				html.append("<td class=\"tableline11\"><div align=\"center\">"+jsLink+"</td>");
				html.append("<td class=\"tableline11\"><div align=\"center\">"+(listMap.getString("rgrseq",i).equals("") ? "&nbsp" : listMap.getString("rgrseq",i))+"</div></td>");
				html.append("<td class=\"tableline11\"><div align=\"center\">"+(listMap.getString("rdeptnm",i).equals("") ? "&nbsp" : listMap.getString("rdeptnm",i))+"</div></td>");
				html.append("<td class=\"tableline11\"><div align=\"center\">"+(listMap.getString("rjiknm",i).equals("") ? "&nbsp" : listMap.getString("rjiknm",i))+"</div></td>");
				html.append("<td class=\"tableline11\"><div align=\"center\">"+(listMap.getString("started_1",i).equals("") ? "&nbsp" : listMap.getString("started_1",i))+"</div></td>");
				html.append("<td class=\"tableline11\"><div align=\"center\">"+(listMap.getString("enddate_1",i).equals("") ? "&nbsp" : listMap.getString("enddate_1",i))+"</div></td>");
				html.append("<td class=\"tableline11\"><div align=\"center\">"+(listMap.getString("rno",i).equals("") ? "&nbsp" : listMap.getString("rno",i))+"</div></td>");
				if(!requestMap.getString("sessClass").equals("3")){
					html.append("	<td class=\"tableline11\"><div align=\"center\">"+(listMap.getString("seqno",i).equals("") ? "&nbsp" : listMap.getString("seqno",i))+"</div></td>");
				}                                           
				html.append("<td class=\"tableline11\"><div align=\"center\">"+(listMap.getString("totno",i).equals("") ? "&nbsp" : listMap.getString("totno",i))+"</div></td>");
				html.append("<td class=\"tableline11\"><div align=\"center\">"+(listMap.getString("rgrayn",i).equals("") ? "&nbsp" : listMap.getString("rgrayn",i))+"</div></td>");
				html.append("<td class=\"tableline11\"><div align=\"center\">"+(listMap.getString("grman",i).equals("") ? "&nbsp" : listMap.getString("grman",i))+"</div></td>");
				html.append("<td class=\"tableline21\"><div align=\"center\">"+(listMap.getString("confirmman",i).equals("") ? "&nbsp" : listMap.getString("confirmman",i))+"</div></td>");

				html.append("</tr>");
			}


		}else{
			html.append("					<tr bgcolor=\"#FFFFFF\"> ");
			html.append("						<td class=\"tableline11\" colspan=8><div align=\"center\">검색된 내용이 없습니다.</div></td>");
			html.append("					</tr>");

		}
		
		// 일반사용자 사진
		ut.lib.util.MD5 md5 = new MD5( requestMap.getString("resno") );
		String sysFileName = md5.asHex();
		String fileDir = Constants.rootPath + Constants.UPLOAD + Constants.NAMOUPLOAD_PIC + sysFileName;		
		java.io.File file = new java.io.File(fileDir);
		String picImg = "";
		if( file.isFile() ){
			picImg = "/pds/pic/" + sysFileName;
		}
%>

<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->



<script language="JavaScript" type="text/JavaScript">

function go_list(qu,mode,userno,resno,process){
	$("qu").value= qu;
	$("mode").value= mode;
	$("userno").value=userno;
	$("resno").value=resno;

	if(IsValidCharSearch($("name").value) == false){
		$("name").focus();
		return false;
	}
	$("process").value="1";

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

//개인별 학적부 자료수정 
function goForm(userno,grcode,grseq,qu,resno){
	$("mode").value = "schoolRegForm";
	$("qu").value = qu;
	$("userno").value = userno;
	$("resno").value = resno;
	$("grcode").value = grcode;
	$("grseq").value = grseq;
	
	pform.action = "/member/member.do";
	var popWindow = popWin('about:blank', 'majorPop11', '500', '570', 'no', 'no');
	pform.target = "majorPop11";
	pform.submit(); 
	pform.target = "";
}
//기관별 개인별 구분에서 사용
function go_gubunList(qu,mode){
location.href="/member/member.do?qu="+qu+"&mode="+mode+"&menuId=<%=requestMap.getString("menuId")%>";

}

//새로고침
function go_refresh(){
	$("mode").value="<%=requestMap.getString("mode")%>";
	$("resno").value="<%=requestMap.getString("resno")%>";
	$("userno").value="<%=requestMap.getString("userno")%>";	
	pform.action = "/member/member.do";
	pform.submit(); 
}

// 사진등록후 페이지 리로드
function fnReload(){
	$("mode").value = "studySchoolRegList";
	$("mode").value="<%=requestMap.getString("mode")%>";
	$("resno").value="<%=requestMap.getString("resno")%>";
	$("userno").value="<%=requestMap.getString("userno")%>";		
	pform.action = "/member/member.do";
	pform.submit();
}

// 사진등록
function fnImgUploadPop(){
	
	var url = "/tutorMgr/tutor.do";
	url += "?mode=imgUploadForm";
	url += "&resno=<%=requestMap.getString("resno")%>";
	
	pwinpop = popWin(url,"cPop","450","540","yes","yes");	
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
<input type="hidden" name="resno" value="">
<!-- 현재 페이지의 기능이 폼인지 리스트인지 확인 -->
<input type="hidden" name="process">
<!-- 수정시 필요한 데이터 -->
<input type="hidden" name="grcode">
<input type="hidden" name="grseq">

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
												<input type = text size="" maxlength="8" class="textfield" name ="name" onkeypress="if(event.keyCode==13){go_list('','studyPersonList');return false;}" value = "<%= requestMap.getString("name")%>" required="true!성명을 입력하십시오."> 
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
							<tr>
								<td width="100%">
									<table width="100%" border="0" cellpadding="0" cellspacing="0">
										<tr>
											<td height="100" bgcolor="">
												<img src="<%= picImg.equals("") ? "/images/photo_blank.gif" : picImg %>" id ="previewTd" width="95" height="100">
											</td>
											<td align=left valign=bottom width="60%" >
												&nbsp;&nbsp;<input type="button" value="사진등록" class="boardbtn1" onclick="fnImgUploadPop();"> 
												<input type="button" onclick="go_refresh();" value="새로고침" class="boardbtn1"> 
											</td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
						
						
						<table cellspacing="0" cellpadding="0" border="0" width="100%">
							<tr bgcolor="#375694" height="2"><td colspan="100%"></td></tr>
							<tr bgcolor="" height="30"><td colspan="100%"></td></tr>
							<tr> 
								<td colspan="100%">
									<table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="E5E5E5">
										<tr bgcolor="#375694"> 
											<td height="2" colspan="100%"></td>
										</tr>
						
						
										<tr bgcolor="#5071B4">
											<td class="tableline11 white" height="28"><div align="center"><strong>성명</strong></div></td>
											<td class="tableline21 white" colspan="100%"><div align="center"><strong><%=listMap.getString("rname") %></strong></div></td>
										</tr>
										
										<tr bgcolor="#5071B4"> 
											<td class="tableline11 white" height="28"><div align="center"><strong>주민번호</strong></div></td>
											<td class="tableline21 white" colspan="100%"><div align="center"><strong><%=requestMap.getString("resno") %></strong></div></td>
										</tr>
										
										<tr bgcolor="#5071B4"> 
											<td class="tableline11 white" height="28"><div align="center"><strong>학력</strong></div></td>
											<td class="tableline11 white"><div align="center"><strong>교번</strong></div></td>
											<td class="tableline11 white"><div align="center"><strong>훈련과정</strong></div></td>
											<td class="tableline11 white"><div align="center"><strong>기별</strong></div></td>
											<td class="tableline11 white">	<div align="center"><strong>소속</strong></div></td>
											<td class="tableline11 white"><div align="center"><strong>직명</strong></div></td>
											<td class="tableline11 white"><div align="center"><strong>입교년월일</strong></div></td> 
											<td class="tableline11 white"><div align="center"><strong>수료년월일</strong></div></td>
											<td class="tableline11 white"><div align="center"><strong>수료증번호</strong></div></td>
										
											<% if(!requestMap.getString("sessClass").equals("3")){ %>
												<td class="tableline11 white"><div align="center"><strong>석차</strong></div></td>
											<% }%>
											<td class="tableline11 white"><div align="center"><strong>총원</strong></div></td>
											<td class="tableline11 white"><div align="center"><strong>판정</strong></div></td>
											<td class="tableline11 white"><div align="center"><strong>작성자</strong></div></td>
											<td class="tableline21 white"><div align="center"><strong>확인자</strong></div></td>
										</tr>
											<%=html.toString() %>
										<tr bgcolor="#375694"> 
											<td height="2" colspan="100%"></td>
										</tr>
									 </table>
								</td>
							</tr>
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


