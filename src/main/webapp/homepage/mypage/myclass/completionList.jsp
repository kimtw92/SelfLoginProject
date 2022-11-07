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

String pageStr = "";
int iNum = 0;
if(listMap.keySize("grseq") > 0){		
	for(int i=0; i < listMap.keySize("grseq"); i++){
		
		sbListHtml.append("<tr>\n");
		sbListHtml.append("<td class=\"bl0 sbj\">"+listMap.getString("grcodeniknm",i)+"</td>\n");
		sbListHtml.append("<td>"+listMap.getString("grseqnm",i)+"</td>	\n");
		sbListHtml.append("<td>"+listMap.getString("edudate",i)+"</td>\n");
		sbListHtml.append("<td>"+listMap.getString("paccept",i)+"</td>\n");
		sbListHtml.append("<td>"+listMap.getString("rgrayn",i)+"</td>\n");
		if (listMap.getString("rgrayn",i).equals("이수"))  {
			sbListHtml.append(" <td><a href=\"#\" onclick=\"go_htmlView('"+listMap.getString("grcode",i)+"', '"+listMap.getString("grseq",i)+"','"+listMap.getString("userno",i)+"');\"><img src=\"/images/icon_print.gif\"  /></a></td>");
		} else {
			sbListHtml.append(" <td>X</td>");
		}
				
		sbListHtml.append("</tr>\n");
		iNum ++;

	}
}else{
	sbListHtml.append("<tr>\n");
	sbListHtml.append("<td  colspan=\"6\">수료한 내용이 없습니다.</td>\n");
	sbListHtml.append("</tr>\n");
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
	pform.action = "/mypage/paper.do";
	pform.submit();
}

//상세보기
function onView(form){
	$("viewNo").value = form;
	pform.action = "/mypage/paper.do";
	pform.submit();
}

function setForm(form){
	$("mode").value = form;
	$("viewNo").value = "";
	pform.action = "/mypage/paper.do";
	pform.submit();
}

function setDel(){
	var lstNo = document.pform.papNo;
	var chkNum = 0;
<%	if (iNum > 1){%>
	for (var i=0,l=lstNo.length;i<l;i++){
		if (lstNo[i].checked == true){
			chkNum ++;
		}
	}
<%} else {%>
	if (lstNo.checked == true){
		chkNum ++;
	}
<%}%>
	if (chkNum > 0){
		$("mode").value = "delete";
		$("rMode").value = "<%=requestMap.getString("mode")%>";
		pform.action = "/mypage/paper.do";
		pform.submit();
	} else {
		alert("삭제할 항목을 선택해 주세요");
	}
}	
function setDelAll(){
	
	$("mode").value = "delAll";
	$("rMode").value = "<%=requestMap.getString("mode")%>";
	pform.action = "/mypage/paper.do";
	pform.submit();
}


//수료증 HTML
function go_htmlView(grcode,grseq,userno) {
	
	popWin("", "pop_ResultDocHtml", "1024", "1050", "1", "0");
	$("mode").value = "certi_html";
	$("qu").value = "";
	$("grcode").value = grcode;
	$("grseq").value = grseq;
	$("userno").value = userno;
	pform.target = "pop_ResultDocHtml";
	pform.action = "/mypage/certiResult.do";
	pform.submit();	
	pform.target = "";
	//window.open('./certiform_rno.php?a_grcode={a_grcode}&a_grseq={a_grseq}&a_master_name='+a_master_name+'&a_userno='+a_usernolist,'CERTI_FORM','toolbar=yes,scrollbars=yes,top=200,left=300,width=1024,height=800');
	//<body onload="window.focus();window.print();"> 
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
              <h2>수료내역</h2>
                <div class="navi"><img src="/homepage_new/images/common/icon_home.gif" alt="home"> &gt; 마이페이지 &gt; <span>수료내역</span></div>
            </div>
            <div class="contnets">
			<form id="pforam" name="pform" method="post">
<!-- 필수 -->
<input type="hidden" name="mode"		value="<%= requestMap.getString("mode") %>">
<input type="hidden" name="kind"		value="<%= requestMap.getString("kind") %>">
<input type="hidden" name="viewNo"		value="<%= requestMap.getString("viewNo") %>">
<input type="hidden" name="rMode"		value="<%= requestMap.getString("rMode") %>">

<input type="hidden" name="grseq"		value="">
<input type="hidden" name="grcode"		value="">
<input type="hidden" name="userno"		value="">
<input type="hidden" name="qu"		value="">


<!-- 페이징용 -->
<input type="hidden" name="currPage"	value="<%= requestMap.getString("currPage")%>">
            <!-- content s ===================== -->
					<div id="content">
						<!-- title --> 
						<h3>수료내역</h3>
						<!-- //title -->
						<div class="h9"></div>
			
						<!-- data -->
						<table class="bList01">	
						<colgroup>
							<col width="*" />
							<col width="94" />
							<col width="100" />
							<!--  col width="100" / -->
							<col width="80" />
							<col width="80" />
						</colgroup>
			
						<thead>
						<tr>		
							<%-- <th class="bl0"><img src="/images/<%= skinDir %>/table/th_process.gif" alt="과정명" /></th>
							<th><img src="/images/<%= skinDir %>/table/th_num.gif" alt="기수" /></th>
							<th><img src="/images/<%= skinDir %>/table/th_date11.gif" alt="교육기간" /></th>
							<th><img src="/images/<%= skinDir %>/table/th_Mk01.gif" alt="교육점수" /></th>
							<th><img src="/images/<%= skinDir %>/table/th_completn.gif" alt="이수" /></th>
							 --%>
							<th class="bl0">과정명</th>
							<th>기수</th>
							<th>교육기간</th>
							<th>교육점수</th>
							<th>이수</th>
							<th>수료증</th>
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
          </div>
        </div>
    
    
    </div>

    <jsp:include page="/homepage_new/inc/footer.jsp" flush="true" ></jsp:include>