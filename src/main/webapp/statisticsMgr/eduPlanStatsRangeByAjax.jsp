<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 교육훈련성적 - 성적분포 list ajax
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
	sbListHtml.append("		<th rowspan=\"2\">평균성적</th>");
	sbListHtml.append("		<th colspan=\"5\">성적분포</th>");
	sbListHtml.append("		<th rowspan=\"2\">최고</th>");
	sbListHtml.append("		<th rowspan=\"2\">최하</th>");
	sbListHtml.append("		<th class=\"br0\" rowspan=\"2\">전년도평균</th>");
	sbListHtml.append("	</tr>");
	sbListHtml.append("	<tr>");
	sbListHtml.append("		<th>60점미만</th>");
	sbListHtml.append("		<th>60~69</th>");
	sbListHtml.append("		<th>70~79</th>");
	sbListHtml.append("		<th>80~89</th>");
	sbListHtml.append("		<th>90점이상</th>");	
	sbListHtml.append("	</tr>");
	sbListHtml.append("	</thead>");
	sbListHtml.append("	<tbody>");
	
	
	
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
	
	sbListHtml.append("	</tbody>");
	sbListHtml.append("</table>");

%>
<%= sbListHtml.toString() %>