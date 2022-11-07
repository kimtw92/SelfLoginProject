<%@ page language="java" contentType="text/html;" pageEncoding="UTF-8"%>
<%@ include file="/commonInc/include/commonImport.jsp" %>

<%
// date	: 2008-08-26
// auth 	: 양정환
%>

<%
	DataMap requestMap = (DataMap)request.getAttribute("EDUCATION_MONTH_AJAX_LIST");
	requestMap.setNullToInitialize(true);

	// 페이징 필수
	FrontPageNavigation pageNavi = (FrontPageNavigation)requestMap.get("PAGE_INFO");
	int pageNum = pageNavi.getTotalCnt() - (requestMap.getInt("currPage") - 1) * requestMap.getInt("rowSize");	
	
	String pageStr = "";
	
	StringBuffer monthListHtml = new StringBuffer();

	if(requestMap.keySize("grcodeniknm") > 0){		
		for(int i=0; i < requestMap.keySize("grcodeniknm"); i++){
			
			if(!requestMap.getString("grcodeniknm", i).contains("test")){
				
			monthListHtml.append("<tr>");
			monthListHtml.append("<td class=\"bl0\">"+requestMap.getString("gubun", i)+"</td>");
			monthListHtml.append("<td><a href=javascript:popWin(\"/homepage/course.do?mode=courseinfopopup&grcode="+requestMap.getString("grcode", i)+"&grseq="+requestMap.getString("grseq", i)+"\",\"aaa\",\"603\",\"680\",\"yes\",\"yes\")>"+requestMap.getString("grcodeniknm", i)+"</a></td>");
			monthListHtml.append("<td>"+requestMap.getString("eapplyst", i)+"~"+requestMap.getString("eapplyed", i)+"</td>");
			monthListHtml.append("<td>"+requestMap.getString("started", i)+"~"+requestMap.getString("enddate", i)+"</td>");
			monthListHtml.append("<td>"+requestMap.getString("tseat", i)+"</td>");
			monthListHtml.append("<td>"+requestMap.getString("tdate", i)+"</td>");
			monthListHtml.append("<td><a href=javascript:popWin(\"/homepage/course.do?mode=courseinfopopup&grcode="+requestMap.getString("grcode", i)+"&grseq="+requestMap.getString("grseq", i)+"\",\"aaa\",\"603\",\"680\",\"yes\",\"yes\")><img src=\"/images/skin1/button/btn_deInfo.gif\" alt=\"상세정보\" /></a></td>");
			monthListHtml.append("</tr>");
			}
			
		}
		pageStr = pageNavi.FrontPageStr();
		monthListHtml.append("<tr>");
		monthListHtml.append("<td colspan=\"7\" class='sbj01'>");
		monthListHtml.append("<div id=\"changepaging\" class=\"paging\">");
		monthListHtml.append(pageStr.toString());
		monthListHtml.append("</div>");
		monthListHtml.append("</td>");
		monthListHtml.append("</tr>");	
	} else {
		monthListHtml.append("<tr>");
		monthListHtml.append("<td colspan=\"7\" class='sbj01' style='text-align:center;'>해당월은 과정이 없습니다.");
		monthListHtml.append("<div id=\"changepaging\" class=\"paging\">");
		monthListHtml.append("</div>");
		monthListHtml.append("</td>");
		monthListHtml.append("</tr>");	
	}

%>

<%= monthListHtml.toString()%>
