<%@page import="ut.lib.support.DataMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

DataMap requestMap = (DataMap) request.getAttribute("REQUEST_DATA");

int stuCnt = (Integer) request.getAttribute("stuCnt");

%>

<script type="text/javascript">

var cnt = <%=stuCnt%>;
switch (cnt) {
case -1:
	alert("업로드된 답안 일부 또는 전체 교번이 일치하는 교육생이 존재하지 않습니다.");
	break;

default:
	alert("<%=stuCnt%>명의 답안지를 업로드 하였습니다.");
	break;
}

var grcode = parent.document.form1.grcode.value;
var grseq = parent.document.form1.grseq.value;
var subj = parent.document.form1.subj.value;
var idExam = parent.getRadioValue(parent.document.form1.idExam);

parent.getAns(grcode, grseq, subj, '', idExam, 2);


</script>