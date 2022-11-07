<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%  
// prgnm : 인천시민이 바라는 공무원 교육 팝업
// date : 2020-09-10
%>

<!-- [s] commonImport -->
<%-- <%@ include file="/commonInc/include/commonImport.jsp" %> --%>
<!-- [e] commonImport -->

<%
    //request 데이터
	/* DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
	requestMap.setNullToInitialize(true); */

	// 필수 코딩 내용 //////////////////////////////////////////////////////////////////////
	//로그인된 사용자 정보
	/* LoginInfo memberInfo = (LoginInfo)request.getAttribute("LOGIN_INFO"); */
	
    //navigation 데이터
	/* DataMap navigationMap = (DataMap)request.getAttribute("NAVIGATION_DATA");
	navigationMap.setNullToInitialize(true); */
	
	// 상단 navigation
	/* String navigationStr = LoginCheck.NavigationCreate(memberInfo, navigationMap); */
	////////////////////////////////////////////////////////////////////////////////////
	
	//리스트 데이터
	/* DataMap rowMap = (DataMap)request.getAttribute("VIEWROW_DATA");
	rowMap.setNullToInitialize(true); */
%>

	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
		<meta name="viewport" content="initial-scale=1, viewport-fit=cover">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<title>인천광역시 인재개발원</title>
		<link rel="stylesheet" href="/homepageMgr/popup/css/reset.css">
		<script type="text/javascript" language="javascript" src="/pluginfree/js/jquery-1.11.0.min.js"></script>
	
		<script language=javascript>
		function Pop_close() 
		{ 
		
				        self.close(); 
		}
		</script>
	</head>
<body>
	<article>
		<form>
		<div class="cont_in">
			<div class="cont_in_wrap">
				<h2>인천시민이 바라는<br/>공무원 교육 조사 안내</h2>
				<div class="con_box mgb_30">
					<p class="t_center t_bold t_size_30 mgb_20">♣ 조사에 협조해 주셔서 대단히 감사합니다 ♣</P>
					<p class="t_center">조사결과는 2020. 10월이후 인재개발원 홈페이지에서 공개할 예정입니다.</P>
				</div>
	
				
				<div class="survey">
					<a href="javascript:Pop_close()" class="cancel">닫기</a>
				</div>
			</div>
		</div>
		</form>
	</article>
</body>
</html>
