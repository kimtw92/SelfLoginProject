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


<%
    //request 데이터
	DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
	requestMap.setNullToInitialize(true);

	// 필수 코딩 내용 //////////////////////////////////////////////////////////////////////	
	
	String bgColor = "";
	
	StringBuffer sbListHtml = new StringBuffer();
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	if(listMap == null) listMap = new DataMap();
	listMap.setNullToInitialize(true);
	
	String m[] = new String[48];
	String sss = "100";
	
	if(listMap.keySize("dept1") > 0){		
		for(int i=0; i < listMap.keySize("dept1"); i++){
			m[0] = listMap.getString("dept1", i);
			m[1] = listMap.getString("succSum1", i);
			m[2] = listMap.getString("failSum1", i);
			m[36] = listMap.getString("rate1", i);			
			m[3] = listMap.getString("dept2", i);
			m[4] = listMap.getString("succSum2", i);
			m[5] = listMap.getString("failSum2", i);
			m[37] = listMap.getString("rate2", i);
			
			m[6] = listMap.getString("dept3", i);
			m[7] = listMap.getString("succSum3", i);
			m[8] = listMap.getString("failSum3", i);
			m[38] = listMap.getString("rate3", i);
			
			m[9] = listMap.getString("dept4", i);
			m[10] = listMap.getString("succSum4", i);
			m[11] = listMap.getString("failSum4", i);
			m[39] = listMap.getString("rate4", i);
			
			m[12] = listMap.getString("dept5", i);
			m[13] = listMap.getString("succSum5", i);
			m[14] = listMap.getString("failSum5", i);
			m[40] = listMap.getString("rate5", i);
			
			m[15] = listMap.getString("dept6", i);
			m[16] = listMap.getString("succSum6", i);
			m[17] = listMap.getString("failSum6", i);
			m[41] = listMap.getString("rate6", i);
			
			m[18] = listMap.getString("dept7", i);
			m[19] = listMap.getString("succSum7", i);
			m[20] = listMap.getString("failSum7", i);
			m[42] = listMap.getString("rate7", i);
			
			m[21] = listMap.getString("dept8", i);
			m[22] = listMap.getString("succSum8", i);
			m[23] = listMap.getString("failSum8", i);
			m[43] = listMap.getString("rate8", i);
			
			m[24] = listMap.getString("dept9", i);
			m[25] = listMap.getString("succSum9", i);
			m[26] = listMap.getString("failSum9", i);
			m[44] = listMap.getString("rate9", i);
			
			m[27] = listMap.getString("dept10", i);
			m[28] = listMap.getString("succSum10", i);
			m[29] = listMap.getString("failSum10", i);
			m[45] = listMap.getString("rate10", i);
			
			m[30] = listMap.getString("dept11", i);
			m[31] = listMap.getString("succSum11", i);
			m[32] = listMap.getString("failSum11", i);
			m[46] = listMap.getString("rate11", i);
			
			m[33] = listMap.getString("dept12", i);
			m[34] = listMap.getString("succSum12", i);
			m[35] = listMap.getString("failSum12", i);
			m[47] = listMap.getString("rate12", i);
			   
		}
	}
	
	
%>



<script type="text/javascript">
	window.onload = function () {
		var chart = new CanvasJS.Chart("chartContainer",
		{
			theme: "theme2",
                        animationEnabled: true,
			title:{
				text: "기관별 사이버 전문 교육 수료 현황",
				fontSize: 12
			},
			toolTip: {
				shared: true
			},
			axisX: {				
				labelFontSize: 12,
				interval:1
			},
			axisY: {
				title: "인원",
				fontSize: 6
			},		
			
					
			data: [ 
			{
				type: "column",	
				name: "신청 인원",
				legendText: "신청 인원",
				showInLegend: true, 
					
				dataPoints:[
				{label: "시청", y: <%=m[0]%>},
				{label: "중구", y: <%=m[3*1]%>},
				{label: "동구", y: <%=m[3*2]%>},
				{label: "남구", y: <%=m[3*3]%>},
				{label: "연수구", y: <%=m[3*4]%>},
				{label: "남동구", y: <%=m[3*5]%>},
				{label: "부평구", y: <%=m[3*6]%>},
				{label: "계양구", y: <%=m[3*7]%>},
				{label: "서구", y: <%=m[3*8]%>},
				{label: "강화군", y: <%=m[3*9]%>},
				{label: "옹진군", y: <%=m[3*10]%>},
				{label: "공사/공단", y: <%=m[3*11]%>}
				]
			},
			{
				type: "column",	
				name: "수료 인원",
				legendText: "수료 인원",			
				showInLegend: true,
				dataPoints:[
				{label: "시청", y: <%=m[0+1]%>},
				{label: "중구", y: <%=m[3*1+1]%>},
				{label: "동구", y: <%=m[3*2+1]%>},
				{label: "남구", y: <%=m[3*3+1]%>},
				{label: "연수구", y: <%=m[3*4+1]%>},
				{label: "남동구", y: <%=m[3*5+1]%>},
				{label: "부평구", y: <%=m[3*6+1]%>},
				{label: "계양구", y: <%=m[3*7+1]%>},
				{label: "서구", y: <%=m[3*8+1]%>},
				{label: "강화군", y: <%=m[3*9+1]%>},
				{label: "옹진군", y: <%=m[3*10+1]%>},
				{label: "공사/공단", y: <%=m[3*11+1]%>}
				]
			},
			{
				type: "line",	
				name: "수료율",
				legendText: "수료율",				
				showInLegend: true,		
				axisYType:"secondary",
				indexLabelFontColor : "red",
				indexLabelFontSize : 12,	
				dataPoints:[
				{label: "시청", y: <%=m[36]%>, indexLabel:"수료율 : <%=m[36]%>%"},
				{label: "중구", y: <%=m[37]%>, indexLabel:" <%=m[37]%>%"},
				{label: "동구", y: <%=m[38]%>, indexLabel:" <%=m[38]%>%"},
				{label: "남구", y: <%=m[39]%>, indexLabel:" <%=m[39]%>%"},
				{label: "연수구", y: <%=m[40]%>, indexLabel:" <%=m[40]%>%"},
				{label: "남동구", y: <%=m[41]%>, indexLabel:" <%=m[41]%>%"},
				{label: "부평구", y: <%=m[42]%>, indexLabel:" <%=m[42]%>%"},
				{label: "계양구", y: <%=m[43]%>, indexLabel:" <%=m[43]%>%"},
				{label: "서구", y: <%=m[44]%>, indexLabel:" <%=m[44]%>%"},
				{label: "강화군", y: <%=m[45]%>, indexLabel:" <%=m[45]%>%"},
				{label: "옹진군", y: <%=m[46]%>, indexLabel:" <%=m[46]%>%"},
				{label: "공사/공단", y: <%=m[47]%>, indexLabel:" <%=m[47]%>%"}				
				]
			}
			/*
			{
				type: "column",	
				name: "미수료인원",
				legendText: "미수료인원",				
				showInLegend: true,				
				dataPoints:[
				{label: "시청", y: <%=m[0+2]%>},
				{label: "중구", y: <%=m[3*1+2]%>},
				{label: "동구", y: <%=m[3*2+2]%>},
				{label: "남구", y: <%=m[3*3+2]%>},
				{label: "연수구", y: <%=m[3*4+2]%>},
				{label: "남동구", y: <%=m[3*5+2]%>},
				{label: "부평구", y: <%=m[3*6+2]%>},
				{label: "계양구", y: <%=m[3*7+2]%>},
				{label: "서구", y: <%=m[3*8+2]%>},
				{label: "강화군", y: <%=m[3*9+2]%>},
				{label: "옹진군", y: <%=m[3*10+2]%>},
				{label: "공사/공단", y: <%=m[3*11+2]%>}				
				]
			}
			*/
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
		
		
		
		
		var chart1 = new CanvasJS.Chart("chartContainer1",
				{
					theme: "theme2",
		                        animationEnabled: true,
					title:{
						text: "기관별 외국어 교육 수료 현황",
						fontSize: 12
					},
					toolTip: {
						shared: true
					},
					axisX: {				
						labelFontSize: 12,
						interval:1
					},
					axisY: {
						title: "인원",
						fontSize: 6
					},
									
					data: [ 
					{
						type: "column",	
						name: "신청 인원",
						legendText: "신청 인원",
						showInLegend: true, 
						indexLabelFontColor : "red",
						indexLabelFontSize : 12,			
						dataPoints:[
						{label: "시청", y: 1630},
						{label: "중구", y: 214},
						{label: "동구", y: 180},
						{label: "남구", y: 254},
						{label: "연수구", y: 193},
						{label: "남동구", y: 213},
						{label: "부평구", y: 212},
						{label: "계양구", y: 151},
						{label: "서구", y: 331},
						{label: "강화군", y: 36},
						{label: "옹진군", y: 105},
						{label: "공사/공단", y: 365}
						]
					},
					{
						type: "column",	
						name: "수료 인원",
						legendText: "수료 인원",			
						showInLegend: true,							
						dataPoints:[
						{label: "시청", y: 1226 },
						{label: "중구", y: 188 },
						{label: "동구", y: 154},
						{label: "남구", y: 200},
						{label: "연수구", y: 157},
						{label: "남동구", y: 150},
						{label: "부평구", y: 162},
						{label: "계양구", y: 122},
						{label: "서구", y: 278},
						{label: "강화군", y: 30},
						{label: "옹진군", y: 91},
						{label: "공사/공단", y: 336}
						]
					},
					
					{
						type: "line",	
						name: "수료율",
						legendText: "수료율",				
						showInLegend: true,		
						indexLabelFontColor : "red",
						indexLabelFontSize : 12,	
						axisYType:"secondary",
						dataPoints:[
						{label: "시청", y: 75.2 , indexLabel:"수료율 : 75.2%"},
						{label: "중구", y: 87.9, indexLabel:"87.9%"},
						{label: "동구", y: 85.6, indexLabel:"85.6%"},
						{label: "남구", y: 78.7, indexLabel:"78.7%"},
						{label: "연수구", y: 81.3, indexLabel:"81.3%"},
						{label: "남동구", y: 70.4, indexLabel:"70.4%"},
						{label: "부평구", y: 76.4, indexLabel:"76.4%"},
						{label: "계양구", y: 80.8, indexLabel:"80.8%"},
						{label: "서구", y: 84.0, indexLabel:"84.0%"},
						{label: "강화군", y: 83.3, indexLabel:"83.3%"},
						{label: "옹진군", y:86.7, indexLabel:"86.7%"},
						{label: "공사/공단", y: 92.1, indexLabel:"92.1%"}				
						]
					}
					
					/*
					{
						type: "column",	
						name: "미수료인원 ",
						legendText: "미수료인원",			
						showInLegend: true,
						dataPoints:[
						{label: "시청", y: 264},
						{label: "중구", y: 18},
						{label: "동구", y: 20},
						{label: "남구", y: 36},
						{label: "연수구", y: 28},
						{label: "남동구", y: 42},
						{label: "부평구", y: 26},
						{label: "계양구", y: 21},
						{label: "서구", y: 34},
						{label: "강화군", y: 3},
						{label: "옹진군", y: 7},
						{label: "공사/공단", y: 11}
						]
					}*/
					
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
				            	chart1.render();
				            }
				          },
				        });
		
		var chart2 = new CanvasJS.Chart("chartContainer2",
				{
					theme: "theme2",
		                        animationEnabled: true,
					title:{
						text: "기관별 사이버 소양/취미 교육 수료 현황",
						fontSize: 12
					},
					toolTip: {
						shared: true
					},
					axisX: {				
						labelFontSize: 12,
						interval:1
					},
					axisY: {
						title: "인원",
						fontSize: 6
					},
									
					data: [ 
					{
						type: "column",	
						name: "신청 인원",
						legendText: "신청 인원",
						showInLegend: true, 
						indexLabelFontColor : "red",
						indexLabelFontSize : 12,			
						dataPoints:[
						{label: "시청", y: 348},
						{label: "중구", y: 38},
						{label: "동구", y: 58},
						{label: "남구", y: 126},
						{label: "연수구", y: 62},
						{label: "남동구", y: 38},
						{label: "부평구", y: 104},
						{label: "계양구", y: 25},
						{label: "서구", y: 104},
						{label: "강화군", y: 22},
						{label: "옹진군", y: 67},
						{label: "공사/공단", y: 25}
						]
					},
					{
						type: "column",	
						name: "수료 인원",
						legendText: "수료 인원",			
						showInLegend: true,							
						dataPoints:[
						{label: "시청", y: 267 },
						{label: "중구", y: 37 },
						{label: "동구", y: 47},
						{label: "남구", y: 108},
						{label: "연수구", y: 52},
						{label: "남동구", y: 28},
						{label: "부평구", y: 78},
						{label: "계양구", y: 20},
						{label: "서구", y: 74},
						{label: "강화군", y: 15},
						{label: "옹진군", y: 65},
						{label: "공사/공단", y: 18}
						]
					},
					
					{
						type: "line",	
						name: "수료율",
						legendText: "수료율",				
						showInLegend: true,		
						indexLabelFontColor : "red",
						indexLabelFontSize : 12,	
						axisYType:"secondary",
						dataPoints:[
						{label: "시청", y: 76.7 , indexLabel:"수료율 : 76.7%"},
						{label: "중구", y: 97.4, indexLabel:"97.4%"},
						{label: "동구", y: 81.0, indexLabel:"81.0%"},
						{label: "남구", y: 85.7, indexLabel:"85.7%"},
						{label: "연수구", y: 83.9, indexLabel:"83.9%"},
						{label: "남동구", y: 73.7, indexLabel:"73.7%"},
						{label: "부평구", y: 75.0, indexLabel:"75.0%"},
						{label: "계양구", y: 80.0, indexLabel:"80.0%"},
						{label: "서구", y: 71.2, indexLabel:"71.2%"},
						{label: "강화군", y: 68.2, indexLabel:"68.2%"},
						{label: "옹진군", y:97.0, indexLabel:"97.0%"},
						{label: "공사/공단", y: 72.0, indexLabel:"72.0%"}				
						]
					}
					
					/*
					{
						type: "column",	
						name: "미수료인원 ",
						legendText: "미수료인원",			
						showInLegend: true,
						dataPoints:[
						{label: "시청", y: 264},
						{label: "중구", y: 18},
						{label: "동구", y: 20},
						{label: "남구", y: 36},
						{label: "연수구", y: 28},
						{label: "남동구", y: 42},
						{label: "부평구", y: 26},
						{label: "계양구", y: 21},
						{label: "서구", y: 34},
						{label: "강화군", y: 3},
						{label: "옹진군", y: 7},
						{label: "공사/공단", y: 11}
						]
					}*/
					
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
				            	chart2.render();
				            }
				          },
				        });

chart.render();
chart1.render();
chart2.render();
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
			<li><a href="javascript:fnGoMenu('4','yearof2016');">2016년 결과 </a></li>	
            <li class="TabOn"><a href="javascript:fnGoMenu('4','cyber');">2017년 현황</a></li>
                        
            <li><a href="javascript:fnGoMenu('4','departBest');">기관별 추천</a></li>
            <li><a href="javascript:fnGoMenu('4','tierBest');">직급별 추천</a></li>
            <li ><a href="javascript:fnGoMenu('4','ageBest');">연령별 추천</a></li>
            <li><a href="javascript:fnGoMenu('4','genderBest');">남여별 추천</a></li>
            
            <li><a href="javascript:fnGoMenu('4','languageBest');">외국어 교육</a></li>
          	</ol>
          	<p><BR><p>
          	
			  <font size="3px"><b>◇  사이버 전문 교육  </b></font>
			  
			  <p><BR><p> 	
			  
              <div id="chartContainer" style="height: 400px; width: 650px;"></div>
              
              <p><BR><p>
          	
			  <font size="3px"><b>◇   사이버 소양/취미 교육  </b></font>
			  
			  <p><BR><p> 	
              <div id="chartContainer2" style="height: 400px; width: 650px;"></div>
              
              	<p><BR><p>
          	
			  <font size="3px"><b>◇   사이버 외국어 교육  </b></font>
			  
			  <p><BR><p> 	
              <div id="chartContainer1" style="height: 400px; width: 650px;"></div>
              
               <!-- //contnet -->
          </div>
        </div>
    	
    
    
    </div>
    
 <jsp:include page="/homepage_new/inc/footer.jsp" flush="true" ></jsp:include>

    
    