<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commonInc/include/commonImport.jsp" %>
<%@ include file="/commonInc/include/comInclude.jsp" %>
<jsp:include page="/commonInc/include/comHtmlTop.jsp" flush="false">
	<jsp:param name="cssName" value="layout" />
</jsp:include>

<%
// 공지사항 리스트
	DataMap listMap1 = (DataMap)request.getAttribute("EAT_LIST_1");
	DataMap listMap2 = (DataMap)request.getAttribute("EAT_LIST_2");
	DataMap listMap3 = (DataMap)request.getAttribute("EAT_LIST_3");
	
	listMap1.setNullToInitialize(true);
	listMap2.setNullToInitialize(true);
	listMap3.setNullToInitialize(true);
	
	StringBuffer eatTitleHtml = new StringBuffer();
	
	StringBuffer eatContentsHtml1 = new StringBuffer();
	StringBuffer eatContentsHtml2 = new StringBuffer();
	StringBuffer eatContentsHtml3 = new StringBuffer();
	
	
	// 초기값, 아무 의미 없음.
	String startYear="0000";
	String startMonth="00";
	String startDay="00";
	String endYear="0000";
	String endMonth="00";
	String endDay="00";
	
	int existCount = 0;
	
	// 아침, 점심, 저녁중에서 있는 리스트맵을 사용하기 위해서...
	if(listMap1.getString("fyear", 0) != "") {
		startYear=listMap1.getString("fyear", 0);
		startMonth=listMap1.getString("fmonth", 0);
		startDay=String.valueOf(listMap1.getString("fdate", 0));
		endYear=listMap1.getString("fyear", 4);
		endMonth=listMap1.getString("fmonth", 4);
		endDay=String.valueOf(listMap1.getString("fdate", 4));	
		++existCount;
	}else if(listMap2.getString("fyear", 0) != "") {
		startYear=listMap2.getString("fyear", 0);
		startMonth=listMap2.getString("fmonth", 0);
		startDay=String.valueOf(listMap2.getString("fdate", 0));
		endYear=listMap2.getString("fyear", 4);
		endMonth=listMap2.getString("fmonth", 4);
		endDay=String.valueOf(listMap2.getString("fdate", 4));
		++existCount;
	}else if(listMap3.getString("fyear", 0) != "") {
		startYear=listMap3.getString("fyear", 0);
		startMonth=listMap3.getString("fmonth", 0);
		startDay=String.valueOf(listMap3.getString("fdate", 0));
		endYear=listMap3.getString("fyear", 4);
		endMonth=listMap3.getString("fmonth", 4);
		endDay=String.valueOf(listMap3.getString("fdate", 4));
		++existCount;
	}
	
	eatTitleHtml.append(startYear+"년"+startMonth+"월"+startDay+"일 ~ ");
	eatTitleHtml.append(endYear+"년"+endMonth+"월"+endDay+"일");

	if(listMap1.getString("fyear", 0) != "") {
		for(int i=0; i<5;i++) {
			if(i==4) {
				eatContentsHtml1.append("<td class=\"taR\"> ");		
			}else {
				eatContentsHtml1.append("<td> ");
			}
			eatContentsHtml1.append("<b>[아침]</b>");
			eatContentsHtml1.append("<span>"+listMap1.getString("gubun", i)+"</span><br /> ");	
			eatContentsHtml1.append(listMap1.getString("content", i));	
			eatContentsHtml1.append("</td> ");	
		}
	}

	if(listMap2.getString("fyear", 0) != "") {
		for(int i=0; i<5;i++) {
			if(i==4) {
				eatContentsHtml2.append("<td valign=top class=\"taR\"> ");		
			}else {
				eatContentsHtml2.append("<td valign=top> ");
			}
			eatContentsHtml2.append("<b>[점심]</b>");
			eatContentsHtml2.append("<span>"+listMap2.getString("gubun", i)+"</span><br /> ");	
			
			String changeHtml = listMap2.getString("content", i).replace("\r","<br>&nbsp;&nbsp;·");
			changeHtml = "&nbsp;&nbsp;· "+changeHtml;
			//eatContentsHtml2.append(listMap2.getString("content", i));	
			eatContentsHtml2.append("<p align=left>"+changeHtml+"</p>");	
			
			eatContentsHtml2.append("</td> ");	
		}
	}

	if(listMap3.getString("fyear", 0) != "") {
		for(int i=0; i<5;i++) {
			if(i==4) {
				eatContentsHtml3.append("<td class=\"taR\"> ");		
			}else {
				eatContentsHtml3.append("<td> ");
			}
			eatContentsHtml3.append("<b>[저녁]</b>");
			eatContentsHtml3.append("<span>"+listMap3.getString("gubun", i)+"</span><br /> ");	
			eatContentsHtml3.append(listMap3.getString("content", i));	
			eatContentsHtml3.append("</td> ");	
		}	
	}
	
%>

<script>

	function preweek() {
		location.href='/homepage/introduce.do?mode=eduinfo7-4&weekcount='+ <%=Integer.parseInt((String)request.getAttribute("weekcount"))+7%>;
	}

	function postweek() {
		location.href='/homepage/introduce.do?mode=eduinfo7-4&weekcount='+ <%=Integer.parseInt((String)request.getAttribute("weekcount"))-7%>;
	}
	
	document.observe("dom:loaded", function() {
		if(<%=existCount%> == 0 ) {
			alert("식단표가 존재하지 않습니다.");
			history.back(-1);
		}
	});
</script>

<jsp:include page="/homepage_new/inc/header.jsp" flush="true" ></jsp:include>
    
    <div id="subContainer">
    
    <div class="subNavi_area">
    
      <jsp:include page="/homepage_new/inc/left5.jsp" flush="true" ></jsp:include>
    
      </div>
    
        <div id="contnets_area">
          <div class="sub_visual5">교육지원</div>
            <div class="local">
              <h2>식단표</h2>
                <div class="navi"><img src="/homepage_new/images/common/icon_home.gif" alt="home"> &gt; 교육지원 &gt; <span>식단표</span></div>
            </div>
            <div class="contnets">
            <!-- contnet -->
            <form id="pform" name="pform" method="post">
			<div class="spaceTop"></div>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;인재개발원 식당은 <b>교육생 </b>및 <b>직원</b>에 한해 이용이 가능합니다. <br><br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;이용문의 : <b>032) 440 - 7754</b> <br><br><br>
		<!-- content s ===================== -->
		<div id="content">
			<!-- title --> 
			<div id="Thead">
				<ul id="Tamenu">
					<li class="top1Head"><img src="/images/skin1/table/menu_thead.jpg" alt="" /></li>
					<li class="top1body">
						<ul class="Tdate" >
							<li><a href="javascript:preweek();"><img src="/images/skin1/table/menu_p.gif" alt="" /></a></li>
							<li class="txt"><%=eatTitleHtml%></li>
							<li><a href="javascript:postweek();"><img src="/images/skin1/table/menu_n.gif" alt="" /></a></li>
						</ul>
					</li>
					<li class="top1Tail"><img src="/images/skin1/table/menu_tail.jpg" alt="" /></li>
				</ul>
			</div>
			<!-- data -->
			<table class="dataH04">	
			<colgroup>
				<col width="123" />
				<col width="123" />
				<col width="123" />
				<col width="123" />
				<col width="123" />
			</colgroup>
			<thead>
			<tr>
				<th class="taL">MON (<%=listMap2.getString("fdate", 0)%>)</th>
				<th>THE (<%=listMap2.getString("fdate", 1)%>)</th>
				<th>WED (<%=listMap2.getString("fdate", 2)%>)</th>
				<th>THU (<%=listMap2.getString("fdate", 3)%>)</th>
				<th class="taR">FRI (<%=listMap2.getString("fdate", 4)%>)</th>
			</tr>
			</thead>

			<tbody>
			<tr>				
				<%=StringReplace.convertContentToWebEdit(eatContentsHtml1.toString()) %>
			</tr>
			<tr>
				<%=eatContentsHtml2.toString() %>
			</tr>
			<tr>
				<%=StringReplace.convertContentToWebEdit(eatContentsHtml3.toString()) %>
			</tr>
			<!-- 
			<tr class="total">
				<td>총 700KCal</td>
				<td>총 700KCal</td>
				<td>총 700KCal</td>
				<td>총 700KCal</td>
				<td class="taR">총 700KCal</td>
			</tr>
			 -->
			</tbody>
			</table>
			<!-- //data --> 
			
			<div class="BtmLine"></div>

		</div>

			</form>
			<jsp:include page="/homepage_new/inc/admin_info.jsp" flush="true" ><jsp:param name="menucode" value="M100030" /></jsp:include>
			<div class="h80"></div>
            <!-- //contnet -->
          </div>
        </div>
    
    
    </div>

    <jsp:include page="/homepage_new/inc/footer.jsp" flush="true" ></jsp:include>