<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%

	// 필수, request 데이타
	DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
	requestMap.setNullToInitialize(true);
	
	// 리스트
	DataMap listMap = (DataMap)request.getAttribute("MY_QUESTION_LIST");
	listMap.setNullToInitialize(true);

	// 페이징 필수
	FrontPageNavigation pageNavi = (FrontPageNavigation)listMap.get("PAGE_INFO");
	int pageNum = pageNavi.getTotalCnt() - (requestMap.getInt("currPage") - 1) * requestMap.getInt("rowSize");


	StringBuffer listHtml = new StringBuffer();
	
	String pageStr = "";
	
	if(listMap.keySize("subj") > 0){	
		
		for(int i=0; i < listMap.keySize("subj"); i++){
			int num = i + 1;
			
			listHtml.append("<tr> ");
			listHtml.append("<td class=\"bl0\">"+num+"</td> ");
			listHtml.append("<td>"+listMap.getString("subj", i)+"</td> ");
			listHtml.append("<td class=\"sbj\"><a href=\"/mypage/myclass.do?mode=myquestionview&no="+listMap.getString("no", i)+"&grcode="+listMap.getString("grcode", i)+"&grseq="+listMap.getString("grseq", i)+"&subj="+listMap.getString("puresubj", i)+"&dates="+listMap.getString("dates", i)+"&classno="+listMap.getString("classno", i)+"\">"+listMap.getString("title", i)+"</a></td> ");
			listHtml.append("<td class=\"\">"+listMap.getString("regdate", i)+"</td> ");
			if(listMap.getString("replyCnt", i).equals("0")) {
				listHtml.append("<td><img src=\"/images/skin1/icon/icon_answr.gif\" alt=\"답변\" /></td> ");
			}else {
				listHtml.append("<td><img src=\"/images/skin1/icon/icon_answr_on.gif\" alt=\"답변\" /></td> ");
			}	
			listHtml.append("</tr> ");
		}
		pageStr = pageNavi.FrontPageStr();		
	}else{
		// 리스트가 없을때
		listHtml.append("<tr><td colspan=\"5\">등록된 글이 없습니다.</td></tr> ");
		
	}
%>

<%@ include file="/commonInc/include/commonImport.jsp" %>
<%@ include file="/commonInc/include/comInclude.jsp" %>
<jsp:include page="/commonInc/include/comHtmlTop.jsp" flush="false">
	<jsp:param name="cssName" value="layout" />
</jsp:include>


<script language="JavaScript" type="text/JavaScript">
<!--

// 페이지 이동
function go_page(page) {
	$("currPage").value = page;
	fnList();
}

// 리스트
function fnList(){
	$("mode").value = "myquestion";
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
         <div class="sub_visual1">마이페이지</div>
            <div class="local">
              <h2>개인정보</h2>
                <div class="navi"><img src="/homepage_new/images/common/icon_home.gif" alt="home"> &gt; 마이페이지 &gt; 개인정보 &gt; <span>나의질문</span></div>
            </div>
            <div class="contnets">
			<form id="pform" name="pform" method="post">

<!-- 필수 -->
<input type="hidden" name="mode"		value="<%= requestMap.getString("mode") %>">

<!-- 페이징용 -->
<input type="hidden" name="currPage"	value="<%= requestMap.getString("currPage")%>">
            <!-- content s ===================== -->
		<div id="content">
			<!-- title --> 
			<h3>나의 질문</h3>
			<!-- //title -->
			<div class="h9"></div>

			<!-- data -->
			<table class="bList01">	
			<colgroup>
				<col width="50" />
				<col width="67" />
				<col width="*" />
				<col width="99" />
				<col width="67" />
			</colgroup>

			<thead>
			<tr>
				<th class="bl0"><img src="/images/skin1/table/th_no.gif" alt="번호" /></th>
				<th><img src="/images/skin1/table/th_div.gif" alt="분류" /></th>
				<th><img src="/images/skin1/table/th_sbj.gif" alt="제목" /></th>
				<th><img src="/images/skin1/table/th_date01.gif" alt="날짜" /></th>
				<th><img src="/images/skin1/table/th_answr.gif" alt="답변" /></th>
			</tr>
			</thead>

			<tbody>
			<%=listHtml %>
			</tbody>
			</table>
			<!-- //data --> 
			<div class="BtmLine"></div>                

			<!--[s] 페이징 -->
			<div class="paging">
			<%= pageStr %>		
			</div>
			<!--//[s] 페이징 -->
			<div class="h80"></div>
		</div>
		<!-- //content e ===================== -->
		</form>
          </div>
        </div>
    
    
    </div>

    <jsp:include page="/homepage_new/inc/footer.jsp" flush="true" ></jsp:include>