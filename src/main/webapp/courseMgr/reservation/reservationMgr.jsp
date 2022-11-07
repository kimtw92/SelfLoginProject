<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%  
// prgnm : 시설예약관리
// date  : 2008-
// auth  : 양정환
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

	
	String place = ""; 

	if(request.getParameter("place") == null) {
		place = "0";
	}else{
		place = request.getParameter("place");
	}


   Calendar cal = Calendar.getInstance();
   // 추상클래스로 getInstance()로 객체 생성
   int year = cal.get(Calendar.YEAR);
   int month = cal.get(Calendar.MONTH);
   
   // 이건 저쪽에서 고정값으로 비교할려구 하는거여..
   int staticYear = cal.get(Calendar.YEAR);
   int staticMonth = cal.get(Calendar.MONTH);
   
   if(request.getParameter("year") != null && request.getParameter("month") != null) {
	   year = Integer.parseInt(request.getParameter("year"));
	   month = Integer.parseInt(request.getParameter("month"))-1;
   }
   
   int today = cal.get(Calendar.DAY_OF_MONTH);
   
   cal.set(year, month, 1); 
   int startDay = cal.getMinimum(Calendar.DATE);
   int endDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
   int start = cal.get(Calendar.DAY_OF_WEEK);
   
   int newLine = 0;
   

   

	String[] daysAm = new String[35];
	String[] daysPm = new String[35];
	String[] allDays = new String[35];
	
	for(int i=0;i<32;i++) {
	 daysAm[i] = "";
	 daysPm[i] = "";
	 allDays[i] = "";
	}
	
	//1일이 일요일일때

   if("6".equals(place) || "7".equals(place) || "1".equals(place)) {

		int sat = 7 - start + 1;
		for(int i=sat; i < 32; i+=7) {
			allDays[i]="<a class=\"redb\" href=javascript:go_adminrsev("+year+","+ (month+1) +","+ i +","+place+",'all');>예약가능</a>";
			allDays[i+1]="<a class=\"redb\" href=javascript:go_adminrsev("+year+","+ (month+1) +","+ (i+1) +","+place+",'all');>예약가능</a>";                       
		}	
				
 	} else {

    if(start == 1) {
	 	
	//일요일 셋팅
	for(int i=1; i<32 ; i+=7){
		daysAm[i]="<a class=\"redb\" href=javascript:go_adminrsev("+year+","+ (month+1) +","+ i +","+place+",'am');>예약가능</a>";
		daysPm[i]="<a class=\"redb\" href=javascript:go_adminrsev("+year+","+ (month+1) +","+ i +","+place+",'pm');>예약가능</a>";
		allDays[i]="<a class=\"redb\" href=javascript:go_adminrsev("+year+","+ (month+1) +","+ i +","+place+",'all');>예약가능</a>";			
	}
	//토요일 셋팅
	for(int i=7; i<32 ; i+=7){
		daysAm[i]="<a class=\"redb\" href=javascript:go_adminrsev("+year+","+ (month+1) +","+ i +","+place+",'am');>예약가능</a>";
		daysPm[i]="<a class=\"redb\" href=javascript:go_adminrsev("+year+","+ (month+1) +","+ i +","+place+",'pm');>예약가능</a>";
		allDays[i]="<a class=\"redb\" href=javascript:go_adminrsev("+year+","+ (month+1) +","+ i +","+place+",'all');>예약가능</a>";			
	}
	
	} else {
	 
	 int sat = 7 - start + 1;
	 
	 for(int i=sat; i < 32; i+=7){
	  
	  //토요일
	  daysAm[i]="<a class=\"redb\" href=javascript:go_adminrsev("+year+","+ (month+1) +","+ i +","+place+",'am');>예약가능</a>";
	  daysPm[i]="<a class=\"redb\" href=javascript:go_adminrsev("+year+","+ (month+1) +","+ i +","+place+",'pm');>예약가능</a>";
	  allDays[i]="<a class=\"redb\" href=javascript:go_adminrsev("+year+","+ (month+1) +","+ i +","+place+",'all');>예약가능</a>";
	  
	  //일요일
	  daysAm[i+1]="<a class=\"redb\" href=javascript:go_adminrsev("+year+","+ (month+1) +","+ (i+1) +","+place+",'am');>예약가능</a>";
	  daysPm[i+1]="<a class=\"redb\" href=javascript:go_adminrsev("+year+","+ (month+1) +","+ (i+1) +","+place+",'pm');>예약가능</a>";
	  allDays[i+1]="<a class=\"redb\" href=javascript:go_adminrsev("+year+","+ (month+1) +","+ (i+1) +","+place+",'all');>예약가능</a>";
	 }
	}
    
    }

	DataMap holydaylistMap = (DataMap)request.getAttribute("HOLYDAYUILIST_DATA");
	holydaylistMap.setNullToInitialize(true); 
	if("6".equals(place) || "7".equals(place) || "1".equals(place)) {
	} else {	
        for(int i = 0 ; i < holydaylistMap.keySize(); i++) {	
            daysAm[Integer.parseInt(holydaylistMap.getString("dd", i))]  =  "<a class=\"redb\" href=javascript:go_adminrsev("+holydaylistMap.getString("yyyy", i)+","+ Integer.parseInt(holydaylistMap.getString("mm", i)) +","+ Integer.parseInt(holydaylistMap.getString("dd", i)) +","+place+",'am');>예약가능</a>";
            daysPm[Integer.parseInt(holydaylistMap.getString("dd", i))]  ="<a class=\"redb\" href=javascript:go_adminrsev("+holydaylistMap.getString("yyyy", i)+","+ Integer.parseInt(holydaylistMap.getString("mm", i)) +","+ Integer.parseInt(holydaylistMap.getString("dd", i)) +","+place+",'pm');>예약가능</a>";
            allDays[Integer.parseInt(holydaylistMap.getString("dd", i))] ="<a class=\"redb\" href=javascript:go_adminrsev("+holydaylistMap.getString("yyyy", i)+","+ Integer.parseInt(holydaylistMap.getString("mm", i)) +","+ Integer.parseInt(holydaylistMap.getString("dd", i)) +","+place+",'all');>예약가능</a>";
        }
	}
	DataMap listMap = (DataMap)request.getAttribute("RESERVATION_LIST");
	listMap.setNullToInitialize(true); 
	
	for(int i = 0 ; i < listMap.keySize("taPk"); i++) {

			int index = Integer.parseInt(listMap.getString("taRentDate",i).substring(6));
			String time=listMap.getString("taRentTime",i);
			if(time.equals("am")){
				daysAm[index] ="<font class=\"green\">예약진행</font>";
			}else if(time.equals("pm")){
				daysPm[index] ="<font class=\"green\">예약진행</font>";
			}else if(time.equals("all")){
				if("6".equals(place) || "7".equals(place) || "1".equals(place)) {
				} else {
					allDays[index] ="<font class=\"green\">예약진행</font>";
				}
			}
	}
	/*	}else if(listMap.getString("section",i).equals("1")) {
			int index = Integer.parseInt(listMap.getString("resvDay",i).substring(6));
			
			if(listMap.getString("status",i).equals("1")){
				daysPm[index] = "<font class=\"gray\">예약불가</font>";
			}else if(listMap.getString("status",i).equals("2")){
				daysPm[index] = "<font class=\"black\"><blink>예약중</blink></font>";
			}else if(listMap.getString("status",i).equals("3")){
				daysPm[index] = "<font class=\"green\">예약진행</font>";
			}			
		}else if(listMap.getString("section",i).equals("2")) {
			int index = Integer.parseInt(listMap.getString("resvDay",i).substring(6));
			
			if(listMap.getString("status",i).equals("1")){
				allDays[index] = "<font class=\"gray\">예약불가</font>";
			}else if(listMap.getString("status",i).equals("2")){
				allDays[index] = "<font class=\"black\"><blink>예약중</blink></font>";
			}else if(listMap.getString("status",i).equals("3")){
				allDays[index] = "<font class=\"green\">예약진행</font>";
			}			
		}
	}*/

	
	
	
	/* 
   if(year < staticYear) {
	   for(int i=0; i<=31; i++) {
		   daysAm[i]="";
		   daysPm[i]="";
		   allDays[i]="";
	   }	   
   }else if(year == staticYear && month == staticMonth) {
	   for(int i=0; i<=today+6; i++) {
		   daysAm[i]="";
		   daysPm[i]="";
		   allDays[i]="";
	   }	   
   }else if(year == staticYear && month < staticMonth) {
	   for(int i=0; i<=31; i++) {
		   daysAm[i]="";
		   daysPm[i]="";
		   allDays[i]="";
	   }	   
   }	
	*/
   //오전 오후중 하나라도 예약진행이면 종일 예약은 예약불가로 한다.
   for(int i=0; i<=31; i++) {
	   if(daysAm[i].equals("<font class=\"green\">예약진행</font>") ) {
		   allDays[i] = "<font class=\"gray\">예약불가</font>";
	   }
	   if(daysPm[i].equals("<font class=\"green\">예약진행</font>") ) {
		   allDays[i] = "<font class=\"gray\">예약불가</font>";
	   }	   
   }
   // 종일예약이 예약 완료일 경우 오전 오후는 모두 예약진행로  바꾼다.
   for(int i=0; i<=31; i++) {
	   if(allDays[i].equals("<font class=\"green\">예약진행</font>")) {
		   daysAm[i] = "<font class=\"green\">예약진행</font>";
		   daysPm[i] = "<font class=\"green\">예약진행</font>";
	   }	   
   }
   if(staticMonth == month ){
	   for(int i=0;i<today;i++){
		   daysAm[i] ="";
		   daysPm[i] ="";
		   allDays[i] ="";
	   }
   }
%>
<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->
<script>
	function go_adminrsev(year, month, day, place,time) {
		window.open("/courseMgr/reservation.do?mode=adminRev&year="+year+"&month="+month+"&day="+day+"&gubun="+time+"&place="+place ,'popConfirm','statusbar=no,height=750px,width=650px,scrollbars=yes,top=100,left=350');
	}
	
	function beforeMonth(year,month,place) {

		if(month == '0') {
			month = 12;
			year -= 1;
		}

		/*
		if( (year==<%=staticYear%> && month==<%=staticMonth%>) || year < <%=staticYear%>) {
			alert('이전달의 예약은 불가능 합니다.');
			return;
		}
		*/

		
		location.href="/courseMgr/reservation.do?mode=mgr&menuId=1-5-1&year="+year+"&month="+month+"&place="+place;
	}

    function yn_save(yyyy, mm, dd, price, yn) {
        var pauth = $F("cboAuth");
        var url = "/courseMgr/reservation.do?mode=mgrYn";
        var pars = "yyyy=" + yyyy + "&mm=" + mm + "&dd=" + dd + "&price=" + price + "&yn=" + yn;
        
        if(yn == "Y") {
            if(!confirm("예약을 가능하도록 변경 하시겠습니까?")) {
                alert("취소되었습니다.");
                return;
            }
        } else {
            if(!confirm("예약을 불가능하도록 변경 하시겠습니까?")) {
                alert("취소되었습니다.");
                return;
            }
        }

        var myAjax = new Ajax.Request(
            url, 
            {
                method: "POST", 
                parameters: pars, 
                onComplete: ynSaveComplete
            }
        );
    }

    function ynSaveComplete(originalRequest){
        alert("설정되었습니다.");
        location.reload();
    }

	function nextMonth(year,month,place) {

		/*
		if(month == <%=staticMonth%>+3) {
			alert('예약은 현재 해당 달의 다음달 까지만 가능합니다.\n예)오늘날짜가 1월이면 2월말까지만 예약가능');
			return;
		}
		*/
		if(month == '13') {
			month = 1;
			year += 1;
		}

		/*
		if(year-1 == <%=staticYear%> && month == 2) {
			alert('예약은 현재 해당 달의 다음달 까지만 가능합니다.\n예)오늘날짜가 1월이면 2월말까지만 예약가능');
			return;
		}
		*/
		
		location.href="/courseMgr/reservation.do?mode=mgr&menuId=1-5-1&year="+year+"&month="+month+"&place="+place;
	}	
	var speed = 800 //깜빡이는 속도 - 1000은 1초

	function doBlink(){
		var blink = document.all.tags("blink")
		for (var i=0; i < blink.length; i++)
			blink[i].style.visibility = blink[i].style.visibility == "" ? "hidden" : ""
	} 

	function startBlink() { 
		setInterval("doBlink()",speed)
	} 
	window.onload = startBlink; 

	
</script>


<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >
<form id="pform" name="pform" method="post"></form>

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

				
			<!--[s] Contents Form  -->
			<table width="90%" border="0" cellspacing="0" cellpadding="0" class="commonTitleTable">
			<tr>
			<td>
			<div class="tabs01" style="width:100%">
				<ul>
					<li><a href="/courseMgr/reservation.do?mode=mgr&menuId=1-5-1&place=4"><img src="../../../images/skin1/common/tab_da05<%if(place.equals("4")) {%>_on<%}%>.gif" alt="체육관" /></a></li>
					<li><a href="/courseMgr/reservation.do?mode=mgr&menuId=1-5-1&place=0"><img src="../../../images/skin1/common/tab_da01<%if(place.equals("0")) {%>_on<%}%>.gif" alt="운동장" /></a></li>
					<li><a href="/courseMgr/reservation.do?mode=mgr&menuId=1-5-1&place=1"><img src="../../../images/skin1/common/tab_da02<%if(place.equals("1")) {%>_on<%}%>.gif" alt="테니스장" /></a></li>
					<li><a href="/courseMgr/reservation.do?mode=mgr&menuId=1-5-1&place=3"><img src="../../../images/skin1/common/tab_da04<%if(place.equals("3")) {%>_on<%}%>.gif" alt="강당" /></a></li>
					<li><a href="/courseMgr/reservation.do?mode=mgr&menuId=1-5-1&place=6"><img src="../../../images/skin1/common/tab_da06<%if(place.equals("6")) {%>_on<%}%>.gif" alt="강의실" /></a></li>
					<li><a href="/courseMgr/reservation.do?mode=mgr&menuId=1-5-1&place=7"><img src="../../../images/skin1/common/tab_da07<%if(place.equals("7")) {%>_on<%}%>.gif" alt="생활관" /></a></li>
					<!-- <li><a href="/courseMgr/reservation.do?mode=mgr&menuId=1-5-1&place=2"><img src="../../../images/skin1/common/tab_da03<%if(place.equals("2")) {%>_on<%}%>.gif" alt="테니스장2" /></a></li> -->
				</ul>
			</div>
			<div class="h9"></div>
			
				<div class="year">
					<a href='javascript:beforeMonth(<%=year %>,<%=month %>,<%=place %>);'><img src="../../../images/skin1/icon/icon_prev.gif" alt="이전" class="ac" /></a>
					<a href="#" class="ml30"><strong class="c_000"><%=year %>년 <%=month+1 %>월</strong></a>
					<a href='javascript:nextMonth(<%=year %>,<%=month+2%>,<%=place %>);' class="ml30"><img src="../../../images/skin1/icon/icon_next.gif" alt="다음" class="ac"/></a>
				</div>
			
			
			<div style="height:20px"></div>
			
			<table class="dataH03">	
			<colgroup>
				<col width="60" />
				<col width="60" />
				<col width="60" />
				<col width="60" />
				<col width="60" />
				<col width="60" />
				<col width="60" />
				<col width="60" />
			</colgroup>
			<thead>
			<tr>
				<%
					if("6".equals(place) || "7".equals(place) || "1".equals(place)) {
					} else {
				%>
				<th class="bl0 txt_b"><img src="../../../images/skin1/table/th_time04.gif" alt="사용시간" /></th>
				<%
					}
				%>
				<th class="bl0"><img src="../../../images/skin1/table/th_day01.gif" alt="일" /></th>
				<th class="bl0"><img src="../../../images/skin1/table/th_day02.gif" alt="월" /></th>
				<th class="bl0"><img src="../../../images/skin1/table/th_day03.gif" alt="화" /></th>
				<th class="bl0"><img src="../../../images/skin1/table/th_day04.gif" alt="수" /></th>
				<th class="bl0"><img src="../../../images/skin1/table/th_day05.gif" alt="목" /></th>
				<th class="bl0"><img src="../../../images/skin1/table/th_day06.gif" alt="금" /></th>
				<th class="bl0"><img src="../../../images/skin1/table/th_day07.gif" alt="토" /></th>
			</tr>
			</thead>
			<tbody>
			
			 <%
             	if("6".equals(place) || "7".equals(place) || "1".equals(place)) {
		 	    } else {
			 	    out.print("<td class=\"blinel\">&nbsp;<br>(오전) 09:00~13:00<br>(오후) 13:00~17:00<br>(종일) 09:00~17:00</td>");
				}
			 	for(int i = 1; i < start; i++){
					out.print("<td>&nbsp;</td>");
			 		newLine++;
				}
			

			if("6".equals(place) || "7".equals(place) || "1".equals(place)) {

			} else { 
				int checkIndex = 0;
				for(int i = 0 ; i < listMap.keySize("taPk"); i++) {
						

					if("Y".equals(listMap.getString("useryn", i))){

						int index = Integer.parseInt(listMap.getString("taRentDate",i).substring(6));			// 대여한 일
						int rentMonth = Integer.parseInt(listMap.getString("taRentDate", i).substring(4, 6));	// 대여한 월
						String time=listMap.getString("taRentTime",i);
						
						boolean ischeck = false;

						if("pm".equals(time)) {
							checkIndex++;
							daysPm[index] = "<font class=\"reg\">예약완료</font>";
							
						} 
						
						if("am".equals(time)) {
							checkIndex++;
							daysAm[index] = "<font class=\"reg\">예약완료</font>";
						}

						if("all".equals(time)) {
							allDays[index] = "<font class=\"reg\">예약완료</font>";
							ischeck = true;
						}

						if(checkIndex == 2) {
							allDays[index] = "<font class=\"reg\">예약완료</font>";
						}

						if(ischeck) {
							daysPm[index] = "<font class=\"reg\">예약완료</font>";
							daysAm[index] = "<font class=\"reg\">예약완료</font>";
							ischeck = false;
						}
						checkIndex = 0;
					}						
						
				}
		}
				
	
                DataMap savemgrynlist = (DataMap) request.getAttribute("SAVEMGRYNLIST");
                savemgrynlist.setNullToInitialize(true); 


                String p_yyyy = (String)request.getAttribute("yyyy");
                String p_mm = (String)request.getAttribute("mm");
                String p_day = "";

      
                for(int i = 0 ; i < savemgrynlist.keySize("seqno"); i++) {
                    p_day += ","+savemgrynlist.getString("dd",i);
                }
                p_day += ",";

				for(int i = 1; i <= endDay; i++){
					
					//날짜 스타일클래스명
					String className = (newLine == 0) ? "blinep sun" : (newLine == 6) ? "bliner sat" : "blinep day";
					//날짜 색상
					String color = (newLine == 0) ? "RED" : (newLine == 6) ? "BLUE" : "BLACK";
				

					for(int j = 0 ; j < holydaylistMap.keySize(); j++) {
						if(Integer.parseInt(holydaylistMap.getString("mm", j)) ==  (month+1)) {
							if(Integer.parseInt(holydaylistMap.getString("dd", j)) ==  i) {
								color = "RED";
							}
						}
					}
					
					
					

					
					
					//일요일 셋팅
					if(newLine != 7) {
					if("6".equals(place) || "7".equals(place) || "1".equals(place)) {
                        if(p_yyyy.equals(String.valueOf(year)) && p_mm.equals(String.valueOf((month+1))) && p_day.indexOf(String.valueOf(","+i+",")) != -1) {
                            out.print("<td class=\""+className+"\"><Font  class=\"num\" Color="+color+">(<a href='javascript:yn_save("+year+","+ (month+1) +","+ i +","+place+",\"Y\");'>불가</a>) "+ i + "</font>");
                            out.print("<br />"+daysAm[i]);
                            out.print("<br />"+daysPm[i]);
                            out.print("<br />"+allDays[i]);		   
                        } else {
                            out.print("<td class=\""+className+"\"><Font  class=\"num\" Color="+color+">(<a href='javascript:yn_save("+year+","+ (month+1) +","+ i +","+place+",\"N\");'>가능</a>) "+ i + "</font>");
                            out.print("<br />"+daysAm[i]);
                            out.print("<br />"+daysPm[i]);
                            out.print("<br />"+allDays[i]);					
                        }
					} else {
                        if(p_yyyy.equals(String.valueOf(year)) && p_mm.equals(String.valueOf((month+1))) && p_day.indexOf(String.valueOf(","+i+",")) != -1) {
                            out.print("<td class=\""+className+"\"><Font  class=\"num\" Color="+color+">(<a href='javascript:yn_save("+year+","+ (month+1) +","+ i +","+place+",\"Y\");'>불가</a>) "+ i + "</font>");
                            out.print("<br />"+daysAm[i]);
                            out.print("<br />"+daysPm[i]);
                            out.print("<br />"+allDays[i]);
                        } else {
                            out.print("<td class=\""+className+"\"><Font  class=\"num\" Color="+color+">(<a href='javascript:yn_save("+year+","+ (month+1) +","+ i +","+place+",\"N\");'>가능</a>) "+ i + "</font>");
                            out.print("<br />"+daysAm[i]);
                            out.print("<br />"+daysPm[i]);
                            out.print("<br />"+allDays[i]);
                        }


                    }
						//줄맞추기 위해 개행
						if(daysAm[i] == "" && daysPm[i] == "" && allDays[i] == "") {
							out.print("<br />");
						}
						out.print("</td>\n");
					}
					newLine++;
					
					//개행. 시간대 그리기
					if(newLine == 7){
						out.print("</tr>\n");
						if(i <= endDay) {
						
                        if("6".equals(place) || "7".equals(place) || "1".equals(place)) {
							out.print("<tr>");
							} else {
                            out.print("<tr>");
							out.print("<td class=\"blinel\">&nbsp;<br>(오전) 09:00~13:00<br>(오후) 13:00~17:00<br>(종일) 09:00~17:00</td>");					
						}

							
						}
						newLine = 0;
					}
				}
			
				while(newLine > 0 && newLine < 7) {
					out.print("<td>&nbsp;</td>");
					newLine++;
				}
				
				
				
			 %>
			<tr></tr>
			</tbody>	
			</table>
			</td>
			</tr>
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