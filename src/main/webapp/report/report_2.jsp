<%
/* ### Generated by AIDesigner 3.7.1.22 ### */
%>

<%@ page language="java" import="java.sql.*,java.io.*,java.text.*" %>
<%@ page contentType="text/plain; charset=euc-kr" %>

<%
Object[] userObj = null;
ReportHandler handler = new ReportHandler(request,response,userObj);
handler.service(out);
%>

<%!
class ReportHandler{
	//공통 변수 선언
	private Object[] userObj = null;
	private int nStartPage;		//각 쉬트별 시작 페이지 저장
	private int nMaxPage;		//한 쉬트가 실행된 후 생성된 최대 페이지 번호 저장
	private int nPageNum;		//현재 페이지 번호
	private int nYStartPos;		//쉬트에서 Y 시작 좌표
	private int nYEndPos;		//쉬트에서 Y 끝 좌표
	private int nYCurPos;		//현재 Y 좌표
	private int nYSavePos;		//연결된 멀티 프레임 쉬트에서 시작 Y 좌표 저장
	private int nYLastPos;		//연결된 멀티 프레임 쉬트에서 각 프레임의 마지막 Y 좌표 저장
	private int nXStartPos;		//쉬트에서 X 시작 좌표
	private int nXEndPos;		//쉬트에서 X 끝 좌표
	private int nXCurPos;		//현재 X 좌표
	private int nXSavePos;		//연결된 멀티 프레임 쉬트에서 시작 X 좌표 저장
	private int  nXLastPos;		//연결된 멀티 프레임 쉬트에서 각 프레임의 마지막 X 좌표 저장
	private boolean bIsBeforePageSkip;		//조건 밴드에서 페이지 넘기기 여부 판단
	private int nLoopRef;		//절대 양식에서 루프 참조 변수
	private String isEmpty="";		//빈 문자열 비교에 사용

	private HttpServletRequest request;
	private HttpServletResponse response;
	private JspWriter out;

	//-----데이터 변수 선언-----
	String sheet10_A1;
	String sheet10_A2;
	int[] nAutoHeight_quest=new int[1];
	long sheet10_B3;
	String sheet10_C3;
	int[] nAutoHeight_ans=new int[1];
	String sheet10_B4;
	String sheet10_C4;

	//-----Connection, Statement, ResultSet 객체 선언-----
	private Connection conn_DUNET;		//DSN DUNET Connection 객체
	private java.sql.Statement stat_category;		//ResultSet category 객체를 생성하기 위한 Statement 객체
	private ResultSet category;		//ResultSet category 객체
	private java.sql.Statement stat_quest;		//ResultSet quest 객체를 생성하기 위한 Statement 객체
	private ResultSet quest;		//ResultSet quest 객체
	private java.sql.Statement stat_ans;		//ResultSet ans 객체를 생성하기 위한 Statement 객체
	private ResultSet ans;		//ResultSet ans 객체

	//-----SQL 변수 선언-----
	private String sql_category;		//ResultSet category 객체를 생성하기 위한 쿼리문 저장
	private String sql_quest;		//ResultSet quest 객체를 생성하기 위한 쿼리문 저장
	private String sql_ans;		//ResultSet ans 객체를 생성하기 위한 쿼리문 저장

	//-----쿼리 필드 변수 선언-----
	//ResultSet category 객체에서 필드 값을 받는 쿼리 필드 변수
	private String category_CATEGORY;

	//ResultSet quest 객체에서 필드 값을 받는 쿼리 필드 변수
	private double quest_NO;
	private String quest_REGDATE;
	private String quest_USERNO;
	private String quest_NAME;
	private double quest_DEPTH;
	private double quest_REF_NO;
	private String quest_TITLE;
	private String quest_CATEGORY;
	private String quest_COUNT;
	private String quest_CONTENT;

	//ResultSet ans 객체에서 필드 값을 받는 쿼리 필드 변수
	private String ans_CONTENT;

	//파라미터 변수 선언
	String p_grcode_Param;
	String p_grseq_Param;

	//-----사용자 정의 변수 및 함수-----
	private String removeHtmlTag(String srcText) {
		//대체(치환)하고 하는 문자열이 더 있는 경우 아래의 배열에 쌍으로 추가
		String[] relSrc = {"&NBSP;", "&lt;", "&gt;", "&amp;", "&quot;"};
		String[] relTgt = {" ", "<", ">", "&", "\"" };

		int pointer = 0, st = 0, ed = 0;
		int size = srcText.length();
		StringBuffer buf = new StringBuffer(size);

		while (st != -1) {
			st = srcText.indexOf("<", st);
			if (st != -1) {
				ed = srcText.indexOf(">", st+1);
				if (ed == -1) {
					break;
				}
				buf.append(srcText.substring(pointer, st));
				pointer = st = ed + 1;
			}
		}
		if (pointer < size) {
			buf.append(srcText.substring(pointer));
		}

		srcText = buf.toString();
		// 특수문자열의 대체가 불필요한 경우 아래의 for 문을 주석처리 가능
		for (int i = 0; i < relSrc.length; i++) {
			pointer = st = 0;
			if (srcText.indexOf(relSrc[i], pointer) == -1) continue;

			buf.setLength(0);
			size = srcText.length();
			int len = relSrc[i].length();

			while ((pointer = srcText.indexOf(relSrc[i], pointer)) != -1) {
				buf.append(srcText.substring(st, pointer));
				buf.append(relTgt[i]);
				pointer += len;
				st = pointer;
			}
			if (st < size) {
				buf.append(srcText.substring(st));
			}
			srcText = buf.toString();
		}

		return srcText;
	}


	//ReportHandler 생성자 함수
	ReportHandler(HttpServletRequest request,HttpServletResponse response,Object[] userObj){
		this.request=request;
		this.response=response;
		this.userObj=userObj;
	}

	//ReportHandler 서비스 함수
	void service(JspWriter out) throws Exception{
		try{    //try 구문
			this.out=out;
			nMaxPage=0;    //nMaxPage 초기화

			//스크립트 헤더 함수 호출
			getScriptHeader("A4", "2100x2970", "9", "VERTICAL");

			//파라미터 설정 함수 호출
			setParam();

			//고정 데이터 초기화 함수 호출
			initConstVarient();

			//Connection 및 Statement 객체 생성 함수 호출
			createConnAndStateObject();

			//쿼리문 초기화 함수 호출
			initSQLConst();

			//쉬트 함수 호출
			//SHEET=Sheet1   FRAME=0 함수 호출
			executeSheet10();

			//---------------스크립트 종료---------------
			out.print("--SCRIPT_END--\r");
		}catch(Exception e){    //catch 구문
			out.print(e);
			out.print("AI!REPORT JSP ERROR!!!!\r");
		}finally{    //finally 구문
			try{    //finally try 구문
				//DataSet Close
				if(stat_ans!=null) stat_ans.close();
				if(stat_quest!=null) stat_quest.close();
				if(category!=null) category.close();
				if(stat_category!=null) stat_category.close();
				if(conn_DUNET!=null) conn_DUNET.close();
			}catch(Exception e){    //finally catch 구문
			}    //end finally try
		}    //end try
	}

	//-----쉬트 함수-----
	//-----SHEET=Sheet1   FRAME=Frame0 Start
	//-----폼 형식 : 상대 양식
	private void executeSheet10( ) throws Exception{
		//쉬트 초기화 함수 호출
		initSheetVariant(41, 72, 546, 801, true);

		//시작 페이지 번호 출력
		out.print("-- " + nPageNum + " PAGE --\r");

		//밴드 함수 호출
		getScriptFromtitle(true, true);    //머리글 밴드 호출
		getScriptFromcategory(true);    //반복 밴드 호출

		//페이지 및 좌표 설정
		nMaxPage=(int)MAX((long)nMaxPage, (long)nPageNum);    //생성된 최대 페이지 번호 구하기
	}

	//-----밴드 함수-----
	//----title HeaderBand Start----
	//----소속 쉬트 : SHEET=Sheet1    FRAME=Frame0
	//----밴드 이름 : title
	//----밴드 종류 : 머리글 밴드
	//----bIsFrist : 쉬트 함수에서 최초로 호출될 때 true, 페이지 스킵 함수에서 호출될 때 false
	//----bIsPrint : 감추기 속성 설정 여부. treu면 출력, false면 AI 스크립트를 생성하지 않음.
	private void getScriptFromtitle(boolean bIsFirst, boolean bIsPrint) throws Exception{
		if(bIsFirst){   //밴드 최초 호출 시에만 실행되는 코드
		}   //end if(bIsFirst)

		//AI 스크립트 출력
		if(bIsPrint){   //감추기 속성이 지정되지 않으면 bIsPrint는 true
			//스크립트 출력 함수 호출
			writeScripttitle();
		}   //end if(bIsPrint)
	}

	//-----ans RepeatBand Start-----
	//-----소속 쉬트 : SHEET=Sheet1   FRAME=Frame0
	//-----밴드 이름 : ans
	//-----밴드 종류 : 반복 밴드
	//-----bIsPrint : 감추기 속성 설정 여부 true면 출력, false면 스크립트를 생성하지 않음
	private void getScriptFromans(boolean bIsPrint) throws Exception{
		//지역 변수 선언 및 초기화
		int nBandHeight=20;    //밴드 출력 높이
		boolean bIsFirst=true;
		//폰트명 : 굴림체
		//폰트 사이즈 : 11
		//각 문자별 폭을 할당할 배열 선언
		int[] charWidth = {6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,12};

		//데이터 변수 초기화
		sheet10_C4="";

		//DataSet 객체 생성
		//ResultSet ans 객체의 생성
		initSQLansVarient();
		ans = stat_ans.executeQuery(sql_ans);

		while(ans.next()){   //자동으로 생성되는 반복 밴드의 루프문
			//데이터 fetch
			setFieldVariableFromans();	//RecordSet ans에서 필드 값 설정

			if(bIsFirst){   //밴드 호출 후 루프 내에서 한번 만 실행되는 코드
			}   //end if(bIsFirst)

			//데이터 변수 할당
			sheet10_C4=ans_CONTENT;

			//Auto Size Code
			nAutoHeight_ans[0]=0;
			nAutoHeight_ans[0]=getPrintHeight(sheet10_C4, charWidth, 11, 458, 20, nAutoHeight_ans[0]);
			nAutoHeight_ans[0]=nAutoHeight_ans[0]+20;
			nBandHeight=nAutoHeight_ans[0];   //밴드 출력 높이 설정

			//AI 스크립트 출력
			if(bIsPrint){   //감추기 속성이 지정되지 않으면 bIsPrint는 true
				if(isPageSkip(nYCurPos+nBandHeight)){   //스크립트 출력 영역 검사
					//페이지 스킵 함수 호출
					pageSkip(10);
				}   //end if(page skip test)

				//스크립트 출력 함수 호출
				writeScriptans();

				//다음 출력 좌표 설정
				nYCurPos=nYCurPos+nBandHeight;
			}   //end if(bIsPrint)

			//bIsFirst 및 출력 라인 설정
			bIsFirst=false;
		}   //while end

		//DataSet Close
		if(ans!=null) ans.close();
	}

	//-----quest RepeatBand Start-----
	//-----소속 쉬트 : SHEET=Sheet1   FRAME=Frame0
	//-----밴드 이름 : quest
	//-----밴드 종류 : 반복 밴드
	//-----bIsPrint : 감추기 속성 설정 여부 true면 출력, false면 스크립트를 생성하지 않음
	private void getScriptFromquest(boolean bIsPrint) throws Exception{
		//지역 변수 선언 및 초기화
		int nBandHeight=20;    //밴드 출력 높이
		boolean bIsFirst=true;
		//폰트명 : 굴림체
		//폰트 사이즈 : 11
		//각 문자별 폭을 할당할 배열 선언
		int[] charWidth = {6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,12};

		//데이터 변수 초기화
		sheet10_B3=0L;
		sheet10_C3="";

		//DataSet 객체 생성
		//ResultSet quest 객체의 생성
		initSQLquestVarient();
		quest = stat_quest.executeQuery(sql_quest);

		while(quest.next()){   //자동으로 생성되는 반복 밴드의 루프문
			//데이터 fetch
			setFieldVariableFromquest();	//RecordSet quest에서 필드 값 설정

			if(bIsFirst){   //밴드 호출 후 루프 내에서 한번 만 실행되는 코드
			}   //end if(bIsFirst)

			//데이터 변수 할당
			sheet10_B3=COUNT(sheet10_B3);
			sheet10_C3=quest_CONTENT;

			//Auto Size Code
			nAutoHeight_quest[0]=0;
			nAutoHeight_quest[0]=getPrintHeight(sheet10_C3, charWidth, 11, 458, 20, nAutoHeight_quest[0]);
			nAutoHeight_quest[0]=nAutoHeight_quest[0]+20;
			nBandHeight=nAutoHeight_quest[0];   //밴드 출력 높이 설정

			//AI 스크립트 출력
			if(bIsPrint){   //감추기 속성이 지정되지 않으면 bIsPrint는 true
				if(isPageSkip(nYCurPos+nBandHeight)){   //스크립트 출력 영역 검사
					//페이지 스킵 함수 호출
					pageSkip(10);
				}   //end if(page skip test)

				//스크립트 출력 함수 호출
				writeScriptquest();

				//다음 출력 좌표 설정
				nYCurPos=nYCurPos+nBandHeight;
			}   //end if(bIsPrint)

			//루프 내부 자식 밴드 호출
			getScriptFromans(true);

			//bIsFirst 및 출력 라인 설정
			bIsFirst=false;
		}   //while end

		//DataSet Close
		if(quest!=null) quest.close();
	}

	//-----category RepeatBand Start-----
	//-----소속 쉬트 : SHEET=Sheet1   FRAME=Frame0
	//-----밴드 이름 : category
	//-----밴드 종류 : 반복 밴드
	//-----bIsPrint : 감추기 속성 설정 여부 true면 출력, false면 스크립트를 생성하지 않음
	private void getScriptFromcategory(boolean bIsPrint) throws Exception{
		//지역 변수 선언 및 초기화
		int nBandHeight=20;    //밴드 출력 높이
		boolean bIsFirst=true;

		//데이터 변수 초기화
		sheet10_A2="";

		//DataSet 객체 생성
		//ResultSet category 객체의 생성
		if(category==null){
			category = stat_category.executeQuery(sql_category);
		}else{
			category.beforeFirst();
		}

		while(category.next()){   //자동으로 생성되는 반복 밴드의 루프문
			//데이터 fetch
			setFieldVariableFromcategory();	//RecordSet category에서 필드 값 설정

			if(bIsFirst){   //밴드 호출 후 루프 내에서 한번 만 실행되는 코드
			}   //end if(bIsFirst)

			//데이터 변수 할당
			sheet10_A2=category_CATEGORY;

			//AI 스크립트 출력
			if(bIsPrint){   //감추기 속성이 지정되지 않으면 bIsPrint는 true
				if(isPageSkip(nYCurPos+nBandHeight)){   //스크립트 출력 영역 검사
					//페이지 스킵 함수 호출
					pageSkip(10);
				}   //end if(page skip test)

				//스크립트 출력 함수 호출
				writeScriptcategory();

				//다음 출력 좌표 설정
				nYCurPos=nYCurPos+nBandHeight;
			}   //end if(bIsPrint)

			//루프 내부 자식 밴드 호출
			getScriptFromquest(true);

			//bIsFirst 및 출력 라인 설정
			bIsFirst=false;
		}   //while end
	}

	//-----스크립트 출력 함수-----
	//----title 스크립트 문 출력 함수----
	private void writeScripttitle( ) throws Exception{
		//스크립트문 생성
		out.print("^PRINT(41,41,504,0,14,0/,굴림체,RGB[0,0,0],BOLD, , ,NONE,31,1)");
		out.println(sheet10_A1+"\r");
	}

	//----ans 스크립트 문 출력 함수----
	private void writeScriptans( ) throws Exception{
		//스크립트문 생성
		out.print("^PRINT("+(nXCurPos+23)+","+(nYCurPos)+",23,1,11,0/,굴림체,RGB[0,0,0], , , ,NONE,"+(nAutoHeight_ans[0])+",1)");
		out.println(sheet10_B4+"\r");
		out.print("^PRINT("+(nXCurPos+46)+","+(nYCurPos)+",458,0,11,0/,굴림체,RGB[0,0,0], , , ,XL,"+(nAutoHeight_ans[0])+",1)");
		out.println(sheet10_C4+"\r");
	}

	//----quest 스크립트 문 출력 함수----
	private void writeScriptquest( ) throws Exception{
		//스크립트문 생성
		out.print("^PRINT("+(nXCurPos+23)+","+(nYCurPos)+",23,0,11,5/###,### \") \"*,굴림체,RGB[0,0,0], , , ,NONE,"+(nAutoHeight_quest[0])+",1)");
		out.println(sheet10_B3+"\r");
		out.print("^PRINT("+(nXCurPos+46)+","+(nYCurPos)+",458,0,11,0/,굴림체,RGB[0,0,0], , , ,XL,"+(nAutoHeight_quest[0])+",1)");
		out.println(sheet10_C3+"\r");
	}

	//----category 스크립트 문 출력 함수----
	private void writeScriptcategory( ) throws Exception{
		//스크립트문 생성
		out.print("^PRINT("+(nXCurPos)+","+(nYCurPos)+",504,0,11,0/,굴림체,RGB[0,0,0], , , ,NONE,20,1)");
		out.println(sheet10_A2+"\r");
	}

	//파라미터 설정 함수
	private void setParam(){
		p_grcode_Param=toKor(GetB(request.getParameter("p_grcode")));
		p_grseq_Param=toKor(GetB(request.getParameter("p_grseq")));
	}

	//-----Connection 및 Statement 객체 생성 함수-----
	private void createConnAndStateObject() throws Exception{
		//DUNET Connection 객체 생성
		Class.forName("oracle.jdbc.driver.OracleDriver").newInstance();
		conn_DUNET=DriverManager.getConnection("jdbc:oracle:thin:@(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=192.168.12.203)(PORT=1521))(ADDRESS=(PROTOCOL=TCP)(HOST=192.168.12.204)(PORT=1521))(FAILOVER=on)(LOAD_BALANCE=off))(CONNECT_DATA=(SERVER=DEDICATED)(SERVICE_NAME=LOTI)))","inchlms","fhxl21");stat_category=conn_DUNET.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
		stat_quest=conn_DUNET.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
		stat_ans=conn_DUNET.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
	}

	//-----SQL문 변수 초기화 함수-----
	private void initSQLConst(){
		sql_category = "SELECT DISTINCT CATEGORY  ";
		sql_category = sql_category + "FROM TB_GRSUGGESTION  ";
		sql_category = sql_category + "WHERE FINISH_YN = 'Y'";
	}

	private void initSQLquestVarient(){
		sql_quest = "SELECT NO, REGDATE, USERNO, NAME ";
		sql_quest = sql_quest + "     , DEPTH, REF_NO, TITLE,  CATEGORY ";
		sql_quest = sql_quest + "     , NO || ') ' AS COUNT ";
		sql_quest = sql_quest + "     , nvl(to_char(upper(dbms_lob.substr(content, 4000,1))),'') AS CONTENT ";
		sql_quest = sql_quest + "FROM TB_GRSUGGESTION ";
		sql_quest = sql_quest + "WHERE GRCODE = '" + p_grcode_Param + "' ";
		sql_quest = sql_quest + "AND GRSEQ = '" + p_grseq_Param + "' ";
		sql_quest = sql_quest + "AND DEPTH=0 ";
		sql_quest = sql_quest + "AND CATEGORY='" + category_CATEGORY + "'  ";
		sql_quest = sql_quest + "ORDER BY NO";
	}

	private void initSQLansVarient(){
		sql_ans = "SELECT nvl(to_char(upper(dbms_lob.substr(content, 4000,1))),'') AS CONTENT   ";
		sql_ans = sql_ans + "FROM TB_GRSUGGESTION    ";
		sql_ans = sql_ans + "WHERE GRCODE = '" + p_grcode_Param + "'    ";
		sql_ans = sql_ans + "AND GRSEQ       = '" + p_grseq_Param + "'    ";
		sql_ans = sql_ans + "AND DEPTH        = 1   ";
		sql_ans = sql_ans + "AND REF_NO     = " + quest_NO + "";
	}

	//-----ResultSet 객체에서 필드 값 설정 함수-----
	//ResultSet category 객체에서 필드 값 설정 함수
	private void setFieldVariableFromcategory() throws Exception{
		category_CATEGORY=GetB(category.getString(1));
	}

	//ResultSet category 객체의 필드 값 초기화 함수
	private void setFieldInitFromcategory(){
		category_CATEGORY="";
	}

	//ResultSet quest 객체에서 필드 값 설정 함수
	private void setFieldVariableFromquest() throws Exception{
		quest_NO=quest.getDouble(1);
		quest_REGDATE=GetB(quest.getString(2));
		quest_USERNO=GetB(quest.getString(3));
		quest_NAME=GetB(quest.getString(4));
		quest_DEPTH=quest.getDouble(5);
		quest_REF_NO=quest.getDouble(6);
		quest_TITLE=GetB(quest.getString(7));
		quest_CATEGORY=GetB(quest.getString(8));
		quest_COUNT=GetB(quest.getString(9));
		//quest_CONTENT=GetB(quest.getString(10));
		quest_CONTENT= removeHtmlTag(quest.getString(10).replaceAll("'"," ")) ;
	}

	//ResultSet quest 객체의 필드 값 초기화 함수
	private void setFieldInitFromquest(){
		quest_NO=0;
		quest_REGDATE="";
		quest_USERNO="";
		quest_NAME="";
		quest_DEPTH=0;
		quest_REF_NO=0;
		quest_TITLE="";
		quest_CATEGORY="";
		quest_COUNT="";
		quest_CONTENT="";
	}

	//ResultSet ans 객체에서 필드 값 설정 함수
	private void setFieldVariableFromans() throws Exception{
		//ans_CONTENT=GetB(ans.getString(1));
		ans_CONTENT= removeHtmlTag(ans.getString(1).replaceAll("'"," "));
	}

	//ResultSet ans 객체의 필드 값 초기화 함수
	private void setFieldInitFromans(){
		ans_CONTENT="";
	}

	//-----고정 데이터 초기화 함수-----
	private void initConstVarient(){
		sheet10_A1="기타건의사항";
		sheet10_B4="→";
	}

	//-----페이지 스킵 관련 함수-----
	//페이지 스킵시 호출되는 함수로서 페이지 번호를 증가시키고 페이지 지시문 출력 그리고 Y좌표 초기화
	//매개변수에 따라 해당 쉬트의 배경 이미지, 머리글 밴드, 바닥글 밴드 함수 호출
	private void pageSkip(int nIndex) throws Exception{
		nXCurPos=nXStartPos;
		nYCurPos=nYStartPos;
		nPageNum=nPageNum+1;
		out.print("-- " + nPageNum + " PAGE --\r");

		switch(nIndex){
			case 10:		//SHEET=Sheet=1   FRAME=0에서 페이지 스킵시
			getScriptFromtitle(false, true);		//머리글 밴드 호출
			break;
		}
	}

	//페이지 스킵이 필요한지 검사하는 함수
	private boolean isPageSkip(int nTestPos){
		if(nTestPos>nYEndPos){
			return true;
		}else{
			return false;
		}
	}

	//-----공통 함수 선언-----
	private void getScriptHeader(String paper, String size, String value, String orient) throws Exception{
		out.print("--SCRIPT_START31--\r");
		out.print("PAPER=" + paper + "\r");
		out.print("PAPER_SIZE=" + size + "\r");
		out.print("PAPER_SETTING_VALUE=" + value + "\r");
		out.print("ORIENTATION=" + orient + "\r");
	}

	private void getSheetPaperInfo(String paper, String size, String value, String orient) throws Exception{
		out.print("--PAPER_INFO--\r");
		out.print("PAPER=" + paper + "\r");
		out.print("PAPER_SIZE=" + size + "\r");
		out.print("PAPER_SETTING_VALUE=" + value + "\r");
		out.print("ORIENTATION=" + orient + "\r");
	}

	private void initSheetVariant(int constStartX, int constStartY, int constEndX, int constEndY, boolean bFirstFrame){
		if(bFirstFrame){
			nStartPage=nMaxPage+1;
			nYLastPos=0;
		}
		nPageNum=nStartPage;
		nYStartPos=constStartY;
		nYEndPos=constEndY;
		nYCurPos=nYStartPos;
		nXStartPos=constStartX;
		nXEndPos=constEndX;
		nXCurPos=nXStartPos;
	}

	private void initChildSheetVariant(int constStartX, int constStartY, int constEndX, int constEndY, boolean bIsMultiFrame, boolean bIsFirstFrame){
		nXStartPos=constStartX;
		nXEndPos=constEndX;
		nXCurPos=nXStartPos;
		nYStartPos=constStartY;
		nYEndPos=constEndY;

		if(bIsMultiFrame){
			if(bIsFirstFrame){
				nStartPage=nPageNum;
				nYSavePos=nYCurPos;
				nYLastPos=0;
			}else{
				nPageNum=nStartPage;
				nYCurPos=nYSavePos;
			}
		}else{
			nStartPage=nPageNum;
		}
	}

	//Empty Row만으로 구성되어 출력 위치를 조정하기 위한 VoidBand 함수
	//nRangePos - VoidBand의 출력 영역
	//nIndex - PageSkip 함수 호출시 전달할 쉬트 인덱스
	private boolean voidBandNoneData(int nRangePos, int nIndex) throws Exception{
		int nTestPos;
		nTestPos=nYCurPos+nRangePos;
		if(isPageSkip(nTestPos)){
			pageSkip(nIndex);
			return true;
		}else{
			nYCurPos=nYCurPos+nRangePos;
			return false;
		}
	}

	private String Get0(String str){
		if(str==null){
			return "0";
		}else{
			if(str.equals("")){
				return "0";
			}else{
				return str;
			}
		}
	}

	private String GetB(String str){
		if(str==null){
			return "";
		}else{
			return str;
		}
	}

	private double SUM(double accVal, double tmpVal){
		return(accVal+tmpVal);
	}

	private double SUM(double accVal, long tmpVal){
		return(accVal+(double)tmpVal);
	}

	private long SUM(long accVal, long tmpVal){
		return(accVal+tmpVal);
	}

	private double SUM(long accVal, double tmpVal){
		return((double)accVal+tmpVal);
	}

	private long COUNT(long accuCNT){
		return ++accuCNT;
	}

	private long MIN(long maxV, long maxTempV){
		if(maxV<=maxTempV){return maxV;}
		else{return maxTempV;}
	}

	private double MIN(long maxV, double maxTempV){
		if((double)maxV<=maxTempV){return (double)maxV;}
		else{return maxTempV;}
	}

	private double MIN(double maxV, double maxTempV){
		if(maxV<=maxTempV){return maxV;}
		else{return maxTempV;}
	}

	private double MIN(double maxV, long maxTempV){
		if(maxV<=maxTempV){return maxV;}
		else{return (double)maxTempV;}
	}
	private long MAX(long maxV, long maxTempV){
		if(maxV>=maxTempV){return maxV;}
		else{return maxTempV;}
	}

	private double MAX(long maxV, double maxTempV){
		if((double)maxV>=maxTempV){return (double)maxV;}
		else{return maxTempV;}
	}

	private double MAX(double maxV, double maxTempV){
		if(maxV>=maxTempV){return maxV;}
		else{return maxTempV;}
	}

	private double MAX(double maxV, long maxTempV){
		if(maxV>=maxTempV){return maxV;}
		else{return (double)maxTempV;}
	}

	private double AVG(double sumVal, long cntVal){
		return(sumVal/cntVal);
	}

	private double AVG(long sumVal, long cntVal){
		return((double)sumVal/(double)cntVal);
	}

	private String aiReplace(String strAll, String strSrc, String strDest) {
		while(strAll.indexOf(strSrc) != -1) {
			strAll = strAll.substring(0, strAll.indexOf(strSrc)) + strDest + strAll.substring(strAll.indexOf(strSrc) + strSrc.length(), strAll.length());
		}
		return strAll;
	}

	private String toDate() {
		SimpleDateFormat dateFormat=new SimpleDateFormat("'#SERVERDATE#'yyyy/MM/dd/HH/mm/ss");
		java.util.Date currentDate = new java.util.Date();
		return dateFormat.format(currentDate);
	}

	final String toKor (String en){
		if(en==null){
			return "";
		}
		try{
			return new String(en.getBytes("8859_1"), "KSC5601");
		}catch(Exception e){return en;}
	}
	//문자의 폭을 조사하여 데이터의 출력 높이를 자동적으로 조정하는 함수
	private int getPrintHeight(String data, int[] charWidth, int fontSize, int cellWidth, int cellHeight, int nMaxHeight){
		int ch;
		int len = 95;
		int width = 0;
		int asciiWidth = 0;
		int linePitch = (int)(fontSize*1.4);
		int height = linePitch;
		int size = data.length();
		cellWidth = cellWidth-4;
		for (int i = 0; i < size; i++) {
			ch = data.charAt(i);

			if(ch<32 && !(ch==10 || ch==20 || ch==13)){
				continue;
			}

			if(ch>0x7F){
				width += asciiWidth;

				if (width > cellWidth) {
					width = asciiWidth;
					height += linePitch;
				}
				asciiWidth = 0;

				width += charWidth[len];
				if (width > cellWidth) {
					width = charWidth[len];
					height += linePitch;
				}
			} else if (ch==10 || ch==20) {
				width = 0;
				asciiWidth = 0;
				height += linePitch;
			} else if (ch==13) {
				width = 0;
				asciiWidth = 0;
				height += linePitch;
				if ((i != size-1) && (10 == (int)data.charAt(i+1))) {
					i++;
				}
			} else {
				if ((ch>64 && ch<91) || (ch>96 && ch<123)) {
					asciiWidth += charWidth[ch-32];
					if (i==size-1){
						width = width + asciiWidth;
						if (width>cellWidth){
							height += linePitch;
						}
					}
				} else {
					width += asciiWidth;

					if (width > cellWidth) {
						width = asciiWidth;
						height += linePitch;
					}

					asciiWidth = 0;

					width += charWidth[ch-32];
					if (width > cellWidth) {
						width = charWidth[ch-32];
						height += linePitch;
					}
				}
			}
		}

		if (height>cellHeight) {
			height=height-cellHeight;
		}else{
			height=0;
		}

		height = (int)MAX((long)height,(long)nMaxHeight);
		return height;
	}
}
%>
