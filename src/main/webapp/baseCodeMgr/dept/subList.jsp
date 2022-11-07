<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 부서코드관리 리스트
// date : 2008-05-14
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
	//listMap 데이터
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	listMap.setNullToInitialize(true);
	
	
	//rowMap 데이터
	DataMap rowMap = (DataMap)request.getAttribute("DEPTNMROW_DATA");
	rowMap.setNullToInitialize(true);
	
	
	StringBuffer contentList = new StringBuffer();
	
	//기관코드관리 리스트
	contentList.append("<table cellspacing=\"0\" cellpadding=\"0\" border=\"0\" width=\"100%\" class=\"contentsTable\">");
	contentList.append("	<tr height=\"2\" bgcolor=\"#375694\"><td colspan=\"100%\"></td></tr>");
	
	contentList.append("	<tr height=\"28\" bgcolor=\"#5071B4\">");
	contentList.append("			<td height=\"28\" align=\"center\" class=\"tableline11 white\"><strong>SEQ</strong></td>");
	contentList.append("			<td height=\"28\" align=\"center\" class=\"tableline11 white\"><strong>부서코드</strong></td>");
	contentList.append("			<td height=\"28\" align=\"center\" class=\"tableline11 white\"><strong>부서명</strong></td>");
	contentList.append("			<td height=\"28\" align=\"center\" class=\"tableline11 white\"><strong>사용</strong></td>");
	contentList.append("			<td height=\"28\" align=\"center\" class=\"tableline11 white\"><strong>수정</strong></td>");
	contentList.append("			<td height=\"28\" align=\"center\" class=\"tableline21 white\"><strong>삭제</strong></td>");
	contentList.append("	</tr>");	
	
	if(listMap.keySize("partcd") > 0 ){
		
		
		for(int i=0;listMap.keySize("partcd") > i;i++){
	
	       
			contentList.append("	<tr>");
			contentList.append("		<td height=\"28\" align=\"center\" class=\"tableline11 \" >"+i+"</td>");
			contentList.append("		<td height=\"28\" align=\"center\" class=\"tableline11 \" >"+listMap.getString("partcd",i)+"</td>");
			contentList.append("		<td height=\"28\" align=\"center\" class=\"tableline11 \" >"+listMap.getString("partnm",i)+"</td>");
			contentList.append("		<td height=\"28\" align=\"center\" class=\"tableline11 \" >"+listMap.getString("useYn",i)+"</td>");
			contentList.append("		<td height=\"28\" align=\"center\" class=\"tableline11 \" ><input type=\"button\" class=\"boardbtn1\" value=\"수정\" onclick=\"go_form('update','"+requestMap.getString("dept")+"','"+listMap.getString("partcd",i)+"');\"></td>");
			contentList.append("		<td height=\"28\" align=\"center\" class=\"tableline21 \" ><input type=\"button\" class=\"boardbtn1\" value=\"삭제\" onclick=\"go_delete('partDelete','"+requestMap.getString("dept")+"','"+listMap.getString("partcd",i)+"');\"></td>");
			contentList.append("	</tr>");
		}
	}else{
		contentList.append("	<tr>");
		contentList.append("		<td height=\"100\" colspan=\"100%\"align=\"center\" class=\"tableline21 \" >등록된 부서가 없습니다.</td>");
		contentList.append("	</tr>");
	}
	contentList.append("	<tr height=\"2\" bgcolor=\"#375694\"><td colspan=\"100%\"></td></tr>");
	contentList.append("</table>");	
	

%>

<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->

<script language="JavaScript" type="text/JavaScript">
function go_list(){
	$("mode").value = "list";
	document.pform.action = "/baseCodeMgr/dept.do";
	document.pform.submit();
}

function go_form(qu,dept,partcd){
	$("mode").value = "subForm";
	$("qu").value=qu;
	$("dept").value = dept;
	$("partcd").value = partcd;
	pform.action = "/baseCodeMgr/dept.do?mode=subForm";
	var popWindow = popWin('about:blank', 'majorPop11', '250', '250', 'no', 'no');
	pform.target = "majorPop11";
	pform.submit();
	pform.target = "";
}

function go_delete(qu,dept,partcd){
	$("mode").value = "exec";
	$("qu").value=qu;
	$("dept").value=dept;
	$("partcd").value = partcd;
	if( confirm('삭제 하시겠습니까?')){
		document.pform.action = "/baseCodeMgr/dept.do";
		document.pform.submit();
	}
	
}
</script>


<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<form id="pform" name="pform" method="post">
<input type="hidden" name="mode"	value="">
<input type="hidden" name="qu"		value="">
<input type="hidden" name="menuId" value = "<%=requestMap.getString("menuId")%>">
<!-- 기관코드  -->
<input type="hidden" name="dept" value ="">
<!-- 부서코드 --> 
<input type="hidden" name="partcd" value ="">
<!-- 기관코드명 -->
<input type="hidden" name="deptnm" value = "<%=rowMap.getString("adeptnm") %>">


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

			<!--[s] subTitle -->
			<table width="100%" height="10"><tr><td></td></tr></table>
			<table width="100%" border="0" cellspacing="0" cellpadding="0" class="contentsSubTitleTable">			
				<tr>
					<td height="20">
						<img src="/images/bullet003.gif"  align="bottom">&nbsp;<strong>부서관리 리스트.</strong>
					</td>
				</tr>
			</table>
			<!--[e] subTitle -->
			<!--[s] button -->
			<table width="100%" border="0" cellspacing="0" cellpadding="0" class="contentsTable">
				<tr>
					<td>
						<table cellspacing="0" cellpadding="0" border="0" width="100%" class="contentsTable">
							<tr>
								<td height="2" bgcolor="#375694" style="width:85%" ></td>
							</tr>
						</table>
					</td>
				</tr>			
				<tr>
					<td height="20" align="right">
						<table cellspacing="0" cellpadding="0" border="0" width="100%" class="contentsTable" >
							<tr>
								<td width="50" class="tableline11" bgcolor="#F7F7F7">
									<strong>기관명 :</strong> 
								</td>
								<td width="200" class="tableline21" style="padding-left:10px">
									<%=rowMap.getString("adeptnm") %>
								</td>
								<td class="tableline11">&nbsp;</td>
								<td width="120" class="tableline21">
									<input type="button" value="리스트" class="boardbtn1" onclick="go_list();">&nbsp;&nbsp;<input type="button" value="추가"  class="boardbtn1" onclick="go_form('insert','<%=requestMap.getString("dept") %>');">
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td>
						<table cellspacing="0" cellpadding="0" border="0" width="100%" class="contentsTable">
							<tr>
								<td height="2" bgcolor="#375694" style="width:85%" ></td>
							</tr>
							<tr>
								<td height="2"></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			
			<!--[e] button -->
			<!--[s] Contents Form  -->
			<table cellspacing="0" cellpadding="0" border="0" width="100%" class="contentsTable">
				<tr>
					<td>
										
                        <!---[s] content -->

						<!-- space --><table width="100%" height="10"><tr><td></td></tr></table>
						<%=contentList.toString() %>
                        <!---[e] content -->

					</td>
				</tr>
			</table>
			<!-- space --><table><tr><td height="30">&nbsp;</td></tr></table>
			<!--[e] Contents Form  -->
				                            
        </td>
    </tr>
</table>

<!--[s] bottom -->
<jsp:include page="/commonInc/include/commonAdminBottom.jsp" flush="false"/>
<!--[e] bottom -->
	
</form>
</body>






