<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

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
	
	
	// 카테고리별 리스트
	StringBuffer sbListHtml = new StringBuffer();
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	if(listMap == null) listMap = new DataMap();
	listMap.setNullToInitialize(true);
	
	
	// 페이징
	PageNavigation pageNavi = (PageNavigation)listMap.get("PAGE_INFO");
	int pageNum = pageNavi.getTotalCnt() - (requestMap.getInt("currPage") - 1) * requestMap.getInt("rowSize");
	
	String pageStr = "";
	String param = "";
	
	String tmpSubj = "";
	String tmpSubjId = "";
	int tmpSubjCount = 0;
	
	if(listMap.keySize("userno") > 0){		
		for(int i=0; i < listMap.keySize("userno"); i++){
			
			// 강의과목
			tmpSubjCount = 0;
			for(int j=1; j < 8; j++){
				tmpSubjId = "subj" + j;
				
				if( !listMap.getString(tmpSubjId, i).equals("")){
					if(tmpSubjCount == 0){
						tmpSubj = listMap.getString(tmpSubjId, i);
					}else{
						tmpSubj += "," + listMap.getString(tmpSubjId, i);
					}
					tmpSubjCount++;
				}else{
					tmpSubj += "&nbsp;";
				}
			}
			
			
			sbListHtml.append("<tr bgcolor=\"#FFFFFF\" height=\"25\">");
			
			sbListHtml.append("	<td align=\"center\" class=\"tableline11\" rowspan=\"2\">" + (pageNum - i) + "</td>");
			sbListHtml.append("	<td align=\"center\" class=\"tableline11\" rowspan=\"2\"> <a href=\"javascript:go_popView('"+listMap.getString("userno", i)+"');\">" + listMap.getString("name", i) + "</a></td>");
			sbListHtml.append("	<td align=\"center\" class=\"tableline11\" >" + Util.getValue( listMap.getString("history", i) ,"&nbsp;") + "</td>");
			sbListHtml.append("	<td align=\"center\" class=\"tableline11\" >" + Util.getValue( listMap.getString("tposition", i) ,"&nbsp;") + "</td>");
			sbListHtml.append("	<td align=\"center\" class=\"tableline11\" >" + Util.getValue( listMap.getString("hp", i) ,"&nbsp;") + "</td>");
			
			
			param = "javascript:fnTutorInfo('" + listMap.getString("userno", i) + "');";
			sbListHtml.append("	<td align=\"center\" class=\"tableline11\" rowspan=\"2\"><a href=\"" + param + "\">수정</a></td>");
			
			
			if( listMap.getString("disabled", i).equals("N") ){
				param = "javascript:fnDisabled('Y','" + listMap.getString("userno", i) + "');";
			}else{
				param = "javascript:fnDisabled('N','" + listMap.getString("userno", i) + "');";
			}			
			sbListHtml.append("	<td align=\"center\" class=\"tableline21\" rowspan=\"2\"><a href=\"" + param + "\">" + Util.getValue( listMap.getString("disabled", i) ,"&nbsp;") + "</a></td>");
			
			sbListHtml.append("</tr>");
			
			sbListHtml.append("<tr bgcolor=\"#FFFFFF\" height=\"25\">");
			sbListHtml.append("	<td align=\"center\" class=\"tableline11\" >" + tmpSubj + "</td>");
			sbListHtml.append("	<td align=\"center\" class=\"tableline11\" >" + Util.getValue( listMap.getString("jikwi", i) ,"&nbsp;") + "</td>");
			sbListHtml.append("	<td align=\"center\" class=\"tableline11\" ><a href=\"mailto:" + listMap.getString("email", i) + "\">" + Util.getValue( listMap.getString("email", i) ,"&nbsp;") + "</a></td>");
			sbListHtml.append("</tr>");
		}
		
		pageStr += pageNavi.showFirst();
		pageStr += pageNavi.showPrev();
		pageStr += pageNavi.showPage();
		pageStr += pageNavi.showNext();
		pageStr += pageNavi.showLast();
		
		
	}else{
		sbListHtml.append("<tr bgcolor=\"#FFFFFF\" height=\"200\">");
		sbListHtml.append("	<td align=\"center\" class=\"tableline21\" colspan=\"100%\">데이타가 없습니다.</td>");
		sbListHtml.append("</tr>");
	}
%>

<%
String toToYear = "강사관리 ";
WebUtils.setFileHeader(request, response, toToYear+".xls", "UTF-8", "UTF-8");
response.setHeader("Content-Description", "JSP Generated Data");
response.setContentType("application/vnd.ms-excel");
request.setCharacterEncoding("UTF-8");
%>
<meta http-equiv="Content-Type" content="application/vnd.ms-excel; charset=UTF-8">

						<br>
						<table width="100%" border="1" cellspacing="1" cellpadding="0">
							<tr bgcolor="#375694"><td height="2" colspan="100%"></td></tr>
							
							<tr height="30" bgcolor="#5071B4" align="center">
								<td width="50" rowspan="2" class="tableline11 white"><b>번호</b></td>
								<td width="70" rowspan="2" class="tableline11 white"><b>성명</b></td>
								<td class="tableline11 white" ><b>전공</b></td>
								<td class="tableline11 white"><b>소속</b></td>
								<td class="tableline11 white"><b>핸드폰</b></td>
								<td width="50" rowspan="2" class="tableline11 white"><b>수정</b></td>
								<td width="50" rowspan="2" class="tableline11 white"><b>권한<br>없음</b></td>
							</tr>
							<tr height="30" bgcolor="#5071B4" align="center">
								<td class="tableline11 white"><b>강의과목</b></td>
								<td class="tableline11 white"><b>직위</b></td>
								<td class="tableline11 white"><b>E-Mail</b></td>
							</tr>
							
							<%= sbListHtml.toString() %>
							
							<tr bgcolor="#375694"><td height="2" colspan="100%"></td></tr>
						</table>