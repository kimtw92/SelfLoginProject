<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commonInc/include/commonImport.jsp" %>
<%
// date	: 2008-08-26
// auth 	: 양정환
%>
<%
	DataMap requestMap = (DataMap)request.getAttribute("ZIPCODE_LIST");
	requestMap.setNullToInitialize(true);
	
	StringBuffer zipcodeListHtml = new StringBuffer();

	if(requestMap.keySize("seq") > 0){
		zipcodeListHtml.append("<br><center><form method=\"post\" name=\"addrForm\"><input type=\"hidden\" name=\"mode\" value=\"detailaddr\"><select name=\"selAddr\">");
		for(int i=0; i < requestMap.keySize("seq"); i++){
			
			zipcodeListHtml.append("<option ");
			zipcodeListHtml.append("value=\"" +requestMap.getString("zipcode1", i)+requestMap.getString("zipcode2", i)+ requestMap.getString("addr1",i)+ " " +requestMap.getString("addr2",i)+ " " + requestMap.getString("addr3",i)+ " " + requestMap.getString("addr4",i));
			zipcodeListHtml.append("\">");
			zipcodeListHtml.append("["+requestMap.getString("zipcode1", i)+"-"+requestMap.getString("zipcode2", i)+"] " + requestMap.getString("addr1",i)+ " " +requestMap.getString("addr2",i)+ " " + requestMap.getString("addr3",i)+ " " + requestMap.getString("addr4",i)+ " " + requestMap.getString("addr5",i));
			zipcodeListHtml.append("</option>");
			
		}
		zipcodeListHtml.append("</select></form></center>");
		zipcodeListHtml.append("<br><center>다음 주소를 사용하시겠습니까?<br><br>");
		zipcodeListHtml.append("<img src=\"/images/skin1/button/btn_submit02.gif\" onClick=\"detailaddressajax()\"></center>");
	}else {
		zipcodeListHtml.append("<br><br><br><center><font color=\"red\">검색 결과가 없습니다.</font></center>");
	}
	
	
%>
<%= zipcodeListHtml.toString()%>