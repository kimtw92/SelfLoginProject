<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%  
// prgnm : 기초코드관리 과정 상세분류 코드관리 폼
%>

<!-- [s] commonImport -->
<%@ include file="/commonInc/include/commonImport.jsp" %>
<!-- [e] commonImport -->

<%
    //request 데이터
	DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
	requestMap.setNullToInitialize(true);

	//상세 분류코드 정
	DataMap rowMap = (DataMap)request.getAttribute("ROW_DATA");
	rowMap.setNullToInitialize(true);
	
	
	
	//메인코드 리스트
	DataMap mainCodeListMap = (DataMap)request.getAttribute("MAINCODE_LIST_DATA");
	mainCodeListMap.setNullToInitialize(true);
	
	
	//컨텐츠 본문영역 리스트 [s]
	StringBuffer sbListHtml = new StringBuffer(); 
	StringBuffer selectList = new StringBuffer();
	if(requestMap.getString("tu").equals("update")){//수정일때
		selectList.append(rowMap.getString("mcodeName"));
	
	}else if (requestMap.getString("tu").equals("insert")){//등록일때
		selectList.append("	<select name=\"mainCode\">");
		
		for(int i=0;i < mainCodeListMap.keySize("cdGubun");i++){
			selectList.append("			<option value='"+mainCodeListMap.getString("cdGubun",i)+"/"+mainCodeListMap.getString("majorCode",i)+"'>"+mainCodeListMap.getString("mcodeName",i)+"</option>");
			
		}
		
		selectList.append("		</select>");
	}
	
//	컨텐츠 본문영역 리스트 [e]
%>

 <SCRIPT LANGUAGE="JavaScript">
 <!--
 	//부모창에서 보내온 모드값을 기준으로 수정페이지인지 등록페이지 확인한다.
	var tu = "<%=requestMap.getString("tu")%>"
	
		function go_save(){
		if(tu == "update"){
			if( confirm('수정 하시겠습니까?')){//수정일때
				document.f.mode.value="minorExec";
				document.f.tu.value="update";
				document.f.submit();
			}
		}else{
			var scodeName = document.f.scodeName.value;
			if(scodeName == "" || scodeName ==null){
				alert("분류명을 입력하여 주십시오");
				return false;
			}
			if( confirm('등록 하시겠습니까?')){//등록일때
				document.f.mode.value="minorExec";
				document.f.tu.value="insert";
				document.f.submit();
			}
		}
	}
//-->
</SCRIPT>
<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->
		
	<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
		<form name="f" action="/baseCodeMgr/mainCode.do" method="post">
		<input type="hidden" name="menuId" 		value="<%=requestMap.getString("menuId") %>">
		<input type="hidden" name="guBun" value="<%=rowMap.getString("cdGubun") %>">
		<input type="hidden" name="cdGubun" value="<%=rowMap.getString("cdGubun") %>">
		<input type="hidden" name="majorCode" value="<%=rowMap.getString("majorCode")%>">
		<input type="hidden" name="minorCode" value="<%=rowMap.getString("minorCode")%>">
		<input type="hidden" name="sub_name" value="<%=rowMap.getString("mcodeName")%>">
		<input type="hidden" name="tu" value="">
		<input type="hidden" name="mode" value="">
		
	    <table cellspacing="0" cellpadding="0" border="0" width="100%" height="100%">
	        <tr><td height="4" bgcolor="#0081C4" nowrap></td></tr>
	        <tr>
	            <td height="45" bgcolor="#FFFFFF" style="padding-left:10px" nowrap>
	                <!-- [s]타이틀영역-->
	                <table cellspacing="0" cellpadding="0" border="0">
	                    <tr>
	                        <td width="15" align="left"><img src="/images/bullet_pop.gif" width="10" height="22" border="0"></td>
	                        <td><font color="#000000" style="font-weight:bold; font-size:13px">상세분류코드 <%=requestMap.getString("tu").equals("update") ? "수정" : "등록" %></font></td>
	                    </tr>
	                </table>
	                <!-- [e]타이틀영역-->
	            </td>
	        </tr>
	        <tr>
	            <td height="100%" class="popupContents " valign="top">
	                <!-- [s]본문영역-->
					<table cellspacing="0" cellpadding="0" border="0" width="100%" class="datah01">
						<tr>
							<td class="" class="tableline11" bgcolor="#E4EDFF"><strong>과정 분류명</strong></td>
							<td align="left" class="tableline21 br0" style="text-align:left; padding-left:10px"><%=selectList.toString() %></td>
						</tr>
							
						<tr>
							<td bgcolor="#E4EDFF"><strong>상세 분류명</strong></td>
							<td style="text-align:left; padding-left:10px" class="br0">
							<input maxlength="30" onkeypress="if(event.keyCode==13){go_save();return false;}" class="textfield" type=text name=scodeName value="<%=rowMap.getString("scodeName")%>" <%=requestMap.getString("tu").equals("update") ? "readonly" : ""%> ></td>
						
						</tr>
						<tr>
							<td bgcolor="#E4EDFF"> <strong>사용여부</strong></td>
							<td style="text-align:left; padding-left:10px" class="br0">
								<input type="radio" name="useYn" value='Y' id='use_y' <%=!rowMap.getString("useYn").equals("N") ? "checked" : ""%>>&nbsp;<label for='use_y'>YES</label>&nbsp;&nbsp;&nbsp;&nbsp;
								<input type=radio name=useYn value='N' id='use_n' <%=rowMap.getString("useYn").equals("N") ? "checked" : ""%>>&nbsp;<label for='use_n'>NO</label>		
							</td> 
						</tr>
					</table>
					<!-- space --><div class="space01"></div>	
					<table cellspacing="0" cellpadding="0" border="0" width="100%" class="">						
						<tr>
								<td colspan='3' align='center'><input type=button value='저장' onclick=go_save() class=boardbtn1>&nbsp;&nbsp;<input type=button value='닫기' onClick=self.close(); class=boardbtn1></td>
						</tr>
					</table>
	                <!-- [e]본문영역-->
	            </td>
	        </tr>
		</table>
		</form>
	</body>
