<%@page import="loti.courseMgr.service.ReservationService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commonInc/include/commonImport.jsp" %>
<%@ include file="/commonInc/include/comInclude.jsp" %>
<jsp:include page="/commonInc/include/comHtmlTop.jsp" flush="false">
	<jsp:param name="cssName" value="layout" />
</jsp:include>

<%
	//시설임대메뉴 사용여부
	DataMap menuMap = (DataMap)request.getAttribute("MENU_USEYN");
	menuMap.setNullToInitialize(true); 
	String tennisYn = "";
	String groundYn = "";
	String auditoriumYn = "";
	String gymnasiumYn = "";
	String classroomYn = "";
	String conceptionYn = "";
	int count = 0;
	String tabmode = "";
	for(int i=0 ; i < menuMap.keySize("menucd"); i++) {
		if("TENNIS".equals(menuMap.getString("menucd", i))) {
			tennisYn = menuMap.getString("useYn", i);
			if("Y".equals(tennisYn)){
				count++;
				tabmode = "T";
			}
		}
		if("GROUND".equals(menuMap.getString("menucd", i))) {
			groundYn = menuMap.getString("useYn", i);
			if("Y".equals(groundYn)){
				count++;
				tabmode = "G";
			}
		}
		if("AUDITORIUM".equals(menuMap.getString("menucd", i))) {
			auditoriumYn = menuMap.getString("useYn", i);
			if("Y".equals(auditoriumYn)){
				count++;
				tabmode = "A";
			}
		}
		if("GYMNASIUM".equals(menuMap.getString("menucd", i))) {
			gymnasiumYn = menuMap.getString("useYn", i);
			if("Y".equals(gymnasiumYn)){
				count++;
				tabmode = "GY";
			}
		}				
		if("CLASSROOM".equals(menuMap.getString("menucd", i))) {
			classroomYn = menuMap.getString("useYn", i);
			if("Y".equals(classroomYn)){
				count++;
				tabmode = "CR";
			}
		}	
		if("CONCEPTION".equals(menuMap.getString("menucd", i))) {
			conceptionYn = menuMap.getString("useYn", i);
			if("Y".equals(conceptionYn)){
				count++;
				tabmode = "CC";
			}
		}					
	}
	
	//시설 장소
	String place = "";
	if(request.getParameter("place") == null) {
		if(count == 4) {
			place = "0";	
		} else {
			if("T".equals(tabmode)) {
				place = "1";
			} else if("G".equals(tabmode)) {
				place = "0";
			} else if("A".equals(tabmode)) {
				place = "3";
			} else if("GY".equals(tabmode)) {
				place = "4";
			} else if("CR".equals(tabmode)) {
				place = "6";
			} else if("CC".equals(tabmode)) {
				place = "7";
			} else {
				place = "0";
			}
		}
	} else  {
		place = request.getParameter("place");
	}

	ReservationService reservationService = SpringUtils.getBean(ReservationService.class);
	//추상클래스로 getInstance()로 객체 생성
	Calendar cal	= Calendar.getInstance();
	int year		= Integer.parseInt(reservationService.getYear());
	int month		= (Integer.parseInt(reservationService.getMonth())-1);
	
	//고정 값으로. 비교용.
	int staticYear	= year;
	int staticMonth	= month;
	
	if(request.getParameter("year") != null && request.getParameter("month") != null) {
		year  = Integer.parseInt(request.getParameter("year"));
		month = Integer.parseInt(request.getParameter("month"))-1;
	}
	int today = (Integer.parseInt(reservationService.getDay()));
	cal.set(year, month, 1);
	int startDay	= cal.getMinimum(Calendar.DATE);				// 월의 첫째날 일자
	int endDay		= cal.getActualMaximum(Calendar.DAY_OF_MONTH);	// 월의 마지막 일자
	int start		= cal.get(Calendar.DAY_OF_WEEK);				// 월의 첫째날 요일
	
	int newLine = 0;
   
	String[] daysAm = new String[35];		// 오전 예약 가능/완료/불가 HTML
	String[] daysPm = new String[35];		// 오후 예약 가능/완료/불가 HTML
	String[] allDays = new String[35];		// 종일 예약 가능/완료/불가 HTML
  
	//배열 초기화
	for(int i=0; i < 32; i++) {
		daysAm[i] = "";
		daysPm[i] = "";
		allDays[i] = "";
	}
	//1일이 일요일인 경우

    DataMap savemgrynlist = (DataMap) request.getAttribute("SAVEMGRYNLIST");
    savemgrynlist.setNullToInitialize(true); 


    String p_yyyy = (String)request.getAttribute("yyyy");
    String p_mm = (String)request.getAttribute("mm");
    String p_day = "";

    for(int i = 0 ; i < savemgrynlist.keySize("seqno"); i++) {
        p_day += ","+savemgrynlist.getString("dd",i);
    }
    p_day += ",";


	if("6".equals(place) || "7".equals(place) || "1".equals(place)) {
		int sat = 7 - start + 1;
		for(int i=sat; i < 32; i+=7) {
            if(p_yyyy.equals(String.valueOf(year)) && p_mm.equals(String.valueOf((month+1))) && p_day.indexOf(String.valueOf(","+i+",")) != -1)  {
			    allDays[i]="<font class=\"green\">예약진행</font>";
            } else{
                allDays[i]="<a class=\"redb\" href=javascript:go_rsev("+year+","+ (month+1) +","+ i +","+place+",'all');>예약가능</a>";
            }
            
            if(p_yyyy.equals(String.valueOf(year)) && p_mm.equals(String.valueOf((month+1))) && p_day.indexOf(String.valueOf(","+(i+1)+",")) != -1)  {
			    allDays[i+1]="<font class=\"green\">예약진행</font>";
            } else{
                allDays[i+1]="<a class=\"redb\" href=javascript:go_rsev("+year+","+ (month+1) +","+ (i+1) +","+place+",'all');>예약가능</a>";
            }            
		}		
 	} else {
		if(start == 1) {
			//일요일 셋팅
			for(int i=1; i < 32 ; i+=7) {
                if(p_yyyy.equals(String.valueOf(year)) && p_mm.equals(String.valueOf((month+1))) && p_day.indexOf(String.valueOf(","+i+",")) != -1)  {
                    daysAm[i]="<font class=\"green\">예약진행</font>";
                    daysPm[i]="<font class=\"green\">예약진행</font>";
                    allDays[i]="<font class=\"green\">예약진행</font>";                
                } else {
                    daysAm[i]="<a class=\"redb\" href=javascript:go_rsev("+year+","+ (month+1) +","+ i +","+place+",'am');>예약가능</a>";
                    daysPm[i]="<a class=\"redb\" href=javascript:go_rsev("+year+","+ (month+1) +","+ i +","+place+",'pm');>예약가능</a>";
                    allDays[i]="<a class=\"redb\" href=javascript:go_rsev("+year+","+ (month+1) +","+ i +","+place+",'all');>예약가능</a>";                
                }

			}
			
			//토요일 셋팅
			for(int i=7;i<32 ; i+=7) {
                if(p_yyyy.equals(String.valueOf(year)) && p_mm.equals(String.valueOf((month+1))) && p_day.indexOf(String.valueOf(","+i+",")) != -1)  {
                    daysAm[i]="<font class=\"green\">예약진행</font>";
                    daysPm[i]="<font class=\"green\">예약진행</font>";
                    allDays[i]="<font class=\"green\">예약진행</font>";    
                } else {
                    daysAm[i]="<a class=\"redb\" href=javascript:go_rsev("+year+","+ (month+1) +","+ i +","+place+",'am');>예약가능</a>";
                    daysPm[i]="<a class=\"redb\" href=javascript:go_rsev("+year+","+ (month+1) +","+ i +","+place+",'pm');>예약가능</a>";
                    allDays[i]="<a class=\"redb\" href=javascript:go_rsev("+year+","+ (month+1) +","+ i +","+place+",'all');>예약가능</a>";

                }
			}
		//1일이 일요일이 아닌 경우
		} else {
			int sat = 7 - start + 1;
			for(int i=sat; i < 32; i+=7) {

                if(p_yyyy.equals(String.valueOf(year)) && p_mm.equals(String.valueOf((month+1))) && p_day.indexOf(String.valueOf(","+i+",")) != -1)  {
                    daysAm[i]="<font class=\"green\">예약진행</font>";
                    daysPm[i]="<font class=\"green\">예약진행</font>";
                    allDays[i]="<font class=\"green\">예약진행</font>";   
                } else {
				//토요일 셋팅
                    daysAm[i]="<a class=\"redb\" href=javascript:go_rsev("+year+","+ (month+1) +","+ i +","+place+",'am');>예약가능</a>";
                    daysPm[i]="<a class=\"redb\" href=javascript:go_rsev("+year+","+ (month+1) +","+ i +","+place+",'pm');>예약가능</a>";
                    allDays[i]="<a class=\"redb\" href=javascript:go_rsev("+year+","+ (month+1) +","+ i +","+place+",'all');>예약가능</a>";
				}

                if(p_yyyy.equals(String.valueOf(year)) && p_mm.equals(String.valueOf((month+1))) && p_day.indexOf(String.valueOf(","+(i+1)+",")) != -1)  {
                    daysAm[i+1]="<font class=\"green\">예약진행</font>";
                    daysPm[i+1]="<font class=\"green\">예약진행</font>";
                    allDays[i+1]="<font class=\"green\">예약진행</font>";   
                } else {
                    //일요일 설정
                    daysAm[i+1]="<a class=\"redb\" href=javascript:go_rsev("+year+","+ (month+1) +","+ (i+1) +","+place+",'am');>예약가능</a>";
                    daysPm[i+1]="<a class=\"redb\" href=javascript:go_rsev("+year+","+ (month+1) +","+ (i+1) +","+place+",'pm');>예약가능</a>";
                    allDays[i+1]="<a class=\"redb\" href=javascript:go_rsev("+year+","+ (month+1) +","+ (i+1) +","+place+",'all');>예약가능</a>";
                }
			}
		}
	}

	DataMap holydaylistMap = (DataMap)request.getAttribute("HOLYDAYUILIST_DATA");
	holydaylistMap.setNullToInitialize(true); 
	
	if("6".equals(place) || "7".equals(place) || "1".equals(place)) {
	} else {
		for(int i = 0 ; i < holydaylistMap.keySize(); i++) {	
            if(p_yyyy.equals(String.valueOf(year)) && p_mm.equals(String.valueOf((month+1))) && p_day.indexOf(String.valueOf(","+Integer.parseInt(holydaylistMap.getString("dd", i))+",")) != -1)  {
                daysAm[Integer.parseInt(holydaylistMap.getString("dd", i))]  =  "<font class=\"green\">예약진행</font>";
                daysPm[Integer.parseInt(holydaylistMap.getString("dd", i))]  ="<font class=\"green\">예약진행</font>";
                allDays[Integer.parseInt(holydaylistMap.getString("dd", i))] ="<font class=\"green\">예약진행</font>";
            } else {
                daysAm[Integer.parseInt(holydaylistMap.getString("dd", i))]  =  "<a class=\"redb\" href=javascript:go_rsev("+holydaylistMap.getString("yyyy", i)+","+ Integer.parseInt(holydaylistMap.getString("mm", i)) +","+ Integer.parseInt(holydaylistMap.getString("dd", i)) +","+place+",'am');>예약가능</a>";
                daysPm[Integer.parseInt(holydaylistMap.getString("dd", i))]  ="<a class=\"redb\" href=javascript:go_rsev("+holydaylistMap.getString("yyyy", i)+","+ Integer.parseInt(holydaylistMap.getString("mm", i)) +","+ Integer.parseInt(holydaylistMap.getString("dd", i)) +","+place+",'pm');>예약가능</a>";
                allDays[Integer.parseInt(holydaylistMap.getString("dd", i))] ="<a class=\"redb\" href=javascript:go_rsev("+holydaylistMap.getString("yyyy", i)+","+ Integer.parseInt(holydaylistMap.getString("mm", i)) +","+ Integer.parseInt(holydaylistMap.getString("dd", i)) +","+place+",'all');>예약가능</a>";

            }
		}
	}
	
	DataMap listMap = (DataMap)request.getAttribute("RESERVATION_LIST");
	listMap.setNullToInitialize(true); 
	
	//예약완료 목록 설정
	for(int i = 0 ; i < listMap.keySize("taPk"); i++) {
		int index = Integer.parseInt(listMap.getString("taRentDate",i).substring(6));			// 대여한 일
		int rentMonth = Integer.parseInt(listMap.getString("taRentDate", i).substring(4, 6));	// 대여한 월
		String time=listMap.getString("taRentTime",i);
		
		//선택한 월에 대한 예약완료만 표시해야 한다.
		if((month+1) == rentMonth) {
			
			if(time.equals("am")) {
				daysAm[index] ="<font class=\"green\">예약진행</font>";
			} else if(time.equals("pm")) {
				daysPm[index] ="<font class=\"green\">예약진행</font>";
			} else if(time.equals("all")) {
				if("6".equals(place) || "7".equals(place) || "1".equals(place)) {
				} else {
					allDays[index] ="<font class=\"green\">예약진행</font>";
				}
			}
		}
	}
	
   //오전오후예약시. 종일 예약 불가
   for(int i=0; i<=31; i++) {
	   if(daysAm[i].equals("<font class=\"green\">예약진행</font>") ) {
		   allDays[i] = "<font class=\"gray\">예약진행</font>";
	   } 
	   if(daysPm[i].equals("<font class=\"green\">예약진행</font>") ) {
		   allDays[i] = "<font class=\"gray\">예약진행</font>";
	   }	   
   }
	
   //종일예약시. 오전 오후 예약완료
   for(int i=0; i<=31; i++) {
	   if(allDays[i].equals("<font class=\"green\">예약진행</font>")) {
            if("6".equals(place) || "7".equals(place) || "1".equals(place)) {
            } else {
               daysAm[i] = "<font class=\"gray\">예약진행</font>";
               daysPm[i] = "<font class=\"gray\">예약진행</font>";
            }
	   } 
   }

   if(staticMonth == month ){
	   for(int i=0;i<today;i++){
		   daysAm[i]  = "";
		   daysPm[i]  = "";
		   allDays[i] = "";
	   }
   }
   
	//테스터 월이동 제약 해제 - 임수철, 이수자, 최석호
	String sess_no = "";
	String access  = "";
	 
	if(session.getAttribute("sess_no") != null) {
		sess_no = (String)session.getAttribute("sess_no");
		if(sess_no.equals("A000000008411") || sess_no.equals("B000000003932")) {
			access = "ok";
		}
	}
%>

<script type="text/javascript" language="javascript">

	//테스터 여부. 테스터는 월이동 제약없음.
	var access = "<%= access %>";

	//예약 팝업
	function go_rsev(year, month, day,place,time) {
<%
	String timer = (String)request.getAttribute("timer");
	String myTime = (String)request.getAttribute("today");
	String istimer = (String)request.getAttribute("istimer");
	
	long brack_timer = Long.parseLong(timer);
	long db_timer = Long.parseLong(myTime);
	
%>
<%
	String saveCheck = (String)request.getAttribute("saveCheck");
	if("1".equals(saveCheck)) {
%>
	alert("토요일, 일요일, 공휴일인 경우 익일 평일 오전 09:00 시에 시설물 대여 신청이 가능합니다.");
	return;
<%
	} else {
		if("1".equals(istimer)) {
			if(db_timer <= brack_timer) {
%>
				alert("금일 09:00 시부터 예약이 가능 합니다.");
				return;
<%
			}
		}
%>
	if(place == "0" || place == 0) {
		if(month == "1" || month == "2" || month == "3" || month == "4" || month == "11" || month == "12") {
			alert(month + "월달은 예약 하실수 없습니다.");
			return;
		}
	}
	window.open("/homepage/introduce.do?mode=reservationInfoPop&year="+year+"&month="+month+"&day="+day+"&gubun="+time+"&place="+place ,'popConfirm','status=no,width=600,height=400,scrollbars=no,top=100,left=350');
<%
	}
%>
	}

	//이전달 이동
	function beforeMonth(year,month,place) {

		if(month == '0') {
			month = 12;
			year -= 1;
		}

		if(access != "ok") {
			if( (year==<%=staticYear%> && month==<%=staticMonth%>) || year < <%=staticYear%>) {
				alert('이전달의 예약은 불가능 합니다.');
				return;
			}
		}

		location.href="/homepage/introduce.do?mode=reservation&year="+year+"&month="+month+"&place="+place;
	}

	//다을달 이동.
	function nextMonth(year,month,place) {

		if(access != "ok") {
			if(<%=staticMonth%>+4 <= month) {
				alert('예약은 익월까지만 가능합니다.\n예)현재가 1월이면 2월말까지만 예약가능.');
				return;
			}
		}

		//해가 넘어가면...
		if(month == '13') {
			month = 1;
			year += 1;
		}
		if(access != "ok") {
			if(year-1 == <%=staticYear%> && month == 2) {
				alert('예약은 익월까지만 가능합니다.\n예)현재가 1월이면 2월말까지만 예약가능.');
				return;
			}
		}
		location.href="/homepage/introduce.do?mode=reservation&year="+year+"&month="+month+"&place="+place;
	}
</script>
<jsp:include page="/homepage_new/inc/header.jsp" flush="true" ></jsp:include>
    
    <div id="subContainer">
    
    <div class="subNavi_area">
    
      <jsp:include page="/homepage_new/inc/left6.jsp" flush="true" ></jsp:include>
    
      </div>
    
        <div id="contnets_area">
          <div class="sub_visual6">인재개발원 소개</div>
            <div class="local">
              <h2>시설현황</h2>
                <div class="navi"><img src="/homepage_new/images/common/icon_home.gif" alt="home"> &gt; 인재개발원 소개 &gt; 시설현황 &gt; <span>시설대여 신청</span></div>
            </div>
            <div class="contnets">
            <!-- contnet -->
			
            <ol class="TabSub">
            <li><a href="javascript:fnGoMenu('7','eduinfo7-6');">시설개요</a></li>
            <li><a href="javascript:fnGoMenu('7','eduinfo7-6-2');">층별안내</a></li>
            <!-- li><a href="javascript:fnGoMenu('7','eduinfo7-6-3');">편의시설</a></li -->
            <li><a href="javascript:fnGoMenu('7','eduinfo7-6-4');">시설대여안내</a></li>
            <li class="TabOn"><a href="javascript:fnGoMenu('7','reservation');" onclick="alert('1. 시설 대여 안내 [신청 절차] 확인 바랍니다. \n - 유선상 예약가능 여부 확인 필요 (☏ 032-440-7632) \n\n2. 예약 후 [최종 승인]이 되어야 시설 사용이 가능합니다. \n - 유선상 미확인 신청시 최종 승인 불가 할수 있음 \n\n ※ 본 시설은 교육시설로서 교육(시,군구 행사 포함) 일정 \n및 교육에 지장없는 범위 내에서 시민에게 개방하고 있어 \n타 대관시설에 비해 제약이 있을 수 있습니다.');">시설대여신청</a></li>
            <li><a href="javascript:fnGoMenu('7','reservationConfirm');">시설대여예약확인</a></li>
			<li class="last"><a href="javascript:fnGoMenu('7','reservationSurvey');">시설대여설문</a></li>
          </ol>



<form id="pform" name="pform" method="post">
<div class="h15"></div>
<div class="tabs01">
		<ul>
<%	//체육관 사용여부
	if("Y".equals(gymnasiumYn)) {
%>
			<li><a href="/homepage/introduce.do?mode=reservation&place=4"><img src="../../../images/skin1/common/tab_da05<%if(place.equals("4")) {%>_on<%}%>.gif" alt="체육관" width="105"/></a></li>
<%	} %>

		
<%	//잔디구장 사용여부
	if("Y".equals(groundYn)) {
%>
			<li><a href="/homepage/introduce.do?mode=reservation&place=0"><img src="../../../images/skin1/common/tab_da01<%if(place.equals("0")) {%>_on<%}%>.gif" alt="운동장" width="105"/></a></li>
<%	} %>


<%	//테니스장 사용여부
	if("Y".equals(tennisYn)) {
%>
			<li><a href="/homepage/introduce.do?mode=reservation&place=1"><img src="../../../images/skin1/common/tab_da02<%if(place.equals("1")) {%>_on<%}%>.gif" alt="테니스장" width="105"/></a></li>
<%	} %>

<%	//강당 사용여부
	if("Y".equals(auditoriumYn)) {
%>
			<li><a href="/homepage/introduce.do?mode=reservation&place=3"><img src="../../../images/skin1/common/tab_da04<%if(place.equals("3")) {%>_on<%}%>.gif" alt="강당" width="105"/></a></li>
<%	} %>

<%	//강의실 사용여부
	if("Y".equals(classroomYn)) {
%>
		<li><a href="/homepage/introduce.do?mode=reservation&place=6"><img src="../../../images/skin1/common/tab_da06<%if(place.equals("6")) {%>_on<%}%>.gif" alt="강의실" width="105"/></a></li>
<%	} %>		
<%	//생활관 사용여부
	if("Y".equals(conceptionYn)) {
%>
		<li><a href="/homepage/introduce.do?mode=reservation&place=7"><img src="../../../images/skin1/common/tab_da07<%if(place.equals("7")) {%>_on<%}%>.gif" alt="생활관" width="105"/></a></li>
<%	} %>
		</ul>
	</div>
	
	<div class="h9"></div>
	<font color="blue">
	<% if("4".equals(place)) { %>

	<script type="text/javascript" language="javascript">
	function goImagePopup(){
		var url = "/commonInc/popup/imagePopup.jsp";
		window.open(url, "imagePopup", "width=544, height=763,scrollbars=yes");
	}
	</script>
	<b><a href="javascript:goImagePopup();">체육관준수사항보기</a></b><br />
	<% } %>
	<!-- ※ 강의실, 강당 "주중" 대관은 신청전에 담당자에게 문의하시기 바랍니다. <br /> -->
<%
	if("6".equals(place) || "7".equals(place)) {
%>
	* 사용료는 시설대여 안내를 참고하시기 바랍니다. <br />
	* 냉난방사용료는 별도 부과됩니다.<br />
	* 기타 문의사항은 032-440-7632로 연락주시기 바랍니다.<br />
	* 최종 시설대여승인은 별도로 연락드리겠습니다.<br />
<%
	} 
%>
	※ 운동장, 태니스장은 12~02월 동절기기간동안은 시설보호를 위하여 대관신청을 받지 않습니다.
	</font>
	<div class="year">
		<a href='javascript:beforeMonth(<%=year %>,<%=month %>,<%=place %>);'><img src="../../../images/skin1/icon/icon_prev.gif" alt="이전" class="ac" /></a>
		<a href="#" class="ml30"><strong class="c_000"><%=year %>년 <%=month+1 %>월</strong></a>
		<a href='javascript:nextMonth(<%=year %>,<%=month+2%>,<%=place %>);' class="ml30"><img src="../../../images/skin1/icon/icon_next.gif" alt="다음" class="ac"/></a>
	</div>


	<div class="space"></div>
		<table class="dataH03">	
			<colgroup>
				<col width="120" />
				<col width="70" />
				<col width="70" />
				<col width="70" />
				<col width="70" />
				<col width="70" />
				<col width="70" />
				<col width="70" />
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
		 	/*********************
		 	 * 달력을 그린다.
		 	 *********************/
		 	//시간대 그리기
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

		 	//달력 그리기
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
						out.print("<td class=\""+className+"\"><Font  class=\"num\" Color="+color+">"+ i + "</font>");
						out.print("<br />"+daysAm[i]);
						out.print("<br />"+daysPm[i]);
						out.print("<br />"+allDays[i]);					
					} else {
						out.print("<td class=\""+className+"\"><Font  class=\"num\" Color="+color+">"+ i + "</font>");
						out.print("<br />"+daysAm[i]);
						out.print("<br />"+daysPm[i]);
						out.print("<br />"+allDays[i]);
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
					if(i < endDay) {
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
			
</form>              
              <jsp:include page="/homepage_new/inc/admin_info.jsp" flush="true" ><jsp:param name="menucode" value="M100038" /></jsp:include>
              <div class="h80"></div>   
            <!-- //contnet -->
          </div>
        </div>
    
    
    </div>

    <jsp:include page="/homepage_new/inc/footer.jsp" flush="true" ></jsp:include>