<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 강사등급관리 리스트
// date  : 2008-07-09
// auth  : 정윤철
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
	
	//리스트 데이터
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	listMap.setNullToInitialize(true);
	
	StringBuffer html = new StringBuffer();
	if(listMap.keySize("tlevel") > 0){
		for(int i=0; listMap.keySize("tlevel") > i; i++){
			html.append("<tr>");
			html.append("<td align=\"center\">"+listMap.getString("tlevel",i)+"</td>");
			html.append("<td align=\"center\">"+listMap.getString("levelName",i)+"</td>");
			html.append("<td align=\"center\">"+listMap.getString("gDefaultAmt",i)+"</td>");
			html.append("<td align=\"center\">"+listMap.getString("gOverAmt",i)+"</td>");
			html.append("<td align=\"center\">"+listMap.getString("cDefaultAmt",i)+"</td>");
			html.append("<td align=\"center\">"+listMap.getString("cOverAmt",i)+"</td>");
			html.append("<td align=\"center\" class=\"br0\"><input type=\"button\" class=\"boardbtn1\" onclick=\"go_modify('"+listMap.getString("tlevel",i)+"')\" value=\"수정\">");
			html.append("<input type=\"button\" class=\"boardbtn1\" onclick=\"go_intimacy('"+listMap.getString("tlevel",i)+"')\" value=\"지정\"></td>");
			html.append("</tr>");			
		}
	}else{
		html.append("<tr>");
		html.append("<td align=\"center\" colspan=\"100%\" style=\"height:100px\">등록된 강사 등급이 없습니다.</td>");
		html.append("</tr>");		
	}
%>


<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->


<script language="JavaScript">
<!--
//권한 등급 수정
function go_modify(tlevel){
	$("tlevel").value = tlevel;
	$("mode").value = "form";
	$("qu").value = "modify";
	pform.action = "/tutorMgr/allowance.do";
	var popWindow = popWin('about:blank', 'majorPop11', '550', '350', 'no', 'no');
	pform.target = "majorPop11";
	pform.submit();
	pform.target = "";
}

//권한 등급 지정
function go_intimacy(tlevel){
	$("tlevel").value = tlevel;
	$("mode").value = "greadList";
	pform.action = "/tutorMgr/allowance.do";
	pform.submit();
}


//권한 등급 등록
function go_insert(tlevel){
	$("tlevel").value = tlevel;
	$("mode").value = "form";
	$("qu").value = "insert";
	pform.action = "/tutorMgr/allowance.do";
	var popWindow = popWin('about:blank', 'majorPop11', '550', '350', 'no', 'no');
	pform.target = "majorPop11";
	pform.submit();
	pform.target = "";
}

//-->
</script>


<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<form id="pform" name="pform" method="post" >

<input type="hidden" name="menuId" 	value="<%= requestMap.getString("menuId") %>">
<input type="hidden" name="mode"	value="<%= requestMap.getString("mode") %>">
<input type="hidden" name="qu"		value="">
<!-- 권한 코드 -->
<input type="hidden" name="tlevel" value="">

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
						<img src="/images/bullet003.gif"  align="bottom">&nbsp;<strong>강사등급관리</strong>
					</td>
				</tr>
			</table> 
			<!--[e] subTitle -->
			<div class="space01"></div>
			<!--[s] Contents Form  -->
			<table cellspacing="0" cellpadding="0" border="0" width="100%" class="contentsTable">
				<tr>
					<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="0" class="datah01">
							<thead>
							<tr>
								<th width="30">코드</th>
								<th>구분</th>
								<th width="130">집합강사 기본수당</th>
								<th width="130">집합강사 초과수당</th>
								<th width="130">사이버강사 기본수당</th>
								<th width="130">사이버강사 초과수당</th>
								<th class="br0">기능 대상 </th>
							</tr>
							</thead>

							<tbody>
							<%=html.toString() %>
							</tbody>
						</table>
					</td>
				</tr>
			</table>
			<table cellspacing="0" cellpadding="0" border="0" width="100%" class="contentsTable">
				<tr height="2">
					<td></td>
				</tr>
				<tr>
					<td width="100%" align="right"><input type="button" value="강사등급추가" style="cusor:hand" onclick="go_insert();" class="boardbtn1"></td>
				</tr>
			</table>
			<!--[e] Contents Form  -->
			<div class="space_ctt_bt"></div>                            
        </td>
    </tr>
</table>

<!--[s] bottom -->
<jsp:include page="/commonInc/include/commonAdminBottom.jsp" flush="false"/>
<!--[e] bottom -->

</form>
</body>