<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 우편번호검색 팝업
// date : 2008-05-14
// auth : 정 윤철
%>

<!-- [s] commonImport -->
<%@ include file="/commonInc/include/commonImport.jsp" %>
<!-- [e] commonImport -->

<%
	
	DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
	requestMap.setNullToInitialize(true);
	
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	listMap.setNullToInitialize(true);
	
	String qu = requestMap.getString("qu");
	
	String html = "";
	
	if(qu.equals("")){
		
		html += "	<tr> ";
		html += "		<td height=\"25\"><div align=\"center\"> ";
		html += "			<input name=\"addr3\" type=\"text\" onkeypress=\"if(event.keyCode==13){goSearch('search1','list');return false;}\" class=\"textfield\" id=\"addr3\" size=\"13\" value=\""+requestMap.getString("addr3")+"\">";
		html += "			<input type='button' value='검 색' onclick=\"goSearch('search1','list');\" class='boardbtn1'></td>";
		html += "	</tr>";
		html += "	<tr>";
		html += "		<td> <div align=\"center\">읍/면/동의 이름을 입력하시고 “검색”를 선택하세요<br>";
		html += "		(예:홍제 또는 만수 또는 일직)<br>";
		html += "		</div></td>";
		html += " 	</tr>";
		html += "	<tr> ";
		html += "		<td height=\"30\"><div align=\"center\"></div></td>";
		html += "	</tr>";
		html += "";

	}else if(qu.equals("search1")){
		html = "	<tr> ";
		html += "		<td height=\"25\"><div align=\"center\"> ";
		html += "		<input name=\"addr3\" type=\"text\" class=\"textfield\" onkeypress=\"if(event.keyCode==13){goSearch('search1','list');return false;}\" size=\"13\"value=\""+requestMap.getString("addr3")+"\" maxlength=\"12\">";
		html += "						<input type='button' value='검 색' onclick=\"goSearch('search1','list');\" class='boardbtn1'></td>";
		html += "	</tr>";
		html += "	<tr> ";
		html += "		<td> <div align=\"center\">읍/면/동의 이름을 입력하시고 “검색”를 선택하세요<br>(예:홍제 또는 만수 또는 일직)<br></div></td>";
		html += "	</tr>";
		html += "	<tr> ";
		html += "		<td height=\"30\"><div align=\"center\"></div></td>";
		html += "	</tr>";
		html += "	<tr> ";
		html += "		<td align = center>";
		html += "		<select name = \"zipValue\" class=\"textfield\">";
		
		//검색된 주소값을 바탕으로 셀렉트 박스를 만든다.
		
		if(listMap.keySize("zipcode1") > 0){
			for(int i=0;listMap.keySize("zipcode1") > i; i++){
				String strAddr5 = listMap.getString("addr6",i);
				if(!"".equals(strAddr5)) {
					strAddr5 += " "+ listMap.getString("addr5",i);
				} else {
					strAddr5 = listMap.getString("addr5",i);
				} 
				html += "		<option value=\""+listMap.getString("zipcode1",i)+"-"+listMap.getString("zipcode2",i)+"\">["+listMap.getString("zipcode1",i)+"-"+listMap.getString("zipcode2",i)+"]"+ listMap.getString("addr1",i) 
				+ " " +listMap.getString("addr2",i) + " "+ listMap.getString("addr3",i)+ " " +listMap.getString("addr4",i) + " " + strAddr5 + "</option>";
				strAddr5 = "";
			}
			html += "		</select><input type = \"button\" class='boardbtn1' value=\"확인\" onclick=\"goPage('search2','list');\"></td>";
		}else if(listMap.keySize("zipcode1") <= 0){
			html += "		<option value=\"\" >검색된 데이터가 없습니다.</option>";
			html += "		</select></td>";
		}else{
			html += "		<option value=\"\" >검색에 실패하였습니다.</option>";
			html += "		</select></td>";
		}
		
		
		html += "		</td>";
		html += "	</tr>";
	}else if(qu.equals("search2")){
		String strAddr5 = listMap.getString("addr6");
		if(!"".equals(strAddr5)) {
			strAddr5 += " "+ listMap.getString("addr5");
		} else {
			strAddr5 = listMap.getString("addr5");
		} 
				
		html += "	<tr> ";
		html += "		<td><br><br><table border=\"0\" align=\"center\" cellpadding=\"0\" cellspacing=\"0\">";
		html += "						<tr>";
		html += "							<td height=\"25\" colspan=\"100%\">현재주소 :";
		//선택된 주소를 넣는다.
		html += "								["+listMap.getString("zipcode1")+"-"+listMap.getString("zipcode2")+"]"+listMap.getString("addr1")+ " " +listMap.getString("addr2")+ " " +listMap.getString("addr3")+ " " +listMap.getString("addr4")+ " " + strAddr5;
		html += "							</td>";	
		html += "						</tr>";
		html += "						<tr> ";
		html += "							<td>상세주소 : </td>";
		html += "							<td><input type = text size = 35 maxlength = 50 onkeypress=\"if(event.keyCode==13){goReturnZip();return false;}\" name=addr_plus class=\"textfield\"> <input type=\"button\" class='boardbtn1' value=\"확인\" onclick=\"goReturnZip()\"></td>";
		html += "						</tr>";
		html += " 					</table>";
		html +="		</td>";
		html +="	</tr>";
		
	}
	
	System.out.println(html);
%>
<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->

<SCRIPT LANGUAGE="JavaScript">
<!--
	function goSearch(qu,mode){
		if($("addr3").value == "" ){
			alert("주소를 입하여 주십시오.");
			return false;
		}
		if(IsValidCharSearch($("addr3").value) == false){
		
			return false;
		}
		
		$("qu").value = qu;
		$("mode").value = mode;
		pform.action = "/search/searchZip.do";
		pform.submit();
	}
	
	function goPage(qu,mode){
	
		$("qu").value = qu;
		$("mode").value = mode;
		pform.action = "/search/searchZip.do";
		pform.submit();
	}
	
	function goReturnZip(){
		if($("zipCodeName1").value != "" && $("zipCodeName1").value != null){
		<%if(!requestMap.getString("zipCodeName1").equals("")){%>	
		//마지막 주소검색이을 끝낸 후 부모창으로 값을 리턴한다.
			opener.<%=requestMap.getString("zipCodeName1")%>.value = "<%=listMap.getString("zipcode1") %>";
			opener.<%=requestMap.getString("zipCodeName2")%>.value = "<%=listMap.getString("zipcode2") %>";
			opener.<%=requestMap.getString("zipAddr") %>.value = "<%=listMap.getString("addr1") %><%=listMap.getString("addr2") %><%=listMap.getString("addr3")%><%=listMap.getString("addr4") %><%=listMap.getString("addr6") %><%=listMap.getString("addr5") %>"+" " + $("addr_plus").value;
			self.close();
		<%}%>
		}else{
			self.close();
		}
	}
	
//-->
</SCRIPT>

<body leftmargin="0" topmargin=0>
<form name="pform">
<input type="hidden" id="mode" name="mode">
<input type="hidden" id="qu" name="qu">
<input type="hidden" id="zipCodeName1" name="zipCodeName1" value="<%=requestMap.getString("zipCodeName1") %>">
<input type="hidden" id="zipCodeName2" name="zipCodeName2" value="<%=requestMap.getString("zipCodeName2") %>">
<input type="hidden" id="zipAddr" name="zipAddr" value=<%=requestMap.getString("zipAddr") %>>
<table cellspacing="0"  cellpadding="0" border="0" style="padding:0 0 0 0" width="100%" height="100%">
	<tr><td height="4" bgcolor="#0081C4" nowrap></td></tr>
	<tr>
		<td height="45" bgcolor="#FFFFFF" style="padding-left:10px" nowrap>
			<!-- [s]타이틀영역-->
			<table cellspacing="0" cellpadding="0" border="0">
				<tr>
					<td width="15" align="left"><img src="/images/bullet_pop.gif" width="10" height="22" border="0"></td>
					<td><font color="#000000" style="font-weight:bold; font-size:13px">우편번호 검색 </font></td>
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
				<%=html %>
				<!-- space --><tr><td height="10"></td></tr>
				<tr bgcolor="#375694">
					<td height="2" colspan="100%"></td>
				</tr>
				
			</table>
			<table width="100%" border="0" cellspacing="0" cellpadding="0">	
				<!-- [e]본문영역-->
				<!-- space --><tr><td height="10"></td></tr>
				<tr>
					<td colspan='3' align='center'>
						<%if(qu.equals("search3")){ %>
							<input type=button value='저장' onclick="goReturnZip();" class=boardbtn1>
						<%}else if(qu.equals("search1") || qu.equals("")){ %>
						&nbsp;&nbsp;
							<input type=button value='닫기' onClick=self.close(); class=boardbtn1>
						<%} %>
					</td>
						
				</tr>
			</table>
					
			
		</td>
	</tr>
</table>
</form>
</body>
