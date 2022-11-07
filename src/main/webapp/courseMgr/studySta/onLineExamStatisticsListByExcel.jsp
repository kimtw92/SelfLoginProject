<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 온라인 평가현황 엑셀 다운로드
// date : 2008-08-22
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

	
	//리스트
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	listMap.setNullToInitialize(true);

	//평가 정보
	DataMap examRowMap = (DataMap)request.getAttribute("EXAM_ROW_DATA");
	examRowMap.setNullToInitialize(true);
	
	StringBuffer listStr = new StringBuffer(); //리스트 결과 변수.
	String tmpStr = "";

	for(int i=0; i < listMap.keySize("userno"); i++){

		listStr.append("\n<tr>");

		//번호
		listStr.append("\n	<td align='center' bgcolor='#FFFFFF'>" + (i+1) + "</td>");
		
		//성명
		listStr.append("\n	<td align='center' bgcolor='#FFFFFF'>" + listMap.getString("name", i) + "</td>");

		//ID
		listStr.append("\n	<td align='center' bgcolor='#FFFFFF'>" + listMap.getString("userId", i) + "</td>");
		
		//기관
		if( listMap.getString("deptnm", i).equals("6280000") )
			tmpStr = listMap.getString("deptnm", i);
		else
			tmpStr = listMap.getString("deptnm", i).replace("인천광역시", "");
		listStr.append("\n	<td align='center' bgcolor='#FFFFFF'>" + tmpStr + "</td>");
		
		//직급
		listStr.append("\n	<td align='center' bgcolor='#FFFFFF'>" + listMap.getString("jiknm", i) + "</td>");
		
		//전화번호
		listStr.append("\n	<td align='center' bgcolor='#FFFFFF'>" + listMap.getString("hp", i) + "</td>");
		
		//평가응시
		if(listMap.getString("ynEnd", i).equals("Y"))
			tmpStr = "응시완료";
		else if(listMap.getString("ynEnd", i).equals("N"))
			tmpStr = "응시중";
		else
			tmpStr = "미응시";
		listStr.append("\n	<td align='center' bgcolor='#FFFFFF'>" + tmpStr + "</td>");
		
		
		//1차, 2차 점수
		String strScore1 = "";
		String strScore2 = "";
		String[] tmpArr = listMap.getString("tryInfo", i).split("_");
		try{
			if(tmpArr[0].equals("0")){
				strScore1 = listMap.getString("score", i);
				strScore2 = "";
			}else{
				strScore1 = tmpArr[1];
				strScore2 = listMap.getString("score", i);
			}
		}catch(Exception e){
			strScore1 = "";
			strScore2 = "";
		}
		//1차
		listStr.append("\n	<td align='center' bgcolor='#FFFFFF'>" + strScore1 + "</td>");
		//2차
		listStr.append("\n	<td align='center' bgcolor='#FFFFFF'>" + strScore2 + "</td>");
		
		//비고
		if( !examRowMap.getString("idExamKind").equals("0") && !examRowMap.getString("idExamKind").equals("1") ){
			
			double tmpDou = Double.parseDouble(Util.getValue(listMap.getString("allotting", i), "0")) * 0.6;
			
			if( !listMap.getString("score", i).equals("") ){
				if( tmpDou <= Double.parseDouble(listMap.getString("score", i)) )
					tmpStr = "이수";
				else
					tmpStr = "미이수";
			}else
				tmpStr = "미이수";

		}else
			tmpStr = "";
		listStr.append("\n	<td align='center' bgcolor='#FFFFFF'>" + tmpStr + "</td>");

		listStr.append("\n</tr>");

	} //end for listMap.keySize("dept")



	//row가 없으면.
	if( listMap.keySize("userno") <= 0){

		listStr.append("\n<tr>");
		listStr.append("\n	<td colspan='10' height='100' align='center' bgcolor='#FFFFFF'>검색된 내용이 없습니다.</td>");
		listStr.append("\n</tr>");

	}


%>


<%
String toToYear = examRowMap.getString("title") + "_온라인평가현황";
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
			<font color=000000><b>□ <%= examRowMap.getString("title") %> 온라인평가현황</b></font>
		</td>
	</tr>

	<tr>
		<td bgcolor="E5E5E5">

			<table cellpadding=2 cellspacing=1 width=100% border=1 bordercolorlight="#000000" bordercolordark="#ffffff">

				<tr height='25'>
					<td bgcolor='#EFF9EE' align=center><b>번호</b></td>
					<td bgcolor='#EFF9EE' align=center><b>성명</b></td>
					<td bgcolor='#EFF9EE' align=center><b>ID</b></td>
					<td bgcolor='#EFF9EE' align=center><b>기관</b></td>
					<td bgcolor='#EFF9EE' align=center><b>직급</b></td>
					<td bgcolor='#EFF9EE' align=center><b>전화번호</b></td>
					<td bgcolor='#EFF9EE' align=center><b>평가응시</b></td>
					<td bgcolor='#EFF9EE' align=center><b>1차점수</b></td>
					<td bgcolor='#EFF9EE' align=center><b>2차점수</b></td>
					<td bgcolor='#EFF9EE' align=center><b>비고</b></td>
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