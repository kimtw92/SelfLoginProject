<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commonInc/include/commonImport.jsp" %>
<%@ include file="/commonInc/include/comInclude.jsp" %>
<jsp:include page="/commonInc/include/comHtmlTop.jsp" flush="false">
	<jsp:param name="cssName" value="layout" />
</jsp:include>

<%

	request.setCharacterEncoding("utf-8");

	LoginInfo loginInfo = (LoginInfo)request.getAttribute("LOGIN_INFO");
	
	// 필수, request 데이타
	DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
	requestMap.setNullToInitialize(true);

	// 리스트
	DataMap listMap = (DataMap)request.getAttribute("OPEN_COURSE_VIEW");
	listMap.setNullToInitialize(true);
	

	StringBuffer sbListHtml = new StringBuffer();

	int number = 1;
	if(listMap.keySize("datesNm") > 0){		

		for(int i=0; i < listMap.keySize("datesNm"); i++){
			sbListHtml.append("<tr> ");
			sbListHtml.append("<td class=\"bl0\">"+(number++)+"</td> ");
			sbListHtml.append("<td class=\"sbj\">"+listMap.getString("datesNm", i)+"</td> ");
			sbListHtml.append("<td><a href=\"javascript:go_view('"+listMap.getString("subj", i)+"','"+listMap.getString("dates", i)+"','"+listMap.getString("orgId", i)+"','"+listMap.getString("ctId", i)+"','"+listMap.getString("ctSeq", i)+"','"+listMap.getString("orgDir", i)+"','"+listMap.getString("lcmsWidth", i)+"','"+listMap.getString("lcmsHeight", i)+"','"+listMap.getString("menuyn", i)+"','"+listMap.getString("menunum", i)+"','"+listMap.getString("limit", i)+"','"+listMap.getString("limitTime", i)+"','"+listMap.getString("orgDirName", i)+"')\"><img src=\"/images/"+skinDir+"/icon/icon_ear.gif\" alt=\"강의듣기\" /><a></td> ");
			sbListHtml.append("</tr>");
		}
				
	}else{
		sbListHtml.append("<tr> ");
		sbListHtml.append("<td colspan=3>등록된 컨텐츠가 없습니다.</td>");
		sbListHtml.append("</tr>");
	}
%>
<script language='javascript'>
function PopWin(he, wi, go_url){
	var optstr;
	optstr="height="+he+",width="+wi+",location=0,menubar=0,resizable=1,scrollbars=1,status=0,titlebar=0,toolbar=0,screeny=0,left=0,top=0";
	window.open(go_url, "study", optstr);
}

function SetCookie(name, value, expiredays) {
	var expire_date = new Date();
	expire_date.setDate(expire_date.getDate() + expiredays );
	document.cookie = name + "=" + escape( value ) + "; expires=" + expire_date.toGMTString() + "; path=/";
}

function go_view(subj,dates,org_id,ct_id,ct_seq,org_dir,lcms_width,lcms_height,menuyn,menunum,limit,limit_time, org_dir_name){
/*
	var url="";
	url = "/user/scorm/lecture/index_open.php?imageFolder="+menunum+"&ctId="+ct_id+"&orgDir="+org_dir+"&orgId="+org_id+"&review=N&menuFlag="+menuyn+"&subj="+subj+"&sbweek="+dates+"&limit="+limit+"&limit_time="+limit_time+"&grCode={grcode}&grSeq={grseq}&review=Y";
	if(lcms_height=="")lcms_height="686";
	if(lcms_width=="")lcms_width="1020";
	PopWin(lcms_height,lcms_width,url);
*/


/*
	if(<%=loginInfo.isLogin()%> == false) {
		alert('로그인 후 사용가능합니다.');
		return;
	}
*/
	//쿠키설정 시작
		SetCookie("lms_func01","/mypage/myclass.do?mode=lcmsproecss",1); 
		SetCookie("lms_func02","/mypage/myclass.do?mode=lcmsnotice",1); 
		SetCookie("lms_func04","/baseCodeMgr/dic.do?mode=dicView",1); 
		SetCookie("lms_func05","/mypage/myclass.do?mode=lcmsqna",1); 
	//쿠키설정 끝
	
	var url = "/lcms/lecture/lecture.jsp?subj="+subj+"&ctId="+ct_id+"&orgDir="+org_dir+"&orgDirName="+org_dir_name+"&review=N&menuYn="+menuyn+"&skinId="+menunum+"&orgId="+org_id+"&grseq=200800&grcode=10C0000016&UserName=yang&UserId=<%=(String)session.getAttribute("sess_no")%>";
	//공개강의라서...아무 값이나 걍 설정...

	if(lcms_height=="")lcms_height="686";
	if(lcms_width=="")lcms_width="1020";
	PopWin(lcms_height,lcms_width,url);

}
</script>
<jsp:include page="/homepage_new/inc/header.jsp" flush="true" ></jsp:include>
    
    <div id="subContainer">
    
    <div class="subNavi_area">
    <jsp:include page="/homepage_new/inc/left2.jsp" flush="true" ></jsp:include>
      <!-- suvNavi -->

      </div>
    
        <div id="contnets_area">
          <div class="sub_visual"><img src="/homepage_new/images/common/sub_visual2.jpg" alt="인재원 소개 인천광역시 인재개발원에 대한 소개 및 시설정보를 제공합니다."></div>
            <div class="local">
              <h2>공개강의</h2>
                <div class="navi"><img src="/homepage_new/images/common/icon_home.gif" alt="home"> &gt; 교육과정 &gt; <span>공개강의</span></div>
            </div>
            <div class="contnets">
            <!-- contnet -->
			<form id="pform" name="pform" method="post">

			<div id="content">
						<table class="dataW02">
							<tr>
								<th class="bl0"><img src='/images/<%=skinDir %>/table/th_lname.gif' alt="과목명"></th>
								<td class="" colspan="5">
										

									<%= (String)request.getAttribute("subjnm") %>
								</td>
							</tr>
							<tr>
								<th class="bl0"><img src='/images/<%=skinDir %>/table/th_tMtrls04.gif' alt="부교재"></th>
								<td class="" colspan="5">--</td>
							</tr>
							<tr>
								<th class="bl0"><img src='/images/<%=skinDir %>/table/th_lnProgm04.gif' alt="학습프로그램"></th>
								<td class="" colspan="5">--</td>
							</tr>
						</table>
					</div>
					<!-- //data -->
			
			    
			
					<div class="space"></div>
			
					<!-- content s ===================== -->
					<div id="content">
						<!-- data -->
						<table class="bList01">	
						<colgroup>
							<col width="50" />
							<col width="*" />
							<col width="90" />
						</colgroup>
			
						<thead>
						<tr>
							<th class="bl0"><img src="/images/<%=skinDir %>/table/th_no.gif" alt="번호" /></th>
							<th><img src="/images/<%=skinDir %>/table/th_cont03.gif" alt="학습내용" /></th>
							<th><img src="/images/<%=skinDir %>/table/th_sound.gif" alt="강의듣기" /></th>
						</tr>
						</thead>
			
						<tbody>
						<%=sbListHtml %>
						</tbody>
						</table>
						<!-- //data --> 
						<div class="BtmLine"></div>              
			
						<div class="h80"></div>
					</div>
					<!-- //content e ===================== -->

			</form>
            
            <!-- //contnet -->
          </div>
        </div>
    
    
    </div>

    <jsp:include page="/homepage_new/inc/footer.jsp" flush="true" ></jsp:include>