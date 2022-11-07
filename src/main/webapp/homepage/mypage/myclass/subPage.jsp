<%@ page language="java" contentType="text/html;" pageEncoding="UTF-8"%>
<%@ include file="/commonInc/include/commonImport.jsp" %>
<%
	DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
	requestMap.setNullToInitialize(true);
	
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	listMap.setNullToInitialize(true);
	
	StringBuffer strHtml = new StringBuffer();
	
	if (requestMap.getString("kind").equals("notice")){
		
		strHtml.append("<div class=\"tab03\">\n")
			.append("	<ul>\n")
			.append("		<li><img src=\"../../../images/skin1/sub/myTab1_on.gif\" alt=\"공지사항\" /></li>\n")
			.append("		<li><a href=\"javascript:setNoitce('quest');\"><img src=\"../../../images/skin1/sub/myTab3.gif\" alt=\"나의질문\" /></a></li>\n")
			.append("		<li></li>\n")
			.append("	</ul>\n")
			.append("</div>\n")
			.append("<div class=\"space01\"></div>\n")
			.append("	<ul class=\"newsList\">\n");
		
		if(listMap.keySize("seq") > 0){		
			for(int i=0; i < listMap.keySize("seq"); i++){
				String threeDot = "";
				if(listMap.getString("seq",i).length()>18 ){
					threeDot = "...";
				}
					
				strHtml.append("		<li>\n")
				.append("			<span><a href=\"javascript:goNoView('"+listMap.getString("seq",i)+"');\">"+listMap.getString("title",i).substring(0,19)+threeDot+"</a></span>\n")
				.append("			<span class=\"date\">"+listMap.getString("regdate",i)+"</span>\n")
				.append("		</li>\n");
				if (i > 3) break;
			}
		}else {
			
			strHtml.append("		<li>\n")
			.append("			<span></span>\n")
			.append("			<span class=\"date\"></span>\n")
			.append("		</li>\n")
			.append("		<li>\n")
			.append("			<span></span>\n")
			.append("			<span class=\"date\"></span>\n")
			.append("		</li>\n")
			.append("		<li>\n")
			.append("			<span></span>\n")
			.append("			<span class=\"date\"></span>\n")
			.append("		</li>\n")
			.append("		<li>\n")
			.append("			<span></span>\n")
			.append("			<span class=\"date\"></span>\n")
			.append("		</li>\n")
			.append("		<li>\n")
			.append("			<span></span>\n")
			.append("			<span class=\"date\"></span>\n")
			.append("		</li>\n");
		}
			
		strHtml.append("<div class=\"space01\"></div>\n")
			.append("<div class=\"bgTail\"></div>\n");
	} else {
		strHtml.append("<div class=\"tab03\">\n")
		.append("	<ul>\n")
		.append("		<li><a href=\"javascript:setNoitce('notice');\"><img src=\"../../../images/skin1/sub/myTab1.gif\" alt=\"공지사항\" /></a></li>\n")
		.append("		<li><img src=\"../../../images/skin1/sub/myTab3_on.gif\" alt=\"나의질문\" /></li>\n")
		.append("		<li></li>\n")
		.append("	</ul>\n")
		.append("</div>\n")
		.append("<div class=\"space01\"></div>\n")
		.append("	<ul class=\"newsList\">\n");
	
		if(listMap.keySize("grcode") > 0){
			int count = 0;
			
			for(int i=0; i < listMap.keySize("grcode"); i++){
				strHtml.append("		<li>\n")
				.append("			<span><a href=\"javascript:goQuView('"+listMap.getString("grcode",i)+"','"+listMap.getString("grseq",i)+"','"+listMap.getString("puresubj",i)+"','"+listMap.getString("classno")+",'"+listMap.getString("no",i)+"');\">"+listMap.getString("title",i)+"</a></span>\n")
				.append("			<span class=\"date\">"+listMap.getString("regdate",i)+"</span>\n")
				.append("		</li>\n");
				count = i;
				if (i > 3) break;
			}
			
			for(int j=0 ; j < 4-count ; j++) {
				strHtml.append("		<li>\n")
				.append("			<span></span>\n")
				.append("			<span class=\"date\"></span>\n")
				.append("		</li>\n");				
			}
			
		} else {
			
			strHtml.append("		<li>\n")
			.append("			<span></span>\n")
			.append("			<span class=\"date\"></span>\n")
			.append("		</li>\n")
			.append("		<li>\n")
			.append("			<span></span>\n")
			.append("			<span class=\"date\"></span>\n")
			.append("		</li>\n")
			.append("		<li>\n")
			.append("			<span></span>\n")
			.append("			<span class=\"date\"></span>\n")
			.append("		</li>\n")
			.append("		<li>\n")
			.append("			<span></span>\n")
			.append("			<span class=\"date\"></span>\n")
			.append("		</li>\n")
			.append("		<li>\n")
			.append("			<span></span>\n")
			.append("			<span class=\"date\"></span>\n")
			.append("		</li>\n");
		}
		strHtml.append("<div class=\"space01\"></div>\n")
		.append("<div class=\"bgTail\"></div>\n");
	}
	
	out.println(strHtml.toString());
%>


