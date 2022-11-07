<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
// prgnm : 동영상 리스트(Ajax)
// date  : 2009-06-08
// auth  : hwani
%>

<%@ include file="/commonInc/include/commonImport.jsp" %>

<%
	DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
	requestMap.setNullToInitialize(true);
	
	//리스트
	DataMap movList = (DataMap)request.getAttribute("MOV_LIST_DATA");
	movList.setNullToInitialize(true);
	
	//과목코드
	String subj = (String)request.getAttribute("SUBJ_CODE");
	
	String mode = requestMap.getString("mode");
	
	int orgNum = 1;
	String listStr = "";
	String tmpStr = "";
	String tmpStr2 = "";
	
	System.out.println("subj === " + subj);
	System.out.println("movList === " + movList);
	System.out.println("requestMap === " + requestMap);
	
	listStr += "<table width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" bgcolor=\"#FFFFFF\">";
	for(int i=0; i < movList.keySize("contCode"); i++){

		listStr += "<tr bgcolor=\"#FFFFFF\">";
		
		tmpStr  = "<input type=\"hidden\" name=\"arrayOrgId_left\" id=\"org&"+i+"\" value=\"" + movList.getString("contCode", i) + ",," + movList.getString("contName", i) + "\"><b>" + movList.getString("contName", i) + "</b>&nbsp;";
		tmpStr2 = "<input type=\"button\" onclick=\"go_removeCont('" + movList.getString("contCode", i) + "')\" value=\"삭 제\" class=\"boardbtn1\">";
		
		listStr += "<td width=\"90%\" height=\"22\" class=\"padding_left\"><br>" + tmpStr + "</td>";
		listStr += "<td width=\"10%\">" + tmpStr2 + "</td>";
		listStr += "</tr>";

		orgNum ++;
	}
	listStr += "</table>";
%>

<input name="contSize" type="hidden" id="contSize" value="<%= movList.keySize("contCode") %>" >
<%=listStr%>