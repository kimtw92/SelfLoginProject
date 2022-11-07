<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 사이버 학습현황 엑셀 다운로드
// date : 2008-08-21
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



	String tmpStr = "";


	
	StringBuffer listStr = new StringBuffer(); //리스트 결과 변수.
	int tmpInt = 0;
	double tmpDou = 0;
	int tmpRowCnt = 0;

	String tmpGrcode = "";
	String tmpGrseq = "";
	String tmpUserno = "";
	
	for(int i=0; i < listMap.keySize("userno"); i++){

		listStr.append("\n<tr height='25'>");
		
		tmpRowCnt = 0;
		
		for(int j=i; j < listMap.keySize("userno"); j++)
			if(listMap.getString("grcode", i).equals(listMap.getString("grcode", j)) && listMap.getString("grseq", i).equals(listMap.getString("grseq", j)) && listMap.getString("userno", i).equals(listMap.getString("userno", j)))
				tmpRowCnt++;
		
		
		if( listMap.getString("grcode", i).equals(tmpGrcode) && listMap.getString("grseq", i).equals(tmpGrseq) && listMap.getString("userno", i).equals(tmpUserno)){
		
		}else{
			
			tmpGrcode = listMap.getString("grcode", i);
			tmpGrseq = listMap.getString("grseq", i);
			tmpUserno = listMap.getString("userno", i);
			
			//번호
			listStr.append("\n	<td rowspan='"+tmpRowCnt+"' align='center' bgcolor='#FFFFFF'>" + ++tmpInt + "</td>");

			//과정
			listStr.append("\n	<td rowspan='"+tmpRowCnt+"' align='center' bgcolor='#FFFFFF'>" + listMap.getString("grcodenm", i) + "</td>");
			
			//성명
			listStr.append("\n	<td rowspan='"+tmpRowCnt+"' align='center' bgcolor='#FFFFFF'>" + listMap.getString("name", i) + "</td>");
			
			listStr.append("\n	<td rowspan='"+tmpRowCnt+"' align='center' bgcolor='#FFFFFF'>" + listMap.getString("userId", i) + "</td>");

			//기관
			if( listMap.getString("deptnm", i).equals("6280000") )
				tmpStr = listMap.getString("deptnm", i);
			else
				tmpStr = listMap.getString("deptnm", i).replace("인천광역시", "");
			listStr.append("\n	<td rowspan='"+tmpRowCnt+"' align='center' bgcolor='#FFFFFF'>" + tmpStr + "</td>");

			//직급
			listStr.append("\n	<td rowspan='"+tmpRowCnt+"' align='center' bgcolor='#FFFFFF'>" + listMap.getString("jiknm", i) + "</td>");

			//전화번호
			listStr.append("\n	<td rowspan='"+tmpRowCnt+"' align='center' bgcolor='#FFFFFF'>" + listMap.getString("hp", i) + "</td>");

		}
		
		
		tmpStr = Util.getValue(listMap.getString("disStep", i), "0");

		
		try{
			
       		if(tmpStr.equals("완료")){
    			tmpDou = 100;
    		}else if(tmpStr.equals("진행중") || tmpStr.equals("미진행")){
    			tmpDou = 0;
    		}else{
    			tmpDou = Double.parseDouble(tmpStr);
				tmpStr = "" + HandleNumber.getCommaZeroDeleteNumber(tmpStr); 
			}
       		
    	}catch(Exception ee){}

		if(tmpDou < 80){
			listStr.append("\n	<td align='center' bgcolor='#FFFFFF'><span style='color:red;font-weight:bold'>" + listMap.getString("lecnm", i) + "(" + tmpStr + ")</span></td>");
		}else{
			listStr.append("\n	<td align='center' bgcolor='#FFFFFF'>" + listMap.getString("lecnm", i) + "(" + tmpStr + ")</td>");
		}

		



		listStr.append("\n</tr>");

	} //end for listMap.keySize("dept")


	//row가 없으면.
	if( listMap.keySize("userno") <= 0){

		listStr.append("\n<tr>");
		listStr.append("\n	<td colspan='7' height='100' align='center' bgcolor='#FFFFFF'>검색된 내용이 없습니다.</td>");
		listStr.append("\n</tr>");

	}


%>


<%
String toToYear = "사이버학습현황";
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
			<font color=000000><b>□ 사이버 학습 현황</b></font>
		</td>
	</tr>

	<tr>
		<td bgcolor="E5E5E5">

			<table cellpadding=2 cellspacing=1 width=100% border=1 bordercolorlight="#000000" bordercolordark="#ffffff">

				<tr height='25'>
					<td bgcolor='#EFF9EE' align=center><b>번호</b></td>
					<td bgcolor='#EFF9EE' align=center><b>과정</b></td>
					<td bgcolor='#EFF9EE' align=center><b>성명</b></td>
					<td bgcolor='#EFF9EE' align=center><b>아이디</b></td>
					<td bgcolor='#EFF9EE' align=center><b>기관</b></td>
					<td bgcolor='#EFF9EE' align=center><b>직급</b></td>
					<td bgcolor='#EFF9EE' align=center><b>전화번호</b></td>
					<td bgcolor='#EFF9EE' align=center><b>진도율</b></td>
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