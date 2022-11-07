<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm :직급검색  팝업
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
	
	
	StringBuffer contentList = new StringBuffer();
	if(qu.equals("")){
		
		contentList.append("	<tr> ");
		contentList.append("		<td height=\"25\" colspan=\"100%\"><div align=\"center\"> ");
		contentList.append("			<input name=\"jiknm\" type=\"text\" class=\"textfield\" id=\"id5\" size=\"20\" maxlength=\"12\" onkeypress=\"if(event.keyCode==13){goSearch('search1','list');return false;}\" required=\"true!직급명을 입력하십시오.\">");
		contentList.append("			<input type = \"button\" value=\"검색\" class=\"boardbtn1\" onclick=\"goSearch('search1','list');\"></td>");
		contentList.append("	</tr>");
		contentList.append("	<tr>");
		contentList.append("		<td colspan=\"100%\"> <div align=\"center\">직급명(예:행정주사)입력 후 검색을 선택하세요.<br><br>");
		contentList.append("		</div></td>");
		contentList.append(" 	</tr>");
		contentList.append("	<tr bgcolor=\"#375694\">");
		contentList.append("		<td height=\"2\" colspan=\"100%\"></td>");
		contentList.append("	</tr>");
		contentList.append("	<tr> ");
		contentList.append("		<td height=\"30\" colspan=\"100%\"><div align=\"center\"></div></td>");
		contentList.append("	</tr>");
		contentList.append("");

	}else if(qu.equals("search1")){
		contentList.append("	<tr> ");
		contentList.append("		<td height=\"25\" colspan=\"100%\"><div align=\"center\"> ");
		contentList.append("		<input name=\"jiknm\" type=\"text\" class=\"textfield\" size=\"13\" onkeypress=\"if(event.keyCode==13){goSearch('search1','list');return false;}\"  maxlength=\"12\">");
		contentList.append("		<input type = \"button\" value=\"검색\" class=\"boardbtn1\"  onclick=\"goSearch('search1','list');\"></td>");
		contentList.append("	</tr>");
		contentList.append("	<tr>");
		contentList.append("		<td colspan=\"100%\"> <div align=\"center\">직급명(예:행정주사)입력 후 검색을 선택하세요.<br><br>");
		contentList.append("		</div></td>");
		contentList.append(" 	</tr>");
		contentList.append("	<tr bgcolor=\"#375694\">");
		contentList.append("		<td height=\"2\" colspan=\"100%\"></td>");
		contentList.append("	</tr>");
		contentList.append("	<tr> ");
		contentList.append("		<td height=\"20\" colspan=\"100%\"><div align=\"center\"></div></td>");
		contentList.append("	</tr>");
		
		
		contentList.append("	<tr bgcolor=\"#375694\">");
		contentList.append("		<td height=\"2\" colspan=\"100%\"></td>");
		contentList.append("	</tr>");
		contentList.append("	<tr> ");
		contentList.append("		<td width=\"35\" style=\"height:28px\" bgcolor=\"#5071B4\" class=\"tableline11 white\"> <div align=\"center\"><strong><font color=\"\">번호</font></strong></div></td>");
		contentList.append("		<td width=\"60\" bgcolor=\"#5071B4\" class=\"tableline11 white\"><div align=\"center\"><strong>직급코드</strong></div></td>");
		contentList.append("		<td bgcolor=\"#5071B4\" class=\"tableline11 white\"> <div align=\"center\"><strong>직급명</strong></div></td>");
		contentList.append("		<td bgcolor=\"#5071B4\" class=\"tableline11 white\"> <div align=\"center\"><strong>구분</strong></div></td>");
		contentList.append("		<td width=\"\" bgcolor=\"#5071B4\" class=\"tableline11 white\"><div align=\"center\"><strong>직종</strong></div></td>");
		contentList.append("		<td width=\"\" bgcolor=\"#5071B4\" class=\"tableline11 white\"><div align=\"center\"><strong>직렬</strong></div></td>");
		contentList.append("		<td width=\"\" bgcolor=\"#5071B4\" class=\"tableline11 white\"> <div align=\"center\"><strong>직류</font></strong></div></td>");
		contentList.append("		<td width=\"\" bgcolor=\"#5071B4\" class=\"tableline21 white\"><div align=\"center\"><strong>계급</strong></div></td>");
		if(listMap.keySize("jik") > 0){
			//검색된 직급코드값이 있을경우
			for(int i =0; listMap.keySize("jik") > i; i++){
				contentList.append("	<tr> ");
				contentList.append("		<td height=\"10\" style=\"height:28px\" align=\"center\" class=\"tableline11\">"+i+"</td>");
				contentList.append("		<td height=\"10\" align=\"center\" class=\"tableline11\">"+(!listMap.getString("jik",i).equals("") ? listMap.getString("jik",i) : "&nbsp")+"</td>");
				contentList.append("		<td height=\"10\" align=\"center\" class=\"tableline11\"><a href=\"javascript:goReturn('"+listMap.getString("jik",i)+"','"+listMap.getString("jiknm",i)+"');\">"+(!listMap.getString("jiknm",i).equals("") ? listMap.getString("jiknm",i) : "&nbsp")+"</a></td>");
				
				if(listMap.getString("jikGubun", i).equals("1")){
					contentList.append("		<td height=\"10\" align=\"center\" class=\"tableline11\">인천광역시</td>");
					
				}else if(listMap.getString("jikGubun", i).equals("2")){
					contentList.append("		<td height=\"10\" align=\"center\" class=\"tableline11\">공사</td>");
					
				}else{
					contentList.append("		<td height=\"10\" align=\"center\" class=\"tableline11\">&nbsp;</td>");
					
				}
				
				out.print(requestMap.getString("jikGubun", i));
				contentList.append("		<td height=\"10\" align=\"center\" class=\"tableline11\">"+(!listMap.getString("jikjnm",i).equals("") ? listMap.getString("jikjnm",i) : "&nbsp")+"</td>");
				contentList.append("		<td height=\"10\" align=\"center\" class=\"tableline11\">"+(!listMap.getString("jikrnm",i).equals("") ? listMap.getString("jikrnm",i) : "&nbsp")+"</td>");
				contentList.append("		<td height=\"10\" align=\"center\" class=\"tableline11\">"+(!listMap.getString("jiklnm",i).equals("") ? listMap.getString("jiklnm",i) : "&nbsp")+"</td>");
				contentList.append("		<td height=\"10\" align=\"center\" class=\"tableline21\">"+(!listMap.getString("dogsnm",i).equals("") ? listMap.getString("dogsnm",i) : "&nbsp")+"</td>");
				contentList.append("	</tr>");
				
			}
			
			contentList.append("	<tr bgcolor=\"#375694\">");
			contentList.append("		<td height=\"2\" colspan=\"100%\"></td>");
			contentList.append("	</tr>");
			
		}else if(listMap.keySize("jik") <= 0){
			contentList.append("	<tr> ");
			contentList.append("		<td align=\"center\" height=\"10\" colspan=\"100%\"> ");
			contentList.append("		</td>");
			contentList.append("	</tr>");
			contentList.append("	<tr> ");
			contentList.append("		<td align=\"center\" height=\"28\" colspan=\"100%\"> ");
			contentList.append("검색된 데이터가 없습니다.");
			contentList.append("		</td>");
			contentList.append("	</tr>");
			contentList.append("	<tr bgcolor=\"#375694\">");
			contentList.append("		<td height=\"2\" colspan=\"100%\"></td>");
			contentList.append("	</tr>");
		}
	}
%>
<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->

<SCRIPT LANGUAGE="JavaScript">
<!--
	function goSearch(qu,mode){
		
		if(IsValidCharSearch($("jiknm").value) == false){
			return false;
		}
		
		$("qu").value = qu;
		$("mode").value = mode;
		pform.action = "/search/searchDept.do";
		pform.submit();
	}
	
	
	function goReturn(jik, jiknm){
	
		if($("t1").value != "" || $("name").value != null){
		//마지막 주소검색이을 끝낸 후 부모창으로 값을 리턴한다.
			opener.<%=requestMap.getString("t1")%>.value = jik;
			opener.<%=requestMap.getString("t2")%>.value = jiknm;
			self.close();
		}else{
			self.close();
		}
	}
	
//-->
</SCRIPT>

<body leftmargin="0" topmargin=0>
	<form name="pform">
	<input type="hidden" name="mode">
	<input type="hidden" name="qu">
	<input type="hidden" name="menuId" value="<%=requestMap.getString("menuId") %>">
    <!-- 직급검색 시 전페이지에서 리턴시켜주기위해서 보내주는 주소값을 받는다. -->
	<input type="hidden" name="t1" value=<%=requestMap.getString("t1") %>>
    <input type="hidden" name="t2" value=<%=requestMap.getString("t2") %>>
    
    <table cellspacing="0" cellpadding="0" border="0" style="padding:0 0 0 0" width="100%" height="100%">
	        <tr><td height="4" bgcolor="#0081C4" nowrap></td></tr>
	        <tr>
	            <td height="45" bgcolor="#FFFFFF" style="padding-left:10px" nowrap>
	                <!-- [s]타이틀영역-->
	                <table cellspacing="0" cellpadding="0" border="0">
	                    <tr>
	                    	<td width="15" align="left"><img src="/images/bullet_pop.gif" width="10" height="22" border="0"></td>
							<td><font color="#000000" style="font-weight:bold; font-size:13px">직급검색</font></td>
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
						<%=contentList.toString() %>	
						<!-- [e]본문영역-->
						
					</table>
							
	                
	            </td>
	        </tr>
		    <tr>
		        <td align="center" nowrap><a href="javascript:window.close();"><img src="/images/btn_popclose.gif" border="0"></a><!-- 닫기버튼 --></td>
		    </tr>
		</table>
		</form>
	</body>
