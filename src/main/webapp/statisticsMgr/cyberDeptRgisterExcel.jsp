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
	
	String rgrayn = Util.getValue(requestMap.getString("rgrayn"),"N");
	String grseq = Util.getValue(requestMap.getString("grseq"),"");
	
	
	String bgColor = "";
	
	StringBuffer sbListHtml = new StringBuffer();
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	DataMap listMapTotal = (DataMap)request.getAttribute("LIST_DATA_TOTAL");
	

	if(listMap == null) listMap = new DataMap();
	listMap.setNullToInitialize(true);

	if(listMapTotal == null) listMapTotal = new DataMap();
	listMapTotal.setNullToInitialize(true);
	

	if(listMap.keySize("rdept") > 0){		
		sbListHtml.append("<tr bgcolor='#122cc1'>");		
		sbListHtml.append("	<td style=\"text-align:center\">&nbsp;<b>" + listMapTotal.getString("deptCnt", 0) + "개 기관 </b></td>");
		sbListHtml.append("	<td><b>"+listMapTotal.getString("totalCnt", 0)+"</b></td>");
		sbListHtml.append("	<td class=\"br0\"></td>");
		sbListHtml.append("</tr>");		

		for(int i=0; i < listMap.keySize("rdept"); i++){
			
			
			// tr 배경색
			if(i%2==0){
				bgColor = "bgcolor=\"#c3cccc\"";			
			}else{
				bgColor = "";
			}
			
			sbListHtml.append("<tr " + bgColor + " >");
			sbListHtml.append("	<td style=\"text-align: left\">&nbsp;" + listMap.getString("lownm", i) + "</td>");	
			sbListHtml.append("	<td>" + listMap.getString("totno", i) + "</td>");
			sbListHtml.append("	<td class=\"br0\"></td>");

			sbListHtml.append("</tr>");												
		}
	}
	

	String toToYear = "사이버 기관별 등록현황 " + requestMap.getString("grseq");
	// String excel_filename = new String(	toToYear.getBytes(), "ISO-8859-1");
WebUtils.setFileHeader(request, response, toToYear+".xls", "UTF-8", "UTF-8");
	response.setHeader("Content-Description", "JSP Generated Data"); 
	response.setContentType( "application/vnd.ms-excel" );
	request.setCharacterEncoding("UTF-8");
	
%>
<meta http-equiv="Content-Type" content="application/vnd.ms-excel; charset=UTF-8">
	기수정보 : <%=grseq%> , 수료 포함 여부 : [<%= "N".equals(rgrayn) ? "전체" : "수료자만"  %>]
	<table class="datah01" border="1" cellpadding="0" cellspacing="0" >
		<tr>
			<th width="600">기 관 명</th>
			<th width="300"><%=grseq.substring(4)%>기 등록인원</th>
			<th width="300">비 고</th>
		</tr>
		<%= sbListHtml.toString() %>                            
	</table>



