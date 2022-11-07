<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 명강의 동영상관리
// date  : 2008-08-7
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
	
	
	//파일 정보 START
	String fileStr = "";
	String tmpStr = ""; //넘어가는 값.

	DataMap fileMap = (DataMap)listMap.get("FILE_GROUP_LIST");

	if(fileMap == null)
		fileMap = new DataMap();
	fileMap.setNullToInitialize(true);

	for(int i=0; i < fileMap.keySize("groupfileNo"); i++){

		if(fileMap.getString("groupfileNo", i).equals("0")){
			continue;
		}
		
		tmpStr = fileMap.getString("groupfileNo", i) + "#" + fileMap.getString("fileNo", i); 
// 		fileStr += "document.InnoDS.AddTempFile('" + fileMap.getString("fileName", i) + "', " + fileMap.getInt("fileSize", i) + ", '" + tmpStr + "');";
// 		fileStr += "g_ExistFiles['" + tmpStr + "'] = false;";

        fileStr += "var input"+i+" = document.createElement('input');\n";
		fileStr += "input"+i+".value='"+fileMap.getString("fileName", i)+"';\n";
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

//리스트
function go_list(){
	$("title").value = "<%=requestMap.getString("title")%>";
	$("mode").value = "list";
	pform.action = "/homepageMgr/moveLect.do?mode=list";
	pform.submit();
}

//리스트
function go_save(){
	if(NChecker($("pform"))){
		if($("qu").value == "insert"){
			if( confirm('등록하시겠습니까?')){
				$("mode").value="exec";	
				pform.action = "/homepageMgr/moveLect.do?mode=exec";
				pform.submit();
			}
		}else if($("qu").value == "modify"){
			if( confirm('수정하시겠습니까?')){
				$("mode").value="exec";	
				pform.action = "/homepageMgr/moveLect.do?mode=exec";
				pform.submit();
			}
		}
	}
}


//식단관리 삭제
function go_delete(){
	if( confirm('삭제하시겠습니까?')){
		$("mode").value="exec";
		$("qu").value="delete";
		pform.action = "/homepageMgr/moveLect.do?mode=exec";
		pform.submit();
	}
}

//	수정시 inno에 기존 파일 넣은 변수 및 함수.
var g_ExistFiles = new Array();
function OnInnoDSLoad(){

}
	
	
//로딩시.
onload = function()	{
	<%= fileStr %>

}


//-->
</script>


<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<form id="pform" name="pform" method="post" enctype="multipart/form-data">
<input type="hidden" name="currPage"			value="<%=requestMap.getString("currPage")%>">
<input type="hidden" name="menuId" 				value="<%= requestMap.getString("menuId") %>">
<input type="hidden" name="mode"				value="<%= requestMap.getString("mode") %>">
<input type="hidden" name="currPage"			value="<%= requestMap.getString("currPage")%>">
<input type="hidden" name="qu"					value="<%= requestMap.getString("qu") %>">
<input type="hidden" name="seq"					value="<%= requestMap.getString("seq") %>">
<input type="hidden" name="sessNo"				value="<%= memberInfo.getSessNo() %>">
<input type="hidden" name="sessName"			value="<%= memberInfo.getSessName() %>">

<!-- INNO FILEUPLOAD 사용시 UPLOAD 경로 지정해줌.-->
<input type="hidden" name="INNO_SAVE_DIR"		value='<%=Constants.UPLOADDIR_HOMEPAGE%>'>



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
			<div class="h10"></div>
			<!--[s] Contents Form  -->
			<table cellspacing="0" cellpadding="0" border="0" width="100%"
				class="contentsTable">
				<tr>
					<td>
						<!-- date -->
						<table  class="dataw01">
							<tr>
								<th style="border-left:0px solid #E5E5E5;">제목</th>
								<td style="border-right:0px solid #E5E5E5;">
									<input type="text" class="textfield" maxLength="50" required="true!제목을 입력하십시오." name="title" size="82" value="<%=listMap.getString("title") %>"/>
								</td>
							</tr>
							<tr>
								<th style="border-left:0px solid #E5E5E5;">구분</th>
								<td style="border-right:0px solid #E5E5E5;">
									MMS방식 : <input type="radio" name="gubun" value="1" <%=listMap.getString("gubun").equals("1") ? "checked" : ""%>>
									팝업방식 : <input type="radio" name="gubun" value="2" <%=!listMap.getString("gubun").equals("1") ? "checked" : ""%>>
									
								</td>
							</tr>
							<tr>
								<th style="border-left:0px solid #E5E5E5;">썸네일 이미지<br />업로드</th>
								<td style="border-right:0px solid #E5E5E5;"> 
	                                <jsp:include page="/fileupload/multplFileSelector.jsp" flush="true">
										<jsp:param name="maxFileCount" value="1"/>
									</jsp:include>

								</td>
							</tr>
							<tr>
								<th style="border-left:0px solid #E5E5E5;">동영상 링크(URL)</th>
								<td style="border-right:0px solid #E5E5E5;">
									<input type="text" maxLength="280" required="true!동영상링크를 입력 하십시오." size="82" class="textfield" name="url" value="<%=listMap.getString("url") %>"  \/>
								</td>
							</tr>
						</table>
						<!-- //date -->

						<!-- 테이블하단 버튼  -->
						<table class="btn01" style="clear:both;">
							<tr>
								<td class="right">
									<input type="button" value="저장" onclick="go_save();" class="boardbtn1">
									<%if(requestMap.getString("qu").equals("modify")){ %>
										<input type="button" value="삭제" onclick="go_delete();" class="boardbtn1">
										
									<%} %>
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
        </td>
    </tr>
</table>

<!--[s] bottom -->
<jsp:include page="/commonInc/include/commonAdminBottom.jsp" flush="false"/>
<!--[e] bottom -->

</form>
</body>