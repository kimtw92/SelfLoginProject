<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 교육훈련성적 - 평균성적 엑셀
// date  : 2008-08-05
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
	
	StringBuffer sbListHtml = new StringBuffer();

	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	if(listMap == null) listMap = new DataMap();
	
	listMap.setNullToInitialize(true);
	
	
	if(listMap.keySize("gubun") > 0){		
		for(int i=0; i < listMap.keySize("gubun"); i++){
			sbListHtml.append("	<tr>");
			sbListHtml.append("		<td>" + listMap.getString("gubunnm", i) + "</td>");
			sbListHtml.append("		<td>" + listMap.getString("grcodenm", i) + "</td>");
			sbListHtml.append("		<td>" + Util.moneyFormValue(listMap.getString("totno", i)) + "</td>");
			sbListHtml.append("		<td>" + listMap.getString("subcnt", i) + "</td>");
			sbListHtml.append("		<td>" + listMap.getString("avlcount", i) + "</td>");
			sbListHtml.append("		<td>" + listMap.getString("silcount", i) + "</td>");
			sbListHtml.append("		<td>" + listMap.getString("buncount", i) + "</td>");
			sbListHtml.append("		<td>" + listMap.getString("avreport", i) + "</td>");
			sbListHtml.append("		<td>" + listMap.getString("avcourse", i) + "</td>");
			sbListHtml.append("		<td>" + listMap.getString("miscount", i) + "</td>");
			sbListHtml.append("		<td>" + listMap.getString("boncount", i) + "</td>");
			sbListHtml.append("		<td>" + listMap.getString("addpoint", i) + "</td>");
			sbListHtml.append("		<td>" + listMap.getString("maxpoint", i) + "</td>");
			sbListHtml.append("		<td>" + listMap.getString("minpoint", i) + "</td>");
			sbListHtml.append("		<td class=\"br0\">" + listMap.getString("oldpoint", i) + "</td>");
			sbListHtml.append("	</tr>");
		}
	}
	
	String toToYear = "교육훈련성적(평균성적)_" + requestMap.getString("searchYear");
	// String excel_filename = new String(	toToYear.getBytes(), "ISO-8859-1");
WebUtils.setFileHeader(request, response, toToYear+".xls", "UTF-8", "UTF-8");
	response.setHeader("Content-Description", "JSP Generated Data"); 
	response.setContentType( "application/vnd.ms-excel" );
	request.setCharacterEncoding("UTF-8");
	
%>
<meta http-equiv="Content-Type" content="application/vnd.ms-excel; charset=UTF-8">

<table width="95%" border="1" cellpadding="0" cellspacing="0" >
	<tr bgcolor="F7F7F7" align="center" height="30">
		<td class="tableline11" colspan="15"><b><%= toToYear %></b></td>
	</tr>
	<tr bgcolor="F7F7F7" align="center" height="28">
		<td class="tableline11" rowspan="2">구분</td>
		<td class="tableline11" rowspan="2">과정명</td>
		<td class="tableline11" rowspan="2">교육인원</td>
		<td class="tableline11" colspan="9">평균성적</td>
		<td class="tableline11" rowspan="2">최고</td>
		<td class="tableline11" rowspan="2">최하</td>
		<td class="tableline11" class="br0" rowspan="2">전년도평균</td>
	</tr>	
	<tr bgcolor="F7F7F7" align="center" height="28">
		<td class="tableline11" >계</td>
		<td class="tableline11" >학습평가</td>
		<td class="tableline11" >극기훈련</td>
		<td class="tableline11" >분임발표</td>
		
		<td class="tableline11" >과제연구</td>
		<td class="tableline11" >근태</td>
		<td class="tableline11" >역할극</td>
		<td class="tableline11" >봉사활동</td>
		<td class="tableline11" >가점</td>
	</tr>
	<%= sbListHtml.toString() %>
</table>
