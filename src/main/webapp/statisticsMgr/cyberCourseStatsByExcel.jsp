<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 사이버교육통계  엑셀
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
	
	String yearMonthFrom = Util.getValue(requestMap.getString("yearMonthFrom"),(String)request.getAttribute("DATE_FROM"));
	String yearMonthTo = Util.getValue(requestMap.getString("yearMonthTo"),(String)request.getAttribute("DATE_TO"));
	String subjType = Util.getValue(requestMap.getString("subjType"),"Y");
	
	
	String bgColor = "";
	
	StringBuffer sbListHtml = new StringBuffer();
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	if(listMap == null) listMap = new DataMap();
	listMap.setNullToInitialize(true);
	
	if(listMap.keySize("gubunnm") > 0){		
		for(int i=0; i < listMap.keySize("gubunnm"); i++){
			
			
			// tr 배경색
			if(listMap.getString("pflag", i).equals("A")){
				bgColor = "bgcolor=\"#cccccc\"";			
			}else{
				bgColor = "";
			}
			
			sbListHtml.append("<tr " + bgColor + " >");
			
			sbListHtml.append("	<td>" + listMap.getString("gubunnm", i) + "</td>");			
			sbListHtml.append("	<td>" + listMap.getString("grcodeniknm", i) + "</td>");
			sbListHtml.append("	<td style=\"text-align: left\">&nbsp;" + listMap.getString("subjnm", i) + "</td>");
			sbListHtml.append("	<td>" + Util.moneyFormValue(listMap.getString("grseqCnt", i)) + "</td>");			
			sbListHtml.append("	<td>" + Util.moneyFormValue(listMap.getString("tseat", i)) + "</td>");
			sbListHtml.append("	<td>" + Util.moneyFormValue(listMap.getString("grseqResucnt", i)) + "</td>");
			sbListHtml.append("	<td>" + Util.moneyFormValue(listMap.getString("manResucnt", i)) + "</td>");
			sbListHtml.append("	<td>" + Util.moneyFormValue(listMap.getString("woResucnt", i)) + "</td>");
			sbListHtml.append("	<td>" + Util.moneyFormValue(listMap.getString("totno", i)) + "</td>");
			sbListHtml.append("	<td class=\"br0\">합계</td>");
						
			sbListHtml.append("</tr>");												
		}
	}
	
	String toToYear = "사이버교육통계_" + requestMap.getString("yearMonthFrom") + "~" + requestMap.getString("yearMonthTo");
	// String excel_filename = new String(	toToYear.getBytes(), "ISO-8859-1");
	WebUtils.setFileHeader(request, response, toToYear+".xls", "UTF-8", "UTF-8");
	response.setHeader("Content-Description", "JSP Generated Data"); 
	response.setContentType( "application/vnd.ms-excel" );
	request.setCharacterEncoding("UTF-8");
	
%>
<meta http-equiv="Content-Type" content="application/vnd.ms-excel; charset=UTF-8">

<table width="95%" border="1" cellpadding="0" cellspacing="0" >
	<tr bgcolor="F7F7F7" align="center" height="30">
		<td class="tableline11" colspan="10"><b><%= toToYear %></b></td>
	</tr>
	<tr bgcolor="F7F7F7" align="center" height="28">
		<td class="tableline11" rowspan="2">구분</td>
		<td class="tableline11" rowspan="2">과정명</td>
		<td class="tableline11" rowspan="2">사이버과목명</td>
		<td class="tableline11" colspan="2">계획</td>
		<td class="tableline11" colspan="4">실적(등록인원)</td>
		<td class="tableline11" class="br0" rowspan="2">비율(%)</td>
	</tr>	
	<tr bgcolor="F7F7F7" align="center" height="28">
		<td class="tableline11" >횟수</td>
		<td class="tableline11" >인원</td>
		<td class="tableline11" >횟수</td>
		<td class="tableline11" >남</td>		
		<td class="tableline11" >여</td>
		<td class="tableline11" >합계</td>
	</tr>
	<%= sbListHtml.toString() %>
</table>


