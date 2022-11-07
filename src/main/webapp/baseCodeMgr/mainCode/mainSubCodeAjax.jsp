<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commonInc/include/commonImport.jsp" %>
<%
	//request
	DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
	requestMap.setNullToInitialize(true);
	
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	listMap.setNullToInitialize(true);

	String mainSubCodeStr = "";
	for(int i=0; i < listMap.keySize("minorCode"); i++){
		mainSubCodeStr += "<option value='"+listMap.getString("minorCode", i)+"' "+ (requestMap.getString("grsubcd").equals(listMap.getString("minorCode", i)) ? "selected" : "") +">"+listMap.getString("scodeName", i)+"</option>";
	}
%>
&nbsp;
<select name="grsubcd">
<%=mainSubCodeStr%>
</select>