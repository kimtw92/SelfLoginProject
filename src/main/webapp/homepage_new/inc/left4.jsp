<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="ut.lib.util.Util" %>

<%
String mode = Util.getValue(request.getParameter("mode"), "requestList");
int num = 0;

if(mode.equals("requestList") || mode.equals("requestView") || mode.equals("requestWrite") || mode.equals("requestModify")){   
	num = 1;
}else if(mode.equals("webzine")){   
	num = 2;
}else if(mode.equals("eduinfo6-1")){   
	num = 3;
}else if(mode.equals("epilogueList") || mode.equals("epilogueView") || mode.equals("epilogueWrite") || mode.equals("epilogueModify")){   
	num = 4;
}else if(mode.equals("uploadbbsList")){
	num = 5;
}
%>
<!-- login -->
			<jsp:include page="/login/main_login.jsp" flush="false"/>					
			<!-- //login -->
           <!-- suvNavi -->
        <div id="subNavi_area">
          <p class="title"><img src="/homepage_new/images/M4/sub_title.gif" alt="참여공간"></p>
          		<div class="sn">
                  <ul>
                  		<li><a href="javascript:fnGoMenu('5','uploadbbsList');" <%if(num == 5){ %>class="on"<%} %>>신임인재평가</a></li>
                    	<li><a href="javascript:fnGoMenu('5','requestList');" <%if(num == 1){ %>class="on"<%} %>>묻고답하기</a></li>
                        <%-- <li><a href="javascript:fnGoMenu('5','webzine');" <%if(num == 2){ %>class="on"<%} %>>포토갤러리-</a></li> --%>
<%--                         <li><a href="javascript:fnGoMenu('6','eduinfo6-1');" <%if(num == 3){ %>class="on"<%} %>>E-book</a></li> --%>
                        <li><a href="javascript:fnGoMenu('5','epilogueList');" <%if(num == 4){ %>class="on"<%} %>>수강후기</a></li>
                    </ul>
                </div>
            </div>
            <!-- //suvNavi -->