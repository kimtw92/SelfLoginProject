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
				<jsp:param name="topMenu" value="2" />
			</jsp:include>
			<!--[e] header -->						
			
			<div id="middle">			
				<!--[s] left -->
				<jsp:include page="/commonInc/include/comLeftMenu.jsp" flush="false">
					<jsp:param name="leftMenu" value="1" />
					<jsp:param name="leftIndex" value="3" />
					<jsp:param name="leftSubIndex" value="2" />
				</jsp:include>
				<!--[e] left -->
				

	<!-- contentOut s ===================== -->
	<div id="subContentArear">
		<!-- content image -->
		<div id="contImg"><img src="../../../images/skin1/sub/img_cont00.gif" alt="" /></div>
		<!-- //content image -->

		<!-- title/location -->
		<div id="top_title">
			<h1 id="title"><img src="../../../images/skin1/title/tit_learnSta.gif" alt="교육현황" /></h1>
			<div id="location">
			<ul> 
				<li class="home"><a href="">HOME</a></li>
				<li>교육안내</li>
				<li class="on">교육현황</li>
			</ul>
			</div>
		</div>
		<!-- title/location -->
		<div class="spaceTop"></div>

		<!-- content s ===================== -->
		<div id="content">
			<!-- title --> 
			<!-- h2 class="h2L"><img src="../../../images/skin1/title/tit_learnRst.gif" alt="교육실적" /></h2-->
			<!--div class="txtR">(<span class="txt_org">*</span> 필수입력사항)</div-->
			<!-- //title -->
			<div class="h9"></div>

			<!-- data -->
			<table class="dataH03">	
			<colgroup>
				<col width="*" />
				<col width="65" />
				<col width="47" />
				<col width="58" />
				<col width="65" />
				<col width="47" />
				<col width="58" />
				<col width="65" />
				<col width="47" />
				<col width="58" />
			</colgroup>

			<thead>
			<tr>
				<th class="bl0 txt_b" rowspan="2">구분</th>
				<!-- <th class="txt_b" colspan="3">2007</th> -->
				<th class="txt_b" colspan="3">2009</th>
				<th class="txt_b" colspan="3">2010</th>
				<th class="txt_b" colspan="3">2011(계획)</th>
			</tr>
			<tr>
				<th><img src="../../../images/skin1/table/th_prcsNo.gif" alt="과정수" /></th>
				<th class="bl0"><img src="../../../images/skin1/table/th_no01.gif" alt="횟수" /></th>
				<th class="bl0"><img src="../../../images/skin1/table/th_pNum.gif" alt="인원" /></th>
				<th><img src="../../../images/skin1/table/th_prcsNo.gif" alt="과정수" /></th>
				<th class="bl0"><img src="../../../images/skin1/table/th_no01.gif" alt="횟수" /></th>
				<th class="bl0"><img src="../../../images/skin1/table/th_pNum.gif" alt="인원" /></th>
				<th><img src="../../../images/skin1/table/th_prcsNo.gif" alt="과정수" /></th>
				<th class="bl0"><img src="../../../images/skin1/table/th_no01.gif" alt="횟수" /></th>
				<th class="bl0"><img src="../../../images/skin1/table/th_pNum.gif" alt="인원" /></th>
			</tr>
			</thead>

			<tbody>
			<tr>
				<td class="bl0 txt_b">계</td>
				<!-- 2007년 정보 주석처리함 
				<td>56</td>
				<td>123</td>
				<td>4,931</td> -->
				<td>82</td>
				<td>301</td>
				<td>14,160</td>
				<td>88</td>
				<td>362</td>
				<td>16,407</td>
				<td>100</td>
				<td>476</td>
				<td>16,560</td>
				
			</tr>
			<tr>
				<td class="bl0 txt_b">기본교육</td>
				<!-- 2007년 정보 주석처리함 
				<td>1</td>
				<td>6</td>
				<td>476</td> -->
				<td>1</td>
				<td>6</td>
				<td>480</td>
				<td>1</td>
				<td>5</td>
				<td>557</td>
				<td>1</td>
				<td>2</td>
				<td>100</td>

			</tr>
			<tr>
				<td class="bl0 txt_b">장기교육</td>
				<!-- 2007년 정보 주석처리함 
				<td>4</td>
				<td>4</td>
				<td>100</td> -->
				<td>4</td>
				<td>4</td>
				<td>100</td>
				<td>2</td>
				<td>2</td>
				<td>100</td>
				<td>3</td>
				<td>3</td>
				<td>100</td>

			</tr>
			<tr>
				<td class="bl0 txt_b">전문교육</td>
				<!-- 2007년 정보 주석처리함 
				<td>31</td>
				<td>75</td>
				<td>2,667</td> -->
				<td>67</td>
				<td>268</td>
				<td>10,060</td>
				<td>78</td>
				<td>334</td>
				<td>9,630</td>
				<td>92</td>
				<td>455</td>
				<td>10,510</td>

			</tr>
			<tr>
				<td class="bl0 txt_b">집합교육</td>
				<!-- 2007년 정보 주석처리함 
				<td>12</td>
				<td>24</td>
				<td>989</td> -->
				<td>43</td>
				<td>90</td>
				<td>3,460</td>
				<td>48</td>
				<td>94</td>
				<td>3,630</td>
				<td>52</td>
				<td>95</td>
				<td>3,670</td>

			</tr>
			<tr>
				<td class="bl0 txt_b">전문(사이버)</td>
				<!-- 2007년 정보 주석처리함 
				<td>12</td>
				<td>24</td>
				<td>989</td> -->
				<td>24</td>
				<td>178</td>
				<td>6,600</td>
				<td>30</td>
				<td>240</td>
				<td>6,000</td>
				<td>40</td>
				<td>360</td>
				<td>6,840</td>

			</tr>
			<tr>
				<td class="bl0 txt_b">기타교육</td>
				<!-- 2007년 정보 주석처리함 
				<td>8</td>
				<td>14</td>
				<td>699</td> -->
				<td>10</td>
				<td>23</td>
				<td>3,520</td>
				<td>7</td>
				<td>21</td>
				<td>6,100</td>
				<td>4</td>
				<td>16</td>
				<td>5,850</td>

			</tr>
			</tbody>
			</table>
			<!-- //data -->
			<div class="BtmLine"></div>

			<!--[s] 페이징 
			<div class="paging">
				<a href="#"><img src='../../../images/skin1/icon/pg_back02.gif' alt='맨앞으로'></a>
				<a href="#"><img src='../../../images/skin1/icon/pg_back01.gif' alt='앞으로'></a>
				<ol start="1">
					<li title="현재 1페이지" class="fir">1</li>
					<li><a href="#" title="2페이지">2</a></li>
					<li><a href="#" title="3페이지">3</a></li>
					<li><a href="#" title="4페이지">4</a></li>
					<li><a href="#" title="5페이지">5</a></li>
				</ol>
				<a href="#"><img src='../../../images/skin1/icon/pg_next01.gif' alt='뒤로'></a>
				<a href="#"><img src='../../../images/skin1/icon/pg_next02.gif' alt='맨뒤로'></a>		
			</div>
			//[s] 페이징 -->
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