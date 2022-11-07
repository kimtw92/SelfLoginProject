<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="utf-8"%>
<%@ include file="/commonInc/include/commonImport.jsp" %>
<%@ include file="/commonInc/include/comInclude.jsp" %>
<%
//과정운영계획 리스트

DataMap grseqPlanListMap = (DataMap)request.getAttribute("GRSEQ_PLAN_LIST");
grseqPlanListMap.setNullToInitialize(true);	

StringBuffer grseqPlanListHtml = new StringBuffer();	
StringBuffer grseqPlanListHtml2 = new StringBuffer();

if(grseqPlanListMap.keySize("rownum") > 0){
	
	int mnum = 10;
	boolean ischeck = false;
	for(int i=0; i < grseqPlanListMap.keySize("rownum"); i++){
		String strName = grseqPlanListMap.getString("grcodeniknm",i);


		if (strName.length() > 10){
			strName = grseqPlanListMap.getString("grcodeniknm",i).substring(0,9)+"..";
		}
		if(i < 5) {
			grseqPlanListHtml.append("<img src=\"/images/skin4/icon/icon_down01.gif\"> <a href=javascript:popWin(\"/commonInc/fileDownload.do?mode=popup&groupfileNo="+grseqPlanListMap.getString("groupfileNo",i)+"\",\"aaa\",\"350\",\"280\",\"yes\",\"yes\") alt=\""+grseqPlanListMap.getString("grcodeniknm",i)+"\" class=\"ht11\">"+strName+"</a><br />");
		} else {
			grseqPlanListHtml2.append("<img src=\"/images/skin4/icon/icon_down01.gif\"> <a href=javascript:popWin(\"/commonInc/fileDownload.do?mode=popup&groupfileNo="+grseqPlanListMap.getString("groupfileNo",i)+"\",\"aaa\",\"350\",\"280\",\"yes\",\"yes\") alt=\""+grseqPlanListMap.getString("grcodeniknm",i)+"\" class=\"ht11\">"+strName+"</a><br />");
			ischeck = true;			
		}
	}

	mnum = (mnum - grseqPlanListMap.keySize("rownum"));		
	
	if(mnum >0 && ischeck) {
		for(int j = 0; j < mnum; j++) {
			grseqPlanListHtml2.append("<br/>");
		}
	}
}
%>
<jsp:include page="/commonInc/include/comHtmlTop.jsp" flush="false">
	<jsp:param name="cssName" value="layout" />
</jsp:include>
<jsp:include page="/homepage_new/inc/header.jsp" flush="true" ></jsp:include>
    <div id="subContainer">
    
    <div class="subNavi_area">
    
      <jsp:include page="/homepage_new/inc/left5.jsp" flush="true" ></jsp:include>
    
      </div>
    
        <div id="contnets_area">
          <div class="sub_visual5">교육지원</div>
            <div class="local">
              <h2>과정시간표</h2>
                <div class="navi"><img src="/homepage_new/images/common/icon_home.gif" alt="home"> &gt; 교육지원 &gt; <span>과정시간표</span></div>
            </div>
            <div class="contnets">
            <!-- contnet -->
            <div id="content">
				<img src="/images/skin4/sub/notice13_2.gif" alt="인천광역시 인재개발원 과정시간표입니다. 각 교육과정별로 원하시는 내용을 아래에서 다운 받아보실 수 있습니다."/>
				<div class="h15"></div>
				<div class="rGrySet01">
					<div class="rGry03">
					<table cellspacing="0" cellpadding="0" width="320px;" border="0" style="width:320px;margin-left:330px;margin-top:40px;">
						<tr>
							<td><%=grseqPlanListHtml%></td>
							<td><%=grseqPlanListHtml2%></td>
						</tr>
					</table>
					</div>
				</div>	
			</div>
			<jsp:include page="/homepage_new/inc/admin_info.jsp" flush="true" ><jsp:param name="menucode" value="M100028" /></jsp:include>
			<div class="h80"></div>		  
            <!-- //contnet -->
          </div>
        </div>
    
    
    </div>

    <jsp:include page="/homepage_new/inc/footer.jsp" flush="true" ></jsp:include>