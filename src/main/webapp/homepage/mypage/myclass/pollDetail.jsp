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
<title>인천광역시인재개발원에 오신 것을 환영합니다.</title>
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
		
		List lstPoll = (List)listMap.get("answer", i);
				
		String strKind = "객관식";
		
		int totalCnt = 0;
		
		for(int x=0,y=lstPoll.size();x<y;x++){
			PollVO pollVO = (PollVO)lstPoll.get(x);
			if (x == 0 && pollVO.getAnswer_kind().equals("4")){
				strKind = "주관식";	
			}
			totalCnt += Util.getIntValue(pollVO.getTotalCnt(),0);
		}

		StringBuffer subHtml = new StringBuffer();
		StringBuffer subHtml01 = new StringBuffer();
		StringBuffer subHtml02 = new StringBuffer();
		
		if (strKind.equals("객관식")){
			subHtml.append("<td class=\"gr\" rowspan=\""+lstPoll.size()+"\" valign=\"bottom\">\n")
				.append("<table class=\"graph\">\n");
			
			subHtml01.append("<tr class=\"br\">\n");
			subHtml02.append("<tr class=\"bs\">\n");
			for(int x=0,y=lstPoll.size();x<y;x++){
				PollVO pollVO = (PollVO)lstPoll.get(x);
				int perCent = 0;
				if (totalCnt > 0 && pollVO.getTotalCnt() > 0){
// 					perCent = (pollVO.getTotalCnt()/totalCnt)*100;
					perCent = (pollVO.getTotalCnt()*100/totalCnt);
				}
				subHtml01.append("<td style=\"position:relative;\"><img style=\"position:absolute; bottom:0px;\" src=\"/images/"+skinDir+"/sub/bg_grbar.gif\" width=\"8\" height=\""+perCent+"%\" border=\"0\"></td>\n");
				subHtml02.append("<td class=\"bs\">"+pollVO.getAnswer_no()+"</td>");	
			}
			
			subHtml02.append("</tr>\n");
			subHtml01.append("</tr>\n");

			subHtml.append(subHtml01.toString());
			subHtml.append(subHtml02.toString());
			
			subHtml.append("</table>\n");
			subHtml.append("</td>\n");
		} else {
			
		}
	
		sbListHtml.append("<table class=\"dataW02\" style=\"width:500px;\">\n")	
			.append("<tbody>\n");
			
			if (listMap.getString("subjnm",i).length() > 0){
				titleName = listMap.getString("subjnm",i);
				sbListHtml.append("<tr><th class=\"bl0\" colspan=\"3\">"+listMap.getString("subjnm",i)+"</th></tr>\n");
			} 
		
			sbListHtml.append("<tr>\n")
			.append("<th class=\"bl0\" width=\"50\">질문"+(i+1)+"</th>\n")
			.append("<td>\n")
			.append(listMap.getString("question",i)+"\n")
			.append("</td>\n")
			.append("<td width=\"100\">"+strKind);
			if (strKind.equals("주관식")){
				sbListHtml.append("&nbsp;&nbsp;<a href=\"javascript:setView('"+listMap.getString("titleNo",i)+"','"+listMap.getString("setNo",i)+"','"+listMap.getString("questionNo",i)+"');\"><img src=\"/images/skin1/button/btn_view02.gif\" alt=\"변경\" align=\"absmiddle\" /></a>");
			}
			sbListHtml.append("</td>\n")
			.append("</tr>\n")
			.append("</tbody>\n")
			.append("</table>\n");
		
		if (strKind.equals("객관식")){
			sbListHtml.append("<table class=\"mini\" style=\"width:500px;\">\n")	
				.append("<tr>\n")
				.append("<th class=\"b10\" width=\"40\">문항</th>\n")
				.append("<th class=\"b10\">지문</th>\n")
				.append("<th class=\"b10\" width=\"50\">응답자수</th>\n")
				.append("<th class=\"ba\" colspan=\"2\">비율</th>\n")
				.append("</tr>\n");
		
		
			for(int x=0,y=lstPoll.size();x<y;x++){
				PollVO pollVO = (PollVO)lstPoll.get(x);
				int perCent = 0;
				if (totalCnt > 0 && pollVO.getTotalCnt() > 0){
					perCent = (pollVO.getTotalCnt()*100/totalCnt);
				}
				sbListHtml.append("<tr>\n");
				sbListHtml.append("<td class=\"bl0\">"+pollVO.getAnswer_no()+"</td>\n")
					.append("<td class=\"bl0\">"+pollVO.getAnswer()+"</td>\n")
					.append("<td class=\"bl0\">"+pollVO.getTotalCnt()+"</td>\n")
					.append("<td class=\"bl0\">"+perCent+"%</td>\n");
				if (x == 0){
					sbListHtml.append(subHtml.toString());
				}
				sbListHtml.append("</tr>\n");
			}
			sbListHtml.append("</table>\n");
		}			
		sbListHtml.append("<div class=\"space01\"></div>\n");
		sbListHtml.append("<div class=\"space01\"></div>\n");
		
	}
			
}else{
	
}
%>

</head>
<script language="javascript" type="text/javascript" >
<!--
	function setPoll(){
		pform.action = "/mypage/myclass.do?mode=pollExec";
		pform.submit();
	}

	function setView(title_no,set_no, question_no){
		window.open('/mypage/myclass.do?mode=juView&title_no='+title_no+'&set_no='+set_no+'&question_no='+question_no,'poll_view1','width=420,height=400,menubar=0,scrollbars=1');
	}
	
//-->
</script>
<!-- popup size 400x220 -->
<body>
<form id="pforam" name="pform" method="post">
<input type="hidden" name="title_no"  value="<%=requestMap.getString("title_no") %>">
<input type="hidden" name="set_no"  value="<%=requestMap.getString("set_no") %>">
<div class="top">
	<h1 class="h1"><%=titleName %></h1>
</div>
<div class="contents">

	<div class="h10"></div>

   <%=sbListHtml.toString() %>

	<!-- button -->
	<div class="btnC" style="width:500px;">
		<a href="javascript:window.close();"><img src="/images/<%=skinDir %>/button/btn_submit03.gif" alt="확인" /></a>		
	</div>	
	<!-- //button -->
</div>

</form>
</body>
</html>


	