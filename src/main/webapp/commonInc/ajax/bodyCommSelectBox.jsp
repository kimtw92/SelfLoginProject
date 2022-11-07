<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
// prgnm : 컨텐츠의 상단의 과정/기수/과목 등의 select Box
// date : 2008-05-30
// auth : Lym
%>

<%@ include file="/commonInc/include/commonImport.jsp" %>

<%

	//필수 코딩 내용 //////////////////////////////////////////////////////////////////////

	//request 데이터
	DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
	requestMap.setNullToInitialize(true);
		
	//로그인된 사용자 정보
	LoginInfo memberInfo = (LoginInfo)request.getAttribute("LOGIN_INFO");
	////////////////////////////////////////////////////////////////////////////////////

	
	
	DataMap listMap = (DataMap)request.getAttribute("LIST_MAP");
	if(listMap == null)
		listMap = new DataMap();
	listMap.setNullToInitialize(true);
	
	String pmode		= requestMap.getString("pmode");		// 구분
	String reloading	= requestMap.getString("reloading");	// 리로딩 되는 부분이 어딘지.
	String onloadYn		= requestMap.getString("onloadYn");		// onload여부
	String year			= requestMap.getString("year");			// 년도
	String grCode		= requestMap.getString("grCode");		// 과정
	String grSeq		= requestMap.getString("grSeq");		// 기수
	String subj			= requestMap.getString("subj");			// 과목
	
	String findCode = requestMap.getString("findCode");
	
	//System.out.println("==== pmode=" + pmode);
	//System.out.println("==== findCode=" + findCode);
	
	StringBuilder sbHtml = new StringBuilder(); //결과 출력변수
	
	if(pmode.equals("grCode")){
		//sbHtml.append(" 과정명 : ");

		if(pmode.equals(reloading)) //
			sbHtml.append("<select name=\"commGrcode\" onChange=\"setCommSession('grCode', this.value);go_reload();\" style=\"width:250px;font-size:12px\">");
		else
			sbHtml.append("<select name=\"commGrcode\" onChange=\"getCommGrSeq('"+reloading+"');\" style=\"width:250px;font-size:12px\">");
			
	}

	if(pmode.equals("grSeq")){
		//sbHtml.append(" 기수명 : ");
		if(pmode.equals(reloading)) //
			sbHtml.append("<select name=\"commGrseq\" onChange=\"setCommSession('grSeq', this.value);go_reload();\" style=\"width:100px;font-size:12px\">");
		else
			sbHtml.append("<select name=\"commGrseq\" onChange=\"getCommSubj('"+reloading+"');getCommExam();\" style=\"width:100px;font-size:12px\">");
	}

	if(pmode.equals("subj")){
		//sbHtml.append(" 과목명 : ");
		if(pmode.equals(reloading))
			sbHtml.append("<select name=\"commSubj\" onChange=\"setCommSession('subj', this.value);go_reload();\" style=\"width:250px;font-size:12px\">");
		else
			sbHtml.append("<select name=\"commSubj\" onChange=\"setCommSession('subj', this.value);getCommClass();\" style=\"width:250px;font-size:12px\">");
	}

	// ------- 사이버 과정 검색
	//사이버 기수
	if(pmode.equals("cyberGrSeq")){

		if(pmode.equals(reloading))
			sbHtml.append("<select name=\"commGrseq\" onChange=\"go_reload();\" style=\"width:100px;font-size:12px\">");
		else
			sbHtml.append("<select name=\"commGrseq\" onChange=\"getCyberCommGrCode('"+reloading+"');\" style=\"width:100px;font-size:12px\">");

	}
	//사이버 과정
	if(pmode.equals("cyberGrCode")){

		if(pmode.equals(reloading))
			sbHtml.append("<select name=\"commGrcode\" onChange=\"go_reload();\" style=\"width:250px;font-size:12px\">");
		else
			sbHtml.append("<select name=\"commGrcode\" onChange=\"getCyberCommSubj('"+reloading+"');\" style=\"width:250px;font-size:12px\">");

	}
	//사이버 과목
	if(pmode.equals("cyberGrSubj")){

		if(pmode.equals(reloading))
			sbHtml.append("<select name=\"commSubj\" onChange=\"go_reload();\" style=\"width:250px;font-size:12px\">");
		else
			sbHtml.append("<select name=\"commSubj\" style=\"width:250px;font-size:12px\">");

	}

	sbHtml.append("<option value=''>**선택하세요**</option>");	
	for(int i=0; i < listMap.keySize("code"); i++){
		
		//System.out.println("\n ##code" + listMap.getString("code", i));
		//System.out.println("\n ##findCode" + findCode);
		
		String selected = "";
		
		if(listMap.getString("code",i).equals(findCode)) selected = "selected";
		else selected = "";
		
		sbHtml.append("<option value='" + listMap.getString("code",i) + "' " + selected + ">" + listMap.getString("codenm",i) + "</option>");

	}

	sbHtml.append("</select>");
	sbHtml.append("&nbsp;&nbsp;");


	out.print(sbHtml.toString());

	//리로딩 되는 지 확인후 리로딩 시킨다.
	boolean reload = false;
	if( !onloadYn.equals("Y") ) {

		// 들어오는 pmode 값은 option을 생성시키는 값이고 
		// reloading 으로 들어오는 값은 reloading시킬 값이므로 한단계씩 밀려서 검사 해야 한다.

		if(pmode.equals("grCode"))
			if(reloading.equals("grSeq")) 
				reload = true;

		else if(pmode.equals("grSeq"))
			if(reloading.equals("grSubj")) 
				reload = true;
	}

	if(reload){
%>
		<script language="JavaScript">
		<!--
		go_reload();
		//-->
		</script>
<%
	} //end if
%>