<%@ page language="java" contentType="text/html;" pageEncoding="UTF-8"%>
<%@ include file="/commonInc/include/commonImport.jsp" %>
<%
// date	: 2008-08-26
// auth 	: 최종삼
%>
<%
	DataMap requestMap = (DataMap)request.getAttribute("LIST_DETAIL");
	requestMap.setNullToInitialize(true);
	
	StringBuffer listHtml = new StringBuffer();
	
	// 각 진도율 확인하는 부분

	if(requestMap.keySize("subj") > 0){		
		for(int i=0; i < requestMap.keySize("subj"); i++){
			listHtml.append("				<tr>\n")
				.append("							<td class=\"inSbj\">");
			if (requestMap.getString("reSubj", i).equals("N")){
				listHtml.append("<a href=\"javascript:go_move('"+requestMap.getString("grcode",i)+"', '"+requestMap.getString("grseq",i)+"', '"+requestMap.getString("subj",i)+"', '"+requestMap.getString("classno",i)+"','"+requestMap.getString("lecType",i)+"')\">"+requestMap.getString("lecnm",i)+"</a>");
			} else {
				listHtml.append("<a href=\"javascript:alert('수강기간이 아닙니다');\">"+requestMap.getString("lecnm",i)+"</a>");
			}
			
			if (requestMap.getString("reSubj", i).equals("Y")){
				//listHtml.append("&nbsp;<a href=\"javascript:replaceChoice('"+requestMap.getString("grcode",i)+"', '"+requestMap.getString("grseq",i)+"', '"+requestMap.getString("subj",i)+"')\"><img src=\"/images/skin1/button/btn_cancel03.gif\" alt=\"변경\" align=\"absmiddle\" /></a>");
			} else {
				// listHtml.append("&nbsp;<a href=\"javascript:alert('수강기간 이전에만 변경이 불가능 합니다')\"><img src=\"/images/skin1/button/btn_cancel03.gif\" alt=\"변경\" align=\"absmiddle\" /></a>");
			}
			listHtml.append("</td>\n")
				.append("							<td >"+requestMap.getString("lecTime",i)+"</td>\n")
				.append("							<td class=\"inNoBottom\">"+requestMap.getString("progress",i)+"</td>\n")
				.append("						</tr>\n");
		}
	} else {
		listHtml.append("				<tr>\n")
		.append("							<td class=\"inNo\" colspan=\"4\">사이버과목이 없습니다</td>\n")
		.append("						</tr>\n");
	}
	listHtml.append("<tr>")
			.append(" <td class=\"inTail\" colspan=\"3\"></td>")
			.append("</tr>");
%>

<%= listHtml.toString()%>
