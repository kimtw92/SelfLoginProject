<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%!
	public String createAnsRadioButtons(String name, String ans, boolean disable){

		String disabled = disable ? "disabled=\"disabled\"" : "";
	
		StringBuilder sb = new StringBuilder();
		
		String checked = null;
		for(int i=1; i<=4; i++){
			checked = String.valueOf(i).equals(ans) ? "checked=\"checked\"" : "";
			sb
				.append("<label><input name=\"").append(name).append("\" type=\"radio\" value=\"").append(i).append("\" ")
				.append(disabled).append(" ").append(checked).append(" >")
				.append(i).append("</label>");
		}
		
		return sb.toString();
	}
%>
<%
//필수, request 데이타
DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
requestMap.setNullToInitialize(true);

List<Map> answers = (List) request.getAttribute("answers");

StringBuilder anses = new StringBuilder();
anses.append("<table class='datah01'><tr><th>No</th><th>정답</th><th>교육생</th></tr>");
for(Map m : answers){
	anses
		.append("<tr>")
		.append("<th>")
		.append(m.get("NR_Q"))
		.append("</th>")
		.append("<td>")
		.append(createAnsRadioButtons("Mark_CA_"+m.get("NR_Q"), String.valueOf(m.get("CA")), true))
		.append("</td>")
		.append("<td>")
		.append(createAnsRadioButtons("Mark_ANS_"+m.get("NR_Q"), String.valueOf(m.get("answer")), false))
		.append("</td>")
// 		.append("<td>")
// 		.append(m.get("ca").equals(m.get("answer")) ? "O" : "X")
// 		.append("</td>")
// 		.append("<td>")
// 		.append(m.get("qtype"))
// 		.append("</td>")
// 		.append("<td>")
// 		.append(m.get("idQ"))
// 		.append("</td>")
// 		.append("<td>")
// 		.append("1,2,3,4")
// 		.append("</td>")
// 		.append("<td>")
// 		.append(m.get("allotting"))
// 		.append("</td>")
		.append("</tr>")
		;
}
anses.append("</table>");

StringBuilder sb = new StringBuilder();
	sb
		.append("<table class='datah01'>");
for(Map m : answers){
	sb
		.append("<tr>")
		.append("<th width='50px'>문제 ").append(m.get("NR_Q"))
		.append("</th>")
		.append("<td colspan=\"3\" style=\"text-align:left; padding-left:20px;\">").append(m.get("Q"))
		.append("</td>")
		.append("</tr>")
		.append("<tr>")
		.append("<th>보기")
		.append("</th>")
		.append("<td colspan=\"3\" style=\"text-align:left; padding-left:20px;\">①").append(m.get("EX1")).append("<br>")
		.append("②").append(m.get("EX2")).append("<br>")
		.append("③").append(m.get("EX3")).append("<br>")
		.append("④").append(m.get("EX4"))
		.append("</td>")
		.append("</tr>")
		.append("<tr>")
		.append("<th>정답")
		.append("</th>")
		.append("<td width='50px'>").append(m.get("CA"))
		.append("</td>")
		.append("<th width='100px'>학습자 선택답")
		.append("</th>")
		.append("<td>").append(createAnsRadioButtons("ANS_"+m.get("NR_Q"), String.valueOf(m.get("answer")), true))
		.append("</td>")
		.append("</tr>")
		.append("<tr>")
		.append("<td height='15' colspan='4'>")
		.append("</td>")
		.append("</tr>");
}
	sb.append("</table><br>");
	
	int min = 'A'-1;
	int nrSet = requestMap.getInt("nrSet");
	char nrSetCh = (char)(min+nrSet);
%>
<!-- [s] commonImport -->
<%@ include file="/commonInc/include/commonImport.jsp" %>
<!-- [e] commonImport -->
<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->
<body>
	<br>
	<h3 align="center"><%=request.getParameter("subjnm") %> <%=nrSetCh %></h3>
	<p>
		<h5 align="right"><%=request.getParameter("userName")%>님 - Mark</h5>
	</p>
<!-- 	<table> -->
<!-- 		<tr> -->
<!-- 			<th>번호</th> -->
<!-- 			<th>정답</th> -->
<!-- 			<th>답안</th> -->
<!-- 			<th>OX</th> -->
<!-- 			<th>문제유형</th> -->
<!-- 			<th>문제코드</th> -->
<!-- 			<th>보기배열</th> -->
<!-- 			<th>배점</th> -->
<!-- 		</tr> -->
<%-- 		<%=sb.toString() %> --%>
<!-- 	</table> -->
<div>
	<div style="display: inline; height: 500px; width: 800px; overflow: auto;"><%=sb.toString() %></div>
	<div style="display: inline; height: 500px; width: 300px; overflow: auto;">
		<div align="right">
			<input type="button" class="boardbtn1" value="답안수정(재채점)" onclick="scoringAns()">
			<input type="button" class="boardbtn1" value="초기화" onclick="deleteAns()">
			<input type="button" class="boardbtn1" value="닫기" onclick="window.close();">
		</div>
		<div id="div-ansPane">
			<form name="pform" action="/courseMgr/offScoring.do" method="post" >
				<input name="mode" value="updateAns" type="hidden">
				<input name="grcode" value="<%=request.getParameter("grcode")%>" type="hidden">
				<input name="grseq" value="<%=request.getParameter("grseq")%>" type="hidden">
				<input name="subj" value="<%=request.getParameter("subj")%>" type="hidden">
				<input name="idExam" value="<%=request.getParameter("idExam")%>" type="hidden">
				<input name="userno" value="<%=request.getParameter("userno")%>" type="hidden">
				<input name="userName" value="<%=request.getParameter("userName")%>" type="hidden">
				<%=anses.toString() %>
			</form>
		</div>
		<div align="right">
			<input type="button" class="boardbtn1" value="답안수정(재채점)" onclick="scoringAns()">
			<input type="button" class="boardbtn1" value="초기화" onclick="deleteAns()">
			<input type="button" class="boardbtn1" value="닫기" onclick="window.close();">
		</div>
	</div>
</div>
<script type="text/javascript">
	userName = "<%=request.getParameter("userName")%>";
	function scoringAns(){
		if(!confirm(userName + "님의 답안 정보를 수정/재채점 하시겠습니까?")){
			return;
		}
		pform.submit();
	}
	
	function deleteAns(){
		if(!confirm(userName + "님의 답안 정보를 초기화 하시겠습니까?")){
			return;
		}
		pform.mode.value="deleteOneAns";
		pform.submit();
	}
	
</script>
</body>
