<%@ page language="java" contentType="text/html;" pageEncoding="UTF-8"%>
<%@ include file="/commonInc/include/commonImport.jsp" %>
<%

	DataMap requestMap = (DataMap)request.getAttribute("PART_DATA");
	requestMap.setNullToInitialize(true);
	
	StringBuffer strHtml = new StringBuffer();
	
	strHtml.append("<dt>부 서 명</dt> \n"); 
	strHtml.append("<dd>: \n <input type=\"text\" name=\"DEPTSUB\" class=\"input01 w159\" size=\"20\"> \n");
	strHtml.append("				<select name=\"PART_DATA\" class=\"select01 w120\" onChange=\"getPart(this.options[this.selectedIndex].value,this.options[this.selectedIndex].text)\">\n");
	strHtml.append("						<option value = \"\" >--- 부서 선택 ---</option>\n");
	
	if(!"6289999".equals((String)request.getAttribute("dept"))) {
 		if("6280000".equals((String)request.getAttribute("dept"))) {
			strHtml.append("						<option value = \"\" selected>인천시청실과명입력</option>\n");
		} else {
			strHtml.append("			<option value = \"\">직접입력</option>\n");
		}
	}
	if(requestMap.keySize("partcd") > 0){		
		for(int i=0; i < requestMap.keySize("partcd"); i++){
			strHtml.append("						<option value = \""+requestMap.getString("partcd",i)+"\" >"+requestMap.getString("partnm",i)+"</option>\n");
		}
	}
	strHtml.append("			</select>\n");
	strHtml.append("</dd> \n ");
	out.println(strHtml.toString());
%>


