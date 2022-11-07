
<%@ page language="java" contentType="text/html;" pageEncoding="UTF-8"%>
<%@ include file="/commonInc/include/commonImport.jsp" %>
<%

	DataMap requestMap = (DataMap)request.getAttribute("PART_DATA");
	requestMap.setNullToInitialize(true);
	
	DataMap requestMap1 = (DataMap)request.getAttribute("REQUEST_DATA");
	String dept = (String)request.getAttribute("dept");
	String deptsub = (String)request.getAttribute("deptsub");

	requestMap1.setNullToInitialize(true);
	
	StringBuffer strHtml = new StringBuffer();
	strHtml.append("<div> <label>부서명 \n");
	

	if(deptsub == null || "".equals(deptsub)) { 
		strHtml.append("		<input type=\"text\" id=\"DEPTSUB\" name=\"DEPTSUB\" class=\"infor_ul_in2\" value=\""+requestMap1.getString("deptname")+"\" /> ");
	} else {
		strHtml.append("		<input type=\"text\" id=\"DEPTSUB\" name=\"DEPTSUB\" class=\"infor_ul_in2\" value=\""+deptsub+"\" /> ");
	}
	strHtml.append("		<select id= \"PART_DATA\" name=\"PART_DATA\" class=\"infor_ul_sel2\" onChange=\"getPart(this.options[this.selectedIndex].value,this.options[this.selectedIndex].text)\">\n");
	//strHtml.append("			<option value = \"\" selected>--- 부서 선택 ---</option>\n");
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
	strHtml.append("</div> \n ");
	out.println(strHtml.toString());
%>
