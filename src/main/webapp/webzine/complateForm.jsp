<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : Webzine 관리 사진리스트
// date : 2008-07-02
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

    //사진 ROW데이터
	DataMap rowMap = (DataMap)request.getAttribute("PHOTOROW_DATA");
	rowMap.setNullToInitialize(true); 

	
	//파일 정보 START
	String fileStr = "";
	String tmpStr = ""; //넘어가는 값.

	for(int i=0; i < rowMap.keySize("photoNo"); i++){

		tmpStr = rowMap.getString("photoNo", i); 
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


function go_save(qu){
	var msg = "";
	
	if($("wcomments").value == "" || $("wcomments").value == null){
		alert("코멘트를  입력하십시오.");
		return false;
	}

	
	if($("wcomments").value.length > 100){
		alert("코멘트의 글자수는 최대 100글자까지만 입력 가능합니다.");
		return false;
	}
	
	if(qu == "insertComplate"){
		msg = "등록 하시겠습니까?";
		
	}else{
		msg = "수정 하시겠습니까? \n만약 이미지 파일이 없으실 경우 \n모든 데이터가 지워집니다.";
	
	}
	
	
	if(confirm(msg)){
		$("mode").value = "complateExec";
		$("qu").value = qu;
		pform.action = "/webzine.do?mode=complateExec";
		pform.submit();
	}
}

//-->
</script>
<!-- INNO FILEUPLOAD 사용시 UPLOAD 경로 지정해줌.-->

<body>
<form id="pform" name="pform" method="post" enctype="multipart/form-data">
<input type="hidden" name="mode"			value="">
<input type="hidden" name="qu"				value="">
<input type="hidden" name="imgPath"			value="<%=requestMap.getString("imgPath") %>">
<input type="hidden" name="photoNo"			value="<%=requestMap.getString("photoNo") %>">
<input type="hidden" name="menuId"			value="<%=requestMap.getString("menuId") %>">
<input type="hidden" name="date"			value="<%=requestMap.getString("date")%>">
<input type="hidden" name="currPage"		value='<%=requestMap.getString("currPage")%>'>

<input type="hidden" name="RENAME_YN" value="Y">
<input type="hidden" name="INNO_SAVE_DIR"		value='<%=Constants.UPLOADDIR_WEBZINE%>'>

<table class="pop01">
	<tr>
		<td class="con">

			<div class="space01"></div>
			<table style="padding: 0 0 0 0">
				<tr>
					<td width="100%" align="left" class="br0">
						<!-- 타이틀영역 -->
						<div class="" align="left" >
							<h1 class="h1"><img src="/images/bullet_pop.gif" />사진추가</h1>
						</div>
						<!--// 타이틀영역 -->
					</td>
				</tr>
			</table>
			<!-- 파일업로드 컴포넌트 [s] -->
			<table class="">
				<tr bgcolor="#5071B4">
					<td colspan="100%" height="2"></td>
				</tr>
				<tr>
					<td class="tableline21" align="left" class="br0">&nbsp;

                                    <jsp:include page="/fileupload/multplFileSelector.jsp" flush="true">
										<jsp:param name="maxFileCount" value="1"/>
									</jsp:include>

					</td>
				</tr>
			
			<!-- 파일업로드 컴포넌트[e]  -->	
				<tr>
					<td><div class="space01"></div></td>
				</tr>
				<tr>
					<td width="100%" align="left" class="br0">
						<!-- 타이틀영역 -->
							<strong>코멘트</strong>
						<!--// 타이틀영역 -->
					</td>
				</tr>
				<tr>
					<td height="28" class="tableline11" align="left" width="100%" class="br0">
						<textarea name="wcomments" class="textarea" cols="60" rows="3"><%=rowMap.getString("wcomments") %></textarea>
					</td>
				</tr>
				<tr bgcolor="#5071B4">
					<td colspan="100%" height="2"></td>
				</tr>
			</table>

			
			<div class="space01"></div>

			<!-- 하단 닫기 버튼  -->
			<table class="btn02">
				<tr>
					<td class="center" class="br0">
						<input type="button" value="저장" onclick="go_save('<%=requestMap.getString("qu") %>');" class="boardbtn1">&nbsp;<input type="button" value="창닫기" onclick="self.close();" class="boardbtn1">
					</td>
				</tr>
			</table>
			<!--// 하단 닫기 버튼  -->
		</td>
	</tr>
</table>
</form>

</body>
