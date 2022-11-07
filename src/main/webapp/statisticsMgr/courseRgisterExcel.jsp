<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 사이버교육통계  엑셀
// date  : 2008-08-05
// auth  : kang
%>

<!-- [s] commonImport -->
<%@ include file="/commonInc/include/commonImport.jsp" %>
<!-- [e] commonImport -->

<%

  //request 데이터
	DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
	requestMap.setNullToInitialize(true);

	// 필수 코딩 내용 //////////////////////////////////////////////////////////////////////
	//로그인된 사용자 정보
	LoginInfo memberInfo = (LoginInfo)request.getAttribute("LOGIN_INFO");
	
    //navigation 데이터
	DataMap navigationMap = (DataMap)request.getAttribute("NAVIGATION_DATA");
	navigationMap.setNullToInitialize(true);
	
	// 상단 navigation
	LoginCheck loginChk = new LoginCheck();
	String navigationStr = loginChk.NavigationCreate(memberInfo, navigationMap);
	////////////////////////////////////////////////////////////////////////////////////
	
	String rgrayn = Util.getValue(requestMap.getString("rgrayn"),"");
	String grseq = Util.getValue(requestMap.getString("grseq"),"");
	
	
	String bgColor = "";
	
	StringBuffer sbListHtml = new StringBuffer();
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	DataMap listMapTotal = (DataMap)request.getAttribute("LIST_DATA_TOTAL");
	

	if(listMap == null) listMap = new DataMap();
	listMap.setNullToInitialize(true);

	if(listMapTotal == null) listMapTotal = new DataMap();
	listMapTotal.setNullToInitialize(true);
	

	if(listMap.keySize("grcode") > 0){		
		sbListHtml.append("<tr bgcolor='#122cc1'>");		
		sbListHtml.append("	<td style=\"text-align:center\">&nbsp;<b>" + listMapTotal.getString("grcodeCnt", 0) + "개 과정 </b></td>");
		sbListHtml.append("	<td><b>"+listMapTotal.getString("manResucntCnt", 0)+"</b></td>");
		sbListHtml.append("	<td><b>"+listMapTotal.getString("woResucntCnt", 0)+"</b></td>");
		sbListHtml.append("	<td colspan=\"2\" class=\"br0\" style=\"text-align:center\"><b>"+listMapTotal.getString("totalCnt", 0)+"</b></td>");
		sbListHtml.append("</tr>");		

		for(int i=0; i < listMap.keySize("grcode"); i++){
			
			
			// tr 배경색
			if(i%2==0){
				bgColor = "bgcolor=\"#c3cccc\"";			
			}else{
				bgColor = "";
			}
			
			sbListHtml.append("<tr " + bgColor + " >");
			
			sbListHtml.append("	<td style=\"text-align: left\">&nbsp;" + listMap.getString("grcodeniknm", i) + "</td>");	

			sbListHtml.append("	<td>" + listMap.getString("manResucnt", i) + "</td>");
			sbListHtml.append("	<td>" + listMap.getString("woResucnt", i) + "</td>");
			sbListHtml.append("	<td colspan=\"2\" class=\"br0\" style=\"text-align:center\">"+listMap.getString("totno", i)+"</td>");

			sbListHtml.append("</tr>");												
		}
	}
	
	

	String toToYear = "과정별등록현황_" + requestMap.getString("grseq");
	// String excel_filename = new String(	toToYear.getBytes(), "ISO-8859-1");
WebUtils.setFileHeader(request, response, toToYear+".xls", "UTF-8", "UTF-8");
	response.setHeader("Content-Description", "JSP Generated Data"); 
	response.setContentType( "application/vnd.ms-excel" );
	request.setCharacterEncoding("UTF-8");
	
%>
<meta http-equiv="Content-Type" content="application/vnd.ms-excel; charset=UTF-8">
	기수정보 : <%=grseq%> , 수료 포함 여부 : [<%= !"Y".equals(rgrayn) ? "N".equals(rgrayn) ? "미수료자":"전체" : "수료자"  %>]
	<table class="datah01" border="1" cellpadding="0" cellspacing="0" >
		<tr>
			<th rowspan="2" width="600">과정명</th>
			<th colspan="2" width="300">성별</th>
			<th colspan="2" width="300">합계</th>
		</tr>
		<tr>
			<th>남</th>
			<th>여</th>
			<th colspan="2">남여합</th>
		</tr>
		<%= sbListHtml.toString() %>                            
	</table>



