<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="ut.lib.support.DataMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

List<Map> ansScoringList = (List<Map>) request.getAttribute("ansScoringList");

StringBuilder listStr = new StringBuilder();
int size = 0;

for(Map m : ansScoringList){
	listStr
		.append("<tr>")
		.append("	<td>")
		.append("		").append(m.get("USERNO"))
		.append("	</td>")
		.append("	<td>")
		.append("		").append(m.get("EDUNO"))
		.append("	</td>")
		.append("	<td>")
		.append("		").append(m.get("NAME"))
		.append("	</td>");
		
	size = (Integer) m.get("size");
	
	for(int i=1; i<=size; i++){
		listStr
			.append("	<td>")
			.append("		").append(m.get("문제"+i))
			.append("	</td>")
			;
	}
		
	listStr
		.append("</tr>")
	;
}

StringBuilder column = new StringBuilder();

for(int i=1; i<=size; i++){
	column
		.append("<th>")
		.append("	문제" + i)
		.append("</th>")
	;
}

%>
<table class="datah01">
	<thead>
	<tr>
		<th>USER ID</th>
		<th>교번</th>
		<th>이름</th>
		<%=column.toString() %>
	</tr>
	</thead>
	<tbody>
		<%=listStr.toString() %>
	</tbody>
</table>