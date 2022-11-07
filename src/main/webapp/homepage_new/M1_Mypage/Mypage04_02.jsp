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
                    	<li><a href="Mypage01.jsp">나의강의실</a></li>
                        <li><a href="Mypage02.jsp">교육신청 및 취소</a></li>
                        <li><a href="Mypage03.jsp">수료내역</a></li>
                        <li><a href="Mypage04.jsp" class="on">개인정보</a>
                            <ul>
                                <li><a href="Mypage04.jsp">나의질문</a></li>
                                <li><span>개인정보변경</span></li>
                           </ul>
                        </li>
                        <li><a href="Mypage05.jsp">회원탈퇴</a></li>
                    </ul>
                </div>
            </div>
            <!-- //suvNavi -->
    
      </div>
    
        <div id="contnets_area">
          <div class="sub_visual"><img src="../images/common/sub_visual1.jpg" alt="인재원 소개 인천광역시 인재개발원에 대한 소개 및 시설정보를 제공합니다."></div>
            <div class="local">
              <h2>개인정보</h2>
                <div class="navi"><img src="../images/common/icon_home.gif" alt="home"> &gt; 마이페이지 &gt; 개인정보 &gt; <span>개인정보변경</span></div>
            </div>
            <div class="contnets">
            <!-- contnet -->
            
            <!-- //contnet -->
          </div>
        </div>
    
    
    </div>

    <jsp:include page="../inc/footer.jsp" flush="true" ></jsp:include>