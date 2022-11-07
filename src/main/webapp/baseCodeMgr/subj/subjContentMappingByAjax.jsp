<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
// prgnm : 콘텐츠 ORG정보  조회
// date  : 2008-09-02
// auth  : LYM
%>

<%@ include file="/commonInc/include/commonImport.jsp" %>


<%
	DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
	requestMap.setNullToInitialize(true);
	
	// 콘텐츠의 org 리스트
	DataMap contentOrgList = (DataMap)request.getAttribute("CONTENT_ORG_LIST_DATA");
	contentOrgList.setNullToInitialize(true);

	int orgNum = 1;
	String listStr = "";
	String tmpStr = "";
	for(int i=0; i < contentOrgList.keySize("orgId"); i++){

		listStr += "<tr bgcolor=\"#FFFFFF\">";

		tmpStr = "<input name=\"arrayOrgId_left\" id=\"org&"+i+"\" type=\"checkbox\" value=\"" + contentOrgList.getString("orgDir", i) + ",," + contentOrgList.getString("orgTitle", i) + "\"><b>" + contentOrgList.getString("orgTitle", i) + "</b>";
		
		listStr += "<td height=\"22\" class=\"padding_left\"><br>" + tmpStr + "</td>";

		listStr += "</tr>";

		orgNum ++;
	}
%>

<input name="orgSize" type="hidden" id="orgSize" value="<%= contentOrgList.keySize("subj") %>" >
<%= listStr %>