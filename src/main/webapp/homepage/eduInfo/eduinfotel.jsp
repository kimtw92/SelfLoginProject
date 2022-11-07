<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commonInc/include/commonImport.jsp" %>
<%@ include file="/commonInc/include/comInclude.jsp" %>
<jsp:include page="/commonInc/include/comHtmlTop.jsp" flush="false">
	<jsp:param name="cssName" value="layout" />
</jsp:include>
<jsp:include page="/homepage_new/inc/header.jsp" flush="true" ></jsp:include>
    
    <div id="subContainer">
    
    <div class="subNavi_area">
    
      <jsp:include page="/homepage_new/inc/left5.jsp" flush="true" ></jsp:include>
    
      </div>
    
        <div id="contnets_area">
          <div class="sub_visual"><img src="/homepage_new/images/common/sub_visual5.jpg" alt="인재원 소개 인천광역시 인재개발원에 대한 소개 및 시설정보를 제공합니다."></div>
            <div class="local">
              <h2>과정별 안내전화</h2>
                <div class="navi"><img src="/homepage_new/images/common/icon_home.gif" alt="home"> &gt; 교육지원 &gt; <span>과정별 안내전화</span></div>
            </div>
            <div class="contnets">
            <!-- contnet -->
            <ul class="list_style3">
					  <table class="table_st3" style="height:450px; width:100%;" cellpadding="0" cellspacing="0"> 
			            <thead>
			            <tr>
			                <th>구분</th>
			                <th>과정명</th>
			                <th>성명</th>
                            <th>전화번호</th>
                            <th>비고</th>
			            </tr>
                        </thead>
                        <tbody>
			            <tr>
			                <td rowspan="5">집합교육</td>
			                <td>국정가치·시책·역량교육</td>
			                <td>임정숙<br>서하영<br>송민근</td>
                            <td>032-440-7663<br>032-440-7662<br>032-440-7664</td>
                            <td>역량개발팀</td>
			                
			                
			            </tr>
			            <tr>
			           		<td>신임인재양성과정</td>
			                <td>이강미</td>
                            <td>032-440-7674</td>
                            <td rowspan="3">장기교육팀</td>			               
			            </tr>
			            <tr>
			                <td>중견간부양성과정</td>
			                <td>이기수</td>
                            <td>032-440-7673</td>
			            </tr>
                        <tr>
			                <td>외국어정예과정</td>
			                <td>신경희</td>
                            <td>032-440-7675</td>
			            </tr> 
                        <tr>
			                <td>직무전문과정</td>
			                <td>김병국<br>김수진</td>
                            <td>032-440-7683<br>032-440-7685</td>
                            <td>전문교육팀</td>
			            </tr>
                        <tr>
			                <td rowspan="2">e-러닝</td>
			                <td>외국어 교육</td>
			                <td>하태성</td>
                            <td>032-440-7682</td>
                            <td rowspan="2">전문교육팀</td>
			            </tr>
                        <tr>
			                <td>전문 교육</td>
			                <td>김기진</td>
                            <td>032-440-7684</td>
			            </tr>
                        <tr>
			                <td rowspan="3">기타</td>
			                <td>강사수당</td>
			                <td>강호경</td>
                            <td>032-440-7652</td>
                            <td>기획평가팀</td>
			            </tr>
                        <tr>
			                <td>시설물 대관문의</td>
			                <td>김미정</td>
                            <td>032-440-7633</td>
                            <td>시설관리팀</td>
			            </tr>
  			<tr>
			                <td>도서대출 및 독서실 운영 문의</td>
			                <td>강호경</td>
                            <td>032-440-7652</td>
                            <td>기획평가팀</td>
			            </tr>

			            </tbody>                        
			       </table>
              </ul>
              <jsp:include page="/homepage_new/inc/admin_info.jsp" flush="true" ><jsp:param name="menucode" value="M100026" /></jsp:include>
              <div class="h80"></div>
            <!-- //contnet -->
          </div>
        </div>
    
    
    </div>

    <jsp:include page="/homepage_new/inc/footer.jsp" flush="true" ></jsp:include>