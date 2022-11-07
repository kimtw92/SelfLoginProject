<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<head>
<LINK href="cyberpoll_files/master_style.css" type=text/css rel=stylesheet>
<LINK href="cyberpoll_files/style2.css" type=text/css rel=stylesheet>
<LINK href="cyberpoll_files/protoload.css" type=text/css rel=stylesheet>
<SCRIPT language=javascript src="cyberpoll_files/prototype-1.6.0.2.js"></SCRIPT>

<SCRIPT language=javascript src="cyberpoll_files/commonJs.js"></SCRIPT>

<SCRIPT language=javascript src="cyberpoll_files/NChecker.js"></SCRIPT>

<SCRIPT language=javascript src="cyberpoll_files/protoload.js"></SCRIPT>

<SCRIPT language=javascript src="cyberpoll_files/InnoDS.js"></SCRIPT>

<SCRIPT language=javascript src="cyberpoll_files/category.js"></SCRIPT>

<!-- [e] commonHtmlTop include -->
<SCRIPT language=JavaScript>
<!--

//주관식 답변 보기
function go_answerTxtView(titleNo, setNo, questionNo){

	var mode = "poll_result_answer";
	var menuId = $F("menuId");
	var url = "/poll/coursePoll.do?mode=" + mode + "&menuId=" + menuId + "&titleNo=" + titleNo + "&setNo=" + setNo + "&questionNo=" + questionNo;

	popWin(url, "pop_answerTxtView", "500", "500", "1", "");
}



onload = function()	{

}

//-->
</SCRIPT>

</HEAD>
<BODY leftMargin=0 topMargin=0 marginheight="0" marginwidth="0">
<FORM id=pform name=pform method=post><INPUT type=hidden value=2-7-1 
name=menuId> <INPUT type=hidden value=poll_result_preview name=mode> <INPUT 
type=hidden name=qu> <INPUT type=hidden value=391 name=titleNo> <INPUT 
type=hidden value=1 name=setNo> 
<TABLE class=pop01>
  <TBODY>
  <TR>
    <TD class=titarea><!-- 타이틀영역 -->
      <DIV class=tit>
      <H1 class=h1><IMG src="cyberpoll_files/bullet_pop.gif"> 2008 cyber 과정 설문</H1></DIV><!--// 타이틀영역 --></TD></TR>
  <TR>
    <TD class=con>
      <TABLE class="datah01 bb0" style="WIDTH: 690px">
        <COLGROUP>
        <COL width=55>
        <COL width=350>
        <COL width=60>
        <COL width=55>
        <COL width=158></COLGROUP>
        <THEAD>
        <TR>
          <TH>설문1</TH>
          <TH class=left colSpan=2>사이버교육을 주로 학습한 장소는?</TH>
          <TH class=br0 colSpan=2>객관식</TH></TR>
        <TR>
          <TH class=bg01>문항</TH>
          <TH class=bg01>지문</TH>
          <TH class=bg01>응답자수</TH>
          <TH class="br0 bg01" colSpan=2>비율</TH></TR></THEAD>
        <TBODY>
        <TR>
          <TD style="HEIGHT: 30px">1</TD>
          <TD>사무실</TD>
          <TD>3688</TD>
          <TD>59.19 %</TD>
          <TD class=br0 rowSpan=4>
            <UL class=graphset01>
              <LI class=graph>
              <UL class=imgset>
                <LI><IMG height=59 src="cyberpoll_files/bg_graph.gif" width=20> 
                </LI>
                <LI><IMG height=38 src="cyberpoll_files/bg_graph.gif" width=20> 
                </LI>
                <LI><IMG height=1 src="cyberpoll_files/bg_graph.gif" width=20> 
                </LI>
                <LI><IMG height=2 src="cyberpoll_files/bg_graph.gif" width=20> 
                </LI></UL>
              <LI class=no>
              <UL class=txtset>
                <LI><IMG src="cyberpoll_files/no1.gif"> </LI>
                <LI><IMG src="cyberpoll_files/no2.gif"> </LI>
                <LI><IMG src="cyberpoll_files/no3.gif"> </LI>
                <LI><IMG src="cyberpoll_files/no4.gif"> </LI></UL></LI></UL></TD></TR>
        <TR>
          <TD style="HEIGHT: 30px">2</TD>
          <TD>가정</TD>
          <TD>2397</TD>
          <TD>38.47 %</TD></TR>
        <TR>
          <TD style="HEIGHT: 30px">3</TD>
          <TD>PC방</TD>
          <TD>17</TD>
          <TD>0.29 %</TD></TR>
        <TR>
          <TD style="HEIGHT: 30px">4</TD>
          <TD>기타</TD>
          <TD>128</TD>
          <TD>0.25 %</TD></TR></TBODY></TABLE>
      <DIV class=space01></DIV>
      <TABLE class="datah01 bb0" style="WIDTH: 690px">
        <COLGROUP>
        <COL width=55>
        <COL width=350>
        <COL width=60>
        <COL width=55>
        <COL width=158></COLGROUP>
        <THEAD>
        <TR>
          <TH>설문2</TH>
          <TH class=left colSpan=2>사이버교육을 주로 학습한 시간대는?</TH>
          <TH class=br0 colSpan=2>객관식</TH></TR>
        <TR>
          <TH class=bg01>문항</TH>
          <TH class=bg01>지문</TH>
          <TH class=bg01>응답자수</TH>
          <TH class="br0 bg01" colSpan=2>비율</TH></TR></THEAD>
        <TBODY>
        <TR>
          <TD style="HEIGHT: 30px">1</TD>
          <TD>근무시간중(09:00 ~ 18:00)</TD>
          <TD>928</TD>
          <TD>14.90 %</TD>
          <TD class=br0 rowSpan=4>
            <UL class=graphset01>
              <LI class=graph>
              <UL class=imgset>
                <LI><IMG height=14 src="cyberpoll_files/bg_graph.gif" width=20> 
                </LI>
                <LI><IMG height=43 src="cyberpoll_files/bg_graph.gif" width=20> 
                </LI>
                <LI><IMG height=34 src="cyberpoll_files/bg_graph.gif" width=20> 
                </LI>
                <LI><IMG height=7 src="cyberpoll_files/bg_graph.gif" width=20> 
                </LI></UL>
              <LI class=no>
              <UL class=txtset>
                <LI><IMG src="cyberpoll_files/no1.gif"> </LI>
                <LI><IMG src="cyberpoll_files/no2.gif"> </LI>
                <LI><IMG src="cyberpoll_files/no3.gif"> </LI>
                <LI><IMG src="cyberpoll_files/no4.gif"> </LI></UL></LI></UL></TD></TR>
        <TR>
          <TD style="HEIGHT: 30px">2</TD>
          <TD>근무시간 후(18:00 ~ 21:00)</TD>
          <TD>2712</TD>
          <TD>43.55 %</TD></TR>
        <TR>
          <TD style="HEIGHT: 30px">3</TD>
          <TD>근무시간 후(21:00 ~ 24:00)</TD>
          <TD>2120</TD>
          <TD>34.05 %</TD></TR>
        <TR>
          <TD style="HEIGHT: 30px">4</TD>
          <TD>출근전(6:00 ~ 9:00)</TD>
          <TD>466</TD>
          <TD>7.5 %</TD></TR></TBODY></TABLE>
      <DIV class=space01></DIV>
      <TABLE class="datah01 bb0" style="WIDTH: 690px">
        <COLGROUP>
        <COL width=55>
        <COL width=350>
        <COL width=60>
        <COL width=55>
        <COL width=158></COLGROUP>
        <THEAD>
        <TR>
          <TH>설문3</TH>
          <TH class=left colSpan=2>사이버교육 1회 학습 시 평균 얼마동안 학습을 지속하였습니까?</TH>
          <TH class=br0 colSpan=2>객관식</TH></TR>
        <TR>
          <TH class=bg01>문항</TH>
          <TH class=bg01>지문</TH>
          <TH class=bg01>응답자수</TH>
          <TH class="br0 bg01" colSpan=2>비율</TH></TR></THEAD>
        <TBODY>
        <TR>
          <TD style="HEIGHT: 30px">1</TD>
          <TD>30분 이상 ~ 1시간 미만</TD>
          <TD>3612</TD>
          <TD>58.01 %</TD>
          <TD class=br0 rowSpan=4>
            <UL class=graphset01>
              <LI class=graph>
              <UL class=imgset>
                <LI><IMG height=58 src="cyberpoll_files/bg_graph.gif" width=20> 
                </LI>
                <LI><IMG height=28 src="cyberpoll_files/bg_graph.gif" width=20> 
                </LI>
                <LI><IMG height=9 src="cyberpoll_files/bg_graph.gif" width=20> 
                </LI>
                <LI><IMG height=3 src="cyberpoll_files/bg_graph.gif" width=20> 
                </LI></UL>
              <LI class=no>
              <UL class=txtset>
                <LI><IMG src="cyberpoll_files/no1.gif"> </LI>
                <LI><IMG src="cyberpoll_files/no2.gif"> </LI>
                <LI><IMG src="cyberpoll_files/no3.gif"> </LI>
                <LI><IMG src="cyberpoll_files/no4.gif"> </LI></UL></LI></UL></TD></TR>
        <TR>
          <TD style="HEIGHT: 30px">2</TD>
          <TD>1시간 ~ 1시간 30분 미만</TD>
          <TD>1797</TD>
          <TD>28.86 %</TD></TR>
        <TR>
          <TD style="HEIGHT: 30px">3</TD>
          <TD>1시간 30분 ~ 2시간 미만</TD>
          <TD>572</TD>
          <TD>9.18 %</TD></TR>
        <TR>
          <TD style="HEIGHT: 30px">4</TD>
          <TD>2시간 이상</TD>
          <TD>245</TD>
          <TD>3.95 %</TD></TR></TBODY></TABLE>
      <DIV class=space01></DIV>
      <TABLE class="datah01 bb0" style="WIDTH: 690px">
        <COLGROUP>
        <COL width=55>
        <COL width=350>
        <COL width=60>
        <COL width=55>
        <COL width=158></COLGROUP>
        <THEAD>
        <TR>
          <TH>설문4</TH>
          <TH class=left colSpan=2>사이버 과목 교육기간은?</TH>
          <TH class=br0 colSpan=2>객관식</TH></TR>
        <TR>
          <TH class=bg01>문항</TH>
          <TH class=bg01>지문</TH>
          <TH class=bg01>응답자수</TH>
          <TH class="br0 bg01" colSpan=2>비율</TH></TR></THEAD>
        <TBODY>
        <TR>
          <TD style="HEIGHT: 30px">1</TD>
          <TD>짧다</TD>
          <TD>826</TD>
          <TD>13.27 %</TD>
          <TD class=br0 rowSpan=3>
            <UL class=graphset01>
              <LI class=graph>
              <UL class=imgset>
                <LI><IMG height=13 src="cyberpoll_files/bg_graph.gif" width=20> 
                </LI>
                <LI><IMG height=82 src="cyberpoll_files/bg_graph.gif" width=20> 
                </LI>
                <LI><IMG height=4 src="cyberpoll_files/bg_graph.gif" width=20> 
                </LI></UL>
              <LI class=no>
              <UL class=txtset>
                <LI><IMG src="cyberpoll_files/no1.gif"> </LI>
                <LI><IMG src="cyberpoll_files/no2.gif"> </LI>
                <LI><IMG src="cyberpoll_files/no3.gif"> </LI></UL></LI></UL></TD></TR>
        <TR>
          <TD style="HEIGHT: 30px">2</TD>
          <TD>적당하다</TD>
          <TD>5138</TD>
          <TD>82.56 %</TD></TR>
        <TR>
          <TD style="HEIGHT: 30px">3</TD>
          <TD>길다</TD>
          <TD>259</TD>
          <TD>4.17 %</TD></TR></TBODY></TABLE>
      <DIV class=space01></DIV>
      <TABLE class="datah01 bb0" style="WIDTH: 690px">
        <COLGROUP>
        <COL width=55>
        <COL width=350>
        <COL width=60>
        <COL width=55>
        <COL width=158></COLGROUP>
        <THEAD>
        <TR>
          <TH>설문5</TH>
          <TH class=left colSpan=2>사이버교육 학습분위기를 조성하기 위하여 학습분량을 하루 최대 5차시로 
            제한하였고 1차별 학습시간은 최소 10분이상 학습하는 것으로 운영하고 있습니다. 이렇게 운영되는 시스템에 대하여 
          묻겠습니다.</TH>
          <TH class=br0 colSpan=2>객관식</TH></TR>
        <TR>
          <TH class=bg01>문항</TH>
          <TH class=bg01>지문</TH>
          <TH class=bg01>응답자수</TH>
          <TH class="br0 bg01" colSpan=2>비율</TH></TR></THEAD>
        <TBODY>
        <TR>
          <TD style="HEIGHT: 30px">1</TD>
          <TD>밀린 차시를 학습하기에 너무 벅찬 시스템이다.</TD>
          <TD>684</TD>
          <TD>10.98 %</TD>
          <TD class=br0 rowSpan=5>
            <UL class=graphset01>
              <LI class=graph>
              <UL class=imgset>
                <LI><IMG height=10 src="cyberpoll_files/bg_graph.gif" width=20> 
                </LI>
                <LI><IMG height=66 src="cyberpoll_files/bg_graph.gif" width=20> 
                </LI>
                <LI><IMG height=15 src="cyberpoll_files/bg_graph.gif" width=20> 
                </LI>
                <LI><IMG height=5 src="cyberpoll_files/bg_graph.gif" width=20> 
                </LI>
                <LI><IMG height=2 src="cyberpoll_files/bg_graph.gif" width=20> 
                </LI></UL>
              <LI class=no>
              <UL class=txtset>
                <LI><IMG src="cyberpoll_files/no1.gif"> </LI>
                <LI><IMG src="cyberpoll_files/no2.gif"> </LI>
                <LI><IMG src="cyberpoll_files/no3.gif"> </LI>
                <LI><IMG src="cyberpoll_files/no4.gif"> </LI>
                <LI><IMG src="cyberpoll_files/no5.gif"> </LI></UL></LI></UL></TD></TR>
        <TR>
          <TD style="HEIGHT: 30px">2</TD>
          <TD>하루 일정량만 꾸준히 학습하면 무리가 없는 시스템이다.</TD>
          <TD>4117</TD>
          <TD>66.13 %</TD></TR>
        <TR>
          <TD style="HEIGHT: 30px">3</TD>
          <TD>밀려서 하다보니 하루 5차시 이상 수강하여야 하는데 분량제한으로 다소 힘들었다.</TD>
          <TD>938</TD>
          <TD>15.06 %</TD></TR>
        <TR>
          <TD style="HEIGHT: 30px">4</TD>
          <TD>1차시 학습시간이 10분보다 짧아도 된다고 생각한다.</TD>
          <TD>314</TD>
          <TD>5.04 %</TD></TR>
        <TR>
          <TD style="HEIGHT: 30px">5</TD>
          <TD>위의 사실에 대하여 전혀 몰랐다.</TD>
          <TD>172</TD>
          <TD>2.79 %</TD></TR></TBODY></TABLE>
      <DIV class=space01></DIV>
      <TABLE class="datah01 bb0" style="WIDTH: 690px">
        <COLGROUP>
        <COL width=55>
        <COL width=350>
        <COL width=60>
        <COL width=55>
        <COL width=158></COLGROUP>
        <THEAD>
        <TR>
          <TH>설문6</TH>
          <TH class=left colSpan=2>2005년부터 
            사이버교육과정(e-엑셀,e-파워포인트,e-회계실무,e-예산실무)을 운영하고 있습니다. 사이버교육2주로 운영되며 평가결과 
            60점이상자만 수료로 인정됩니다. 사이버교육과정에 들어오실 의향은?</TH>
          <TH class=br0 colSpan=2>객관식</TH></TR>
        <TR>
          <TH class=bg01>문항</TH>
          <TH class=bg01>지문</TH>
          <TH class=bg01>응답자수</TH>
          <TH class="br0 bg01" colSpan=2>비율</TH></TR></THEAD>
        <TBODY>
        <TR>
          <TD style="HEIGHT: 30px">1</TD>
          <TD>꼭 들어오고 싶다.</TD>
          <TD>2675</TD>
          <TD>42.95 %</TD>
          <TD class=br0 rowSpan=4>
            <UL class=graphset01>
              <LI class=graph>
              <UL class=imgset>
                <LI><IMG height=42 src="cyberpoll_files/bg_graph.gif" width=20> 
                </LI>
                <LI><IMG height=46 src="cyberpoll_files/bg_graph.gif" width=20> 
                </LI>
                <LI><IMG height=2 src="cyberpoll_files/bg_graph.gif" width=20> 
                </LI>
                <LI><IMG height=7 src="cyberpoll_files/bg_graph.gif" width=20> 
                </LI></UL>
              <LI class=no>
              <UL class=txtset>
                <LI><IMG src="cyberpoll_files/no1.gif"> </LI>
                <LI><IMG src="cyberpoll_files/no2.gif"> </LI>
                <LI><IMG src="cyberpoll_files/no3.gif"> </LI>
                <LI><IMG src="cyberpoll_files/no4.gif"> </LI></UL></LI></UL></TD></TR>
        <TR>
          <TD style="HEIGHT: 30px">2</TD>
          <TD>보통이다.</TD>
          <TD>2890</TD>
          <TD>46.41 %</TD></TR>
        <TR>
          <TD style="HEIGHT: 30px">3</TD>
          <TD>들어오고 싶지만 과정이 맘에 안든다.</TD>
          <TD>175</TD>
          <TD>2.81 %</TD></TR>
        <TR>
          <TD style="HEIGHT: 30px">4</TD>
          <TD>사이버교육과정보다는 집합교육을 듣고 싶다.</TD>
          <TD>487</TD>
          <TD>7.83 %</TD></TR></TBODY></TABLE>
      <DIV class=space01></DIV>

      <TABLE class="datah01 bb0" style="WIDTH: 690px">
        <COLGROUP>
        <COL width=55>
        <COL width=350>
        <COL width=60>
        <COL width=55>
        <COL width=158></COLGROUP>
        <THEAD>
        <TR>
          <TH>설문11</TH>
          <TH class=left colSpan=2>이번 교육과정을 통해 본인이 얻은 교육성과는?</TH>
          <TH class=br0 colSpan=2>객관식</TH></TR>
        <TR>
          <TH class=bg01>문항</TH>
          <TH class=bg01>지문</TH>
          <TH class=bg01>응답자수</TH>
          <TH class="br0 bg01" colSpan=2>비율</TH></TR></THEAD>
        <TBODY>
        <TR>
          <TD style="HEIGHT: 30px">1</TD>
          <TD>매우 만족</TD>
          <TD>1023</TD>
          <TD>16.77 %</TD>
          <TD class=br0 rowSpan=5>
            <UL class=graphset01>
              <LI class=graph>
              <UL class=imgset>
                <LI><IMG height=16 src="cyberpoll_files/bg_graph.gif" width=20> 
                </LI>
                <LI><IMG height=55 src="cyberpoll_files/bg_graph.gif" width=20> 
                </LI>
                <LI><IMG height=25 src="cyberpoll_files/bg_graph.gif" width=20> 
                </LI>
                <LI><IMG height=1 src="cyberpoll_files/bg_graph.gif" width=20> 
                </LI>
                <LI><IMG height=0 src="cyberpoll_files/bg_graph.gif" width=20> 
                </LI></UL>
              <LI class=no>
              <UL class=txtset>
                <LI><IMG src="cyberpoll_files/no1.gif"> </LI>
                <LI><IMG src="cyberpoll_files/no2.gif"> </LI>
                <LI><IMG src="cyberpoll_files/no3.gif"> </LI>
                <LI><IMG src="cyberpoll_files/no4.gif"> </LI>
                <LI><IMG src="cyberpoll_files/no5.gif"> </LI></UL></LI></UL></TD></TR>
        <TR>
          <TD style="HEIGHT: 30px">2</TD>
          <TD>대체로 만족</TD>
          <TD>3410</TD>
          <TD>55.90 %</TD></TR>
        <TR>
          <TD style="HEIGHT: 30px">3</TD>
          <TD>보통</TD>
          <TD>1563</TD>
          <TD>25.62 %</TD></TR>
        <TR>
          <TD style="HEIGHT: 30px">4</TD>
          <TD>불만족</TD>
          <TD>92</TD>
          <TD>1.50 %</TD></TR>
        <TR>
          <TD style="HEIGHT: 30px">5</TD>
          <TD>매우 불만족</TD>
          <TD>12</TD>
          <TD>0.21 %</TD></TR></TBODY></TABLE>
      <DIV class=space01></DIV>
      <TABLE class="datah01 bb0" style="WIDTH: 690px">
        <COLGROUP>
        <COL width=55>
        <COL width=350>
        <COL width=60>
        <COL width=55>
        <COL width=158></COLGROUP>
        <THEAD>
        <TR>
          <TH>설문12</TH>
          <TH class=left colSpan=2>이번 교육과정의 교과목 편성 및 구성에 대한 전반적 의견은?</TH>
          <TH class=br0 colSpan=2>객관식</TH></TR>
        <TR>
          <TH class=bg01>문항</TH>
          <TH class=bg01>지문</TH>
          <TH class=bg01>응답자수</TH>
          <TH class="br0 bg01" colSpan=2>비율</TH></TR></THEAD>
        <TBODY>
        <TR>
          <TD style="HEIGHT: 30px">1</TD>
          <TD>매우 만족</TD>
          <TD>954</TD>
          <TD>15.62 %</TD>
          <TD class=br0 rowSpan=5>
            <UL class=graphset01>
              <LI class=graph>
              <UL class=imgset>
                <LI><IMG height=15 src="cyberpoll_files/bg_graph.gif" width=20> 
                </LI>
                <LI><IMG height=57 src="cyberpoll_files/bg_graph.gif" width=20> 
                </LI>
                <LI><IMG height=25 src="cyberpoll_files/bg_graph.gif" width=20> 
                </LI>
                <LI><IMG height=1 src="cyberpoll_files/bg_graph.gif" width=20> 
                </LI>
                <LI><IMG height=0 src="cyberpoll_files/bg_graph.gif" width=20> 
                </LI></UL>
              <LI class=no>
              <UL class=txtset>
                <LI><IMG src="cyberpoll_files/no1.gif"> </LI>
                <LI><IMG src="cyberpoll_files/no2.gif"> </LI>
                <LI><IMG src="cyberpoll_files/no3.gif"> </LI>
                <LI><IMG src="cyberpoll_files/no4.gif"> </LI>
                <LI><IMG src="cyberpoll_files/no5.gif"> </LI></UL></LI></UL></TD></TR>
        <TR>
          <TD style="HEIGHT: 30px">2</TD>
          <TD>대체로 만족</TD>
          <TD>3489</TD>
          <TD>57.13 %</TD></TR>
        <TR>
          <TD style="HEIGHT: 30px">3</TD>
          <TD>보통</TD>
          <TD>1570</TD>
          <TD>25.70 %</TD></TR>
        <TR>
          <TD style="HEIGHT: 30px">4</TD>
          <TD>불만족</TD>
          <TD>88</TD>
          <TD>1.44 %</TD></TR>
        <TR>
          <TD style="HEIGHT: 30px">5</TD>
          <TD>매우 불만족</TD>
          <TD>6</TD>
          <TD>0.11 %</TD></TR></TBODY></TABLE>
      <DIV class=space01></DIV>
