<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%  
// prgnm : 평가 담당자 > 평가점수관리 > 특수과목점수입력
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
	String classList = "";
	
	if(!requestMap.getString("classList").equals("") ){
		classList=requestMap.getString("classList");
		
	}else{
		//데이터가 없을때의 처리가 없어서 해놓았습니다.
		//작성자 정윤철 작성일 9월 16일
		classList= "<tr height=\"100\"><td colspan=\"100%\" bgcolor=\"#FFFFFF\" align=\"center\" class=\"tableline21\"> 검색된 내역이 없습니다. </td></tr>";
	}
	
	String toToYear = "특수과목가점입력_반별평가";
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
	<td class="tableline11 white"><strong>No</strong></td>
	<td class="tableline11 white"><strong>교번</strong></td>
	<td class="tableline11 white"><strong>성명</strong></td>
	<td class="tableline11 white"><strong>주민번호</strong></td>
	<td class="tableline11 white"><strong>소속기관</strong></td>
	<td class="tableline11 white"><strong>직급</strong></td>
	<td class="tableline11 white"><strong>점수</strong></td>
</tr>
<%=classList %>
</table>
			
