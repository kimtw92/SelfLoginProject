<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%
// prgnm : 계정관리의 부서코드 셀렉트  박스 리스트(AJAX)
// date : 2008-05-29
// auth : 정 윤철
%>

<!-- [s] commonImport -->
<%@ include file="/commonInc/include/commonImport.jsp" %>
<!-- [e] commonImport -->

<%

	//request
	DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
	requestMap.setNullToInitialize(true);
	
	//부서코드,부서명 리스트 데이터.
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	listMap.setNullToInitialize(true);

	//부서명,부서코드 셀렉트박스 리스트
	String partCdStr = "";
	

	if(requestMap.getString("qu").equals("")){
		partCdStr += "<input type=\"text\" maxlength=\"20\" class=\"textfield\" name=\"partnm\" value=\"" + requestMap.getString("partnm") + "\" required=\"true!부서명을 입력하십시오.\">&nbsp;";
	}else{
		partCdStr += "";
	}
	
	
	partCdStr += "<select name=\"partcd\" onchange=\"getPart(this.options[this.selectedIndex].value, this.options[this.selectedIndex].text)\">";
	if(listMap.keySize("partcd") > 0 ) {
		partCdStr += "<option value=\"\">직접입력</option>";
		for(int i=0; i < listMap.keySize("partcd"); i++){

			
			String selectedStr = "";
			if(listMap.getString("partcd",i).equals(requestMap.getString("partcd")) )
				selectedStr = "selected";

			partCdStr += "<option value='"+listMap.getString("partcd", i)+"' " + selectedStr + ">"+listMap.getString("partnm",i) +"</option>";
		}
	} else if(listMap.keySize("partcd") <=0 ) {
		partCdStr += "<option value=\"\">직접입력</option>";
	}
	
	partCdStr += "</select>"; 

%>
<%=partCdStr%>

