<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 과정 안내 미리보기 팝업
// date : 2008-07-07
// auth : LYM
%>

<!-- [s] commonImport -->
<%@ include file="/commonInc/include/commonImport.jsp" %>
<!-- [e] commonImport -->

<%
    //request 데이터
	DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
	requestMap.setNullToInitialize(true);       


    //수료이력 리스트
	DataMap rowMap = (DataMap)request.getAttribute("ROW_DATA");
	rowMap.setNullToInitialize(true); 

	//과정 기수 정보.
	DataMap grseqMap = (DataMap)request.getAttribute("GRSEQ_ROW_DATA");
	grseqMap.setNullToInitialize(true);



	StringBuffer listStr = new StringBuffer(); //리스트 결과 변수.

	String rowStr = "";
	String tmpStr = "";
	String checkClassStr = "";

	//① 교과목 편성시간 및 강사
	if( rowMap.getString("guide2").equals("Y") ){

		DataMap guide2 = (DataMap)request.getAttribute("GUIDE2_DATA");
		guide2.setNullToInitialize(true);

			
		listStr.append("\n<div class='tit'><h2 class='h2'><img src='/images/bullet003.gif' /> 교과목 편성시간 및 강사</h2></div>");

		listStr.append("\n<table class='datah01'>");
		listStr.append("\n	<thead>");
		listStr.append("\n	<tr>");
		listStr.append("\n		<th colspan='2'>교과목</th>");
		listStr.append("\n		<th>시간</th>");
		listStr.append("\n		<th colspan='2'>강사</th>");
		listStr.append("\n		<th class='br0'>비고</th>");
		listStr.append("\n	</thead>");
		listStr.append("\n	<tbody>");

		if(guide2.keySize("gubun") > 0){

			//소계 및 rowSpan 을 구하기 위해.
			int[] arrCnt = {0, 0, 0, 0}; //소계0~2, 3:전체 소계
			int[] arrRowCnt = {0, 0, 0}; //
			int[] arrOutputCnt = {0, 0, 0}; //
			String[] arrRowSubj = {"", "", ""}; //
			for(int i=0; i < guide2.keySize("gubun"); i++){

				arrCnt[3] += guide2.getInt("ttime", i); //전체 소계
				if( guide2.getString("gubun", i).equals("01") ){
					arrCnt[0] += guide2.getInt("ttime", i);
					arrRowCnt[0]++;
					arrRowSubj[0] = guide2.getString("gubunnm", i);
				}else if( guide2.getString("gubun", i).equals("02") ){
					arrCnt[1] += guide2.getInt("ttime", i);
					arrRowCnt[1]++;
					arrRowSubj[1] = guide2.getString("gubunnm", i);
				}else if( guide2.getString("gubun", i).equals("03") ){
					arrCnt[2] += guide2.getInt("ttime", i);
					arrRowCnt[2]++;
					arrRowSubj[2] = guide2.getString("gubunnm", i);
				}
				
			}

			//상단 전체 소계
			listStr.append("\n	<tr>");
			listStr.append("\n		<td colspan='2'>계</td>");
			listStr.append("\n		<td>" + arrCnt[3] + "</td>");
			listStr.append("\n		<td>소속</td>");
			listStr.append("\n		<td>성명</td>");
			listStr.append("\n		<td class='br0'></td>");
			listStr.append("\n	</tr>");

			for(int i=0; i < guide2.keySize("gubun"); i++){

				if(guide2.getString("gubun", i).equals("01")){ //소양일 경우 
					
					if( arrOutputCnt[0] == 0 ){ //처음일경우 계를 찍어준다.
						arrOutputCnt[0]++;
	
						listStr.append("\n	<tr>");
						listStr.append("\n		<td rowspan='" + (arrRowCnt[0] + 1) + "'>" + arrRowSubj[0] + "</td>");
						listStr.append("\n		<td>소계</td>");
						listStr.append("\n		<td>" + arrCnt[0] + "</td>");
						listStr.append("\n		<td></td>");
						listStr.append("\n		<td></td>");
						listStr.append("\n		<td class='br0'></td>");
						listStr.append("\n	</tr>");
					}

				}else if(guide2.getString("gubun", i).equals("02")){ //직무분야

					if( arrOutputCnt[1] == 0 ){ //처음일경우 계를 찍어준다.
						arrOutputCnt[1]++;
	
						listStr.append("\n	<tr>");
						listStr.append("\n		<td rowspan='" + (arrRowCnt[1] + 1) + "'>" + arrRowSubj[1] + "</td>");
						listStr.append("\n		<td>소계</td>");
						listStr.append("\n		<td>" + arrCnt[1] + "</td>");
						listStr.append("\n		<td></td>");
						listStr.append("\n		<td></td>");
						listStr.append("\n		<td class='br0'></td>");
						listStr.append("\n	</tr>");
					}

				}else if(guide2.getString("gubun", i).equals("03")){ //행정분야

					if( arrOutputCnt[2] == 0 ){ //처음일경우 계를 찍어준다.
						arrOutputCnt[2]++;
	
						listStr.append("\n	<tr>");
						listStr.append("\n		<td rowspan='" + (arrRowCnt[2] + 1) + "'>" + arrRowSubj[2] + "</td>");
						listStr.append("\n		<td>소계</td>");
						listStr.append("\n		<td>" + arrCnt[2] + "</td>");
						listStr.append("\n		<td></td>");
						listStr.append("\n		<td></td>");
						listStr.append("\n		<td class='br0'></td>");
						listStr.append("\n	</tr>");
					}

				}

				listStr.append("\n	<tr>");
				listStr.append("\n		<td>" + guide2.getString("subjnm", i) + "</td>");
				listStr.append("\n		<td>" + guide2.getInt("ttime", i) + "</td>");
				listStr.append("\n		<td>" + guide2.getString("tposition", i) + "</td>");
				listStr.append("\n		<td>" + guide2.getString("name", i) + "</td>");
				listStr.append("\n		<td class='br0'></td>");
				listStr.append("\n	</tr>");

			} //end for

		}else{
			listStr.append("\n<tr>");
			listStr.append("\n	<td colspan='6' height='50' class='br0'>등록된 교과목 편성시간 및 강사가 없습니다.</td>");
			listStr.append("\n</tr>");
		}

		listStr.append("\n	</tbody>");
		listStr.append("\n</table>");
		listStr.append("\n<div class='space_ctt_bt'></div>");

	}

	if( rowMap.getString("guide3").equals("Y") ){ //② 교육시간표

		DataMap listMap = (DataMap)request.getAttribute("GUIDE3_DATA");
		listMap.setNullToInitialize(true);

		listStr.append("\n<div class='tit'><h2 class='h2'><img src='/images/bullet003.gif' /> 시 간 표</h2></div>");

		StringBuffer tmpListStr = new StringBuffer(); 
		if( grseqMap.getInt("weekCnt") > 0 ){


			//교시 정보
			DataMap gosiMap = (DataMap)listMap.get("GOSI_MAP");
			if(gosiMap == null) gosiMap = new DataMap();
			gosiMap.setNullToInitialize(true);


			for(int kkk = 1; kkk <= grseqMap.getInt("weekCnt") ; kkk++){

				int index = kkk-1;
				tmpListStr.append("\n<h3 class='h3'>"+kkk+"주차 시간표</h3>");



				String[] dayArr = {"", "", "", "", ""}; //상단에 표시되는 월,화,수.. 일자. ex)20080324
				String[] dayComaArr = {"", "", "", "", ""}; //상단에 표시되는 월,화,수.. 일자. ex)<br>(03.24)
				String[] dayOnlyComaArr = {"", "", "", "", ""}; //상단에 표시되는 월,화,수.. 일자. ex)03.24
				
				// 타이틀의 일자. [S]
				DataMap weekDay = (DataMap)listMap.get("WEEK_MAP", index);
				if(weekDay == null) weekDay = new DataMap();
				weekDay.setNullToInitialize(true);
				
				for(int i=0;i < weekDay.keySize("comaDay"); i++){
					dayArr[i] = weekDay.getString("day", i);
					dayComaArr[i] = "&nbsp;(" + weekDay.getString("comaDay", i) + ")";
					dayOnlyComaArr[i] = weekDay.getString("comaDay", i);
				}
				// 타이틀의 일자. [E]
				
				
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
				DataMap plan1 = (DataMap)listMap.get("TIME1_LIST_DATA", index);
				if(plan1 == null) plan1 = new DataMap();
				plan1.setNullToInitialize(true);
				
				//목, 금 요일 시간표 리스트
				DataMap plan2 = (DataMap)listMap.get("TIME2_LIST_DATA", index);
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
							resultStr[i][0] += monStr;
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
							resultStr[i][1] += tueStr;
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
							resultStr[i][2] += wedStr;
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
							resultStr[i][3] += thuStr;
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
							resultStr[i][4] += friStr;
						}else
							resultStr[i][4] += friStr;
					}
					//금요일 [E]
						   
				}
				


				tmpListStr.append("\n<table class='datah01'>");
				tmpListStr.append("\n	<thead>");
				tmpListStr.append("\n	<tr>");
				tmpListStr.append("\n		<th>교시</th>");
				tmpListStr.append("\n		<th>시간/요일</th>");
				tmpListStr.append("\n		<th>월"+dayComaArr[0]+"</th>");
				tmpListStr.append("\n		<th>화"+dayComaArr[1]+"</th>");
				tmpListStr.append("\n		<th>수"+dayComaArr[2]+"</th>");
				tmpListStr.append("\n		<th>목"+dayComaArr[3]+"</th>");
				tmpListStr.append("\n		<th>금"+dayComaArr[4]+"</th>");
				tmpListStr.append("\n	</tr>");
				tmpListStr.append("\n	</thead>");
				tmpListStr.append("\n	<tbody>");

				// ----------------------------
				// 프린트 하는 for
				for(int i=0;i < gosi.length; i++){
					
					tmpListStr.append("\n	<tr>");
					
					tmpListStr.append("\n		<td style='width:6%'>"+gosi[i][1]+"</td>");
					tmpListStr.append("\n		<td style='width:16%'>"+gosi[i][2]+"</td>");

					//월요일
					if(rowspanCnt[i][0] > 0)
						tmpListStr.append("\n		<td style='width:16%' rowspan='" + rowspanCnt[i][0] + "'>" + resultStr[i][0] + "</td>");
					//화요일
					if(rowspanCnt[i][1] > 0)
						tmpListStr.append("\n		<td style='width:16%' rowspan='" + rowspanCnt[i][1] + "'>" + resultStr[i][1] + "</td>");
					//수요일
					if(rowspanCnt[i][2] > 0)
						tmpListStr.append("\n		<td style='width:16%' rowspan='" + rowspanCnt[i][2] + "'>" + resultStr[i][2] + "</td>");
					//목요일 
					if(rowspanCnt[i][3] > 0)
						tmpListStr.append("\n		<td style='width:16%' rowspan='" + rowspanCnt[i][3] + "'>" + resultStr[i][3] + "</td>");
					//금요일
					if(rowspanCnt[i][4] > 0)
						tmpListStr.append("\n		<td class='br0' style='width:16%' rowspan='" + rowspanCnt[i][4] + "'>" + resultStr[i][4] + "</td>");
					tmpListStr.append("\n	</tr>");
				}
				tmpListStr.append("\n	</tbody>");
				tmpListStr.append("\n</table>");
				tmpListStr.append("\n<div class='space_ctt_bt'></div>");


			}//end for kkk

		}
		listStr.append(tmpListStr.toString());
		
	}

	if( rowMap.getString("guide4").equals("Y") ){ //③ 교육생(입교자)현황

		DataMap guide4 = (DataMap)request.getAttribute("GUIDE4_DATA");
		guide4.setNullToInitialize(true);

		listStr.append("\n<div class='tit'><h2 class='h2'><img src='/images/bullet003.gif' /> 교 육 생 현 황</h2></div>");

		listStr.append("\n<h3 class='h3'>1. 교육인원( 직 급 별 )</h3>");

		//부서 리스트
		DataMap deptList = (DataMap)guide4.get("DEPT_LIST_DATA");
		deptList.setNullToInitialize(true);

		//기관/계급명 CROSS 통계
		DataMap deptDogsList = (DataMap)guide4.get("DEPTDOGS_LIST_DATA");
		deptDogsList.setNullToInitialize(true);


		/** 교육인원 START */
		//기관/계급명 CROSS 통계
		String deptDogsListHeadStr = "";
		String deptDogsListBodyStr = "";

		//Hearder
		deptDogsListHeadStr += "\n<tr>";
		deptDogsListHeadStr += "\n	<th>구분</th><th>합계</th>";
		for(int i=0; i < deptList.keySize("dept"); i++){
			
			if( i == (deptList.keySize("dept")-1))
				checkClassStr = "class='br0'";
			else
				checkClassStr = "";
			
			tmpStr = StringReplace.replaceStr(deptList.getString("deptnm", i), "인천광역시 ", "");
			tmpStr = StringReplace.replaceStr(tmpStr, "인천광역", "");
			deptDogsListHeadStr += "\n	<th "+checkClassStr+">" + tmpStr + "</th>";

		} //end for
		deptDogsListHeadStr += "\n</tr>";

		
		//Body
		for(int i=0; i < deptDogsList.keySize("codenm"); i++){

			String tmpCrossStr = "";
			int deptDogsCrossTotCnt = 0;

			deptDogsListBodyStr += "\n<tr>";
			deptDogsListBodyStr += "\n	<td>"+deptDogsList.getString("codenm", i)+"</td>"; //직급구분명

			for(int j = 0; j < deptList.keySize("dept"); j++){
				deptDogsCrossTotCnt += deptDogsList.getInt("dept"+(j+1), i); //합계 count

				if( j == (deptList.keySize("dept") -1))
					checkClassStr = "class='br0'";
				else
					checkClassStr = "";
				tmpCrossStr += "\n	<td "+checkClassStr+">" + deptDogsList.getString("dept"+(j+1), i) + "</td>"; //각구별 인원수.
			}

			deptDogsListBodyStr += "\n	<td>" + deptDogsCrossTotCnt + "</td>"; //합계
			deptDogsListBodyStr += tmpCrossStr; //각구별 인원수.

			deptDogsListBodyStr += "\n</tr>";
		}
		if( deptDogsList.keySize("codenm") <= 0 ){
			deptDogsListBodyStr += "\n<tr><td colspan='100%' class='br0'>수강생이 없습니다.</td></tr>";
		}
		/** 교육인원 END */

		//교육생 현황의 1.교육인원
		listStr.append("\n<table class='datah01'>");
		listStr.append("\n	<thead>");
		listStr.append(deptDogsListHeadStr);
		listStr.append("\n	</thead>");
		listStr.append("\n	<tbody>");
		listStr.append(deptDogsListBodyStr);
		listStr.append("\n	</tbody>");
		listStr.append("\n</table>");
		listStr.append("\n<div class='space_ctt_bt'></div>");


		listStr.append("\n<h3 class='h3'>2. 직 렬 별</h3>");

		//직렬
		DataMap jikListMap = (DataMap)guide4.get("JIKR_LIST_DATA");
		jikListMap.setNullToInitialize(true);

		//직렬/계급명 CROSS 통계
		DataMap jikrDogsList = (DataMap)guide4.get("JIKRDOGS_LIST_DATA");
		jikrDogsList.setNullToInitialize(true);

		/** 직렬별 START */
		//기관/계급명 CROSS 통계
		String jikrListHeadStr = "";
		String jikrListBodyStr = "";

		//Hearder
		jikrListHeadStr += "\n<tr>";
		jikrListHeadStr += "\n	<th>구분</th><th>합계</th>";
		for(int i=0; i < jikListMap.keySize("code"); i++){
			
			if( i == (jikListMap.keySize("code")-1))
				checkClassStr = "class='br0'";
			else
				checkClassStr = "";
			
			jikrListHeadStr += "\n	<th "+checkClassStr+">" + jikListMap.getString("codenm", i) + "</th>";

		} //end for
		jikrListHeadStr += "\n	<th class='br0'>기타</th>";
		jikrListHeadStr += "\n</tr>";

		//Body
		for(int i=0; i < jikrDogsList.keySize("codenm"); i++){

			String tmpCrossStr = "";
			int jikrCrossTotCnt = 0;

			jikrListBodyStr += "\n<tr>";
			jikrListBodyStr += "\n	<td>"+jikrDogsList.getString("codenm", i)+"</td>"; //직급구분명

			for(int j = 0; j < jikListMap.keySize("code"); j++){
				jikrCrossTotCnt += jikrDogsList.getInt("jikr"+(j+1), i); //합계 count
				tmpCrossStr += "\n	<td>" + jikrDogsList.getString("jikr"+(j+1), i) + "</td>"; //각구별 인원수.
			}

			jikrListBodyStr += "\n	<td>" + (jikrCrossTotCnt + jikrDogsList.getInt("etc", i)) + "</td>"; //합계
			jikrListBodyStr += tmpCrossStr; //각구별 인원수.
			jikrListBodyStr += "\n	<td class='br0'>" + jikrDogsList.getString("etc", i)  + "</td>"; //합계

			jikrListBodyStr += "\n</tr>";
		}
		if( jikrDogsList.keySize("codenm") <= 0 ){
			jikrListBodyStr += "\n<tr><td colspan='100%' class='br0'>수강생이 없습니다.</td></tr>";
		}
		/** 직렬별 END */


		//교육생 현황의 2. 직렬별 
		listStr.append("\n<table class='datah01'>");
		listStr.append("\n	<thead>");
		listStr.append(jikrListHeadStr);
		listStr.append("\n	</thead>");
		listStr.append("\n	<tbody>");
		listStr.append(jikrListBodyStr);
		listStr.append("\n	</tbody>");
		listStr.append("\n</table>");
		listStr.append("\n<div class='space_ctt_bt'></div>");


		//교육생 현황의 3. 학 력 별 
		listStr.append("\n<h3 class='h3'>3. 학 력 별</h3>");

		DataMap schoolMap = (DataMap)guide4.get("SCHOOL_ROW_DATA");
		schoolMap.setNullToInitialize(true);

		listStr.append("\n<table class='datah01'>");
		listStr.append("\n	<thead>");
		listStr.append("\n	<tr>");
		listStr.append("\n		<th>구분</th>");
		listStr.append("\n		<th>합계</th>");
		listStr.append("\n		<th>고졸미만</th>");
		listStr.append("\n		<th>고졸</th>");
		listStr.append("\n		<th>초대졸</th>");
		listStr.append("\n		<th>대졸</th>");
		listStr.append("\n		<th>석사</th>");
		listStr.append("\n		<th>박사</th>");
		listStr.append("\n		<th class='br0'>기타</th>");
		listStr.append("\n	</tr>");
		listStr.append("\n	</thead>");
		listStr.append("\n	<tbody>");

		listStr.append("\n	<tr>");
		listStr.append("\n		<td class='bg01'>총계</td>");
		listStr.append("\n		<td>"+schoolMap.getInt("sum")+"</td>");
		listStr.append("\n		<td>"+schoolMap.getInt("06")+"</td>");
		listStr.append("\n		<td>"+schoolMap.getInt("05")+"</td>");
		listStr.append("\n		<td>"+schoolMap.getInt("04")+"</td>");
		listStr.append("\n		<td>"+schoolMap.getInt("03")+"</td>");
		listStr.append("\n		<td>"+schoolMap.getInt("02")+"</td>");
		listStr.append("\n		<td>"+schoolMap.getInt("01")+"</td>");
		listStr.append("\n		<td class='br0'>"+schoolMap.getInt("07")+"</td>");
		listStr.append("\n	</tr>");

		listStr.append("\n	</tbody>");
		listStr.append("\n</table>");
		listStr.append("\n<div class='space_ctt_bt'></div>");

		//교육생 현황의 4. 연 령 별 
		listStr.append("\n<h3 class='h3'>4. 연 령 별</h3>");

		DataMap ageRowMap = (DataMap)guide4.get("AGE_ROW_DATA");
		ageRowMap.setNullToInitialize(true);

		listStr.append("\n<table class='datah01'>");
		listStr.append("\n	<thead>");
		listStr.append("\n	<tr>");
		listStr.append("\n		<th>구분</th>");
		listStr.append("\n		<th>합계</th>");
		listStr.append("\n		<th>25세이하</th>");
		listStr.append("\n		<th>26세~30세</th>");
		listStr.append("\n		<th>31세~35세</th>");
		listStr.append("\n		<th>36세~40세</th>");
		listStr.append("\n		<th>41세~45세</th>");
		listStr.append("\n		<th>46세~50세</th>");
		listStr.append("\n		<th>51세~55세</th>");
		listStr.append("\n		<th class='br0'>56세이상</th>");
		listStr.append("\n	</tr>");
		listStr.append("\n	</thead>");

		listStr.append("\n	<tbody>");
		listStr.append("\n	<tr>");
		listStr.append("\n		<td class='bg01'>총계</td>");
		listStr.append("\n		<td>"+ageRowMap.getString("t")+"</td>");
		listStr.append("\n		<td>"+ageRowMap.getString("t1")+"</td>");
		listStr.append("\n		<td>"+ageRowMap.getString("t2")+"</td>");
		listStr.append("\n		<td>"+ageRowMap.getString("t3")+"</td>");
		listStr.append("\n		<td>"+ageRowMap.getString("t4")+"</td>");
		listStr.append("\n		<td>"+ageRowMap.getString("t5")+"</td>");
		listStr.append("\n		<td>"+ageRowMap.getString("t6")+"</td>");
		listStr.append("\n		<td>"+ageRowMap.getString("t7")+"</td>");
		listStr.append("\n		<td class='br0'>"+ageRowMap.getString("t8")+"</td>");
		listStr.append("\n	</tr>");
		listStr.append("\n	<tr>");
		listStr.append("\n		<td class='bg01'>남</td>");
		listStr.append("\n		<td>"+ageRowMap.getString("tm")+"</td>");
		listStr.append("\n		<td>"+ageRowMap.getString("m1")+"</td>");
		listStr.append("\n		<td>"+ageRowMap.getString("m2")+"</td>");
		listStr.append("\n		<td>"+ageRowMap.getString("m3")+"</td>");
		listStr.append("\n		<td>"+ageRowMap.getString("m4")+"</td>");
		listStr.append("\n		<td>"+ageRowMap.getString("m5")+"</td>");
		listStr.append("\n		<td>"+ageRowMap.getString("m6")+"</td>");
		listStr.append("\n		<td>"+ageRowMap.getString("m7")+"</td>");
		listStr.append("\n		<td class='br0'>"+ageRowMap.getString("m8")+"</td>");
		listStr.append("\n	</tr>");
		listStr.append("\n	<tr>");
		listStr.append("\n		<td class='bg01'>여</td>");
		listStr.append("\n		<td>"+ageRowMap.getString("tf")+"</td>");
		listStr.append("\n		<td>"+ageRowMap.getString("f1")+"</td>");
		listStr.append("\n		<td>"+ageRowMap.getString("f2")+"</td>");
		listStr.append("\n		<td>"+ageRowMap.getString("f3")+"</td>");
		listStr.append("\n		<td>"+ageRowMap.getString("f4")+"</td>");
		listStr.append("\n		<td>"+ageRowMap.getString("f5")+"</td>");
		listStr.append("\n		<td>"+ageRowMap.getString("f6")+"</td>");
		listStr.append("\n		<td>"+ageRowMap.getString("f7")+"</td>");
		listStr.append("\n		<td class='br0'>"+ageRowMap.getString("f8")+"</td>");
		listStr.append("\n	</tr>");
		listStr.append("\n	</tbody>");
		listStr.append("\n</table>");
		listStr.append("\n<div class='space_ctt_bt'></div>");

	}

	//④ 교육생(입교자)명단
	if( rowMap.getString("guide5").equals("Y") ){

		DataMap guide5 = (DataMap)request.getAttribute("GUIDE5_DATA");
		guide5.setNullToInitialize(true);

		listStr.append("\n<div class='tit'><h2 class='h2'><img src='/images/bullet003.gif' /> 교육생 명단</h2></div>");


		listStr.append("\n<table class='datah01'>");
		listStr.append("\n	<thead>");
		listStr.append("\n	<tr>");
		listStr.append("\n		<th>교번</th>");
		listStr.append("\n		<th>소속</th>");
		listStr.append("\n		<th>직급</th>");
		listStr.append("\n		<th>성명</th>");
		listStr.append("\n		<th>성별</th>");
		listStr.append("\n		<th class='br0'>나이</th>");
		listStr.append("\n	</tr>");
		listStr.append("\n	</thead>");
		listStr.append("\n	<tbody>");

		for(int i=0; i < guide5.keySize("userno"); i++){

			listStr.append("\n	<tr>");
			//교번
			listStr.append("\n		<td>" + guide5.getString("eduno", i) + "</td>");
			//소속
			listStr.append("\n		<td>" + guide5.getString("deptnm", i) + " " + guide5.getString("deptsub", i) + "</td>");
			//직급
			listStr.append("\n		<td>" + guide5.getString("jiknm", i) + "</td>");
			//이름
			listStr.append("\n		<td>" + guide5.getString("name", i) + "</td>");
			//성별
			listStr.append("\n		<td>" + guide5.getString("sex", i) + "</td>");
			//나이
			listStr.append("\n		<td>" + guide5.getString("age", i) + "</td>");
			listStr.append("\n	</tr>");

		}

		if( guide5.keySize("userno") <= 0){

			listStr.append("\n<tr>");
			listStr.append("\n	<td colspan='6' height='50' class='br0'>교육생이 없습니다.</td>");
			listStr.append("\n</tr>");

		}


		listStr.append("\n	</tbody>");
		listStr.append("\n</table>");
		listStr.append("\n<div class='space_ctt_bt'></div>");

	}


	String grcodenm = grseqMap.getString("grcodeniknm") + " " + StringReplace.subString(grseqMap.getString("grseq"), 4, 6) + "기";

%>


						
<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->
<script language="JavaScript">
<!--



//-->
</script>
<script language="JavaScript" src="/AIViewer/AIScript.js"></script>

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<form id="pform" name="pform" method="post">
<input type="hidden" name="menuId"				value="<%=requestMap.getString("menuId")%>">
<input type="hidden" name="mode"				value="<%=requestMap.getString("mode")%>">

<input type="hidden" name="qu"					value='<%=requestMap.getString("qu")%>'>

<table class="pop01">
	<tr>
		<td class="titarea">
			<!-- 타이틀영역 -->
			<div class="tit">
				<h1 class="h1"><img src="/images/bullet_pop.gif" /> 과정안내문 미리보기</h1>
			</div>
			<!--// 타이틀영역 -->
		</td>
	</tr>
	<tr>
		<td class="con">

			<%= listStr.toString() %>

			<!-- 하단 닫기 버튼  -->
			<table class="btn02">
				<tr>
					<td class="center">
						<input type="button" value="닫기" onclick="javascript:window.close();" class="boardbtn1">
					</td>
				</tr>
			</table>
			<!--// 하단 닫기 버튼  -->
		</td>
	</tr>
</table>

</form>
<script language="JavaScript">
  document.write(tagAIGeneratorOcx);
</script>

</body>
