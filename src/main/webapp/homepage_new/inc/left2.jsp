<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="ut.lib.util.Util" %>

<%
String mode = Util.getValue(request.getParameter("mode"), "main");
String sub = "";
if(mode.equals("eduinfo3-1") || mode.equals("eduinfo3-2")  || mode.equals("eduinfo3-3") || mode.equals("eduinfo3-11") || mode.equals("eduinfo3-12")){
	sub = mode.substring(9);

	mode = "eduinfo3";
}
if(mode.equals("eduinfo3-4") || mode.equals("eduinfo3-8") || mode.equals("eduinfo3-9")){
	sub = mode.substring(mode.length()-1);
	mode = "eduinfo4";
}
%>
<!-- login -->
			<jsp:include page="/login/main_login.jsp" flush="false"/>					
			<!-- //login -->
            <!-- suvNavi -->
        <div id="subNavi_area">
          <p class="title"><img src="/homepage_new/images/M2/sub_title.gif" alt="교육과정"></p>
                <div class="sn">
                  <ul>
                    	<li><a href="javascript:fnGoMenu('2','eduinfo2-1');" <%if(mode.equals("eduinfo2-1")){ %>class="on"<%} %> >입교안내</a></li>
                        <li><a href="javascript:fnGoMenu('2','eduinfo2-2');" <%if(mode.equals("eduinfo2-2")){ %>class="on"<%} %> >교육훈련체계</a></li>
                        <li><a href="javascript:fnGoMenu('2','eduinfo2-3');" <%if(mode.equals("eduinfo2-3")||mode.equals("searchcourse")){ %>class="on"<%} %> >연간교육일정</a></li>
                        <li><a href="javascript:fnGoMenu('3','eduinfo3-1');" <%if(mode.equals("eduinfo3")){ %>class="on"<%} %> >집합교육</a>
                        	 <%if(mode.equals("eduinfo3")){ %>
                        	<ul>
                            	<li><%if(sub.equals("1")){ %><span>기본교육</span><%}else{ %><a href="javascript:fnGoMenu('3','eduinfo3-1');">기본교육</a><%} %></li>
                                <li><%if(sub.equals("3")){ %><span>전문교육</span><%}else{ %><a href="javascript:fnGoMenu('3','eduinfo3-3');">전문교육</a><%} %></li>
                                <li><%if(sub.equals("2")){ %><span>장기교육</span><%}else{ %><a href="javascript:fnGoMenu('3','eduinfo3-2')">장기교육</a><%} %></li>
                                <!-- li><%if(sub.equals("11")){ %><span>군·구방문교육</span><%}else{ %><a href="/homepage/renewal.do?mode=eduinfo3-11">군·구방문교육</a><%} %></li -->
                                <!-- li><%if(sub.equals("12")){ %><span>국제교류상호공무원연수</span><%}else{ %><a href="/homepage/renewal.do?mode=eduinfo3-12">국제교류상호공무원연수</a><%} %></li -->
                            </ul>
                            <%} %>
                        </li>
                        <li><a href="javascript:fnGoMenu('3','eduinfo3-4');" <%if(mode.equals("eduinfo4")){ %>class="on"<%} %> >e-러닝</a>
                        	<%if(mode.equals("eduinfo4")){ %>
                        	<ul>
                            	<li><%if(sub.equals("4")){ %><span>전문교육</span><%}else{ %><a href="javascript:fnGoMenu('3','eduinfo3-4');">전문교육</a><%} %></li>
                                <li><%if(sub.equals("8")){ %><span>외국어교육</span><%}else{ %><a href="/homepage/renewal.do?mode=eduinfo3-8">외국어교육</a><%} %></li>
                                
								<!-- li><%if(sub.equals("9")){ %><span>공직자청렴교육</span><%}else{ %><a href="/homepage/renewal.do?mode=eduinfo3-9">공직자청렴교육</a><%} %></li -->

                            </ul>
                            <%} %>
                        </li>
                        <!-- li><a href="javascript:fnGoMenu('5','opencourse');" <%if(mode.equals("opencourse")){ %>class="on"<%} %> >공개강의</a></li -->
                    </ul>
                </div>
            </div>
            <!-- //suvNavi -->