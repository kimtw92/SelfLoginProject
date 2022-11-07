<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%  
// prgnm : 평가 담당자 > 평가점수관리 > 특수과목점수입력 엑셀
// date : 2008-09-16
// auth : 최형준
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
	
	//////////////////////////////////////////////////////////////////////////////////// 	
	
	DataMap personList=null;
	
	StringBuffer sbListHtml = new StringBuffer();
	
	personList=(DataMap)request.getAttribute("personList");
	personList.setNullToInitialize(true);
	
	if(personList.keySize("resno") > 0){
		for(int i=0;i<personList.keySize();i++){	
			sbListHtml.append("<tr>");			
			sbListHtml.append("<td>"+personList.getString("stu_cnt",i)+"</td>");
			sbListHtml.append("<td>"+personList.getString("eduno",i)+"</td>");
			sbListHtml.append("<td>"+personList.getString("name",i)+"</td>");
			sbListHtml.append("<td>"+personList.getString("resno",i)+"</td>");
			sbListHtml.append("<td>"+personList.getString("deptnm",i)+"</td>");
			sbListHtml.append("<td>"+personList.getString("jiknm",i)+"</td>");
			//sbListHtml.append("<td>"+Integer.parseInt(personList.getString("cur_avlcount",i))+"</td>");
			sbListHtml.append("<td>"+personList.getString("cur_avlcount",i)+"</td>");
			sbListHtml.append("</tr>");
		}
	}else{
		sbListHtml.append("<tr>");
		if(requestMap.getString("sessClass").equals("7")) sbListHtml.append("<td>지정된 과목이 없습니다</td>");
		else sbListHtml.append("<td>검색된 내역이 없습니다</td>");
		sbListHtml.append("</tr>");
	}

	String toToYear = "특수과목가점입력_개인별평가";
	WebUtils.setFileHeader(request, response, toToYear+".xls", "UTF-8", "UTF-8");
	response.setHeader("Content-Description", "JSP Generated Data");
	response.setContentType("application/vnd.ms-excel");
	request.setCharacterEncoding("UTF-8");
%>
<meta http-equiv="Content-Type" content="application/vnd.ms-excel; charset=UTF-8">

				
<table cellspacing="0" cellpadding="0" border="1" width="95%">   
	<tr bgcolor="F7F7F7" align="center" height="30">
		<td class="tableline11" colspan="7"><b><%= toToYear %></b></td>
	</tr>
	<tr bgcolor="F7F7F7" align="center" height="28"> 
		<td class="tableline11"><strong>No</strong></td>
		<td class="tableline11"><strong>교번</strong></td>
		<td class="tableline11"><strong>성명</strong></td>
		<td class="tableline11"><strong>주민번호</strong></td>
		<td class="tableline11"><strong>소속기관</strong></td>
		<td class="tableline11"><strong>직급</strong></td>
		<td class="tableline11"><strong>점수</strong></td>
	</tr>
	<%=sbListHtml.toString() %>							
</table>					 								
