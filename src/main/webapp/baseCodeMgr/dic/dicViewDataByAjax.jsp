<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
// prgnm : 용어사전 리스트 Ajax
// date  : 2008-06-02
// auth  : kang
%>

<%@ include file="/commonInc/include/commonImport.jsp" %>

<%

	DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
	requestMap.setNullToInitialize(true);
	
	// 리스트
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	listMap.setNullToInitialize(true);
	
	
	
	StringBuffer sbTable = new StringBuffer();
	
	sbTable.append("<table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">");
	if(listMap.keySize("subj") > 0){
						
		for(int i=0; i < listMap.keySize("subj"); i++){
			
			sbTable.append("<tr>");
			sbTable.append("	<td width=\"30%\" class=\"tableline11\" align=\"center\">" + listMap.getString("words",i) + "</td> ");
			sbTable.append("	<td class=\"tableline21\" align=\"left\" style=\"padding:10 10 10 10;word-break:break-all;\" >" + listMap.getString("descs",i) + "</td> ");
			sbTable.append("</tr> ");
			
		}
		
	}else{
		sbTable.append("<tr height=\"100\">");
		sbTable.append("	<td class=\"tableline21\" align=\"center\" >검색된 데이타가 없습니다.</td> ");
		sbTable.append("</tr> ");
	}
	sbTable.append("</table>");



%>
<%= sbTable.toString() %>

