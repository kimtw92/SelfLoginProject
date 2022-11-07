<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="ut.lib.util.Util" %>

<%
String mode = Util.getValue(request.getParameter("mode"), "main");

if(mode.equals("selectCourseList") || mode.equals("courseDetail") || mode.equals("selectGrnoticeList") || mode.equals("grnoticeListView") || mode.equals("pollList") 
		|| mode.equals("testView") || mode.equals("discussList") || mode.equals("suggestionList") || mode.equals("discussView") || mode.equals("discussWrite") || mode.equals("discussModify") 
		|| mode.equals("suggestionWrite")|| mode.equals("suggestionView") || mode.equals("suggestionModify") || mode.equals("sameClassView") || mode.equals("sameClassList") || mode.equals("courseInfoDetail")){   
	mode = "main";
}
%>
<!-- login -->
			<jsp:include page="/login/main_login.jsp" flush="false"/>					
			<!-- //login -->
           <!-- suvNavi -->
        <div id="subNavi_area">
          <p class="title"><img src="/homepage_new/images/M1/sub_title.gif" alt="마이페이지"></p>
                <div class="sn">
                  <ul>
						<li><a href="javascript:fnGoMenu('1','main');" <%if(mode.equals("main")){ %>class="on"<%} %>>나의강의실</a></li>
                        <li><a href="javascript:fnGoMenu('1','attendList');" <%if(mode.equals("attendList") ||mode.equals("attendDetail")){ %>class="on"<%} %>>교육신청 및 취소</a></li>
                        <li><a href="javascript:fnGoMenu('1','completionList');" <%if(mode.equals("completionList")){ %>class="on"<%} %> >수료내역</a></li>
                        <li><a href="javascript:fnGoMenu('1','myquestion')" <%if(mode.equals("myquestion") || mode.equals("personalinfomodify")){ %>class="on"<%} %> >개인정보</a>
                        	<%if(mode.equals("myquestion")){ %>
                        	<ul>
                                <li><span>나의질문</span></li>
                                <li><a href="javascript:fnGoMenu('1','personalinfomodify')">개인정보변경</a></li>
                           </ul>
                           <%}else if(mode.equals("personalinfomodify")){ %>
                           <ul>
                                <li><a href="javascript:fnGoMenu('1','myquestion')">나의질문</a></li>
                                <li><span>개인정보변경</span></li>
                           </ul>
                           <%} %>
                           </li>
                        <li><a href="javascript:fnGoMenu('1','memberout');" <%if(mode.equals("memberout")){ %>class="on"<%} %> >회원탈퇴</a></li>
                    </ul>
                </div>
            </div>
            <!-- //suvNavi -->