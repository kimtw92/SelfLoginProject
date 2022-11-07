<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 외래강사 수당관리 리스트
// date  : 2008-07-18
// auth  : 정윤철
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
	
	//리스트 데이터
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	listMap.setNullToInitialize(true);
	
	//주민번호와 날짜 데이터맵
	DataMap resNoDateMap = null;
	resNoDateMap = new DataMap();
	resNoDateMap.setNullToInitialize(true);
	
	//과정소계  데이터
	DataMap courseListMap = (DataMap)request.getAttribute("COURSTLIST_DATA");
	courseListMap.setNullToInitialize(true);
	//리스트
	StringBuffer html = new StringBuffer();
	
	//과정소계 셀렉트박스
	StringBuffer option = new StringBuffer();
	//총계
	double totalMoney = 0;
	double totalStax = 0;
	double totalJtax = 0;
	double totalRealMoney = 0;
	double totalAllTax = 0;
	int seq = 0;
	StringBuffer subMenu = new StringBuffer();
	
	//각각의 검색조건마다 항목이 달라진다. 
	if(requestMap.getString("salaryType").equals("cyber")){
		//사이버 강사모드
		subMenu.append("<tr bgcolor=\"#5071B4\">");
		subMenu.append("<td height=\"28\"class=\"tableline11 white\" align = center rowspan = 2><input type = checkbox id=\"chk\" name = \"checkType\" onclick=\"go_check()\"></td>");
		subMenu.append("	<td height=\"28\"class=\"tableline11 white\"align = center rowspan = 2><b>연번</td>");
		subMenu.append("	<td height=\"28\"class=\"tableline11 white\"align = center rowspan = 2><b>소속및직위</td>");
		subMenu.append("	<td height=\"28\"class=\"tableline11 white\"align = center rowspan = 2 width=\"50\"><b>성명</td>");
		subMenu.append("	<td height=\"28\"class=\"tableline11 white\"align = center rowspan = 2><b>주소</td>");
		subMenu.append("	<td height=\"28\"class=\"tableline11 white\"align = center rowspan = 2><b>주민번호</td>");
		subMenu.append("	<td height=\"28\"class=\"tableline11 white\"align = center colspan = 4><b>사이버강사료</td>");
		subMenu.append("	<td height=\"28\"class=\"tableline11 white\"align = center colspan = 3><b>세금공제액</td>");
		subMenu.append("	<td height=\"28\"class=\"tableline11 white\"align = center rowspan = 2><b>실지급액</td>");
		subMenu.append("	<td height=\"28\"class=\"tableline11 white\"align = center rowspan = 2><b>계좌번호</td>");
		subMenu.append("	<td height=\"28\"class=\"tableline11 white\"align = center rowspan = 2><b>과정명</td>");
		subMenu.append("	<td height=\"28\"class=\"tableline11 white\"align = center rowspan = 2><b>강의과목</td>");
		
		if(requestMap.getString("gubun").equals("N")){
			subMenu.append("	<td height=\"28\"class=\"tableline11 white\"align = center rowspan = 2><b>총회차</td>");
			subMenu.append("	<td height=\"28\"class=\"tableline11 white\"align = center rowspan = 2><b>산출<br>근거</td>");
			
		}
		
		subMenu.append("</tr>");
		
		subMenu.append("<tr bgcolor=\"#5071B4\">");
		subMenu.append("	<td height=\"28\"class=\"tableline11 white\"align = center><b>계</td>");
		subMenu.append("	<td height=\"28\"class=\"tableline11 white\"align = center><b>강사료</td>");
		subMenu.append("	<td height=\"28\"class=\"tableline11 white\"align = center><b>과제물</td>");
		subMenu.append("	<td height=\"28\"class=\"tableline11 white\"align = center><b>질의응답</td>");
		subMenu.append("	<td height=\"28\"class=\"tableline11 white\"align = center><b>계</td>");
		subMenu.append("	<td height=\"28\"class=\"tableline11 white\"align = center><b>소득세</td>");
		subMenu.append("	<td height=\"28\"class=\"tableline11 white\"align = center><b>주민세</td>");
		subMenu.append("</tr>");
		
	}else if(requestMap.getString("salaryType").equals("collec") ){
		//집합강사모드
		subMenu.append("<tr bgcolor=\"#5071B4\">");
		subMenu.append("<td height=\"28\"class=\"tableline11 white\"align = center rowspan = 2><input type = checkbox onclick=\"go_check()\" id=\"chk\" name = \"checkType\"></td>");
		subMenu.append("	<td height=\"28\"class=\"tableline11 white\"align = center rowspan = 2><b>연번</td>");
		subMenu.append("	<td height=\"28\"class=\"tableline11 white\"align = center rowspan = 2><b>소속및직위</td>");
		subMenu.append("	<td height=\"28\"class=\"tableline11 white\"align = center rowspan = 2 width=\"50\"><b>성명</td>");
		subMenu.append("	<td height=\"28\"class=\"tableline11 white\"align = center rowspan = 2><b>주소</td>");
		subMenu.append("	<td height=\"28\"class=\"tableline11 white\"align = center rowspan = 2><b>주민<br>번호</td>");
		subMenu.append("	<td height=\"28\"class=\"tableline11 white\"align = center rowspan = 2><b>강사료</td>");
		subMenu.append("	<td height=\"28\"class=\"tableline11 white\"align = center colspan = 3><b>세금공제액</td>");
		subMenu.append("	<td height=\"28\"class=\"tableline11 white\"align = center rowspan = 2><b>실지급액</td>");
		subMenu.append("	<td height=\"28\"class=\"tableline11 white\"align = center rowspan = 2><b>계좌번호</td>");
		subMenu.append("	<td height=\"28\"class=\"tableline11 white\"align = center rowspan = 2><b>과정명</td>");
		subMenu.append("	<td height=\"28\"class=\"tableline11 white\"align = center rowspan = 2><b>강의과목</td>");
		subMenu.append("	<td height=\"28\"class=\"tableline11 white\"align = center rowspan = 2><b>강의일자</td>");
		subMenu.append("	<td height=\"28\"class=\"tableline11 white\"align = center rowspan = 2><b>교시</td>");
		if(requestMap.getString("gubun").equals("N")){
			subMenu.append("	<td height=\"28\"class=\"tableline11 white\"align = center rowspan = 2><b>산출근거</td>");
			
		}
		subMenu.append("</tr>");
		
		subMenu.append("<tr bgcolor=\"#5071B4\">");
		subMenu.append("	<td height=\"28\"class=\"tableline11 white\"align = center><b>계</td>");
		subMenu.append("	<td height=\"28\"class=\"tableline11 white\"align = center><b>소득세</td>");
		subMenu.append("	<td height=\"28\"class=\"tableline11 white\"align = center><b>주민세</td>");
		subMenu.append("</tr>");
		
	}else if(requestMap.getString("salaryType").equals("exam")){
		//출제료 모드
		subMenu.append("<tr bgcolor=\"#5071B4\">");
		subMenu.append("<td height=\"28\" class=\"tableline11 white\" align = center rowspan = 2><input type = checkbox onclick=\"go_check()\" id=\"chk\" name=\"checkType\"></td>");
		subMenu.append("	<td height=\"28\" class=\"tableline11 white\" align = center rowspan = 2><b>연번</td>");
		subMenu.append("	<td height=\"28\" class=\"tableline11 white\" align = center rowspan = 2><b>소속및직위</td>");
		subMenu.append("	<td height=\"28\" class=\"tableline11 white\" align = center rowspan = 2><b>성명</td>");
		subMenu.append("	<td height=\"28\" class=\"tableline11 white\" align = center rowspan = 2><b>주소</td>");
		subMenu.append("	<td height=\"28\" class=\"tableline11 white\" align = center rowspan = 2><b>주민번호</td>");
		subMenu.append("	<td height=\"28\" class=\"tableline11 white\" align = center rowspan = 2><b>객관식</td>");
		subMenu.append("	<td height=\"28\" class=\"tableline11 white\" align = center rowspan = 2><b>주관식</td>");
		subMenu.append("	<td height=\"28\" class=\"tableline11 white\" align = center rowspan = 2><b>출제료</td>");
		subMenu.append("	<td height=\"28\" class=\"tableline11 white\" align = center colspan = 3><b>세금공제액</td>");
		subMenu.append("	<td height=\"28\" class=\"tableline11 white\" align = center rowspan = 2><b>실지급액</td>");
		subMenu.append("	<td height=\"28\" class=\"tableline11 white\" align = center rowspan = 2><b>계좌번호</td>");
		subMenu.append("	<td height=\"28\" class=\"tableline11 white\" align = center rowspan = 2><b>과정명</td>");
		subMenu.append("	<td height=\"28\" class=\"tableline11 white\" align = center rowspan = 2><b>강의과목</td>");
		subMenu.append("</tr>");
		subMenu.append("<tr bgcolor=\"#5071B4\">");
		subMenu.append("	<td height=\"28\" class=\"tableline11 white\" align = center><b>계</td>");
		subMenu.append("	<td height=\"28\" class=\"tableline11 white\" align = center><b>소득세</td>");
		subMenu.append("	<td height=\"28\" class=\"tableline11 white\" align = center><b>주민세</td>");
		subMenu.append("</tr>");
		
	}else if(requestMap.getString("salaryType").equals("copyPay")){
		//원고료 모드
		subMenu.append("<tr bgcolor=\"#5071B4\">");
		subMenu.append("	<td height=\"28\" class=\"tableline11 white\" align = center rowspan = 2><input type =checkbox onclick=\"go_check()\" id=\"chk\" name=\"checkType\"></td>");
		subMenu.append("	<td height=\"28\" class=\"tableline11 white\" align = center rowspan = 2><b>연번</td>");
		subMenu.append("	<td height=\"28\" class=\"tableline11 white\" align = center rowspan = 2><b>소속및직위</td>");
		subMenu.append("	<td height=\"28\" class=\"tableline11 white\" align = center rowspan = 2><b>성명</td>");
		subMenu.append("	<td height=\"28\" class=\"tableline11 white\" align = center rowspan = 2><b>주소</td>");
		subMenu.append("	<td height=\"28\" class=\"tableline11 white\" align = center rowspan = 2><b>주민번호</td>");
		subMenu.append("	<td height=\"28\" class=\"tableline11 white\" align = center rowspan = 2><b>원고</td>");
		subMenu.append("	<td height=\"28\" class=\"tableline11 white\" align = center rowspan = 2><b>원고료</td>");
		subMenu.append("	<td height=\"28\" class=\"tableline11 white\" align = center colspan = 3><b>세금공제액</td>");
		subMenu.append("	<td height=\"28\" class=\"tableline11 white\" align = center rowspan = 2><b>실지급액</td>");
		subMenu.append("	<td height=\"28\" class=\"tableline11 white\" align = center rowspan = 2><b>계좌번호</td>");
		subMenu.append("	<td height=\"28\" class=\"tableline11 white\" align = center rowspan = 2><b>과정명</td>");
		subMenu.append("	<td height=\"28\" class=\"tableline11 white\" align = center rowspan = 2><b>강의과목</td>");
		subMenu.append("	<td height=\"28\" class=\"tableline11 white\" align = center rowspan = 2><b>원고제출일자</td>");
		subMenu.append("</tr>");
		subMenu.append("<tr bgcolor=\"#5071B4\">");
		subMenu.append("	<td height=\"28\" class=\"tableline11 white\" align = center><b>계</td>");
		subMenu.append("	<td height=\"28\" class=\"tableline11 white\" align = center><b>소득세</td>");
		subMenu.append("	<td height=\"28\" class=\"tableline11 white\" align = center><b>주민세</td>");
		subMenu.append("</tr>");
		
	}
	
	
	
	
	
	int cnt = 0;
	if(listMap.keySize("userno") > 0){
		//집합강사이면서 비고1이 같은날 두개 일경우 계산을 해준다.
		// 계산법은 1 * 2000 이라면 1은 +1을 해주고 2000은 1을 더한값을 곱해준다.
		
		if(requestMap.getString("salaryType").equals("collec") && requestMap.getString("gubun").equals("N")){
			//집합 강사모드
			DataMap tmpMap = new DataMap();
			tmpMap.setNullToInitialize(true);
			
			for(int i=0; i < listMap.keySize("userno"); i++){
				
				String tmpBigo1 = listMap.getString("bigo1", i);
				String tmpBigo2 = listMap.getString("bigo2", i);
				double tmpMoney = Double.parseDouble(listMap.getString("money", i));
				
				boolean isIn = false;
				for(int y=0; y < tmpMap.keySize("aaaa");y++)
					if(tmpMap.getString("aaaa", y).equals(listMap.getString("resno", i) + listMap.getString("studydate", i)))
						isIn = true;
				
				if(isIn){
					tmpBigo1 = "";
					String[] tmpBigo2Str = listMap.getString("bigo2", i).split("[*]");

					tmpBigo2 = (Integer.parseInt(Util.getValue(tmpBigo2Str[0], "0")) + 1) + "*" + Util.getValue(tmpBigo2Str[1], "0");
					tmpMoney = (Integer.parseInt(Util.getValue(tmpBigo2Str[0], "0")) + 1) * Double.parseDouble(tmpBigo2Str[1]);

				}else{
					tmpMap.addString("aaaa", listMap.getString("resno", i) + listMap.getString("studydate", i));
					
				}
				
				listMap.addString("calBigo1", tmpBigo1);
				listMap.addString("calBigo2", tmpBigo2);
				listMap.addString("calMoney", Double.toString(tmpMoney));
				
			}
			
		}
		
		for(int i=0; i < listMap.keySize("userno"); i++){
			
			
			int rowCnt = 1;//밑에 row수
			int rowCnt2 = 0; //hidden인지 확인.
			
			//각각의 금액들관련 변수 선언
			double money = 0;
			double stax = 0;
			double jtax = 0;
			double totalTax = 0;
			double realmoney = 0;
			double tmoney = 0;
			double rmoney = 0;
			double qmoney = 0;
			
			if(requestMap.getString("salaryType").equals("collec")){
				
				totalMoney += Double.parseDouble(listMap.getString("calMoney", i));
					//집합강사모드일경우
					money = Double.parseDouble(listMap.getString("calMoney", i));
					if(i > seq || seq == 0){
						for(int j = (i+1); j < listMap.keySize("userno"); j++){//리스트사이즈만큼 루프
							if(listMap.getString("userno",i).equals(listMap.getString("userno", j))){//현재 번호와 두번째 루프의 유저 넘버가 같을경우.
			
								rowCnt++;
								money += Double.parseDouble(listMap.getString("calMoney", j));
								
								if(money >= 250000){	
									//현재 돈이 25만원이상일경우
									stax = money * 0.04;
									jtax = stax * 0.1;
									totalTax = stax + jtax;
									
								}else{
									//아닐경우 세금관련 금액 초기화
									stax = 0;
									jtax = 0;
									totalTax = 0;
									
								}
								seq = j;
							}
						}
					}
					//실금액은 전체 금액에 세금액을 뺀 금액이다.
					realmoney = money - totalTax;
					
					for(int j = i; j >= 0; j--)
						if(listMap.getString("userno", i).equals(listMap.getString("userno", j)))
							rowCnt2++;
					
					listMap.addInt("rowCnt", rowCnt);
					listMap.addInt("rowCnt2", rowCnt2);
					listMap.addDouble("sumMoney", money);
					listMap.addDouble("sumStax", stax);
					listMap.addDouble("sumJtax", jtax);
					listMap.addDouble("sumTotalTax", totalTax);
					listMap.addDouble("sumRealmoney", realmoney);
					
					totalRealMoney += realmoney;
				
					
			}else if(requestMap.getString("salaryType").equals("cyber")){
				rowCnt= 0;
				//사이버 모드
				for(int j = 0; j < listMap.keySize("userno"); j++){//리스트사이즈만큼 루프
					
					if(listMap.getString("userno",i).equals(listMap.getString("userno", j))){//현재 번호와 두번째 루프의 유저 넘버가 같을경우.

						rowCnt++;
						
						if(!listMap.getString("totalmoney", j).equals("")){
							tmoney += Double.parseDouble(listMap.getString("totalmoney",j));
							
						}else{
							tmoney += 0;
							
						}
						
						
						rmoney += listMap.getInt("rptMoney", j);
						qmoney += listMap.getInt("qnaMoney", j);
						
						if(tmoney > 250000){
							stax = tmoney * 0.04;
							jtax = stax * 0.1;
							totalTax = stax + jtax;
						}else{
							stax = 0;
							jtax = 0;
							totalTax = 0;
						}
						realmoney = tmoney - totalTax;
						
					}
				}

				for(int j = i; j >= 0; j--)
					if(listMap.getString("userno", i).equals(listMap.getString("userno", j)))
						rowCnt2++;
				
				listMap.addInt("rowCnt", rowCnt);
				listMap.addInt("rowCnt2", rowCnt2);
				listMap.addDouble("sumMoney", tmoney);
				listMap.addDouble("sumStax", stax);
				listMap.addDouble("sumJtax", jtax);
				listMap.addDouble("sumTotalTax", totalTax);
				listMap.addDouble("sumRealmoney", realmoney);
				
				listMap.addDouble("tmoney", tmoney-rmoney);
				
				listMap.addDouble("rmoney", rmoney);
				listMap.addDouble("qnaMoney", qmoney);
			
				}else if(requestMap.getString("salaryType").equals("copyPay")){
					for(int j = 0; j < listMap.keySize("userno"); j++){//리스트사이즈만큼 루프
						
						if(listMap.getString("userno",i).equals(listMap.getString("userno", j))){//현재 번호와 두번째 루프의 유저 넘버가 같을경우.

							rowCnt++;
							
							if(!listMap.getString("money", j).equals("")){
								money += Double.parseDouble(listMap.getString("money", j));
								
							}else{
								money += 0;
								
							}
							
							if(tmoney > 250000){
								stax = money * 0.04;
								jtax = stax * 0.1;
								totalTax = stax + jtax;
							}else{
								stax = 0;
								jtax = 0;
								totalTax = 0;
							}
							realmoney = tmoney - totalTax;
							
						}
					}
					
					for(int j = i; j >= 0; j--)
						if(listMap.getString("userno", i).equals(listMap.getString("userno", j)))
							rowCnt2++;
					
					listMap.addDouble("sumMoney", money);
					listMap.addDouble("sumStax", stax);
					listMap.addDouble("sumJtax", jtax);
					listMap.addDouble("sumTotalTax", totalTax);
					listMap.addDouble("sumRealmoney", realmoney);
					
					
					listMap.addDouble("tmoney", tmoney);
					listMap.addDouble("rmoney", rmoney);
					listMap.addDouble("qnaMoney", qmoney);
				
					}else if(requestMap.getString("salaryType").equals("exam")){
						for(int j = 0; j < listMap.keySize("userno"); j++){//리스트사이즈만큼 루프
							
							if(listMap.getString("userno",i).equals(listMap.getString("userno", j))){//현재 번호와 두번째 루프의 유저 넘버가 같을경우.

								rowCnt++;
								
								if(!listMap.getString("money", j).equals("")){
									money += Double.parseDouble(listMap.getString("money", j));
									
								}else{
									money += 0;
									
								}
								
								if(tmoney > 250000){
									stax = money * 0.04;
									jtax = stax * 0.1;
									totalTax = stax + jtax;
								}else{
									stax = 0;
									jtax = 0;
									totalTax = 0;
								}
								
								realmoney = tmoney - totalTax;
							}
						}
						
						//5
						for(int j = i; j >= 0; j--)
							if(listMap.getString("userno", i).equals(listMap.getString("userno", j)))
								rowCnt2++;
						
						
						listMap.addDouble("sumMoney", money);
						listMap.addDouble("sumStax", stax);
						listMap.addDouble("sumJtax", jtax);
						listMap.addDouble("sumTotalTax", totalTax);
						listMap.addDouble("sumRealmoney", realmoney);
						listMap.addDouble("tmoney", tmoney);
						listMap.addDouble("rmoney", rmoney);
						listMap.addDouble("qnaMoney", qmoney);
					
						}

			//모든 금액 관련

			totalStax += listMap.getDouble("sumStax",i);
			totalJtax += listMap.getDouble("sumJtax",i);
			totalAllTax += listMap.getDouble("sumTotalTax",i);
			}
		
		int size = 0;
		for(int i=0; i < listMap.keySize("userno"); i++){
			
			if(requestMap.getString("salaryType").equals("collec")){
				html.append("\n	<tr>");
				
				
				if(listMap.getInt("rowCnt2", i) <= 1){ //처음 이면 
					
					//checkBox
					html.append("\n		<td rowspan='"+listMap.getString("rowCnt",i)+"' align=\"center\"><input type=\"checkbox\" name=\"sel\" id=\"chkbox_"+i+"\" value=\""+listMap.getString("userno",i)+"\"></td>");
				
					//연번
					html.append("\n		<td rowspan='"+listMap.getString("rowCnt",i)+"' align=\"center\">"+ size +"</td>");
					
					//소속 및 직위
					html.append("\n		<td rowspan='"+listMap.getString("rowCnt",i)+"' align=\"center\">" + listMap.getString("tposition", i)+"<br>" + listMap.getString("jikwi", i) + "&nbsp;</td>");
					
					//성명
					html.append("\n		<td rowspan='"+listMap.getString("rowCnt",i)+"' align=\"center\">" + listMap.getString("name", i) + "&nbsp;</td>");
					
					//주소
					html.append("\n		<td rowspan='"+listMap.getString("rowCnt",i)+"' align=\"center\">"+(listMap.getString("homeAddr", i).equals("") ? "&nbsp" : listMap.getString("homeAddr",i) )+"</td>");
					//주민번호
					html.append("\n		<td rowspan='"+listMap.getString("rowCnt",i)+"' align=\"center\">"+(listMap.getString("resno", i).equals("") ? "&nbsp" : listMap.getString("resno", i) )+"</td>");
					
					//강사료
					html.append("\n		<td rowspan='"+listMap.getString("rowCnt",i)+"' align=\"center\">");
					
					if(requestMap.getString("gubun").equals("Y")){
						html.append(NumConv.setComma(Math.round(listMap.getDouble("sumMoney", i))));
					}else{
						html.append("\n		<input type=\"checkbox\" name=\"chk2\" id=\"chk2_"+cnt+"\" onclick=\"check('price_"+cnt+"');\" value=\""+listMap.getString("userno",i)+"\"><font color=\"red\"><b>수동지정</b>");
						html.append("\n		<input type=\"text\" name=\"price\" id=\"price_"+cnt+"\" value=\""+NumConv.setComma(Math.round(listMap.getDouble("sumMoney", i)))+"\" size=8 disabled>");
						
					}
					
					html.append("</td>");
					
					//세금 공재
					html.append("\n		<td rowspan='"+listMap.getString("rowCnt",i)+"' align=\"center\">"+NumConv.setComma(Math.round(listMap.getDouble("sumTotalTax", i)))+"</td>");
					html.append("\n		<td rowspan='"+listMap.getString("rowCnt",i)+"' align=\"center\">"+NumConv.setComma(Math.round(listMap.getDouble("sumStax", i)))+"</td>");
					html.append("\n		<td rowspan='"+listMap.getString("rowCnt",i)+"' align=\"center\">"+NumConv.setComma(Math.round(listMap.getDouble("sumJtax", i)))+"</td>");
	
					//실지급액
					html.append("\n		<td rowspan='"+listMap.getString("rowCnt",i)+"' align=\"center\">"+NumConv.setComma(Math.round(listMap.getDouble("sumRealmoney", i)))+"</td>");
					//계좌번호
					html.append("\n		<td rowspan='"+listMap.getString("rowCnt",i)+"' align=\"center\">"+ listMap.getString("bankname", i) + "<br>"+listMap.getString("bankno", i)+"&nbsp;</td>");
					
					size++;
				}
		
	
				html.append("\n		<td align=\"center\">"+listMap.getInt("rowCnt2", i) + listMap.getString("grcodenm",i)+"</td>");
				html.append("\n		<td align=\"center\">"+listMap.getString("lecnm",i)+"</td>");
				html.append("\n		<td align=\"center\">"+listMap.getString("studydate",i)+"</td>");
				
				if(requestMap.getString("gubun").equals("N")){
					html.append("\n		<td align=\"center\">"+listMap.getString("studytime",i)+"</td>");	
				}else{
					html.append("\n		<td align=\"center\" class=\"br0\">"+listMap.getString("studytime",i)+"</td>");	
				}
				
				
				if(requestMap.getString("gubun").equals("N")){
					String[] biogo1 = null;
					String[] biogo2 = null;
					html.append("<td class=\"br0\">");
					biogo1 = listMap.getString("calBigo1", i).split("[*]");
					biogo2 = listMap.getString("calBigo2", i).split("[*]");

					try{
						
						
						if(Integer.parseInt(biogo1[0]) > 0){
							html.append(listMap.getString("calBigo1", i));
							html.append("<br>");
						}
						
					}catch (Exception e) {
						
					}

						
					try{
						if(Integer.parseInt(biogo2[0]) > 0){
							html.append(listMap.getString("calBigo2",i));
						}
						
					}catch (Exception e){
						
					}
					
					html.append("</td>");
				}
				
				html.append("</tr>");
				cnt++;
				
				
			}else if(requestMap.getString("salaryType").equals("cyber")){
				
				if(listMap.getString("count").equals("")){
					cnt++;
					html.append("\n	<tr>");
					
					if(listMap.getInt("rowCnt2", i) <= 1){ //처음 이면 
						size++;
						//checkBox
						html.append("\n		<td rowspan='"+listMap.getString("rowCnt",i)+"' align=\"center\"><input type=\"checkbox\" name=\"sel\" id=\"chkbox_"+i+"\" value=\""+listMap.getString("userno",i)+"\"></td>");
					
						//연번
						html.append("\n		<td rowspan='"+listMap.getString("rowCnt",i)+"' align=\"center\">"+ size +"</td>");
						
						//소속 및 직위
						html.append("\n		<td rowspan='"+listMap.getString("rowCnt",i)+"' align=\"center\">" + listMap.getString("tposition", i)+"<br>" + listMap.getString("jikwi", i) + "&nbsp;</td>");
						
						//성명
						html.append("\n		<td rowspan='"+listMap.getString("rowCnt",i)+"' align=\"center\">" + listMap.getString("name", i)+ "&nbsp;</td>");
						
						//주소
						html.append("\n		<td rowspan='"+listMap.getString("rowCnt",i)+"' align=\"center\">"+(listMap.getString("homeAddr", i).equals("") ? "&nbsp" : listMap.getString("homeAddr",i) )+"</td>");
						//주민번호
						html.append("\n		<td rowspan='"+listMap.getString("rowCnt",i)+"' align=\"center\">"+(listMap.getString("resno", i).equals("") ? "&nbsp" : listMap.getString("resno", i) )+"</td>");

						html.append("\n		<td align=\"center\" rowspan='"+listMap.getString("rowCnt",i)+"'>"+NumConv.setComma(Math.round(listMap.getDouble("sumMoney", i)))+"</td>");
						html.append("\n		<td align=\"center\" rowspan='"+listMap.getString("rowCnt",i)+"'>"+NumConv.setComma(Math.round(listMap.getDouble("tmoney", i)))+"</td>");
						html.append("\n		<td align=\"center\" rowspan='"+listMap.getString("rowCnt",i)+"'>"+NumConv.setComma(Math.round(listMap.getDouble("rmoney", i)))+"</td>");
						html.append("\n		<td align=\"center\" rowspan='"+listMap.getString("rowCnt",i)+"'>"+NumConv.setComma(Math.round(listMap.getDouble("qmoney", i)))+"</td>");
						
						//세금 공재
						html.append("\n		<td align=\"center\" rowspan='"+listMap.getString("rowCnt",i)+"'>"+NumConv.setComma(Math.round(listMap.getDouble("sumTotalTax", i)))+"</td>");
						html.append("\n		<td align=\"center\" rowspan='"+listMap.getString("rowCnt",i)+"'>"+NumConv.setComma(Math.round(listMap.getDouble("sumStax", i)))+"</td>");
						html.append("\n		<td align=\"center\" rowspan='"+listMap.getString("rowCnt",i)+"'>"+NumConv.setComma(Math.round(listMap.getDouble("sumJtax", i)))+"</td>");
						//실지급액
						html.append("\n		<td rowspan='"+listMap.getString("rowCnt",i)+"' align=\"center\">"+NumConv.setComma(Math.round(listMap.getDouble("sumRealmoney", i)))+"</td>");
						//계좌번호
						html.append("\n		<td rowspan='"+listMap.getString("rowCnt",i)+"' align=\"center\">"+ listMap.getString("bankname", i) + "<br>"+listMap.getString("bankno", i)+"&nbsp;</td>");

						//html.append("\n		<td align=\"center\" rowspan='"+listMap.getString("rowCnt",i)+"'>"+NumConv.setComma(Math.round(listMap.getDouble("sumJtax", i)))+"</td>");
					}
					
		
					html.append("\n		<td align=\"center\" >" + listMap.getString("grcodenm",i)+"</td>");
					html.append("\n		<td align=\"center\">"+listMap.getString("lecnm",i)+"</td>");
					
					//구분이 N일경우 br0를 넣어주지안는다 Y일경우 티디박스는 총회박스에서 끝이난다.
					if(requestMap.getString("gubun").equals("N")){
						html.append("\n		<td align=\"center\">"+listMap.getString("datesCnt",i)+"</td>");
						
					}else{
						html.append("\n		<td align=\"center\" class=\"br0\">"+listMap.getString("datesCnt",i)+"</td>");	
						
					}

					if(requestMap.getString("gubun").equals("N")){
						html.append("	<td class=\"br0\">");
							html.append(	listMap.getString("bigo1", i));
							html.append("	<br>");
							html.append(	listMap.getString("bigo2", i));
						html.append("	</td>");	

					}
					
					html.append("</tr>");
				}else{
					html.append("<tr>");
					html.append("	<td align=\"center\" colspan=\"100%\" class=\"tableline21 br0\" style=\"height:100px\">"+listMap.getString("content")+"</td>");
					html.append("</tr>");
				}
				
				
			}else if(requestMap.getString("salaryType").equals("copyPay")){
				cnt++;
					html.append("\n	<tr>");
					if(listMap.getInt("rowCnt2", i) <= 1){ //처음 이면 
						
						html.append("\n	<tr>");
						html.append("\n		<td rowspan='"+listMap.getString("rowCnt",i)+"' align=\"center\"><input type=\"checkbox\" name=\"sel\" id=\"chkbox_"+i+"\" value=\""+listMap.getString("userno",i)+"\"></td>");
						html.append("\n		<td rowspan='"+listMap.getString("rowCnt",i)+"' align=\"center\">"+cnt+"</td>");
						html.append("\n		<td rowspan='"+listMap.getString("rowCnt",i)+"' align=\"center\">"+(listMap.getString("tposition", i).equals("") ? "&nbsp;" : listMap.getString("tposition",i)));
						html.append("\n		<td rowspan='"+listMap.getString("rowCnt",i)+"' align=\"center\">"+(listMap.getString("name", i).equals("") ? "&nbsp;" : listMap.getString("name",i) )+"</td>");
						html.append("\n		<td rowspan='"+listMap.getString("rowCnt",i)+"' align=\"center\">"+(listMap.getString("homeAddr", i).equals("") ? "&nbsp;" : listMap.getString("homeAddr",i) )+"</td>");
						html.append("\n		<td rowspan='"+listMap.getString("rowCnt",i)+"' align=\"center\">"+(listMap.getString("resno", i).equals("") ? "&nbsp;" : listMap.getString("resno", i) )+"</td>");
										
					}
					
					html.append("\n		<td align=\"center\"><a href=\"javascript:fileUpload('"+listMap.getString("userno", i)+"', '"+listMap.getString("groupfileNo", i)+"')\">"+listMap.getString("pCnt", i)+"장</td>");
					
					
					if(requestMap.getString("gubun").equals("Y")){
						html.append("\n		<td rowspan='"+listMap.getString("rowCnt",i)+"' align=\"center\">"+NumConv.setComma(Math.round(listMap.getDouble("sumMoney", i)))+"</td>");
						html.append("\n		<td rowspan='"+listMap.getString("rowCnt",i)+"' align=\"center\">"+NumConv.setComma(Math.round(listMap.getDouble("sumTotalTax", i)))+"</td>");
						html.append("\n		<td rowspan='"+listMap.getString("rowCnt",i)+"' align=\"center\">"+NumConv.setComma(Math.round(listMap.getDouble("sumStax", i)))+"</td>");
						html.append("\n		<td rowspan='"+listMap.getString("rowCnt",i)+"' align=\"center\">"+NumConv.setComma(Math.round(listMap.getDouble("sumJtax", i)))+"</td>");
						html.append("\n		<td rowspan='"+listMap.getString("rowCnt",i)+"' align=\"center\">"+NumConv.setComma(Math.round(listMap.getDouble("sumRealmoney", i)))+"</td>");

					}else if(requestMap.getString("gubun").equals("N")){
						html.append("\n		<td rowspan='"+listMap.getString("rowCnt",i)+"' align=\"center\"><input type=\"text\" id=\"money_"+listMap.getString("userno", i)+"\" name=\"money\" size=\"7\" onBlur=\"account('"+ listMap.getString("userno", i) +"')\"></td>");
						html.append("\n		<td rowspan='"+listMap.getString("rowCnt",i)+"' align=\"center\"><span id=\"total_tax_"+listMap.getString("userno", i)+"\">&nbsp;</span></td>");
						html.append("\n		<td rowspan='"+listMap.getString("rowCnt",i)+"' align=\"center\"><span id=\"stax_"+listMap.getString("userno", i)+"\">&nbsp;</span></td>");
						html.append("\n		<td rowspan='"+listMap.getString("rowCnt",i)+"' align=\"center\"><span id=\"jtax_"+listMap.getString("userno", i)+"\">&nbsp;</span></td>");
						html.append("\n		<td rowspan='"+listMap.getString("rowCnt",i)+"' align=\"center\"><span id=\"realmoney_"+listMap.getString("userno", i)+"\">&nbsp;</span></td>");	
						
					}
						
					html.append("\n		<td align=\"center\">"+(listMap.getString("bankname", i).equals("") ? "&nbsp;" : listMap.getString("bankname", i)));
					html.append("\n		<br>"+(listMap.getString("bankno", i).equals("") ? "&nbsp;" : listMap.getString("bankno", i) )+"</td>");
	
					html.append("\n		<td align=\"center\">"+listMap.getString("grcodenm",i)+"&nbsp;</td>");
					html.append("\n		<td align=\"center\">"+listMap.getString("lecnm",i)+"&nbsp;</td>");
					html.append("\n		<td class=\"br0\" align=\"center\">"+listMap.getString("pDate",i)+"&nbsp;</td>");
					
				} else if(requestMap.getString("salaryType").equals("exam")){
					html.append("\n	<tr>");
					if(listMap.getInt("rowCnt2", i) <= 1){ //처음 이면 
						cnt++;
						html.append("\n	<tr>");
						html.append("\n		<td rowspan='"+listMap.getString("rowCnt",i)+"' align=\"center\"><input type=\"checkbox\" name=\"sel\" id=\"chkbox_"+i+"\" value=\""+listMap.getString("userno",i)+"\"></td>");
						html.append("\n		<td rowspan='"+listMap.getString("rowCnt",i)+"' align=\"center\">"+cnt+"</td>");
						html.append("\n		<td rowspan='"+listMap.getString("rowCnt",i)+"' align=\"center\">"+(listMap.getString("tposition", i).equals("") ? "&nbsp" : listMap.getString("tposition",i)));
						html.append("\n		<td rowspan='"+listMap.getString("rowCnt",i)+"' align=\"center\">"+(listMap.getString("name", i).equals("") ? "&nbsp" : listMap.getString("name",i) )+"</td>");
						html.append("\n		<td rowspan='"+listMap.getString("rowCnt",i)+"' align=\"center\">"+(listMap.getString("homeAddr", i).equals("") ? "&nbsp" : listMap.getString("homeAddr",i) )+"</td>");
						html.append("\n		<td rowspan='"+listMap.getString("rowCnt",i)+"' align=\"center\">"+(listMap.getString("resno", i).equals("") ? "&nbsp" : listMap.getString("resno", i) )+"</td>");
						html.append("\n		<td rowspan='"+listMap.getString("rowCnt",i)+"' align=\"center\">"+(listMap.getString("cntsingle", i).equals("") ? "&nbsp" : listMap.getString("cntsingle", i) )+"개</td>");
						html.append("\n		<td rowspan='"+listMap.getString("rowCnt",i)+"' align=\"center\">"+(listMap.getString("cntdesc", i).equals("") ? "&nbsp" : listMap.getString("cntdesc", i) )+"개</td>");
						
						html.append("\n		<td rowspan='"+listMap.getString("rowCnt",i)+"' align=\"center\">"+NumConv.setComma(Math.round(listMap.getDouble("sumMoney", i)))+"</td>");
						html.append("\n		<td rowspan='"+listMap.getString("rowCnt",i)+"' align=\"center\">"+NumConv.setComma(Math.round(listMap.getDouble("sumStax", i)))+"</td>");
						html.append("\n		<td rowspan='"+listMap.getString("rowCnt",i)+"' align=\"center\">"+NumConv.setComma(Math.round(listMap.getDouble("sumJtax", i)))+"</td>");
						html.append("\n		<td rowspan='"+listMap.getString("rowCnt",i)+"' align=\"center\">"+NumConv.setComma(Math.round(listMap.getDouble("sumRealmoney", i)))+"</td>");
						html.append("\n		<td rowspan='"+listMap.getString("rowCnt",i)+"' align=\"center\">"+(listMap.getString("bankname", i).equals("") ? "&nbsp" : listMap.getString("bankname", i)));
		
						size++;
					}
		
					html.append("\n		<td align=\"center\">"+listMap.getString("grcodenm",i)+"</td>");
					html.append("\n		<td align=\"center\">"+listMap.getString("lecnm",i)+"</td>");
					html.append("\n		<td align=\"center\" class=\"br0\">"+listMap.getString("studytime",i)+"</td>");	
					
					if(requestMap.getString("gubu").equals("N")){
						html.append("<td class=\"br0\">");
							html.append(listMap.getString("bigo1", i));
							html.append("<br>");
							html.append(listMap.getString("bigo2", i));
						html.append("</td>");	
						
						html.append("</tr>");
					}
		
				} //end for html
			}
			
		}else{
			
			html.append("<tr>");
			html.append("<td align=\"center\" colspan=\"100%\" class=\"br0\" style=\"height:100px\">등록된 데이터가  없습니다.</td>");
			html.append("</tr>");	
		}
	
	
	
		
	
	
	
	if(courseListMap.keySize("grcode") > 0){
		
		for(int i=0; i < courseListMap.keySize("grcode"); i++){
			option.append("\n	<option value=\""+courseListMap.getString("grcode",i)+"\">" +courseListMap.getString("grcodenm",i) +"</option>");
			
		}

	}
	
	// 집합강사료 총액
	StringBuffer bottomHtml = new StringBuffer();
	if(requestMap.getString("salaryType").equals("collec")){
		bottomHtml.append("<tr><td><table width=\"100%\"><tr><td width=\"50\">");
		bottomHtml.append("	<b>총&nbsp;&nbsp;계</b>");
		bottomHtml.append("	</td>");
		bottomHtml.append("	<td align=right style='color:red'><b> 총강사료 : "+ NumConv.setComma(Math.round(totalMoney)) +"/");
		bottomHtml.append("총 세금공제액 : "+ NumConv.setComma(Math.round(totalAllTax)) +"원 /");
		bottomHtml.append("총 소득세  : "+ NumConv.setComma(Math.round(totalStax)) +"원 /");
		bottomHtml.append("총 주민세 : "+ NumConv.setComma(Math.round(totalJtax)) +"원 /");
		//bottomHtml.append("총 실지급액 : "+ NumConv.setComma(Math.round(totalRealMoney)) +"원");
		bottomHtml.append("총 실지급액 : "+ NumConv.setComma(Math.round(totalMoney)-Math.round(totalAllTax)) +"원");
		bottomHtml.append("	</b></td></tr></table></td>");
		bottomHtml.append("</tr>");
	}
	
%>

<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->


<script language="JavaScript">
<!--
//검색
function go_search(){
	
	if($("sDate").value == ""){
		alert("시작 날짜를 선택하여 주십시오.");
		return false;
	}
	
	var url = "/tutorMgr/salary.do";
	var pars = "mode=ajaxDateChk&sDate="+$("sDate").value;
	var divId = "classroomDIV";
	var myAjax = new Ajax.Updater(
		{success:divId},
		url, 
		{
			asynchronous : false,
			method: "get", 
			parameters: pars,
			
			onSuccess : fnSuccessChk,
			onFailure: function(){
				alert("오류가 발생했습니다.");
			}
		}
	)
}


//원고료 수당확정 N일때 사용하는 함수 금액계산
function account(val_id){
	var val_idObj = "money_"+val_id;
	var total_taxObj = "total_tax_"+val_id;
	var staxObj = "stax_"+val_id;
	var jtaxObj = "jtax_"+val_id;
	var realmoneyObj = "realmoney_"+val_id;
	var val_pay = $(val_idObj).value;
		
	if(val_pay > 250000){
			
		var stax_pay = val_pay*0.04;
		var jtax_pay = val_pay*0.1;
		var total_pay = stax_pay + jtax_pay;
		var realmoney_pay = val_pay - total_pay;
		
		document.getElementById(total_taxObj).innerHTML = total_pay + "원";
		document.getElementById(staxObj).innerHTML = stax_pay + "원";
		document.getElementById(jtaxObj).innerHTML = jtax_pay + "원";
		document.getElementById(realmoneyObj).innerHTML= realmoney_pay + "원";
		
		return;		
	}
	else{
		document.getElementById(total_taxObj).innerHTML="0원";
		document.getElementById(staxObj).innerHTML="0원";
		document.getElementById(jtaxObj).innerHTML="0원";
		document.getElementById(realmoneyObj).innerHTML= val_pay + "원";
		return;
	}	
	
}


//요일 체크
function fnSuccessChk(originalRequest){
	var returnValue = trim(originalRequest.responseText);
	if(returnValue != 2){
		alert("시작날짜는 월요일만 선택가능합니다.	");
		return false;
	}
	
	if(NChecker($("pform"))){
		$("qu").value= "search";
		$("mode").value = "salaryList";
		pform.action = "/tutorMgr/salary.do";
		pform.submit();
	}
}

//팝업열기
function go_popup(mode){

	$("mode").value = mode;
	
	var popHeight = "";
	
	switch(mode){
		case "salaryCyberPop":
			popHeight = "480";
			break;
		case "salaryCollecPop":
			popHeight = "430";
			break;
		case "salaryCopyPayPop":
			popHeight = "280";
			break;
		case "salaryExamPop":
			popHeight = "200";
			break;
	}
	
	
	pform.action = "/tutorMgr/salary.do";
	var popup =popWin('about:blank','majorPop11', '450', popHeight, 'YES', 'no');
	pform.target = "majorPop11";
	pform.submit();
	pform.target = "";
}

//검색인지 엑셀인지 체크
function go_searchChk(qu){

	if(qu == "search"){
		go_search();
	}else{
		go_excel()
	}
	
}
//엑셀열기
function go_excel(){
	$("mode").value="salaryExcel";
	if(NChecker($("pform"))){
		pform.action = "/tutorMgr/salary.do";				
		pform.submit();
	}
}

//개별 수당 강제 지정
function check(id){
	var chk = document.getElementById(id);
	if(chk.disabled == true){
		alert("강제지정을 하셨습니다.\n추후 데이터의 값과 일치하지 않을수도 있습니다");
		chk.disabled = false;
	}else{
		chk.disabled = true;
	}
	
	
}

//전체 체크박스 체크드
function go_check(){

	if($("checkType").checked == true){
		for(var i=0; i < pform.elements.length; i++){  
			if(pform.elements[i].name == "sel"){
				var obj= pform.elements[i].id;
					$(obj).checked = true;
			}
		}
	}else{
		for(var i=0; i < pform.elements.length; i++){  
			if(pform.elements[i].name == "sel"){
				var obj= pform.elements[i].id;
					$(obj).checked = false;
			}
		}
	}
	
}

//강사지정에서 쓰이는 업로드 컴포넌트 호출
function fileUpload(userno, groupfileNo){

	$("mode").value = "fileUp";
	$("userno").value = userno;
	$("groupfileNo").value = groupfileNo;
	
	pform.action = "/tutorMgr/salary.do";
	var popup =popWin('about:blank','majorPop11', '600', '600', 'no', 'no');
	pform.target = "majorPop11";
	pform.submit();
	pform.target = "";
	
}


//저장
function go_save(){
	var chk = 0;
	var chk2 = 0;
	for(var i=0; i < pform.elements.length; i++){  
		if(pform.elements[i].name == "sel"){
			var obj= pform.elements[i].id;
			if($(obj).checked == true){
				chk += 1;
			}
		}
	}

	for(var i=0; i < pform.elements.length; i++){  
		if(pform.elements[i].name == "chk2"){
			var obj= pform.elements[i].id;
			if($(obj).checked == true){
				chk2 += 1;
			}
		}
	}
	if(chk == 0 && chk2 == 0){
		alert("수당확정할 항목을 체크하여 주십시오.");
		return false;
	}
    	if(confirm("저장하시겠습니까 ?")){		
		$("mode").value = "tutorSalaryExec";
		pform.action = "/tutorMgr/salary.do";
		pform.submit();
	}
}

//수당확정 취소
function go_cancle(){
	var chk = 0;

	for(var i=0; i < pform.elements.length; i++){  
		if(pform.elements[i].name == "sel"){
			var obj= pform.elements[i].id;
			if($(obj).checked == true){
				chk += 1;
			}
		}
	}
	
	if(chk == 0){
		alert("수당확정취소 할 항목을 체크하여 주십시오.");
		return false;
	}
	
	if(confirm("저장하시겠습니까 ?")){		
		$("mode").value = "tutorSalaryExec";
		pform.action = "/tutorMgr/salary.do";
		pform.submit();
	}
}

//-->
</script>


<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<form id="pform" name="pform" method="post" >

<input type="hidden" id="menuId" name="menuId" 	value="<%= requestMap.getString("menuId") %>">
<input type="hidden" id="mode" name="mode"	value="<%= requestMap.getString("mode") %>">
<input type="hidden" id="qu" name="qu"		value="">
<!-- 유저넘버 -->
<input type="hidden" id="userno" name="userno"		value="">

<!-- 그룹파일넘버 -->
<input type="hidden" id="groupfileNo" name="groupfileNo"		value="">

<!-- 세션넘버 -->
<input type="hidden" id="userNo" name="userNo"		value="<%=memberInfo.getSessNo() %>">


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
			<jsp:include page="/commonInc/include/commonAdminTitle.jsp" flush="false" />
			<!--[e] 타이틀 -->

			<!--[s] subTitle -->
			<table width="100%" height="10"><tr><td></td></tr></table>
			<table width="100%" border="0" cellspacing="0" cellpadding="0" class="contentsSubTitleTable">			
				<tr>
					<td height="20">
						<img src="/images/bullet003.gif"  align="bottom">&nbsp;<strong>외래강사수당내역</strong>
					</td>
				</tr>
			</table> 
			<!--[e] subTitle -->
			<div class="space01"></div>
			<!--[s] Contents Form  -->
			<div class="h10"></div>
			<!--[s] Contents Form  -->
			<table cellspacing="0" cellpadding="0" border="0" width="100%"
				class="contentsTable">
				<tr>
					<td>
						<!-- 검색  -->
						<table class="search01">
							<tr>
								<th width="80" class="bl0">
									강사수당구분 
								</th>
								<td width="20%">
									<select id="salaryType" name="salaryType"  class="mr10">
										<option value="collec">
											집합강사료
										</option>
										<option value="cyber">
											사이버강사료
										</option>
										<option value="copyPay">
											원고료
										</option>
										<option value="exam">
											출제료
										</option>																				
									</select>
								</td>
								<th>
									수당확정구분 
								</th>
								<td>
									<select name="gubun" class="mr10">
										<option selected value="N">
											미확정
										</option>
										<option value="Y">
											확정
										</option>
									</select>
								</td>
								<td width="120" class="btnr" rowspan="3">
									<input type="button" value="검 색" onclick="go_searchChk('search');" class="boardbtn1">
									<input type="button" value="출 력" onclick="go_excel('salaryExcel');" class="boardbtn1">
								</td>
							</tr>
							<tr>
								<th class="bl0">
									과정
								</th>
								<td  colspan="3">
									<select id="grcode" name="grcode" class="mr10">
										<option value="">
											전체
										</option>
										<%=option.toString() %>
									</select>
								</td>
							</tr>
							<tr>
							<th width="80" class="bl0">
									기간
								</th>
								<td  colspan="3">
									<input type="text" class="textfield" name="sDate" value="<%=requestMap.getString("sDate")%>" style="width:100px" readonly/>
									<img style="cursor:hand" onclick="fnPopupCalendar('pform','sDate');" src="../images/icon_calen.gif" alt="" />
									<br>(시작일(월요일)을 지정하시면 자동으로 해당주의 금요일이 종료일이 됩니다.) 
								</td>
								
						</table>
						<!--//검색  -->	
						<div class="space01"></div>

						<!-- 상단 버튼 -->  
						<table class="btn01">
							<tr>
								<td class="right">
									<input type="button" value="사이버강사수당관리" onclick="go_popup('salaryCyberPop');" class="boardbtn1">
									<input type="button" value="집합강사수당관리" onclick="go_popup('salaryCollecPop');" class="boardbtn1">
									<input type="button" value="원고료수당관리" onclick="go_popup('salaryCopyPayPop');" class="boardbtn1">
									<input type="button" value="평가출제수당관리" onclick="go_popup('salaryExamPop');" class="boardbtn1">
									<%if(requestMap.getString("gubun").equals("N")){ %>
										<input type="button" value="수당확정" onclick="go_save();" class="boardbtn1">
									<%}else{ %>
										<input type="button" value="수당취소" onclick="go_cancle();" class="boardbtn1">
									<%} %>
								</td>
							</tr>
						</table>
						<!-- // 상단 버튼  -->

						<!-- 리스트  -->
						<table class="datah01">
							<thead>
						<%=subMenu.toString() %>
							</thead>

							<tbody>
							<%=html.toString() %>
							</tbody>
						</table>
						<!--//리스트  -->	
					</td>
				</tr>
				<%=bottomHtml.toString() %>
			</table>
			<!--//[e] Contents Form  -->
			<div class="space_ctt_bt"></div>                  
        </td>
    </tr>
</table>

<!--[s] bottom -->
<jsp:include page="/commonInc/include/commonAdminBottom.jsp" flush="false"/>
<!--[e] bottom -->

</form>
</body>
<script language="JavaScript" type="text/JavaScript">
	//검색 조건 셀렉티드
	var salaryType = "<%=requestMap.getString("salaryType")%>";
	len = $("salaryType").options.length;

	for(var i=0; i < len; i++) {
		if($("salaryType").options[i].value == salaryType){
			$("salaryType").selectedIndex = i;
		 }
 	 }
 	//검색 조건 셀렉티드
	var grcode = "<%=requestMap.getString("grcode")%>";
	grcodeLen = $("grcode").options.length;

	for(var i=0; i < grcodeLen; i++) {
		if($("grcode").options[i].value == grcode){
			$("grcode").selectedIndex = i;
		 }
 	 }

 	
 	//검색 조건 셀렉티드
	var gubun = "<%=requestMap.getString("gubun")%>";
	gubunLen = $("gubun").options.length;

	for(var i=0; i < gubunLen; i++) {
		if($("gubun").options[i].value == gubun){
			$("gubun").selectedIndex = i;
		 }
 	 }

</script>
