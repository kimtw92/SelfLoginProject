<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 과정기수의 첨부파일 추가 / 수정
// date : 2008-09-09
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

    //과정 기수 정보.
	DataMap rowMap = (DataMap)request.getAttribute("ROW_DATA");
	rowMap.setNullToInitialize(true); 

	
	//파일 정보 START
	String fileStr = "";
	String tmpStr = ""; //넘어가는 값.

	DataMap fileMap = (DataMap)rowMap.get("FILE_GROUP_LIST");
	if(fileMap == null)
		fileMap = new DataMap();
	fileMap.setNullToInitialize(true);

	for(int i=0; i < fileMap.keySize("groupfileNo"); i++){

		if(fileMap.getInt("groupfileNo", i)==0){
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
	//파일 정보 END

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


function go_save(){
	
	if(confirm("파일을 등록 하시겠습니까?")){
// 		document.querySelector('input[name=mode]').value = "exec";
// 		document.querySelector('input[name=qu]').value = "file_form";
		$('mode').value = "exec";
		$('qu').value = "file_form";
		pform.action = "/courseMgr/courseSeq.do?mode=exec";
		pform.submit();
	}
}

//-->
</script>
<!-- INNO FILEUPLOAD 사용시 UPLOAD 경로 지정해줌.-->



<body>
<form id="pform" name="pform" method="post" enctype="multipart/form-data">
<input type="hidden" name="menuId"			value="<%=requestMap.getString("menuId") %>">
<input type="hidden" name="mode"			value="<%=requestMap.getString("mode") %>">
<input type="hidden" name="qu"				value="<%=requestMap.getString("qu") %>">

<input type="hidden" name="grcode"			value="<%=requestMap.getString("grcode") %>">
<input type="hidden" name="grseq"			value="<%=requestMap.getString("grseq") %>">

<input type="hidden" name="INNO_SAVE_DIR"		value='<%=Constants.UPLOADDIR_COURSE%>'>

<table class="pop01">
	<tr>
		<td class="con">

			<div class="space01"></div>
			<table style="padding: 0 0 0 0">
				<tr>
					<td width="100%" align="left" class="br0">
						<!-- 타이틀영역 -->
						<div class="" align="left" >
							<h1 class="h1"><img src="/images/bullet_pop.gif" />과정기수 첨부파일 등록 / 수정</h1>
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

								<jsp:include page="/fileupload/multplFileSelector.jsp" flush="true"/>

					</td>
				</tr>
			
			<!-- 파일업로드 컴포넌트[e]  -->	
				<tr>
					<td><div class="space01"></div></td>
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
						<input type="button" value="저장" onclick="go_save();" class="boardbtn1">
						<input type="button" value="닫기" onclick="self.close();" class="boardbtn1">
					</td>
				</tr>
			</table>
			<!--// 하단 닫기 버튼  -->
		</td>
	</tr>
</table>
</form>

</body>
