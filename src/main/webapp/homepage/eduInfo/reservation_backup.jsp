<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
// prgnm 	: 
// date		: 2008-08-28
// auth 	: 양정환
%>

<%@ include file="/commonInc/include/commonImport.jsp" %>
<%@ include file="/commonInc/include/comInclude.jsp" %>
<jsp:include page="/commonInc/include/comHtmlTop.jsp" flush="false">
	<jsp:param name="cssName" value="layout" />
</jsp:include>

<script>
	function go_rsevAm(year, month, day) {
		location.href="/homepage/introduce.do?mode=reservationform&year="+year+"&month="+month+"&day="+day+"&gubun=am";
	}
	function go_rsevPm(year, month, day) {
		location.href="/homepage/introduce.do?mode=reservationform&year="+year+"&month="+month+"&day="+day+"&gubun=pm";
	}	
</script>

<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<form id="pform" name="pform" method="post">

<div id="wrapper">
	<div id="dvwhset">
		<div id="dvwh">
		
			<!--[s] header -->
			<jsp:include page="/commonInc/include/comHeader.jsp" flush="false">
				<jsp:param name="topMenu" value="7" />
			</jsp:include>
			<!--[e] header -->						
			
			<div id="middle">			
				<!--[s] left -->
				<jsp:include page="/commonInc/include/comLeftMenu.jsp" flush="false">
					<jsp:param name="leftMenu" value="6" />
					<jsp:param name="leftIndex" value="6" />
					<jsp:param name="leftSubIndex" value="5" />
				</jsp:include>
				<!--[e] left -->
				

	<!-- contentOut s ===================== -->
	<div id="subContentArear">
		<!-- content image -->
		<div id="contImg"><img src="/images/skin1/sub/img_cont05.gif" alt="교육원소개" /></div>
		<!-- //content image -->

		<!-- title/location -->
		<div id="top_title">
			<h1 id="title"><img src="/images/skin1/title/tit_0506.gif" alt="시설현황" /></h1>
			<div id="location">
			<ul> 
				<li class="home"><a href="">HOME</a></li>
				<li>교육원소개</li>
				<li class="on">시설현황</li>
			</ul>
			</div>
		</div>
		<!-- title/location -->
		<div class="spaceTop"></div>

		<!-- content s ===================== -->
<%
   Calendar cal = Calendar.getInstance();
   // 추상클래스로 getInstance()로 객체 생성
   int year = cal.get(Calendar.YEAR);
   int month = cal.get(Calendar.MONTH);
   int today = cal.get(Calendar.DAY_OF_MONTH);
   
   cal.set(year, month, 1); 
   int startDay = cal.getMinimum(Calendar.DATE);
   int endDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
   int start = cal.get(Calendar.DAY_OF_WEEK);
   
   int newLine = 0;
   
  String[] daysAm= {"","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""};
  String[] daysPm= {"","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""};
   
   for(int i=0; i<32; i++) {
	   daysAm[i]="<a href=javascript:go_rsevAm("+year+","+ (month+1) +","+ i +");>예약가능</a>";
   }

   for(int i=0; i<32; i++) {
	   daysPm[i]="<a href=javascript:go_rsevPm("+year+","+ (month+1) +","+ i +");>예약가능</a>";
   }

   for(int i=0; i<=today+1; i++) {
	   daysAm[i]="예약불가";
	   daysPm[i]="예약불가";
   }
   

	DataMap listMap = (DataMap)request.getAttribute("RESERVATION_LIST");
	listMap.setNullToInitialize(true); 
	
	
	for(int i = 0 ; i < listMap.keySize("status"); i++) {
		if(listMap.getString("section",i).equals("0")) {
			int index = Integer.parseInt(listMap.getString("resvDay",i).substring(6));
			
			if(listMap.getString("status",i).equals("1")){
				daysAm[index] = "예약불가";
			}else if(listMap.getString("status",i).equals("2")){
				daysAm[index] = "예약중";
			}else if(listMap.getString("status",i).equals("3")){
				daysAm[index] = "예약완료";
			}
		}else if(listMap.getString("section").equals("1")) {
			int index = Integer.parseInt(listMap.getString("resvDay",i).substring(6));
			
			if(listMap.getString("status",i).equals("1")){
				daysPm[index] = "예약불가";
			}else if(listMap.getString("status",i).equals("2")){
				daysPm[index] = "예약중";
			}else if(listMap.getString("status",i).equals("3")){
				daysPm[index] = "예약완료";
			}			
		}
	}

%>

<b><%=month+1 %>월 예약현황<%=today %></b>
<table border="1">
<tr><td>구분</td><td width=55>일</td><td width=55>월</td><td width=55>화</td><td width=55>수</td><td width=55>목</td><td width=55>금</td><td width=55>토</td></tr>
 <%
 	out.print("<td>&nbsp;</td>");
 
 	for(int i = 1; i < start; i++){
		out.print("<td>&nbsp;</td>");
 		newLine++;
	}

	for(int i = 1; i <= endDay; i++){
		String color = (newLine == 0) ? "RED" : (newLine==6)? "BLUE":"BLACK"; 
		out.print("<td align=RIGHT><Font Color="
					+color+">"+ i + "</font><br>"+daysAm[i]+"<br>"+daysPm[i]+"</td>");
		newLine++;
		
		if(newLine == 7){
			out.print("</TR>");
			if(i <= endDay){
				out.print("<TR>");
				out.print("<td>&nbsp;<br>오전<br>오후</td>");
			}
			newLine = 0;
		}
	}

	while(newLine > 0 && newLine < 7){
		out.print("<td>&nbsp;</td>");
		newLine++;
	}
 %>
<tr></tr>
	
</table>
		<!-- //content e ===================== -->

	</div>
	<!-- //contentOut e ===================== -->




				
				
				
				
								<div class="spaceBtt"></div>
			</div>			
		</div>
		
		<div id="divQuickMenu" style="position:absolute; top:10; left:89%; width:90px; height:264px; z-index:1">
			<!--[s] quick -->
			<jsp:include page="/commonInc/include/comQuick.jsp" flush="false"/>
			<!--[e] quick -->
		</div>
	</div>
	<!--[s] footer -->
	<jsp:include page="/commonInc/include/comFoot.jsp" flush="false"/>
	<!--[e] footer -->
</div>

</form>
</body>					