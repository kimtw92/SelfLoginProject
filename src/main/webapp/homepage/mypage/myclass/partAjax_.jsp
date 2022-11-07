<%@ page language="java" contentType="text/html;" pageEncoding="UTF-8"%>
<%@ include file="/commonInc/include/commonImport.jsp" %>
<%

	DataMap requestMap = (DataMap)request.getAttribute("PART_DATA");
	requestMap.setNullToInitialize(true);
	
	DataMap requestMap1 = (DataMap)request.getAttribute("REQUEST_DATA");
	String dept = (String)request.getAttribute("dept");
	requestMap1.setNullToInitialize(true);
	
	StringBuffer strHtml = new StringBuffer();
	strHtml.append("<th class=\"bl0\">부서명 <span class=\"txt_org\">*</span></th> \n");
	strHtml.append("<td> \n"); 
	strHtml.append("		<input type=\"text\" name=\"deptname\" class=\"input02 w193\" value=\""+requestMap1.getString("deptname")+"\" /> ");
	strHtml.append("		<select name=\"PART_DATA\" class=\"select01 w120\" onChange=\"getPart(this.options[this.selectedIndex].value,this.options[this.selectedIndex].text)\">\n");
	strHtml.append("			<option value = \"\" selected>--- 부서 선택 ---</option>\n");
	if(!"6289999".equals(dept)) {
 		if("6280000".equals((String)request.getAttribute("dept"))) {
			strHtml.append("						<option value = \"\" selected>인천시청실과명입력</option>\n");
		} else {
			strHtml.append("			<option value = \"\">직접입력</option>\n");
		}
	}
	if(requestMap.keySize("partcd") > 0){		
		for(int i=0; i < requestMap.keySize("partcd"); i++){
			strHtml.append("			<option value = \""+requestMap.getString("partcd",i)+"\" >"+requestMap.getString("partnm",i)+"</option>\n");
		}
	}
	strHtml.append("		</select>\n");
	strHtml.append("</td> \n ");
	out.println(strHtml.toString());
%>
