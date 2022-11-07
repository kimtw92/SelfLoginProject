<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 교육훈련성적 - 평균성적 list ajax
// date  : 2008-08-04
// auth  : kang
%>

<%@ include file="/commonInc/include/commonImport.jsp" %>

<%

	StringBuffer sbListHtml = new StringBuffer();

	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	if(listMap == null) listMap = new DataMap();
	
	listMap.setNullToInitialize(true);
	
	
	sbListHtml.append("<table class=\"datah01\">");
	sbListHtml.append("	<thead>");
	sbListHtml.append("	<tr>");
	sbListHtml.append("		<th rowspan=\"2\">구분</th>");
	sbListHtml.append("		<th rowspan=\"2\">과정명</th>");
	sbListHtml.append("		<th rowspan=\"2\">교육인원</th>");
	sbListHtml.append("		<th colspan=\"9\">평균성적</th>");
	sbListHtml.append("		<th rowspan=\"2\">최고</th>");
	sbListHtml.append("		<th rowspan=\"2\">최하</th>");
	sbListHtml.append("		<th class=\"br0\" rowspan=\"2\">전년도평균</th>");
	sbListHtml.append("	</tr>");
	sbListHtml.append("	<tr>");
	sbListHtml.append("		<th>계</th>");
	sbListHtml.append("		<th>학습평가</th>");
	sbListHtml.append("		<th>극기훈련</th>");
	sbListHtml.append("		<th>분임발표</th>");
	sbListHtml.append("		<th>과제연구</th>");
	sbListHtml.append("		<th>근태</th>");
	sbListHtml.append("		<th>역할극</th>");
	sbListHtml.append("		<th>봉사활동</th>");
	sbListHtml.append("		<th>가점</th>");
	sbListHtml.append("	</tr>");
	sbListHtml.append("	</thead>");
	sbListHtml.append("	<tbody>");
	
	
	
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
	
	sbListHtml.append("	</tbody>");
	sbListHtml.append("</table>");

%>
<%= sbListHtml.toString() %>