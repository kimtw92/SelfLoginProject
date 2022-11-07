<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
// prgnm : 부서 select Box
// date : 2008-06-27
// auth : Lym
%>

<%@ include file="/commonInc/include/commonImport.jsp" %>

<%

	//필수 코딩 내용 //////////////////////////////////////////////////////////////////////

	//request 데이터
	DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
	requestMap.setNullToInitialize(true);
		
	////////////////////////////////////////////////////////////////////////////////////

	//과정 목록.	
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	listMap.setNullToInitialize(true);

	String selectBoxStr = "";
	String tmpStr = "";
	for(int i=0; i < listMap.keySize("partcd"); i++){
		
		tmpStr = listMap.getString("partcd", i).equals(requestMap.getString("partcd")) ? "selected" : "";
		
		selectBoxStr += "<option value='" + listMap.getString("partcd",i) + "' " + tmpStr + ">" + listMap.getString("partnm",i) + "</option>";
	}


%>

<select name="partcd" onChange="go_setPartNm(this.options[this.selectedIndex].text);" style="font-size:12px">
	<option value="">직접입력</option>
	<%= selectBoxStr %>
</select>