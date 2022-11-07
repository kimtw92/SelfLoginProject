<%@page import="org.apache.taglibs.standard.tag.common.fmt.FormatDateSupport"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 역량강화 역량진단 결과
// date : 2020-04-08
// auth : LYM
%>

<!-- [s] commonImport -->
<%@ include file="/commonInc/include/commonImport.jsp" %>
<!-- [e] commonImport -->

<%
	request.setCharacterEncoding("UTF-8");

    //request 데이터
	DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
	requestMap.setNullToInitialize(true);

	// 필수 코딩 내용 //////////////////////////////////////////////////////////////////////
	//로그인된 사용자 정보
	LoginInfo memberInfo = (LoginInfo)request.getAttribute("LOGIN_INFO");
	
    //navigation 데이터
	/* DataMap navigationMap = (DataMap)request.getAttribute("NAVIGATION_DATA");
	navigationMap.setNullToInitialize(true); */
	
	// 상단 navigation
	/* String navigationStr = LoginCheck.NavigationCreate(memberInfo, navigationMap); */
	////////////////////////////////////////////////////////////////////////////////////

	
	String tmpStr = "";	
	String name = "";	// 성명
	String deptnm = "";	// 소속
	String mjiknm = "";	// 직급
	String toDay = "";	// 작업일
	//리스트
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	listMap.setNullToInitialize(true);

	StringBuffer listStr = new StringBuffer(); //리스트 결과 변수.
	StringBuffer listStr1 = new StringBuffer(); //리스트 결과 변수.
	StringBuffer listStr2 = new StringBuffer(); //리스트 결과 변수.
  	int x = 1;
	String temname = "";
	String temsubjnm = "";
	for(int i=0; i < listMap.keySize("name"); i++){
		if (i == 0){
			name = listMap.getString("name", i);
			deptnm = listMap.getString("deptnm", i);
			mjiknm = listMap.getString("mjiknm", i);
			toDay = listMap.getString("reqdate", i);
			Date now = new Date();

			double q_a = 0 ;
			double q_b = 0 ;
			double q_c = 0 ;
			double q_d = 0 ;
			double q_e = 0 ;
			double q_f = 0 ;
			double q_g = 0 ;
			// 정책방향인식
			q_a = q_a + Double.parseDouble(listMap.getString("q01", i));
			q_a = q_a + Double.parseDouble(listMap.getString("q02", i));
			q_a = q_a + Double.parseDouble(listMap.getString("q03", i));
			q_a = q_a + Double.parseDouble(listMap.getString("q04", i));
			q_a = q_a + Double.parseDouble(listMap.getString("q05", i));
			// 정책변화대응
			q_b = q_b + Double.parseDouble(listMap.getString("q06", i));
			q_b = q_b + Double.parseDouble(listMap.getString("q07", i));
			q_b = q_b + Double.parseDouble(listMap.getString("q08", i));
			q_b = q_b + Double.parseDouble(listMap.getString("q09", i));
			q_b = q_b + Double.parseDouble(listMap.getString("q10", i));
			// 소통채널구축
			q_c = q_c + Double.parseDouble(listMap.getString("q11", i));
			q_c = q_c + Double.parseDouble(listMap.getString("q12", i));
			q_c = q_c + Double.parseDouble(listMap.getString("q13", i));
			q_c = q_c + Double.parseDouble(listMap.getString("q14", i));
			q_c = q_c + Double.parseDouble(listMap.getString("q15", i));
			// 이해관계조정
			q_d = q_d + Double.parseDouble(listMap.getString("q16", i));
			q_d = q_d + Double.parseDouble(listMap.getString("q17", i));
			q_d = q_d + Double.parseDouble(listMap.getString("q18", i));
			q_d = q_d + Double.parseDouble(listMap.getString("q19", i));
			q_d = q_d + Double.parseDouble(listMap.getString("q20", i));
			// 팀워크촉진
			q_e = q_e + Double.parseDouble(listMap.getString("q21", i));
			q_e = q_e + Double.parseDouble(listMap.getString("q22", i));
			q_e = q_e + Double.parseDouble(listMap.getString("q23", i));
			q_e = q_e + Double.parseDouble(listMap.getString("q24", i));
			q_e = q_e + Double.parseDouble(listMap.getString("q25", i));
			// 팀성과관리
			q_f = q_f + Double.parseDouble(listMap.getString("q26", i));
			q_f = q_f + Double.parseDouble(listMap.getString("q27", i));
			q_f = q_f + Double.parseDouble(listMap.getString("q28", i));
			q_f = q_f + Double.parseDouble(listMap.getString("q29", i));
			q_f = q_f + Double.parseDouble(listMap.getString("q30", i));
			// 역량이해도
			q_g = q_g + Double.parseDouble(listMap.getString("q31", i));
			q_g = q_g + Double.parseDouble(listMap.getString("q32", i));
			q_g = q_g + Double.parseDouble(listMap.getString("q33", i));
			q_g = q_g + Double.parseDouble(listMap.getString("q34", i));
			q_g = q_g + Double.parseDouble(listMap.getString("q35", i));
			
			listStr1.append("\n<tr height='25'>");
			listStr1.append("\n	<td style='color:red;font-weight:bold;'>사전진단</td>");
			
			listStr1.append("\n	<td align='center' bgcolor='#FFFFFF'>" + String.format("%.2f", (q_a/5)) + "</td>");
			listStr1.append("\n	<td align='center' bgcolor='#FFFFFF'>" + String.format("%.2f", (q_b/5)) + "</td>");
			listStr1.append("\n	<td align='center' bgcolor='#FFFFFF'>" + String.format("%.2f", (q_c/5)) + "</td>");
			listStr1.append("\n	<td align='center' bgcolor='#FFFFFF'>" + String.format("%.2f", (q_d/5)) + "</td>");
			listStr1.append("\n	<td align='center' bgcolor='#FFFFFF'>" + String.format("%.2f", (q_e/5)) + "</td>");
			listStr1.append("\n	<td align='center' bgcolor='#FFFFFF'>" + String.format("%.2f", (q_f/5)) + "</td>");
			listStr1.append("\n	<td align='center' bgcolor='#FFFFFF'>" + String.format("%.2f", (q_g/5)) + "</td>");
	
			listStr1.append("\n</tr>");
		} else if(i == 1){
			double q_a2 = 0 ;
			double q_b2 = 0 ;
			double q_c2 = 0 ;
			double q_d2 = 0 ;
			double q_e2 = 0 ;
			double q_f2 = 0 ;
			double q_g2 = 0 ;
			// 정책방향인식
			q_a2 = q_a2 + Double.parseDouble(listMap.getString("q01", i));
			q_a2 = q_a2 + Double.parseDouble(listMap.getString("q02", i));
			q_a2 = q_a2 + Double.parseDouble(listMap.getString("q03", i));
			q_a2 = q_a2 + Double.parseDouble(listMap.getString("q04", i));
			q_a2 = q_a2 + Double.parseDouble(listMap.getString("q05", i));
			// 정책변화대응
			q_b2 = q_b2 + Double.parseDouble(listMap.getString("q06", i));
			q_b2 = q_b2 + Double.parseDouble(listMap.getString("q07", i));
			q_b2 = q_b2 + Double.parseDouble(listMap.getString("q08", i));
			q_b2 = q_b2 + Double.parseDouble(listMap.getString("q09", i));
			q_b2 = q_b2 + Double.parseDouble(listMap.getString("q10", i));
			// 소통채널구축
			q_c2 = q_c2 + Double.parseDouble(listMap.getString("q11", i));
			q_c2 = q_c2 + Double.parseDouble(listMap.getString("q12", i));
			q_c2 = q_c2 + Double.parseDouble(listMap.getString("q13", i));
			q_c2 = q_c2 + Double.parseDouble(listMap.getString("q14", i));
			q_c2 = q_c2 + Double.parseDouble(listMap.getString("q15", i));
			// 이해관계조정
			q_d2 = q_d2 + Double.parseDouble(listMap.getString("q16", i));
			q_d2 = q_d2 + Double.parseDouble(listMap.getString("q17", i));
			q_d2 = q_d2 + Double.parseDouble(listMap.getString("q18", i));
			q_d2 = q_d2 + Double.parseDouble(listMap.getString("q19", i));
			q_d2 = q_d2 + Double.parseDouble(listMap.getString("q20", i));
			// 팀워크촉진
			q_e2 = q_e2 + Double.parseDouble(listMap.getString("q21", i));
			q_e2 = q_e2 + Double.parseDouble(listMap.getString("q22", i));
			q_e2 = q_e2 + Double.parseDouble(listMap.getString("q23", i));
			q_e2 = q_e2 + Double.parseDouble(listMap.getString("q24", i));
			q_e2 = q_e2 + Double.parseDouble(listMap.getString("q25", i));
			// 팀성과관리
			q_f2 = q_f2 + Double.parseDouble(listMap.getString("q26", i));
			q_f2 = q_f2 + Double.parseDouble(listMap.getString("q27", i));
			q_f2 = q_f2 + Double.parseDouble(listMap.getString("q28", i));
			q_f2 = q_f2 + Double.parseDouble(listMap.getString("q29", i));
			q_f2 = q_f2 + Double.parseDouble(listMap.getString("q30", i));
			// 역량이해도
			q_g2 = q_g2 + Double.parseDouble(listMap.getString("q31", i));
			q_g2 = q_g2 + Double.parseDouble(listMap.getString("q32", i));
			q_g2 = q_g2 + Double.parseDouble(listMap.getString("q33", i));
			q_g2 = q_g2 + Double.parseDouble(listMap.getString("q34", i));
			q_g2 = q_g2 + Double.parseDouble(listMap.getString("q35", i));
			
			listStr2.append("\n<tr height='25'>");
			listStr2.append("\n	<td style='color:red;font-weight:bold;'>사후진단</td>");
			
			listStr2.append("\n	<td align='center' bgcolor='#FFFFFF'>" + String.format("%.2f", (q_a2/5)) + "</td>");
			listStr2.append("\n	<td align='center' bgcolor='#FFFFFF'>" + String.format("%.2f", (q_b2/5)) + "</td>");
			listStr2.append("\n	<td align='center' bgcolor='#FFFFFF'>" + String.format("%.2f", (q_c2/5)) + "</td>");
			listStr2.append("\n	<td align='center' bgcolor='#FFFFFF'>" + String.format("%.2f", (q_d2/5)) + "</td>");
			listStr2.append("\n	<td align='center' bgcolor='#FFFFFF'>" + String.format("%.2f", (q_e2/5)) + "</td>");
			listStr2.append("\n	<td align='center' bgcolor='#FFFFFF'>" + String.format("%.2f", (q_f2/5)) + "</td>");
			listStr2.append("\n	<td align='center' bgcolor='#FFFFFF'>" + String.format("%.2f", (q_g2/5)) + "</td>");
	
			listStr2.append("\n</tr>");
			x ++;
		}
	
	
	} //end for 
	//1차 등록일 경우
	 if( listMap.keySize("name") == 1){
		listStr2.append("\n<tr height='25'>");
		listStr2.append("\n	<td style='color:red;font-weight:bold;'>사후진단</td>");
		
		listStr2.append("\n	<td align='center' bgcolor='#FFFFFF'></td>");
		listStr2.append("\n	<td align='center' bgcolor='#FFFFFF'></td>");
		listStr2.append("\n	<td align='center' bgcolor='#FFFFFF'></td>");
		listStr2.append("\n	<td align='center' bgcolor='#FFFFFF'></td>");
		listStr2.append("\n	<td align='center' bgcolor='#FFFFFF'></td>");
		listStr2.append("\n	<td align='center' bgcolor='#FFFFFF'></td>");
		listStr2.append("\n	<td align='center' bgcolor='#FFFFFF'></td>");

		listStr2.append("\n</tr>");

	}

%>


<%

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

	<title>인천광역시인재개발원에 오신 것을 환영합니다.</title>


<link  type="text/css" href="/homepage_new/css/sub.css" rel="stylesheet" charset="euc-kr">
<link rel="STYLESHEET" type="text/css" href="/homepage_new/css/common.css" />
<link rel="stylesheet" type="text/css" href="/homepage_new/css/content.css" />
<script type="text/javascript" language="javascript" src="/homepage_new/js/navigation.js"></script>
<script type="text/javascript" src="/lib/js/script.js"></script>
<script type="text/javascript" language="javascript" src="/commonInc/js/commonJs.js"></script>
<script type="text/javascript" language="javascript" src="/commonInc/js/prototype-1.6.0.2.js"></script>

<style type="text/css">
/*설문조사 추가*/
.survey{text-align:center;}
.survey a{
    padding: 30px 30px;
    color: #ffffff;
    background: #0079ba;
    text-align:center;
}
.table_st3 tbody tr th
{
font-size: 12px;
}
#content
{
margin: 20px;
}
</style>
<script type="text/javascript">
function excel(){

	var url = "/poll/capacityDiagnosisPoll4.do";
	pform.action = url;
	pform.submit();
}
</script>
</head>
<bady>


<div id="content">
	<div class="point_box">
		<p class="box_img"><span><img src="https://hrd.incheon.go.kr/homepage_new/images/common/box_point.gif" alt=""></span></p>
		<div class="list">
			<p>본 결과는 자가진단 결과로, 본인의 실제 역량 수준과는 차이가 있을 수 있습니다. 다만 해당 결과를 교육 이후 부족한 역량을 개발하는데 참고하시기 바랍니다.</p>
		</div>
	</div>
	<br/>
	<br/>
	<table class="table_st3"> 
		<colgroup>
			<col width="10%">
			<col width="40%">
			<col width="10%">
			<col width="40%">
		</colgroup>
		<tbody>
			<tr>
				<th>이름</th>
				<td class="left"><%= name %></td>
				<th>소속</th>
				<td class="left"><%= deptnm %></td>
			</tr>
			<tr>
				<th>직급</th>
				<td class="left"><%= mjiknm %></td>
				<th>진단일</th>
				<td class="left"><%=toDay %></td>
			</tr>
		</tbody>
	</table>
	<br/>
	<br/>
	<p style="font-weight:bold;">※ 개인진단결과(5점만점)</P>
	<table class="table_st3">
		<thead>
			<tr>
				<th></th>
				<th style="font-size:12px;">정책관리</th>
				<th style="font-size:12px;">변화주도</th>
				<th style="font-size:12px;">네트워크 구축 및 활용</th>
				<th style="font-size:12px;">다양성존중</th>
				<th style="font-size:12px;">조직관리</th>
				<th style="font-size:12px;">성과관리</th>
				<th style="font-size:12px;">역량이해도</th>
			</tr>
		</thead>
		<tbody>
			<%=listStr1 %>
			<%=listStr2 %>
			<!-- <tr>
				<td style="color:red;font-weight:bold;">사전진단</td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>
			<tr>
				<td style="color:blue;font-weight:bold;">사후진단</td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
			</tr> -->
		</tbody>
	</table>
	<br/>
	<div class="survey" style="margin-top:40px;">
		<a href="javascript:excel()">결과출력</a>
	</div>
</div>

	<form id="pform" name="pform" method="post" >
		<input type="hidden" name="menuId"				value="<%= requestMap.getString("menuId") %>">
		<input type="hidden" name="mode"				value="result_excel">
		
		<input type="hidden" name="grcode"		id="grcode"		value="<%= requestMap.getString("grcode") %>">
		<input type="hidden" name="grseq"		id="grseq"		value="<%= requestMap.getString("grseq") %>">
		
		<input type="hidden" name="banda"		id="banda"		value="<%= requestMap.getString("banda") %>">
	</form>
</bady>

