<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%  
// prgnm : 과목코드별 문항관리 > 엑셀 일괄입력
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
%>

<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->

<script language="JavaScript" type="text/JavaScript">
	//등록
	function go_save()	{
		if($("file").value == ""){
			alert("등록하실 파일을 선택하여 주십시오.");
			return false;
		}
		if( confirm('등록하시겠습니까?')){
// 			alert($("subj").value);
			$("mode").value = "mInsert";
			pform.action = "/baseCodeMgr/questionMgr.do?mode="+$("mode").value;
			pform.submit();
		}
	}
</script>


<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<form id="pform" name="pform" method="post" enctype="multipart/form-data">
<input type="hidden" name="menuId" id="menuId" value="<%= requestMap.getString("menuId") %>">
<input type="hidden" name="mode" id="mode" value="">

<input type="hidden" name="subj" id="subj" value="<%= requestMap.getString("subj") %>">
<input type="hidden" name="subjnm" id="subjnm" value="<%= requestMap.getString("subjnm") %>">

<!-- 과목 리스트 검색결과 유지 -->
<input type="hidden" name="s_subjIndexSeq" value="<%= requestMap.getString("s_subjIndexSeq") %>">
<input type="hidden" name="s_indexSeq">
<input type="hidden" name="s_subjUseYn" value="<%= requestMap.getString("s_subjUseYn") %>">
<input type="hidden" name="s_subType" value="<%= requestMap.getString("s_subType") %>">
<input type="hidden" name="s_subjSearchTxt" value="<%= requestMap.getString("s_subjSearchTxt") %>">
<!-- 과목 리스트 페이징 유지 -->
<input type="hidden" name="subjCurrPage" id="subjCurrPage" value="<%= requestMap.getString("subjCurrPage")%>">

<!-- 검색 -->
<input type="hidden" name="s_difficulty" value="<%= requestMap.getString("s_difficulty") %>">
<input type="hidden" name="s_useYn" value="<%= requestMap.getString("s_useYn") %>">
<input type="hidden" name="s_qType" value="<%= requestMap.getString("s_qType") %>">

<!-- 페이징 -->
<input type="hidden" name="currPage" id="currPage" value="<%= requestMap.getString("currPage")%>">

<input type="hidden" name="UPLOAD_DIR" value="<%=Constants.DIRECT_FILE_TEMP%>">

<input type="hidden" name="hidContents" id="hidContents">

	<!--[s] subTitle -->
	<table width="100%" border="0" cellspacing="0" cellpadding="0" class="pop01">			
		<tr>
			<td height="20" class="titarea">
				<div class="tit">
					<h1 class="h1"><img src="../images/bullet_pop.gif" /> 과목코드별 문항관리 엑셀 엘괄 입력</h1>
				</div>
			</td>
		</tr>

		<tr>
			<td class="con">
				<!-- space --><table width="100%" height="10"><tr><td></td></tr></table>
					
					<table cellspacing="0" cellpadding="0" border="0" width="100%" class="contentsTable">
							<tr bgcolor="#5071B4"><td height="2" colspan="100%"></td></tr>
							 <tr>
								<td align='center' class="tableline11" width="150" bgcolor="#F7F7F7"><strong>문항 일괄 데이터 </strong></td>
								<td class="tableline11">&nbsp;
									<input type="file" name="file" class="finput" style="width:100%;" class="boardbtn1"></td>
		                    </tr>
							<tr>
								<td class="" align='center' colspan='2'><input type="button" value='입력' onClick="go_save();" class="boardbtn1"></td>
							</tr>
							<tr bgcolor="#5071B4"><td height="2" colspan="100%"></td></tr>
									
		                </table>
                      <!---[e] content -->
	        </td>
	    </tr>
	</table>

		
</form>
</body>






