<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commonInc/include/commonImport.jsp" %>
<%@ include file="/commonInc/include/comInclude.jsp" %>
<jsp:include page="/commonInc/include/comHtmlTop.jsp" flush="false">
	<jsp:param name="cssName" value="layout" />
</jsp:include>

<script type="text/javascript" language="javascript" src="/commonInc/js/commonJs.js"></script>
<script language="javascript">

	//페이지 이동
	function go_page(page) {
		$("currPage").value = page;
		showYearEducationMonthTab($("month").value);
		
	}
	
	// 리스트
	function fnList(){
		$("mode").value = "eduinfo2-3";
		pform.action = "/homepage/infomation.do";
		pform.submit();
	}
	function showYearEducationMonthTab(month) {

		var paging = $('changepaging');
		paging.hide();
		
		if(month.length == 2 ) {
		
		}else{
			month = '0'+month;	
		}
		
		for(var i=1;i<=12;i++) {
			var a = document.getElementById('leftImg2'+i);
			if(eval(month) == i) {
				a.src="/images/skin4/common/tab_month"+i+"_on.gif";
			}else {
				a.src="/images/skin4/common/tab_month"+i+".gif";
			}
		}
		
		
		yearmonthajax(month);
	}
	
	function yearmonthajax(month) {
		
		var url = "infomation.do";
		pars = "month=" + month + "&mode=educationmonthajax&currPage="+$("currPage").value;
		var divID = "yearmonthajax";
			
		var myAjax = new Ajax.Updater(
				{success: divID },
				url, 
				{
					method: "post", 
					parameters: pars,
					onLoading : function(){
						//$("yearmonthajax").startWaiting('bigWaiting');
					},
					onSuccess : function(){
						
						//window.setTimeout( $(document.body).stopWaiting.bind( $(document.body) ), 500);
						$("month").value = month;
						$("currPage").value = 1;
					},
					onFailure : function(){					
						//window.setTimeout( $(document.body).stopWaiting.bind( $(document.body) ), 500);
						alert("데이타를 가져오지 못했습니다.");
					}	
				}
			);
	}
</script>

<%
// 필수, request 데이타
	DataMap requestMap1 = (DataMap)request.getAttribute("REQUEST_DATA");
	requestMap1.setNullToInitialize(true);
	
	

	DataMap requestMap = (DataMap)request.getAttribute("EDUCATION_MONTH_LIST");
	requestMap.setNullToInitialize(true);
	

	// 페이징 필수
	FrontPageNavigation pageNavi = (FrontPageNavigation)requestMap.get("PAGE_INFO");
	int pageNum = pageNavi.getTotalCnt() - (requestMap.getInt("currPage") - 1) * requestMap.getInt("rowSize");
	
	String pageStr = "";
	
	StringBuffer monthListHtml = new StringBuffer();

	if(requestMap.keySize("grcodeniknm") > 0){		
		for(int i=0; i < requestMap.keySize("grcodeniknm"); i++){
			
			
				
			monthListHtml.append("<tr>");
			monthListHtml.append("<td class=\"bl0\">"+requestMap.getString("gubun", i)+"</td>");
			monthListHtml.append("<td><a href=javascript:popWin(\"/homepage/course.do?mode=courseinfopopup&grcode="+requestMap.getString("grcode", i)+"&grseq="+requestMap.getString("grseq", i)+"\",\"aaa\",\"603\",\"680\",\"yes\",\"yes\")>"+requestMap.getString("grcodeniknm", i)+"</a></td>");
			monthListHtml.append("<td>"+requestMap.getString("eapplyst", i)+"~"+requestMap.getString("eapplyed", i)+"</td>");
			monthListHtml.append("<td>"+requestMap.getString("started", i)+"~"+requestMap.getString("enddate", i)+"</td>");
			monthListHtml.append("<td>"+requestMap.getString("tseat", i)+"</td>");
			monthListHtml.append("<td>"+requestMap.getString("tdate", i)+"</td>");
			monthListHtml.append("<td><a href=javascript:popWin(\"/homepage/course.do?mode=courseinfopopup&grcode="+requestMap.getString("grcode", i)+"&grseq="+requestMap.getString("grseq", i)+"\",\"aaa\",\"603\",\"680\",\"yes\",\"yes\")><img src=\"/images/skin1/button/btn_deInfo.gif\" alt=\"상세정보\" /></a></td>");
			monthListHtml.append("</tr>");
			
			
		}
		pageStr = pageNavi.FrontPageStr();	
	}

%>
<jsp:include page="/homepage_new/inc/header.jsp" flush="true" ></jsp:include>
    
    <div id="subContainer">
    
    <div class="subNavi_area">
    
      <jsp:include page="/homepage_new/inc/left2.jsp" flush="true" ></jsp:include>
    
      </div>
    
        <div id="contnets_area">
          <div class="sub_visual2">교육과정</div>
                              
            <div style="margin-bottom: 15px;" class="local">
              <h2>연간교육일정</h2>
                <div class="navi"><img src="/homepage_new/images/common/icon_home.gif" alt="home"> &gt; 교육과정 &gt; <span>연간교육일정</span></div>
            </div>
           	<h3>e-러닝(전문) 학습안내</h3>
			<a href="http://incheon.nhi.go.kr/"><font color="red"> 2019년부터 e-러닝(전문)은 인천시 나라배움터 사이트에서 학습가능 <br/>나라배움터 학습 사이트 바로가기 : incheon.nhi.go.kr</font></a>		
            
            <div style="margin-top: -2px;" class="contnets">
			<form id="pform" id="pform" name="pform" method="post">

<!-- 필수 -->
<input type="hidden" id="mode" name="mode"		value="<%= requestMap1.getString("mode") %>">

<!-- 페이징용 -->
<input type="hidden" id="currPage" name="currPage"	value="<%= requestMap1.getString("currPage")%>">
<input type="hidden" id="month" name="month"		value="<%= requestMap1.getString("month") %>">
            <!-- contnet -->
            <div id="content">
			
			<div class="h9"></div>

			<!-- 탭 -->
			<div class="tabs04">
				<ul>
					<%
						java.util.Calendar c = java.util.Calendar.getInstance();
						String monthA = Util.plusZero(c.get(Calendar.MONTH)+1);					
						int month = Integer.parseInt(monthA);
		
					%>
					<li><a href="javascript:showYearEducationMonthTab('1');"><img src="/images/<%= skinDir %>/common/tab_month1<%if(month==1){%>_on<%}%>.gif" id="leftImg21" alt="1월" /></a></li>
					<li><a href="javascript:showYearEducationMonthTab('2');"><img src="/images/<%= skinDir %>/common/tab_month2<%if(month==2){%>_on<%}%>.gif" id="leftImg22" alt="2월" /></a></li>
					<li><a href="javascript:showYearEducationMonthTab('3');"><img src="/images/<%= skinDir %>/common/tab_month3<%if(month==3){%>_on<%}%>.gif" id="leftImg23" alt="3월" /></a></li>
					<li><a href="javascript:showYearEducationMonthTab('4');"><img src="/images/<%= skinDir %>/common/tab_month4<%if(month==4){%>_on<%}%>.gif" id="leftImg24" alt="4월" /></a></li>
					<li><a href="javascript:showYearEducationMonthTab('5');"><img src="/images/<%= skinDir %>/common/tab_month5<%if(month==5){%>_on<%}%>.gif" id="leftImg25" alt="5월" /></a></li>
					<li><a href="javascript:showYearEducationMonthTab('6');"><img src="/images/<%= skinDir %>/common/tab_month6<%if(month==6){%>_on<%}%>.gif" id="leftImg26" alt="6월" /></a></li>
					<li><a href="javascript:showYearEducationMonthTab('7');"><img src="/images/<%= skinDir %>/common/tab_month7<%if(month==7){%>_on<%}%>.gif" id="leftImg27" alt="7월" /></a></li>
					<li><a href="javascript:showYearEducationMonthTab('8');"><img src="/images/<%= skinDir %>/common/tab_month8<%if(month==8){%>_on<%}%>.gif" id="leftImg28" alt="8월" /></a></li>
					<li><a href="javascript:showYearEducationMonthTab('9');"><img src="/images/<%= skinDir %>/common/tab_month9<%if(month==9){%>_on<%}%>.gif" id="leftImg29" alt="9월" /></a></li>
					<li><a href="javascript:showYearEducationMonthTab('10');"><img src="/images/<%= skinDir %>/common/tab_month10<%if(month==10){%>_on<%}%>.gif" id="leftImg210" alt="10월" /></a></li>
					<li><a href="javascript:showYearEducationMonthTab('11');"><img src="/images/<%= skinDir %>/common/tab_month11<%if(month==11){%>_on<%}%>.gif" id="leftImg211" alt="11월" /></a></li>
					<li><a href="javascript:showYearEducationMonthTab('12');"><img src="/images/<%= skinDir %>/common/tab_month12<%if(month==12){%>_on<%}%>.gif" id="leftImg212" alt="12월" /></a></li>
				</ul>
			</div>
			<!-- //탭 -->

			<!-- data -->
			<table class="bList01">	
			<colgroup>
				<col width="50" />
				<col width="*" />
				<col width="135" />
				<col width="135" />
				<col width="57" />
				<col width="60" />
				<col width="57" />
			</colgroup>

			<thead>
			<tr>
				<th class="b20">구분</th>
				<th class="b20">과정명(기수)</th>
				<th class="b20">신청기간</th>
				<th class="b20">교육기간</th>
				<th class="b20">교육인원</th>
				<th class="b20">학습시간</th>
				<th class="b20">상세정보</th>
			</tr>
			</thead>
			

			<tbody id="yearmonthajax">
					<%= monthListHtml%>

				<tr>
					<td colspan="7" class='sbj02'>

						<!--[s] 페이징 -->
						<div id="changepaging" class="paging">
						<%= pageStr %>
						</div>
						<!--//[s] 페이징 -->
					</td>
				</tr>
			</tbody>
			</table>
			

		</div>
		</form>
		    <jsp:include page="/homepage_new/inc/admin_info.jsp" flush="true" ><jsp:param name="menucode" value="M100002" /></jsp:include>
            <div class="h80"></div>	
			<!-- //contnet -->
          </div>
        </div>
    
    
    </div>

    <jsp:include page="/homepage_new/inc/footer.jsp" flush="true" ></jsp:include>