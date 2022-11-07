<%@page import="ut.lib.support.DataMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

DataMap ansList = (DataMap) request.getAttribute("ansList");
ansList.setNullToInitialize(true);

StringBuilder listStr = new StringBuilder();

for(int i=0; i<ansList.keySize("userno"); i++){
	listStr
		.append("<tr>");
	if("ansAjax".equals(request.getParameter("mode"))){
		listStr
			.append("	<td>")
			.append("		").append("<input class='checkboxUserNo' name='userno' type='checkbox' value='").append(ansList.getString("userno",i)).append("'/>")
			.append("	</td>");
	}
	listStr
		.append("	<td>")
		.append("		").append(ansList.getString("userno",i))
		.append("	</td>")
		.append("	<td>")
		.append("		").append(ansList.getString("eduno",i))
		.append("	</td>")
		.append("	<td>")
		.append("		").append(ansList.getString("name",i))
		.append("	</td>")
		.append("	<td>")
		.append("		").append(ansList.getString("paperType",i))
		.append("	</td>")
		.append("	<td>")
		.append("		").append("".equals(ansList.getString("answers",i)) ? "미응시" : "Y".equals(ansList.getString("ynEnd",i)) ? "완료" : "미완료")
		.append("	</td>")
		.append("	<td>")
		.append("		").append(ansList.getString("score",i))
		.append("	</td>")
// 		.append("	<td>")
// 		.append("		").append(ansList.getString("idExam",i))
// 		.append("	</td>")
		.append("</tr>")
	;
}

%>
<table class="datah01">
	<thead>
	<tr>
		<%//
			if("ansAjax".equals(request.getParameter("mode"))){
		%>
		<th><input type="checkbox" onclick="selectAll(this); "></th>
		<%} %>
		<th>USER ID</th>
		<th>교번</th>
		<th>이름</th>
		<th>시험지</th>
		<th>응시상태</th>
		<th>득점</th>
<!-- 		<th>시험id</th> -->
	</tr>
	</thead>
	<tbody>
		<%=listStr.toString() %>
	</tbody>
</table>