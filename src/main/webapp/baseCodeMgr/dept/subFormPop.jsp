<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 부서코드관리 폼
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

	//메인코드 리스트
	DataMap listMap = (DataMap)request.getAttribute("ROW_DATA");
	listMap.setNullToInitialize(true);
	
	String qu = requestMap.getString("qu");
%>
<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->
<SCRIPT LANGUAGE="JavaScript">
<!--

// 숫자, 영문, 한글 이외의 문자이면 true 리턴함
function strChk(ch){

	if ( ch >= "0" && ch <= "9" ) return false;
	if ( ch >= "a" && ch <= "z" ) return false;
	if ( ch >= "A" && ch <= "Z" ) return false;

	//var sEncode = encodeURI(ch);  //5.0 not supported

	var sEncode = ch;
	if ( sEncode.length==9 ) {
		var sHex = sEncode.substring(1, 3);
		if ( sHex >= "EA" && sHex <= "ED" ) return false;
	}
	
	alert("코드는 숫자와 영문자만 가능합니다.");
	return true;
}

function goSave(){
	
	if(strChk($("partcd").value) == true){
		return false;
	}
	
				
	if($F("partcd") == ""){
		alert("부서코드를 입력하십시오");
		return false;
	}
	
	if($F("partnm") == ""){
		alert("부서명을 입력하십시오");
		return false;
	}

	var qu = "<%=requestMap.getString("qu")%>";
	
	if(qu == "update" ){

		
	if( confirm('수정 하시겠습니까?')){
			$("qu").value="partUpdate";
			document.pform.submit();
		}
	}else{
	
		if( confirm('등록 하시겠습니까?')){
			$("qu").value="partInsert";
			document.pform.submit();
		}
	}
}

//-->
</SCRIPT>

		
	<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
		<form name="pform" action="/baseCodeMgr/dept.do" method="post">
		<input type="hidden" name="qu" value="">
		<input type="hidden" name="mode" value="exec">
		<input type="hidden" name="menuId" value="<%=requestMap.getString("menuId") %>">
			
	    <table cellspacing="0" cellpadding="0" border="0" width="100%" height="100%">
	        <tr><td height="4" bgcolor="#0081C4" nowrap></td></tr>
	        <tr>
	            <td height="45" bgcolor="#FFFFFF" style="padding-left:10px" nowrap>
	                <!-- [s]타이틀영역-->
	                <table cellspacing="0" cellpadding="0" border="0">
	                    <tr>
	                    	<td width="15" align="left"><img src="/images/bullet_pop.gif" width="10" height="22" border="0"></td>
							<td><font color="#000000" style="font-weight:bold; font-size:13px">부서 <%=qu.equals("insert")?"등록":"수정"%></font></td>
	                    </tr>
	                </table>
	                <!-- [e]타이틀영역-->
	            </td>
	        </tr>
	        <tr>
	            <td height="100%" class="popupContents " valign="top">
	                <!-- [s]본문영역-->
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr bgcolor="#375694">
							<td height="2" colspan="100%"></td>
						</tr>
						<tr>
							<td bgcolor="#E4EDFF" class="tableline11" align="center"><strong>기관코드</strong></td>
							<td class="tableline21" style="padding-left:10px" ><input type="text" name="dept" maxLength='7' size="10" class="textfield" value="<%=requestMap.getString("qu").equals("insert") ? requestMap.getString("dept") : listMap.getString("dept")%>"  readonly></td>
						</tr>
						<tr>
							<td bgcolor="#E4EDFF" class="tableline11" align="center"><strong>기관코드명</strong></td>
							<td class="tableline21" style="padding-left:10px" ><input type="text" name="deptnm" size="20" class="textfield" value="<%=requestMap.getString("deptnm")%>" readonly></td>
						</tr>
						<tr>
							<td bgcolor="#E4EDFF" class="tableline11" align="center"><strong>부서코드</strong></td>
							<td class="tableline21" style="padding-left:10px" ><input type="text" name="partcd" size="10" maxlength="7" class="textfield" value="<%=requestMap.getString("qu").equals("insert")? "" : listMap.getString("partcd")%>" <%=requestMap.getString("qu").equals("update") ? "readonly" : "" %>></td>
						</tr>
						<tr>
							<td bgcolor="#E4EDFF" class="tableline11" align="center"><strong>부서명</strong></td>
							<td class="tableline21" style="padding-left:10px" ><input type="text" name="partnm" maxlength="15" size="20" class="textfield" value="<%=listMap.getString("partnm")%>"></td>
						<tr>
							<td bgcolor="#E4EDFF" class="tableline11" align="center"><strong>사용여부</strong></td>
							<td class="tableline21" style="padding-left:10px">
								<select name="useYn">
									<option value='Y'>사용중</option>
									<option value='N'>미사용</option>
									
								</select>
							</td>
						</tr>																	
						<tr bgcolor="#375694">
							<td height="2" colspan="100%"></td>
						</tr>
						<!-- [e]본문영역-->
						<!-- space --><tr><td colspan="3" height="10"></td></tr>
																		
						<tr>
								<td colspan='3' align='center'><input type=button value='저장' onclick=goSave() class=boardbtn1>&nbsp;&nbsp;<input type=button value='닫기' onClick=self.close(); class=boardbtn1></td>
						</tr>
					</table>
							
	                
	            </td>
	        </tr>
		   
		</table>
		</form>
	</body>
	
<SCRIPT LANGUAGE="JavaScript">
<!--
	 	 
	 //사용여부  셀렉티드
	 	var useYn = "<%=listMap.getString("useYn")%>";
	 	useYnLen = $("useYn").options.length
		 for(var i=0; i < useYnLen; i++) {
		     if($("useYn").options[i].value == useYn){
		      	$("useYn").selectedIndex = i;
			 }
	 	 }
	 	 
//-->
</script>
