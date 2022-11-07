<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 각종 통계 상단 Tab
// date  : 2008-07-22
// auth  : kang
%>

<!-- [s] commonImport -->
<%@ include file="/commonInc/include/commonImport.jsp" %>
<!-- [e] commonImport -->

<%

	// 각 페이지 구분
	String tabIndex = request.getParameter("tabIndex");

	String[] aryClass = new String[15];
	for(int i=0; i < aryClass.length; i++){
		if(tabIndex.equals( String.valueOf(i) )){
			aryClass[i] = "class=\"on\"";
		}else{
			aryClass[i] = "";	
		}		
	}
	
	StringBuffer sbTabHtml = new StringBuffer();
	
	// 상단 tab 리스트
	DataMap tabMap = (DataMap)request.getAttribute("TABMENU_DATA");
	if(tabMap == null) tabMap = new DataMap();
	tabMap.setNullToInitialize(true);
	
	String url = "";
	
	if(tabMap.keySize("menuId") > 0){		
		for(int i=0; i < tabMap.keySize("menuId"); i++){
			if(tabMap.getString("menuName", i).indexOf("모바일") != -1) {
                continue;
            }
			url = tabMap.getString("menuUrl", i) + "&menuId=" + tabMap.getString("menuId", i);
			
			// 한 줄에 5개씩 나와야 함
			if(i==0){
				sbTabHtml.append("<ul class=\"hl03\">");			
			}
			
			sbTabHtml.append("<li><a href=\"javascript:fnTab('" + url + "');\" " + aryClass[i] + " >" + tabMap.getString("menuName", i) + "</a></li>");			
			sbTabHtml.append("<li class=\"hline\"></li>");
						
			if(i==4 || i==9){
				sbTabHtml.append("</ul>");
				sbTabHtml.append("<ul class=\"hl03\">");
			}else if(i==14){
				sbTabHtml.append("</ul>");
			}			
		}
	}
	
%>

<script language="JavaScript">
<!--
function fnTab(url){
	location.href=url;
}
//-->
</script>

<table class="tab01">
	<tr>
		<td class="bg01">
			<%= sbTabHtml.toString() %>			
		</td>
	</tr>
</table>
