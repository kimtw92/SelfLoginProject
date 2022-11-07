<%@ page language="java" contentType="text/html;" pageEncoding="UTF-8"%><%@ include file="/commonInc/include/commonImport.jsp" %><%

	DataMap reqMap = (DataMap)request.getAttribute("LIST_DATA");
	reqMap.setNullToInitialize(true);
	
	if (reqMap.getInt("limit") > 0){
		if (reqMap.getInt("limit") <= reqMap.getInt("attendCnt")){
			out.println("false");
		} else {
			out.println("true");
		}
	} else {
		out.println("true");
	}
%>
