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
	
	
	////////////////////////////////////////////////////////////////////////////////////
	
	
	String sType = Util.getValue(requestMap.getString("sType"),"1");
	String yearMonthFrom = Util.getValue(requestMap.getString("yearMonthFrom"),(String)request.getAttribute("DATE_FROM"));
	String yearMonthTo = Util.getValue(requestMap.getString("yearMonthTo"),(String)request.getAttribute("DATE_TO"));
	
	String bgColor = "";
	
	StringBuffer sbListHtml = new StringBuffer();
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	if(listMap == null) listMap = new DataMap();
	listMap.setNullToInitialize(true);
	
	
	if(listMap.keySize("pflag") > 0){		
		for(int i=0; i < listMap.keySize("pflag"); i++){
			
			if(listMap.getString("pflag", i).equals("A")){
				bgColor = "bgcolor=\"#cccccc\"";				
			}else if(listMap.getString("pflag", i).equals("B")){
				bgColor = "bgcolor=\"ffcc00\"";
			}else{
				bgColor = "";
			}
			
			sbListHtml.append("<tr>");
			if(listMap.getString("pflag",i).equals("C")){
				sbListHtml.append("	<td>" + listMap.getString("gubunnm", i) + "</td>");
				sbListHtml.append("	<td>" + listMap.getString("grcodenm", i) + "</td>");
			}else{
				//sbListHtml.append("	<td colspan=\"2\">" + listMap.getString("gubunnm", i) + "</td>");
				sbListHtml.append("	<td ><b>" + listMap.getString("gubunnm", i) + "</b></td>");
				sbListHtml.append("	<td ></td>");
			}
									
			sbListHtml.append("	<td>" + Util.moneyFormValue(listMap.getString("stuCnt", i)) + "</td>");
			sbListHtml.append("	<td>" + Util.moneyFormValue(listMap.getString("grseqCnt", i)) + "</td>");
			sbListHtml.append("	<td>" + Util.moneyFormValue(listMap.getString("tutorTotalCnt", i)) + "</td>");
			sbListHtml.append("	<td>" + Util.moneyFormValue(listMap.getString("total1", i)) + "</td>");
			sbListHtml.append("	<td>" + Util.moneyFormValue(listMap.getString("aCnt", i)) + "</td>");
			sbListHtml.append("	<td>" + Util.moneyFormValue(listMap.getString("a1Cnt", i)) + "</td>");
			sbListHtml.append("	<td>" + Util.moneyFormValue(listMap.getString("aTotalCnt", i)) + "</td>");
			sbListHtml.append("	<td>" + Util.moneyFormValue(listMap.getString("bCnt", i)) + "</td>");
			sbListHtml.append("	<td>" + Util.moneyFormValue(listMap.getString("c1Cnt", i)) + "</td>");
			sbListHtml.append("	<td>" + Util.moneyFormValue(listMap.getString("c2Cnt", i)) + "</td>");
			sbListHtml.append("	<td>" + Util.moneyFormValue(listMap.getString("cTotalCnt", i)) + "</td>");
			sbListHtml.append("	<td>" + Util.moneyFormValue(listMap.getString("dCnt", i)) + "</td>");
			sbListHtml.append("	<td>" + Util.moneyFormValue(listMap.getString("zCnt", i)) + "</td>");
			sbListHtml.append("	<td style=\"border-right:0px solid #E5E5E5;\"></td>");
			sbListHtml.append("</tr>");			
			
		}
	}
	
	String toToYear = "강사활용실적_" + requestMap.getString("yearMonthFrom") + "_" + requestMap.getString("yearMonthTo");
	// String excel_filename = new String(	toToYear.getBytes(), "ISO-8859-1");
	WebUtils.setFileHeader(request, response, toToYear+".xls", "UTF-8", "UTF-8");
	response.setHeader("Content-Description", "JSP Generated Data"); 
	response.setContentType( "application/vnd.ms-excel" );
	request.setCharacterEncoding("UTF-8");
%>

<script language="javascript" src="/commonInc/js/rowspan.js"></script>

<script for="window" event="onload">
<!--
cellMergeChk($("dataList"), 3, 0);		//첫번째 td 처리
//-->
</script>

<meta http-equiv="Content-Type" content="application/vnd.ms-excel; charset=UTF-8">



<table width="95%" border="1" cellpadding="0" cellspacing="0" >	
	<tr bgcolor="F7F7F7" align = center>
		<td height="28" class="tableline11" rowspan = 2><b>구분</b></td>
		<td class="tableline11" rowspan = 2><b>과정명</b></td>
		<td class="tableline11" rowspan = 2><b>교육인원</b></td>
		<td class="tableline11" rowspan = 2><b>기수</b></td>
		<td class="tableline11" rowspan = 2><b>총강의시간 (①+②+③+⑤)</b></td>
		<td class="tableline11" colspan = 9><b>외래강사</b></td>
		<td class="tableline11" rowspan = 2><b>자체교관인원 (⑤)</b></td>
		<td class="tableline21" rowspan = 2><b>비고</b></td>
	</tr>
	<tr bgcolor="F7F7F7" align = center>
		<td height="28" class="tableline11"><b>소계(①+②+③)</b></td>
		<td class="tableline11"><b>특A급</b></td>
		<td class="tableline11"><b>A급</b></td>
		<td class="tableline11"><b>A급소계(①)</b></td>
		<td class="tableline11"><b>B급(②)</b></td>
		<td class="tableline11"><b>C1급</b></td>
		<td class="tableline11"><b>C2급</b></td>
		<td class="tableline11"><b>C급소계(③)</b></td>
		<td class="tableline11"><b>D급보조(④)</b></td>
	</tr>
</table>
<table width="95%" border="1" cellpadding="0" cellspacing="0" >
<%= sbListHtml.toString() %>		
</table>



