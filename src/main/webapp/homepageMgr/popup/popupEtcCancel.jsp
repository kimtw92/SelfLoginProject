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
					<div class="point_box mgb_30">
						<p class="box_img"><span><img src="https://hrd.incheon.go.kr/homepage_new/images/common/box_point.gif" alt=""></span></p>
						<div class="list">
							<p class="mgb_30">죄송합니다!</p>
			 
							<p class="mgb_30">본 조사는 인천시민을 대상으로 인천시민이 요구하는 공무원 교육에 대한 의견을 조사하고자 합니다.<br/>
							귀하께서는 조사대상에 해당되지 아니하니 양해하여 주시기 바랍니다.</p>
						</div>
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
