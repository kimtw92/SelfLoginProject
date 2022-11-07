<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
// prgnm : 선택과목 추가  리스트 Ajax
// date  : 2008-06-04
// auth  : kang
%>

<%@ include file="/commonInc/include/commonImport.jsp" %>

<%

	DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
	requestMap.setNullToInitialize(true);
	
	// 리스트
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	listMap.setNullToInitialize(true);
	
	
	String param = "";
	StringBuffer sbTable = new StringBuffer();
	
	sbTable.append("<table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">");
	sbTable.append("	<tr bgcolor=\"#375694\"><td height=\"2\" colspan=\"4\"></td></tr>");
	sbTable.append("	<tr height=\"28\" bgcolor=\"#5071B4\"> ");
	sbTable.append("		<td width=\"30\" align=\"center\" class=\"tableline11 white\"><strong>번호</strong></td> ");
	sbTable.append("		<td width=\"30\" align=\"center\" class=\"tableline11 white\"><strong>선택</strong></td> ");
	sbTable.append("		<td width=\"80\" align=\"center\" class=\"tableline11 white\"><strong>과목코드</strong></td> ");
	sbTable.append("		<td align=\"center\" class=\"tableline11 white\"><strong>과목명</strong></td> ");
	sbTable.append("	</tr> ");
	
	
	if(listMap.keySize("subj") > 0){
		
		for(int i=0; i < listMap.keySize("subj"); i++){
			
			sbTable.append("<tr height=\"25\">");
			sbTable.append("	<td class=\"tableline11\" align=\"center\">" + (i+1) + "</td> ");
			sbTable.append("	<td class=\"tableline11\" align=\"center\" >");			
			sbTable.append("		<input type=\"checkbox\" name=\"sbjCode\" id=\"sbjCode_" + i + "\" value='" + listMap.getString("subj",i) + "'>");
			sbTable.append("		<input type=\"hidden\" name=\"sbjNm\" id=\"sbjNm_" + i + "\" value=\"" + listMap.getString("subjnm",i) + "\" >   ");
			sbTable.append("	</td> ");
			sbTable.append("	<td class=\"tableline11\" align=\"center\" ><label for=\"sbjCode_" + i + "\">" + listMap.getString("subj",i) + "</label></td> ");
			sbTable.append("	<td class=\"tableline21\" align=\"left\" style=\"padding:5 0 0 5;\" ><label for=\"sbjCode_" + i + "\">" + listMap.getString("subjnm",i) + "</label></td> ");
			sbTable.append("</tr> ");
			
		}
		
	}else{
		sbTable.append("<tr height=\"100\">");
		sbTable.append("	<td class=\"tableline21\" align=\"center\" colspan=\"4\" >검색된 데이타가 없습니다.</td> ");
		sbTable.append("</tr> ");
	}
	sbTable.append("	<tr bgcolor=\"#375694\"><td height=\"2\" colspan=\"4\"></td></tr>");
	sbTable.append("</table>");
	
	
%>
<%= sbTable.toString() %>

