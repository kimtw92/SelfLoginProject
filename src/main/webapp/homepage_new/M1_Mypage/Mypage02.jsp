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
                        <li><a href="Mypage02.jsp" class="on">교육신청 및 취소</a></li>
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
              <h2>교육신청 및 취소</h2>
                <div class="navi"><img src="../images/common/icon_home.gif" alt="home"> &gt; 마이페이지 &gt; 교육신청 및 취소 &gt; <span>교육신청</span></div>
            </div>
            <div class="contnets">
            <!-- contnet -->
			
            <div class="mytab01">
              <ul>
                <li><a href="Mypage02.jsp"><img src="../images/M1/2tab01_on.gif" alt="교육신청"/></a></li><li><a href="Mypage02_02.jsp"><img src="../images/M1/2tab02.gif" alt="교육신청이력"/></a></li>
              </ul>
              </div>
              
              
            <!-- //contnet -->
          </div>
        </div>
    
    
    </div>

    <jsp:include page="../inc/footer.jsp" flush="true" ></jsp:include>