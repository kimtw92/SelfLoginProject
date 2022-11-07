<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 강사 대상지정 리스트
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
			html.append("<td align=\"center\">"+(i+1)+"</td>");
			html.append("<td align=\"center\">"+listMap.getString("gruName",i)+"</td>");
			html.append("<td align=\"center\"><a href=\"javascript:go_modify('"+listMap.getString("gruCode",i)+"')\">수정</a></td>");
			html.append("<td align=\"center\" class=\"br0\"><a href=\"javascript:go_delete('"+listMap.getString("gruCode",i)+"')\">삭제</a></td>");
			html.append("</tr>");			
		}
	}else{
		html.append("<tr>");
		html.append("	<td align=\"center\" colspan=\"100%\" style=\"height:100px\" class=\"br0\">등록된 대상이 없습니다.</td>");
		html.append("</tr>");		
	}
%>


<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->


<script language="JavaScript">
<!--
//강사지정 수정
function go_modify(gruCode){
	$("gruCode").value = gruCode;
	$("mode").value = "greadForm";
	$("qu").value = "modify";
	pform.action = "/tutorMgr/allowance.do";
	var popWindow = popWin('about:blank', 'majorPop11', '450', '150', 'no', 'no');
	pform.target = "majorPop11";
	pform.submit();
	pform.target = "";
}
//지정된 강사 삭제
function go_delete(gruCode){
	if( confirm('삭제 하시겠습니까?')){
		$("mode").value = "greadExec";
		$("qu").value = "delete";
		$("gruCode").value = gruCode;
		pform.action = "/tutorMgr/allowance.do";
		pform.submit();
	}
}

//강사지정 등록
function go_insert(){
	$("mode").value = "greadForm";
	$("qu").value = "insert";
	pform.action = "/tutorMgr/allowance.do";
	var popWindow = popWin('about:blank', 'majorPop11', '450', '150', 'no', 'no');
	pform.target = "majorPop11";
	pform.submit();
	pform.target = "";
}

//전페이지로 이동
function go_list(){
	$("mode").value = "";
	$("qu").value = "";
	pform.action = "/tutorMgr/allowance.do";
	pform.submit();
}

//-->
</script>


<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<form id="pform" name="pform" method="post" >

<input type="hidden" name="menuId" 	value="<%= requestMap.getString("menuId") %>">
<input type="hidden" name="mode"	value="<%= requestMap.getString("mode") %>">
<input type="hidden" name="qu"		value="">

<!-- 권한 코드 -->
<input type="hidden" name="tlevel" value="<%=requestMap.getString("tlevel") %>">
<!-- 강사지정코드  -->
<input type="hidden" name="gruCode" value="">

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
						<img src="/images/bullet003.gif"  align="bottom">&nbsp;<strong><%=requestMap.getString("name") %> 강사 대상 설정</strong>
					</td>
				</tr>
			</table> 
			<div class="space01"></div>
			<table cellspacing="0" cellpadding="0" border="0" width="100%" class="contentsTable">
				<tr>
					<td width="100%" align="right">
						<input type="button" value="강사 대상 추가" style="cusor:hand" onclick="go_insert();" class="boardbtn1">
						<input type="button" value="강사등급리스트" style="cusor:hand" onclick="go_list();" class="boardbtn1">
					</td>
				</tr>
				<tr height="2">
					<td></td>
				</tr>
			</table>
			<!--[e] subTitle -->
			<!--[s] Contents Form  -->
			<table cellspacing="0" cellpadding="0" border="0" width="100%" class="contentsTable">
				<tr>
					<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="0" class="datah01">
							<thead>
							<tr>
								<th width="">NO</th>
								<th>대상</th>
								<th width="">기능</th>
								<th width="">삭제</th>
							</tr>
							</thead>

							<tbody>
							<%=html.toString() %>
							</tbody>
						</table>
					</td>
				</tr>
			</table>
			<div class="space_ctt_bt"></div>
			<!--[e] Contents Form  -->
				                            
        </td>
    </tr>
</table>

<!--[s] bottom -->
<jsp:include page="/commonInc/include/commonAdminBottom.jsp" flush="false"/>
<!--[e] bottom -->

</form>
</body>