<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/commonInc/include/commonImport.jsp" %>
<%@ include file="/commonInc/include/comInclude.jsp" %>
<jsp:include page="/commonInc/include/comHtmlTop.jsp" flush="false">
	<jsp:param name="cssName" value="layout" />
</jsp:include>

<%
	String year=(String)request.getAttribute("year");
	String month=(String)request.getAttribute("month");
	String day=(String)request.getAttribute("day");
	String gubun=(String)request.getAttribute("gubun");	// 시간 구분 [am, pm]
	String place=(String)request.getAttribute("place");		// 시설장소 구분	 [0, 1, 2]
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>인천사이버교육센터에 오신것을 환영합니다</title>
<link rel="stylesheet" type="text/css" href="/commonInc/css/skin1/popup.css" />
<!-- [Page Customize] -->
<script>
	function go_insertForm( year,month,day,gubun,place){		
		opener.location.href="/homepage/introduce.do?mode=reservationform&year="+year+"&month="+month+"&day="+day+"&gubun="+gubun+"&place="+place;
		self.close();
	}
</script>
<!-- [/Page Customize] -->
</head>

<!-- popup size 497x497 -->
<body>
<div class="top">
	<h1 class="h1">시설 사용 허가 신청 동의서</h1>

</div>
<div class="contents">
	<!-- data -->
	<div class="webZine01">
         <div class="InCons">

        <h3>시설임대 신청시 유의사항 </h3>
        

1. 사용자가 주관하는 행사 및 경기 등으로 인하여 발생한 제반사고에 대하여는<br /> 
   &nbsp;&nbsp;&nbsp;&nbsp;사용자가 책임을 집니다. <br /><div class="SpB"></div>

2. 시설사용 시 사용자의 귀책 사유로 발생한 시설물의 파손 및 훼손에 대하여는 사용자가<br />  
   &nbsp;&nbsp;원상복구 또는 배상하여야 합니다. <br /><div class="SpB"></div>
3. 다음의 경우에는 사용승인을 취소 또는 정지합니다. <br />
<div class="h5"></div> 
  &nbsp;가. 시설 내에서 취사, 음주, 가무 및 특정 종교행사, 상행위 등으로 공공질서를 해치고<br />
    &nbsp;&nbsp;&nbsp;&nbsp;주변 주거지역에 해를 끼친다고 인정될 때 (주위에 공동주택이 있음) <br />
    나. 사용승인 이외의 목적으로 사용하거나 승인 조건을 위반 할 때 <br />
    다. 우천 등 기상변화에 따라 시설 유지관리상 필요하다고 인정될 때 <br />
    라. 기타 공공행사 등으로 인하여 원장이 필요하다고 인정될 때 <br /><div class="SpB"></div>

4. 시설사용 후에는 청소 등 원상으로 정리정돈 하여야 하며, 발생한 쓰레기는 반드시<br />
   수거하여 가져가야 합니다.<br /> <div class="SpB"></div>
5. 천막 등 부가시설이나 부착물에 대하여는 사전 승인을 받아야 합니다. <br /><div class="SpB"></div>
6. 기타사항은 『인천광역시인재개발원시설사용료징수조례』를 참고하시기 바라며, <br />
&nbsp;&nbsp;&nbsp;&nbsp;납부고지(고지서)금액을 기한내 납부하여 주시기 바랍니다. <br />
<div class="h5"></div> 
   ※ 승인조건을 지키지 않아 물의를 야기시킨 경우 추후 시설사용을 제한합니다. <br />

        </div>        
	</div>

	<!-- //data -->

	<!-- button -->
	<div class="btnC">
		<a href="#" onclick="javascript:go_insertForm('<%=year %>','<%=month %>','<%=day %>','<%=gubun %>','<%=place %>');"><img src="../../../images/skin1/button/btn_ok.gif" alt="동의함" /></a>
		<a href="#" onclick="javascript:self.close();"><img src="../../../images/skin1/button/btn_close01.gif" alt="닫기" /></a>
	</div>	
	<!-- //button -->
</div>
</body>
</html>
