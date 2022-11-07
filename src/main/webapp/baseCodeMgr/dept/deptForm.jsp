<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 기관코드관리 폼
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
//부모창에서 보내온 모드값을 기준으로 수정페이지인지 등록페이지 확인한다.
var qu = "<%=requestMap.getString("qu")%>"

	function goSave(){
	var qu = "<%=requestMap.getString("qu")%>";
	if(qu == "update" || qu =="allDeptUpdate"){
		//not null field 에 빈값 못들어가게 체크 [s]
		if($F("dept") == ""){
			alert("기관코드를 입력하십시오");
			return false;
		}
		if($F("deptnm") == ""){
			alert("기관코드명을 입력하십시오");
			return false;
		}
		if($F("lownm") == ""){
			alert("최하위기명을 입력하십시오");
			return false;
		}
		if($F("upper") == ""){
			alert("상위코드를 입력하십시오");
			return false;
		}
		if($F("parent") == ""){
			alert("최상위코드를 입력하십시오");
			return false;
		}
		//nuo null field 에 빈값 못들어가게 체크 [e]

		if( confirm('수정 하시겠습니까?')){//수정일때
			$("mode").value="exec";
			
			if(qu == "allDeptUpdate"){
				//전체 기관코드 리스트 수정
				$("qu").value="allDeptUpdate";
				
			}else{
				//기관코드 리스트 수정
				$("qu").value="update";
			}
			
			document.pform.submit(); 
		}
	}else{
		
		//not null field 에 빈값 못들어가게 체크 [s]
		if($F("dept") == ""){
			alert("기관코드를 입력하십시오");
			return false;
		}
		if($F("deptnm") == ""){
			alert("기관코드명을 입력하십시오");
			return false;
		}
		if($F("lownm") == ""){
			alert("최하위기명을 입력하십시오");
			return false;
		}
		if($F("upper") == ""){
			alert("최상위코드를 입력하십시오");
			return false;
		}
		if($F("parent") == ""){
			alert("상위코드를 입력하십시오");
			return false;
		}
		//nuo null field 에 빈값 못들어가게 체크 [e]
		
		if( confirm('등록 하시겠습니까?')){//등록일때
			$("mode").value="exec";
			$("qu").value=qu;
			document.pform.submit();
		}
	}
}

	function go_delete(qu){
		//기관코드삭제 수정모드일때만 쓸수있다.
		var gubunQu = "";
		if(qu == "update"){
			gubunQu = "deptDelete";
		
		}else{
			gubunQu = "allDeptDelete";
		
		}
	
		if( confirm('삭제 하시겠습니까?')){//등록일때
			$("mode").value="exec";
			$("qu").value=gubunQu;
			document.pform.submit();
		}
	}
	
//-->
</SCRIPT>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
	<form name="pform" action="/baseCodeMgr/dept.do" method="post">
	<input type="hidden" name="qu" value="">
	<input type="hidden" name="mode" value="">
	<input type="hidden" name="menuId" value="<%=requestMap.getString("menuId") %>">
	<input type="hidden" name="search" 		value="<%=requestMap.getString("search") %>">
	<input type="hidden" name="currPage" 		value="<%=requestMap.getString("currPage") %>">
	
    <table cellspacing="0" cellpadding="0" border="0" width="100%" height="100%">
        <tr><td height="4" bgcolor="#0081C4" nowrap></td></tr>
        <tr>
            <td height="45" bgcolor="#FFFFFF" style="padding-left:10px" nowrap>
                <!-- [s]타이틀영역-->
                <table cellspacing="0" cellpadding="0" border="0">
                    <tr>
                    	<td width="15" align="left"><img src="/images/bullet_pop.gif" width="10" height="22" border="0"></td>
						<td><font color="#000000" style="font-weight:bold; font-size:13px">기관코드 <%=qu.equals("insert") || qu.equals("allDeptCodeInsert") ? "등록":"수정"%></font></td>
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
						<td class="tableline11 " bgcolor=#E4EDFF style="padding-left:10px;"><strong>기관코드</strong></td>
						<td class="tableline21" style="padding-left:10px"><input type="text" name="dept" maxLength='7' class="textfield" value="<%=listMap.getString("dept") %>"  <%=requestMap.getString("qu").equals("insert") || requestMap.getString("qu").equals("allDeptCodeInsert")? "" : "readonly"%>></td>
					</tr>
					<tr>
						<td class="tableline11 " bgcolor=#E4EDFF style="padding-left:10px;"><strong>기관코드명</strong></td>
						<td class="tableline21" style="padding-left:10px"><input type="text" name="deptnm" maxlength="20" class="textfield" value="<%=!listMap.getString("deptnm").equals("") ? listMap.getString("deptnm") : listMap.getString("adeptnm") %>"></td>
					</tr>
					<tr>
						<td class="tableline11 " bgcolor=#E4EDFF style="padding-left:10px;"><strong>최하위 부서명</strong></td>
						<td class="tableline21" style="padding-left:10px"><input type="text" name="lownm" maxlength="20" class="textfield" value="<%=!listMap.getString("lownm").equals("") ? listMap.getString("lownm") : listMap.getString("alownm") %>"></td>
					</tr>
					<tr>
						<td class="tableline11 " bgcolor=#E4EDFF style="padding-left:10px;"><strong>Level</strong></td>
						<td class="tableline21" style="padding-left:10px">
							<select name="levels">
								<option value='101'>시스템관리자</option>
								<option value='102'>과정운영자</option>
								<option value='103'>기관담당자</option>
								<option value='104'>평가담당자</option>
								<option value='105'>강사관리자</option>
								<option value='106'>홈페이지관리자</option>
							</select>
						</td>
					</tr>																	
					<tr>
						<td class="tableline11 " bgcolor=#E4EDFF style="padding-left:10px;"><strong>최상위코드</strong></td>
						<td class="tableline21" style="padding-left:10px"><input type="text" name="upper" maxLength='7' class="textfield" value="<%=listMap.getString("parent") %>"></td>
					</tr>
					<tr>
						<td class="tableline11 " bgcolor=#E4EDFF style="padding-left:10px;"><strong>상위코드</strong></td>
						<td class="tableline21" style="padding-left:10px"><input type="text" name="parent" maxLength='7' class="textfield" value="<%=listMap.getString("upper") %>"></td>
					</tr>
					<tr>
						<td class="tableline11 " bgcolor=#E4EDFF style="padding-left:10px;"><strong>인사행정<br>연계여부</strong></td>
						<td class="tableline21" style="padding-left:10px">Y<input name="peoplesystemYn" type="radio" value="Y" <%=listMap.getString("peoplesystemYn").equals("Y") ? "checked" : "" %>>&nbsp;N<input type="radio" name="peoplesystemYn" value="N" <%=!listMap.getString("peoplesystemYn").equals("Y") ? "checked" : "" %>></td>
					</tr>
					<tr>
						<td class="tableline11 " bgcolor=#E4EDFF style="padding-left:10px;"><strong>사용여부</strong></td>
						<td class="tableline21" style="padding-left:10px"><select name="useYn"><option value='Y'>사용중</option><option value='N'>미사용</option></select></td>
					</tr>
					<tr bgcolor="#375694">
						<td height="2" colspan="100%"></td>
					</tr>
					<!-- [e]본문영역-->
					<!-- space --><tr><td colspan="3" height="10"> </td></tr>
																	
					<tr>
						<td colspan='3' align='center'>
							<input type=button value='저장' onclick=goSave() class=boardbtn1>
							<%if(requestMap.getString("qu").equals("update") || requestMap.getString("qu").equals("allDeptUpdate")){%>
							<input type=button value='삭제' onClick=go_delete('<%=requestMap.getString("qu")%>'); class=boardbtn1>							
							<%} %>
								
							<input type=button value='닫기' onClick=self.close(); class=boardbtn1>
						</td>
					</tr>
				</table>
						
                
            </td>
        </tr>
	</table>
	</form>
</body>
	
<SCRIPT LANGUAGE="JavaScript">
<!--
//레벨  셀렉티드
 	var levels = "<%=listMap.getString("levels")%>";
 	levelsLen = $("levels").options.length
	 for(var i=0; i < levelsLen; i++) {
	     if($("levels").options[i].value == levels){
	      	$("levels").selectedIndex = i;
		 }
 	 }
 	 
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
