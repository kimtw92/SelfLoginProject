<%@ page language="java" contentType="text/html;" pageEncoding="UTF-8"%>
<%@ include file="/commonInc/include/commonImport.jsp" %>

<%
// date	: 2008-08-26
// auth 	: 양정환
%>

<%
	DataMap listMap = (DataMap)request.getAttribute("TEAM_LIST_BY_NAME");
	listMap.setNullToInitialize(true);


	StringBuffer list = new StringBuffer();

	
	list.append("<h4 class=\"h4RecLtxt\">검색결과</h4> ");
	list.append("<div class=\"h9\"></div> ");
	
	if(listMap.keySize("username") > 0){	
		list.append("<table class=\"dataH07\"> ");	
		list.append("<colgroup><col width=\"100\" /><col width=\"138\" /><col width=\"130\" /><col width=\"*\" /></colgroup> ");
		list.append("<thead> ");
		list.append("<tr><th class=\"bl0 thB\">직급</th><th class=\"thB\">이름</th><th class=\"thB\">전화번호</th><th class=\"thB\">업 무</th></tr> ");
		list.append("</thead> ");
		list.append("<tbody> "); 
		
		for(int i=0; i < listMap.keySize("username"); i++){
			list.append("<tr> ");				
			list.append("<td>"+listMap.getString("memberJikName", i)+"</td> ");
			list.append("<td>"+listMap.getString("username", i)+"</td> ");
			list.append(" <td>"+listMap.getString("phoneNumber", i)+"</td> ");
			list.append("<td class=\"left01\">"+listMap.getString("content", i)+"</td> ");
			list.append("</tr> ");             
		}
		
		list.append("</tbody> ");
		list.append("</table> ");
		list.append(" <div class=\"h25\"></div> ");	 
		
	}else {
		list.append(" &nbsp;&nbsp;&nbsp;<font color=\"red\">검색 결과가 없습니다.</font>");
	}
%>

<%= list.toString()%>
