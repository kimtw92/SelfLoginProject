<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 분야별 통계 엑셀
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
	
	LoginInfo memberInfo = (LoginInfo)request.getAttribute("LOGIN_INFO");
	
	////////////////////////////////////////////////////////////////////////////////////
	
	String dept = "";
	if( memberInfo.getSessClass().equals("3")){
		dept = memberInfo.getSessDept();
	}
	
	
	String yearMonthFrom = Util.getValue(requestMap.getString("yearMonthFrom"),(String)request.getAttribute("DATE_FROM"));
	String yearMonthTo = Util.getValue(requestMap.getString("yearMonthTo"),(String)request.getAttribute("DATE_TO"));
	
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
			sbListHtml.append("	<td>" + Util.moneyFormValue(listMap.getString("grcodeCnt", i)) + "</td>");
			sbListHtml.append("	<td>" + Util.moneyFormValue(listMap.getString("grseqCnt", i)) + "</td>");
			sbListHtml.append("	<td>" + Util.moneyFormValue(listMap.getString("planInwon", i)) + "</td>");
			sbListHtml.append("	<td>" + Util.moneyFormValue(listMap.getString("grseqCount", i)) + "</td>");
			sbListHtml.append("	<td>" + Util.moneyFormValue(listMap.getString("male", i)) + "</td>");
			sbListHtml.append("	<td>" + Util.moneyFormValue(listMap.getString("female", i)) + "</td>");
			sbListHtml.append("	<td>" + Util.moneyFormValue(listMap.getString("resuInwon", i)) + "</td>");
			sbListHtml.append("	<td>" + listMap.getString("rate", i) + "</td>");
			sbListHtml.append("	<td class=\"br0\"></td>");
						
			sbListHtml.append("</tr>");
		}
	}
	
	String toToYear = "분야별통계_" + requestMap.getString("yearMonthFrom") + "_" + requestMap.getString("yearMonthTo");
// 	String excel_filename = new String(	toToYear.getBytes(), "ISO-8859-1");
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
		<td class="tableline11" rowspan="3">구분</td>
		<td class="tableline11" rowspan="3">과정수</td>
		<td class="tableline11" rowspan="3">기수</td>
		<td class="tableline11" colspan="6">교육인원</td>
		<td class="tableline11" class="br0" rowspan="3">비고</td>
	</tr>
	<tr bgcolor="F7F7F7" align="center" height="28">
		<td class="tableline11" rowspan="2">계획</td>
		<td class="tableline11" colspan="4">실적</td>
		<td class="tableline11" rowspan="2">비율(%)</td>
	</tr>
	<tr bgcolor="F7F7F7" align="center" height="28">
		<td class="tableline11" >횟수</td>
		<td class="tableline11" >남</td>
		<td class="tableline11" >여</td>
		<td class="tableline11" >합계</td>
	</tr>
	<%= sbListHtml.toString() %>
</table>




