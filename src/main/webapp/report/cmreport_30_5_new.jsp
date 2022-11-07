<%
/* ### Generated by AIDesigner 3.7.1.23 ### */
%>

<%@ page language="java" import="java.sql.*,java.io.*,java.text.*,java.util.*" %>
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
	String sheet10_J1;
	String sheet10_A2;
	String sheet10_A6;
	String sheet10_A3;
	String sheet10_B3;
	String sheet10_C3;
	String sheet10_D3;
	String sheet10_E3;
	String sheet10_F3;
	String sheet10_G3;
	String sheet10_C4;
	String sheet10_D4;
	String sheet10_E4;
	String sheet10_F4;
	String sheet10_G4;
	double sheet10_A5;
	String sheet10_B5;

	//-----Connection, Statement, ResultSet 객체 선언-----
	private Connection conn_DUNET;		//DSN DUNET Connection 객체
	private java.sql.Statement stat_title;		//ResultSet title 객체를 생성하기 위한 Statement 객체
	private ResultSet title;		//ResultSet title 객체
	private java.sql.Statement stat_name_list;		//ResultSet name_list 객체를 생성하기 위한 Statement 객체
	private ResultSet name_list;		//ResultSet name_list 객체

	//-----SQL 변수 선언-----
	private String sql_title;		//ResultSet title 객체를 생성하기 위한 쿼리문 저장
	private String sql_name_list;		//ResultSet name_list 객체를 생성하기 위한 쿼리문 저장

	//-----쿼리 필드 변수 선언-----
	//ResultSet title 객체에서 필드 값을 받는 쿼리 필드 변수
	private String title_GR_INFO;
	private String title_STARTED_DATE;

	//ResultSet name_list 객체에서 필드 값을 받는 쿼리 필드 변수
	private double name_list_NO;
	private String name_list_NAME;

	//파라미터 변수 선언
	String p_grcode_Param;
	String p_grseq_Param;
	String p_dept_Param;

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
				if(name_list!=null) name_list.close();
				if(stat_name_list!=null) stat_name_list.close();
				if(title!=null) title.close();
				if(stat_title!=null) stat_title.close();
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
		initSheetVariant(41, 98, 546, 781, true);

		//시작 페이지 번호 출력
		out.print("-- " + nPageNum + " PAGE --\r");

		//밴드 함수 호출
		getScriptFromtitle01(true, true);    //머리글 밴드 호출
		getScriptFromfoot01(true, true);    //바닥글 밴드 호출
		getScriptFromlist01(true);    //반복 밴드 호출

		//페이지 및 좌표 설정
		nMaxPage=(int)MAX((long)nMaxPage, (long)nPageNum);    //생성된 최대 페이지 번호 구하기
	}

	//-----밴드 함수-----
	//----title01 HeaderBand Start----
	//----소속 쉬트 : SHEET=Sheet1    FRAME=Frame0
	//----밴드 이름 : title01
	//----밴드 종류 : 머리글 밴드
	//----bIsFrist : 쉬트 함수에서 최초로 호출될 때 true, 페이지 스킵 함수에서 호출될 때 false
	//----bIsPrint : 감추기 속성 설정 여부. treu면 출력, false면 AI 스크립트를 생성하지 않음.
	private void getScriptFromtitle01(boolean bIsFirst, boolean bIsPrint) throws Exception{
		if(bIsFirst){   //밴드 최초 호출 시에만 실행되는 코드
			//DataSet 객체 생성
			//ResultSet title 객체의 생성
			if(title==null){
				title = stat_title.executeQuery(sql_title);
			}else{
				title.beforeFirst();
			}

			//데이터 fetch
			if(title.next()){
				setFieldVariableFromtitle();	//ResultSet title에서 필드 값 설정
			}else{
				setFieldInitFromtitle();	//ResultSet title의 필드 값 초기화
			}

			//데이터 변수 초기화
			sheet10_J1="";
			sheet10_A2="";

			//데이터 변수 할당
			sheet10_J1=title_STARTED_DATE;
			sheet10_A2=title_GR_INFO;

			iWeekCount =0;
			iDayCount = 0;
			strDate =title_STARTED_DATE;
		}   //end if(bIsFirst)

		//AI 스크립트 출력
		if(bIsPrint){   //감추기 속성이 지정되지 않으면 bIsPrint는 true
			//스크립트 출력 함수 호출
			writeScripttitle01();
		}   //end if(bIsPrint)
	}

	//----foot01 FooterBand Start----
	//----소속 쉬트 : SHEET=Sheet1    FRAME=Frame0
	//----밴드 이름 : foot01
	//----밴드 종류 : 바닥글 밴드
	//----bIsFrist : 쉬트 함수에서 최초로 호출될 때 true, 페이지 스킵 함수에서 호출될 때 false
	//----bIsPrint : 감추기 속성 설정 여부. treu면 출력, false면 AI 스크립트를 생성하지 않음.
	private void getScriptFromfoot01(boolean bIsFirst, boolean bIsPrint) throws Exception{
		if(bIsFirst){   //밴드 최초 호출 시에만 실행되는 코드
		}   //end if(bIsFirst)

		//AI 스크립트 출력
		if(bIsPrint){   //감추기 속성이 지정되지 않으면 bIsPrint는 true
			//스크립트 출력 함수 호출
			writeScriptfoot01();
		}   //end if(bIsPrint)
	}

	//----header01 RepeatHeader Start----
	//----소속 쉬트 : SHEET=Sheet1    FRAME=Frame0
	//----밴드 이름 : header01
	//----밴드 종류 : 반복 헤더
	//----bIsFrist : 반복 밴드 함수에서 최초로 호출될 때 true, 그 이후 호출될 때 false
	//----bIsPrint : 감추기 속성 설정 여부. treu면 출력, false면 AI 스크립트를 생성하지 않음.
	private void getScriptFromheader01(boolean bIsFirst, boolean bIsPrint) throws Exception{
		//지역 변수 선언 및 초기화
		int nBandHeight=32;	//밴드 출력 높이

		if(bIsFirst){   //밴드 최초 호출 시에만 실행되는 코드
			//데이터 변수 초기화
			sheet10_C3="";
			sheet10_D3="";
			sheet10_E3="";
			sheet10_F3="";
			sheet10_G3="";
			sheet10_C4="";
			sheet10_D4="";
			sheet10_E4="";
			sheet10_F4="";
			sheet10_G4="";

			//데이터 변수 할당
			sheet10_C3=getAfterDay(0);
			sheet10_D3=getAfterDay(1);
			sheet10_E3=getAfterDay(2);
			sheet10_F3=getAfterDay(3);
			sheet10_G3=getAfterDay(4);
			sheet10_C4=getAfterWeek(0);
			sheet10_D4=getAfterWeek(1);
			sheet10_E4=getAfterWeek(2);
			sheet10_F4=getAfterWeek(3);
			sheet10_G4=getAfterWeek(4);
		}   //end if(bIsFirst)

		//AI 스크립트 출력
		if(bIsPrint){   //감추기 속성이 지정되지 않으면 bIsPrint는 true
			//스크립트 출력 영역 검사
			if(isPageSkip(nYCurPos+nBandHeight)){
				pageSkip(10);
			}

			//스크립트 출력 함수 호출
			writeScriptheader01();

			//다음 출력 좌표 설정
			nYCurPos=nYCurPos+nBandHeight;
		}   //end if(bIsPrint)
	}

	//-----list01 RepeatBand Start-----
	//-----소속 쉬트 : SHEET=Sheet1   FRAME=Frame0
	//-----밴드 이름 : list01
	//-----밴드 종류 : 반복 밴드
	//-----bIsPrint : 감추기 속성 설정 여부 true면 출력, false면 스크립트를 생성하지 않음
	private void getScriptFromlist01(boolean bIsPrint) throws Exception{
		//지역 변수 선언 및 초기화
		int nBandHeight=20;    //밴드 출력 높이
		boolean bIsFirst=true;

		//데이터 변수 초기화
		sheet10_A5=0;
		sheet10_B5="";

		//DataSet 객체 생성
		//ResultSet name_list 객체의 생성
		if(name_list==null){
			name_list = stat_name_list.executeQuery(sql_name_list);
		}else{
			name_list.beforeFirst();
		}

		while(name_list.next()){   //자동으로 생성되는 반복 밴드의 루프문
			//데이터 fetch
			setFieldVariableFromname_list();	//RecordSet name_list에서 필드 값 설정

			if(bIsFirst){   //밴드 호출 후 루프 내에서 한번 만 실행되는 코드
				//반복 헤더 호출 및 조건 플래그 초기화
				getScriptFromheader01(bIsFirst, true);	//반복 헤더 호출
			}   //end if(bIsFirst)

			//데이터 변수 할당
			sheet10_A5=name_list_NO;
			sheet10_B5=name_list_NAME;

			//AI 스크립트 출력
			if(bIsPrint){   //감추기 속성이 지정되지 않으면 bIsPrint는 true
				if(isPageSkip(nYCurPos+nBandHeight)){   //스크립트 출력 영역 검사
					//페이지 스킵 함수 호출
					pageSkip(10);

					//반복 헤더 및 부모 반복단위 호출
					getScriptFromheader01(false, true);	//반복 헤더 호출
				}   //end if(page skip test)

				//스크립트 출력 함수 호출
				writeScriptlist01();

				//다음 출력 좌표 설정
				nYCurPos=nYCurPos+nBandHeight;
			}   //end if(bIsPrint)

			//bIsFirst 및 출력 라인 설정
			bIsFirst=false;
		}   //while end
	}

	//-----스크립트 출력 함수-----
	//----title01 스크립트 문 출력 함수----
	private void writeScripttitle01( ) throws Exception{
		//스크립트문 생성
		out.print("^PRINT(41,41,504,1,19,0/,궁서,RGB[0,0,0],BOLD,UNDERLINE, ,NONE,32,1)");
		out.println(sheet10_A1+"\r");
		out.print("^PRINT(41,73,504,1,11,0/,돋움체,RGB[0,0,0], , , ,NONE,25,1)");
		out.println(sheet10_A2+"\r");
	}

	//----foot01 스크립트 문 출력 함수----
	private void writeScriptfoot01( ) throws Exception{
		//스크립트문 생성
		out.print("^PRINT(41,781,504,1,10,0/,돋움체,RGB[0,0,0], , , ,NONE,20,1)");
		out.println(sheet10_A6+"\r");
	}

	//----header01 스크립트 문 출력 함수----
	private void writeScriptheader01( ) throws Exception{
		//스크립트문 생성
		out.println("^CELLBG("+(nXCurPos)+","+(nYCurPos)+",50,32,1,RGB[230,230,250],RGB[230,230,250],0)\r");
		out.println("^CELLLINE("+(nXCurPos)+","+(nYCurPos)+",50,32,0,RGB[0,0,0],0)\r");
		out.println("^CELLLINE("+(nXCurPos)+","+(nYCurPos)+",50,32,0,RGB[0,0,0],1)\r");
		out.println("^CELLLINE("+(nXCurPos)+","+(nYCurPos)+",50,32,0,RGB[0,0,0],2)\r");
		out.println("^CELLLINE("+(nXCurPos)+","+(nYCurPos)+",50,32,0,RGB[0,0,0],3)\r");
		out.print("^PRINT("+(nXCurPos)+","+(nYCurPos)+",50,1,10,0/,돋움체,RGB[0,0,0], , , ,NONE,32,1)");
		out.println(sheet10_A3+"\r");
		out.println("^CELLBG("+(nXCurPos+50)+","+(nYCurPos)+",99,32,1,RGB[230,230,250],RGB[230,230,250],0)\r");
		out.println("^CELLLINE("+(nXCurPos+50)+","+(nYCurPos)+",99,32,0,RGB[0,0,0],0)\r");
		out.println("^CELLLINE("+(nXCurPos+50)+","+(nYCurPos)+",99,32,0,RGB[0,0,0],1)\r");
		out.println("^CELLLINE("+(nXCurPos+50)+","+(nYCurPos)+",99,32,0,RGB[0,0,0],2)\r");
		out.println("^CELLLINE("+(nXCurPos+50)+","+(nYCurPos)+",99,32,0,RGB[0,0,0],3)\r");
		out.print("^PRINT("+(nXCurPos+50)+","+(nYCurPos)+",99,1,10,0/,돋움체,RGB[0,0,0], , , ,NONE,32,1)");
		out.println(sheet10_B3+"\r");
		out.println("^CELLBG("+(nXCurPos+149)+","+(nYCurPos)+",71,16,1,RGB[230,230,250],RGB[230,230,250],0)\r");
		out.println("^CELLLINE("+(nXCurPos+149)+","+(nYCurPos)+",71,16,0,RGB[0,0,0],0)\r");
		out.println("^CELLLINE("+(nXCurPos+149)+","+(nYCurPos)+",71,16,0,RGB[0,0,0],2)\r");
		out.println("^CELLLINE("+(nXCurPos+149)+","+(nYCurPos)+",71,16,0,RGB[0,0,0],3)\r");
		out.print("^PRINT("+(nXCurPos+149)+","+(nYCurPos)+",71,1,10,0/,돋움체,RGB[0,0,0], , , ,NONE,16,1)");
		out.println(sheet10_C3+"\r");
		out.println("^CELLBG("+(nXCurPos+220)+","+(nYCurPos)+",71,16,1,RGB[230,230,250],RGB[230,230,250],0)\r");
		out.println("^CELLLINE("+(nXCurPos+220)+","+(nYCurPos)+",71,16,0,RGB[0,0,0],0)\r");
		out.println("^CELLLINE("+(nXCurPos+220)+","+(nYCurPos)+",71,16,0,RGB[0,0,0],2)\r");
		out.println("^CELLLINE("+(nXCurPos+220)+","+(nYCurPos)+",71,16,0,RGB[0,0,0],3)\r");
		out.print("^PRINT("+(nXCurPos+220)+","+(nYCurPos)+",71,1,10,0/,돋움체,RGB[0,0,0], , , ,NONE,16,1)");
		out.println(sheet10_D3+"\r");
		out.println("^CELLBG("+(nXCurPos+291)+","+(nYCurPos)+",71,16,1,RGB[230,230,250],RGB[230,230,250],0)\r");
		out.println("^CELLLINE("+(nXCurPos+291)+","+(nYCurPos)+",71,16,0,RGB[0,0,0],0)\r");
		out.println("^CELLLINE("+(nXCurPos+291)+","+(nYCurPos)+",71,16,0,RGB[0,0,0],2)\r");
		out.println("^CELLLINE("+(nXCurPos+291)+","+(nYCurPos)+",71,16,0,RGB[0,0,0],3)\r");
		out.print("^PRINT("+(nXCurPos+291)+","+(nYCurPos)+",71,1,10,0/,돋움체,RGB[0,0,0], , , ,NONE,16,1)");
		out.println(sheet10_E3+"\r");
		out.println("^CELLBG("+(nXCurPos+362)+","+(nYCurPos)+",71,16,1,RGB[230,230,250],RGB[230,230,250],0)\r");
		out.println("^CELLLINE("+(nXCurPos+362)+","+(nYCurPos)+",71,16,0,RGB[0,0,0],0)\r");
		out.println("^CELLLINE("+(nXCurPos+362)+","+(nYCurPos)+",71,16,0,RGB[0,0,0],2)\r");
		out.println("^CELLLINE("+(nXCurPos+362)+","+(nYCurPos)+",71,16,0,RGB[0,0,0],3)\r");
		out.print("^PRINT("+(nXCurPos+362)+","+(nYCurPos)+",71,1,10,0/,돋움체,RGB[0,0,0], , , ,NONE,16,1)");
		out.println(sheet10_F3+"\r");
		out.println("^CELLBG("+(nXCurPos+433)+","+(nYCurPos)+",71,16,1,RGB[230,230,250],RGB[230,230,250],0)\r");
		out.println("^CELLLINE("+(nXCurPos+433)+","+(nYCurPos)+",71,16,0,RGB[0,0,0],0)\r");
		out.println("^CELLLINE("+(nXCurPos+433)+","+(nYCurPos)+",71,16,0,RGB[0,0,0],2)\r");
		out.println("^CELLLINE("+(nXCurPos+433)+","+(nYCurPos)+",71,16,0,RGB[0,0,0],3)\r");
		out.print("^PRINT("+(nXCurPos+433)+","+(nYCurPos)+",71,1,10,0/,돋움체,RGB[0,0,0], , , ,NONE,16,1)");
		out.println(sheet10_G3+"\r");
		out.println("^CELLBG("+(nXCurPos+149)+","+(nYCurPos+16)+",71,16,1,RGB[230,230,250],RGB[230,230,250],0)\r");
		out.println("^CELLLINE("+(nXCurPos+149)+","+(nYCurPos+16)+",71,16,0,RGB[0,0,0],1)\r");
		out.println("^CELLLINE("+(nXCurPos+149)+","+(nYCurPos+16)+",71,16,0,RGB[0,0,0],2)\r");
		out.println("^CELLLINE("+(nXCurPos+149)+","+(nYCurPos+16)+",71,16,0,RGB[0,0,0],3)\r");
		out.print("^PRINT("+(nXCurPos+149)+","+(nYCurPos+16)+",71,1,10,0/,돋움체,RGB[0,0,0], , , ,NONE,16,1)");
		out.println(sheet10_C4+"\r");
		out.println("^CELLBG("+(nXCurPos+220)+","+(nYCurPos+16)+",71,16,1,RGB[230,230,250],RGB[230,230,250],0)\r");
		out.println("^CELLLINE("+(nXCurPos+220)+","+(nYCurPos+16)+",71,16,0,RGB[0,0,0],1)\r");
		out.println("^CELLLINE("+(nXCurPos+220)+","+(nYCurPos+16)+",71,16,0,RGB[0,0,0],2)\r");
		out.println("^CELLLINE("+(nXCurPos+220)+","+(nYCurPos+16)+",71,16,0,RGB[0,0,0],3)\r");
		out.print("^PRINT("+(nXCurPos+220)+","+(nYCurPos+16)+",71,1,10,0/,돋움체,RGB[0,0,0], , , ,NONE,16,1)");
		out.println(sheet10_D4+"\r");
		out.println("^CELLBG("+(nXCurPos+291)+","+(nYCurPos+16)+",71,16,1,RGB[230,230,250],RGB[230,230,250],0)\r");
		out.println("^CELLLINE("+(nXCurPos+291)+","+(nYCurPos+16)+",71,16,0,RGB[0,0,0],1)\r");
		out.println("^CELLLINE("+(nXCurPos+291)+","+(nYCurPos+16)+",71,16,0,RGB[0,0,0],2)\r");
		out.println("^CELLLINE("+(nXCurPos+291)+","+(nYCurPos+16)+",71,16,0,RGB[0,0,0],3)\r");
		out.print("^PRINT("+(nXCurPos+291)+","+(nYCurPos+16)+",71,1,10,0/,돋움체,RGB[0,0,0], , , ,NONE,16,1)");
		out.println(sheet10_E4+"\r");
		out.println("^CELLBG("+(nXCurPos+362)+","+(nYCurPos+16)+",71,16,1,RGB[230,230,250],RGB[230,230,250],0)\r");
		out.println("^CELLLINE("+(nXCurPos+362)+","+(nYCurPos+16)+",71,16,0,RGB[0,0,0],1)\r");
		out.println("^CELLLINE("+(nXCurPos+362)+","+(nYCurPos+16)+",71,16,0,RGB[0,0,0],2)\r");
		out.println("^CELLLINE("+(nXCurPos+362)+","+(nYCurPos+16)+",71,16,0,RGB[0,0,0],3)\r");
		out.print("^PRINT("+(nXCurPos+362)+","+(nYCurPos+16)+",71,1,10,0/,돋움체,RGB[0,0,0], , , ,NONE,16,1)");
		out.println(sheet10_F4+"\r");
		out.println("^CELLBG("+(nXCurPos+433)+","+(nYCurPos+16)+",71,16,1,RGB[230,230,250],RGB[230,230,250],0)\r");
		out.println("^CELLLINE("+(nXCurPos+433)+","+(nYCurPos+16)+",71,16,0,RGB[0,0,0],1)\r");
		out.println("^CELLLINE("+(nXCurPos+433)+","+(nYCurPos+16)+",71,16,0,RGB[0,0,0],2)\r");
		out.println("^CELLLINE("+(nXCurPos+433)+","+(nYCurPos+16)+",71,16,0,RGB[0,0,0],3)\r");
		out.print("^PRINT("+(nXCurPos+433)+","+(nYCurPos+16)+",71,1,10,0/,돋움체,RGB[0,0,0], , , ,NONE,16,1)");
		out.println(sheet10_G4+"\r");
	}

	//----list01 스크립트 문 출력 함수----
	private void writeScriptlist01( ) throws Exception{
		//스크립트문 생성
		out.println("^CELLLINE("+(nXCurPos)+","+(nYCurPos)+",50,20,0,RGB[0,0,0],0)\r");
		out.println("^CELLLINE("+(nXCurPos)+","+(nYCurPos)+",50,20,0,RGB[0,0,0],1)\r");
		out.println("^CELLLINE("+(nXCurPos)+","+(nYCurPos)+",50,20,0,RGB[0,0,0],2)\r");
		out.println("^CELLLINE("+(nXCurPos)+","+(nYCurPos)+",50,20,0,RGB[0,0,0],3)\r");
		out.print("^PRINT("+(nXCurPos)+","+(nYCurPos)+",50,1,10,1/0/0,돋움체,RGB[0,0,0], , , ,NONE,20,1)");
		out.println(sheet10_A5+"\r");
		out.println("^CELLLINE("+(nXCurPos+50)+","+(nYCurPos)+",99,20,0,RGB[0,0,0],0)\r");
		out.println("^CELLLINE("+(nXCurPos+50)+","+(nYCurPos)+",99,20,0,RGB[0,0,0],1)\r");
		out.println("^CELLLINE("+(nXCurPos+50)+","+(nYCurPos)+",99,20,0,RGB[0,0,0],2)\r");
		out.println("^CELLLINE("+(nXCurPos+50)+","+(nYCurPos)+",99,20,0,RGB[0,0,0],3)\r");
		out.print("^PRINT("+(nXCurPos+50)+","+(nYCurPos)+",99,1,10,0/,돋움체,RGB[0,0,0], , , ,NONE,20,1)");
		out.println(sheet10_B5+"\r");
		out.println("^CELLLINE("+(nXCurPos+149)+","+(nYCurPos)+",71,20,0,RGB[0,0,0],0)\r");
		out.println("^CELLLINE("+(nXCurPos+149)+","+(nYCurPos)+",71,20,0,RGB[0,0,0],1)\r");
		out.println("^CELLLINE("+(nXCurPos+149)+","+(nYCurPos)+",71,20,0,RGB[0,0,0],2)\r");
		out.println("^CELLLINE("+(nXCurPos+149)+","+(nYCurPos)+",71,20,0,RGB[0,0,0],3)\r");
		out.println("^CELLLINE("+(nXCurPos+220)+","+(nYCurPos)+",71,20,0,RGB[0,0,0],0)\r");
		out.println("^CELLLINE("+(nXCurPos+220)+","+(nYCurPos)+",71,20,0,RGB[0,0,0],1)\r");
		out.println("^CELLLINE("+(nXCurPos+220)+","+(nYCurPos)+",71,20,0,RGB[0,0,0],2)\r");
		out.println("^CELLLINE("+(nXCurPos+220)+","+(nYCurPos)+",71,20,0,RGB[0,0,0],3)\r");
		out.println("^CELLLINE("+(nXCurPos+291)+","+(nYCurPos)+",71,20,0,RGB[0,0,0],0)\r");
		out.println("^CELLLINE("+(nXCurPos+291)+","+(nYCurPos)+",71,20,0,RGB[0,0,0],1)\r");
		out.println("^CELLLINE("+(nXCurPos+291)+","+(nYCurPos)+",71,20,0,RGB[0,0,0],2)\r");
		out.println("^CELLLINE("+(nXCurPos+291)+","+(nYCurPos)+",71,20,0,RGB[0,0,0],3)\r");
		out.println("^CELLLINE("+(nXCurPos+362)+","+(nYCurPos)+",71,20,0,RGB[0,0,0],0)\r");
		out.println("^CELLLINE("+(nXCurPos+362)+","+(nYCurPos)+",71,20,0,RGB[0,0,0],1)\r");
		out.println("^CELLLINE("+(nXCurPos+362)+","+(nYCurPos)+",71,20,0,RGB[0,0,0],2)\r");
		out.println("^CELLLINE("+(nXCurPos+362)+","+(nYCurPos)+",71,20,0,RGB[0,0,0],3)\r");
		out.println("^CELLLINE("+(nXCurPos+433)+","+(nYCurPos)+",71,20,0,RGB[0,0,0],0)\r");
		out.println("^CELLLINE("+(nXCurPos+433)+","+(nYCurPos)+",71,20,0,RGB[0,0,0],1)\r");
		out.println("^CELLLINE("+(nXCurPos+433)+","+(nYCurPos)+",71,20,0,RGB[0,0,0],2)\r");
		out.println("^CELLLINE("+(nXCurPos+433)+","+(nYCurPos)+",71,20,0,RGB[0,0,0],3)\r");
	}

	//파라미터 설정 함수
	private void setParam(){
		p_grcode_Param=GetB(request.getParameter("p_grcode"));
		p_grseq_Param=GetB(request.getParameter("p_grseq"));
		p_dept_Param=GetB(request.getParameter("p_dept"));
	}

	//-----Connection 및 Statement 객체 생성 함수-----
	private void createConnAndStateObject() throws Exception{
		//DUNET Connection 객체 생성
		Class.forName("oracle.jdbc.driver.OracleDriver");
		conn_DUNET = DriverManager.getConnection("jdbc:oracle:thin:@210.100.164.2:1521:loti","cmlms","fhxl21");stat_title=conn_DUNET.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
		stat_name_list=conn_DUNET.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
	}

	//-----SQL문 변수 초기화 함수-----
	private void initSQLConst(){
		sql_title = "SELECT TO_CHAR(STARTED,'YYYY') || '년 ' || ";
		sql_title = sql_title + "      TO_CHAR(STARTED,'MM')   || '월 ' || ";
		sql_title = sql_title + "      TO_CHAR(STARTED,'DD')   || '일 ~  ' || ";
		sql_title = sql_title + "      TO_CHAR(ENDDATE,'YYYY') || '년 ' || ";
		sql_title = sql_title + "      TO_CHAR(ENDDATE,'MM') || '월 ' || ";
		sql_title = sql_title + "      TO_CHAR(ENDDATE,'DD') || '일' AS GR_INFO ";
		sql_title = sql_title + "     , TO_CHAR(STARTED,'YYYYMMDD') AS STARTED_DATE ";
		sql_title = sql_title + "  FROM CMTB_GRSEQ  ";
		sql_title = sql_title + " WHERE GRCODE = '" + p_grcode_Param + "' ";
		sql_title = sql_title + " AND GRSEQ    = '" + p_grseq_Param + "' ";
		sql_title = sql_title + " AND DEPT     = '" + p_dept_Param + "'";
		sql_name_list = "SELECT ROWNUM AS NO, NAME ";
		sql_name_list = sql_name_list + " FROM (SELECT NAME, GRCODE, GRSEQ, DEPT   ";
		sql_name_list = sql_name_list + "             FROM CMTV_UNAPP_INFO  ";
		sql_name_list = sql_name_list + "           WHERE GRCHK = 'Y'  ";
		sql_name_list = sql_name_list + "           ORDER BY NAME)  ";
		sql_name_list = sql_name_list + " WHERE GRCODE = '" + p_grcode_Param + "'  ";
		sql_name_list = sql_name_list + " AND GRSEQ = '" + p_grseq_Param + "'  ";
		sql_name_list = sql_name_list + " AND DEPT = '" + p_dept_Param + "'";
	}

	//-----ResultSet 객체에서 필드 값 설정 함수-----
	//ResultSet title 객체에서 필드 값 설정 함수
	private void setFieldVariableFromtitle() throws Exception{
		title_GR_INFO=GetB(title.getString(1));
		title_STARTED_DATE=GetB(title.getString(2));
	}

	//ResultSet title 객체의 필드 값 초기화 함수
	private void setFieldInitFromtitle(){
		title_GR_INFO="";
		title_STARTED_DATE="";
	}

	//ResultSet name_list 객체에서 필드 값 설정 함수
	private void setFieldVariableFromname_list() throws Exception{
		name_list_NO=name_list.getDouble(1);
		name_list_NAME=GetB(name_list.getString(2));
	}

	//ResultSet name_list 객체의 필드 값 초기화 함수
	private void setFieldInitFromname_list(){
		name_list_NO=0;
		name_list_NAME="";
	}

	//-----고정 데이터 초기화 함수-----
	private void initConstVarient(){
		sheet10_A1="출       석       부";
		sheet10_A6="#PAGE / #TOTALPAGE";
		sheet10_A3="번호";
		sheet10_B3="성  명";
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
			getScriptFromtitle01(false, true);		//머리글 밴드 호출
			getScriptFromfoot01(false, true);		//바닥글 밴드 호출
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
}
%>
