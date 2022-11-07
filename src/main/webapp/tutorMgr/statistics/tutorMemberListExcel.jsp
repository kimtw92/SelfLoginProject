<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 강사활용실적 엑셀
// date  : 2008-07-22
// auth  : kang
%>

<!-- [s] commonImport -->
<%@ include file="/commonInc/include/commonImport.jsp" %>
<!-- [e] commonImport -->

<%

	//request 데이터
	DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
	requestMap.setNullToInitialize(true);
	
	String sType = Util.getValue(requestMap.getString("sType"),"1");
	String yearMonthFrom = Util.getValue(requestMap.getString("yearMonthFrom"),(String)request.getAttribute("DATE_FROM"));
	String yearMonthTo = Util.getValue(requestMap.getString("yearMonthTo"),(String)request.getAttribute("DATE_TO"));
	StringBuffer sbListHtml = new StringBuffer();
	
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	if(listMap == null) listMap = new DataMap();
	listMap.setNullToInitialize(true);

	int count = listMap.keySize("userno");	
	if(count > 0){		
		for(int i=0; i < listMap.keySize("userno"); i++){
			sbListHtml.append("<tr>");
			sbListHtml.append("	<td><center>" + listMap.getString("name", i) + "</center></td>");
			sbListHtml.append("	<td><center>" + listMap.getString("indate", i) + "</center></td>");
			sbListHtml.append("	<td><center>" + listMap.getString("tlevel", i) + "</center></td>");
			sbListHtml.append("	<td><center>" + listMap.getString("job", i) + "</center></td>");
			sbListHtml.append("	<td><center>" + listMap.getString("tposition", i) + "</center></td>");
			sbListHtml.append("</tr>");
		}
	} else {
			sbListHtml.append("<tr>");
			sbListHtml.append("	<td colspan=\"5\" class=\"br0\"><center>검색된 데이타가 없습니다.</center></td>");
			sbListHtml.append("</tr>");
	}


	String toToYear = "년도별 강사등록명부_" + requestMap.getString("yearMonthFrom") + "_" + requestMap.getString("yearMonthTo");
	// String excel_filename = new String(	toToYear.getBytes(), "ISO-8859-1");
	WebUtils.setFileHeader(request, response, toToYear+".xls", "UTF-8", "UTF-8");
	response.setHeader("Content-Description", "JSP Generated Data"); 
	response.setContentType( "application/vnd.ms-excel" );
	request.setCharacterEncoding("UTF-8");
%>

<script language="javascript" src="/commonInc/js/rowspan.js"></script>

<meta http-equiv="Content-Type" content="application/vnd.ms-excel; charset=UTF-8">
<% 
	int year = requestMap.getInt("year");	
%>
	<table width="95%" border="1" cellpadding="0" cellspacing="0" >
		<thead>
		<tr>
			<th colspan="5" style="color:blue;"><%=year%>년도 총 <%=count%> 명</th>
		</tr>
		<tr>
			<th>성명</th>
			<th>신규등록강사</th>
			<th>등급</th>
			<th>직업군</th>
			<th>소속</th>
		</tr>
		</thead>
		<tbody>							
		<%= sbListHtml.toString() %>			
		</tbody>
	</table>