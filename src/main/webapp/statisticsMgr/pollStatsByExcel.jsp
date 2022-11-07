<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 과정별 설문통계
// date  : 2008-08-07
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
	
	String commYear = requestMap.getString("commYear");
	
	StringBuffer sbListHtml = new StringBuffer();
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	if(listMap == null) listMap = new DataMap();
	listMap.setNullToInitialize(true);
	
	String tmpQuestion = "";
	String bgColor = "";
	String textAlignLeft = "";
	
	if(listMap.keySize("question") > 0){		
		for(int i=0; i < listMap.keySize("question"); i++){
			
			
			if(listMap.getString("pflag", i).equals("A")){
				bgColor = "bgcolor=\"#cccccc\"";
				textAlignLeft = "";
			}else if(listMap.getString("pflag", i).equals("B")){
				bgColor = "bgcolor=\"ffcc00\"";
				textAlignLeft = "";
			}else{
				bgColor = "";
				
				textAlignLeft = "style=\"text-align:left\"";
			}
			
			
			
			// 다르면 타이틀 태그를 넣는다.
			if(!tmpQuestion.equals(listMap.getString("question",i))){
				sbListHtml.append("<table width=\"95%\" border=\"1\" cellpadding=\"0\" cellspacing=\"0\" >");
				sbListHtml.append("<thead>");
				sbListHtml.append("	<tr bgcolor=\"F7F7F7\" align=\"center\" height=\"28\" >");
				sbListHtml.append("		<td rowspan=\"3\" width=\"250\" class=\"tableline11\">과정명</td>");
				sbListHtml.append("		<td colspan=\"11\" style=\"text-align:left\" class=\"tableline11\">&nbsp;" + listMap.getString("question",i) + "</td>");
				sbListHtml.append("		<td class=\"br0\" rowspan=\"3\" width=\"60\" class=\"tableline11\">비고</td>");
				sbListHtml.append("	</tr>");
				sbListHtml.append("	<tr bgcolor=\"F7F7F7\" align=\"center\" height=\"28\">");
				sbListHtml.append("		<td rowspan=\"2\" width=\"80\" class=\"tableline11\">총응답수</td>");
				sbListHtml.append("		<td colspan=\"2\" class=\"tableline11\">매우 양호</td>");
				sbListHtml.append("		<td colspan=\"2\" class=\"tableline11\">비교적 양호</td>");
				sbListHtml.append("		<td colspan=\"2\" class=\"tableline11\">보통</td>");
				sbListHtml.append("		<td colspan=\"2\" class=\"tableline11\">다소미흡</td>");
				sbListHtml.append("		<td colspan=\"2\" class=\"tableline11\">매우미흡</td>");
				sbListHtml.append("	</tr>");
				sbListHtml.append("	<tr bgcolor=\"F7F7F7\" align=\"center\" height=\"28\">");
				sbListHtml.append("		<td width=\"60\" class=\"tableline11\">인원</td>");
				sbListHtml.append("		<td width=\"60\" class=\"tableline11\">비율</td>");
				sbListHtml.append("		<td width=\"60\" class=\"tableline11\">인원</td>");
				sbListHtml.append("		<td width=\"60\" class=\"tableline11\">비율</td>");
				sbListHtml.append("		<td width=\"60\" class=\"tableline11\">인원</td>");
				sbListHtml.append("		<td width=\"60\" class=\"tableline11\">비율</td>");
				sbListHtml.append("		<td width=\"60\" class=\"tableline11\">인원</td>");
				sbListHtml.append("		<td width=\"60\" class=\"tableline11\">비율</td>");
				sbListHtml.append("		<td width=\"60\" class=\"tableline11\">인원</td>");
				sbListHtml.append("		<td width=\"60\" class=\"tableline11\">비율</td>");
				sbListHtml.append("	</tr>");
				sbListHtml.append("</thead>");
				sbListHtml.append("<tbody>");
			}
									
			if(i==0){								
				
				sbListHtml.append("<tr " + bgColor + ">");
				sbListHtml.append("	<td>" + listMap.getString("grnm",i) + "</td>");
				sbListHtml.append("	<td >" + Util.moneyFormValue(listMap.getString("ansNo",i)) + "</td>");
				sbListHtml.append("	<td >" + Util.moneyFormValue(listMap.getString("num1",i)) + "</td>");
				sbListHtml.append("	<td >" + listMap.getString("num1Avg",i) + "</td>");
				sbListHtml.append("	<td >" + Util.moneyFormValue(listMap.getString("num2",i)) + "</td>");
				sbListHtml.append("	<td >" + listMap.getString("num2Avg",i) + "</td>");
				sbListHtml.append("	<td >" + Util.moneyFormValue(listMap.getString("num3",i)) + "</td>");
				sbListHtml.append("	<td >" + listMap.getString("num3Avg",i) + "</td>");
				sbListHtml.append("	<td >" + Util.moneyFormValue(listMap.getString("num4",i)) + "</td>");
				sbListHtml.append("	<td >" + listMap.getString("num4Avg",i) + "</td>");
				sbListHtml.append("	<td >" + Util.moneyFormValue(listMap.getString("num5",i)) + "</td>");
				sbListHtml.append("	<td >" + listMap.getString("num5Avg",i) + "</td>");
				sbListHtml.append("	<td class=\"br0\"></td>");
				sbListHtml.append("</tr>");
								
				tmpQuestion = listMap.getString("question",i);
				
			}else{
				
				sbListHtml.append("<tr " + bgColor + ">");
				sbListHtml.append("	<td  " + textAlignLeft + ">&nbsp;" + listMap.getString("grnm",i) + "</td>");
				sbListHtml.append("	<td >" + Util.moneyFormValue(listMap.getString("ansNo",i)) + "</td>");
				sbListHtml.append("	<td >" + Util.moneyFormValue(listMap.getString("num1",i)) + "</td>");
				sbListHtml.append("	<td >" + listMap.getString("num1Avg",i) + "</td>");
				sbListHtml.append("	<td >" + Util.moneyFormValue(listMap.getString("num2",i)) + "</td>");
				sbListHtml.append("	<td >" + listMap.getString("num2Avg",i) + "</td>");
				sbListHtml.append("	<td >" + Util.moneyFormValue(listMap.getString("num3",i)) + "</td>");
				sbListHtml.append("	<td >" + listMap.getString("num3Avg",i) + "</td>");
				sbListHtml.append("	<td >" + Util.moneyFormValue(listMap.getString("num4",i)) + "</td>");
				sbListHtml.append("	<td >" + listMap.getString("num4Avg",i) + "</td>");
				sbListHtml.append("	<td >" + Util.moneyFormValue(listMap.getString("num5",i)) + "</td>");
				sbListHtml.append("	<td >" + listMap.getString("num5Avg",i) + "</td>");
				sbListHtml.append("	<td class=\"br0\" ></td>");
				sbListHtml.append("</tr>");
				
				if(i < listMap.keySize("question")){
					
					if( !listMap.getString("question",i).equals(listMap.getString("question",i+1)) ){
						sbListHtml.append("	</tbody>");
						sbListHtml.append("</table>");
						sbListHtml.append("<br><br>");
					}
					
					tmpQuestion = listMap.getString("question",i);
					
				}else{
					sbListHtml.append("	</tbody>");
					sbListHtml.append("</table>");
					sbListHtml.append("<br><br>");
				}				
			}															
		}
	}else{
		sbListHtml.append("<table class=\"datah01\">");
		sbListHtml.append("<tr><td style=\"height:100px\">결과가 업습니다.</td></tr>");
		sbListHtml.append("</table>");
	}	
	
	String toToYear = "과정별설문통계_" + commYear;
	// String excel_filename = new String(	toToYear.getBytes(), "ISO-8859-1");
	WebUtils.setFileHeader(request, response, toToYear+".xls", "UTF-8", "UTF-8");
	response.setHeader("Content-Description", "JSP Generated Data"); 
	response.setContentType( "application/vnd.ms-excel" );
	request.setCharacterEncoding("UTF-8");
	
%>
<meta http-equiv="Content-Type" content="application/vnd.ms-excel; charset=UTF-8">

<%= sbListHtml.toString() %>


