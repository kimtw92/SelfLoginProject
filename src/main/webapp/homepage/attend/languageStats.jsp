<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>


<%@ include file="/commonInc/include/commonImport.jsp" %>
<%@ include file="/commonInc/include/comInclude.jsp" %>
<jsp:include page="/commonInc/include/comHtmlTop.jsp" flush="false">
	<jsp:param name="cssName" value="layout" />
</jsp:include>
<script language="javascript" src="/commonInc/js/commonJs.js"></script>

<script language="JavaScript" type="text/JavaScript">
<!--

// 검색
function goSearch(){
	$("mode").value = "ageBest";
	pform.action = "/statisMgr/stats.do";
	pform.submit();
}
//-->
</script>



<script src="http://hrd.incheon.go.kr/homepage_new/js/canvasjs.min.js"></script>
<jsp:include page="/homepage_new/inc/header.jsp" flush="true" ></jsp:include>
    
    <div id="subContainer">
    
    <div class="subNavi_area">
    
      <jsp:include page="/homepage_new/inc/left3.jsp" flush="true" ></jsp:include>
    
      </div>
    
        <div id="contnets_area">
          <div class="sub_visual3">교육신청</div>
            <div class="local">
              <h2>외국어 추천과정</h2>
                <div class="navi"><img src="/homepage_new/images/common/icon_home.gif" alt="home"> &gt; 교육신청 &gt; <span>수료현황 및 추천과정</span></div>
            </div>
            <div class="contnets">
            <!-- contnet -->

              <!--//검색  -->	
						<ol class="TabSub">
			<li><a href="javascript:fnGoMenu('4','yearof2016');">2016년 결과  </a></li>						
            <li><a href="javascript:fnGoMenu('4','cyber');">2017년 현황</a></li>            
            <li><a href="javascript:fnGoMenu('4','departBest');">기관별 추천</a></li>
            <li><a href="javascript:fnGoMenu('4','tierBest');">직급별 추천</a></li>
            <li><a href="javascript:fnGoMenu('4','ageBest');">연령별 추천</a></li>
            <li><a href="javascript:fnGoMenu('4','genderBest');">남여별 추천</a></li>
            <li class="TabOn"><a href="javascript:fnGoMenu('4','languageBest');">외국어 교육</a></li>			
          	</ol>
          	
          	   <p><BR><p><font size="3px"><b>◇ 영어 </b></font><p><BR><p> 	
          	
	          	<table class="dataH07"> 
	            <colgroup>
	            <col width="" />
	            <col width="" />	            
	            </colgroup>
	
	            <thead>
	            <tr>
	                <th class="t04">순위</th>
	                <th class="t03">과정명</th>
	            </thead>
	            <tbody>
	            	<tr>
	            	<td>1</td>
	            	<td style="text-align: left">10일 안에 끝내는 척척 여행영어</td>
	            	</tr>
	            	
	            	<tr>
	            	<td>2</td>
	            	<td style="text-align: left">New English 900 - 초급 1step</td>
	            	</tr>
	            	
	            	<tr>
	            	<td>3</td>
	            	<td style="text-align: left">New English 900 회화 잡는 기초 영단어</td>
	            	</tr>
	            	
	            	<tr>
	            	<td>4</td>
	            	<td style="text-align: left">YBM 생활 영어 1</td>
	            	</tr>
	            	
	            	<tr>
	            	<td>5</td>
	            	<td style="text-align: left">New English 900 - 초급 2step</td>
	            	</tr>
	            	
	            	<tr>
	            	<td>6</td>
	            	<td style="text-align: left">[신토익] 10시간만에 Part 1&2 공략하기</td>
	            	</tr>
	            	
	            	<tr>
	            	<td>7</td>
	            	<td style="text-align: left">[신토익] the쉬운 Grammar로 Part 5 정복하기</td>
	            	</tr>
	            	
	            	<tr>
	            	<td>8</td>
	            	<td style="text-align: left">YBM기초영어-왕초보 0단계 발음편 step 1</td>
	            	</tr>
	            	
	            	<tr>
	            	<td>9</td>
	            	<td style="text-align: left">[무비랑티처] 디즈니 명작 애니로 배우는 영어 회화</td>
	            	</tr>
	            	
	            	<tr>
	            	<td>10</td>
	            	<td style="text-align: left">[급상승토익] Part7 독해구구단</td>
	            	</tr>
	            	
	            	
	            
	         
	            </tbody>
	            </table>
	            
	            <p><br><p>
	            
	            	<p><BR><p><font size="3px"><b>◇ 중국어 </b></font><p><BR><p>
          	
	          	<table class="dataH07"> 
	            <colgroup>
	            <col width="" />
	            <col width="" />	            
	            </colgroup>
	
	            <thead>
	            <tr>
	                <th class="t04">순위</th>
	                <th class="t03">과정명</th>
	            </thead>
	            <tbody>
	            	<tr>
	            	<td>1</td>
	            	<td style="text-align: left">YBM 생활 중국어 1
</td>
	            	</tr>
	            	
	            	<tr>
	            	<td>2</td>
	            	<td style="text-align: left">YBM 생활 중국어 2
</td>
	            	</tr>
	            	
	            	<tr>
	            	<td>3</td>
	            	<td style="text-align: left">YBM 생활 중국어 3
</td>
	            	</tr>
	            	
	            	<tr>
	            	<td>4</td>
	            	<td style="text-align: left">YBM 생활 중국어 4
/td>
	            	</tr>
	            	
	            	<tr>
	            	<td>5</td>
	            	<td style="text-align: left">니하오 중국어 회화 첫걸음 1step
</td>
	            	</tr>
	            	
	            	<tr>
	            	<td>6</td>
	            	<td style="text-align: left">베이직 중국어 회화 - 기초
</td>
	            	</tr>
	            	
	            	<tr>
	            	<td>7</td>
	            	<td style="text-align: left">[B2B] 한 번에 끝내는 新 HSK 회화 중급 1step
</td>
	            	</tr>
	            	
	            	<tr>
	            	<td>8</td>
	            	<td style="text-align: left">빵 (棒) 터지는 중국어 회화 중급 1step
</td>
	            	</tr>
	            	
	            	<tr>
	            	<td>9</td>
	            	<td style="text-align: left">YBM 생활 중국어 5
</td>
	            	</tr>
	            	
	            	<tr>
	            	<td>10</td>
	            	<td style="text-align: left">니하오 중국어 회화 초급 1step
</td>
	            	</tr>
	            	
	            	
	            
	         
	            </tbody>
	            </table>
	            
	            
	              <p><br><p>
	            
	            	<p><BR><p><font size="3px"><b>◇일본어 </b></font><p><BR><p>
          	
	          	<table class="dataH07"> 
	            <colgroup>
	            <col width="" />
	            <col width="" />	            
	            </colgroup>
	
	            <thead>
	            <tr>
	                <th class="t04">순위</th>
	                <th class="t03">과정명</th>
	            </thead>
	            <tbody>
	            	<tr>
	            	<td>1</td>
	            	<td style="text-align: left">YBM 생활 일본어 1

</td>
	            	</tr>
	            	
	            	<tr>
	            	<td>2</td>
	            	<td style="text-align: left">하지메마시떼 왕초보 일본어: 처음부터 시작하기

</td>
	            	</tr>
	            	
	            	<tr>
	            	<td>3</td>
	            	<td style="text-align: left">YBM 생활 일본어 2

</td>
	            	</tr>
	            	
	            	<tr>
	            	<td>4</td>
	            	<td style="text-align: left">가장 쉽게 끝내는 일본어 첫걸음

</td>
	            	</tr>
	            	
	            	<tr>
	            	<td>5</td>
	            	<td style="text-align: left">하지메마시떼 일본어 회화 초급

</td>
	            	</tr>
	            	
	            	<tr>
	            	<td>6</td>
	            	<td style="text-align: left">일본어회화 대박패턴 200

</td>
	            	</tr>
	            	
	            	<tr>
	            	<td>7</td>
	            	<td style="text-align: left">일본어 문법 무작정 따라하기 초급 1step

</td>
	            	</tr>
	            	
	            	<tr>
	            	<td>8</td>
	            	<td style="text-align: left">보고 듣고 따라하는 초급 일본어 단어 1step

</td>
	            	</tr>
	            	
	            	<tr>
	            	<td>9</td>
	            	<td style="text-align: left">우키우키 일본어회화 고급 1step

</td>
	            	</tr>
	            	
	            	<tr>
	            	<td>10</td>
	            	<td style="text-align: left">YBM 생활 일본어 3

</td>
	            	</tr>
	            	
	            	
	            
	         
	            </tbody>
	            </table>
	          
            
          
              
            <!-- //contnet -->
          </div>
        </div>
    	
    
    
    </div>
    
 <jsp:include page="/homepage_new/inc/footer.jsp" flush="true" ></jsp:include>
    