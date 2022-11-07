<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%
// prgnm : 설문결과 관리 리스트
// date : 2008 - 09 - 22
// auth : 정 윤철
%>

<!-- [s] commonImport -->
<%@ include file="/commonInc/include/commonImport.jsp" %>
<!-- [e] commonImport -->

<%

	//request
	DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
	requestMap.setNullToInitialize(true);
	
	//각 셀렉박스 데이터
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	if(listMap == null){
		listMap = new DataMap();
	}
	
	listMap.setNullToInitialize(true);

	//각 셀렉박스에대한 구분 변수
	String qu = requestMap.getString("qu");
	//과정명 옵션박스 
	StringBuffer grcodeSelectBox = new StringBuffer();
	if(qu.equals("sequence")){
		grcodeSelectBox.append("<select name=\"sequence\" onchange=\"selectInquiryAjax('end')\" class=\"mr10\">");
		grcodeSelectBox.append("<option value=\"\" selected> **선택하세요** </option>");
		if(listMap.keySize("titleNo") > 0 ){
			for(int i=0; i < listMap.keySize("titleNo"); i++){
				grcodeSelectBox.append("<option value=\""+listMap.getString("titleNo", i)+"\">"+listMap.getString("titleSeq",i) +"</option>");

			}	
		}else{
			grcodeSelectBox.append("<option value=\"\">회차가 없습니다.</option>");
			
		}		
		
		grcodeSelectBox.append("</select>");
	
	}else if(qu.equals("end")){
		grcodeSelectBox.append("<input type=\"hidden\" name=\"minVal\" value=\""+listMap.getString("minVal")+"\">");
		
	}
		
%>

<%=grcodeSelectBox.toString() %>

