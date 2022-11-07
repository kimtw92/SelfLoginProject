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

	String tmpStr = "";

	String subjListStr = "";
	int selSubjCnt = 0;
	String subjDate = "";
	for(int i=0; i < subjListMap.keySize("subj"); i++){
		
		tmpStr = "";
		if(subjListMap.getString("lecType", i).equals("C")){
			selSubjCnt++;
			tmpStr = "<font color=orange>선택과목</font><br>";
		}
		
		subjListStr += "<td bgcolor='#EFF9EE' align=center><b>" + tmpStr + subjListMap.getString("lecnm", i) + "</b></td>";
		
		subjDate = subjListMap.getString("subjdate", i);
	}

	StringBuffer listStr = new StringBuffer(); //리스트 결과 변수.
	int tmpInt = 0;
	int tmpInt2 = 0;
	double tmpDou = 0;
	

	for(int i=0; i < listMap.keySize("userno"); i++){

		
		if(requestMap.getString("qu").equals("EXCEL")){ //엑셀 다운로드 일경우.
			
			tmpInt2 = 0;
			tmpInt = 0;
			//한줄 먼저 표시하기 전에 과목을 선택하지 않은 학생은 BG칼라 색상을 달리 해주기 위해
			for(int j=0; j < subjListMap.keySize("subj"); j++){

				tmpInt = 0;
				for(int k=0; k < subjStuPointListMap.keySize("userno"); k++){

					//수강생이 같고 과목 정보가 같으면
					if( listMap.getString("userno", i).equals(subjStuPointListMap.getString("userno", k)) && subjListMap.getString("subj", j).equals(subjStuPointListMap.getString("subj", k)) ){

						tmpInt++;
						break;
					}
				}
				//과목이 있지 않다면.
				if(tmpInt == 0)
					tmpInt2++;
			}

			String tmpBgColorStr = "#FFFFFF";
			//tr생성
			if(selSubjCnt > 0 && selSubjCnt == tmpInt2)
				tmpBgColorStr = "#FBE0E9";
			
			listStr.append("\n<tr height='25'>");
			
			
			//번호
			listStr.append("\n	<td align='center' bgcolor='"+tmpBgColorStr+"'>" + (i+1) + "</td>");
			
			//성명
			listStr.append("\n	<td align='center' bgcolor='"+tmpBgColorStr+"'>" + listMap.getString("name", i) + "</td>");

			//ID
			listStr.append("\n	<td align='center' bgcolor='"+tmpBgColorStr+"'>" + listMap.getString("userId", i) + "</td>");

			//기관
			if( listMap.getString("deptnm", i).equals("6280000") )
				tmpStr = listMap.getString("deptnm", i);
			else
				tmpStr = listMap.getString("deptnm", i).replace("인천광역시", "");
			listStr.append("\n	<td align='center' bgcolor='"+tmpBgColorStr+"'>" + tmpStr + "</td>");

			//직급
			listStr.append("\n	<td align='center' bgcolor='"+tmpBgColorStr+"'>" + listMap.getString("jiknm", i) + "</td>");

			//전화번호
			listStr.append("\n	<td align='center' bgcolor='"+tmpBgColorStr+"'>" + listMap.getString("hp", i) + "</td>");

			//과목별 점수.
			tmpDou = 0;
			tmpInt2 = 0;
			for(int j=0; j < subjListMap.keySize("subj"); j++){

				tmpInt = 0;
				for(int k=0; k < subjStuPointListMap.keySize("userno"); k++){

					//수강생이 같고 과목 정보가 같으면
					if( listMap.getString("userno", i).equals(subjStuPointListMap.getString("userno", k)) && subjListMap.getString("subj", j).equals(subjStuPointListMap.getString("subj", k)) ){

	                	tmpStr = Util.getValue(subjStuPointListMap.getString("disStep", k), "0");

	                	try{
	                		if(tmpStr.equals("완료")){
	                			tmpDou = 100;
	                		}else if(tmpStr.equals("진행중") || tmpStr.equals("미진행")){
	                			tmpDou = 0;
	                		}else{
	                			tmpDou = Double.parseDouble(tmpStr);
								tmpStr = "" + HandleNumber.getCommaZeroDeleteNumber(tmpStr); 
							}
	                		
	                	}catch(Exception ee){
	                		tmpDou = 0;
	                	}

						if(tmpDou < 80){
							listStr.append("\n	<td align='center' bgcolor='"+tmpBgColorStr+"' style='color:red;font-weight:bold'>" + tmpStr + "</td>");
						}else{
							listStr.append("\n	<td align='center' bgcolor='"+tmpBgColorStr+"'>" + tmpStr + "</td>");
						}

						tmpInt++;
						break;
					}
				}
				//수강생 과목별  정보가 없으면 0
				if(tmpInt == 0)
					listStr.append("\n	<td align='center' bgcolor='"+tmpBgColorStr+"'>-</td>");
			}

			listStr.append("\n</tr>");
			
		}else{ //연락처 일경우.
			
			
			listStr.append("\n<tr height='25'>");
			

			//전화번호
			listStr.append("\n	<td align='center' style=\"mso-number-format:'\\@'\" bgcolor='#FFFFFF'>" + listMap.getString("hp", i).replaceAll("-", "") + "</td>");
			
			//성명
			listStr.append("\n	<td align='center' bgcolor='#FFFFFF'>" + listMap.getString("name", i) + "님</td>");

			//메세지내용2
			listStr.append("\n	<td align='center' bgcolor='#FFFFFF'>" + listMap.getString("grcodenm", i) + subjDate + ", " + listMap.getString("grdate", i) + "(홈페이지 공지안내)</td>");

			
			listStr.append("\n</tr>");
		}

	} //end for listMap.keySize("dept")


	//row가 없으면.
	if( listMap.keySize("userno") <= 0){

		listStr.append("\n<tr>");
		listStr.append("\n	<td colspan='100%' style=\"height:100px\" class='br0'>검색된 내용이 없습니다.</td>");
		listStr.append("\n</tr>");

	}


%>


<%
String toToYear = "혼합학습현황";
if(requestMap.getString("qu").equals("PHONE"))
	toToYear = "혼합학습현황_연락처";
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
			<font color=000000><b>□ 혼합 학습현황</b></font>
		</td>
	</tr>

	<tr>
		<td bgcolor="E5E5E5">

			<table cellpadding=2 cellspacing=1 width=100% border=1 bordercolorlight="#000000" bordercolordark="#ffffff">

			<% if(requestMap.getString("qu").equals("EXCEL")){ %>

				<tr height='25'>
					<td bgcolor='#EFF9EE' align=center><b>번호</b></td>
					<td bgcolor='#EFF9EE' align=center><b>성명</b></td>
					<td bgcolor='#EFF9EE' align=center><b>ID</b></td>
					<td bgcolor='#EFF9EE' align=center><b>기관</b></td>
					<td bgcolor='#EFF9EE' align=center><b>직급</b></td>
					<td bgcolor='#EFF9EE' align=center><b>전화번호</b></td>
					<%= subjListStr %>
				</tr>
			<% }else{ %>
				<tr height='25'>
					<td bgcolor='#EFF9EE' align=center><b>휴대폰번호</b></td>
					<td bgcolor='#EFF9EE' align=center><b>메세지내용</b></td>
					<td bgcolor='#EFF9EE' align=center><b>메세지내용2</b></td>
				</tr>
			<% } %>

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