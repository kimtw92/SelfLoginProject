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
				<jsp:param name="topMenu" value="7" />
			</jsp:include>
			<!--[e] header -->						
			
			<div id="middle">			
				<!--[s] left -->
				<jsp:include page="/commonInc/include/comLeftMenu.jsp" flush="false">
					<jsp:param name="leftMenu" value="6" />
					<jsp:param name="leftIndex" value="6" />
				</jsp:include>
				<!--[e] left -->



				<!-- contentOut s ===================== -->
				<div id="subContentArear">
					<!-- content image -->
					<div id="contImg"><img src="/images/<%= skinDir %>/sub/img_cont05.gif" alt="" /></div>
					<!-- //content image -->
			
					<!-- title/location -->
					<div id="top_title">
						<h1 id="title"><img src="/images/<%= skinDir %>/title/tit_law.gif" alt="입교안내" /></h1>
						<div id="location">
						<ul> 
							<li class="home"><a href="">HOME</a></li>
							<li>교육원소개</li>
							<li class="on">법률/조례/지침</li>
						</ul>
						</div>
					</div>
					<!-- title/location -->
					<div class="spaceTop"></div>



		<!-- content s ===================== -->
		<div id="content">
			<!-- data -->
			<table class="bList01">	
			<colgroup>
				<col width="50" />
				<col width="*" />
				<col width="62" />
			</colgroup>

			<thead>
			<tr>
				<th class="bl0"><img src="/images/<%= skinDir %>/table/th_no.gif" alt="번호" /></th>
				<th><img src="/images/<%= skinDir %>/table/th_sbj.gif" alt="제목" /></th>
				<th><img src="/images/<%= skinDir %>/table/th_addFile.gif" alt="첨부" /></th>
			</tr>
			</thead>

			<tbody>
			<tr>
				<td class="bl0">10</td>
				<td class="sbj"><a href="">인천광역시 공무원 교육훈련시간의 승진반영제도 운영지침</a></td>
				<td><img src="/images/<%= skinDir %>/icon/icon_zip.gif" alt="Zip File" /></td>
			</tr>
			<tr>
				<td class="bl0">9</td>
				<td class="sbj"><a href="">인천광역시 공무원 교육훈련시간의 승진반영제도 운영지침</a></td>
				<td><img src="/images/<%= skinDir %>/icon/icon_han.gif" alt="한글" /></td>
			</tr>
			<tr>
				<td class="bl0">8</td>
				<td class="sbj"><a href="">인천광역시 공무원 교육훈련시간의 승진반영제도 운영지침</a></td>
				<td><img src="/images/<%= skinDir %>/icon/icon_han.gif" alt="한글" /></td>
			</tr>
			<tr>
				<td class="bl0">7</td>
				<td class="sbj"><a href="">인천광역시 공무원 교육훈련시간의 승진반영제도 운영지침</a></td>
				<td><img src="/images/<%= skinDir %>/icon/icon_han.gif" alt="한글" /></td>
			</tr>
			<tr>
				<td class="bl0">6</td>
				<td class="sbj"><a href="">인천광역시 공무원 교육훈련시간의 승진반영제도 운영지침</a></td>
				<td><img src="/images/<%= skinDir %>/icon/icon_han.gif" alt="한글" /></td>
			</tr>
			<tr>
				<td class="bl0">5</td>
				<td class="sbj"><a href="">인천광역시 공무원 교육훈련시간의 승진반영제도 운영지침</a></td>
				<td><img src="/images/<%= skinDir %>/icon/icon_han.gif" alt="한글" /></td>
			</tr>
			<tr>
				<td class="bl0">4</td>
				<td class="sbj"><a href="">인천광역시 공무원 교육훈련시간의 승진반영제도 운영지침</a></td>
				<td><img src="/images/<%= skinDir %>/icon/icon_han.gif" alt="한글" /></td>
			</tr>
			<tr>
				<td class="bl0">3</td>
				<td class="sbj"><a href="">인천광역시 공무원 교육훈련시간의 승진반영제도 운영지침</a></td>
				<td><img src="/images/<%= skinDir %>/icon/icon_han.gif" alt="한글" /></td>
			</tr>
			<tr>
				<td class="bl0">2</td>
				<td class="sbj"><a href="">인천광역시 공무원 교육훈련시간의 승진반영제도 운영지침</a></td>
				<td><img src="/images/<%= skinDir %>/icon/icon_han.gif" alt="한글" /></td>
			</tr>
			<tr>
				<td class="bl0">1</td>
				<td class="sbj"><a href="">인천광역시 공무원 교육훈련시간의 승진반영제도 운영지침</a></td>
				<td><img src="/images/<%= skinDir %>/icon/icon_han.gif" alt="한글" /></td>
			</tr>
			</tbody>
			</table>
			<!-- //data --> 
			<div class="BtmLine"></div>              

			<!--[s] 페이징 -->
			<div class="paging">
				<a href="#"><img src='/images/<%= skinDir %>/icon/pg_back02.gif' alt='맨앞으로'></a>
				<a href="#"><img src='/images/<%= skinDir %>/icon/pg_back01.gif' alt='앞으로'></a>
				<ol start="1">
					<li title="현재 1페이지" class="fir">1</li>
					<li><a href="#" title="2페이지">2</a></li>
					<li><a href="#" title="3페이지">3</a></li>
					<li><a href="#" title="4페이지">4</a></li>
					<li><a href="#" title="5페이지">5</a></li>
				</ol>
				<a href="#"><img src='/images/<%= skinDir %>/icon/pg_next01.gif' alt='뒤로'></a>
				<a href="#"><img src='/images/<%= skinDir %>/icon/pg_next02.gif' alt='맨뒤로'></a>		
			</div>
			<!--//[s] 페이징 -->
			<div class="BtmLine01"></div>
			<div class="space"></div>
			
			<div class="bttSearch">
				<select>
				<option selected="selected">선택</option>
				<option>제목</option>
				<option>내용</option>
				<option>작성자</option>
				</select>
				<input type="text" value="" name="" class="input01 w160" style="" />
				<img src="/images/<%= skinDir %>/button/btn_search01.gif" class="sch01" alt="검색" />	
			</div>
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