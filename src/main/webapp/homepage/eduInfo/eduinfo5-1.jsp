<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
// prgnm 	: 입교안내
// date		: 2008-08-07
// auth 	: kang
%>

<%@ include file="/commonInc/include/commonImport.jsp" %>
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
				<jsp:param name="topMenu" value="5" />
			</jsp:include>
			<!--[e] header -->						
			
			<div id="middle">			
				<!--[s] left -->
				<jsp:include page="/commonInc/include/comLeftMenu.jsp" flush="false">
					<jsp:param name="leftMenu" value="4" />
					<jsp:param name="leftIndex" value="1" />
				</jsp:include>
				<!--[e] left -->


	<!-- contentOut s ===================== -->
	<div id="subContentArear">
		<!-- content image -->
		<div id="contImg"><img src="/images/skin1/sub/img_cont03.gif" alt="학습지원" /></div>
		<!-- //content image -->

		<!-- title/location -->
		<div id="top_title">
			<h1 id="title"><img src="/images/skin1/title/tit_0301.gif" alt="문의답변" /></h1>
			<div id="location">
			<ul> 
				<li class="home"><a href="">HOME</a></li>
				<li>학습지원</li>
				<li>열린광장</li>
				<li class="on">문의답변</li>
			</ul>
			</div>
		</div>
		<!-- title/location -->
		<div class="spaceTop"></div>

		<!-- content s ===================== -->
		<div id="content">
			<!-- title --> 
			<h2 class="h2L"><img src="/images/skin1/title/tit_qna01.gif" alt="문의/답변" /></h2>
			<!--div class="txtR">(<span class="txt_org">*</span> 필수입력사항)</div-->
			<!-- //title -->
			<div class="h9"></div>

			<div class="qnaTxtSet01">
				<ul class="qnaTxt">
					<li>
					이곳은 인천광역시교육원의 업무와 관련된 내용(교육 및 시설개방)중에<br />
					궁금하신 부분에 대한 질의/답변을 위한 게시판입니다.
					</li>
					<li>
					정확한 답변을 위하여 실명, 주소, 연락처를 반드시 기재하여 주시기 바랍니다.
					</li>
					<li>
					<strong>답변기한은 일반문의의 경우 7일이내, 관련법령 해석이 요구되는 경우에는<br />
					14일 이내입니다.</strong>
					</li>
					<li>
					본 게시판의 운영목적과 상이한 내용(타인비방, 욕설, 광고물, 본 게시판의 운영 
					</li>
					<li>
					취지와 전혀 무관한 내용등)은 사전동의 없이 삭제되며, 동일한 내용의 제보 또는 문의를<br /> 
					정당한 사유없이 3회이상 반복하여 제출할 경우 종결처리할수 있습니다. 
					</li>
				</ul>
			</div>

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
				<th class="bl0"><img src="/images/skin1/table/th_no.gif" alt="번호" /></th>				
				<th><img src="/images/skin1/table/th_sbj.gif" alt="제목" /></th>
				<th><img src="/images/skin1/table/th_date.gif" alt="작성일" /></th>
				<th><img src="/images/skin1/table/th_wName01.gif" alt="작성자" /></th>
				<th><img src="/images/skin1/table/th_hit.gif" alt="조회" /></th>
				<th><img src="/images/skin1/table/th_addfile.gif" alt="첨부" /></th>
			</tr>
			</thead>

			<tbody>
			<tr>
				<td class="bl0">1</td>
				<td class="sbj"><a href="">책 대출이 안될런지요?</a></td>		
				<td>2008-05-16</td>
				<td>오성국</td>				
				<td>39</td>
				<td><img src="/images/skin1/icon/icon_han.gif" alt="한글file 첨부" /></td>
			</tr>     
			<tr>
				<td class="bl0">2</td>
				<td class="sbj"><a href="">책 대출이 안될런지요?</a></td>		
				<td>2008-05-16</td>
				<td>오성국</td>				
				<td>39</td>
				<td><img src="/images/skin1/icon/icon_han.gif" alt="한글file 첨부" /></td>
			</tr>
			<tr>
				<td class="bl0">3</td>
				<td class="re" title="답변글"><a href="">책 대출이 안될런지요?</a></td>		
				<td>2008-05-16</td>
				<td>오성국</td>				
				<td>39</td>
				<td><img src="/images/skin1/icon/icon_han.gif" alt="한글file 첨부" /></td>
			</tr>
			<tr>
				<td class="bl0">4</td>
				<td class="sbj"><a href="">책 대출이 안될런지요?</a></td>		
				<td>2008-05-16</td>
				<td>오성국</td>				
				<td>39</td>
				<td><img src="/images/skin1/icon/icon_fileDwn.gif" alt="file 첨부" /></td>
			</tr>
			<tr>
				<td class="bl0">5</td>
				<td class="re" title="답변글"><a href="">책 대출이 안될런지요?</a></td>		
				<td>2008-05-16</td>
				<td>오성국</td>				
				<td>39</td>
				<td><img src="/images/skin1/icon/icon_jpg.gif" alt="JPG file 첨부" /></td>
			</tr>
			<tr>
				<td class="bl0">6</td>
				<td class="sbj"><a href="">책 대출이 안될런지요?</a></td>		
				<td>2008-05-16</td>
				<td>오성국</td>				
				<td>39</td>
				<td><img src="/images/skin1/icon/icon_jpg.gif" alt="JPG file 첨부" /></td>
			</tr>
			<tr>
				<td class="bl0">7</td>
				<td class="sbj"><a href="">책 대출이 안될런지요?</a></td>		
				<td>2008-05-16</td>
				<td>오성국</td>				
				<td>39</td>
				<td><img src="/images/skin1/icon/icon_han.gif" alt="한글file 첨부" /></td>
			</tr>
			<tr>
				<td class="bl0">8</td>
				<td class="sbj"><a href="">책 대출이 안될런지요?</a></td>		
				<td>2008-05-16</td>
				<td>오성국</td>				
				<td>39</td>
				<td><img src="/images/skin1/icon/icon_han.gif" alt="한글file 첨부" /></td>
			</tr>
			<tr>
				<td class="bl0">9</td>
				<td class="sbj"><a href="">책 대출이 안될런지요?</a></td>		
				<td>2008-05-16</td>
				<td>오성국</td>				
				<td>39</td>
				<td><img src="/images/skin1/icon/icon_han.gif" alt="한글file 첨부" /></td>
			</tr>
			<tr>
				<td class="bl0">10</td>
				<td class="sbj"><a href="">책 대출이 안될런지요?</a></td>		
				<td>2008-05-16</td>
				<td>오성국</td>				
				<td>39</td>
				<td><img src="/images/skin1/icon/icon_han.gif" alt="한글file 첨부" /></td>
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