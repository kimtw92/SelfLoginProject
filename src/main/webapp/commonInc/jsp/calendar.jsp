<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commonInc/include/commonImport.jsp" %>

<%

	String oDate = Util.getValue(request.getParameter("oDate"));

	int oYear = 0;
	int oMonth = 0;
	int oDay = 0;
	
	if(!oDate.equals("")){
		if(oDate.length() == 8){
			oYear = Integer.parseInt(oDate.substring(0,4));
			oMonth = Integer.parseInt(oDate.substring(4,6));
			oDay = Integer.parseInt(oDate.substring(6,8));						
		}else if(oDate.length() == 6){
			oYear = Integer.parseInt(oDate.substring(0,4));
			oMonth = Integer.parseInt(oDate.substring(4,6));
		}else if(oDate.length() == 4){
			oYear = Integer.parseInt(oDate.substring(0,4));
		}
	}

%>
<!-------------------------------------------------------------------------------+
	일반형 달력
--------------------------------------------------------------------------------->
<HTML>
<HEAD>
<TITLE>날짜입력</TITLE>
<style type="text/css">
    a:link { text-decoration: none;}
    a:visited { text-decoration: none;}
    TD { text-align: center; vertical-align: middle;}
    .CalHead { font:bold 8pt Arial; color: white;}
    .CalCell { font:8pt Arial; cursor: hand;}
    .HeadBtn { vertical-align:middle; height:22; width:18; font:10pt Fixedsys;}
    .HeadBox { vertical-align:middle; font:10pt;}
    .Today { font:bold 10pt Arial; color:white;}
</style>
</head>

<body leftmargin=0 topmargin=0 marginwidth=0 marginheight=0>

<script>
/******** 환경설정 부분 *******************************************************/

var giStartYear     = 1973;
var giEndYear       = 2073;
var giCellWidth     = 20;
var gMonths         = new Array("1월","2월","3월","4월","5월","6월","7월","8월","9월","10월","11월","12월");
var gcOtherDay      = "gray";
var gcToggle        = "yellow";
var gcBG            = "#dddddd";
var gcTodayBG       = "white";
var gcFrame         = "orange";
var gcHead          = "white";
var gcWeekend       = "red";
var gcWorkday       = "black";
var gcCalBG         = "lightblue";

var gcTemp          = gcBG;
var gdCurDate       = new Date();
var giYear          = <% if(oYear > 0){ out.println(oYear); }else{ out.print("gdCurDate.getFullYear();"); } %> //   gdCurDate.getFullYear();
var giMonth         = <% if(oMonth > 0){ out.println(oMonth); }else{ out.print("gdCurDate.getMonth()+1;"); } %> //gdCurDate.getMonth()+1;
var giDay           = <% if(oDay > 0){ out.println(oDay); }else{ out.print("gdCurDate.getDate();"); } %> //gdCurDate.getDate();
var gCellSet        = new Array;
var tbMonSelect, tbYearSelect;


function setFormat(str, len, c)
{
	var iLen;

	str = str.toString();

	 iLen = str.length;
	len = len - iLen;
	for( k = 0; k < len; k++)
	{
		str = c + str;
	}
	return str;
}

function fSetDate(iYear, iMonth, iDay){
	window.returnValue = iYear  + setFormat(iMonth, 2, '0') +  setFormat(iDay,2,'0');
	window.close();
}

function fSetDelDate(){
	window.returnValue = "delete";
	window.close();
}

function fSetSelected(aCell){
	var iOffset = 0;
	var iYear = parseInt(tbSelYear.value);
	var iMonth = parseInt(tbSelMonth.value);

	aCell.bgColor = gcBG;
	with (aCell.firstChild){
  		var iDate = parseInt(innerHTML);
  		if (style.color==gcOtherDay)
			iOffset = (id<10)?-1:1;
		iMonth += iOffset;
		if (iMonth<1) {
			iYear--;
			iMonth = 12;
		}
		else if (iMonth>12){
			iYear++;
			iMonth = 1;
		}
	}

	fSetDate(iYear, iMonth, iDate);
}

function fBuildCal(iYear, iMonth) {
	var aMonth=new Array();
  
	for(i=1;i<7;i++)
  		aMonth[i]=new Array(i);

	var dCalDate=new Date(iYear, iMonth-1, 1);
	var iDayOfFirst=dCalDate.getDay();
	var iDaysInMonth=new Date(iYear, iMonth, 0).getDate();
	var iOffsetLast=new Date(iYear, iMonth-1, 0).getDate()-iDayOfFirst+1;
	var iDate = 1;
	var iNext = 1;

	for (d = 0; d < 7; d++)
		aMonth[1][d] = (d<iDayOfFirst)?-(iOffsetLast+d):iDate++;
	for (w = 2; w < 7; w++)
  		for (d = 0; d < 7; d++)
			aMonth[w][d] = (iDate<=iDaysInMonth)?iDate++:-(iNext++);
	return aMonth;
}

function fDrawCal(iCellWidth) {
	var WeekDay = new Array("일","월","화","수","목","금","토");
	var styleTD = " width='"+iCellWidth+"' ";

	with (document) {
		write("<tr>");
		for(i=0; i<7; i++)
		write("<td class='CalHead' "+styleTD+">" + WeekDay[i] + "</td>");
		write("</tr>");

  		for (w = 1; w < 7; w++) {
			write("<tr>");
			for (d = 0; d < 7; d++) {
				write("<td class='CalCell' "+styleTD+" onMouseOver='gcTemp=this.bgColor;this.bgColor=gcToggle;this.bgColor=gcToggle' onMouseOut='this.bgColor=gcTemp;this.bgColor=gcTemp' onclick='fSetSelected(this)'>");
				write("<A href='#' onfocus='this.blur();'>00</A></td>")
			}
			write("</tr>");
		}
	}
}

function fUpdateCal(iYear, iMonth) {
	myMonth = fBuildCal(iYear, iMonth);
	var i = 0;
	var iDate = 0;
	for (w = 0; w < 6; w++)
		for (d = 0; d < 7; d++)
			with (gCellSet[(7*w)+d]) {
				id = i++;
				if (myMonth[w+1][d]<0) {
					style.color = gcOtherDay;
					innerHTML = -myMonth[w+1][d];
					iDate = 0;
				}
				else{
					style.color = ((d==0)||(d==6))?gcWeekend:gcWorkday;
					innerHTML = myMonth[w+1][d];
					iDate++;
				}
				parentNode.bgColor = ((iYear==giYear)&&(iMonth==giMonth)&&(iDate==giDay))?gcTodayBG:gcBG;
				parentNode.bgColor = parentNode.bgColor;
			}
}

function fSetYearMon(iYear, iMon){
	tbSelMonth.options[iMon-1].selected = true;
	
	if (iYear>giEndYear) iYear=giEndYear;
	if (iYear<giStartYear) iYear=giStartYear;
	
	tbSelYear.options[iYear-giStartYear].selected = true;
	fUpdateCal(iYear, iMon);
}

function fPrevMonth(){
	var iMon = tbSelMonth.value;
	var iYear = tbSelYear.value;

	if (--iMon<1) {
		iMon = 12;
		iYear--;
	}

	fSetYearMon(iYear, iMon);
}

function fNextMonth(){
	var iMon = tbSelMonth.value;
	var iYear = tbSelYear.value;

	if (++iMon>12) {
		iMon = 1;
		iYear++;
	}

	fSetYearMon(iYear, iMon);
}

with (document) {
	write("	<table id='popTable' width='250' height='100%' bgcolor='"+gcCalBG+"' cellspacing='0' cellpadding='3' border='1'>");
	write("		<TR>");
	write("			<td align='center'>");
	write("				<input type='button' value='<' class='HeadBtn' onClick='fPrevMonth()' id='button'1 name='button'1>&nbsp;");
	write("				<SELECT id='tbYearSelect' class='HeadBox' onChange='fUpdateCal(tbSelYear.value, tbSelMonth.value)' Victor='Won'>");
	
	for(i=giStartYear;i<=giEndYear;i++)
		write("				<OPTION value='"+i+"'>"+i+"</OPTION>");
	write("				</SELECT>");

	write("				<select id='tbMonSelect' class='HeadBox' onChange='fUpdateCal(tbSelYear.value, tbSelMonth.value)' Victor='Won'>");
	
	for (i=0; i<12; i++)
		write("				<option value='"+(i+1)+"'>"+gMonths[i]+"</option>");
	write("				</SELECT>&nbsp;");
	write("				<input type='button' value='>' class='HeadBtn' onclick='fNextMonth()' id='button'1 name='button'1>");	
	write("			</td>");
	write("		</TR>");
	write("		<TR>");
	write("			<td align='center'>");
	write("				<DIV style='background-color:"+gcFrame+";width:"+((giCellWidth+6)*7+2)+"px;'>");
	write("					<table border='0' cellpadding='2' >");
	
	tbSelMonth = getElementById("tbMonSelect");
	tbSelYear = getElementById("tbYearSelect");
	fDrawCal(giCellWidth);
	gCellSet = getElementsByTagName("A"); 
	fSetYearMon(giYear, giMonth);
	
	write("					</table>");
	write("				</DIV>");
	write("			</td>");
	write("		</TR>");
	write("		<TR>");
	write("			<TD align='center'>");
	write("				<A href='#' class='Today' onclick='fSetDate(giYear,giMonth,giDay); this.blur();' onMouseOver='gcTemp=this.style.color;this.style.color=gcToggle' onMouseOut='this.style.color=gcTemp'>Today :&nbsp;"+giYear +"년 "+gMonths[giMonth-1]+" "+giDay+"일</A>");
	write("			</TD>");
	write("		</TR>");
	write("		<TR>");
	write("			<TD>");
	write("				<A href='#' class='Today' OnClick='fSetDelDate();'  onMouseOver='gcTemp=this.style.color;this.style.color=gcToggle' onMouseOut='this.style.color=gcTemp'>[ 날짜삭제 ]</A>&nbsp;&nbsp;");
	write("				<A href='#' class='Today' OnClick='self.close();'  onMouseOver='gcTemp=this.style.color;this.style.color=gcToggle' onMouseOut='this.style.color=gcTemp'>[ 닫기 ]</A>");
	write("			</TD>");
	write("		</TR>");
	write("	</TABLE>");
}
</script>

</body>
</html>

