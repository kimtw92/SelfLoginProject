<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 과정 토론방 상세보기.
// date : 2008-07-09
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

	//질문 상세 정보
	DataMap rowMap = (DataMap)request.getAttribute("ROW_DATA");
	rowMap.setNullToInitialize(true);

	//파일 정보
	String rowFileStr = "";
	DataMap fileMap = (DataMap)rowMap.get("FILE_GROUP_LIST");
	if(fileMap == null) fileMap = new DataMap();
	fileMap.setNullToInitialize(true);
	
	for(int i=0; i < fileMap.keySize("groupfileNo"); i++){
		if(!rowFileStr.equals(""))
			rowFileStr += "<br><br>";

		tmpStr = "javascript:fileDownload(" + fileMap.getInt("groupfileNo", i) + ", " + fileMap.getInt("fileNo", i) + ");";
		rowFileStr += "<a href=\"" + tmpStr + "\"><b>" + fileMap.getString("fileName", i) + "</b></a>";
	}


%>

<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->

<script language="JavaScript" type="text/JavaScript">
<!--
//리스트
function go_list(){

	$("mode").value = "list";

	pform.action = "/courseMgr/discuss.do";
	pform.submit();

}

//수정
function go_modify(){

	$("mode").value = "form";
	$("qu").value = "update";

	pform.action = "/courseMgr/discuss.do";
	pform.submit();

}

//답변
function go_reply(){

	$("mode").value = "form";
	$("qu").value = "reply";

	pform.action = "/courseMgr/discuss.do";
	pform.submit();

}

//삭제
function go_delete(){

	if(confirm("삭제하시겠습니까?")){
		$("mode").value = "exec";
		$("qu").value = "delete";

		pform.action = "/courseMgr/discuss.do";
		pform.submit();
	}
}



//로딩시.
onload = function()	{

}


//-->
</script>
<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<form id="pform" name="pform" method="post">
<input type="hidden" name="menuId"				value="<%= requestMap.getString("menuId") %>">
<input type="hidden" name="mode"				value="<%= requestMap.getString("mode") %>">

<input type="hidden" name="currPage"			value="<%= requestMap.getString("currPage") %>">
<input type="hidden" name="qu"					value="">
<input type="hidden" name="searchKey"			value='<%=requestMap.getString("searchKey")%>'>
<input type="hidden" name="searchValue"			value='<%=requestMap.getString("searchValue")%>'>

<input type="hidden" name="grcode"				value="<%= requestMap.getString("grcode") %>">
<input type="hidden" name="grseq"				value="<%= requestMap.getString("grseq") %>">

<input type="hidden" name="seq"					value="<%= requestMap.getString("seq") %>">

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



<!--[ 코딩 시작 ] ------------------------------------------------------------------------------------------------------>
			<div class="h10"></div>
			<!--[s] Contents Form  -->
			<table cellspacing="0" cellpadding="0" border="0" width="100%"
				class="contentsTable">
				<tr>
					<td>
						<!-- subTitle -->
						<h2 class="h2"><img src="/images/bullet003.gif"> 과정토론방 보기 </h2>
						<!--// subTitle -->
						<div class="h5"></div>

						<!-- date -->
						<table  class="dataw01">
							<tr>
								<th width="70">제목</th>
								<td colspan="3">
									<%= rowMap.getString("title") %>
								</td>
							</tr>
							<tr>
								<th>작성자</th>
								<td>
									<%= rowMap.getString("username") %>(<%= rowMap.getString("wuserno") %>)
								</td>
								<th>작성일</th>
								<td>
									<%= rowMap.getString("regdate") %>
								</td>
							</tr>
							<tr>
								<th>내용</th>
								<td colspan="3" style="height:200px" valign="top">
									<%=StringReplace.convertHtmlDecodeNamo(rowMap.getString("content"))%>
								</td>
							</tr>
							<% if(!rowFileStr.equals("")){ %>
							<tr>
								<th>첨부파일</th>
								<td colspan="3" >
									<%= rowFileStr %>
								</td>
							</tr>
							<% } %>
						</table>
						<!-- //date -->
						
						<!-- 테이블하단 버튼  -->
						<table class="btn01" style="clear:both;">
							<tr>
								<td class="right">
								<% 
								//삭제된 글인지 확인.
								if(rowMap.getInt("groupfileNo") > -2){ 
								%>
										<input type="button" value=" 수정 "	onclick="go_modify();" class="boardbtn1">
										<input type="button" value=" 삭제 "	onclick="go_delete();" class="boardbtn1">
								<% 
									if(rowMap.getInt("topRank") <= 0){
								%>
										<input type="button" value=" 답변 "	onclick="go_reply();" class="boardbtn1">
								<% 
									}
								}
								%>
									<input type="button" value="리스트" onclick="go_list();" class="boardbtn1">
								</td>
							</tr>
						</table>
						<!-- //테이블하단 버튼  -->

					</td>
				</tr>
			</table>
			<!--//[e] Contents Form  -->
			<div class="space_ctt_bt"></div>
<!--[ 코딩 끝 ] ------------------------------------------------------------------------------------------------------>

				                            
        </td>
    </tr>
</table>

<!--[s] bottom -->
<jsp:include page="/commonInc/include/commonAdminBottom.jsp" flush="false"/>
<!--[e] bottom -->
	
</form>
</body>

