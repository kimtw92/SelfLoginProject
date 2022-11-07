/* Start of AIScript.js
   Version 2.1 by ActiveIntra Co., Ltd.(Kim S.Y)
*/

/* 
  . AIViewer를 사용하는 웹페이지에 포함되어야 하는 JavaScript화일
  . 아래의 경우를 제외하고는 본 화일을 임의로 수정할 수 없음
    1. 뷰어모듈을 배치하는 웹서버경로를 변경시 아래 tagAIGeneratorOcx변수의
       codebase값을 그 배치경로로 변경
       
       * codebase에 사용가능한 URL형식
         (1)절대경로 (http:// ~)
         (2)상대경로
            /path         (웹서버의 document root)
            ./path        (하위에 .나 ..의 중복사용불가)
            path/sub_path (하위에 .나 ..의 중복사용불가)
       
    2. 뷰어모듈을 AIGenerator(OCX)와 다른 경로에 배치하는 경우 아래
       tagAIGeneratorOcx변수의 resource_base값을 변경후 주석해제
    3. 업그레이드 된 AIGenerator(OCX)를 새로 배치한 경우 아래 tagAIGeneratorOcx변수의
       Version값을 새로운 버전번호로 수정

*/


    /* AIViewer를 embed할 html의 frame 이름 */
    var target_frame = null; // Don't remove
    /* AIViewer의 실행옵션의 설정에 사용 */
    var params = null; // Don't remove
    /* AIViewer가 내부적으로 사용 */
    var embedParams = ""; // Don't remove

    var tagAIGeneratorOcx = 
        "<object id='AIGenerator' classid='CLSID:78530AB7-7AC1-48E6-961E-A8D4EED52BAA' width='0' height='0'\n" +
        "  codebase='http://localhost:8080/AIViewer/AIGeneratorOcx.cab#Version=1,1,0,5'>\n" +
//        "  codebase='http://152.99.42.130/AIViewer/AIGeneratorOcx.cab#Version=1,1,0,5'>\n" +
        //"   <param name='resource_base' value='http://myserver/AIViewer_path/'>\n" +
        //"   <param name='msg_color' value='(255,255,255)/(0,0,0)'>\n" +                   // 색상 => 배경색/폰트색 
        "</object>";
    
    var tagAIViewer =
        "<table align='center' width='90%' height='90%' border='0' bgcolor='#002233'>\n" +
        "<tr>\n" +
        "  <td>\n" +
        "  <object id='AIViewer' classid='CLSID:3B7D47C0-FE3B-11D6-97B4-005022200F17'\n" +
        "    bgcolor='#FFFFFF' width='100%' height='100%' standby='Loading AIViewer...'>\n" +
        "  </object>\n" +
        "  </td>\n" +
        "</tr>\n" +
        "</table>";

     
    /* 
      AIViewer를 HTML의 특정Frame에 동적으로 embed할 때 호출하는 함수
        @param  target  - AIViewer를 embed할 frame명
        @param  cgi_url - AIViewer가 호출할 출력프로그램의 URL
    */ 
    function embedAI(target, cgi_url) {
        if (document.AIGenerator.object == null) {
            alert("보안설정문제로 AIViewer (출력프로그램) 를 설치할 수 없습니다 !\n웹브라우저를 다시 시작한 후 보안경고창에서 [예]를 선택해 주세요.");
            return;
        }
        
        target_frame = target;
        if (params != null) document.AIGenerator.setParams(params);
        document.AIGenerator.setViewerType("embed");
        document.AIGenerator.setEmbedType("ocx");
        document.AIGenerator.view(cgi_url);
        params = null;
    }

    /*
      별도의 팝업윈도우로 AIViewer를 호출하는 함수
        @param  cgi_url - AIViewer가 호출할 출력프로그램의 URL
    */  
    function popAI(cgi_url) {
        if (document.AIGenerator.object == null) {
            alert("보안설정문제로 AIViewer (출력프로그램) 를 설치할 수 없습니다 !\n웹브라우저를 다시 시작한 후 보안경고창에서 [예]를 선택해 주세요.");
            return;
        }
        
        if (params != null) document.AIGenerator.setParams(params);
        document.AIGenerator.setViewerType("stand_alone");
        document.AIGenerator.view(cgi_url);
        params = null;
    }
    
    /* 
      HTML페이지에 정적으로 포함된 AIViewer(OCX)를 통해 보고서를 반복적으로 처리하는 경우에 사용하는 함수
        @param  target  - AIViewer가 embed된 frame명
        @param  cgi_url - AIViewer가 호출할 출력프로그램의 URL
    */ 
    function loadReport(target, cgi_url) {
        if (document.AIGenerator.object == null) {
            alert("보안설정문제로 AIViewer (출력프로그램) 를 설치할 수 없습니다 !\n웹브라우저를 다시 시작한 후 보안경고창에서 [예]를 선택해 주세요.");
            return;
        }
        
        target_frame = target;
        if (params != null) document.AIGenerator.setParams(params);
        document.AIGenerator.setViewerType("embed");
        document.AIGenerator.setEmbedType("ocx2");
        document.AIGenerator.view(cgi_url);
        params = null;
    }

    /*
      AIViewer Control을 HTML에 embed하는 함수로 AIViewer가 내부적으로 사용함
    */
    function run() {
        if (target_frame == null) target_frame = "self";
        var win = eval(target_frame);
    
        win.document.open();
        
        win.document.writeln("<html>");
        win.document.writeln("<head>");
        win.document.writeln("<meta http-equiv='Content-Type' content='text/html; charset=euc-kr'>");
        win.document.writeln("<title>AI뷰어</title>");
        win.document.writeln("</head>");
        win.document.writeln("<body scroll='no' leftmargin='0' topmargin='0' marginwidth='0' marginheight='0'>");
        win.document.writeln("<table align='center' width='100%' height='100%' border='0' bgcolor='#FFFFFF'>");
        //win.document.writeln("<body>");
        //win.document.writeln("<table align='center' width='90%' height='100%' border='0' bgcolor='#002233'>");
        win.document.writeln("<tr>");
        win.document.writeln("  <td>");
        win.document.writeln("  <object id='AIViewer' classid='CLSID:3B7D47C0-FE3B-11D6-97B4-005022200F17'");
        win.document.writeln("          bgcolor='#FFFFFF' width='100%' height='100%' standby='Loading AIViewer...'>");
        win.document.writeln(embedParams);
        //win.document.writeln("<param name='ctl_control' value='(255,255,255)/(0,0,0)/(0,0,0)/(255,255,255)'>");  /* 색상 => 전체외곽선색/용지위선색/용지아래선색/배경색 */
        win.document.writeln("  </object>");
        win.document.writeln("  </td>");
        win.document.writeln("</tr>");
        win.document.writeln("</table>");
        win.document.writeln("</body>");
        win.document.writeln("</html>");

        win.document.close();
    }
    
    // Don't edit or remove
    function runOcx() {
        if (target_frame == null) target_frame = "self";
        var win = eval(target_frame);
        win.document.AIViewer.setParams(embedParams);
        win.document.AIViewer.run();
    }
    
    // Don't edit or remove
    function setParams(options) {
        params = options;
    }
    
    // Don't edit or remove
    function setEmbedParams(options) {
        embedParams = options;
    }
    
/* End of AIScript.js */