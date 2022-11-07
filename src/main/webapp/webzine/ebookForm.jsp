<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : Webzine 관리 E-book
// date : 2008-07-02
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
	

    //Ebook 관리 Row데이터
	DataMap rowMap = (DataMap)request.getAttribute("EBOOKROW_DATA");
	rowMap.setNullToInitialize(true); 

	
	//파일 정보 START
	String fileStr = "";
	String tmpStr = ""; //넘어가는 값.

	for(int i=0; i < rowMap.keySize("ebookNo"); i++){

		tmpStr = rowMap.getString("ebookNo", i); 
// 		fileStr += "document.InnoDS.AddTempFile('" + rowMap.getString("imgName", i) + "', '" + tmpStr + "');";
// 		fileStr += "g_ExistFiles['" + tmpStr + "'] = false;";
        fileStr += "var input"+i+" = document.createElement('input');\n";
		fileStr += "input"+i+".value='"+rowMap.getString("imgName", i)+"';\n";
		fileStr += "input"+i+".setAttribute('fileNo', '"+tmpStr+"');\n";
		fileStr += "input"+i+".name='existFile';\n";
		fileStr += "multi_selector.addListRow(input"+i+");\n\n";

	}

%>
<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->

<script language="JavaScript">
<!--
//수정시 inno에 기존 파일 넣은 변수 및 함수.
var g_ExistFiles = new Array();
function OnInnoDSLoad(){


}

window.onload = function(){
	
	<%= fileStr %>
}

function go_list(){
	$("mode").value = "ebookList";
	$("qu").value = "";
	pform.action = "/webzine.do?mode=ebookList";
	pform.submit();
}

function go_save(qu){
	var msg = "";
	
	if(qu == "insertEbook"){
		msg = "등록 하시겠습니까?";
	}else if(qu == "delete"){
		msg = "삭제 하시겠습니까?";
	}else{	
		msg = "수정 하시겠습니까?";
	}
	
	if(confirm(msg)){
		$("mode").value = "ebookExec";
		$("qu").value = qu;
		pform.action = "/webzine.do?mode=ebookExec";
		pform.submit();
	}
}

//-->
</script>
<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >
<form id="pform" name="pform" method="post" enctype="multipart/form-data">
<input type="hidden" name="mode"			value="">
<input type="hidden" name="qu"				value="">
<input type="hidden" name="menuId"			value="<%=requestMap.getString("menuId") %>">
<input type="hidden" name="currPage"		value='<%=requestMap.getString("currPage")%>'>
<input type="hidden" name="ebookNo"		value='<%=requestMap.getString("ebookNo")%>'>
<!-- 기존이미지 경로 -->
<input type="hidden" name="imgPath"			value="<%=requestMap.getString("imgPath") %>">
<!-- 넘버값 -->
<input type="hidden" name="photoNo"			value="<%=requestMap.getString("ebookNo") %>">

<!-- 파일관련 함수 -->
<input type="hidden" name="RENAME_YN" value="Y">
<input type="hidden" name="INNO_SAVE_DIR"		value='<%=Constants.UPLOADDIR_WEBZINE%>'>

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
						<img src="/images/bullet003.gif"  align="bottom">&nbsp;<strong>E-Book<%=requestMap.getString("qu").equals("insertEbook") ? "등록" : "수정"%></strong>
					</td>
				</tr>
			</table>
			<!--[e] subTitle -->

			<!--[s] Contents Form  -->
			<table cellspacing="0" cellpadding="0" border="0" width="100%" class="contentsTable">
				<tr>
					<td>
					<div class="space01"></div>
					<!---[s] content -->
					<table  cellspacing="0" cellpadding="0" border="0" width="100%" class="">
						<tr bgcolor="#5071B4">
							<td colspan="100%" height="2"></td>
						</tr>
						
						<tr>
							<td width="100" class="tableline11" style="padding-left:10px;" bgcolor="#E4EDFF" align="left">
									<strong>제목</strong>
							</td>
							<td height="28" class="tableline21" style="padding-left:10px;" align="left" width="" class="br0">
								<input type="text" maxlength="50" class="textfield" required="true!제목을 입력하세요." name="ebookTitle" size="65" value="<%=rowMap.getString("ebookTitle")%>">
							</td>
						</tr>
						
						
						<tr>
							<td width="" class="tableline11" style="padding-left:10px;" bgcolor="#E4EDFF" align="left">
									<strong>컨텐츠 분류 </strong>
							</td>
							<td height="28" class="tableline21" style="padding-left:10px;" align="left" width="" class="br0">
								<input type="text" maxlength="50" class="textfield" size="65" name="ebookAuth" value="<%=rowMap.getString("ebookAuth")%>">
							</td>
						</tr>				
						
						<tr>
							<td width="" align="left" bgcolor="#E4EDFF" style="padding-left:10px;" class="tableline11">
									<strong>LINK 주소 </strong>
							</td>
							<td height="28" class="tableline21" style="padding-left:10px;" align="left" width="" class="br0">
								<input type="text" required="true!LINK주소를 입력하세요." maxlength="100" class="textfield" name="ebookLink" size="65" value="<%=rowMap.getString("ebookLink")%>">
							</td>
						</tr>
						
						<tr>
							<td width="" class="tableline11" bgcolor="#E4EDFF" style="padding-left:10px;" align="left">
									<strong>제작 일시</strong>
							</td>
							<td height="28" class="tableline21" style="padding-left:10px;" align="left" width="" class="br0">
								<input type="text" class="textfield" name="grseq" size="15" style="cursor:hand" onclick="fnPopupCalendar('pform', 'grseq')" value="<%=rowMap.getString("grseq")%>" readonly>&nbsp;
								<img src = "/images/icon_calendar.gif" style="cursor:hand" onclick="fnPopupCalendar('pform', 'grseq')" border = 0 align = absmiddle>
							</td>
						</tr>
						
						
						<tr>
							<td width="" align="left" bgcolor="#E4EDFF" style="padding-left:10px;" class="tableline11">
									<strong>총 페이지수</strong>
							</td>
							<td height="28" class="tableline21" style="padding-left:10px;" align="left" width="" class="br0">
								<input type="text" maxlength="15" class="textfield" name="ebookPage" size="15" value="<%=rowMap.getString("ebookPage")%>"> PAGE
							</td>
						</tr>											
		
						<tr>
							<td width="" align="left" bgcolor="#E4EDFF" style="padding-left:10px;" class="tableline11" >
									<strong>사용여부</strong>
							</td>
							<td height="28" class="tableline21" style="padding-left:10px;" align="left" width="" class="br0">
								<input type="radio" name="useYn" value="Y" <%=rowMap.getString("useYn").equals("Y") ? "checked" : ""%>>사용&nbsp;&nbsp;
								<input type="radio" name="useYn" value="N" <%=!rowMap.getString("useYn").equals("Y") ? "checked" : ""%>>사용안함
							</td>
						</tr>
						
						<tr>
							<td width="" align="left" bgcolor="#E4EDFF" style="padding-left:10px;" class="tableline11">
									<strong>파일</strong>
							</td>
								
							<td class="tableline21" align="left" colspan="0" class="br0">&nbsp;
		
                                    <jsp:include page="/fileupload/multplFileSelector.jsp" flush="true">
										<jsp:param name="maxFileCount" value="1"/>
									</jsp:include>
		
							</td>
						</tr>
					
					<!-- 파일업로드 컴포넌트[e]  -->	
					
						<tr bgcolor="#5071B4">
							<td colspan="100%" height="2"></td>
						</tr>
					</table>
					<!-- 저장/리스트버튼[s] -->
					<table class="btn02">
						<tr>
							<td class="center">
								<input type="button" value="저장" onclick="go_save('<%=requestMap.getString("qu") %>');" class="boardbtn1">&nbsp;
								<% if(requestMap.getString("qu").equals("modifyEbook")){ %>
									<input type="button" value="삭제" onclick="go_save('delete');" class="boardbtn1">&nbsp;
								<%} %>
								<input type="button" value="취소" onclick="go_list();" class="boardbtn1">
							</td>
						</tr>
					</table>
					<!-- 저장/리스트버튼[e] -->
						<div class="space01"></div>

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

