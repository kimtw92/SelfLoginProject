<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="ut.lib.util.Util" %>

<%
String mode = Util.getValue(request.getParameter("mode"), "main");
int num = 0;
if(mode.equals("eduinfo7-1")){   
	num = 1;
}else if(mode.equals("introduction02")){   
	num = 2;
}else if(mode.equals("eduinfo7-8")){   
	num = 3;
}else if(mode.equals("eduinfo7-2")){   
	num = 4;
}else if(mode.equals("eduinfo7-3")){   
	num = 5;
}else if(mode.equals("noticeList") || mode.equals("noticeView")){   
	num = 6;
}else if(mode.equals("lawsList") || mode.equals("lawsView")){  
	num = 7;
}else if(mode.equals("eduinfo7-6")||mode.equals("eduinfo7-6-2")||mode.equals("eduinfo7-6-3")||mode.equals("eduinfo7-6-4")||mode.equals("reservation")||mode.equals("reservationConfirm")){
	num = 8;
}else if(mode.equals("eduinfo7-7")){  
	num = 9;
}
%>
<!-- login -->
			<jsp:include page="/login/main_login.jsp" flush="false"/>					
			<!-- //login -->
            <!-- suvNavi -->
        <div id="subNavi_area">
          <p class="title"><img src="/homepage_new/images/M6/sub_title.gif" alt="인재개발원 소개"></p>
                <div class="sn">
                  <ul>
                    	<li><a href="javascript:fnGoMenu('7','eduinfo7-1');" <%if(num == 1){ %>class="on"<%} %>>인사말</a></li>
                        <li><a href="/homepage/renewal.do?mode=introduction02" <%if(num == 2){ %>class="on"<%} %>>비전 및 목표</a></li>
                        <!-- li><a href="javascript:fnGoMenu('7','eduinfo7-8');" <%if(num == 3){ %>class="on"<%} %>>안내동영상</a></li -->
                        <li><a href="javascript:fnGoMenu('7','eduinfo7-2');" <%if(num == 4){ %>class="on"<%} %>>연혁</a></li>
                        <li><a href="javascript:fnGoMenu('7','eduinfo7-3');" <%if(num == 5){ %>class="on"<%} %>>조직 및 업무</a></li>
                        <li><a href="javascript:fnGoMenu('5','noticeList');" <%if(num == 6){ %>class="on"<%} %>>인재개발원 알림</a></li>
                        <li><a href="javascript:fnGoMenu('7','lawsList');" <%if(num == 7){ %>class="on"<%} %>>법률/조례</a></li>
                        <li><a href="javascript:fnGoMenu('7','eduinfo7-6');" <%if(num == 8){ %>class="on"<%} %>>시설현황</a>
                        <%-- <%if(num == 8){ %>
                        	<ul>
                                	<li><%if(mode.equals("eduinfo7-6")){ %><span>시설개요</span><%}else{ %><a href="javascript:fnGoMenu('7','eduinfo7-6');">시설개요</a><%} %></li>
                                    <li><%if(mode.equals("eduinfo7-6-2")){ %><span>층별안내</span><%}else{ %><a href="javascript:fnGoMenu('7','eduinfo7-6-2');">층별안내</a><%} %></li>
                                    <li><%if(mode.equals("eduinfo7-6-3")){ %><span>편의시설</span><%}else{ %><a href="javascript:fnGoMenu('7','eduinfo7-6-3');">편의시설</a><%} %></li>
                                    <li><%if(mode.equals("eduinfo7-6-4")){ %><span>시설대여 안내</span><%}else{ %><a href="javascript:fnGoMenu('7','eduinfo7-6-4');">시설대여 안내</a><%} %></li>
                                    <li><%if(mode.equals("reservation")){ %><span>시설대여 신청</span><%}else{ %><a href="javascript:fnGoMenu('7','reservation');">시설대여 신청</a><%} %></li>
                                    <li><%if(mode.equals("reservationConfirm")){ %><span>시설대여 예약확인</span><%}else{ %><a href="javascript:fnGoMenu('7','reservationConfirm');">시설대여 예약확인</a><%} %></li>
                                </ul>
                         <%} %> --%>
                         </li>
                         <%-- <li><a href="javascript:fnGoMenu('7','eduinfo7-7');" <%if(num == 9){ %>class="on"<%} %>>찾아오시는길</a></li> --%>
                    </ul>
                </div>
            </div>
            <!-- //suvNavi -->