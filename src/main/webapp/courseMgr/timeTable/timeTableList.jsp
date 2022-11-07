<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 시간표 리스트.
// date : 2008-06-23
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


	//과정기수 정보.
	DataMap grSeqRowMap = (DataMap)request.getAttribute("GRSEQ_ROW_DATA");
	grSeqRowMap.setNullToInitialize(true);

	//기수의 강의실 정보
	DataMap grseqClassroomMap = (DataMap)request.getAttribute("GRSEQ_CLASSROOM_ROW_DATA");
	grseqClassroomMap.setNullToInitialize(true);

	//시간표 리스트
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	listMap.setNullToInitialize(true);

	
	StringBuffer listStr = new StringBuffer(); //리스트 결과 변수.
	//String tmpStr = "";
	String[] dayArr = {"", "", "", "", ""}; //상단에 표시되는 월,화,수.. 일자. ex)20080324
	String[] dayComaArr = {"", "", "", "", ""}; //상단에 표시되는 월,화,수.. 일자. ex)<br>(03.24)
	String[] dayOnlyComaArr = {"", "", "", "", ""}; //상단에 표시되는 월,화,수.. 일자. ex)03.24
	
	if(!requestMap.getString("commGrcode").equals("") && !requestMap.getString("commGrseq").equals("") && listMap.getInt("weekCnt") > 0){
		
		// 타이틀의 일자. [S]
		DataMap weekDay = (DataMap)listMap.get("WEEK_MAP");
		if(weekDay == null) weekDay = new DataMap();
		weekDay.setNullToInitialize(true);
		
		for(int i=0;i < weekDay.keySize("comaDay"); i++){
			dayArr[i] = weekDay.getString("day", i);
			dayComaArr[i] = "<br/>(" + weekDay.getString("comaDay", i) + ")";
			dayOnlyComaArr[i] = weekDay.getString("comaDay", i);
		}
		// 타이틀의 일자. [E]
		
		             
		//교시 정보
		DataMap gosiMap = (DataMap)listMap.get("GOSI_MAP");
		if(gosiMap == null) gosiMap = new DataMap();
		gosiMap.setNullToInitialize(true);
		
		int gosiCnt = gosiMap.keySize("gosinum");
		String[][] gosi = new String[gosiCnt][3];  //0:교시, 1: 보여줄교시, 2:교시의 시간
		for(int i=0;i < gosi.length; i++) //초기화
			for(int j=0;j < gosi[i].length; j++)
				gosi[i][j] = "";

		//Rowspan 여부를 계산하여 등록하는 배열 (default 1)
		int[][] rowspanCnt = new int[gosiCnt][5];
		String[][] resultStr = new String[gosiCnt][5]; //결과
		String[][] tmpArrStr = new String[gosiCnt][5]; //이전 교시와 같은지
		String[][] subjAddStr = new String[gosiCnt][5]; //과목 추가를 위해.
		for(int i=0;i < gosiCnt; i++){ //초기화
			for(int j=0;j < 5; j++){
				rowspanCnt[i][j] = 1;
				resultStr[i][j] = "";
				tmpArrStr[i][j] = "";
				subjAddStr[i][j] = "";
			}
		}
		
		//월~수요일 까지 시간표 리스트.
		DataMap plan1 = (DataMap)listMap.get("TIME1_LIST_DATA");
		if(plan1 == null) plan1 = new DataMap();
		plan1.setNullToInitialize(true);
		
		//목, 금 요일 시간표 리스트
		DataMap plan2 = (DataMap)listMap.get("TIME2_LIST_DATA");
		if(plan2 == null) plan2 = new DataMap();
		plan2.setNullToInitialize(true);
		
		String[][] tmpMon = null; //월
		String[][] tmpTue = null; //화
		String[][] tmpWed = null; //수
		String[][] tmpThu = null; //목
		String[][] tmpFri = null; //금
		int subjCnt = 0; //각 시간마다 과목의 갯수.
		
		//Row 계산을 위해 먼저 한번 돌려서 해당 교시의 과목정도 등 넣어둠. 
		for(int i=0;i < gosi.length; i++){
			
			//교시 정보 
			gosi[i][0] = gosiMap.getString("gosinum", i);
			if(gosiMap.getInt("gosinum", i) > 0)
				gosi[i][1] = gosiMap.getString("gosinum", i);
			gosi[i][2] = gosiMap.getString("term", i);
			
			subjAddStr[i][0] = subjAddStr[i][1] = subjAddStr[i][2] = subjAddStr[i][3] = subjAddStr[i][4] = gosi[i][0];

			//월요일 [S]
			subjCnt = (plan1.getString("subj1", i).split(",")).length; //과목  갯수.
			tmpMon = new String[5][subjCnt];
			tmpMon[1] = plan1.getString("lecnm1", i).split(",");			//과목명
			tmpMon[3] = plan1.getString("tuUserno1", i).split(",");			//강사 userno
			
			for(int k=0; k < subjCnt; k++){
				if(k > 0)
					tmpArrStr[i][0] += "|";
					
				//이전기수와 비교하기 위해.
				if( !(tmpMon[1][k].replace("&&", "")).trim().equals("") ) //과목코드
					tmpArrStr[i][0] += tmpMon[1][k].replace("&&", "");
				if( !(tmpMon[3][k].replace("&&", "")).trim().equals("") ) //강사코드
					tmpArrStr[i][0] += "<br>(" + tmpMon[3][k].replace("&&", "").replaceAll(";", ",") + ")";	
			}
			//월요일 [E]
			
			
			//화요일 [S]
			subjCnt = (plan1.getString("subj2", i).split(",")).length; //과목  갯수.
			tmpTue = new String[5][subjCnt];
			tmpTue[1] = plan1.getString("lecnm2", i).split(",");			//과목명
			tmpTue[3] = plan1.getString("tuUserno2", i).split(",");			//강사 userno
			
			for(int k=0; k < subjCnt; k++){
				if(k > 0)
					tmpArrStr[i][1] += "|";
				
				//이전기수와 비교하기 위해.
				if( !(tmpTue[1][k].replace("&&", "")).trim().equals("") ) //과목코드
					tmpArrStr[i][1] += tmpTue[1][k].replace("&&", "");
				if( !(tmpTue[3][k].replace("&&", "")).trim().equals("") ) //강사코드
					tmpArrStr[i][1] += "<br>(" + tmpTue[3][k].replace("&&", "") + ")";
					
			}
			
			//화요일 [E]
			
			//수요일 [S]
			subjCnt = (plan1.getString("subj3", i).split(",")).length; //과목  갯수.
			tmpWed = new String[5][subjCnt];
			tmpWed[1] = plan1.getString("lecnm3", i).split(",");			//과목명
			tmpWed[3] = plan1.getString("tuUserno3", i).split(",");			//강사 userno
			
			for(int k=0; k < subjCnt; k++){
				
				if(k > 0)
					tmpArrStr[i][2] += "|";
				
				//이전기수와 비교하기 위해.
				if( !(tmpWed[1][k].replace("&&", "")).trim().equals("") ) //과목코드
					tmpArrStr[i][2] += tmpWed[1][k].replace("&&", "");
				if( !(tmpWed[3][k].replace("&&", "")).trim().equals("") ) //강사코드
					tmpArrStr[i][2] += "<br>(" + tmpWed[3][k].replace("&&", "") + ")";
			}
			//수요일 [E]
			       
			       
			//목요일 [S]
			subjCnt = (plan2.getString("subj4", i).split(",")).length; //과목  갯수.
			tmpThu = new String[5][subjCnt];
			tmpThu[1] = plan2.getString("lecnm4", i).split(",");			//과목명
			tmpThu[3] = plan2.getString("tuUserno4", i).split(",");			//강사 userno
			
			for(int k=0; k < subjCnt; k++){
				
				if(k > 0)
					tmpArrStr[i][3] += "|";

				
				//이전기수와 비교하기 위해.
				if( !(tmpThu[1][k].replace("&&", "")).trim().equals("") ) //과목코드
					tmpArrStr[i][3] += tmpThu[1][k].replace("&&", "");
				if( !(tmpThu[3][k].replace("&&", "")).trim().equals("") ) //강사코드
					tmpArrStr[i][3] += "<br>(" + tmpThu[3][k].replace("&&", "") + ")";
					
			}
			//목요일 [E]
			       
			//금요일 [S]
			subjCnt = (plan2.getString("subj5", i).split(",")).length; //과목  갯수.
			tmpFri = new String[5][subjCnt];
			tmpFri[1] = plan2.getString("lecnm5", i).split(",");			//과목명
			tmpFri[3] = plan2.getString("tuUserno5", i).split(",");			//강사 userno
			
			for(int k=0; k < subjCnt; k++){
				
				if(k > 0)
					tmpArrStr[i][4] += "|";
				
				//이전기수와 비교하기 위해.
				if( !(tmpFri[1][k].replace("&&", "")).trim().equals("") ) //과목코드
					tmpArrStr[i][4] += tmpFri[1][k].replace("&&", "");
				if( !(tmpFri[3][k].replace("&&", "")).trim().equals("") ) //강사코드
					tmpArrStr[i][4] += "<br>(" + tmpFri[3][k].replace("&&", "") + ")";
			}
			//금요일 [E]
			       
		}
		

		//이전 교시와 비교하여 rowSpan 계산. 및 과목 추가시 사용할 교시 정보 셋팅
		for(int i=0;i < 5; i++){
			for(int k=(gosi.length-1); k > 0; k--){
				//이전 교시랑 같다면.
				if(!tmpArrStr[k][i].trim().equals("") && tmpArrStr[k][i].equals(tmpArrStr[k-1][i])){
					System.out.print("#이전 = " + tmpArrStr[k-1][i] + "\n");
					System.out.print("#들어온거 = " + tmpArrStr[k][i] + "\n");
					rowspanCnt[k-1][i] += rowspanCnt[k][i];
					rowspanCnt[k][i] = 0;
					
					subjAddStr[k-1][i] += "|" + subjAddStr[k][i];
					subjAddStr[k][i] = "";
					
				}
			}
		}
		
		tmpMon = null; //월
		tmpTue = null; //화
		tmpWed = null; //수
		tmpThu = null; //목
		tmpFri = null; //금
		
		String monStr = "";
		String tueStr = "";
		String wedStr = "";
		String thuStr = "";
		String friStr = "";
		
		//실제 시간표 내역 계산 하여 넣는  for 문 
		for(int i=0;i < gosi.length; i++){
			

			//월요일 [S]
			subjCnt = (plan1.getString("subj1", i).split(",")).length; //과목  갯수.
			tmpMon = new String[5][subjCnt];
			tmpMon[0] = plan1.getString("subj1", i).split(",");				//과목코드
			tmpMon[1] = plan1.getString("lecnm1", i).split(",");			//과목명
			tmpMon[2] = plan1.getString("classroomName1", i).split(",");	//강의실명
			tmpMon[3] = plan1.getString("tuUserno1", i).split(",");			//강사 userno
			tmpMon[4] = plan1.getString("tuName1", i).split(",");			//강사명
			
			for(int k=0; k < subjCnt; k++){
				
				monStr = tmpMon[1][k].replace("&&", ""); //과목명
				if( !(tmpMon[4][k].replace("&&", "")).trim().equals("") ) //강사
					monStr += "<br>(" + tmpMon[4][k].replace("&&", "").replaceAll(";", ",") + ")";
				
				if( !(tmpMon[2][k].replace("&&", "")).trim().equals("") ) //강의실.
					monStr += "<br>(" + tmpMon[2][k].replace("&&", "") + ")";
				
					
				if(k > 0)
					resultStr[i][0] += "<br><br>";
					
				if(rowspanCnt[i][0] == 1 && !tmpMon[0][k].replace("&&", "").trim().equals("")){
					
					resultStr[i][0] += "<a href=\"javascript:go_modify('"+dayArr[0]+"', '" + gosi[i][0] + "', '" + tmpMon[0][k].replace("&&", "").trim() + "');\">";
					resultStr[i][0] += monStr;
					resultStr[i][0] += "</a>";
					
				}else
					resultStr[i][0] += monStr;
				
			}
			//월요일 [E]
			
			
			//화요일 [S]
			subjCnt = (plan1.getString("subj2", i).split(",")).length; //과목  갯수.
			tmpTue = new String[5][subjCnt];
			tmpTue[0] = plan1.getString("subj2", i).split(",");				//과목코드
			tmpTue[1] = plan1.getString("lecnm2", i).split(",");			//과목명
			tmpTue[2] = plan1.getString("classroomName2", i).split(",");	//강의실명
			tmpTue[3] = plan1.getString("tuUserno2", i).split(",");			//강사 userno
			tmpTue[4] = plan1.getString("tuName2", i).split(",");			//강사명
			
			for(int k=0; k < subjCnt; k++){
				
				tueStr = tmpTue[1][k].replace("&&", "");
				if( !(tmpTue[4][k].replace("&&", "")).trim().equals("") )  //강사
					tueStr += "<br>(" + tmpTue[4][k].replace("&&", "").replaceAll(";", ",") + ")";
				
				if( !(tmpTue[2][k].replace("&&", "")).trim().equals("") ) //강의실.
					tueStr += "<br>(" + tmpTue[2][k].replace("&&", "") + ")";
				
				if(k > 0)
					resultStr[i][1] += "<br><br>";
					
				if(rowspanCnt[i][1] == 1 && !tmpTue[0][k].replace("&&", "").trim().equals("")){
					
					resultStr[i][1] += "<a href=\"javascript:go_modify('"+dayArr[1]+"', '" + gosi[i][0] + "', '" + tmpTue[0][k].replace("&&", "").trim() + "');\">";
					resultStr[i][1] += tueStr;
					resultStr[i][1] += "</a>";
					
				}else
					resultStr[i][1] += tueStr;
				
			}
			//화요일 [E]
			
			//수요일 [S]
			subjCnt = (plan1.getString("subj3", i).split(",")).length; //과목  갯수.
			tmpWed = new String[5][subjCnt];
			tmpWed[0] = plan1.getString("subj3", i).split(",");				//과목코드
			tmpWed[1] = plan1.getString("lecnm3", i).split(",");			//과목명
			tmpWed[2] = plan1.getString("classroomName3", i).split(",");	//강의실명
			tmpWed[3] = plan1.getString("tuUserno3", i).split(",");			//강사 userno
			tmpWed[4] = plan1.getString("tuName3", i).split(",");			//강사명
			
			for(int k=0; k < subjCnt; k++){
				
				wedStr = tmpWed[1][k].replace("&&", "");
				if( !(tmpWed[4][k].replace("&&", "")).trim().equals("") ) //강사
					wedStr += "<br>(" + tmpWed[4][k].replace("&&", "").replaceAll(";", ",") + ")";
				
				if( !(tmpWed[2][k].replace("&&", "")).trim().equals("") ) //강의실
					wedStr += "<br>(" + tmpWed[2][k].replace("&&", "") + ")";
				
				
				if(k > 0)
					resultStr[i][2] += "<br><br>";
				
				if(rowspanCnt[i][2] == 1 && !tmpWed[0][k].replace("&&", "").trim().equals("")){
					
					resultStr[i][2] += "<a href=\"javascript:go_modify('"+dayArr[2]+"', '" + gosi[i][0] + "', '" + tmpWed[0][k].replace("&&", "").trim() + "');\">";
					resultStr[i][2] += wedStr;
					resultStr[i][2] += "</a>";
					
				}else
					resultStr[i][2] += wedStr;

			}
			//수요일 [E]
			       
			       
			//목요일 [S]
			subjCnt = (plan2.getString("subj4", i).split(",")).length; //과목  갯수.
			tmpThu = new String[5][subjCnt];
			tmpThu[0] = plan2.getString("subj4", i).split(",");				//과목코드
			tmpThu[1] = plan2.getString("lecnm4", i).split(",");			//과목명
			tmpThu[2] = plan2.getString("classroomName4", i).split(",");	//강의실명
			tmpThu[3] = plan2.getString("tuUserno4", i).split(",");			//강사 userno
			tmpThu[4] = plan2.getString("tuName4", i).split(",");			//강사명
			
			for(int k=0; k < subjCnt; k++){
				
				thuStr = tmpThu[1][k].replace("&&", "");
				if( !(tmpThu[4][k].replace("&&", "")).trim().equals("") ) //강사
					thuStr += "<br>(" + tmpThu[4][k].replace("&&", "").replaceAll(";", ",") + ")";
				
				if( !(tmpThu[2][k].replace("&&", "")).trim().equals("") ) //강의실
					thuStr += "<br>(" + tmpThu[2][k].replace("&&", "") + ")";
				
				if(k > 0)
					resultStr[i][3] += "<br><br>";
				
				if(rowspanCnt[i][3] == 1 && !tmpThu[0][k].replace("&&", "").trim().equals("")){
					
					resultStr[i][3] += "<a href=\"javascript:go_modify('"+dayArr[3]+"', '" + gosi[i][0] + "', '" + tmpThu[0][k].replace("&&", "").trim() + "');\">";
					resultStr[i][3] += thuStr;
					resultStr[i][3] += "</a>";
					
				}else
					resultStr[i][3] += thuStr;
			}
			//목요일 [E]
			       
			//금요일 [S]
			subjCnt = (plan2.getString("subj5", i).split(",")).length; //과목  갯수.
			tmpFri = new String[5][subjCnt];
			tmpFri[0] = plan2.getString("subj5", i).split(",");				//과목코드
			tmpFri[1] = plan2.getString("lecnm5", i).split(",");			//과목명
			tmpFri[2] = plan2.getString("classroomName5", i).split(",");	//강의실명
			tmpFri[3] = plan2.getString("tuUserno5", i).split(",");			//강사 userno
			tmpFri[4] = plan2.getString("tuName5", i).split(",");			//강사명
			
			for(int k=0; k < subjCnt; k++){
				
				friStr = tmpFri[1][k].replace("&&", "");
				if( !(tmpFri[4][k].replace("&&", "")).trim().equals("") ) //강사
					friStr += "<br>(" + tmpFri[4][k].replace("&&", "").replaceAll(";", ",") + ")";
				
				if( !(tmpFri[2][k].replace("&&", "")).trim().equals("") ) //강의실
					friStr += "<br>(" + tmpFri[2][k].replace("&&", "") + ")";
				
					
				if(k > 0)
					resultStr[i][4] += "<br><br>";
				
				//합져진 시간이 아니고 과목정보가 있을때만 수정 가능.
				if(rowspanCnt[i][4] == 1 && !tmpFri[0][k].replace("&&", "").trim().equals("")){
					
					resultStr[i][4] += "<a href=\"javascript:go_modify('"+dayArr[4]+"', '" + gosi[i][0] + "', '" + tmpFri[0][k].replace("&&", "").trim() + "');\">";
					resultStr[i][4] += friStr;
					resultStr[i][4] += "</a>";
					
				}else
					resultStr[i][4] += friStr;
			}
			//금요일 [E]
			       
		}
		
		//비어 있을경우, 과정 학습일 일경우만  과목선택 항목으로 설정.
		for(int i=0;i < gosi.length; i++)
			for(int k=0; k < 5; k++)
				if( resultStr[i][k].trim().equals("") 
						&& DateUtil.getDaysDiff(dayArr[k], grSeqRowMap.getString("started")) >= 0
						&& DateUtil.getDaysDiff(dayArr[k], grSeqRowMap.getString("enddate")) <= 0 )
					resultStr[i][k] = "<a href=\"javascript:go_setSubj('"+dayArr[k]+"', '" + gosi[i][0] + "');\">과목선택</a>";
				else if( DateUtil.getDaysDiff(dayArr[k], grSeqRowMap.getString("started")) >= 0
						&& DateUtil.getDaysDiff(dayArr[k], grSeqRowMap.getString("enddate")) <= 0 )
					resultStr[i][k] += "<br><br><a href=\"javascript:go_addSubj('"+dayArr[k]+"', '" + subjAddStr[i][k] + "');\"><font color='blue'>과목추가</font></a>";
					
		//for(int i=0;i < gosi.length; i++)
		//	for(int k=0; k < 5; k++)			
		//		System.out.print("\n ## subjAddStr["+i+"]["+k+"]=" +subjAddStr[i][k]);
		
		// ----------------------------
		// 프린트 하는 for
		for(int i=0;i < gosi.length; i++){
			
			listStr.append("\n	<tr>");
			
			listStr.append("\n		<td style='width:6%'>"+gosi[i][1]+"</td>");
			listStr.append("\n		<td style='width:16%'>"+gosi[i][2]+"</td>");

			//월요일
			if(rowspanCnt[i][0] > 0)
				listStr.append("\n		<td style='width:16%' rowspan='" + rowspanCnt[i][0] + "'>" + resultStr[i][0] + "</td>");
			
			//화요일
			if(rowspanCnt[i][1] > 0)
				listStr.append("\n		<td style='width:16%' rowspan='" + rowspanCnt[i][1] + "'>" + resultStr[i][1] + "</td>");
			
			//수요일
			if(rowspanCnt[i][2] > 0)
				listStr.append("\n		<td style='width:16%' rowspan='" + rowspanCnt[i][2] + "'>" + resultStr[i][2] + "</td>");
			       
			//목요일 
			if(rowspanCnt[i][3] > 0)
				listStr.append("\n		<td style='width:16%' rowspan='" + rowspanCnt[i][3] + "'>" + resultStr[i][3] + "</td>");
			       
			//금요일
			if(rowspanCnt[i][4] > 0)
				listStr.append("\n		<td class='br0' style='width:16%' rowspan='" + rowspanCnt[i][4] + "'>" + resultStr[i][4] + "</td>");
			       
			listStr.append("\n	</tr>");
		}
		
	}

	

	//주차 TEXT
	String weekTextListStr = "";
	if(listMap.getInt("weekCnt") > 0){
		
		weekTextListStr += "\n<table class='tab01'>";
		weekTextListStr += "\n	<tr>";
		weekTextListStr += "\n		<td align='center'><ul class='hl01'>";
		
		for(int i=1; i <= listMap.getInt("weekCnt") ; i++){
			
			if(i > 1) 
				weekTextListStr += "<li class='hline'></li>";

			weekTextListStr += "\n	<li><a href=\"javascript:go_weekSelect("+i+");\">"+i+"주차</a></li>";
		}
		
		weekTextListStr += "\n		</ul></td>";
		weekTextListStr += "\n	</tr>";
		weekTextListStr += "\n</table>";
		
	}

	//subTitle
	String weekTextInfoStr = "";
	if(!listMap.getString("studyWeek").equals("")){
		
		weekTextInfoStr += listMap.getString("studyWeek") + " 주차 ";
		weekTextInfoStr += "(" + StringReplace.subString(listMap.getString("weekSdate"), 4, 6) + "." + StringReplace.subString(listMap.getString("weekSdate"), 6, 8);
		weekTextInfoStr += "~";
		weekTextInfoStr += StringReplace.subString(listMap.getString("weekEdate"), 4, 6) + "." + StringReplace.subString(listMap.getString("weekEdate"), 6, 8) + ")";
		
	}

%>
<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->

<script language="JavaScript" type="text/JavaScript">
<!--

//comm Selectbox선택후 리로딩 되는 함수.
function go_reload(){
	go_list();
}
function go_search(){
	go_list();
}
//리스트
function go_list(){

	$("mode").value = "list";

	pform.action = "/courseMgr/timeTable.do";
	pform.submit();

}

//주차 리스트 클릭시.
function go_weekSelect(studyWeek){

	$("studyWeek").value = studyWeek;
	go_search();
}


//과목 선택시
function go_setSubj(studydate, studytime){

	//alert([studydate, studytime]);

	$("mode").value = "form";
	$("qu").value = "insert";
	$("studydate").value = studydate;
	$("studytime").value = studytime;

	popWin("about:blank", "pop_timeForm", "600", "300", "0", "");

	pform.action = "/courseMgr/timeTable.do";
	pform.target = "pop_timeForm";
	pform.submit();
	pform.target = "";

}

//과목 수정시.
function go_modify(studydate, studytime, subj){

	$("mode").value = "form";
	$("qu").value = "update";

	$("studydate").value = studydate;
	$("studytime").value = studytime;
	$("subj").value = subj;

	popWin("about:blank", "pop_timeForm", "600", "300", "0", "");

	pform.action = "/courseMgr/timeTable.do";
	pform.target = "pop_timeForm";
	pform.submit();
	pform.target = "";
}

//과목 추가시.
function go_addSubj(studydate, studytime){

	//alert([studydate, studytime]);

	$("mode").value = "form";
	$("qu").value = "add";

	$("studydate").value = studydate;
	$("studytime").value = studytime;
	$("subj").value = "";

	popWin("about:blank", "pop_timeForm", "600", "300", "0", "");

	pform.action = "/courseMgr/timeTable.do";
	pform.target = "pop_timeForm";
	pform.submit();
	pform.target = "";

}

//시간표 초기화
function go_reset(){

	if($F("grcode") == ""){
		alert("과정을 선택해주세요");
		return;
	}
	if($F("grseq") == ""){
		alert("기수를 선택해주세요");
		return;
	}

	if(!confirm("초기화하시겠습니까? (구성되어 있는 시간표 전체가 초기화됩니다.)"))
		return;
	else {

		$("mode").value = "exec";
		$("qu").value = "delete";

		$("studydate").value = "";
		$("studytime").value = "";
		$("subj").value = "";

		pform.action = "/courseMgr/timeTable.do";
		pform.target = "";
		pform.submit();

	}
}

//시간표 확정.
function go_complete(){

	if($F("grcode") == ""){
		alert("과정을 선택해주세요");
		return;
	}
	if($F("grseq") == ""){
		alert("기수를 선택해주세요");
		return;
	}

	if( !confirm("확정하시겠습니까? (시간표상에 있는 시간이 강의(과목기수)정보의 강의시간에 셋팅됩니다.)") )
		return;
	else {

		$("mode").value = "exec";
		$("qu").value = "complete";

		$("studydate").value = "";
		$("studytime").value = "";
		$("subj").value = "";

		pform.action = "/courseMgr/timeTable.do";
		pform.target = "";
		pform.submit();

	}
}


//날짜 선택 삭제시
function go_dateDel(comaStudydate, studydate){

	if($F("grcode") == ""){
		alert("과정을 선택해주세요");
		return;
	}
	if($F("grseq") == ""){
		alert("기수를 선택해주세요");
		return;
	}

	if(!confirm(comaStudydate +"일 시간표를 초기화 시키시겠습니까?"))
		return;
	else {

		$("mode").value = "exec";
		$("qu").value = "delete_date";

		$("studydate").value = studydate;
		$("studytime").value = "";
		$("subj").value = "";

		pform.action = "/courseMgr/timeTable.do";
		pform.target = "";
		pform.submit();

	}
}

//교과목편성시간및 강사
function go_view(){

	if($F("grcode") == ""){
		alert("과정을 선택해주세요");
		return;
	}
	if($F("grseq") == ""){
		alert("기수를 선택해주세요");
		return;
	}

	var url = "/courseMgr/timeTable.do?mode=view&grcode=" + $F("grcode") + "&grseq=" + $F("grseq");
	popWin(url, "pop_timeView", "600", "500", "1", "0");

}


//시간표출력
function go_print(){

	$("mode").value = "print";
	$("qu").value = "";

	pform.action = "/courseMgr/timeTable.do";
	pform.target = "";
	pform.submit();

}



//로딩시.
onload = function()	{

	//전체/주간 구분
	var searchKey = '<%=requestMap.getString("searchKey")%>';
	$("searchKey").value = searchKey;


	//상단 Onload시 셀렉트 박스 선택.
	var commYear = "<%= requestMap.getString("commYear") %>";
	var commGrCode = "<%= requestMap.getString("commGrcode") %>";
	var commGrSeq = "<%= requestMap.getString("commGrseq") %>";
	
	//*********************** reloading 하려는 항목을 적어준다. 리로딩을 사용하지 않으면 "" 그렇지 않으면(grCode, grSeq, grSubj)
	var reloading = "grSeq"; 


	/****** body 상단의 년도, 과정, 기수, 과목등의 select box가 있을경우 밑에 내용 실행. */
	getCommYear(commYear); //년도 생성.
	getCommOnloadGrCode(reloading, commYear, commGrCode);
	getCommOnloadGrSeq(reloading, commYear, commGrCode, commGrSeq);

}

//-->
</script>
<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<form id="pform" id="pform" name="pform" method="post">
<input type="hidden" id="menuId" name="menuId"				value="<%=requestMap.getString("menuId")%>">
<input type="hidden" id="mode" name="mode"				value="<%=requestMap.getString("mode")%>">

<input type="hidden" id="qu" name="qu"					value="<%=requestMap.getString("qu")%>">

<input type="hidden" id="studyWeek" name="studyWeek"			value="<%=requestMap.getString("studyWeek")%>">

<input type="hidden" id="grcode" name="grcode"				value="<%=requestMap.getString("commGrcode")%>">
<input type="hidden" id="grseq" name="grseq"				value="<%=requestMap.getString("commGrseq")%>">

<input type="hidden" id="studydate" name="studydate"			value="">
<input type="hidden" id="studytime" name="studytime"			value="">
<input type="hidden" id="subj" name="subj"				value="">

<table cellspacing="0" cellpadding="0" border="0" width="100%" height="100%">
    <tr>
        <td width="211" height="86" valign="bottom" align="center" nowrap><img src="/images/incheon_logo.gif" width="192" height="56" border="0"></td>
        <td width="8" valign="top" nowrap><img src="/images/lefttop_bg.gif" width="8" height="86" border="0"></td>
        <td width="100%">
            <!--[s] 공통 top include -->
            <jsp:include page="/commonInc/include/commonAdminTopMenu.jsp" flush="false"/>
            <!--[e] 공통 top include -->
        </td>
    </tr>
    <tr>
        <td height="100%" valign="top" align="center" class="leftMenuIllust">
            <!--[s] 공통 Left Menu  -->
            <jsp:include page="/commonInc/include/commonAdminLeftMenu.jsp" flush="false"/>
            <!--[e] 공통 Left Menu  -->
        </td>

        <td colspan="2" valign="top" class="leftMenuBg">
          
            <!--[s] 경로 네비게이션-->
            <%= navigationStr %>            
            <!--[e] 경로 네비게이션-->
                                    
			<!--[s] 타이틀 -->
			<jsp:include page="/commonInc/include/commonAdminTitle.jsp" flush="false"/>
			<!--[e] 타이틀 -->



			<!--[s] Contents Form  -->
			<div class="h10"></div>


			<table cellspacing="0" cellpadding="0" border="0" width="100%" class="contentsTable">
				<tr>
					<td>
						<!---[s] content -->

						<!-- 검색 -->
						<table class="search01">
							<tr>
								<th width="80" class="bl0">
									년도
								</th>
								<td width="20%">
									<div id="divCommYear" class="commonDivLeft">										
										<select id="commYear" name="commYear" onChange="getCommGrCode('grSeq');" class="mr10">
											<option value="">**선택하세요**</option>
										</select>
									</div>
								</td>
								<th width="80">
									과정명
								</th>
								<td>

									<div id="divCommGrCode" class="commonDivLeft">
										<select id="commGrcode" name="commGrcode" class="mr10">
											<option value="">**선택하세요**</option>
										</select>
									</div>

								</td>
								<td width="100" class="btnr" rowspan="4">
									<input type="button" value="검색" onclick="go_search();return false;" class="boardbtn1">
								</td>
							</tr>
							<tr>
								<th class="bl0">
									기수명
								</th>
								<td>
									<div id="divCommGrSeq" class="commonDivLeft">
										<select id="commGrseq" name="commGrseq" class="mr10">
											<option value="">**선택하세요**</option>
										</select>
									</div>
								</td>
								<th class="bl0">
									구분
								</th>
								<td>
									<select id="searchKey" name="searchKey">
										<option value="MORNING">주간학습</option>
										<option value="ALL">전체학습</option>
									</select>
								</td>
						</table>
						<!--//검색 -->	
						<div class="space01"></div>


						<!-- subTitle -->
						<div class="tit01" style="padding-left:0;">
							<h2 class="h2"><img src="/images/bullet003.gif">교과운영 시간표  <%= weekTextInfoStr %></h2>
						</div>
						<div class="txtr">
							<font color=blue>(과정장: <%=grseqClassroomMap.getString("grseqmanNm")%>,  강의실: <%=grseqClassroomMap.getString("classroomName")%>)</font>
						</div>
						<!-- // subTitle -->						
						<div class="h5"></div>
						
						<!-- 주차 목록  -->
						<%= weekTextListStr %>
						<div class="space01"></div>

						<!-- [s] 상단 추가, 새로고침 버튼  -->
						<table class="btn01">
							<tr>
								<td class="left">
									
									<a href="javascript:go_reset();"><font color=blue>시간표[초기화]</font></a> 
									<a href="javascript:go_complete();"><font color=blue>시간표[확정]</font></a> 
									<a href="javascript:go_view();"><font color=blue>교과목편성시간및 강사</font></a>
									
								</td>
								<td class="right">
									<input type="button" value="강사지정" onclick="fnGoTutorSetting();" class="boardbtn1" />
									<input type="button" value="과정기수관리" onclick="fnGoCourseSeqByAdmin();" class='boardbtn1' />
									<input type="button" value="시간표 출력양식" onclick="go_print();" class='boardbtn1' />
								</td>
							</tr>
						</table>
						<!-- //[e] 상단 추가, 새로고침 버튼  -->

						<!--[s] 리스트  -->
						<table class="datah01">
							<thead>
							<tr>
								<th>교시</th>
								<th>시간/요일</th>
								<th>월<a href="javascript:go_dateDel('<%= dayOnlyComaArr[0] %>', '<%= dayArr[0] %>');" style="color:#ffffff;font-weight:bold;">ⓧ</a><%= dayComaArr[0] %></th>
								<th>화<a href="javascript:go_dateDel('<%= dayOnlyComaArr[1] %>', '<%= dayArr[1] %>');" style="color:#ffffff;font-weight:bold;">ⓧ</a><%= dayComaArr[1] %></th>
								<th>수<a href="javascript:go_dateDel('<%= dayOnlyComaArr[2] %>', '<%= dayArr[2] %>');" style="color:#ffffff;font-weight:bold;">ⓧ</a><%= dayComaArr[2] %></th>
								<th>목<a href="javascript:go_dateDel('<%= dayOnlyComaArr[3] %>', '<%= dayArr[3] %>');" style="color:#ffffff;font-weight:bold;">ⓧ</a><%= dayComaArr[3] %></th>
								<th class="br0">금<a href="javascript:go_dateDel('<%= dayOnlyComaArr[4] %>', '<%= dayArr[4] %>');" style="color:#ffffff;font-weight:bold;">ⓧ</a><%= dayComaArr[4] %></th>
							</tr>
							</thead>

							<tbody>
							<%= listStr.toString() %>
							</tbody>
						</table>
						<!--//[e] 리스트  -->		
                        
					</td>
				</tr>
			</table>
			<!--[e] Contents Form  -->

			<div class="space_ctt_bt"></div>
				                            
        </td>
    </tr>
</table>

<!--[s] bottom -->
<jsp:include page="/commonInc/include/commonAdminBottom.jsp" flush="false"/>
<!--[e] bottom -->
	
</form>
</body>

