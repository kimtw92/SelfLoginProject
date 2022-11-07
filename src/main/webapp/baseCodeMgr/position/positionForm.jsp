<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm :  직급코드관리 폼
// date : 2008-05-14
// auth : 정 윤철
%>

<!-- [s] commonImport -->
<%@ include file="/commonInc/include/commonImport.jsp" %>
<!-- [e] commonImport -->

<%
    //request 데이터
	DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
	requestMap.setNullToInitialize(true);       

	//popContent  전체자료 리스트 데이터
	DataMap listMap = (DataMap)request.getAttribute("POSITION_SELECTLIST_DATA");
	
	String qu = requestMap.getString("qu");
	
	//직종
	String dogsnm = "";
	//직렬
	String jikjnm = "";
	//직류
	String jikrnm = "";
	//계급
	String jiklnm = "";
	
	for(int i=0;listMap.keySize("code") > i;i++ ){
		if(listMap.getString("jikgubun",i).equals("dogs")){
			dogsnm += "<option value=\""+listMap.getString("code",i)+"\">"+listMap.getString("codenm",i)+"</option>"; 
		}
		else if(listMap.getString("jikgubun",i).equals("jikj")){
			jikjnm += "<option value=\""+listMap.getString("code",i)+"\">"+listMap.getString("codenm",i)+"</option>"; 
		}
		else if(listMap.getString("jikgubun",i).equals("jikr")){
			jikrnm += "<option value=\""+listMap.getString("code",i)+"\">"+listMap.getString("codenm",i)+"</option>"; 
		}
		else if(listMap.getString("jikgubun",i).equals("jikl")){
			jiklnm += "<option value=\""+listMap.getString("code",i)+"\">"+listMap.getString("codenm",i)+"</option>"; 
		}
	}
%>
						
<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->
<SCRIPT LANGUAGE="JavaScript">

	function go_exec(qu){
		var chk = "";
		var temp = $("jikGubun");
		for(i = 0; i < pform.elements.length; i++){
			if(pform.elements[i].checked == true && i < 9){
				chk = pform.elements[i].value;
			}
		}
		
		if(chk == "1"){
			if( $F("jiknm") == ""){
				alert("직급명을 입력하십시오");
				return;
			}
		}
		
		if(qu == "insert"){
			//등록모드
			if( confirm('등록 하시겠습니까?')){
				$("mode").value = "positionExec";
				$("qu").value = "insert";
				pform.submit();
			}
		}else if(qu == "modify"){
			//수정모드
			if( confirm('수정 하시겠습니까?')){
				$("mode").value = "positionExec";
				$("qu").value = "modify";
				pform.submit();
			}
		}
	}


	function displayOn(gubun){
		if(gubun == "incheon"){
			$("incheon").style.display = "";
			$("government").style.display = "none";
		}else if(gubun == "government"){
			$("incheon").style.display = "none";
			$("government").style.display = "";		
		}
	}

//-->
</SCRIPT>

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<form name="pform" action="/baseCodeMgr/position.do" method="post">
<input type="hidden" name="qu"		 	value="<%=requestMap.getString("qu")%>">
<input type="hidden" name="mode" 		value="">
<input type="hidden" name="menuId" 		value="<%=requestMap.getString("menuId") %>">
<input type="hidden" name="search" 		value="<%=requestMap.getString("search") %>">
<input type="hidden" name="currPage" 		value="<%=requestMap.getString("currPage") %>">
<table cellspacing="0" cellpadding="0" border="0" width="100%" height="100%">
	<tr><td height="4" bgcolor="#0081C4" nowrap></td></tr>
	<tr>
		<td height="45" bgcolor="#FFFFFF" style="padding-left:10px" nowrap>
			<!-- 타이틀영역-->
			<table cellspacing="0" cellpadding="0" border="0">
				<tr>
					<td width="15" align="left"><img src="/images/bullet_pop.gif" width="10" height="22" border="0"></td>
					<td><font color="#000000" style="font-weight:bold; font-size:13px">직급코드  <%=qu.equals("modify")?"수정":"등록"%></font></td>
				</tr>
			</table>
			<!-- /타이틀영역-->
		</td>
	</tr>
	<tr>
		<td height="100%" class="popupContents " valign="top">
			<!-- 본문영역-->
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr bgcolor="#375694">
					<td height="2" colspan="100%"></td>
				</tr>
				<tr>
					<td class="tableline11 "  bgcolor="#E4EDFF" align="center"><strong>직급코드</strong></td>
					<td class="tableline21 " style="padding-left:10px">
						<input type="text"  class="textfield" maxlength="15" name="mcodeName" value="<%=requestMap.getString("maxJik") %>" readonly>
					</td>
				</tr>
				<tr>
					<td class="tableline11 " bgcolor="#E4EDFF" align="center"><strong>구분</strong></td>
					<td class="tableline21 " style="padding-left:10px">인천광역시 <input type="radio" onclick="displayOn('incheon')" class="textfield" name="jikGubun" value="1" <%=!requestMap.getString("jikGubun").equals("2") ? "checked" : ""%>>, 공사/공단 <input type="radio"  name="jikGubun" value="2" onclick="displayOn('government')" <%=requestMap.getString("jikGubun").equals("2") ? "checked" : ""%>></td>
				</tr>
				<tr>
					<td width="100%" colspan="2" style="padding:0 0 0 0">
						<table border="0" style="padding:0 0 0 0" id="incheon" cellspacing="0" cellpadding="0" width="100%">
							<tr>
								<td class="tableline11 " width="63" bgcolor="#E4EDFF" align="center"><strong>직급명</strong></td>
								<td class="tableline21" style="padding-left:10px">
									<input type="text" maxlength="15" class="textfield" name="jiknm" value="<%=qu.equals("modify")? requestMap.getString("jiknm") : ""%>">
								</td>
							</tr>
							<tr>
								<td class="tableline11 " bgcolor="#E4EDFF" align="center"><strong>계급</strong></td>
								<td class="tableline21" style="padding-left:10px">
									<select name="dogsnm" style="width:100px;">
									<%=dogsnm %>
									</select>
								</td>
							</tr>
							<tr>
								<td class="tableline11 " bgcolor="#E4EDFF" align="center"><strong>직종</strong></td>
								<td class="tableline21" style="padding-left:10px">
									<select name="jikjnm" style="width:100px;">
									
									<%= jikjnm%>
									</select>
								</td>
							</tr>
							<tr>
								<td class="tableline11 " bgcolor="#E4EDFF"align="center"><strong>직렬</strong></td>
								<td class="tableline21" style="padding-left:10px">
									<select name="jikrnm" style="width:100px;">
									<%=jikrnm%>
									</select>
								</td>
							</tr>
							<tr>
								<td class="tableline11 " bgcolor="#E4EDFF"align="center"><strong>직류</strong></td>
								<td class="tableline21" style="padding-left:10px">
									<select name="jiklnm" style="width:100px;">
									<%=jiklnm%>
									</select>
								</td>
							</tr>
						</table>
					
						<table border="0" id="government" style="display:none" cellspacing="0" cellpadding="0" width="100%">
							<tr>
								<td class="tableline11 " width="63" bgcolor="#E4EDFF" align="center"><strong>직급명</strong></td>
								<td class="tableline21" style="padding-left:10px">
									<select name="goverJiknm">
										<option value="팀장">팀장</option>
										<option value="직원">직원</option>
									</select>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				
				<tr>
					<td class="tableline11 " bgcolor="#E4EDFF" align="center"><strong>사용여부</strong></td>
					<td class="tableline21" style="padding-left:10px">&nbsp;Yes<input type="radio" name="useYn" value="Y" <%=!requestMap.getString("useYn").equals("N") ? "checked" : ""%>>&nbsp;&nbsp;No<input type="radio" name="useYn" value="N" <%=requestMap.getString("useYn").equals("N") ? "checked" : ""%>></td>
				</tr>
				<tr bgcolor="#375694">
					<td height="2" colspan="100%"></td>
				</tr>
			<!-- space --><tr><td height="10">&nbsp;</td></tr>
				<tr>
					<td colspan='3' align='center'><input type=button value='저장' onclick=go_exec('<%=requestMap.getString("qu")%>') class=boardbtn1>&nbsp;&nbsp;<input type=button value='닫기' onClick=self.close(); class=boardbtn1></td>
				</tr>
			</table>
					
			<!-- /본문영역-->
		</td>
	</tr>

</table>

</form>
</body>
<SCRIPT LANGUAGE="JavaScript">
	var qu ="modify";
	
	if(qu == "<%=requestMap.getString("qu")%>"){
	 	//직종 셀렉티드
	 	var dogsnm = "<%=requestMap.getString("dogsnm")%>";
	 	dogsLen = $("dogsnm").options.length
		 for(var i=0; i <dogsLen; i++) {
		     if($("dogsnm").options[i].text == dogsnm){
		      	$("dogsnm").selectedIndex = i;
			 }
	 	 }
	 	 
	 	 //직렬 셀렉티드
	 	 var jikjnm = "<%=requestMap.getString("jikjnm")%>";
	 	 jikjLne = $("jikjnm").options.length
		 for(var i=0; i <jikjLne; i++) {
		     if($("jikjnm").options[i].text == jikjnm){
		      	$("jikjnm").selectedIndex = i;
			 }
	 	 }
	 	 //직류 셀렉티드
	 	 var jikrnm = "<%=requestMap.getString("jikrnm")%>";
	 	 jikrLne = $("jikrnm").options.length
		 for(var i=0; i <jikrLne; i++) {
		     if($("jikrnm").options[i].text == jikrnm){
		      	$("jikrnm").selectedIndex = i;
			 }
	 	 }
	 	 
	 	 //계급 셀렉티드
	 	 var jiklnm = "<%=requestMap.getString("dogsnm	")%>";
	 	 jiklLne = $("jiklnm").options.length
		 for(var i=0; i <jiklLne; i++) {
		     if($("jiklnm").options[i].text == jiklnm){
		      	$("jiklnm").selectedIndex = i;
			 }
	 	 }
	 	 
	 }

//-->
</SCRIPT>
