<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 수료증 출력 팝업
// date : 2008-08-26
// auth : LYM
%>

<!-- [s] commonImport -->
<%@ include file="/commonInc/include/commonImport.jsp" %>
<!-- [e] commonImport -->

<%
    //request 데이터
	DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
	requestMap.setNullToInitialize(true);       

    //수료자 리스트
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	listMap.setNullToInitialize(true); 

	//과정 기수 정보.
	DataMap resultDocMap = (DataMap)request.getAttribute("RESULTDOC_ROW_DATA");
	resultDocMap.setNullToInitialize(true);

	StringBuffer listStr = new StringBuffer(); //리스트 결과 변수.
	String tmpStr = "";
	String grtime = "";
	String grtimeNew = "";
	String grminute = "";
	String time = "";
	String enddate = "";
	String grcodenm = "";
	int date = 20170223;
	int edate ;
	
	String content = StringReplace.convertHtmlDecodeNamo( StringReplace.replaceStr(resultDocMap.getString("content"), "\\'", "'") );
	for(int i=0; i < listMap.keySize("userno"); i++){


		tmpStr = content.replaceAll("\\{수료번호\\}", listMap.getString("rno", i));
		tmpStr = tmpStr.replaceAll("\\{소속기관\\}", listMap.getString("deptnm", i));
		tmpStr = tmpStr.replaceAll("\\{상세기관\\}", listMap.getString("deptsub", i));
		tmpStr = tmpStr.replaceAll("\\{직급명\\}", listMap.getString("jiknm", i));
		tmpStr = tmpStr.replaceAll("\\{성명\\}", listMap.getString("name", i));
		
		tmpStr = tmpStr.replaceAll("\\{년도\\}", listMap.getString("gryear", i));
		tmpStr = tmpStr.replaceAll("\\{기수\\}", listMap.getString("txseq", i));
		tmpStr = tmpStr.replaceAll("\\{과정명\\}", listMap.getString("grcodenm", i));
		
		
		if("10G0000131".equals(listMap.getString("grcode", i))){
			String grseq = listMap.getString("grseq", i);
			int grseqCheck = Integer.parseInt(grseq);
			
			if(grseqCheck < 201401){
				tmpStr = tmpStr.replaceAll("\\{시간\\}", "(35시간)");
			}else{
				tmpStr = tmpStr.replaceAll("\\{시간\\}", "(21시간)");
			}
			
		}else{
			if(listMap.getString("grcodenm", i) != null && !listMap.getString("time", i).equals("")){
				
				grtime = listMap.getString("time", i);
				grtimeNew = listMap.getString("timeNew", i);
				grminute = listMap.getString("minute", i);
				enddate = listMap.getString("enddate", i);
				time = "";
				edate = Integer.parseInt(enddate);
				grcodenm = listMap.getString("grcodenm", i);
				
				if(grcodenm.indexOf("e-") != -1){
					if(edate < date){
						time = 	grtime + "시간";
						if(grtime.equals("0")){
							tmpStr = tmpStr.replaceAll("\\{시간\\}", "");
						}else{
							tmpStr = tmpStr.replaceAll("\\{시간\\}", "("+time+")");	
						}
					}else{
						if(grtimeNew.equals("0") && !grminute.equals("0")){
							time = grminute + "분";
						}else if(!grtimeNew.equals("0") && grminute.equals("0")){
							time = grtimeNew + "시간";
						}else if(!grtimeNew.equals("0") && !grminute.equals("0")){
							time = grtimeNew + "시간" + " " + grminute + "분";
						}else{
							time = "0";
						}
						if(time.equals("0")){
							tmpStr = tmpStr.replaceAll("\\{시간\\}", "");
						}else{
							tmpStr = tmpStr.replaceAll("\\{시간\\}", "("+time+")");	
						}
					}
				}else{
					time = 	grtime + "시간";
					if(grtime.equals("0")){
						tmpStr = tmpStr.replaceAll("\\{시간\\}", "");
					}else{
						tmpStr = tmpStr.replaceAll("\\{시간\\}", "("+time+")");	
					}
				}
			}
		}
		
		
		tmpStr = tmpStr.replaceAll("\\{교육시작일\\}", listMap.getString("syear", i) + "." + listMap.getString("smonth", i) + "." + listMap.getString("sday", i));
		tmpStr = tmpStr.replaceAll("\\{교육종료일\\}", listMap.getString("eyear", i) + "." + listMap.getString("emonth", i) + "." + listMap.getString("eday", i));
		
		//tmpStr = tmpStr.replaceAll("\\{현재일자\\}", DateUtil.getYear() + "년 " + DateUtil.getMonth() + "월 " + DateUtil.getDay() + "일");
		tmpStr = tmpStr.replaceAll("\\{교육시작일\\}", listMap.getString("syear", i) + "년 " + listMap.getString("emonth", i) + "월 " + listMap.getString("eday", i) + "일");
		tmpStr = tmpStr.replaceAll("\\{교육원장명\\}", requestMap.getString("masterName") /* + "<img src=\"/images/2017_seal.jpg\"  style='position:relative; top:35px;'/>" */);
		
		//tmpStr = "<table width=\"700px\" height=\"1050px\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"table-layout:fixed\"><tr><td>" + tmpStr + "</td></tr></table>";

		if( i > 0 ){
			tmpStr = "<p style=\"page-break-before: always\">" + tmpStr + "</p>";
		}
		listStr.append(tmpStr);
	}
	
	System.out.println(listStr);
%>


						
<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->

<script language="JavaScript" type="text/JavaScript">

function newSetPrintSettings() {
  try {
		factory.printing.header = ""; // Header에 들어갈 문장
		factory.printing.footer = ""; // Footer에 들어갈 문장
		factory.printing.portrait = true // true 면 가로인쇄, false 면 세로 인쇄
		factory.printing.leftMargin = 1.0 // 왼쪽 여백 사이즈
		factory.printing.topMargin = 10.0 // 위 여백 사이즈
		factory.printing.rightMargin = 1.0 // 오른쪽 여백 사이즈
		factory.printing.bottomMargin = 1.0 // 아래 여백 사이즈
		factory.printing.paperSource = "Manual feed"; // 종이 Feed 방식
	}catch (e)
	{
    	//alert('출력중 에러가 발생 하였습니다.');
    	return;
	}
}

function SetPrintSettings() {
	try {
		factory.printing.header = ""; // Header에 들어갈 문장
		factory.printing.footer = ""; // Footer에 들어갈 문장
		factory.printing.portrait = true // true 면 가로인쇄, false 면 세로 인쇄
		factory.printing.leftMargin = 0.0 // 왼쪽 여백 사이즈
		factory.printing.topMargin = 5.0 // 위 여백 사이즈
		factory.printing.rightMargin = 0.0 // 오른쪽 여백 사이즈
		factory.printing.bottomMargin = 5.0 // 아래 여백 사이즈
	//	factory.printing.SetMarginMeasure(2); // 테두리 여백 사이즈 단위를 인치로 설정합니다.
	//	factory.printing.printer = factory.printing.DefaultPrinter(); // 프린트 할 프린터 이름
	//	factory.printing.paperSize = "A4"; // 용지 사이즈
	//	factory.printing.paperSource = "Manual feed"; // 종이 Feed 방식
	//	factory.printing.collate = true; // 순서대로 출력하기
	//	factory.printing.copies = 1; // 인쇄할 매수
	//	factory.printing.SetPageRange(false, 1, 1); // True로 설정하고 1, 3이면 1페이지에서 3페이지까지 출력
	}catch (e)
	{
    	alert('출력중 에러가 발생 하였습니다.');
    	return;
	}
}
</script>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="window.focus();window.print();">

<script language="JavaScript">
<!--
//Scriptx Obj
com_printManager1();
com_printManager2();
com_printManager3();
//-->
</script>



<%= listStr.toString() %>


</body>
<SCRIPT LANGUAGE="JavaScript">
<!--
newSetPrintSettings();
//factory.printing.Preview();
factory.printing.Print(true, window);
//-->
</SCRIPT>