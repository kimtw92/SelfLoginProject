<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 외래강사 수당관리 엑셀
// date  : 2008-07-21
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
	
	//과정소계  데이터
	DataMap courseListMap = (DataMap)request.getAttribute("COURSTLIST_DATA");
	courseListMap.setNullToInitialize(true);
	//리스트
	StringBuffer html = new StringBuffer();
	
	//총계
	double totalMoney = 0;
	double totalStax = 0;
	double totalJtax = 0;
	double totalRealMoney = 0;
	double totalAllTax = 0;

	StringBuffer subMenu = new StringBuffer();
	
	//각각의 검색조건마다 항목이 달라진다. 
	if(requestMap.getString("salaryType").equals("cyber")){
		//사이버 강사모드
		subMenu.append("<tr bgcolor=\"#5071B4\">");
		subMenu.append("	<td height=\"28\"class=\"tableline11 white\"align = center rowspan = 2><b>연번</td>");
		subMenu.append("	<td height=\"28\"class=\"tableline11 white\"align = center rowspan = 2><b>소속및직위</td>");
		subMenu.append("	<td height=\"28\"class=\"tableline11 white\"align = center rowspan = 2><b>성명</td>");
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
			subMenu.append("	<td height=\"28\"class=\"tableline11 white\"align = center rowspan = 2><b>산출근거</td>");
			
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
		subMenu.append("	<td height=\"28\"class=\"tableline11 white\"align = center rowspan = 2><b>연번</td>");
		subMenu.append("	<td height=\"28\"class=\"tableline11 white\"align = center rowspan = 2><b>소속및직위</td>");
		subMenu.append("	<td height=\"28\"class=\"tableline11 white\"align = center rowspan = 2><b>성명</td>");
		subMenu.append("	<td height=\"28\"class=\"tableline11 white\"align = center rowspan = 2><b>주소</td>");
		subMenu.append("	<td height=\"28\"class=\"tableline11 white\"align = center rowspan = 2><b>주민번호</td>");
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
					for(int j = (i+1); j < listMap.keySize("userno"); j++){//리스트사이즈만큼 루프
						
						if(listMap.getString("userno",i).equals(listMap.getString("userno", j))){//현재 번호와 두번째 루프의 유저 넘버가 같을경우.
		
							rowCnt++;
							money += Double.parseDouble(listMap.getString("calMoney", j));
		
							if(money > 250000){	
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
							//실금액은 전체 금액에 세금액을 뺀 금액이다.
							realmoney = money - totalTax;
							
						}
							
					}
					

					
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
						
						if(!listMap.getString("money", j).equals("")){
							money = Double.parseDouble(listMap.getString("money", j));
							
						}else{
							money = 0;
							
						}
						
						rmoney += listMap.getInt("rptMoney", j);
						qmoney += listMap.getInt("qnaMoney", j);
						
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
				
				listMap.addInt("rowCnt", rowCnt);
				listMap.addInt("rowCnt2", rowCnt2);
				listMap.addDouble("sumMoney", tmoney);
				listMap.addDouble("sumStax", stax);
				listMap.addDouble("sumJtax", jtax);
				listMap.addDouble("sumTotalTax", totalTax);
				listMap.addDouble("sumRealmoney", realmoney);
				
				listMap.addDouble("tmoney", money);
				
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
					
					html.append(NumConv.setComma(Math.round(listMap.getDouble("sumMoney", i))));
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
					html.append("<td class=\"br0\">");
						html.append(listMap.getString("calBigo1",i));
						html.append("<br>");
						html.append(listMap.getString("calBigo2",i));
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
						html.append("\n		<td align=\"center\" rowspan='"+listMap.getString("rowCnt",i)+"'>"+NumConv.setComma(Math.round(listMap.getDouble("rmoney", i)))+"</td>");//
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
					html.append("<td align=\"center\" colspan=\"100%\" class=\"tableline21\" style=\"height:100px\">"+listMap.getString("content")+"</td>");
					html.append("</tr>");
				}
				
				
			}else if(requestMap.getString("salaryType").equals("copyPay")){
				cnt++;
					html.append("\n	<tr>");
					if(listMap.getInt("rowCnt2", i) <= 1){ //처음 이면 
						
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
					html.append("</tr>");
				} else if(requestMap.getString("salaryType").equals("exam")){
					html.append("\n	<tr>");
					if(listMap.getInt("rowCnt2", i) <= 1){ //처음 이면 
						cnt++;
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
					}else{
						html.append("</tr>");
					}
		
				} //end for html
			}
			
		}else{
			
			html.append("<tr>");
			html.append("<td align=\"center\" colspan=\"15\" class=\"br0\" style=\"height:100px\">등록된 데이터가  없습니다.</td>");
			html.append("</tr>");	
		}
	
	// 집합강사료 총액
	StringBuffer bottomHtml = new StringBuffer();
	if(requestMap.getString("salaryType").equals("collec")){
		bottomHtml.append("\n	<tr>");
		bottomHtml.append("\n		<td>");
		bottomHtml.append("\n			<b>총&nbsp;&nbsp;계</b>&nbsp;&nbsp;&nbsp;<font color=red><b> 총강사료 : "+ NumConv.setComma(Math.round(totalMoney)) +"/");
		bottomHtml.append("				총 세금공제액 : "+ NumConv.setComma(Math.round(totalAllTax)) +"원 /");
		bottomHtml.append("				총 소득세  : "+ NumConv.setComma(Math.round(totalStax)) +"원 /");
		bottomHtml.append("				총 주민세 : "+ NumConv.setComma(Math.round(totalJtax)) +"원 /");
		//bottomHtml.append("				총 실지급액 : "+ NumConv.setComma(Math.round(totalRealMoney)) +"원");
		bottomHtml.append("총 실지급액 : "+ NumConv.setComma(Math.round(totalMoney)-Math.round(totalAllTax)) +"원");
		bottomHtml.append("\n		</font></td>");
		bottomHtml.append("\n	</b></tr>");
	}
	

	
	String fileName = "";
	if(requestMap.getString("salaryType").equals("cyber")){
		if(requestMap.getString("sDate").equals("")){
			//시작날짜가없을때에는 현재 날짜를 넣어준다.
			fileName = "사이버 강사수당_"+DateUtil.getDateTime();	
			
		}else{
			//시작날짜가 있을경우 시작날짜를 넣어준다.
			fileName = "사이버 강사수당_"+requestMap.getString("sDate");	
			
		}
		
	}else if(requestMap.getString("salaryType").equals("collec")){
		if(requestMap.getString("sDate").equals("")){
			fileName = "집합 강사수당_"+DateUtil.getDateTime();	
			
		}else{
			fileName = "집합 강사수당_"+requestMap.getString("sDate");	
			
		}
		
	}else if(requestMap.getString("salaryType").equals("copyPay")){
		if(requestMap.getString("sDate").equals("")){
			fileName = "원고료 강사수당_"+DateUtil.getDateTime();	
			
		}else{
			fileName = "원고료 강사수당_"+requestMap.getString("sDate");	
			
		}
		
	}else if(requestMap.getString("salaryType").equals("exam")){
		if(requestMap.getString("sDate").equals("")){
			fileName = "출제료  강사수당_"+DateUtil.getDateTime();	
			
		}else{
			fileName = "출제료 강사수당_"+requestMap.getString("sDate");	
			
		}
	}
	
	WebUtils.setFileHeader(request, response, fileName+".xls", "UTF-8", "UTF-8");
	response.setHeader("Content-Description", "JSP Generated Data"); 
	response.setContentType( "application/vnd.ms-excel" );
	request.setCharacterEncoding("UTF-8");
%>
<meta http-equiv="Content-Type" content="application/vnd.ms-excel; charset=UTF-8">
<table width="1200" border="1" cellpadding="0" cellspacing="0" bordercolordark="#ffffff" bordercolorlight="#000000">
	<tr>
		<td>
			<!-- 리스트  -->
			<table border="1" cellpadding="0" cellspacing="0" bordercolordark="#ffffff" bordercolorlight="#000000">
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

