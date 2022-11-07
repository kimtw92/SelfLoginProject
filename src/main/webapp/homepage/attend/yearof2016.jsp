<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
</head>


<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>



<%@ include file="/commonInc/include/commonImport.jsp" %>
<%@ include file="/commonInc/include/comInclude.jsp" %>


<jsp:include page="/commonInc/include/comHtmlTop.jsp" flush="false">
	<jsp:param name="cssName" value="layout" />
</jsp:include>

<script src="http://hrd.incheon.go.kr/homepage_new/js/source/canvasjs.js"></script>
<script language="javascript" src="/commonInc/js/commonJs.js"></script>
<script language="JavaScript" type="text/JavaScript">
<!--

// 검색
function goSearch(){
	$("mode").value = "cyber";
	pform.action = "/statisMgr/stats.do";
	pform.submit();
}
//-->
</script>


<script type="text/javascript">
	window.onload = function () {
		 CanvasJS.addColorSet("greenShades",
	                [//colorSet Array

	                "#2E8B57",
	                "#90EE90",
	                "#90EE90",
	                "#90EE90",
	                "#2E8B57",
	                "#2E8B57",
	                "#90EE90",
	                "#90EE90",
	                "#90EE90",
	                "#90EE90",
	                "#90EE90"
	                ]);

		 
		var chart = new CanvasJS.Chart("chartContainer",
		{
			theme: "theme2",		
            animationEnabled: true,   
            colorSet:"greenShades",
			title:{
				text: "1인당  평균 1.95 과정",
				fontSize: 12
			},
			toolTip: {
				shared: true
			},
			axisX: {				
				labelFontSize: 12,
				interval:1
			},
			axisY2: {
				interval:1.95
			},	
			data: [ 			
			{
				type: "column",	
				name: "1인당 수료과정수",
				legendText: "1인당 수료과정수",				
				showInLegend: true,
				axisYType:"secondary",
				indexLabelFontColor : "red",
				indexLabelFontSize : 12,
				dataPoints:[
					{label: "시청", y: 2.28},
					{label: "중구", y: 0.96 , indexLabel:"최저 0.96"},
					{label: "동구", y: 1.85},
					{label: "남구", y: 1.73},
					{label: "연수구", y: 3.35, indexLabel:"최고 3.35"},
					{label: "남동구", y: 2.57},
					{label: "부평구", y: 1.30},
					{label: "계양구", y: 1.02},
					{label: "서구", y: 1.15},
					{label: "강화군", y: 1.80},
					{label: "옹진군", y: 1.20}				
				]
			}
			
			],
			 legend:{
		            cursor:"pointer",
		            itemclick: function(e){
		              if (typeof(e.dataSeries.visible) === "undefined" || e.dataSeries.visible) {
		              	e.dataSeries.visible = false;
		              }
		              else {
		                e.dataSeries.visible = true;
		              }
		            	chart.render();
		            }
		          },
		        });
		
		
		
		
		
chart.render();
}
</script>



<jsp:include page="/homepage_new/inc/header.jsp" flush="true" ></jsp:include>

    
    <div id="subContainer">
    
    <div class="subNavi_area">
    
      <jsp:include page="/homepage_new/inc/left3.jsp" flush="true" ></jsp:include>
    
      </div>
    
        <div id="contnets_area">
          <div class="sub_visual3">교육신청</div>
            <div class="local">
              <h2>기관별 수료 현황</h2>
                <div class="navi"><img src="/homepage_new/images/common/icon_home.gif" alt="home"> &gt; 교육신청 &gt; <span>수료현황 및 추천과정</span></div>
            </div>
            <div class="contnets">
            <!-- contnet -->

              <!--//검색  -->	
						<ol class="TabSub">			
            
			<li class="TabOn"><a href="javascript:fnGoMenu('4','yearof2016');">2016년 결과 </a></li>			
            <li><a href="javascript:fnGoMenu('4','cyber');">2017년 현황</a></li>            
            <li><a href="javascript:fnGoMenu('4','departBest');">기관별 추천</a></li>
            <li><a href="javascript:fnGoMenu('4','tierBest');">직급별 추천</a></li>
            <li ><a href="javascript:fnGoMenu('4','ageBest');">연령별 추천</a></li>
            <li><a href="javascript:fnGoMenu('4','genderBest');">남여별 추천</a></li>
            <li><a href="javascript:fnGoMenu('4','languageBest');">외국어교육</a></li>
          	</ol>
          	<p><BR><p>
          	
			  <font size="3px"><b>◇ 공무원 1인당 사이버교육 수료과정 수 </b></font>
			  
			  <p><BR><p> 	
              <div id="chartContainer" style="height: 400px; width: 650px;"></div>
            
            
            
            <p><br/><p><p><br/><p><p><br/><p>
           <font size="3px"><b>◇  공무원 1인당 사이버교육 수료과정 수(도표) </b></font>
          	<p style="padding-left:530px">(기준일 : 2016. 11. 30)</p>
	          	<table class="dataH07"> 
	            <colgroup>
	            <col width="200" />
	            <col width="150" />	            
	            <col width="100" />
	            <col width="100" />
	            <col width="100" />
	            <col width="150" />
	            </colgroup>
	
	            <thead>
	            <tr>
	                <th class="t04" rowspan="2">기관</th>
	                <th class="t04" style="text-align: right" rowspan="2">현재인원&nbsp;&nbsp;</th>
	                <th class="t04" style="text-align: center" colspan="3">수료인원&nbsp;&nbsp;</th>
	                <th class="t04" style="text-align: right" rowspan="2">수료과정수&nbsp;&nbsp;</th>
	              </tr>
	              
	              <tr>
	                <th class="t04" style="text-align: right">합계&nbsp;&nbsp;</th>
	                <th class="t04" style="text-align: right">전문교육&nbsp;&nbsp;</th>
	                <th class="t04" style="text-align: right">외국어교육&nbsp;&nbsp;</th>
	              </tr>
	              
	            </thead>
	            <tbody>
	            	<tr>
	            	<td style="text-align: center">합계</td>
	            	<td style="text-align: right"><b>13,634</b> &nbsp;&nbsp;</td>
	            	<td style="text-align: right"><b>26,520</b> &nbsp;&nbsp;</td>
	            	
	            	<td style="text-align: right"><b>24,175</b> &nbsp;&nbsp;</td>
	            	<td style="text-align: right"><b>2,345</b> &nbsp;&nbsp;</td>
	            	<td style="text-align: right"><b>1.95</b> &nbsp;&nbsp;</td>
	            	</tr>
	            	
	            	<tr>
	            	<td style="text-align: center">시청</td>
	            	<td style="text-align: right">5,979 &nbsp;&nbsp;</td>
	            	<td style="text-align: right">13,630 &nbsp;&nbsp;</td>
	            	
	            	<td style="text-align: right">12,638 &nbsp;&nbsp;</td>
	            	<td style="text-align: right">992 &nbsp;&nbsp;</td>
	            	<td style="text-align: right">2.28&nbsp;&nbsp;</td>
	            	</tr>
	            	
	            	<tr>
	            	<td style="text-align: center">중구</td>
	            	<td style="text-align: right">661 &nbsp;&nbsp;</td>
	            	<td style="text-align: right">632 &nbsp;&nbsp;</td>
	            	
	            	<td style="text-align: right">469 &nbsp;&nbsp;</td>
	            	<td style="text-align: right">163 &nbsp;&nbsp;</td>
	            	
	            	<td style="text-align: right">0.96&nbsp;&nbsp;</td>
	            	</tr>
	            	
	            	<tr>
	            	<td style="text-align: center">동구</td>
	            	<td style="text-align: right">527 &nbsp;&nbsp;</td>
	            	<td style="text-align: right">976 &nbsp;&nbsp;</td>
	            	
	            	<td style="text-align: right">844 &nbsp;&nbsp;</td>
	            	<td style="text-align: right">132 &nbsp;&nbsp;</td>
	            	
	            	
	            	<td style="text-align: right">1.85 &nbsp;&nbsp;</td>
	            	</tr>
	            	
	            	<tr>
	            	<td style="text-align: center">남구</td>
	            	<td style="text-align: right">894 &nbsp;&nbsp;</td>
	            	<td style="text-align: right">1,548 &nbsp;&nbsp;</td>
	            	
	            	<td style="text-align: right">1,361 &nbsp;&nbsp;</td>
	            	<td style="text-align: right">187 &nbsp;&nbsp;</td>
	            	
	            	<td style="text-align: right">1.73&nbsp;&nbsp;</td>
	            	</tr>
	            	
	            	<tr bgcolor="ff9900">
	            	<td style="text-align: center"><b>연수구</b></td>
	            	<td style="text-align: right"><b>685 </b>&nbsp;&nbsp;</td>
	            	<td style="text-align: right"><b>2,292</b>&nbsp;&nbsp;</td>
	            	
	            	<td style="text-align: right"><b>2,161</b> &nbsp;&nbsp;</td>
	            	<td style="text-align: right"><b>131</b> &nbsp;&nbsp;</td>
	            	
	            	<td style="text-align: right"><b>3.35</b>&nbsp;&nbsp;</td>
	            	</tr>
	            	
	            	<tr>
	            	<td style="text-align: center">남동구</td>
	            	<td style="text-align: right">920 &nbsp;&nbsp;</td>
	            	<td style="text-align: right">2,360 &nbsp;&nbsp;</td>
	            	
	            	<td style="text-align: right">2,219 &nbsp;&nbsp;</td>
	            	<td style="text-align: right">141 &nbsp;&nbsp;</td>
	            	
	            	<td style="text-align: right">2.57&nbsp;&nbsp;</td>
	            	</tr>
	            	
	            	<tr>
	            	<td style="text-align: center">부평구</td>
	            	<td style="text-align: right">1,077 &nbsp;&nbsp;</td>
	            	<td style="text-align: right">1,397 &nbsp;&nbsp;</td>
	            	
	            	<td style="text-align: right">1,259 &nbsp;&nbsp;</td>
	            	<td style="text-align: right">138 &nbsp;&nbsp;</td>
	            	
	            	
	            	<td style="text-align: right">1.30 &nbsp;&nbsp;</td>
	            	</tr>
	            	
	            	<tr>
	            	<td style="text-align: center">계양구</td>
	            	<td style="text-align: right">747 &nbsp;&nbsp;</td>
	            	<td style="text-align: right">764 &nbsp;&nbsp;</td>
	            	
	            	<td style="text-align: right">659 &nbsp;&nbsp;</td>
	            	<td style="text-align: right">105 &nbsp;&nbsp;</td>
	            	
	            	<td style="text-align: right">1.02 &nbsp;&nbsp;</td>
	            	</tr>
	            	
	            	<tr>
	            	<td style="text-align: center">서구</td>
	            	<td style="text-align: right">948 &nbsp;&nbsp;</td>
	            	<td style="text-align: right">1,094&nbsp;&nbsp;</td>
	            	
	            	<td style="text-align: right">849 &nbsp;&nbsp;</td>
	            	<td style="text-align: right">245 &nbsp;&nbsp;</td>
	            	
	            	<td style="text-align: right">1.15 &nbsp;&nbsp;</td>
	            	</tr>
	            	
	            	<tr>
	            	<td style="text-align: center">강화군</td>
	            	<td style="text-align: right">660 &nbsp;&nbsp;</td>
	            	<td style="text-align: right">1,185 &nbsp;&nbsp;</td>
	            	
	            	<td style="text-align: right">1,160 &nbsp;&nbsp;</td>
	            	<td style="text-align: right">25 &nbsp;&nbsp;</td>
	            	
	            	
	            	<td style="text-align: right">1.80 &nbsp;&nbsp;</td>
	            	</tr>
	            	
	            	<tr>
	            	<td style="text-align: center">옹진군</td>
	            	<td style="text-align: right">536 &nbsp;&nbsp;</td>
	            	<td style="text-align: right">641 &nbsp;&nbsp;</td>
	            	
	            	<td style="text-align: right">556 &nbsp;&nbsp;</td>
	            	<td style="text-align: right">85 &nbsp;&nbsp;</td>
	            	
	            	<td style="text-align: right">1.20 &nbsp;&nbsp;</td>
	            	</tr>
	            	
	            </tbody>
	            </table>
	            
	            <p/><br/><p/><br/><p/>    
               <!-- //contnet -->
          </div>
        </div>
    	
    
    
    </div>
    
  
 <jsp:include page="/homepage_new/inc/footer.jsp" flush="true" ></jsp:include>   

    
    