<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 미등록/미수료자 현황  엑셀
// date  : 2008-07-23
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
	
	String colName = "";
	String bgColor = "bgcolor=\"ffcc00\"";
	
	if(listMap.keySize("gubunnm") > 0){		
		for(int i=0; i < listMap.keySize("gubunnm"); i++){
			
			// tr 배경색
			if(listMap.getString("pflag", i).equals("A")){
				bgColor = "bgcolor=\"#cccccc\"";				
			}else if(listMap.getString("pflag", i).equals("B")){
				bgColor = "bgcolor=\"ffcc00\"";
			}else{
				bgColor = "";
			}
			
			sbListHtml.append("<tr " + bgColor + " >");
			
			sbListHtml.append("	<td style=\"text-align: left\">" + listMap.getString("gubunnm", i) + "</td>");
			sbListHtml.append("	<td style=\"text-align: left\">" + listMap.getString("grcodenm", i) + "</td>");
			
			sbListHtml.append("	<td>" + Util.moneyFormValue(listMap.getString("sumTotal", i)) + "</td>");
			
			sbListHtml.append("	<td>" + Util.moneyFormValue(listMap.getString("adeptcountSubsum", i)) + "</td>");
			sbListHtml.append("	<td>" + Util.moneyFormValue(listMap.getString("adeptcount13", i)) + "</td>");
			
			for(int j=1; j < 13; j++){
				colName = "adeptcount" + j;
				sbListHtml.append("	<td>" + Util.moneyFormValue(listMap.getString(colName, i)) + "</td>");	
			}
			
			sbListHtml.append("	<td>" + Util.moneyFormValue(listMap.getString("bdeptcountSubsum", i)) + "</td>");
			sbListHtml.append("	<td>" + Util.moneyFormValue(listMap.getString("bdeptcount13", i)) + "</td>");
			
			for(int j=1; j < 13; j++){
				colName = "bdeptcount" + j;
				sbListHtml.append("	<td>" + Util.moneyFormValue(listMap.getString(colName, i)) + "</td>");	
			}
			
			sbListHtml.append("	<td>" + Util.moneyFormValue(listMap.getString("cdeptcountSubsum", i)) + "</td>");
			sbListHtml.append("	<td>" + Util.moneyFormValue(listMap.getString("cdeptcount13", i)) + "</td>");
			
			for(int j=1; j < 13; j++){
				colName = "cdeptcount" + j;
				sbListHtml.append("	<td>" + Util.moneyFormValue(listMap.getString(colName, i)) + "</td>");	
			}
			
			
			sbListHtml.append("</tr>");
		}
	}
	
	String toToYear = "미등록_미수료자 현황_" + requestMap.getString("searchYear");
	// String excel_filename = new String(	toToYear.getBytes(), "ISO-8859-1");
WebUtils.setFileHeader(request, response, toToYear+".xls", "UTF-8", "UTF-8");
	response.setHeader("Content-Description", "JSP Generated Data"); 
	response.setContentType( "application/vnd.ms-excel" );
	request.setCharacterEncoding("UTF-8");
	
%>
<meta http-equiv="Content-Type" content="application/vnd.ms-excel; charset=UTF-8">

<table width="95%" border="1" cellpadding="0" cellspacing="0" >
	<tr bgcolor="F7F7F7" align="center" height="30">
		<td class="tableline11" colspan="45"><b><%= toToYear %></b></td>
	</tr>
	<tr bgcolor="F7F7F7" align="center" height="28">
		<td class="tableline11" rowspan="2">구분</td>
		<td class="tableline11" rowspan="2">과정명</td>
		<td class="tableline11" colspan="15">미등록</td>
		<td class="tableline11" colspan="14">자퇴</td>
		<td class="tableline11" class="br0" colspan="14">유급</td>
	</tr>
	<tr bgcolor="F7F7F7" align="center" height="28">
		<td class="tableline11" >총계</td>
		<td class="tableline11" >소계</td>
		<td class="tableline11" >시</td>
		<td class="tableline11" >중구</td>
		<td class="tableline11" >동구</td>
		<td class="tableline11" >남구</td>
		<td class="tableline11" >연수구</td>
		<td class="tableline11" >남동구</td>
		<td class="tableline11" >부평구</td>
		<td class="tableline11" >계양구</td>
		<td class="tableline11" >서구</td>
		<td class="tableline11" >강화군</td>
		<td class="tableline11" >옹진군</td>
		<td class="tableline11" >타시도</td>
		<td class="tableline11" >기타</td>
	
		<td class="tableline11" >소계</td>
		<td class="tableline11" >시</td>
		<td class="tableline11" >중구</td>
		<td class="tableline11" >동구</td>
		<td class="tableline11" >남구</td>
		<td class="tableline11" >연수구</td>
		<td class="tableline11" >남동구</td>
		<td class="tableline11" >부평구</td>
		<td class="tableline11" >계양구</td>
		<td class="tableline11" >서구</td>
		<td class="tableline11" >강화군</td>
		<td class="tableline11" >옹진군</td>
		<td class="tableline11" >타시도</td>
		<td class="tableline11" >기타</td>
	
		<td class="tableline11" >소계</td>
		<td class="tableline11" >시</td>
		<td class="tableline11" >중구</td>
		<td class="tableline11" >동구</td>
		<td class="tableline11" >남구</td>
		<td class="tableline11" >연수구</td>
		<td class="tableline11" >남동구</td>
		<td class="tableline11" >부평구</td>
		<td class="tableline11" >계양구</td>
		<td class="tableline11" >서구</td>
		<td class="tableline11" >강화군</td>
		<td class="tableline11" >옹진군</td>
		<td class="tableline11" >타시도</td>
		<td class="tableline11" >기타</td>
	</tr>

	<%= sbListHtml.toString() %>
	
</table>


