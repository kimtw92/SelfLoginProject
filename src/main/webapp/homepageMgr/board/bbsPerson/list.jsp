<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%

// 필수, request 데이타
DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
requestMap.setNullToInitialize(true);

// 리스트
DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
listMap.setNullToInitialize(true);

// 페이징 필수
FrontPageNavigation pageNavi = (FrontPageNavigation)listMap.get("PAGE_INFO");
int pageNum = pageNavi.getTotalCnt() - (requestMap.getInt("currPage") - 1) * requestMap.getInt("rowSize");

StringBuffer sbListHtml = new StringBuffer();

String pageStr = "";

if(listMap.keySize("seq") > 0){
	for(int i=0; i < listMap.keySize("seq"); i++){
		
		String sample = "";
		if(listMap.getString("seq",i).equals("0")){
			sample = "<font color='red'>샘플</font>";
		}else{
			sample = listMap.getString("seq",i);
		}
		
		sbListHtml.append("<tr>");
		sbListHtml.append("	<td class=\"bl0\">"+sample+"</td>");
		int l = Util.getIntValue(listMap.getString("depth",i),0);
		
		sbListHtml.append("	<td class=\"sbj\">");
		
		
		String title = listMap.getString("title",i);
		title = title.substring(0, 3);
		sbListHtml.append(" <a href=\"javascript:onClick('"+listMap.getString("seq",i)+"', '" + listMap.getString("passwd", i) + "');\">"+title+"...</a></td>");
		String name = listMap.getString("username",i);
		String name1 = name.substring(0, 1);
		String name2 = name.substring(2);
		sbListHtml.append("	<td>"+name1 + "*" + name2 +"</td>");				
		sbListHtml.append("	<td>"+listMap.getString("regdate",i)+"</td>");
		sbListHtml.append("</tr>");

	}
	
	pageStr = pageNavi.FrontPageStr();				
}else{
	// 리스트가 없을때
	sbListHtml.append("<tr>");
	sbListHtml.append("	<td class=\"bl0\" colspan='6'>등록된 글이 없습니다.</td>");
	sbListHtml.append("</tr>");
}

%>

<%@ include file="/commonInc/include/commonImport.jsp" %>
<%@ include file="/commonInc/include/comInclude.jsp" %>

<jsp:include page="/commonInc/include/comHtmlTop.jsp" flush="false">
	<jsp:param name="cssName" value="layout" />
</jsp:include>

</head>


<body>

<style type="text/css">
#header{
margin-top: 10px;
}
#TopMenu{
margin-top: 5px;
}

#modal {
	position: relative;
	width: 100%;
	height: 100%;
	z-index: 1;
}
#modal #button {
	display: inline-block;
	width: 100px;
	margin-left: calc(100% - 100px - 10px);
}

#modal .content {
	width: 300px;
	margin: 100px auto;
	padding: 20px 10px;
	background: #fff;
	border: 2px solid #666;
}

#modal .modal_layer {
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background: rgba(0, 0, 0, 0.5);
	z-index: -1;
}
</style>

<script language="JavaScript" type="text/JavaScript">

// 페이지 이동
function go_page(page) {
	$("currPage").value = page;
	fnList();
}

// 리스트
function fnList(){
	pform.action = "/homepage/person.do?mode=list";
	pform.submit();
}

// 모달 창 열기
function onClick(seq, pass){
	var modal = document.getElementById("modal");
	modal.style.display = '';
	var seqid = document.getElementById("seq");
	seqid.value = seq;
	var passwd = document.getElementById("passwd");
	passwd.value = pass;
	console.log("============================ passwd : " + passwd.value);
	var pw = document.getElementById("pw");
	pw.value = "";
}

//상세보기
function onView(){
	// $("mode").value = "noticeView";
	
	var seq = document.getElementById("seq");
	var pform = document.getElementById("pform");
	var pw = document.getElementById("pw");
	var passwd = document.getElementById("passwd");
	var modal = document.getElementById("modal");
	console.log("============================ pw : " + pw.value);
	console.log("============================ passwd : " + passwd.value);
	if(pw.value == passwd.value){
		var qu = document.getElementById("qu");
		qu.value = "select";
		pform.action = "/homepage/person.do?mode=personView";
		pform.submit();
	}else{
		alert("비밀번호가 틀렸습니다.");
	}
	modal.style.display = 'none';
}

//글쓰기
function goWrite(){
	var qu = document.getElementById("qu");
	console.log("qu : " + qu.value);
	qu.value = "insert";
	console.log("qu : " + qu.value);
	pform.action = "/homepage/person.do?mode=personView";
	pform.submit();
}

</script>

    <div id="subContainer" style="width: auto;">
    
    <!-- <div class="subNavi_area"> -->
    
      <%-- <jsp:include page="/homepage_new/inc/left4.jsp" flush="true" ></jsp:include> --%>
    
      <!-- </div> -->
    
        <div id="contnets_area" style="MARGIN: 20px">
          <!-- <div class="sub_visual4">참여공간</div> -->
            <div class="local">
              <h2>감사반장에 바란다.</h2>
                <!-- <div class="navi"><img src="/homepage_new/images/common/icon_home.gif" alt="home"> &gt; 참여공간 &gt; <span>수강후기</span></div> -->
            </div>
            <div class="contnets">
            <!-- contnet -->

			<form id="pform" name="pform" method="post">
				<!-- 필수 -->
				<input type="hidden" id="qu" name="qu">
				<input type="hidden" id="boardId" name="boardId">
				<input type="hidden" id="mode" name="mode" value="<%= requestMap.getString("mode")%>">
				<!-- 페이징용 -->
				<input type="hidden" id="currPage" name="currPage"	value="<%= requestMap.getString("currPage")%>">
				
				<input type="hidden" id="seq" name="seq">
				<input type="hidden" id="passwd" name="passwd">
				<div id="content">
				<div class="h9"></div>
			
			</form>
			<div class="point_box">
<!-- 				<p class="box_img"><span><img src="/homepage_new/images/common/box_point.gif" alt=""></span></p> -->
				<div class="list">
					
				</div>
			</div>
			<div class="h9"></div>
						<!-- data -->
						<table class="bList01">	
						<colgroup>
							<col width="50" />
							<col width="*" />
							<col width="83" />
							<col width="77" />
							<col width="59" />
							<col width="71" />
						</colgroup>
			
						<thead>
						<tr>
							<th class="bl0">번호</th>				
							<th>제목</th>
							<th>작성자</th>
							<th>작성일</th>
						</tr>
						</thead>
							<%= sbListHtml.toString() %>
						<tbody>
						
						</tbody>
						</table>
						<!-- //data --> 
						<div class="BtmLine"></div>  
						
						<!-- button -->
						<div class="btnRbtt">			
							<a href="javascript:goWrite();"><img src="/images/<%= skinDir %>/button/btn_write01.gif" alt="글쓰기" /></a>
						</div>
			
						<!--[s] 페이징 -->
						<div class="paging">
							<%= pageStr %>		
						</div>
						<!--//[s] 페이징 -->

					</div>

					<%-- <jsp:include page="/homepage_new/inc/admin_info.jsp" flush="true" ><jsp:param name="menucode" value="M100014" /></jsp:include> --%>
					<div class="h80"></div>            
            <!-- //contnet -->
          </div>
        </div>
    
    
    </div>

</div>
<div id="modal" class="white_content" style="display:none;">
	<div class="content">
		<p>비밀번호를 입력하세요.</p>
		<input type="password" id="pw">
		<div id="button">
			<a href="javascript:onView();">입력</a>
		</div>
	</div>
	<div class="modal_layer"></div>
</div>
</body>
</html>
    <%-- <jsp:include page="/homepage_new/inc/footer.jsp" flush="true" ></jsp:include> --%>