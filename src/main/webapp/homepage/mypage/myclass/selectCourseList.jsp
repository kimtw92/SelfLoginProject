<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commonInc/include/commonImport.jsp" %>
<%@ include file="/commonInc/include/comInclude.jsp" %>
<jsp:include page="/commonInc/include/comHtmlTop.jsp" flush="false">
	<jsp:param name="cssName" value="layout" />
</jsp:include>
<script language="javascript" src="/commonInc/js/commonJs.js"></script>
<%

String type = (String)request.getAttribute("type");

// 필수, request 데이타
DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
requestMap.setNullToInitialize(true);

// 리스트
DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
listMap.setNullToInitialize(true);

StringBuffer sbListHtml = new StringBuffer();

String pageStr = "";
int iNum = 0;
if(listMap.keySize("userno") > 0){		
	for(int i=0; i < listMap.keySize("userno"); i++){
		sbListHtml.append("<tr>\n");
		sbListHtml.append("<td class=\"bl0\">"+(i+1)+"</td>\n");
		sbListHtml.append("<td>"+listMap.getString("lecTypeStr", i)+"</td>\n");
		sbListHtml.append("<td class=\"sbj01\">");
		
		if (Util.getIntValue(listMap.getString("repCnt",i),0) > 0){
			sbListHtml.append("<a href=\"javascript:goReport('"+requestMap.getString("grcode")+"', '"+requestMap.getString("grseq")+"', '"+listMap.getString("subj",i)+"', '"+listMap.getString("classno",i)+"','"+listMap.getString("lecType",i)+"')\">"+listMap.getString("lecnm",i)+"</a>");
		} else if(listMap.getString("nowdate",i).equals("Y")){
			sbListHtml.append("<a href=\"javascript:go_move('"+requestMap.getString("grcode")+"', '"+requestMap.getString("grseq")+"', '"+listMap.getString("subj",i)+"', '"+listMap.getString("classno",i)+"','"+listMap.getString("lecType",i)+"','N')\">"+listMap.getString("lecnm",i)+"</a>");
		} else if(listMap.getString("reSubj",i).equals("Y")){
			sbListHtml.append("<a href=\"javascript:go_move('"+requestMap.getString("grcode")+"', '"+requestMap.getString("grseq")+"', '"+listMap.getString("subj",i)+"', '"+listMap.getString("classno",i)+"','"+listMap.getString("lecType",i)+"','Y')\">"+listMap.getString("lecnm",i)+"</a>");
		} else {
			sbListHtml.append("&nbsp;<a href=\"javascript:alert('지정된 학습기간이 아닙니다.')\">"+listMap.getString("lecnm",i)+"</a>");
		}

		if (listMap.getString("lecTypeStr", i).equals("선택") && listMap.getString("deleteYN", i).equals("Y")){
			sbListHtml.append("&nbsp;<a href=\"javascript:replaceChoice('"+requestMap.getString("grcode")+"', '"+requestMap.getString("grseq")+"', '"+listMap.getString("subj",i)+"')\"><img src=\"/images/"+skinDir+"/button/btn_cancel03.gif\" alt=\"변경\" align=\"absmiddle\" /></a>");
		} else if (listMap.getString("lecTypeStr", i).equals("선택") && listMap.getString("reSubj", i).equals("N")){
			// sbListHtml.append("&nbsp;<a href=\"javascript:alert('수강기강 이전에만 변경 가능합니다.')\"><img src=\"/images/"+skinDir+"/button/btn_cancel03.gif\" alt=\"변경\" align=\"absmiddle\" /></a>");
		}
		
		sbListHtml.append("</td>\n");
		sbListHtml.append("<td>"+listMap.getString("tutorlist",i)+"</td>\n");
		
		sbListHtml.append("<td>"+listMap.getString("started",i)+"~"+listMap.getString("enddate",i)+" </td>\n");
		sbListHtml.append("<td>");
		if(listMap.getString("bookFilename",i).length() > 0){
			sbListHtml.append("다운");
		}else {
			sbListHtml.append("--");
		}
		sbListHtml.append("</td>\n");
		sbListHtml.append("<td>");
		if(listMap.getString("proFinename",i).length() > 0){
			sbListHtml.append("다운");
		} else {
			sbListHtml.append("--");
		}
		sbListHtml.append("</td>\n");
		sbListHtml.append("<td>");
		if(Util.getIntValue(listMap.getString("notiCnt",i),0) > 0){
			sbListHtml.append("<a href=\"javascript:gonoti_move('"+requestMap.getString("grcode")+"', '"+requestMap.getString("grseq")+"', '"+listMap.getString("subj",i)+"', '"+listMap.getString("classno",i)+"','"+listMap.getString("lecType",i)+"')\"><img src=\"/images/"+skinDir+"/button/btn_view02.gif\" alt=\"보기\" /></a>");
		}else {
			sbListHtml.append("--");
		}
		sbListHtml.append("</td>\n");
		sbListHtml.append("<td>");
		if(Util.getIntValue(listMap.getString("repCnt",i),0) > 0){
			sbListHtml.append("<a href=\"javascript:goReport('"+requestMap.getString("grcode")+"', '"+requestMap.getString("grseq")+"', '"+listMap.getString("subj",i)+"', '"+listMap.getString("classno",i)+"','"+listMap.getString("lecType",i)+"')\"><img src=\"/images/"+skinDir+"/button/btn_view02.gif\" alt=\"보기\" /></a>");
		} else {
			sbListHtml.append("--");
		}
		sbListHtml.append("</td>\n");
		if(!"b".equals(type)) {
			sbListHtml.append("<td>"+listMap.getString("ratio",i)+"<!-- input type='hidden' id='ratio' name='ratio' value='"+listMap.getString("ratio",i)+"'/ --></td>\n");
		}
		sbListHtml.append("</tr>\n");
		iNum ++;

	}
}else{
	// 리스트가 없을때
}

	// 테스트 관련 내용
	DataMap testMap = (DataMap)requestMap.get("cTest");
	testMap.setNullToInitialize(true);
	StringBuffer sbListHtml2 = new StringBuffer();
	if(testMap.keySize("idExam") > 0 ){
		for(int i=0; testMap.keySize("idExam") > i; i++){
			sbListHtml2.append("<input type='hidden' id='score' name='score' value='"+testMap.getString("score",i)+"'/>");
			sbListHtml2.append("<input type='hidden' id='examState' name='examState' value='"+testMap.getString("examState",i)+"'/>");
		}
	}
%>

<script language="JavaScript" type="text/JavaScript">
<!--
window.onload = function() {
	var ratio = $F("ratio");
	if(ratio != "" || ratio != null) {
		ratio = ratio.replace("%","");
	}
	if($F("examState") == 1 || $F("examState") == 2) {
		return;
	}
	if(ratio >= 100) {
		if($F("score") < 18) {
			if(confirm("사이버 과정을 95% 이상 수강하신분은 21일까지 과정평가와 과정설문을 완료하셔야 수료처리가 됩니다. \n\n과정평가페이지로 이동 하시겠습니까?")) {
				document.location.href = "/mypage/myclass.do?mode=testView";
			}
		}
	}
}
function replaceChoice(grcode,grseq,subj){
	PopWin(300,420,'/mypage/myclass.do?mode=selectSubLecture&grcode='+grcode+'&grseq='+grseq+'&subj='+subj);
}

function go_move(grcode,grseq,subj,classno,lec_type, review){
	if(lec_type == "P"){ //선택과목선택창이 띄워짐
		PopWin(300,420,'/mypage/myclass.do?mode=selectSubLecture&grcode='+grcode+'&grseq='+grseq+'&subj='+subj+'&review='+review);
		return;
	}else{  //강의실로 이동
		document.pform.type.value='<%=type%>';
		document.pform.grcode.value=grcode;
		document.pform.grseq.value=grseq;
		document.pform.subj.value=subj;
		document.pform.classno.value=classno;
		document.pform.review.value=review;
		document.pform.mode.value="courseDetail";
		document.pform.action="/mypage/myclass.do";
	    document.pform.submit();
	  }
	}

	function PopWin(he, wi, go_url){
	  var optstr;
	  optstr="height="+he+",width="+wi+",location=0,menubar=0,resizable=1,scrollbars=1,status=0,titlebar=0,toolbar=0,screeny=0,left=0,top=0";
	  window.open(go_url, "POPWIN", optstr);
	}

	function goReport(grcode, grseq, subj, classno,lec_type){
		if(lec_type == "P"){ //선택과목선택창이 띄워짐
			PopWin(300,420,'/mypage/myclass.do?mode=selectSubLecture&grcode='+grcode+'&grseq='+grseq+'&subj='+subj);
			return;
		}else{
			document.pform.grcode.value=grcode;
			document.pform.grseq.value=grseq;
			document.pform.subj.value=subj;
			document.pform.classno.value=classno;
			document.pform.mode.value="selectReportList";
			document.pform.action="/mypage/myclass.do";
		    document.pform.submit();
		}
	}

	function gonoti_move(grcode,grseq,subj,classno,lec_type){

	  if(lec_type == "P"){ //선택과목선택창이 띄워짐
		  PopWin(300,420,'/mypage/myclass.do?mode=selectSubLecture&grcode='+grcode+'&grseq='+grseq+'&subj='+subj);
	    return;
	  }

	  document.moveForm.grcode.value=grcode;
	  document.moveForm.grseq.value=grseq;
	  document.moveForm.subj.value=subj;
	  document.moveForm.classno.value=classno;

	  if(subj == ""){ //과목코드가 없으면 과목리스트로 이동
	    document.moveForm.goto.value="mysubject.php";
	    document.moveForm.target="imove";
	    document.moveForm.action="sess_setting.php";
	    document.moveForm.submit();
	    return;
	  }else{  //해당강의리스트로 이동
		document.pform.mode.value="selectGrnoticeList";
	    document.pform.action="/mypage/myclass.do";
	    document.moveForm.submit();
	    return;
	  }
	}

	// 리스트
	function fnList(){
		document.pform.mode.value="selectCourseList";
		pform.action = "/mypage/myclass.do";
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
                <li><a href="/mypage/myclass.do?mode=selectCourseList&type=<%=type%>"><img src="/homepage_new/images/M1/tab01_on.gif" alt="과정리스트"/></a></li>
                <li><a href="/mypage/myclass.do?mode=selectGrnoticeList&type=<%=type%>"><img src="/homepage_new/images/M1/tab02.gif" alt="과정공지"/></a></li>
                <li><a href="/mypage/myclass.do?mode=pollList&type=<%=type%>"><img src="/homepage_new/images/M1/tab03.gif" alt="과정설문"/></a></li>
                <li><a href="/mypage/myclass.do?mode=testView&type=<%=type%>"><img src="/homepage_new/images/M1/tab04.gif" alt="과정평가"/></a></li>
                <li><a href="/mypage/myclass.do?mode=discussList&type=<%=type%>"><img src="/homepage_new/images/M1/tab05.gif" alt="과정토론방"/></a></li>
                <li><a href="/mypage/myclass.do?mode=suggestionList&type=<%=type%>"><img src="/homepage_new/images/M1/tab06.gif" alt="과정질문방"/></a></li>
                <li><a href="/mypage/myclass.do?mode=courseInfoDetail&type=<%=type%>"><img src="/homepage_new/images/M1/tab07.gif" alt="교과안내문"/></a></li>
                <li><a href="/mypage/myclass.do?mode=sameClassList&type=<%=type%>"><img src="/homepage_new/images/M1/tab08.gif" alt="동기모임"/></a></li>
              </ul>
              </div>
              <form id="pforam" name="pform" method="get">
<!-- 필수 -->
<%=sbListHtml2%>
<input type="hidden" id="coursenm" name="coursenm"  value="<%=requestMap.getString("coursenm") %>">
<input type="hidden" id="type" name="type">
<input type="hidden" id="grcode" name="grcode">
<input type="hidden" id="grseq" name="grseq">
<input type="hidden" id="subj" name="subj">
<input type="hidden" id="classno" name="classno">
<input type="hidden" id="goto" name="goto">
<input type="hidden" id="review" name="review">
<input type="hidden" id="mode" name="mode">
				<div id="content">
						<div class="h9"></div>
			
						<!-- data -->
						<table class="bList01">	
						<colgroup>
							<col width="35" />
							<col width="40" />
							<col width="*" />
							<col width="52" />
							<col width="115" />
							<col width="42" />
							<col width="50" />
							<col width="32" />
							<col width="44" />
							<col width="44" />
						</colgroup>
			
						<thead>
						<tr>
							<th class="bl0"><img src="/images/<%= skinDir %>/table/th_no.gif" alt="번호" /></th>
							<th><img src="/images/<%= skinDir %>/table/th_div01.gif" alt="구분" /></th>
							<th><img src="/images/<%= skinDir %>/table/th_sbj01.gif" alt="과목" /></th>
							<th><img src="/images/<%= skinDir %>/table/th_tName01.gif" alt="강사명" /></th>
							<th><img src="/images/<%= skinDir %>/table/th_date04.gif" alt="기간" /></th>
							<th><img src="/images/<%= skinDir %>/table/th_tMtrls04.gif" alt="부교재" /></th>
							<th class=""><img src="/images/<%= skinDir %>/table/th_lnProgm04.gif" alt="학습프로그램" /></th>
							<th class=""><img src="/images/<%= skinDir %>/table/th_notice.gif" alt="공지" /></th>
							<th class=""><img src="/images/<%= skinDir %>/table/th_assigt.gif" alt="과제물" /></th>
							<% if(!"b".equals(type)) { %>
							<th><img src="/images/<%= skinDir %>/table/th_progress.gif" alt="진도율" /></th>
							<% } %>
						</tr>
						</thead>
			
						<tbody>
						<%=sbListHtml %>
						</tbody>
						</table>
						<!-- //data --> 
						<div class="BtmLine"></div>
						
						<div class="TbBttTxt01">* 과목을 선택하면 해당과목 메뉴로 이동합니다.</div>
						<div class="spaceNone"></div>
			
						<div class="space"></div>
					</div>

</form>
              
            <!-- //contnet -->
          </div>
        </div>
    
    
    </div>

    <jsp:include page="/homepage_new/inc/footer.jsp" flush="true" ></jsp:include>