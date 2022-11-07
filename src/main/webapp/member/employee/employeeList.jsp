<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 직원회원 관리
// date : 2008-08-19
// auth : 정윤철
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
	
	
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	listMap.setNullToInitialize(true);
	
	//페이지 처리
	PageNavigation pageNavi = (PageNavigation)listMap.get("PAGE_INFO");
	int pageNum = pageNavi.getTotalCnt() - (requestMap.getInt("currPage") - 1) * requestMap.getInt("rowSize");
	
	//페이징 String
	String pageStr = "";
	if(listMap.keySize() > 0){
		pageStr += pageNavi.showFirst();
		pageStr += pageNavi.showPrev();
		pageStr += pageNavi.showPage();
		pageStr += pageNavi.showNext();
		pageStr += pageNavi.showLast();
	}
	
	StringBuffer html = new StringBuffer();

	if(listMap.keySize("seq") > 0){
		for(int i = 0; i < listMap.keySize("seq"); i++ ){
			html.append("<tr>");
			
			html.append("<td>");
			html.append(pageNum - i);			
			html.append("</td>");
			
			html.append("<td>");
			if(listMap.getString("memberPart", i).equals("1")){
				html.append("원장실");
				
			}else if(listMap.getString("memberPart", i).equals("2")){
				html.append("교육지원과");
				
			}else if(listMap.getString("memberPart", i).equals("3")){
				html.append("교육운영과");
				
			}else if(listMap.getString("memberPart", i).equals("4")){
				html.append("인재양성과");
				
			}

			html.append("</td>");
			
			html.append("<td>");
			if(listMap.getString("memberPartTeam", i).equals("1")){
				html.append("원장실");
				
			}
			
			else if(listMap.getString("memberPartTeam", i).equals("2")){
				html.append("교육직원담당");
			}
			else if(listMap.getString("memberPartTeam", i).equals("3")){
				html.append("기획평가담당");
			}
			else if(listMap.getString("memberPartTeam", i).equals("4")){
				html.append("운영담당");
			}
			else if(listMap.getString("memberPartTeam", i).equals("5")){
				html.append("사이버교육팀");
			}
			else if(listMap.getString("memberPartTeam", i).equals("6")){
				html.append("교수실");
			}
			//else if(listMap.getString("memberPartTeam", i).equals("6")){
			//	html.append("사이버교육팀");	
			//}	
			//else if(listMap.getString("memberPartTeam", i).equals("7")){
			//	html.append("교육분석팀");	
			//}
			
			else if(listMap.getString("memberPartTeam", i).equals("8")){
				html.append("교수실");
				
			}
			html.append("</td>");
			
			html.append("<td>");
			html.append("<a href=\"javascript:go_modify('"+listMap.getString("seq",i)+"');\">"+listMap.getString("username", i)+"</a>");
			html.append("</td>");
			
			html.append("<td>");
			html.append(listMap.getString("phoneNumber", i));
			html.append("</td>");
			
			html.append("<td class=\"br0\">");
			html.append(listMap.getString("content", i));
			html.append("</td>");
			html.append("</tr>");
		}
	}else{
		html.append("<tr>");
		html.append("<td class=\"br0\" style=\"height:100px;\" colspan=\"100%\"> 등록된 데이터가 없습니다.");
		html.append("</td>");
		html.append("</tr>");
	}

%>

<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->

<script language="JavaScript" type="text/JavaScript">
//페이지 이동
function go_page(page) {
	$("currPage").value = page;
	go_list();
}

//수정폼 이동
function go_modify(seq){
	$("mode").value = "from";
	$("qu").value = "modify";
	$("seq").value = seq;
	pform.action ="/member/employee.do";
	pform.submit();
}

//등록폼 이동
function go_form(qu){
	$("mode").value = "from";
	$("qu").value = qu;	
	pform.action ="/member/employee.do";
	pform.submit();
}


//리스트
function go_list(){
	$("mode").value = "list";
	pform.action ="/member/employee.do";
	pform.submit();
	
}


function go_search(){

	if(IsValidCharSearch($("name").value) == false){
		return false;
	}
	
	if(IsValidCharSearch($("content").value) == false){
		return false;
	}
		
	$("currPage").value = "";
	$("mode").value = "list";
	pform.action ="/member/employee.do";
	pform.submit();
}

onload = function(){

	//부서별검색 셀렉티드
	var part = "<%=requestMap.getString("part")%>";
	partLen = $("part").options.length;
	for(var i=0; i < partLen; i++) {
		if($("part").options[i].value == part){
			$("part").selectedIndex = i;
		}
	}
}


</script>

<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<form id="pform" name="pform" method="post">
<input type="hidden" name="currPage"			value='<%=requestMap.getString("currPage")%>'>
<input type="hidden" name="menuId" 				value="<%=requestMap.getString("menuId")%>">
<input type="hidden" name="mode"				value="<%=requestMap.getString("mode")%>">
<input type="hidden" name="qu"					value="<%=requestMap.getString("qu")%>">
<!-- 시퀀스 번호 -->
<input type="hidden" name="seq"					value="">

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
						<img src="/images/bullet003.gif"  align="bottom">&nbsp;<strong>직원관리</strong>
					</td>
				</tr>
			</table>
			<!--[e] subTitle -->
			<div class="h10"></div>
			<!--[s] Contents Form  -->
			<table cellspacing="0" cellpadding="0" border="0" width="100%"
				class="contentsTable">
				<tr>
					<td>
						<!-- 검색  -->
						<table class="search01">
							<tr>
								<th width="80" class="bl0">
									부서별 검색
								</th>
								<td>
									<select name="part" class="mr10">
										<option selected value="">
											**** 선택하십시오. ****
										</option>
										<option value="1">
										원장실
										</option>
										<option value="2">
										교육직원담당
										</option>
										<option value="3">
										기획평가담당
										</option>
										<option value="4">
										운영담당
										</option>
										<option value="5">
										사이버교육담당
										</option>
										<option value="6">
										교수실
										</option>
										<!-- option value="7">
										관리담당
										</option -->
									</select>
								</td>
								<th width="100">
									이름
								</th>
								<td>
									<input type="text" onkeypress="if(event.keyCode==13){go_search('name');return false;}"  class="textfield" maxlength="10" name="name" value="<%=requestMap.getString("name") %>">
								</td>
								<td width="100" rowspan="2" class="btnr">
									<input type="button" value="조회" onclick="go_search();" class="boardbtn1">
								</td>
							</tr>
							<tr>
								<th class="bl0">업무명</th>
								<td colspan="3"><input type="text" onkeypress="if(event.keyCode==13){go_search('content');return false;}"  maxlength="20" size="25" class="textfield" name="content" value="<%=requestMap.getString("content") %>"></td>
							</tr>
						</table>
						<!--//검색  -->	
						<div class="space01"></div>

						<!-- 리스트  -->
						<table class="datah01">
							<thead>
							<tr>
								<th>번호</th>
								<th>부서</th>
								<th>직위</th>
								<th>이름</th>
								<th>전화번호</th>
								<th class="br0">담당업무</th>
							</tr>
							</thead>

							<tbody>
							<%=html.toString() %>
							</tbody>
						</table>
						<!--//리스트  -->
						<div class="h10"></div>
						<!-- 테이블하단 버튼   -->
						<table class="btn01" style="clear:both;">
							<tr>
								<td class="right">
									<input type="button" value="등록" onclick="go_form('insert');" class="boardbtn1">
								</td>
							</tr>
						</table>
						<!-- //테이블하단 버튼  -->

						<!--[s] 페이징 -->
						<div class="paging">
                       		<table cellspacing="0" cellpadding="0" border="0" width="100%" class="contentsTable">
                        		<tr>
                        			<td width="100%" align="center" colspan="100%"><%=pageStr%></td>
                        		</tr>
                        	</table>	
						</div>
						<!-- //[s] 페이징 -->
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



