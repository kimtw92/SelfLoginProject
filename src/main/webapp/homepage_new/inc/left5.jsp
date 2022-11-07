<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="ut.lib.util.Util" %>

<%
String mode = Util.getValue(request.getParameter("mode"), "requestList");
int num = 0;

if(mode.equals("eduinfo8-1") || mode.equals("eduinfo8-2") || mode.equals("eduinfo8-3")){   
	num = 1;
}else if(mode.equals("faqList") || mode.equals("faqView")){   
	num = 2;
}else if(mode.equals("educationDataList") || mode.equals("educationDataView") || mode.equals("lectureList") || mode.equals("lectureView") || mode.equals("programList") || mode.equals("programView")){   
	num = 3;
}else if(mode.equals("eduinfotel")){   
	num = 4;
}else if(mode.equals("readingList")){   
	num = 6;
}else if(mode.equals("courseTimetable")){   
	num = 7;
}else if(mode.equals("eduinfo7-4")){   
	num = 8;
}  
%>
<!-- login -->
			<jsp:include page="/login/main_login.jsp" flush="false"/>					
			<!-- //login -->
            
            <!-- suvNavi -->
        <div id="subNavi_area">
          <p class="title"><img src="/homepage_new/images/M5/sub_title.gif" alt="교육지원"></p>
                <div class="sn">
                  	<ul>
                    	<li><a href="/homepage/renewal.do?mode=eduinfo8-1" <%if(num == 1){ %>class="on"<%} %>>분야별교육안내</a>
                    	<%-- <%if(num == 1){ %>
                        	<ul>
                                <li><%if(mode.equals("eduinfo8-1")){ %><span>집합교육</span><%}else{ %><a href="/homepage/renewal.do?mode=eduinfo8-1">집합교육</a><%} %></li>
                                <li><%if(mode.equals("eduinfo8-2")){ %><span>전문사이버교육</span><%}else{ %><a href="/homepage/renewal.do?mode=eduinfo8-2">전문사이버교육</a><%} %></li>
                                <li><%if(mode.equals("eduinfo8-3")){ %><span>외부사이버교육</span><%}else{ %><a href="/homepage/renewal.do?mode=eduinfo8-3">외부사이버교육</a><%} %></li>
                           </ul>
                        <%} %> --%>
                        </li>
                        <li><a href="javascript:fnGoMenu('5','faqList');" <%if(num == 2){ %>class="on"<%} %>>자주하는질문</a></li>
                        <li><a href="javascript:fnGoMenu('5','educationDataList');" <%if(num == 3){ %>class="on"<%} %>>자료실</a>
                        <%if(num == 3){ %>
                        	<ul>
                                <li><%if(mode.equals("educationDataList")||mode.equals("educationDataView")){ %><span>교육자료</span><%}else{ %><a href="javascript:fnGoMenu('5','educationDataList');">교육자료</a><%} %></li>
                                <li><%if(mode.equals("lectureList")||mode.equals("lectureView")){ %><span>강의교재</span><%}else{ %><a href="javascript:fnGoMenu('5','lectureList');">강의교재</a><%} %></li>
                                <li><%if(mode.equals("programList")||mode.equals("programView")){ %><span>학습프로그램</span><%}else{ %><a href="javascript:fnGoMenu('5','programList');">학습프로그램</a><%} %></li>
                           </ul>
                        <%} %>
                        </li>
                        <li><a href="/homepage/renewal.do?mode=eduinfotel" <%if(num == 4){ %>class="on"<%} %>>과정별 안내전화</a></li>
                        <%-- <li><a href="http://152.99.42.138/" target = "_blank" <%if(num == 5){ %>class="on"<%} %>>e-도서관</a></li> --%>
                        <li><a href="/homepage/renewal.do?mode=readingList" <%if(num == 6){ %>class="on"<%} %>>교육생숙지사항</a></li>
                        <li><a href="/homepage/renewal.do?mode=courseTimetable" <%if(num == 7){ %>class="on"<%} %>>과정시간표</a></li>
                        <li><a href="javascript:fnGoMenu('7','eduinfo7-4');" <%if(num == 8){ %>class="on"<%} %>>식단표</a></li>
                    </ul>
                </div>
            </div>
            <!-- //suvNavi -->