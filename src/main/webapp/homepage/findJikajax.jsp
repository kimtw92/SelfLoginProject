<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commonInc/include/commonImport.jsp" %>
<%
// date	: 2008-08-26
// auth 	: 양정환
%>
<%
	DataMap requestMap = (DataMap)request.getAttribute("ZIK_LIST");
	requestMap.setNullToInitialize(true);
	
	StringBuffer jikListHtml = new StringBuffer();

	if(requestMap.keySize("jik") > 0){
		jikListHtml.append(" <table class=\"dataH01\" style=\"width:372px;\"><colgroup><col width=\"\" /><col width=\"\" /><col width=\"\" /><col width=\"\" /><col width=\"\" /><col width=\"\" /><col width=\"\" /></colgroup>");
		jikListHtml.append("<thead><tr><th>번호</th><th>직급코드</th><th>직급명</th><!--<th>직종</th>--><th>직렬</th><th>직류</th><!--<th>계급</th --></tr></thead><tbody> ");
		
		for(int i=0; i < requestMap.keySize("jik"); i++){
			jikListHtml.append("<tr> ");
			jikListHtml.append(" <td>"+requestMap.getString("rownum", i)+"</td>");
			jikListHtml.append(" <td>"+requestMap.getString("jik", i)+"</td> ");
			jikListHtml.append(" <td class=\"sbj\"><a href=\"javascript:confirmJik('"+requestMap.getString("jiknm", i)+"','"+requestMap.getString("jik", i)+"');\">"+requestMap.getString("jiknm", i)+"</a></td> ");
			//jikListHtml.append(" <td>"+requestMap.getString("jikj", i)+"</td>");  //직종
			jikListHtml.append(" <td>"+requestMap.getString("jikr", i)+"</td>");  //직류
			jikListHtml.append(" <td>"+requestMap.getString("jikl", i)+"</td>");  //직렬
			//jikListHtml.append(" <td>"+requestMap.getString("dogs", i)+"</td>");  // 계급
			jikListHtml.append("</tr>");  // 계급

		}
		jikListHtml.append("</tbody>	</table> ");
		jikListHtml.append(" ");
	}else {
		jikListHtml.append("<br><br><br><center><font color=\"red\">검색 결과가 없습니다.</font></center>");
	}
	
	
%>
<%= jikListHtml.toString()%>