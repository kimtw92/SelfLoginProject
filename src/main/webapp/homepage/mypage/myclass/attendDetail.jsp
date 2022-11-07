<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commonInc/include/commonImport.jsp" %>
<%@ include file="/commonInc/include/comInclude.jsp" %>
<jsp:include page="/commonInc/include/comHtmlTop.jsp" flush="false">
	<jsp:param name="cssName" value="layout" />
</jsp:include>
<script language="javascript" src="/commonInc/js/commonJs.js"></script>
<%


// 필수, request 데이타
DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
requestMap.setNullToInitialize(true);


// 리스트
DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
listMap.setNullToInitialize(true);


StringBuffer sbListHtml = new StringBuffer();

int iNum = 0;
if(listMap.keySize("grcode") > 0){		
	for(int i=0; i < listMap.keySize("grcode"); i++){
		
		sbListHtml.append("<tr>\n");
		sbListHtml.append("	<td class=\"bl0\">"+(i+1)+"</td>\n");
		sbListHtml.append("	<td class=\"sbj\">");
		if (listMap.getString("status",i).equals("대기중") && listMap.getString("cancel",i).equals("취소불가")){
			sbListHtml.append("<a href=\"javascript:go_cancel('"+listMap.getString("grcode",i)+"','"+listMap.getString("grseq",i)+"','"+listMap.getString("grcodeniknm",i)+"','N');\">");
		} else if(listMap.getString("status",i).equals("대기중") && listMap.getString("cancel",i).equals("취소가능")){
			if(listMap.getString("fvalue",i).equals("Y")){
				sbListHtml.append("<a href=\"javascript:go_cancel('"+listMap.getString("grcode",i)+"','"+listMap.getString("grseq",i)+"','"+listMap.getString("grcodeniknm",i)+"','Y');\">");
			} else {
				sbListHtml.append("<a href=\"javascript:go_cancel('"+listMap.getString("grcode",i)+"','"+listMap.getString("grseq",i)+"','"+listMap.getString("grcodeniknm",i)+"','D');\">");
			}
		} else {
			sbListHtml.append("<a href=\"javascript:go_cancel('"+listMap.getString("grcode",i)+"','"+listMap.getString("grseq",i)+"','"+listMap.getString("grcodeniknm",i)+"','N');\">");
		}
		sbListHtml.append(listMap.getString("grcodeniknm",i)+"-"+listMap.getString("grseq",i)+"("+listMap.getString("status",i)+")</a></td>\n");
		sbListHtml.append("	<td>"+listMap.getString("appdate",i)+"</td>\n");
		sbListHtml.append("	<td>"+listMap.getString("status",i)+"</td>\n");
		sbListHtml.append("</tr>\n");
		iNum ++;
		
	}
}else{
	sbListHtml.append("<tr>");
	sbListHtml.append("<td colspan=\"4\">수강신청한 과정이 없습니다!");
	sbListHtml.append(" </td>");
	sbListHtml.append("</tr>");
	
}
%>

<script language="JavaScript" type="text/JavaScript">
<!--

// 리스트
function fnList(){
	pform.action = "/mypage/myclass.do?mode=attendDetail";
	pform.submit();
}
function goList(){
	pform.action = "/mypage/myclass.do?mode=attendList";
	pform.submit();
}


//과정 취소
function go_cancel(grcode,grseq,grcodename,part){
	if(part == "Y"){
		if(grcode=="" || grseq==""){
			alert('필요정보가 전달되지 않았습니다. 관리자에게 문의하세요.');
			return;
		}
		if(confirm("다음과정의 수강 취소를 하시겠습니까?\n"+grcodename+" "+grseq+"기수") == true){

			var url = "/mypage/myclass.do";

			pars = "mode=cancelAttend&grcode=" + grcode + "&grseq="+grseq+"&userno=<%=requestMap.getString("userno")%>";
			// alert(pars);
			var divID = "part";
				
			var myAjax = new Ajax.Request(
					
				url, 
					{
						method: "post", 
						parameters: pars,
						onComplete : showResponse
					}
			);
			
			return;
			
		}else{

		}

	}else if(part == "C"){
		alert('수강신청 기간이 지났으므로 수강취소 불가합니다');
		return;
	}else{
		alert('현재 취소 불가능합니다');
		return;
	}
}

function showResponse(oRequest){
	alert(oRequest.responseText);
	fnList();
}
//-->
</script>
<jsp:include page="/homepage_new/inc/header.jsp" flush="true" ></jsp:include>
    
    <div id="subContainer">
    
    <div class="subNavi_area">
    
	  <jsp:include page="/homepage_new/inc/left1.jsp" flush="true" ></jsp:include>
      
    
      </div>
    
        <div id="contnets_area">
          <div class="sub_visual1">마이페이지</div>
            <div class="local">
              <h2>교육신청 및 취소</h2>
                <div class="navi"><img src="/homepage_new/images/common/icon_home.gif" alt="home"> &gt; 마이페이지 &gt; 교육신청 및 취소 &gt; <span>교육신청이력</span></div>
            </div>
            <div class="contnets">
            <!-- contnet -->
			
            <ol class="TabSub">
            <li><a href="javascript:fnGoMenu('1','attendList')">교육신청</a></li>
            <li class="TabOn last"><a href="javascript:fnGoMenu('1','attendDetail')">교육신청이력</a></li>
          </ol>
              
			 <!-- content s ===================== -->
			 
					<div id="content">
					<form id="pform" name="pform" method="post">
					<!-- 필수 -->
					<input type="hidden"  name="qu" >
					<!-- 페이징용 -->
					<input type="hidden" name="currPage"	value="<%= requestMap.getString("currPage")%>">
						
						<div class="h15"></div>
			
						<!-- title --> 
						<h3>수강신청중인 과정 취소 및 상세확인</h3>
						<!-- //title -->
						<div class="h9"></div>
			
						<!-- data -->
						<table class="bList01">	
						<colgroup>
							<col width="50" />
							<col width="*" />
							<col width="120" />
							<col width="80" />
						</colgroup>
			
						<thead>
						<tr>
							<th class="bl0"><img src="/images/<%= skinDir %>/table/th_no.gif" alt="번호" /></th>				
							<th><img src="/images/<%= skinDir %>/table/th_process.gif" alt="과정명" /></th>
							<th><img src="/images/<%= skinDir %>/table/th_date10.gif" alt="신청일" /></th>
							<th><img src="/images/<%= skinDir %>/table/th_agree.gif" alt="승인여부" /></th>
						</tr>
						</thead>
			
						<tbody>
						
						<%=sbListHtml.toString() %>
						</tbody>
						</table>
						<!-- //data --> 
						<div class="BtmLine"></div>                
			
						<!-- button -->
						<div class="btnRbtt">			
							<!-- <a href="javascript:goList();"><img src="/images/<%= skinDir %>/button/btn_request01.gif" alt="신청" /></a> -->
						</div>
						<!-- //button -->
			
						
						<div class="h80"></div>
					</form>
				</div>
			<!-- //content e ===================== -->
			
            <!-- //contnet -->
			 </div>
        </div>
        
              
    
    
    </div>

    <jsp:include page="/homepage_new/inc/footer.jsp" flush="true" ></jsp:include>