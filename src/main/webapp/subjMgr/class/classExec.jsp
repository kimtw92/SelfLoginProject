<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%
// prgnm : 반 갯수   저장시 처리 페이지
// date  : 2008-06-09
// auth  : kang
%>

<!-- [s] commonImport -->
<%@ include file="/commonInc/include/commonImport.jsp" %>
<!-- [e] commonImport -->

<%

	DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
	requestMap.setNullToInitialize(true);
	
	// 메뉴ID
	String menuId = requestMap.getString("menuId");
	
	// 처리 메세지
	String msg = (String)request.getAttribute("RESULT_MSG");
	
	// 처리 구분
	String resultType = (String)request.getAttribute("RESULT_TYPE");
	
	String modeType = requestMap.getString("modeType");
	
	String mode = requestMap.getString("mode");
	
	String param = "";
	
	if(mode.equals("saveStu")){
		param = "&commYear=" + requestMap.getString("commYear");
		param += "&commGrcode=" + requestMap.getString("commGrcode");
		param += "&commGrseq=" + requestMap.getString("commGrseq");
		param += "&grCode=" + requestMap.getString("grCode");
		param += "&grSeq=" + requestMap.getString("grSeq");
		param += "&subj=" + requestMap.getString("subj");
		param += "&s_refSubj=" + requestMap.getString("s_refSubj");
				
	}
	
%>

<script language="JavaScript" type="text/JavaScript">

	var param = "";

	switch("<%=resultType%>"){
	
		case "ok":
			// 반 갯수 지정
			alert("<%= msg %>");
			param = "?mode=classList";
			param += "&menuId=<%=menuId%>";
			opener.fnSearch();
			self.close();
			break;
			
		case "single_ok":
			// 단일 분반 저장
			alert("<%= msg %>");
			param = "?mode=classList";
			param += "&menuId=<%=menuId%>";
			location.href = "class.do" + param;
			break;
			
		case "dept1_ok":
			// 기관별 분반 Type1 업데이트
			alert("<%= msg %>");
			param = "?mode=classList";
			param += "&menuId=<%=menuId%>";			
			location.href = "class.do" + param;
			break;
			
		case "dept2_ok":
			// 기관별 분반 Type2 업데이트
			alert("<%= msg %>");
			param = "?mode=dept2";
			param += "&menuId=<%=menuId%>";			
			location.href = "class.do" + param;
			break;
			
		case "free_ok":
			// 자유분반 업데이트
			alert("<%= msg %>");
			param = "?mode=free";
			param += "&menuId=<%=menuId%>";			
			location.href = "class.do" + param;
			break;
			
		case "option_ok":
			// 조건별  업데이트
			alert("<%= msg %>");
			param = "?mode=option";
			param += "&menuId=<%=menuId%>";			
			location.href = "class.do" + param;
			break;
			
		case "other_ok":
			// 타 과목 동일반 구성하기
			alert("<%= msg %>");
			
			param = "?mode=classList";
			param += "&menuId=<%=menuId%>";
					
			switch("<%=modeType%>"){
				case "classList":					
					opener.fnSearch();
					break;
					
				default:
					window.opener.location.href="class.do" + param;
					break;
			}
									
			self.close();
			break;
			
		case "stuUpdate_ok":
			// 입교자 반편성 선택과목 과목수강정보에 업데이트
			alert("<%= msg %>");
			param = "?mode=stuFormList";
			param += "&menuId=<%=menuId%>";
			param += "<%=param%>";
			location.href = "class.do" + param;
			break;
			
		case "saveError":		
			alert("<%=msg%>");
			history.back();
			break;
			
		case "saveError_Pop":		
			alert("<%=msg%>");
			history.back();
			break;
	}
	

</script>