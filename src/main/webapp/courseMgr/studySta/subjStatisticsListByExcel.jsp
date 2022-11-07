<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 전체 학습현황 엑셀 출력
// date : 2008-08-14
// auth : LYM
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
	String navigationStr = LoginCheck.NavigationCreate(memberInfo, navigationMap);
	////////////////////////////////////////////////////////////////////////////////////

	
	//수강생 리스트
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	listMap.setNullToInitialize(true);

	//과목 리스트
	DataMap subjListMap = (DataMap)request.getAttribute("SUBJ_LIST_DATA");
	subjListMap.setNullToInitialize(true);

	//수강생의 과목별 점수 리스트
	DataMap subjStuPointListMap = (DataMap)request.getAttribute("STUPOINT_LIST_DATA");
	subjStuPointListMap.setNullToInitialize(true);


	StringBuffer listStr = new StringBuffer(); //리스트 결과 변수.
	String tmpStr = "";
	int tmpInt = 0;
	double tmpDouble = 0;

	for(int i=0; i < listMap.keySize("userno"); i++){

		listStr.append("\n<tr>");

		//번호
		listStr.append("\n	<td>" + (i+1) + "</td>");
		
		//아이디
		listStr.append("\n	<td>" + listMap.getString("userId", i) + "</td>");

		//이름
		listStr.append("\n	<td>" + listMap.getString("name", i) + "</td>");

		//기관
		listStr.append("\n	<td>" + listMap.getString("deptnm", i) + "</td>");

		//직급
		listStr.append("\n	<td>" + listMap.getString("jiknm", i) + "</td>");

		//주민번호
		//tmpStr = StringReplace.subString(listMap.getString("resno", i), 0, 6) + "-XXXXXX";
		//listStr.append("\n	<td>" + tmpStr + "</td>");

		//전화번호
		listStr.append("\n	<td>" + listMap.getString("hp", i) + "</td>");

		//진도율
		listStr.append("\n	<td>" + listMap.getString("tstep", i) + "</td>");

		//진도율점수
		listStr.append("\n	<td>" + listMap.getString("avcourse", i) + "</td>");

		//차시평가
		listStr.append("\n	<td>" + listMap.getString("quizstep", i) + "</td>");

		//평가점수
		listStr.append("\n	<td>" + listMap.getString("avquiz", i) + "</td>");

		//평가점수
		listStr.append("\n	<td>" + listMap.getString("avlcount", i) + "</td>");


		if(!memberInfo.getSessClass().equals(Constants.ADMIN_SESS_CLASS_DEPT)){ 
			
			//과제물점수
			listStr.append("\n	<td>" + listMap.getString("avreport", i) + "</td>");
			
			//취득점수
			tmpDouble = Double.parseDouble(listMap.getString("avcourse", i)) + Double.parseDouble(listMap.getString("avlcount", i)) + Double.parseDouble(listMap.getString("avquiz", i)) + Double.parseDouble(listMap.getString("avreport", i));
//			listStr.append("\n	<td class='br0'>" + HandleNumber.getCommaOnePointNumber(tmpDouble) + "</td>");
			listStr.append("\n	<td class='br0'>" + tmpDouble + "</td>");
			listStr.append("\n	<td class='br0'>" + listMap.getString("grayn", i) + "</td>");
			
		}else{
			
			//과제물점수
			listStr.append("\n	<td class='br0'>" + listMap.getString("avreport", i) + "</td>");
		}


		listStr.append("\n</tr>");

	} //end for listMap.keySize("dept")


	//row가 없으면.
	if( listMap.keySize("userno") <= 0){

		listStr.append("\n<tr>");
		listStr.append("\n	<td colspan='100%' style=\"height:100px\" class='br0'>검색된 내용이 없습니다.</td>");
		listStr.append("\n</tr>");

	}


%>


<%
String toToYear = "과목별학습현황";
WebUtils.setFileHeader(request, response, toToYear+".xls", "UTF-8", "UTF-8");
response.setHeader("Content-Description", "JSP Generated Data");
response.setContentType("application/vnd.ms-excel");
request.setCharacterEncoding("UTF-8");
%>
<meta http-equiv="Content-Type" content="application/vnd.ms-excel; charset=UTF-8">



<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height=30 valign=top></td>
	</tr>
	<tr>
		<td height=30 valign=top>
			<font color=000000><b>□ 과목별학습현황</b></font>
		</td>
	</tr>

	<tr>
		<td>

			<table cellpadding=2 cellspacing=1 width=100% border=1 bordercolorlight="#000000">

									<tr>
											<th>번호</th>
											
											<th>아이디</th>
											
											<th>이름</th>
											<th>기관</th>
											<th>직급</th>
											
											<!-- 
											<th>주민번호</th>
											 -->
											 
											<th>전화번호</th>
											<th>진도율<br />(%)</th>
											<th>진도율<br />점수</th>
											<th>차시<br />평가<br />정답율<br />(%)</th>
											<th>차시<br />평가<br />점수</th>
											<th>평가<br />점수</th>
										<%if(!memberInfo.getSessClass().equals(Constants.ADMIN_SESS_CLASS_DEPT)){ %>
											<th>과제물<br />점수</th>
											<th class="br0">취득<br />점수</th>
											<th class="br0">이수<br />여부</th>
										<%}else{%>
											<th class="br0">과제물<br />점수</th>
										<%}%>
										</tr>
								<%= listStr.toString() %>

			</table>

		</td>
	</tr>

	<tr>
		<td>
			&#160;
		</td>
	</tr>
</table>