<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="ut.lib.util.Util" %>

<%
String mode = Util.getValue(request.getParameter("mode"), "requestList");
int num = 0;

if(mode.equals("policy")){   
	num = 1;
}else if(mode.equals("worktel")){   
	num = 2;
}else if(mode.equals("spam")){   
	num = 3;
}else if(mode.equals("sitemap")){   
	num = 4;
}else if(mode.equals("eduinfo7-7")){  
	num = 5;
}else if(mode.equals("lecturer1") || mode.equals("lecturer2") || mode.equals("lecturer3") || mode.equals("lecturer4")){  
	num = 6;
}else if(mode.equals("lecturerSearch") || mode.equals("fromLecturer")){  
	num = 7;
}else if(mode.equals("videopolicy")){  
	num = 8;
}
%>
<!-- login -->
			<jsp:include page="/login/main_login.jsp" flush="false"/>					
			<!-- //login -->
           <!-- suvNavi -->
        <div id="subNavi_area">
          <p class="title"><img src="/homepage_new/images/M7/sub_title.gif" alt="고객지원"></p>
          		<div class="sn">
                  <ul>
                    	<li><a href="/homepage/index.do?mode=policy" <%if(num == 1){ %>class="on"<%} %>>개인정보처리방침</a></li>
                    	<li><a href="/homepage/index.do?mode=videopolicy" <%if(num == 8){ %>class="on"<%} %>>영상정보처리기기 방침</a></li>
                        <li><a href="/homepage/index.do?mode=worktel" <%if(num == 2){ %>class="on"<%} %>>업무별연락처</a></li>
                        <li><a href="/homepage/index.do?mode=spam" <%if(num == 3){ %>class="on"<%} %>>이메일 무단수집거부</a></li>
						
						<!-- li><a href="/homepage/lecturer.do?mode=lecturer1" <%if(num == 6){ %>class="on"<%} %>>강사등록</a></li>
						<li><a href="/homepage/lecturer.do?mode=lecturerSearch" <%if(num == 7){ %>class="on"<%} %>>강사등록조회</a></li -->

                        <li><a href="/homepage/index.do?mode=sitemap" <%if(num == 4){ %>class="on"<%} %>>사이트맵</a></li>
                        <li><a href="javascript:fnGoMenu('7','eduinfo7-7');" <%if(num == 5){ %>class="on"<%} %>>찾아오시는길</a></li>
                    </ul>
                </div>
            </div>
            <!-- //suvNavi -->