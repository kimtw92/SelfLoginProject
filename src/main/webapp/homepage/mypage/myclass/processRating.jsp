<%@ page language="java" contentType="text/html;" pageEncoding="UTF-8"%>
<%@ include file="/commonInc/include/commonImport.jsp" %>

<%
// date	: 2008-08-26
// auth 	: 최종삼
%>

<%
	DataMap requestMap = (DataMap)request.getAttribute("LIST_DATA");
	requestMap.setNullToInitialize(true);
	
	StringBuffer listHtml = new StringBuffer();
	
	// 각 진도율 확인하는 부분


	
	if(requestMap.keySize("itemTitle") > 0){		
		for(int i=0; i < requestMap.keySize("itemTitle"); i++){
		String strTime = "";
		int sco_time=Util.getIntValue(requestMap.getString("scoTime",i),0);
		
		int ihour=Math.round((sco_time%(60*60*24))/(60*60)*1);
		int imin=Math.round(((sco_time%(60*60*24))%(60*60))/(60)*1);
		int isec=Math.round((((sco_time%(60*60*24))%(60*60))%(60))/1);

		if(ihour > 9) 
			strTime += ihour + ":";
		else
			strTime += ihour + ":";
		
		if(imin > 9) 
			strTime += imin + ":";
		else
			strTime += "0"+imin + ":";
		
		if(isec > 9) 
			strTime += isec + "";
		else
			strTime += "0"+isec;
			
			listHtml.append("				<tr>\n")
				.append("							<td class=\"inSbj\">"+requestMap.getString("itemTitle",i)+"</td>\n")
				.append("							<td class=\"inNoBottom\">&nbsp;"+strTime+"&nbsp;</td>\n")
				.append("							<td class=\"inNo\">"+requestMap.getString("progressStatus",i)+"</td>\n")
				.append("						</tr>\n");
		}
	}
	listHtml.append("<tr>")
	.append(" <td class=\"inTail\" colspan=\"3\"></td>")
	.append("</tr>");
		
		

%>

<%= listHtml.toString()%>
