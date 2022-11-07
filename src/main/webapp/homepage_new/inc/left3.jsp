<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="ut.lib.util.Util" %>

<%
String mode = Util.getValue(request.getParameter("mode"), "main");
%>
<!-- login -->
			<jsp:include page="/login/main_login.jsp" flush="false"/>					
			<!-- //login -->
            <!-- suvNavi -->
        <div id="subNavi_area">
          <p class="title"><img src="/homepage_new/images/M3/sub_title.gif" alt="교육신청"></p>
                <div class="sn">
                  <ul>
                    	<li><a href="javascript:fnGoMenu('4','attendList');" <%if(mode.equals("attendList")){ %>class="on"<%} %>> 교육신청 및 취소</a></li>                    	
                    	<%-- <li><a href="javascript:fnGoMenu('4','yearof2016');" <%if(mode.equals("cityList")){ %>class="on"<%} %>> 수료현황 및 추천과정</a></li> --%>
                    </ul>
                </div>
            </div>
            <!-- //suvNavi -->
            