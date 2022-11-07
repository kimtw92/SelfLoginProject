<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%  
// prgnm : 학적부관리 excel 다운로드
// date : 2010-10-19
// auth : woni82
%>

<!-- [s] commonImport -->
<%@ include file="/commonInc/include/commonImport.jsp" %>
<!-- [e] commonImport -->

<%
    //request 데이터
	DataMap requestMap = null; 
	requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
	requestMap.setNullToInitialize(true);

	// 필수 코딩 내용 //////////////////////////////////////////////////////////////////////
	//로그인된 사용자 정보
	LoginInfo memberInfo = null; 
	memberInfo = (LoginInfo)request.getAttribute("LOGIN_INFO");
	
    //navigation 데이터
	DataMap navigationMap = null;
	navigationMap = (DataMap)request.getAttribute("NAVIGATION_DATA");
	navigationMap.setNullToInitialize(true);
	
	// 상단 navigation
	LoginCheck loginChk = null; 
	loginChk = new LoginCheck();
	String navigationStr = loginChk.NavigationCreate(memberInfo, navigationMap);
	////////////////////////////////////////////////////////////////////////////////////

    //기관조회 리스트
	//DataMap deptListMap = (DataMap)request.getAttribute("DEPT_LIST_DATA");
	//deptListMap.setNullToInitialize(true);

    //학적부 조회 리스트
	DataMap listMap = null; 
	listMap = (DataMap)request.getAttribute("LIST_DATA");
	listMap.setNullToInitialize(true);

	StringBuffer html =  new StringBuffer();
	//html.append("	<table width=\"100%\" border=\"0\" height=\"\" cellspacing=\"0\" cellpadding=\"0\">");
	//html.append("		<tr>");
	//html.append("			<td align=\"center\" colspan=\"11\">");
	//html.append("				학적부 ");
	//html.append("			</td>");
	//html.append("		</tr>");
	//html.append("	</table>");
	html.append("	<table width=\"100%\" border=\"0\" height=\"\" cellspacing=\"0\" cellpadding=\"0\">");
	html.append("		<tr>");
	html.append("			<td>");
	//html.append("				<table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">	");
	//html.append("							<tr bgcolor=\"#5071B4\" height=\"2\"><td></td></tr>	");
	//html.append("				</table>	");	
		
		//리스트 출력
		html.append("			<table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">");
		//html.append("				<tr bgcolor=\"#5071B4\" height=\"2\"><td colspan=\"100%\"></td></tr>");
		//html.append("				<tr><td height=30></td></tr>");
		html.append("				<tr> ");
		html.append("					<td colspan=\"3\">");
		html.append("						<table width=\"100%\" border=\"1\" cellpadding=\"0\" cellspacing=\"0\" bgcolor=\"E5E5E5\">");
		html.append("							<tr bgcolor=\"375694\"> ");
		html.append("								<td height=\"2\" colspan=\"11\"></td>");
		html.append("							</tr>");
		html.append("							<tr>");
		html.append("								<td align=\"center\" colspan=\"11\">");
		html.append("									<font size=\"5\"><strong>학적부</strong></font> ");
		html.append("								</td>");
		html.append("							</tr>");
		html.append("							<tr bgcolor=\"#5071B4\"> ");
		html.append("								<td align=\"center\" height=28 width=50><div align=\"center\"><strong>성명</strong></td>");
				html.append("								<td align=\"center\" width=80><div align=\"center\"><strong>성별</strong></td>");
		html.append("								<td align=\"center\" width=80><div align=\"center\"><strong>생년월일</strong></td>");
		html.append("								<td align=\"center\"><div align=\"center\"><strong>직급</strong></td>");
		html.append("								<td align=\"center\"><div align=\"center\"><strong>기관</strong></td>");
		html.append("								<td align=\"center\"><div align=\"center\"><strong>부서</strong></td>");
		html.append("								<td align=\"center\"><div align=\"center\"><strong>과정명(기수)</strong></td>");
		html.append("								<td align=\"center\"><div align=\"center\"><strong>시작일</strong></td>");
		html.append("								<td align=\"center\"><div align=\"center\"><strong>종료일</strong></td>");		
		if(!requestMap.getString("sessClass").equals("3")){	
			html.append("							<td align=\"center\" width=20><strong>석차</strong></td>");
		}
		html.append("								<td align=\"center\"><div align=\"center\"><strong>총점</strong></td>");
		html.append("								<td align=\"center\"><div align=\"center\"><strong>수료여부</strong></td>");
		html.append("							</tr>");
		
		if(listMap.keySize("rname") > 0){
			for(int i=0; listMap.keySize("rname")>i;i++){
				html.append("					<tr bgcolor=\"#FFFFFF\">");                                                         
				html.append("						<td height=28><div align=\"center\">"+(listMap.getString("rname",i).equals("") ? "&nbsp;" : listMap.getString("rname",i)) +"</td>");
				html.append("				<td><div align=\"center\">"+listMap.getString("sex",i)+"</td>");            
				if(!listMap.getString("birthdate",i).equals("")){
					try{
						html.append("				<td><div align=\"center\">"+listMap.getString("birthdate",i)+"</td>");
					}catch(Exception e){
						html.append("				<td><div align=\"center\">에러</td>");
					}				
				}else{
					html.append("					<td><div align=\"center\">&nbsp;</td>");
				}
				html.append("						<td><div align=\"center\">"+(listMap.getString("rjiknm",i).equals("") ? "&nbsp;" : listMap.getString("rjiknm",i))+"</td>");                     
				html.append("						<td><div align=\"center\">"+(listMap.getString("rdeptnm",i).equals("") ? "&nbsp;" : listMap.getString("rdeptnm",i))+"</td>");                     
				html.append("						<td><div align=\"center\">"+(listMap.getString("rdeptsub",i).equals("") ? "&nbsp;" : listMap.getString("rdeptsub",i))+"</td>");                     
				html.append("						<td><div align=\"center\">"+(listMap.getString("grnm",i).equals("") ? "&nbsp;" : listMap.getString("grnm",i))+"("+listMap.getString("grseq",i)+")" +"</td>");                     
				html.append("						<td><div align=\"center\">"+(listMap.getString("started",i).equals("") ? "&nbsp;" : listMap.getString("started",i))+"</td>");                     
				html.append("						<td><div align=\"center\">"+(listMap.getString("enddate",i).equals("") ? "&nbsp;" : listMap.getString("enddate",i))+"</td>");                  
				if(!requestMap.getString("sessClass").equals("3")){
					html.append("					<td><div align=\"center\">"+(listMap.getString("seqno",i).equals("") ? "&nbsp;" : listMap.getString("seqno",i))+"</td>");
				}
				html.append("						<td><div align=\"center\">"+(listMap.getString("paccept",i).equals("") ? "&nbsp;" : listMap.getString("paccept",i))+"</td>");
				html.append("						<td align=\"center\"><div align=\"center\">"+(listMap.getString("rgrayn",i).equals("") ? "&nbsp;" : listMap.getString("rgrayn",i))+"</td>");
			}
		}else{
			html.append("						<!-- space-->");
			html.append("						<tr height=\"300\">");
			html.append("							<td colspan=\"11\" bgcolor=\"#FFFFFF\"colspan=\"100%\"><div align=\"center\">");
			html.append("								조회된 데이터가 없습니다.");
			html.append("							</td>");
		}
		html.append("							</tr>");
		html.append("							<tr bgcolor=\"375694\"> ");
		html.append("								<td height=\"2\" colspan=\"11\"></td>");
		html.append("							</tr>");
		html.append("						</table>");
		
		//html.append("						<tr bgcolor=\"#375694\" height=\"2\"><td colspan=\"100%\"></td></tr>");
		html.append("					</td>");
		html.append("				</tr>");
		html.append("			</table>");
		//리스트 출력 종료
		
		
		html.append("		</td>");
		html.append("	</tr>");
		html.append("</table>");
		
%>

<%
	String toToYear = "학적부";
	String file_name = new String(	toToYear.getBytes(), "ISO-8859-1");
	response.setHeader("Content-Disposition", "attachment; filename=" + file_name + ".xls");
	response.setHeader("Content-Description", "JSP Generated Data");
	response.setContentType("application/vnd.ms-excel");
	request.setCharacterEncoding("UTF-8");
%>

<meta http-equiv="Content-Type" content="application/vnd.ms-excel; charset=UTF-8">

	<table cellspacing="0" cellpadding="0" border="0" width="100%" height="100%">
	    <tr>
	        <td colspan="2" valign="top">
				<!--[s] Contents Form  -->
				<table cellspacing="0" cellpadding="0" border="0" width="100%">
					<tr>
						<td>       
	                        <!---[s] content -->
							<%=html.toString() %>
	                        <!---[e] content -->											
						</td>
					</tr>
				</table>
				<!--[e] Contents Form  -->				                            
	        </td>
	    </tr>
	</table>





