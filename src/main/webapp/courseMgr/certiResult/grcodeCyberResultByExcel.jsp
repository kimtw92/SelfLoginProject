<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 사이버 과정의 수료/미수료자 명단조회 엑셀 출력
// date : 2008-08-07
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

	
	String tmpStr = "";	
	
	//리스트
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	listMap.setNullToInitialize(true);

	StringBuffer listStr = new StringBuffer(); //리스트 결과 변수.
	for(int i=0; i < listMap.keySize("grcode"); i++){

		listStr.append("\n<tr height='25'>");
		
		int tmpSeqno = listMap.getInt("seqno", i); //임시 석차
		String tmpPaccept = Util.getValue(listMap.getString("paccept", i), "0"); // 임시 총점

		String seqno = ""; //석차
		String paccept = ""; //총점
		
		if( memberInfo.getSessClass().equals(Constants.ADMIN_SESS_CLASS_ADMIN)
				|| memberInfo.getSessClass().equals(Constants.ADMIN_SESS_CLASS_DEPT ) ){
			
			seqno = tmpSeqno + "";
			paccept = tmpPaccept;
			
		}else{

			if( tmpSeqno <= 3 && Double.parseDouble(tmpPaccept) >= 60){
				seqno = tmpSeqno + "";
				paccept = tmpPaccept;
			}else{
				seqno = "*";
				if( listMap.getString("rgrayn", i).equals("Y") && Double.parseDouble(tmpPaccept) == 60) paccept = "*";
				else if( listMap.getString("rgrayn", i).equals("Y") && Double.parseDouble(tmpPaccept) > 0) paccept = "60점 이상";
				else paccept = "60점 미만";
			}
			
		}
		
		//No
		listStr.append("\n	<td align='center' bgcolor='#FFFFFF'>" + (i+1) + "</td>");

		//성명
		listStr.append("\n	<td align='center' bgcolor='#FFFFFF'>" + listMap.getString("rname", i) + "</td>");
		
		listStr.append("\n	<td align='center' bgcolor='#FFFFFF'>" + listMap.getString("userId", i) + "</td>");
		
		tmpStr = listMap.getString("birthdate", i);
		listStr.append("\n	<td align='center' bgcolor='#FFFFFF'>" + tmpStr + "</td>");
		
		listStr.append("\n	<td align='center' bgcolor='#FFFFFF'>" + listMap.getString("sex", i) + "</td>");

		//과정명
		listStr.append("\n	<td align='center' bgcolor='#FFFFFF'>" + listMap.getString("grcodeniknm", i) + "</td>");
		
		//소속
		listStr.append("\n	<td align='center' bgcolor='#FFFFFF'>" + listMap.getString("rdeptnm", i) + "</td>");
		
		//세부기관
		listStr.append("\n	<td align='center' bgcolor='#FFFFFF'>" + listMap.getString("rdeptsub", i) + "</td>");
		
		//직급명
		listStr.append("\n	<td align='center' bgcolor='#FFFFFF'>" + listMap.getString("rjiknm", i) + "</td>");


		listStr.append("\n	<td align='center' bgcolor='#FFFFFF'>" + listMap.getString("tstep", i) + "</td>");
		
		listStr.append("\n	<td align='center' bgcolor='#FFFFFF'>" + listMap.getString("avcourse", i) + "</td>");
		
		listStr.append("\n	<td align='center' bgcolor='#FFFFFF'>" + listMap.getString("avlcount", i) + "</td>");
		
		//교번
		//listStr.append("\n	<td align='center' bgcolor='#FFFFFF'>" + listMap.getString("eduno", i) + "</td>");
		
		//성적
		listStr.append("\n	<td align='center' bgcolor='#FFFFFF'>" + paccept + "</td>");
		
		//석차
		//listStr.append("\n	<td align='center' bgcolor='#FFFFFF'>" + seqno + "</td>");

		//이수시간
		listStr.append("\n	<td align='center' bgcolor='#FFFFFF'>" + listMap.getString("grtime", i) + "</td>");

		//수료
		listStr.append("\n	<td align='center' bgcolor='#FFFFFF'>" + listMap.getString("txtRgrayn", i) + "</td>");
		
		//수료번호
		//listStr.append("\n	<td align='center' bgcolor='#FFFFFF'>" + listMap.getString("rno", i) + "</td>");

		listStr.append("\n</tr>");
	
	
	} //end for 

	//row가 없으면.
	if( listMap.keySize("grcode") <= 0){

		listStr.append("\n<tr>");
		listStr.append("\n	<td colspan='14' height='100' align=center>검색된 내용이 없습니다.</td>");
		listStr.append("\n</tr>");

	}

%>


<%
String toToYear = "사이버 수료_미수료자";
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
			<font color=000000><b>□ 과정수료/미수료자현황</b></font>
		</td>
	</tr>

	<tr>
		<td bgcolor="E5E5E5">

			<table cellpadding=2 cellspacing=1 width=100% border=1 bordercolorlight="#000000" bordercolordark="#ffffff">

				<tr height='25'>
					<td bgcolor='#EFF9EE' align=center><b>No</b></td>
					<td bgcolor='#EFF9EE' align=center><b>성명</b></td>
					<td bgcolor='#EFF9EE' align=center><b>ID</b></td>
					<td bgcolor='#EFF9EE' align=center><b>생년월일</b></td>
					<td bgcolor='#EFF9EE' align=center><b>성별</b></td>
					<td bgcolor='#EFF9EE' align=center><b>과정명</b></td>
					<td bgcolor='#EFF9EE' align=center><b>소속</b></td>
					<td bgcolor='#EFF9EE' align=center><b>세부소속기관</b></td>
					<td bgcolor='#EFF9EE' align=center><b>직급명</b></td>
					<td bgcolor='#EFF9EE' align=center><b>진도율</b></td>
					<td bgcolor='#EFF9EE' align=center><b>진도율점수</b></td>
					<td bgcolor='#EFF9EE' align=center><b>평가점수</b></td>
					<!-- td bgcolor='#EFF9EE' align=center><b>교번</b></td -->
					<td bgcolor='#EFF9EE' align=center><b>성적</b></td>
					<!-- td bgcolor='#EFF9EE' align=center><b>석차</b></td -->
					<td bgcolor='#EFF9EE' align=center><b>이수시간</b></td>
					<td bgcolor='#EFF9EE' align=center><b>수료</b></td>
					<!-- td bgcolor='#EFF9EE' align=center><b>수료번호</b></td -->
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