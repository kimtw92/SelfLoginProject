<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/commonInc/include/commonImport.jsp" %>
<%
// date	: 2008-08-26
// auth 	: 양정환
%>
<%
	DataMap requestMap = (DataMap)request.getAttribute("EXIST_ID_VALUE");
	requestMap.setNullToInitialize(true);
	
	StringBuffer listHtml = new StringBuffer();

	if(requestMap.keySize("userId") > 0){
		listHtml.append("<link rel=\"stylesheet\" type=\"text/css\" href=\"/commonInc/css/skin1/popup.css\" />");
		listHtml.append("<div class=\"top\"><h1 class=\"h1\">아이디/패스워드 찾기</h1></div> ");
		listHtml.append("<div class=\"contents\"> ");
		listHtml.append("<div class=\"textSet01\" style=\"width:372px;\">주민번호를 입력하시면 기존의 아이디를 확인하실수 있습니다.	</div> ");
		listHtml.append("<div class=\"h10\"></div> ");
		listHtml.append("<div class=\"popBoxWrap\"> ");
		listHtml.append("<div class=\"drBoxTop\"> ");
		listHtml.append("<dl> ");
		listHtml.append("<dt>회원님의 아이디는 <strong>"+requestMap.getString("userId", 0)+"</strong> 입니다.</dt> ");
		listHtml.append("</dl> ");
		listHtml.append("<dl> ");
		listHtml.append("<dd> ");
		listHtml.append("<a href=\"/homepage/join.do?mode=findstep1\"><img src=\"/images/skin1/button/btn_pwserch.gif\" alt=\"패스워드 찾기\" /></a> ");
		listHtml.append("</dd> ");
		listHtml.append("</dl> ");
		listHtml.append("</div> ");
		listHtml.append("</div> ");
		listHtml.append("<div class=\"btnC\" style=\"width:372px;\"> ");
		listHtml.append("<a href=\"javascript:self.close();\"><img src=\"/images/skin1/button/btn_close01.gif\" alt=\"닫기\" /></a>	 ");	
		listHtml.append("</div>	 ");
		listHtml.append("</div>	 ");	
	}else {
		listHtml.append("<link rel=\"stylesheet\" type=\"text/css\" href=\"/commonInc/css/skin1/popup.css\" />");
		listHtml.append("<div class=\"top\"><h1 class=\"h1\">아이디/패스워드 찾기</h1></div> ");
		listHtml.append("<div class=\"contents\"> ");
		listHtml.append("<div class=\"textSet01\" style=\"width:372px;\">검색결과가 없습니다  </div>");
		listHtml.append("<div class=\"h10\"></div>");
		listHtml.append("<div class=\"btnC\" style=\"width:372px;\">");
		listHtml.append("<a href=\"/homepage/index.do?mode=existid\"><img src=\"/images/skin1/button/btn_research.gif\" alt=\"다시검색하기\" ></a>&nbsp;");
		listHtml.append("<a href=\"javascript:self.close();\"><img src=\"/images/skin1/button/btn_close01.gif\" alt=\"닫기\" /></a>");
		listHtml.append("</div>	");
	}
	
	
%>
<%= listHtml.toString()%>

