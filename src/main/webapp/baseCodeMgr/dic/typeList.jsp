<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 용어사전분류코드
// date  : 2008-05-27
// auth  : kang
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
	
	
	// 용어분류 리스트
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	
	StringBuffer sbListHtml = new StringBuffer(); //목록
	String param = "";
	
	if(listMap.keySize("types") > 0){
		
		for(int i=0; i < listMap.keySize("types"); i++){
			
			param = "javascript:fnSave('typeModifyPop','" + listMap.getString("types", i) + "')";
			
			sbListHtml.append("<tr bgcolor=\"#FFFFFF\" height=\"25\">");
			sbListHtml.append("	<td align='center' class=\"tableline11\">" + listMap.getString("rownum", i) + "</td>");
			sbListHtml.append("	<td align='center' class=\"tableline11\">" + listMap.getString("types", i) + "</td>");
			sbListHtml.append("	<td align='left' class=\"tableline21\">&nbsp;");
			sbListHtml.append("		<a href=\"" + param + "\">" + listMap.getString("typenm", i) + "</a>");
			sbListHtml.append("	</td>");
			sbListHtml.append("</tr>");
		}
		
	}else{
		sbListHtml.append("<tr bgcolor=\"#FFFFFF\" height=\"100\">");
		sbListHtml.append("	<td align=\"center\" class=\"tableline21\" colspan=\"100%\">작성된 글이 없습니다.</td>");		
		sbListHtml.append("</tr>");
	}
	
	
	

%>

<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->


<script language="JavaScript" type="text/JavaScript">

// 등록
function fnSave(mode, types){

	var url = "dic.do";
	url += "?mode=" + mode;
	url += "&types=" + types;
	url += "&menuId=<%=requestMap.getString("menuId")%>";
	
	pwinpop = popWin(url,"typePop","350","200","no","no");
}

// 새로고침
function fnReload(){
	pform.submit();
}




</script>



<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<form id="pform" name="pform" method="post">

<input type="hidden" name="menuId" 	value="<%=requestMap.getString("menuId")%>">
<input type="hidden" name="mode"	value="<%=requestMap.getString("mode") %>">

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

			<!--[s] subTitle -->
			<table width="100%" height="10"><tr><td></td></tr></table>
			<table width="100%" border="0" cellspacing="0" cellpadding="0" class="contentsSubTitleTable">			
				<tr>
					<td height="20">
						<img src="/images/bullet003.gif"  align="bottom">&nbsp;<strong>용어분류 관리 리스트</strong>
					</td>
				</tr>
			</table>
			<!--[e] subTitle -->
			
			<!--[s] Contents Form  -->
			<table cellspacing="0" cellpadding="0" border="0" width="100%" class="contentsTable">
				<tr>
					<td>
						
						<!--[s] 상단 추가, 새로고침 버튼  -->
						<table width="100%" border="0" cellpadding="0" cellspacing="0" style="border-collapse:collapse;">
							<tr>
								<td align="right">
									<input type="button" value="추가" onclick="fnSave('typeRegPop','');" class="boardbtn1">
									&nbsp;
									<input type="button" value="새로고침" onclick="fnReload();" class="boardbtn1">
								</td>
							</tr>
						</table>
						<!--[e] 상단 추가, 새로고침 버튼  -->
						<br>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr bgcolor="#375694"><td height="2" colspan="3"></td></tr>		
							<tr height='28' bgcolor="#5071B4">
								<td align="center" class="tableline11 white"><strong>번호</strong></td>
								<td align="center" class="tableline11 white"><strong>TYPES</strong></td>
								<td align="center" class="tableline11 white"><strong>TYPE NAME</strong></td>
							</tr>
							
							<%=sbListHtml.toString() %>
							
							<tr bgcolor="#375694"><td height="2" colspan="3"></td></tr>
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

