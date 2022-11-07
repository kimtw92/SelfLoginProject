<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="../inc/header.jsp" flush="true" ></jsp:include>
    
    <div id="subContainer">
    
    <div class="subNavi_area">
    
      <jsp:include page="../inc/left.jsp" flush="true" ></jsp:include>
      <!-- suvNavi -->
        <div id="subNavi_area">
          <p class="title"><img src="../images/M1/sub_title.gif" alt="마이페이지"></p>
                <div class="sn">
                  <ul>
                    	<li><a href="Mypage01.jsp" class="on">나의강의실</a></li>
                        <li><a href="Mypage02.jsp">교육신청 및 취소</a></li>
                        <li><a href="Mypage03.jsp">수료내역</a></li>
                        <li><a href="Mypage04.jsp">개인정보</a></li>
                        <li><a href="Mypage05.jsp">회원탈퇴</a></li>
                    </ul>
                </div>
            </div>
            <!-- //suvNavi -->
    
      </div>
    
        <div id="contnets_area">
          <div class="sub_visual1">마이페이지</div>
            <div class="local">
              <h2>나의강의실</h2>
                <div class="navi"><img src="../images/common/icon_home.gif" alt="home"> &gt; 마이페이지 &gt; <span>나의강의실</span></div>
            </div>
            <div class="contnets">
            <!-- contnet -->
			
            <div class="mytab01">
              <ul>
                <li><a href="Mypage01_02.jsp"><img src="../images/M1/tab01.gif" alt="과정리스트"/></a></li><li><a href="Mypage01_03.jsp"><img src="../images/M1/tab02_on.gif" alt="과정공지"/></a></li><li><a href="Mypage01_04.jsp"><img src="../images/M1/tab03.gif" alt="과정설문"/></a></li><li><a href="Mypage01_05.jsp"><img src="../images/M1/tab04.gif" alt="과정평가"/></a></li><li><a href="Mypage01_06.jsp"><img src="../images/M1/tab05.gif" alt="과정토론방"/></a></li><li><a href="Mypage01_07.jsp"><img src="../images/M1/tab06.gif" alt="과정질문방"/></a></li><li><a href="Mypage01_08.jsp"><img src="../images/M1/tab07.gif" alt="교과안내문"/></a></li><li><a href="Mypage01_09.jsp"><img src="../images/M1/tab08.gif" alt="동기모임"/></a></li>
              </ul>
              </div>
              
              
            <!-- //contnet -->
          </div>
        </div>
    
    
    </div>

    <jsp:include page="../inc/footer.jsp" flush="true" ></jsp:include>