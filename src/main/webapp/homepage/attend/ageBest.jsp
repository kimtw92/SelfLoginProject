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


<%
    //request 데이터
	DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
	requestMap.setNullToInitialize(true);

	// 필수 코딩 내용 //////////////////////////////////////////////////////////////////////
	//로그인된 사용자 정보
	
	String searchYear = Util.getValue(requestMap.getString("searchYear"),(String)request.getAttribute("DATE_YEAR"));
	
	
	// 리스트
	StringBuffer sbListHtml = new StringBuffer();
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	if(listMap == null) listMap = new DataMap();
	listMap.setNullToInitialize(true);
	
	String colName = "";
	String bgColor = "";
	
	if(listMap.keySize("userage") > 0){		
		for(int i=0; i < listMap.keySize("userage"); i++){
			
			// tr 배경색
			/* if(listMap.getString("pflag", i).equals("A")){
				bgColor = "bgcolor=\"#cccccc\"";				
			}else if(listMap.getString("pflag", i).equals("B")){
				bgColor = "bgcolor=\"ffcc00\"";
			}else{
				bgColor = "";
			} */
			
			sbListHtml.append("<tr " + bgColor + " >");
			
			sbListHtml.append("	<td style=\"text-align: center\">" + listMap.getString("userage", i) + "대 </td>");
			sbListHtml.append("	<td style=\"text-align: left\">&nbsp;&nbsp;&nbsp;" + listMap.getString("subj", i) + "</td>");			
			
			sbListHtml.append("</tr>");
		}
	}
	
	
%>



<script src="http://hrd.incheon.go.kr/homepage_new/js/canvasjs.min.js"></script>
<jsp:include page="/homepage_new/inc/header.jsp" flush="true" ></jsp:include>
    
    <div id="subContainer">
    
    <div class="subNavi_area">
    
      <jsp:include page="/homepage_new/inc/left3.jsp" flush="true" ></jsp:include>
    
      </div>
    
        <div id="contnets_area">
          <div class="sub_visual3">교육신청</div>
            <div class="local">
              <h2>연령별 추천과정</h2>
                <div class="navi"><img src="/homepage_new/images/common/icon_home.gif" alt="home"> &gt; 교육신청 &gt; <span>수료현황 및 추천과정</span></div>
            </div>
            <div class="contnets">
            <!-- contnet -->

              <!--//검색  -->	
						<ol class="TabSub">
			<li><a href="javascript:fnGoMenu('4','yearof2016');">2016년 결과 </a></li>						
            <li><a href="javascript:fnGoMenu('4','cyber');">2017년 현황</a></li>            
            <li><a href="javascript:fnGoMenu('4','departBest');">기관별 추천</a></li>
            <li><a href="javascript:fnGoMenu('4','tierBest');">직급별 추천</a></li>
            <li class="TabOn"><a href="javascript:fnGoMenu('4','ageBest');">연령별 추천</a></li>
            <li><a href="javascript:fnGoMenu('4','genderBest');">남여별 추천</a></li>
            <li><a href="javascript:fnGoMenu('4','languageBest');">외국어 교육</a></li>
          	</ol>
          	
	          	<table class="dataH07"> 
	            <colgroup>
	            <col width="" />
	            <col width="" />
	            <col width="" />
	            <col width="" />
	            </colgroup>
	
	            <thead>
	            <tr>
	                <th class="t04">연령</th>
	                <th class="t04">과정명</th>
	            </thead>
	            <tbody>
	           <%= sbListHtml.toString() %>
	            </tbody>
	            </table>
	            
	             <form id="pform" name="pform" method="post">
	          	<input type="hidden" id="mode" name="mode"	value="ageBest">
				<!-- contnet -->
	              <div class="board_search03">              
	              <select name="key" id="key">
	                	<option value="201601" <%if(requestMap.getString("key").equals("201601")){out.print("selected");} %>>2016년 2월</option>
	               		<option value="201602" <%if(requestMap.getString("key").equals("201602")){out.print("selected");} %>>2016년 3월</option>
	               		<option value="201603" <%if(requestMap.getString("key").equals("201603")){out.print("selected");} %>>2016년 4월</option>
	               		<option value="201604" <%if(requestMap.getString("key").equals("201604")){out.print("selected");} %>>2016년 5월</option>
	               		<option value="201605" <%if(requestMap.getString("key").equals("201605")){out.print("selected");} %>>2016년 6월</option>
	               		<option value="201606" <%if(requestMap.getString("key").equals("201606")){out.print("selected");} %>>2016년 7월</option>
	               		<option value="201607" <%if(requestMap.getString("key").equals("201607")){out.print("selected");} %>>2016년 8월</option>
	               		<option value="201608" <%if(requestMap.getString("key").equals("201608")){out.print("selected");} %>>2016년 9월</option>
	               		<option value="201609" <%if(requestMap.getString("key").equals("201609")){out.print("selected");} %>>2016년 10월</option>
	               		<option value="201610" <%if(requestMap.getString("key").equals("201610") ){out.print("selected");} %>>2016년 11월</option>
	               		<option value="201701" <%if(requestMap.getString("key").equals("201701") ){out.print("selected");} %>>2017년 02월</option>
	               		<option value="201702" <%if(requestMap.getString("key").equals("201702") ){out.print("selected");} %>>2017년 03월</option>
	               		<option value="201704" <%if(requestMap.getString("key").equals("201704") ){out.print("selected");} %>>2017년 05월</option> 
	               		<option value="201705" <%if(requestMap.getString("key").equals("201705") ){out.print("selected");} %>>2017년 06월</option>
	               		<option value="201706" <%if(requestMap.getString("key").equals("201706") ){out.print("selected");} %>>2017년 07월</option>
	               		<option value="201707" <%if(requestMap.getString("key").equals("201707") ){out.print("selected");} %>>2017년 08월</option>
	               		<option value="201708" <%if(requestMap.getString("key").equals("201708") ){out.print("selected");} %>>2017년 09월</option>
	               		<option value="201709" <%if(requestMap.getString("key").equals("") || requestMap.getString("key").equals("201709") ){out.print("selected");} %>>2017년 10월</option>
	               </select>
	             
			      <a href="javascript:goSearch();"><img id="btnSeach" src="/homepage_new/images/board/btn_search.gif" border="0" align="absmiddle" style="cursor:hand;"></a>
	            </div>
	            </form>
	            
            
          
              
            <!-- //contnet -->
          </div>
        </div>
    	
    
    
    </div>
    
 <jsp:include page="/homepage_new/inc/footer.jsp" flush="true" ></jsp:include>
    