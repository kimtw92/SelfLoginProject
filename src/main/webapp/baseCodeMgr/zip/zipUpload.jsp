<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 우편번호관리 폼
// date : 2008-05-24
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
	String navigationStr = LoginCheck.NavigationCreate(memberInfo, navigationMap);
	////////////////////////////////////////////////////////////////////////////////////
	
	//리스트 데이터
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	listMap.setNullToInitialize(true);
		
	
%>
<%@ page language="java" import="java.util.*"%><%
   String file_path = "D:/resin/webapps"+request.getParameter("file_path");

%>


<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->

<script language="JavaScript" type="text/JavaScript">

function searchZip(){
	
	
	var popWindow = popWin('about:blank', 'majorPop11', '400', '250', 'no', 'no');
	pform.target = "majorPop11";
	pform.action = "/search/searchZip.do";
	pform.submit();
	pform.target = "";
}

//일괄데이터 입력
function go_exec(){
	if($("file").value == ""){
		alert("파일을 선택하여 주십시오.");
		return false;
	}
	
	if( confirm('등록하시겠습니까?')){
		$("mode").value = "zipUploadExec";
		pform.action = "/search/searchZip.do";
		pform.submit();
	}
	
}

</script>

<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<form id="pform" name="pform" method="post" enctype="multipart/form-data">
<input type="hidden" name="mode" value="">
<input type="hidden" name="menuId" value="<%=requestMap.getString("menuId") %>">
<input type="hidden" name="UPLOAD_DIR"		 	value="<%=Constants.DIRECT_FILE_TEMP%>">
<input type="hidden" name="filePath" value="baseCodeMgr/zip/">
<input type="hidden" name="fileName" value="zipcode.xls">

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
						<img src="/images/bullet003.gif"  align="bottom">&nbsp;<strong>우편번호 관리 일괄입력.</strong>
					</td>
				</tr>
			</table>
			<!--[e] subTitle -->

			<!--[s] Contents Form  -->
			<table cellspacing="0" cellpadding="0" border="0" width="100%" class="contentsTable">

				<tr>
					<td>
                        <!---[s] content -->

						<!-- space --><table width="100%" height="10"><tr><td></td></tr></table>
						<table cellspacing="0" cellpadding="0" border="0" width="100%" class="contentsTable">
							<tr bgcolor="#375694">
								<td height="2" colspan="100%"></td>
							</tr>
							<tr>
								<td align='center' bgcolor="#E4EDFF" class="tableline11"><strong>우편번호 일관데이터 :</strong></td>
								<td class="tableline21" style="padding-left:10px"><input size="40" type=file name=file class=finput class="boardbtn1"></td>
		                    </tr>
							<tr>
								<td class="tableline21" align='center' colspan='2'>엑셀 파일로 업로드 하시면 기존 데이터가 삭제된 후 삽입이 됩니다.
								<input type="button" value='입력' onclick="go_exec();" class="boardbtn1">&nbsp;&nbsp;&nbsp;
								<input type="button" value='업로드파일 서식 다운로드' onClick="fnGoFileDown('zipcode.xls', '/excel/');" class="boardbtn1"></td>
		                    </tr>
							<tr>
								<td class="tableline21" align='center' colspan='2'><input type="button" value='검색' onClick="searchZip();" class="boardbtn1"></td>
							</tr>
							<tr bgcolor="#375694">
								<td height="2" colspan="100%"></td>
							</tr>										
						</table>	
                        <!---[e] content -->
                        
                       
                        
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






