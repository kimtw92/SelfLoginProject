<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%   
	// prgnm : 개인별수료이력조회
	// date : 2008-07-16 
	// auth : LYM
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

	
	String tmpStr = "";
	String prevUserno = "";
	
	//리스트
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	listMap.setNullToInitialize(true);

	StringBuffer listStr = new StringBuffer(); //리스트 결과 변수.
	for(int i=0; i < listMap.keySize("userno"); i++){
		
		prevUserno = listMap.getString("userno", i);
		listStr.append("\n<tr>");
		//성명
		tmpStr = "<a href=\"javascript:go_view('" + listMap.getString("userno", i) + "')\">" + listMap.getString("rname", i) + "</a>";
		listStr.append("\n	<td>" + tmpStr + "</td>");
		
		//아이디
		listStr.append("\n	<td>" + listMap.getString("userId", i) + "</td>");
		
		
		//기관명
		listStr.append("\n	<td>" + listMap.getString("rdeptnm", i) + "</td>");
		//직급명
		listStr.append("\n	<td>" + listMap.getString("rjiknm", i) + "</td>");
		//과정명(기수)
		listStr.append("\n	<td class='br0'>" + listMap.getString("grcodenm", i) + "(" + listMap.getString("grseq", i) +")</td>");	
		listStr.append("\n</tr>");
	
	} //end for 
	//row가 없으면.
	if( requestMap.getString("searchName").equals("") || listMap.keySize("userno") <= 0){
		listStr.append("\n<tr>");
		listStr.append("\n	<td colspan='100%' class='br0' style='height:100px'>검색된 내용이 없습니다.</td>");
		listStr.append("\n</tr>");

	}
%>

<!-- [s] commonHtmlTop include 필수 -->
	<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->

	<script language="JavaScript" type="text/JavaScript">
	<!--
		//comm Selectbox선택후 리로딩 되는 함수.
		function go_reload(){
			go_list();
		}
		
		//검색
		function go_search(){
			if($F("searchName") == ""){
				alert("검색어를 입력하세요.");
				return;
			}
			if(IsValidCharSearch($F("searchName"))){
				go_list();
			}
		}
		
		//리스트
		function go_list(){
			$("mode").value = "person_list";
			pform.action = "/courseMgr/certiResult.do";
			pform.submit();
		}
		
		function go_view(userno){
			$("mode").value = "person_view";
			$("userno").value = userno;
			pform.action = "/courseMgr/certiResult.do";
			pform.submit();
		}
		
		
		//로딩시.
		onload = function()	{
		
		}
		
		function go_formChk(){
			go_search();
		}
	//-->
	</script>

<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >
	<form id="pform" name="pform" method="post" onSubmit="go_formChk();return false;">
	
		<input type="hidden" name="menuId"				value="<%= requestMap.getString("menuId") %>"/>
		<input type="hidden" name="mode"				value="<%= requestMap.getString("mode") %>"/>
		<input type="hidden" name="qu"					value=""/>
		<input type="hidden" name="userno"				value=""/>
		
		<table cellspacing="0" cellpadding="0" border="0" width="100%" height="100%">
		    <tr>
		        <td width="211" height="86" valign="bottom" align="center" nowrap>
		        	<img src="/images/incheon_logo.gif" width="192" height="56" border="0">
		        </td>
		        <td width="8" valign="top" nowrap>
		        	<img src="/images/lefttop_bg.gif" width="8" height="86" border="0">
		        </td>
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
					<div class="h10"></div>
					<!--[s] Contents Form  -->
					<table cellspacing="0" cellpadding="0" border="0" width="100%" class="contentsTable">
						<tr>
							<td>
								<!-- 검색 -->
								<table class="search01">
									<tr>
										<th width="80" class="bl0">
											<strong>성명</strong>
										</th>
										<td>
											<input type='text' name='searchName' style='width:100' class="font1" value="<%=requestMap.getString("searchName")%>"/>
										</td>
										<td width="120" class="btnr">
											<input type="button" value="조회" onclick="go_search();return false;" class="boardbtn1"/>
											<!-- <input type="button" value="EXCEL" onclick="go_excel();" class="boardbtn1"> -->
										</td>
									</tr>
								</table>
								<!--//검색 -->	
								<div class="space01"></div>
								<!--[s] 리스트  -->
								<table class="datah01">
									<thead>
									<tr>
										<th>성명</th>
										<th>ID</th>
										<!-- 
										<th>주민번호</th>  
										-->
										<th>기관명</th>
										<th>직급명</th>
										<th class="br0">과정명(기수)</th>
									</tr>
									</thead>
									<tbody>
									<%= listStr.toString() %>
									</tbody>
								</table>
								<!--//[e] 리스트  -->
							</td>
						</tr>
					</table>
					<!--//[e] Contents Form  -->
					<div class="space_ctt_bt"></div>	                            
		        </td>
		    </tr>
		</table>
		<!--[s] bottom -->
		<jsp:include page="/commonInc/include/commonAdminBottom.jsp" flush="false"/>
		<!--[e] bottom -->
		
	</form>
</body>

