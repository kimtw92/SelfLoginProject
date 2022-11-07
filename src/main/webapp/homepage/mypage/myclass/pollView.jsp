<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="loti.mypage.model.PollVO" %>
<%
// prgnm 	: 설문
// date		: 2008-09-30
// auth 	: jong03
%>
<%@ include file="/commonInc/include/commonImport.jsp" %>
<%@ include file="/commonInc/include/comInclude.jsp" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>설문조사</title>
<link rel="stylesheet" type="text/css" href="/commonInc/css/skin1/popup.css" />

<%


// 필수, request 데이타
DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
requestMap.setNullToInitialize(true);


// 리스트
DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
listMap.setNullToInitialize(true);


StringBuffer sbListHtml = new StringBuffer();

String pageStr = "";
String titleName = "";
if(listMap.keySize("titleNo") > 0){		
	for(int i=0; i < listMap.keySize("titleNo"); i++){
		
		sbListHtml.append("<input type=\"hidden\" name=\"keyVal\" value=\"+i+\">");
		if (listMap.getString("subjnm",i).length() > 0){
			titleName = listMap.getString("subjnm",i);
			sbListHtml.append("<tr><th class=\"bl0\" colspan=\"2\">과목명:"+listMap.getString("subjnm",i)+"</th></tr>\n");
		} 
		
		sbListHtml.append("<tr>\n")
			.append("<th class=\"bl0\" width=\"50\">질문"+(i+1)+"</th>\n")
			.append("<td>\n")
			.append(listMap.getString("question",i)+"\n")
			.append("</td>\n")
			.append("</tr>\n");	
		
		sbListHtml.append("<tr>\n")
			.append("<td colspan=\"2\" class=\"sbj\">\n");
		
		List lstPoll = (List)listMap.get("answer", i);
		
		for(int x=0,y=lstPoll.size();x<y;x++){
			
			PollVO pollVO = (PollVO)lstPoll.get(x);
			if (i == 0){
				sbListHtml.append("<input type=\"hidden\" name=\"keyType\" value=\""+pollVO.getAnswer_kind()+"\" >\n");
			}
			
			if (pollVO.getAnswer_kind().equals("1")){
				sbListHtml.append("<input type=radio name=\"poll_"+i+"\" value=\""+pollVO.getAnswer_no()+"\" class=\"radio\"> "+pollVO.getAnswer()+"<br />\n");
			} else if (pollVO.getAnswer_kind().equals("2")){
				sbListHtml.append("<input type=radio name=\"poll_"+i+"\" value=\""+pollVO.getAnswer_no()+"\" class=\"radio\"> "+pollVO.getAnswer()+" <input type=\"text\" value=\"\" name=\""+pollVO.getAnswer()+"\" class=\"input01 w158\" /> <br />\n");
			} else if (pollVO.getAnswer_kind().equals("3")){
				sbListHtml.append("<input type=\"checkbox\" name=\"poll_"+i+"\" value=\""+pollVO.getAnswer_no()+"\" class=\"checkbox\"> "+pollVO.getAnswer()+" <br />");
			} else if (pollVO.getAnswer_kind().equals("4")){
				sbListHtml.append("<textarea name=\"poll_"+i+"_text\" style='width:90%;height:38' class=\"input01\" /></textarea>");
			}

		}
		sbListHtml.append("</td>\n")
			.append("</tr>\n");
	}
			
}else{
	sbListHtml.append("<tr>");
	sbListHtml.append("<td colspan=\"6\">등록된 토론이 없습니다!");
	sbListHtml.append(" </td>");
	sbListHtml.append("</tr>");
}
%>

</head>
<script language="javascript" type="text/javascript" >
<!--
	function setPoll(){
		pform.action = "/mypage/myclass.do?mode=pollExec";
		pform.submit();
	}
//-->
</script>
<!-- popup size 400x220 -->
<body>
<form id="pforam" name="pform" method="post">
<input type="text" name="title_no"  value="<%=requestMap.getString("title_no") %>">
<input type="text" name="set_no"  value="<%=requestMap.getString("set_no") %>">
<input type="text" name="question_no"  value="<%=requestMap.getString("question_no") %>">
<div class="top">
	<h1 class="h1"><%=titleName %></h1>
</div>
<div class="contents">

	<div class="h10"></div>
	
    <table class="dataW02" style="width:370px;">	
	<colgroup>
		<col width="" />
		<col width="" />
	</colgroup>
	<tbody>
	<%=sbListHtml.toString() %>
    </tbody>
	</table>	

	<!-- button -->
	<div class="btnC" style="width:375px;">
		<a href="javascript:setPoll();"><img src="/images/<%=skinDir %>/button/btn_submit03.gif" alt="확인" /></a>		
	</div>	
	<!-- //button -->
</div>

</form>
</body>
</html>


	