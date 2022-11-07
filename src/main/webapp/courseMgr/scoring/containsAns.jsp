<%@page import="java.util.List"%>
<%@page import="ut.lib.support.DataMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

DataMap requestMap = (DataMap) request.getAttribute("REQUEST_DATA");

List<String> usernos = (List) request.getAttribute("usernos");

StringBuilder sb = new StringBuilder("[");

for(int i=0; i<usernos.size(); i++){
	if(i!=0){
		sb.append(",");
	}
	sb
		.append("\"")
		.append(usernos.get(i))
		.append("\"");
}
sb.append("]");

%><%=sb.toString()%>