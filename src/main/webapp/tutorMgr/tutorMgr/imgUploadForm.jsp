<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 사진등록 팝업
// date  : 2008-06-25
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
	
	
	
	
	
%>

<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->

<script language="JavaScript" type="text/JavaScript">
<!--

/*
사용안함
function ShowImageWithModalBox(objImage) {

	if (objImage == "") {
		alert("미리보기 하실 이미지를 선택해 주십시요");
		return false;
	}
	//window.showModalDialog("/tutorMgr/tutorMgr/imgPreview.jsp?imgurl=" + objImage, "", "dialogHeight: 520px; dialogWidth: 430px; dialogTop: px; dialogLeft: px; edge: Raised; center: Yes; help: No; resizable: No; status: No; Scroll : No;");
}
*/

// 이미지 업로드
function fnSave(){
	$("mode").value = "imgUpload";
	sform.action = "tutor.do?mode=imgUpload";
	sform.submit();
}


// 이미지 미리보기
function img_preview(obj,img_id){
	var img_id = $(img_id);	
	img_id.style.width="100";
	img_id.style.height="100";
	img_id.style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(src='" + obj.value + "',sizingMethod=scale)";
	
}


//-->
</script>


<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<form id="sform" name="sform" method="post" enctype="multipart/form-data">

<input type="hidden" name="menuId" 	value="<%=requestMap.getString("menuId")%>">
<input type="hidden" name="mode" id="mode" value="<%=requestMap.getString("mode")%>">

<input type="hidden" name="UPLOAD_DIR"	id="UPLOAD_DIR"	value="<%= Constants.NAMOUPLOAD_PIC%>">
<input type="hidden" name="RENAME_YN"	id="RENAME_YN"	value="tutor">

<input type="hidden" name="resno"		id="resno"		value="<%= requestMap.getString("resno") %>">
<input type="hidden" name="imgnm"		id="imgnm">

<table cellspacing="0" cellpadding="0" border="0" width="100%" height="100%">
	<tr><td height="4" bgcolor="#0081C4" nowrap></td></tr>
	<tr>
		<td height="45" bgcolor="#FFFFFF" style="padding-left:10px" nowrap>
			<!--[s] 타이틀 영역-->
			<table cellspacing="0" cellpadding="0" border="0">
				<tr>
					<td width="15" align="left"><img src="/images/bullet_pop.gif" width="10" height="22" border="0"></td>
					<td><font color="#000000" style="font-weight:bold; font-size:13px">사진등록</font></td>
				</tr>
			</table>
			<!--[e] 타이틀 영역-->
		</td>
	</tr>
	<tr>
		<td height="100%" class="popupContents" valign="top" bgcolor="#E4E3E4">
		
			<div style="text-align:center">
				<img src="/images/photorecord_img01.gif">
				<div id="img_show"></div>				
				<table width="371" height="39" border="0" cellpadding="0" cellspacing="0" background="/images/photorecord_img02.gif">
					<tr> 
						<td>
							<table width="371" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td width="60">&nbsp;</td>
									<td></td>
									<td width="68"><input type="file" name="memberImg" size="30" class="textfield"  onchange="img_preview(this,'img_show');" ></td>
									<!-- <td width="68"><a href="javascript:void(0);" onClick = "ShowImageWithModalBox(document.all.memberImg.value)"><img src="/images/btn_view.gif" width="58" height="18" border="0"></a></td> -->
								</tr>
							</table>
						</td>
					</tr>
				</table>
				<br>
				<input type="button" name="btnSave"   value="저 장" onclick="fnSave();" class="boardbtn1">
				<input type="button" name="btnCancel" value="닫 기" onclick="self.close();" class="boardbtn1">
			</div>					
			<!--[e] contents -->
			
		</td>
	</tr>
	
</table>


</form>
</body>