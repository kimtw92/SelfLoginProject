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
if(listMap.keySize("setNo") > 0){		
	for(int i=0; i < listMap.keySize("setNo"); i++){
		
		sbListHtml.append("<tr>\n")
			.append("<td class=\"bl0\"><a href=\"javascript:onView('"+listMap.getString("titleNo",i)+"','"+listMap.getString("setNo",i)+"');\">"+listMap.getString("setNo",i)+"</a></td>\n")	
			.append("<td>"+listMap.getString("startDate",i)+"</td>\n")
			.append("<td>"+listMap.getString("endDate",i)+"</td>\n");
		if (Util.getIntValue(listMap.getString("total",i),0) > 0){
			sbListHtml.append("<td>응시</td>\n");
		} else {
			sbListHtml.append("<td><a href=\"javascript:pre_view('"+listMap.getString("titleNo",i)+"', '"+listMap.getString("setNo",i)+"');\"><img src=\"/images/skin1/button/btn_bu1.gif\" alt=\"미응시\" align=\"absmiddle\" /></a></td>\n");
		}
		sbListHtml.append("<td><a href=\"javascript:detail_view('"+listMap.getString("titleNo",i)+"', '"+listMap.getString("setNo",i)+"');\"><img src=\"/images/skin1/button/btn_view02.gif\" alt=\"변경\" align=\"absmiddle\" /></a></td>\n")
			.append("</tr>\n");
	}
}else{
	// 리스트가 없을때
	sbListHtml.append("<tr>\n")
		.append("<td colspan=\"5\"> 진행중인 설문이 없습니다. </td>\n");
}
%>

<script language="JavaScript" type="text/JavaScript">
<!--
function go_move(grcode,grseq,subj,classno,lec_type){
	if(lec_type == "P"){ //선택과목선택창이 띄워짐
		PopWin(200,450,'/mypage/myclass.do?mode=selectSubLecture&grcode='+grcode+'&grseq='+grseq+'&subj='+subj);
		return;
	}else{  //강의실로 이동
		document.pform.grcode.value=grcode;
		document.pform.grseq.value=grseq;
		document.pform.subj.value=subj;
		document.pform.classno.value=classno;
		document.pform.action="/mypage/myclass.do?mode=courseDetail";
	    document.pform.submit();
	  }
	}

	function PopWin(he, wi, go_url){
	  var optstr;
	  optstr="height="+he+",width="+wi+",location=0,menubar=0,resizable=1,scrollbars=1,status=0,titlebar=0,toolbar=0,screeny=0,left=0,top=0";
	  window.open(go_url, "POPWIN", optstr);
	}

	function onView(form1, form2){
		PopWin(200,300,'/mypage/myclass.do?mode=pollView&title_no='+form1+'&set_no='+form2);
	}
	
	function goReport(grcode, grseq, subj, classno,lec_type){
		if(lec_type == "P"){ //선택과목선택창이 띄워짐
			PopWin(200,450,'/mypage/myclass.do?mode=selectSubLecture&grcode='+grcode+'&grseq='+grseq+'&subj='+subj);
			return;
		}else{
			document.pform.grcode.value=grcode;
			document.pform.grseq.value=grseq;
			document.pform.subj.value=subj;
			document.pform.classno.value=classno;
			document.pform.action="/mypage/myclass.do?mode=selectReportList";
		    document.pform.submit();
		}
	}

	function gonoti_move(grcode,grseq,subj,classno,lec_type){

	  if(lec_type == "P"){ //선택과목선택창이 띄워짐
		  PopWin(200,450,'/mypage/myclass.do?mode=selectSubLecture&grcode='+grcode+'&grseq='+grseq+'&subj='+subj);
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
	    document.pform.action="/mypage/myclass.do?mode=selectGrnoticeList";
	    document.moveForm.submit();
	    return;
	  }
	}

	// 리스트
	function fnList(){
		pform.action = "/mypage/myclass.do?mode=selectCourseList";
		pform.submit();
	}

	function pre_view(title_no,set_no){
		window.open('/mypage/myclass.do?mode=pollView&title_no='+title_no+'&set_no='+set_no,'poll_view','width=420,height=500,menubar=0,scrollbars=1');
	}
	
	function detail_view(title_no,set_no){
		window.open('/mypage/myclass.do?mode=pollDetail&title_no='+title_no+'&set_no='+set_no,'poll_detail','width=550,height=500,menubar=0,scrollbars=1');
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
                <li><a href="/mypage/myclass.do?mode=selectCourseList&type=<%=type%>"><img src="/homepage_new/images/M1/tab01.gif" alt="과정리스트"/></a></li>
                <li><a href="/mypage/myclass.do?mode=selectGrnoticeList&type=<%=type%>"><img src="/homepage_new/images/M1/tab02.gif" alt="과정공지"/></a></li>
                <li><a href="/mypage/myclass.do?mode=pollList&type=<%=type%>"><img src="/homepage_new/images/M1/tab03_on.gif" alt="과정설문"/></a></li>
                <li><a href="/mypage/myclass.do?mode=testView&type=<%=type%>"><img src="/homepage_new/images/M1/tab04.gif" alt="과정평가"/></a></li>
                <li><a href="/mypage/myclass.do?mode=discussList&type=<%=type%>"><img src="/homepage_new/images/M1/tab05.gif" alt="과정토론방"/></a></li>
                <li><a href="/mypage/myclass.do?mode=suggestionList&type=<%=type%>"><img src="/homepage_new/images/M1/tab06.gif" alt="과정질문방"/></a></li>
                <li><a href="/mypage/myclass.do?mode=courseInfoDetail&type=<%=type%>"><img src="/homepage_new/images/M1/tab07.gif" alt="교과안내문"/></a></li>
                <li><a href="/mypage/myclass.do?mode=sameClassList&type=<%=type%>"><img src="/homepage_new/images/M1/tab08.gif" alt="동기모임"/></a></li>
              </ul>
              </div>
              
              
            <!-- //contnet -->

			<form id="pforam" name="pform" method="post">
<!-- 필수 -->
<input type="hidden" name="coursenm"  value="<%=requestMap.getString("coursenm") %>">
<input type="hidden" name="grcode">
<input type="hidden" name="grseq">
<input type="hidden" name="subj">
<input type="hidden" name="classno">
<input type="hidden" name="goto">

					<div id="content">
						<div class="h9"></div>
			
						<!-- data -->
						<table class="bList01">	
						<colgroup>
							<col width="58" />
							<col width="*" />
							<col width="180" />
							<col width="90" />
							<col width="90" />
						</colgroup>
			
						<thead>
						<tr>
							<th class="bl0"><img src="/images/<%=skinDir %>/table/th_time02.gif" alt="차시" /></th>
							<th><img src="/images/<%=skinDir %>/table/th_date05.gif" alt="시작일" /></th>
							<th><img src="/images/<%=skinDir %>/table/th_date06.gif" alt="종료일" /></th>
							<th><img src="/images/<%=skinDir %>/table/th_time03.gif" alt="응시" /></th>
							<th><img src="/images/<%=skinDir %>/table/th_poll02.gif" alt="설문분석" /></th>
						</tr>
						</thead>
			
						<tbody>
						<%=sbListHtml.toString() %>
						
						</tbody>
						</table>
						<!-- //data --> 
						<div class="BtmLine"></div>
						
			
						<div class="space"></div>
					</div>

</form>
          </div>
        </div>
    
    
    </div>

    <jsp:include page="/homepage_new/inc/footer.jsp" flush="true" ></jsp:include>