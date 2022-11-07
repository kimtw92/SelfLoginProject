<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 교육훈련성적 - 성적분포 엑셀
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
			sbListHtml.append("		<td>" + listMap.getString("paccept", i) + "</td>");
			sbListHtml.append("		<td>" + listMap.getString("totcount1", i) + "</td>");
			sbListHtml.append("		<td>" + listMap.getString("totcount2", i) + "</td>");
			sbListHtml.append("		<td>" + listMap.getString("totcount3", i) + "</td>");
			sbListHtml.append("		<td>" + listMap.getString("totcount4", i) + "</td>");
			sbListHtml.append("		<td>" + listMap.getString("totcount5", i) + "</td>");
			sbListHtml.append("		<td>" + listMap.getString("maxpoint", i) + "</td>");
			sbListHtml.append("		<td>" + listMap.getString("minpoint", i) + "</td>");			
			sbListHtml.append("		<td class=\"br0\">" + listMap.getString("oldpoint", i) + "</td>");
			sbListHtml.append("	</tr>");			
		}
	}
	
	String toToYear = "교육훈련성적(성적분포)_" + requestMap.getString("searchYear");
	// String excel_filename = new String(	toToYear.getBytes(), "ISO-8859-1");
WebUtils.setFileHeader(request, response, toToYear+".xls", "UTF-8", "UTF-8");
	response.setHeader("Content-Description", "JSP Generated Data"); 
	response.setContentType( "application/vnd.ms-excel" );
	request.setCharacterEncoding("UTF-8");
	
%>

<meta http-equiv="Content-Type" content="application/vnd.ms-excel; charset=UTF-8">


<table width="95%" border="1" cellpadding="0" cellspacing="0" >
	<tr bgcolor="F7F7F7" align="center" height="30">
		<td class="tableline11" colspan="12"><b><%= toToYear %></b></td>
	</tr>
	<tr bgcolor="F7F7F7" align="center" height="28">
		<td class="tableline11" rowspan="2">구분</td>
		<td class="tableline11" rowspan="2">과정명</td>
		<td class="tableline11" rowspan="2">교육인원</td>
		<td class="tableline11" rowspan="2">평균성적</td>
		<td class="tableline11" colspan="5">성적분포</td>
		<td class="tableline11" rowspan="2">최고</td>
		<td class="tableline11" rowspan="2">최하</td>
		<td class="tableline11" class="br0" rowspan="2">전년도평균</td>
	</tr>	
	<tr bgcolor="F7F7F7" align="center" height="28">
		<td class="tableline11" >60점미만</td>
		<td class="tableline11" >60~69</td>
		<td class="tableline11" >70~79</td>
		<td class="tableline11" >80~89</td>
		<td class="tableline11" >90점이상</td>
	</tr>
	<%= sbListHtml.toString() %>
</table>
