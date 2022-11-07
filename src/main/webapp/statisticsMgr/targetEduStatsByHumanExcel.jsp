<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 대상별 교육훈련실적 - 남여별 엑셀
// date  : 2008-07-24
// auth  : kang
%>

<!-- [s] commonImport -->
<%@ include file="/commonInc/include/commonImport.jsp" %>
<!-- [e] commonImport -->

<%

	//request 데이터
	DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
	requestMap.setNullToInitialize(true);
	
	LoginInfo memberInfo = (LoginInfo)request.getAttribute("LOGIN_INFO");
	
	////////////////////////////////////////////////////////////////////////////////////
	
	String searchYear = Util.getValue(requestMap.getString("searchYear"),(String)request.getAttribute("DATE_YEAR"));
	
	
	// 리스트
	StringBuffer sbListHtml = new StringBuffer();
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	if(listMap == null) listMap = new DataMap();
	listMap.setNullToInitialize(true);
	
	String bgColor = "";
	
	if(listMap.keySize("name") > 0){		
		for(int i=0; i < listMap.keySize("name"); i++){
			
			// tr 배경색
			if(listMap.getString("pflag", i).equals("A")){
				bgColor = "bgcolor=\"#cccccc\"";				
			}else if(listMap.getString("pflag", i).equals("B")){
				bgColor = "bgcolor=\"ffcc00\"";
			}else{
				bgColor = "";
			}
			
			sbListHtml.append("<tr " + bgColor + " >");
			
			sbListHtml.append("	<td style=\"text-align: left\">" + listMap.getString("gubun", i) + "</td>");
			sbListHtml.append("	<td style=\"text-align: left\">" + listMap.getString("name", i) + "</td>");
			
			sbListHtml.append("	<td>" + Util.moneyFormValue(listMap.getString("total", i)) + "</td>");	
			sbListHtml.append("	<td>" + Util.moneyFormValue(listMap.getString("man", i)) + "</td>");	
			sbListHtml.append("	<td>" + Util.moneyFormValue(listMap.getString("wo", i)) + "</td>");	
			
			sbListHtml.append("</tr>");
		}
	}
	
	String toToYear = "대상별교육훈련실적_남여별_" + requestMap.getString("searchYear");
	// String excel_filename = new String(	toToYear.getBytes(), "ISO-8859-1");
	WebUtils.setFileHeader(request, response, toToYear+".xls", "UTF-8", "UTF-8");
	response.setHeader("Content-Description", "JSP Generated Data"); 
	response.setContentType( "application/vnd.ms-excel" );
	request.setCharacterEncoding("UTF-8");
%>
<meta http-equiv="Content-Type" content="application/vnd.ms-excel; charset=UTF-8">

<table width="95%" border="1" cellpadding="0" cellspacing="0" >
	<tr bgcolor="F7F7F7" align="center" height="30">
		<td class="tableline11" colspan="5"><b><%= toToYear %></b></td>
	</tr>
	<tr bgcolor="F7F7F7" align="center" height="28">
		<td class="tableline11" >구분</td>
		<td class="tableline11" >과정명</td>
		<td class="tableline11" >총계</td>
		<td class="tableline11" >남</td>
		<td class="tableline11" >여</td>
	</tr>
	<%= sbListHtml.toString() %>
</table>


