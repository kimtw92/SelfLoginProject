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

	                "#90EE90",
	                "#90EE90",
	                "#90EE90",
	                "#90EE90",
	                "#2E8B57",
	                "#2E8B57",
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
				text: "1인당  평균 2.63 과정",
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
				interval:2.63
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
					{label: "시청", y: 2.21},
					{label: "중구", y: 1.53},
					{label: "동구", y: 2.10},
					{label: "남구", y: 2.37},
					{label: "연수구", y: 3.88, indexLabel:"최고 3.88"},
					{label: "남동구", y: 2.75},
					{label: "부평구", y: 1.90},
					{label: "계양구", y: 1.64},
					{label: "서구", y: 1.44, indexLabel:"최저 1.44"},
					{label: "강화군", y: 1.95},
					{label: "옹진군", y: 1.67}				
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
            
			<li class="TabOn"><a href="javascript:fnGoMenu('4','yearof2015');">2015년 결과 </a></li>			
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
          	<p style="padding-left:530px">(기준일 : 2015. 12. 31)</p>
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
	                <th class="t04" style="text-align: right">사이버교육&nbsp;&nbsp;</th>
	              </tr>
	              
	            </thead>
	            <tbody>
	            	<tr>
	            	<td style="text-align: center">합계</td>
	            	<td style="text-align: right"><b>13,585</b> &nbsp;&nbsp;</td>
	            	<td style="text-align: right"><b>35,687</b> &nbsp;&nbsp;</td>
	            	
	            	<td style="text-align: right"><b>31,920</b> &nbsp;&nbsp;</td>
	            	<td style="text-align: right"><b>3,767</b> &nbsp;&nbsp;</td>
	            	
	            	<td style="text-align: right"><b>2.63</b> &nbsp;&nbsp;</td>
	            	</tr>
	            	
	            	<tr>
	            	<td style="text-align: center">시청</td>
	            	<td style="text-align: right">5,989&nbsp;&nbsp;</td>
	            	<td style="text-align: right">13,223&nbsp;&nbsp;</td>
	            	
	            	<td style="text-align: right">11,463 &nbsp;&nbsp;</td>
	            	<td style="text-align: right">1,760 &nbsp;&nbsp;</td>
	            	
	            	<td style="text-align: right">2.21&nbsp;&nbsp;</td>
	            	</tr>
	            	
	            	<tr>
	            	<td style="text-align: center">중구</td>
	            	<td style="text-align: right">652&nbsp;&nbsp;</td>
	            	<td style="text-align: right">999&nbsp;&nbsp;</td>
	            	
	            	<td style="text-align: right">759 &nbsp;&nbsp;</td>
	            	<td style="text-align: right">240 &nbsp;&nbsp;</td>
	            	
	            	<td style="text-align: right">1.53&nbsp;&nbsp;</td>
	            	</tr>
	            	
	            	<tr>
	            	<td style="text-align: center">동구</td>
	            	<td style="text-align: right">536&nbsp;&nbsp;</td>
	            	<td style="text-align: right">1,124&nbsp;&nbsp;</td>
	            	
	            	<td style="text-align: right">999 &nbsp;&nbsp;</td>
	            	<td style="text-align: right">125 &nbsp;&nbsp;</td>
	            	
	            	
	            	<td style="text-align: right">2.10&nbsp;&nbsp;</td>
	            	</tr>
	            	
	            	<tr>
	            	<td style="text-align: center">남구</td>
	            	<td style="text-align: right">898&nbsp;&nbsp;</td>
	            	<td style="text-align: right">2,129&nbsp;&nbsp;</td>
	            	
	            	<td style="text-align: right">1,909 &nbsp;&nbsp;</td>
	            	<td style="text-align: right">220 &nbsp;&nbsp;</td>
	            	
	            	<td style="text-align: right">2.37&nbsp;&nbsp;</td>
	            	</tr>
	            	
	            	<tr bgcolor="ff9900">
	            	<td style="text-align: center"><b>연수구</b></td>
	            	<td style="text-align: right"><b>673 </b>&nbsp;&nbsp;</td>
	            	<td style="text-align: right"><b>2,612</b>&nbsp;&nbsp;</td>
	            	
	            	<td style="text-align: right"><b>2,428</b> &nbsp;&nbsp;</td>
	            	<td style="text-align: right"><b>184</b> &nbsp;&nbsp;</td>
	            	
	            	<td style="text-align: right"><b>3.88</b>&nbsp;&nbsp;</td>
	            	</tr>
	            	
	            	<tr>
	            	<td style="text-align: center">남동구</td>
	            	<td style="text-align: right">909&nbsp;&nbsp;</td>
	            	<td style="text-align: right">2,502&nbsp;&nbsp;</td>
	            	
	            	<td style="text-align: right">2,328 &nbsp;&nbsp;</td>
	            	<td style="text-align: right">174 &nbsp;&nbsp;</td>
	            	
	            	<td style="text-align: right">2.75&nbsp;&nbsp;</td>
	            	</tr>
	            	
	            	<tr>
	            	<td style="text-align: center">부평구</td>
	            	<td style="text-align: right">1,060&nbsp;&nbsp;</td>
	            	<td style="text-align: right">2,016&nbsp;&nbsp;</td>
	            	
	            	<td style="text-align: right">1,813 &nbsp;&nbsp;</td>
	            	<td style="text-align: right">203 &nbsp;&nbsp;</td>
	            	
	            	
	            	<td style="text-align: right">1.90&nbsp;&nbsp;</td>
	            	</tr>
	            	
	            	<tr>
	            	<td style="text-align: center">계양구</td>
	            	<td style="text-align: right">724&nbsp;&nbsp;</td>
	            	<td style="text-align: right">1,188&nbsp;&nbsp;</td>
	            	
	            	<td style="text-align: right">1,050 &nbsp;&nbsp;</td>
	            	<td style="text-align: right">138 &nbsp;&nbsp;</td>
	            	
	            	<td style="text-align: right">1.64&nbsp;&nbsp;</td>
	            	</tr>
	            	
	            	<tr>
	            	<td style="text-align: center">서구</td>
	            	<td style="text-align: right">944&nbsp;&nbsp;</td>
	            	<td style="text-align: right">1,362&nbsp;&nbsp;</td>
	            	
	            	<td style="text-align: right">1,173 &nbsp;&nbsp;</td>
	            	<td style="text-align: right">189 &nbsp;&nbsp;</td>
	            	
	            	<td style="text-align: right">1.44&nbsp;&nbsp;</td>
	            	</tr>
	            	
	            	<tr>
	            	<td style="text-align: center">강화군</td>
	            	<td style="text-align: right">656&nbsp;&nbsp;</td>
	            	<td style="text-align: right">1,276&nbsp;&nbsp;</td>
	            	
	            	<td style="text-align: right">1,226 &nbsp;&nbsp;</td>
	            	<td style="text-align: right">50 &nbsp;&nbsp;</td>
	            	
	            	
	            	<td style="text-align: right">1.95&nbsp;&nbsp;</td>
	            	</tr>
	            	
	            	<tr>
	            	<td style="text-align: center">옹진군</td>
	            	<td style="text-align: right">544&nbsp;&nbsp;</td>
	            	<td style="text-align: right">908&nbsp;&nbsp;</td>
	            	
	            	<td style="text-align: right">830 &nbsp;&nbsp;</td>
	            	<td style="text-align: right">78 &nbsp;&nbsp;</td>
	            	
	            	<td style="text-align: right">1.67&nbsp;&nbsp;</td>
	            	</tr>
	            	
	            </tbody>
	            </table>
	            
	            
               <!-- //contnet -->
          </div>
        </div>
    	
    
    
    </div>
   
 <jsp:include page="/homepage_new/inc/footer.jsp" flush="true" ></jsp:include>
    
    