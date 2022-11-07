<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 파일 업로드  팝업
// date  : 2008-07-02
// auth  : kang
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
	    
	////////////////////////////////////////////////////////////////////////////////////
	
	
	
	String fileStr = "";
	String tmpStr = ""; //넘어가는 값.

	DataMap fileMap = (DataMap)request.getAttribute("LIST_DATA");
	if(fileMap == null) fileMap = new DataMap();
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



%>


<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->

<script language="JavaScript" type="text/JavaScript">
// <!--

function fnUpload(){
	if(confirm("업로드 하시겠습니까 ?")){
		$("mode").value = "exec";
		pform.action = "/commonInc/commonFileUploadPop.do?mode=exec";
		pform.submit();
	}
}


//수정시 inno에 기존 파일 넣은 변수 및 함수.
var g_ExistFiles = new Array();
function OnInnoDSLoad(){


}

window.onload = function(){
	<%= fileStr %>
}

//-->
</script>

<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<form id="pform" name="pform" method="post" enctype="multipart/form-data" >

<input type="hidden" name="menuId" id="menuId" 	value="<%= requestMap.getString("menuId") %>">
<input type="hidden" name="mode" id="mode" value="<%= requestMap.getString("mode") %>">

<input type="hidden" name="retObj" id="retObj" value="<%= requestMap.getString("retObj") %>">


<input type="hidden" name="INNO_SAVE_DIR"		value='<%= Constants.UPLOADDIR_TUTOR %>'>




<table cellspacing="0" cellpadding="0" border="0" width="100%">
	<tr><td height="4" bgcolor="#0081C4" nowrap></td></tr>
	<tr>
		<td height="45" bgcolor="#FFFFFF" style="padding-left:10px" nowrap>
			<!--[s] 타이틀 영역-->
			<table cellspacing="0" cellpadding="0" border="0">
				<tr>
					<td width="15" align="left"><img src="/images/bullet_pop.gif" width="10" height="22" border="0"></td>
					<td><font color="#000000" style="font-weight:bold; font-size:13px">파일 업로드</font></td>
				</tr>
			</table>
			<!--[e] 타이틀 영역-->
		</td>
	</tr>
	<tr>
		<td class="popupContents" valign="top" bgcolor="#E4E3E4">
		
			<!--[s] contents  -->
			<table class="tab01">				
				<tr>
					<td align="center">
					
                                <jsp:include page="/fileupload/multplFileSelector.jsp" flush="true"/>
						
					</td>
				</tr>
			</table>
			
			<!--[e] contents -->
			
		</td>
	</tr>
	<tr>
		<td height="50" align="center" nowrap>
			<input type="button" name="btnCancel" value="업로드" onclick="fnUpload();" class="boardbtn1">
			<input type="button" name="btnCancel" value="닫 기"  onclick="self.close();" class="boardbtn1">
		</td>
	</tr>
</table>


</form>
</body>