<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
// prgnm 	: 교육훈련체계
// date		: 2008-08-07
// auth 	: kang
%>

<%@ include file="/commonInc/include/commonImport.jsp" %>

<%

	//request 데이터
	DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
	requestMap.setNullToInitialize(true);

	
	DataMap sampleMap = (DataMap)request.getAttribute("SAMPLE_DATA");
	if(sampleMap == null) sampleMap = new DataMap();
	sampleMap.setNullToInitialize(true);
	
	
	StringBuffer strHtml = new StringBuffer();
	
	if(sampleMap.keySize("userno") > 0){		
		for(int i=0; i < sampleMap.keySize("userno"); i++){
			
			strHtml.append( sampleMap.getString("userno", i) + "," );
			strHtml.append( sampleMap.getString("homeTel", i) + "," );
			strHtml.append( sampleMap.getString("name", i) + "<br>" );
									
		}
	}
	

%>


<%@ include file="/commonInc/include/comInclude.jsp" %>
<jsp:include page="/commonInc/include/comHtmlTop.jsp" flush="false">
	<jsp:param name="cssName" value="layout" />
</jsp:include>



<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<form id="pform" name="pform" method="post">

<div id="wrapper">
	<div id="dvwhset">
		<div id="dvwh">
		
			<!--[s] header -->
			<jsp:include page="/commonInc/include/comHeader.jsp" flush="false">
				<jsp:param name="topMenu" value="4" />
			</jsp:include>
			<!--[e] header -->						
			
			<div id="middle">			
				<!--[s] left -->
				<jsp:include page="/commonInc/include/comLeftMenu.jsp" flush="false">
					<jsp:param name="leftMenu" value="3" />
					<jsp:param name="leftIndex" value="1" />
				</jsp:include>
				<!--[e] left -->
				
	
	<!-- contentOut s ===================== -->
	<div id="subContentArear">
		<!-- content image -->
		<div id="contImg"><img src="/images/skin1/sub/img_cont02.gif" alt="" /></div>
		<!-- //content image -->

		<!-- title/location -->
		<div id="top_title">
			<h1 id="title"><img src="/images/skin1/title/tit_request01.gif" alt="수강신청" /></h1>
			<div id="location">
			<ul> 
				<li class="home"><a href="">HOME</a></li>
				<li class="on">수강신청</li>
			</ul>
			</div>
		</div>
		<!-- title/location -->
		<div class="spaceTop"></div>

		<!-- content s ===================== -->
		<div id="content">
			<!-- title --> 
			<h4 class="h4Ltxt">수강신청 가능한 과정</h4>
			<!-- //title -->
			<div class="btnR"><img src="/images/skin1/button/btn_reqList01.gif" alt="수강신청취소/상세확인" /></div>
			<div class="h9"></div>

			<!-- data -->
			<table class="bList01">	
			<colgroup>
				<col width="50" />
				<col width="*" />
				<col width="56" />
				<col width="80" />
				<col width="80" />
				<col width="48" />
				<col width="48" />
				<col width="80" />
			</colgroup>

			<thead>
			<tr>
				<th class="bl0"><img src="/images/skin1/table/th_no.gif" alt="번호" /></th>				
				<th><img src="/images/skin1/table/th_process.gif" alt="과정명" /></th>
				<th><img src="/images/skin1/table/th_num.gif" alt="기수" /></th>
				<th><img src="/images/skin1/table/th_date08.gif" alt="수강신청기간" /></th>
				<th><img src="/images/skin1/table/th_date09.gif" alt="학습기간" /></th>
				<th><img src="/images/skin1/table/th_req.gif" alt="신청" /></th>
				<th><img src="/images/skin1/table/th_state.gif" alt="상태" /></th>
				<th><img src="/images/skin1/table/th_date10.gif" alt="신청일" /></th>
			</tr>
			</thead>

			<tbody>
			<tr>
				<td class="bl0">1</td>
				<td class="sbj"><a href="">PC 분해 및 조립 과정</a></td>
				<td>200801기</td>				
				<td>06.02~07.04</td>
				<td>07.21~07.25</td>
				<td><img src="/images/skin1/button/btn_cancel03.gif" alt="취소" /></td>
				<td><strong class="txt_org">검토중</span></td>
				<td>2008-06-25</td>
			</tr>     
			<tr>
				<td class="bl0">2</td>
				<td class="sbj"><a href="">PC 분해 및 조립 과정</a></td>
				<td>200801기</td>				
				<td>06.02~07.04</td>
				<td>07.21~07.25</td>
				<td><img src="/images/skin1/button/btn_request03.gif" alt="신청" /></td>
				<td><strong class="txt_org">검토중</span></td>
				<td>2008-06-25</td>
			</tr>
			<tr>
				<td class="bl0">3</td>
				<td class="sbj"><a href="">PC 분해 및 조립 과정</a></td>
				<td>200801기</td>				
				<td>06.02~07.04</td>
				<td>07.21~07.25</td>
				<td><img src="/images/skin1/button/btn_request03.gif" alt="신청" /></td>
				<td><strong class="txt_org">검토중</span></td>
				<td>2008-06-25</td>
			</tr>
			<tr>
				<td class="bl0">4</td>
				<td class="sbj"><a href="">PC 분해 및 조립 과정</a></td>
				<td>200801기</td>				
				<td>06.02~07.04</td>
				<td>07.21~07.25</td>
				<td><img src="/images/skin1/button/btn_request03.gif" alt="신청" /></td>
				<td><strong class="txt_org">검토중</span></td>
				<td>2008-06-25</td>
			</tr>
			<tr>
				<td class="bl0">5</td>
				<td class="sbj"><a href="">PC 분해 및 조립 과정</a></td>
				<td>200801기</td>				
				<td>06.02~07.04</td>
				<td>07.21~07.25</td>
				<td><img src="/images/skin1/button/btn_request03.gif" alt="신청" /></td>
				<td><strong>미신청</span></td>
				<td>2008-06-25</td>
			</tr>
			<tr>
				<td class="bl0">6</td>
				<td class="sbj"><a href="">PC 분해 및 조립 과정</a></td>
				<td>200801기</td>				
				<td>06.02~07.04</td>
				<td>07.21~07.25</td>
				<td><img src="/images/skin1/button/btn_request03.gif" alt="신청" /></td>
				<td><strong class="txt_org">검토중</span></td>
				<td>2008-06-25</td>
			</tr>
			<tr>
				<td class="bl0">7</td>
				<td class="sbj"><a href="">PC 분해 및 조립 과정</a></td>
				<td>200801기</td>				
				<td>06.02~07.04</td>
				<td>07.21~07.25</td>
				<td><img src="/images/skin1/button/btn_request03.gif" alt="신청" /></td>
				<td><strong class="txt_org">검토중</span></td>
				<td>2008-06-25</td>
			</tr>
			<tr>
				<td class="bl0">8</td>
				<td class="sbj"><a href="">PC 분해 및 조립 과정</a></td>
				<td>200801기</td>				
				<td>06.02~07.04</td>
				<td>07.21~07.25</td>
				<td><img src="/images/skin1/button/btn_request03.gif" alt="신청" /></td>
				<td><strong class="txt_org">검토중</span></td>
				<td>2008-06-25</td>
			</tr>
			<tr>
				<td class="bl0">9</td>
				<td class="sbj"><a href="">PC 분해 및 조립 과정</a></td>
				<td>200801기</td>				
				<td>06.02~07.04</td>
				<td>07.21~07.25</td>
				<td><img src="/images/skin1/button/btn_request03.gif" alt="신청" /></td>
				<td><strong class="txt_org">검토중</span></td>
				<td>2008-06-25</td>
			</tr>
			<tr>
				<td class="bl0">10</td>
				<td class="sbj"><a href="">PC 분해 및 조립 과정</a></td>
				<td>200801기</td>				
				<td>06.02~07.04</td>
				<td>07.21~07.25</td>
				<td><img src="/images/skin1/button/btn_request03.gif" alt="신청" /></td>
				<td><strong class="txt_org">검토중</span></td>
				<td>2008-06-25</td>
			</tr>
			</tbody>
			</table>
			<!-- //data --> 
			<div class="BtmLine"></div>                

			<!--[s] 페이징 -->
			<div class="paging">
				<a href="#"><img src='/images/skin1/icon/pg_back02.gif' alt='맨앞으로'></a>
				<a href="#"><img src='/images/skin1/icon/pg_back01.gif' alt='앞으로'></a>
				<ol start="1">
					<li title="현재 1페이지" class="fir">1</li>
					<li><a href="#" title="2페이지">2</a></li>
					<li><a href="#" title="3페이지">3</a></li>
					<li><a href="#" title="4페이지">4</a></li>
					<li><a href="#" title="5페이지">5</a></li>
				</ol>
				<a href="#"><img src='/images/skin1/icon/pg_next01.gif' alt='뒤로'></a>
				<a href="#"><img src='/images/skin1/icon/pg_next02.gif' alt='맨뒤로'></a>		
			</div>
			<!--//[s] 페이징 -->
			<div class="h80"></div>
		</div>
		<!-- //content e ===================== -->

	</div>
	<!-- //contentOut e ===================== -->	
	
	
	
	
	
				
				
				
				<div class="spaceBtt"></div>
			</div>			
		</div>
		
		<div id="divQuickMenu" style="position:absolute; top:10; left:89%; width:90px; height:264px; z-index:1">
			<!--[s] quick -->
			<jsp:include page="/commonInc/include/comQuick.jsp" flush="false"/>
			<!--[e] quick -->
		</div>
	</div>
	<!--[s] footer -->
	<jsp:include page="/commonInc/include/comFoot.jsp" flush="false"/>
	<!--[e] footer -->
</div>

</form>
</body>								