<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commonInc/include/commonImport.jsp" %>
<%@ include file="/commonInc/include/comInclude.jsp" %>
<jsp:include page="/commonInc/include/comHtmlTop.jsp" flush="false">
	<jsp:param name="cssName" value="layout" />
</jsp:include>
<script language="javascript" src="/commonInc/js/commonJs.js"></script>
<%

//필수, request 데이타
DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
requestMap.setNullToInitialize(true);

// 보드 뷰 
DataMap viewMap = (DataMap)request.getAttribute("LIST_DATA");
requestMap.setNullToInitialize(true);

StringBuffer innerHtml = new StringBuffer();

if (Util.getIntValue(viewMap.getString("groupfileNo"), 0) > 0){
	
	DataMap fileGroup = (DataMap)viewMap.get("FILE_GROUP_LIST");
	
	if (fileGroup.keySize("groupfileNo") > 0){
		
		for(int i=0,l=fileGroup.keySize("groupfileNo");i<l;i++){
			
			String fileName =  fileGroup.getString("fileName");
			String extName = fileName.substring(fileName.indexOf(".")+1,fileName.length());
			
			if (!extName.equals("hwp") && !extName.equals("jpg")){
				extName = "fileDwn";
			}
			// 권한없음으로 나와서 임시로 처리함
			if (extName.equals("hwp")){
				extName = "han";
			}
						
			innerHtml.append("<a href=\"javascript:fileDownload('"+fileGroup.getString("groupfileNo")+"', '"+fileGroup.getString("fileNo")+"');\">");
			innerHtml.append("<img src=\"/images/"+ skinDir +"/icon/icon_"+extName+".gif\" /><span class=\"vp2\">"+fileGroup.getString("fileName")+"</span>");
			innerHtml.append("</a>&nbsp;");
			//if ( i != 0 && i%4 == 0){
			//	innerHtml.append("<br />");
			//}
		}
	}
	
}
%>

<script language="JavaScript" type="text/JavaScript">
<!--

// 페이지 이동
function go_page(page) {
	$("currPage").value = page;
	fnList();
}

// 리스트
function fnList(){
	pform.action = "/mypage/myclass.do?mode=selectGrnoticeList";
	pform.submit();
}

//-->
</script>
<jsp:include page="/homepage_new/inc/header.jsp" flush="true" ></jsp:include>
    
    <div id="subContainer">
    
    <div class="subNavi_area">
    
      <jsp:include page="/homepage_new/inc/left1.jsp" flush="true" ></jsp:include>
    
      </div>
    
        <div id="contnets_area">
          <div class="sub_visual"><img src="/homepage_new/images/common/sub_visual1.jpg" alt="인재원 소개 인천광역시 인재개발원에 대한 소개 및 시설정보를 제공합니다."></div>
            <div class="local">
              <h2>나의강의실</h2>
                <div class="navi"><img src="/homepage_new/images/common/icon_home.gif" alt="home"> &gt; 마이페이지 &gt; <span>나의강의실</span></div>
            </div>
            <div class="contnets">
            <!-- contnet -->
			<div style="margin:1px;">					<!-- ※ 사이버 과정을 <font color="red">95% 이상</font> 수강하신 분은 <font color="red">21일까지 과정평가와 과정설문을 완료</font>하셔야 합니다. <font color="blue">(21일 이후 일괄 이수처리)</font><br />
					※ 교육기간 중에만 학습이 가능하며, 1일 최대 학습분량은 <font color="blue">20차시 이상은 7차시, 20차시 미만은 5차시로 </font>제한합니다.<br />
					※ <b><font color="blue">학습관련 장애</font></b>(진도율 0%인 경우 등) 시  <b><font color="blue">「인터넷 환경설정 필수 조치사항」</font></b> 안내에 따라 조치하여 주시기 바랍니다.(<a href="http://hrd.incheon.go.kr/homepage/support.do?mode=faqView&fno=60" target="_blank"><b>조치방법 보기</b></a>)<br /></div> -->
					※ <font color="red"> 학습기간(매월 1일~21일)내 진도율 95% 이상, 과정평가 및 과정설문 완료 필수</font>(일괄 수료처리 후 매월23일경 수료<br />  결과통보)<br />
					※ <font color="red"> 진도율 올라가지 않는 등</font> 학습장애시  (<a href="http://hrd.incheon.go.kr/homepage/support.do?mode=faqView&fno=63" target="_blank"><font color="blue"><b>「학습관련 장애시 대처방법」</b></font></a>)안내 참고
			</div>		
            <div class="mytab01">
              <ul>
                <li><a href="javascript:fnGoMenu('1','selectCourseList')"><img src="/homepage_new/images/M1/tab01.gif" alt="과정리스트"/></a></li>
                <li><a href="javascript:fnGoMenu('1','selectGrnoticeList')""><img src="/homepage_new/images/M1/tab02_on.gif" alt="과정공지"/></a></li>
                <li><a href="javascript:fnGoMenu('1','pollList')""><img src="/homepage_new/images/M1/tab03.gif" alt="과정설문"/></a></li>
                <li><a href="javascript:fnGoMenu('1','testView')""><img src="/homepage_new/images/M1/tab04.gif" alt="과정평가"/></a></li>
                <li><a href="javascript:fnGoMenu('1','discussList')""><img src="/homepage_new/images/M1/tab05.gif" alt="과정토론방"/></a></li>
                <li><a href="javascript:fnGoMenu('1','suggestionList')""><img src="/homepage_new/images/M1/tab06.gif" alt="과정질문방"/></a></li>
                <li><a href="javascript:fnGoMenu('1','courseInfoDetail')""><img src="/homepage_new/images/M1/tab07.gif" alt="교과안내문"/></a></li>
                <li><a href="javascript:fnGoMenu('1','sameClassList')""><img src="/homepage_new/images/M1/tab08.gif" alt="동기모임"/></a></li>
              </ul>
              </div>

			  <form id="pform" name="pform" method="post">
<!-- 필수 -->
<input type="hidden" name="mode"		value="<%= requestMap.getString("mode") %>">
<input type="hidden" name="kind"		value="<%= requestMap.getString("kind") %>">
<input type="hidden" name="no"		value="<%= requestMap.getString("no") %>">
<input type="hidden" name="rMode"		value="<%= requestMap.getString("rMode") %>">

<!-- 필수 -->
<!-- 페이징용 -->
<input type="hidden" name="currPage"	value="<%= requestMap.getString("currPage")%>">
		<div id="content">
						<div class="h9"></div>
			
						<!-- view -->
						<table class="bView01">
						<tr>
							<th width="80"><img src="/images/<%= skinDir %>/table/th_sbj.gif" alt="제목" /></th>
							<td >
								<%=viewMap.getString("title", 0) %>
							</td>
							<th width="75"><img src="/images/<%= skinDir %>/table/th_date.gif" alt="작성일" /></th>
							<td width="100"><%=viewMap.getString("regdate", 0) %></td>
						</tr>
						<tr>
							<th class="bl0"><img src="/images/<%= skinDir %>/table/th_addfile01.gif" alt="첨부파일" /></th>
							<td colspan="3">
								<%=innerHtml.toString() %>
							</td>
						</tr>
						
						<tr>
							<td class="bl0 cont" colspan="4">
							<%=StringReplace.convertHtmlDecode(viewMap.getString("content", 0))%>
							</td>
						</tr>
						</table>	
						<!-- //view -->
			
						<!-- button -->
						<div class="btnRbtt">			
							<a href="javascript:fnList();"><img src="/images/<%= skinDir %>/button/btn_list02.gif" alt="리스트" /></a>
						</div>
						<!-- //button -->
						<div class="space"></div>
					</div>

</form>
              
              
            <!-- //contnet -->
          </div>
        </div>
    
    
    </div>

    <jsp:include page="/homepage_new/inc/footer.jsp" flush="true" ></jsp:include>