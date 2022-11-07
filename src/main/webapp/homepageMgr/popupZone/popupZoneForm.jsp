<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 식단관리 폼
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
	
	DataMap viewMap = new DataMap();
	//상세보기 데이터
	if(requestMap.getString("mode").equals("modForm"))
		viewMap = (DataMap)request.getAttribute("BOARDROW_DATA");
	
	viewMap.setNullToInitialize(true);
	
	
	// 필수 코딩 내용 //////////////////////////////////////////////////////////////////////
	//로그인된 사용자 정보
	LoginInfo memberInfo = (LoginInfo)request.getAttribute("LOGIN_INFO");
	
    //navigation 데이터
	DataMap navigationMap = (DataMap)request.getAttribute("NAVIGATION_DATA");
	navigationMap.setNullToInitialize(true);
	
	// 상단 navigation
	String navigationStr = LoginCheck.NavigationCreate(memberInfo, navigationMap);
	////////////////////////////////////////////////////////////////////////////////////
	
%>

<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->

<script language="JavaScript">

function imageCheck(thisObj){
	 if(!/(\.gif|\.jpg|\.jpeg|\.png)$/i.test(thisObj.value)) {
	    	alert("이미지 파일을 올려주세요");
			document.getElementById(thisObj.id).select();
	        document.selection.clear();
			document.getElementById(thisObj.id).focus();
			return;
	    }
}

function checkForm(){
	if(getRadioValue(Form.getInputs('pform',  'radio', 'usedYn')) == ""){
		alert("사용여부를 선택해주세요.");
		return false;
	}
	if($('title').value == ""){
		alert("제목을 입력해주세요");
		$('title').focus();
		return false;
	}
	
	var dtYn = getRadioValue(Form.getInputs('pform',  'radio', 'dtYn'));
	if(dtYn == ""){
		alert("기간사용여부를 선택해주세요.");
		return false;
	}else if(dtYn == 'Y'){
		if($('sDate').value == ""){
			alert("기간을 입력해주세요");
			$('sDate').focus();
			return false;
		}
		if($('eDate').value == ""){
			alert("기간을 입력해주세요");
			$('eDate').focus();
			return false;
		}
	}
	if(getRadioValue(Form.getInputs('pform',  'radio', 'linkYn')) == ""){
		alert("링크사용여부를 선택해주세요.");
		return false;
	}
	if(getRadioValue(Form.getInputs('pform',  'radio', 'linkYn')) == "Y" && $('linkUrl').value == ""){
		alert("링크주소를 입력해주세요");
		$('linkUrl').focus();
		return false;
	}
	<%if(viewMap.getString("fileName").equals("")){%>
	if($('popupImg').value == ""){
		alert("팝업존 이미지를 입력해주세요");
		$('popupImg').focus();
		return false;
	}
	<%}%>
	
	return true;
}

function getRadioValue(radioObj){
    if(radioObj != null){
        for(var i = 0; i < radioObj.length; i++){
            if(radioObj[i].checked){
                return radioObj[i].value;
            }
        }
    }
    return "";
}

function checkRadioValue(radioObj, value){
    if(radioObj != null){
        for(var i = 0; i < radioObj.length; i++){
            if(radioObj[i].value == value){
            	radioObj[i].checked = true;
            }
        }
    }
    return "";
}

function btnFileDelete() {   
	if( confirm('이미지 파일을 삭제하시겠습니까?')){
		$("mode").value="fileDelete";
		pform.action = "/homepageMgr/popzone.do?mode=fileDelete";
		pform.submit();
	}
};

function btnSave(){
	if(checkForm()){
		$('sTime').value = $('sTime1').value + $('sTime2').value;
		$('eTime').value = $('eTime1').value + $('eTime2').value;
		if($("mode").value == "form"){
			if( confirm('등록하시겠습니까?')){
				$("mode").value="insert";	
				pform.action = "/homepageMgr/popzone.do?mode="+$("mode").value;
				pform.submit();
			
			}
		}else{
			if( confirm('수정하시겠습니까?')){
				$("mode").value = "update";
				pform.action = "/homepageMgr/popzone.do?mode="+$("mode").value;
				pform.submit();
			}
		}
	}
}

function btnList(){	
	$("mode").value = "list";
	pform.action = "/homepageMgr/popzone.do?mode="+$("mode").value;
	pform.submit();
}

function btnDelete(){
	if( confirm('삭제하시겠습니까?')){
		$("mode").value="delete";
		pform.action = "/homepageMgr/popzone.do?mode="+$("mode").value;
		pform.submit();
	}
}

function dtYnClick(obj){
	if(obj.value == 'Y')
		$('dateCon').show();
	else
		$('dateCon').hide();
}

function linkYnClick(obj){
	if(obj.value == 'Y')
		$('linkUrlTr').show();
	else
		$('linkUrlTr').hide();
}

</script>


<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<form id="pform" name="pform" method="post" enctype="multipart/form-data">

<input type="hidden" name="mode" id="mode" value="<%= requestMap.getString("mode") %>">
<input type="hidden" name="currPage"	value="<%= requestMap.getString("currPage")%>">
<input type="hidden" name="UPLOAD_DIR"			value="/popupZone/">
<input type="hidden" name="RENAME_YN"			value="N">
<input type="hidden" name="sTime"	id = "sTime"		/>
<input type="hidden" name="eTime"	id = "eTime"		/>
<input type="hidden" name="sysFileName"	id = "sysFileName"	value = "<%=viewMap.getString("fileName") %>"	/>
<input type="hidden" name="seq"	id = "seq"	value = "<%= requestMap.getString("seq")%>"	/>




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
						<colgroup>
						<col width="20%" />
						<col width="80%" />
						</colgroup>
							<tr>
								<th>사용여부</th>
								<td><input type = "radio" name = "usedYn" <%if(viewMap.getString("usedYn").equals("Y")){%> checked <%} %>value = "Y"> 사용 <input type = "radio" name = "usedYn" <%if(viewMap.getString("usedYn").equals("N")){%> checked <%} %> value = "N"> 비사용 </td>
							</tr>
							<tr>
								<th>제목</th>
								<td><input type = "text" name = "title" id = "title" value = "<%=viewMap.getString("title")%>"/></td>
							</tr>
							<tr>
								<th>기간사용여부</th>
								<td><input type = "radio" onclick ="dtYnClick(this)" name = "dtYn" class = "dtYn" <%if(viewMap.getString("dtYn").equals("Y")){%> checked <%} %>value = "Y"> 사용 
								<input onclick ="dtYnClick(this)" type = "radio" name = "dtYn" class = "dtYn" <%if(viewMap.getString("dtYn").equals("N")){%> checked <%} %>value = "N"> 비사용 </td>
							</tr>
							<tr id="dateCon" <%if(!viewMap.getString("dtYn").equals("Y")){%> style = "display:none" <%} %>>
								<th>기간</th>
								<td style="border-right:0px solid #E5E5E5;">
							 		<input type="text" size="10" name="sDate" id = "sDate" value ="<%=viewMap.getString("startDt")%>" readonly />
							 		<img style="cursor:hand" onclick="fnPopupCalendar('pform','sDate');" src="../images/icon_calen.gif" alt="" />
							 		<%
							 		String sTime1 = "";
							 		String sTime2 = "";
							 		if(!viewMap.getString("startTm").equals("")) {
							 			sTime1 = viewMap.getString("startTm").substring(0,2);
							 			sTime2 = viewMap.getString("startTm").substring(2); 
							 		}
							 		
							 		%>
							 		<select name="sTime1" id = "sTime1">
										<option value="00"<%if(sTime1.equals("00")){%> selected <%} %>>00</option>
<option value="01"<%if(sTime1.equals("01")){%> selected <%} %>>01</option>
<option value="02"<%if(sTime1.equals("02")){%> selected <%} %>>02</option>
<option value="03"<%if(sTime1.equals("03")){%> selected <%} %>>03</option>
<option value="04"<%if(sTime1.equals("04")){%> selected <%} %>>04</option>
<option value="05"<%if(sTime1.equals("05")){%> selected <%} %>>05</option>
<option value="06"<%if(sTime1.equals("06")){%> selected <%} %>>06</option>
<option value="07"<%if(sTime1.equals("07")){%> selected <%} %>>07</option>
<option value="08"<%if(sTime1.equals("08")){%> selected <%} %>>08</option>
<option value="09"<%if(sTime1.equals("09")){%> selected <%} %>>09</option>
<option value="10"<%if(sTime1.equals("10")){%> selected <%} %>>10</option>
<option value="11"<%if(sTime1.equals("11")){%> selected <%} %>>11</option>
<option value="12"<%if(sTime1.equals("12")){%> selected <%} %>>12</option>
<option value="13"<%if(sTime1.equals("13")){%> selected <%} %>>13</option>
<option value="14"<%if(sTime1.equals("14")){%> selected <%} %>>14</option>
<option value="15"<%if(sTime1.equals("15")){%> selected <%} %>>15</option>
<option value="16"<%if(sTime1.equals("16")){%> selected <%} %>>16</option>
<option value="17"<%if(sTime1.equals("17")){%> selected <%} %>>17</option>
<option value="18"<%if(sTime1.equals("18")){%> selected <%} %>>18</option>
<option value="19"<%if(sTime1.equals("19")){%> selected <%} %>>19</option>
<option value="20"<%if(sTime1.equals("20")){%> selected <%} %>>20</option>
<option value="21"<%if(sTime1.equals("21")){%> selected <%} %>>21</option>
<option value="22"<%if(sTime1.equals("22")){%> selected <%} %>>22</option>
<option value="23"<%if(sTime1.equals("23")){%> selected <%} %>>23</option>
<option value="24"<%if(sTime1.equals("24")){%> selected <%} %>>24</option>
</select>:<select name="sTime2" id = "sTime2">
<option value="00"<%if(sTime2.equals("00")){%> selected <%} %>>00</option>
<option value="10"<%if(sTime2.equals("10")){%> selected <%} %>>10</option>
<option value="20"<%if(sTime2.equals("20")){%> selected <%} %>>20</option>
<option value="30"<%if(sTime2.equals("30")){%> selected <%} %>>30</option>
<option value="40"<%if(sTime2.equals("40")){%> selected <%} %>>40</option>
<option value="50"<%if(sTime2.equals("50")){%> selected <%} %>>50</option>
</select>
									
									&nbsp;~&nbsp;
							 		<input type="text" size="10" name="eDate" id = "eDate" readonly value="<%=viewMap.getString("endDt")%>">
							 		<img style="cursor:hand" onclick="fnPopupCalendar('pform','eDate');" src="../images/icon_calen.gif" alt="" />
							 		<%
							 		String eTime1 = "";
							 		String eTime2 = "";
							 		if(!viewMap.getString("endTm").equals("")) {
							 			eTime1 = viewMap.getString("endTm").substring(0,2);
							 			eTime2 = viewMap.getString("endTm").substring(2); 
							 		}
							 		%>
							 		<select name="eTime1" id="eTime1">
										<option value="00"<%if(eTime1.equals("00")){%> selected <%} %>>00</option>
<option value="01"<%if(eTime1.equals("01")){%> selected <%} %>>01</option>
<option value="02"<%if(eTime1.equals("02")){%> selected <%} %>>02</option>
<option value="03"<%if(eTime1.equals("03")){%> selected <%} %>>03</option>
<option value="04"<%if(eTime1.equals("04")){%> selected <%} %>>04</option>
<option value="05"<%if(eTime1.equals("05")){%> selected <%} %>>05</option>
<option value="06"<%if(eTime1.equals("06")){%> selected <%} %>>06</option>
<option value="07"<%if(eTime1.equals("07")){%> selected <%} %>>07</option>
<option value="08"<%if(eTime1.equals("08")){%> selected <%} %>>08</option>
<option value="09"<%if(eTime1.equals("09")){%> selected <%} %>>09</option>
<option value="10"<%if(eTime1.equals("10")){%> selected <%} %>>10</option>
<option value="11"<%if(eTime1.equals("11")){%> selected <%} %>>11</option>
<option value="12"<%if(eTime1.equals("12")){%> selected <%} %>>12</option>
<option value="13"<%if(eTime1.equals("13")){%> selected <%} %>>13</option>
<option value="14"<%if(eTime1.equals("14")){%> selected <%} %>>14</option>
<option value="15"<%if(eTime1.equals("15")){%> selected <%} %>>15</option>
<option value="16"<%if(eTime1.equals("16")){%> selected <%} %>>16</option>
<option value="17"<%if(eTime1.equals("17")){%> selected <%} %>>17</option>
<option value="18"<%if(eTime1.equals("18")){%> selected <%} %>>18</option>
<option value="19"<%if(eTime1.equals("19")){%> selected <%} %>>19</option>
<option value="20"<%if(eTime1.equals("20")){%> selected <%} %>>20</option>
<option value="21"<%if(eTime1.equals("21")){%> selected <%} %>>21</option>
<option value="22"<%if(eTime1.equals("22")){%> selected <%} %>>22</option>
<option value="23"<%if(eTime1.equals("23")){%> selected <%} %>>23</option>
<option value="24"<%if(eTime1.equals("24")){%> selected <%} %>>24</option>
</select>:<select name="eTime2" id = "eTime2">
<option value="00"<%if(eTime2.equals("00")){%> selected <%} %>>00</option>
<option value="10"<%if(eTime2.equals("10")){%> selected <%} %>>10</option>
<option value="20"<%if(eTime2.equals("20")){%> selected <%} %>>20</option>
<option value="30"<%if(eTime2.equals("30")){%> selected <%} %>>30</option>
<option value="40"<%if(eTime2.equals("40")){%> selected <%} %>>40</option>
<option value="50"<%if(eTime2.equals("50")){%> selected <%} %>>50</option>
</select>
									
								</td>
							</tr>
							<tr>
								<th>링크사용여부</th>
								<td><input onclick ="linkYnClick(this)" type = "radio" name = "linkYn" class = "linkYn" <%if(viewMap.getString("linkYn").equals("Y")){%> checked <%} %>value = "Y"> 사용 
								<input onclick ="linkYnClick(this)" type = "radio" name = "linkYn" class = "linkYn" <%if(viewMap.getString("linkYn").equals("N")){%> checked <%} %>value = "N"> 비사용 </td>
							</tr>
							<tr id = "linkUrlTr" <%if(!viewMap.getString("linkYn").equals("Y")){%> style = "display:none" <%} %>>
								<th>링크주소</th>
								<td><input type = "text" name = "linkUrl" id = "linkUrl" value = "<%=viewMap.getString("linkUrl")%>"/></td>
							</tr>
							<tr>
								<th>링크타겟</th>
								<td><select name="linkTarget" id="linkTarget">
										<option <%if(viewMap.getString("linkTarget").equals("_self")){%> selected <%} %>value="_self">현재창</option>
										<option <%if(viewMap.getString("linkTarget").equals("_blank")){%> selected <%} %>value="_blank">새창</option>
									</select>
								</td>
							</tr>
							<tr>
											<td height="28" class="tableline11" bgcolor="#E4EDFF" align="center" width="">
												<strong>팝업존 이미지</strong>
											</td>
											<td>
							<%if(viewMap.getString("fileName").equals("")){%><input style="width:60%" type = "file" onchange="imageCheck(this)" name = "popupImg" id = "popupImg" />
							<%}else{ %><%=viewMap.getString("fileName") %><input type="button" value="삭제" onclick="btnFileDelete()" class="boardbtn1" >
							<%} %>
											</td>
										</tr>
							<tr>
								<th>대체텍스트</th>
								<td><input type = "text" name = "fileAlt" id = "fileAlt" value="<%=viewMap.getString("fileAlt") %>"/></td>
							</tr>
							
														
							
						</table>
						<!-- //date -->

						<!-- 테이블하단 버튼  -->
						<table class="btn01" style="clear:both;">
							<tr>
								<td class="right">
									<input type="button" value="저장" onclick = "btnSave()" class="boardbtn1">
									<input type="button" value="삭제" onclick = "btnDelete()" class="boardbtn1" <%if(!requestMap.getString("mode").equals("modForm")){ %>style="display:none"<%} %>>
									<input type="button" value="리스트" onclick = "btnList()" class="boardbtn1">
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