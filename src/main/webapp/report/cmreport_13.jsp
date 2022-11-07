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
	String sheet10_A5;
	String sheet10_A2;
	int[] nAutoHeight_list=new int[1];
	String sheet10_A3;
	String sheet10_B3;
	String sheet10_C3;
	String sheet10_D3;
	String sheet10_E3;
	String sheet10_F3;
	String sheet10_G3;
	String sheet10_H3;
	long sheet10_A4;
	String sheet10_B4;
	String sheet10_C4;
	String sheet10_D4;
	String sheet10_E4;
	String sheet10_F4;
	String sheet10_G4;
	String sheet10_H4;

	//-----Connection, Statement, ResultSet 객체 선언-----
	private Connection conn_DUNET;		//DSN DUNET Connection 객체
	private java.sql.Statement stat_list;		//ResultSet list 객체를 생성하기 위한 Statement 객체
	private ResultSet list;		//ResultSet list 객체
	private java.sql.Statement stat_gr_info;		//ResultSet gr_info 객체를 생성하기 위한 Statement 객체
	private ResultSet gr_info;		//ResultSet gr_info 객체

	//-----SQL 변수 선언-----
	private String sql_list;		//ResultSet list 객체를 생성하기 위한 쿼리문 저장
	private String sql_gr_info;		//ResultSet gr_info 객체를 생성하기 위한 쿼리문 저장

	//-----쿼리 필드 변수 선언-----
	//ResultSet list 객체에서 필드 값을 받는 쿼리 필드 변수
	private String list_OFF_USERNO;
	private String list_USER_ID;
	private String list_NAME;
	private String list_APPDATE;
	private String list_EMAIL;
	private String list_TELNO;
	private String list_DEPTNM;
	private String list_RESNO;
	private String list_ADDR;
	private String list_HP;

	//ResultSet gr_info 객체에서 필드 값을 받는 쿼리 필드 변수
	private String gr_info_GRCODENM;

	//파라미터 변수 선언
	String p_grcode_Param;
	String p_grseq_Param;

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
			getScriptHeader("A4", "2100x2970", "9", "HORIZONTAL");

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
				if(gr_info!=null) gr_info.close();
				if(stat_gr_info!=null) stat_gr_info.close();
				if(list!=null) list.close();
				if(stat_list!=null) stat_list.close();
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
		initSheetVariant(41, 81, 798, 534, true);

		//시작 페이지 번호 출력
		out.print("-- " + nPageNum + " PAGE --\r");

		//밴드 함수 호출
		getScriptFromtitle01(true, true);    //머리글 밴드 호출
		getScriptFromfoot01(true, true);    //바닥글 밴드 호출
		getScriptFromVoidBand109(true, true);    //Void 밴드 호출
		getScriptFromlist(true);    //반복 밴드 호출

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

	//----VoidBand109 VoidBand Start----
	//----소속 쉬트 : SHEET=Sheet1    FRAME=Frame0
	//----밴드 이름 : VoidBand109
	//----밴드 종류 : Void 밴드
	//----bIsFrist : 부모 밴드 함수나 쉬트 함수에서 최초로 호출될 때 true, 그 이후 호출될 때 false
	//----bIsPrint : 감추기 속성 설정 여부. true면 출력, false면 AI 스크립트를 생성하지 않음.
	//----nRepeatCnt : 부모 반복 밴드 수행 횟수와 연동 옵션 설정시 void 밴드가 수행할 반복 횟수 전달
	private void getScriptFromVoidBand109(boolean bIsFirst, boolean bIsPrint) throws Exception{
		//지역 변수 선언 및 초기화
		int nBandHeight=24;    //밴드 출력 높이

		if(bIsFirst){   //밴드 최초 호출 시에만 실행되는 코드
			//DataSet 객체 생성
			//ResultSet gr_info 객체의 생성
			if(gr_info==null){
				gr_info = stat_gr_info.executeQuery(sql_gr_info);
			}else{
				gr_info.beforeFirst();
			}

			//데이터 fetch
			if(gr_info.next()){
				setFieldVariableFromgr_info();	//ResultSet gr_info에서 필드 값 설정
			}else{
				setFieldInitFromgr_info();	//ResultSet gr_info의 필드 값 초기화
			}

			//데이터 변수 초기화
			sheet10_A2="";

			//데이터 변수 할당
			sheet10_A2=gr_info_GRCODENM;
		}    //end if(bIsFirst)

		//AI 스크립트 출력
		if(bIsPrint){   //감추기 속성이 지정되지 않으면 bIsPrint는 true
			//스크립트 출력 영역 검사
			if(isPageSkip(nYCurPos+nBandHeight)){
				pageSkip(10);
			}

			//스크립트 출력 함수 호출
			writeScriptVoidBand109();

			//다음 출력 좌표 설정
			nYCurPos=nYCurPos+nBandHeight;
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
		int nBandHeight=20;	//밴드 출력 높이

		if(bIsFirst){   //밴드 최초 호출 시에만 실행되는 코드
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

	//-----list RepeatBand Start-----
	//-----소속 쉬트 : SHEET=Sheet1   FRAME=Frame0
	//-----밴드 이름 : list
	//-----밴드 종류 : 반복 밴드
	//-----bIsPrint : 감추기 속성 설정 여부 true면 출력, false면 스크립트를 생성하지 않음
	private void getScriptFromlist(boolean bIsPrint) throws Exception{
		//지역 변수 선언 및 초기화
		int nBandHeight=20;    //밴드 출력 높이
		boolean bIsFirst=true;
		//폰트명 : 돋움체
		//폰트 사이즈 : 10
		//각 문자별 폭을 할당할 배열 선언
		int[] charWidth = {5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,10};

		//데이터 변수 초기화
		sheet10_A4=0L;
		sheet10_B4="";
		sheet10_C4="";
		sheet10_D4="";
		sheet10_E4="";
		sheet10_F4="";
		sheet10_G4="";
		sheet10_H4="";

		//DataSet 객체 생성
		//ResultSet list 객체의 생성
		if(list==null){
			list = stat_list.executeQuery(sql_list);
		}else{
			list.beforeFirst();
		}

		while(list.next()){   //자동으로 생성되는 반복 밴드의 루프문
			//데이터 fetch
			setFieldVariableFromlist();	//RecordSet list에서 필드 값 설정

			if(bIsFirst){   //밴드 호출 후 루프 내에서 한번 만 실행되는 코드
				//반복 헤더 호출 및 조건 플래그 초기화
				getScriptFromheader01(bIsFirst, true);	//반복 헤더 호출
			}   //end if(bIsFirst)

			//데이터 변수 할당
			sheet10_A4=COUNT(sheet10_A4);
			sheet10_B4=list_RESNO;
			sheet10_C4=list_NAME;
			sheet10_D4=list_DEPTNM;
			sheet10_E4=list_EMAIL;
			sheet10_F4=list_TELNO;
			sheet10_G4=list_HP;
			sheet10_H4=list_ADDR;

			//Auto Size Code
			nAutoHeight_list[0]=0;
			nAutoHeight_list[0]=getPrintHeight(sheet10_B4, charWidth, 10, 78, 20, nAutoHeight_list[0]);
			nAutoHeight_list[0]=getPrintHeight(sheet10_C4, charWidth, 10, 52, 20, nAutoHeight_list[0]);
			nAutoHeight_list[0]=getPrintHeight(sheet10_D4, charWidth, 10, 108, 20, nAutoHeight_list[0]);
			nAutoHeight_list[0]=getPrintHeight(sheet10_E4, charWidth, 10, 114, 20, nAutoHeight_list[0]);
			nAutoHeight_list[0]=getPrintHeight(sheet10_F4, charWidth, 10, 79, 20, nAutoHeight_list[0]);
			nAutoHeight_list[0]=nAutoHeight_list[0]+20;
			nBandHeight=nAutoHeight_list[0];   //밴드 출력 높이 설정

			//AI 스크립트 출력
			if(bIsPrint){   //감추기 속성이 지정되지 않으면 bIsPrint는 true
				if(isPageSkip(nYCurPos+nBandHeight)){   //스크립트 출력 영역 검사
					//페이지 스킵 함수 호출
					pageSkip(10);

					//반복 헤더 및 부모 반복단위 호출
					getScriptFromheader01(false, true);	//반복 헤더 호출
				}   //end if(page skip test)

				//스크립트 출력 함수 호출
				writeScriptlist();

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
		out.print("^PRINT(41,43,756,1,16,0/,돋움체,RGB[0,0,0],BOLD, , ,NONE,38,1)");
		out.println(sheet10_A1+"\r");
	}

	//----foot01 스크립트 문 출력 함수----
	private void writeScriptfoot01( ) throws Exception{
		//스크립트문 생성
		out.print("^PRINT(41,534,756,1,10,0/,돋움체,RGB[0,0,0], , , ,NONE,20,1)");
		out.println(sheet10_A5+"\r");
	}

	//----VoidBand109 스크립트 문 출력 함수----
	private void writeScriptVoidBand109( ) throws Exception{
		//스크립트문 생성
		out.print("^PRINT("+(nXCurPos)+","+(nYCurPos)+",756,0,14,0/,돋움체,RGB[0,0,0],BOLD, , ,NONE,24,1)");
		out.println(sheet10_A2+"\r");
	}

	//----header01 스크립트 문 출력 함수----
	private void writeScriptheader01( ) throws Exception{
		//스크립트문 생성
		out.println("^CELLBG("+(nXCurPos)+","+(nYCurPos)+",35,20,1,RGB[230,230,250],RGB[230,230,250],0)\r");
		out.println("^CELLLINE("+(nXCurPos)+","+(nYCurPos)+",35,20,0,RGB[0,0,0],0)\r");
		out.println("^CELLLINE("+(nXCurPos)+","+(nYCurPos)+",35,20,0,RGB[0,0,0],1)\r");
		out.println("^CELLLINE("+(nXCurPos)+","+(nYCurPos)+",35,20,0,RGB[0,0,0],2)\r");
		out.println("^CELLLINE("+(nXCurPos)+","+(nYCurPos)+",35,20,0,RGB[0,0,0],3)\r");
		out.print("^PRINT("+(nXCurPos)+","+(nYCurPos)+",35,1,10,0/,돋움체,RGB[0,0,0], , , ,NONE,20,1)");
		out.println(sheet10_A3+"\r");
		out.println("^CELLBG("+(nXCurPos+35)+","+(nYCurPos)+",78,20,1,RGB[230,230,250],RGB[230,230,250],0)\r");
		out.println("^CELLLINE("+(nXCurPos+35)+","+(nYCurPos)+",78,20,0,RGB[0,0,0],0)\r");
		out.println("^CELLLINE("+(nXCurPos+35)+","+(nYCurPos)+",78,20,0,RGB[0,0,0],1)\r");
		out.println("^CELLLINE("+(nXCurPos+35)+","+(nYCurPos)+",78,20,0,RGB[0,0,0],2)\r");
		out.println("^CELLLINE("+(nXCurPos+35)+","+(nYCurPos)+",78,20,0,RGB[0,0,0],3)\r");
		out.print("^PRINT("+(nXCurPos+35)+","+(nYCurPos)+",78,1,10,0/,돋움체,RGB[0,0,0], , , ,NONE,20,1)");
		out.println(sheet10_B3+"\r");
		out.println("^CELLBG("+(nXCurPos+113)+","+(nYCurPos)+",52,20,1,RGB[230,230,250],RGB[230,230,250],0)\r");
		out.println("^CELLLINE("+(nXCurPos+113)+","+(nYCurPos)+",52,20,0,RGB[0,0,0],0)\r");
		out.println("^CELLLINE("+(nXCurPos+113)+","+(nYCurPos)+",52,20,0,RGB[0,0,0],1)\r");
		out.println("^CELLLINE("+(nXCurPos+113)+","+(nYCurPos)+",52,20,0,RGB[0,0,0],2)\r");
		out.println("^CELLLINE("+(nXCurPos+113)+","+(nYCurPos)+",52,20,0,RGB[0,0,0],3)\r");
		out.print("^PRINT("+(nXCurPos+113)+","+(nYCurPos)+",52,1,10,0/,돋움체,RGB[0,0,0], , , ,NONE,20,1)");
		out.println(sheet10_C3+"\r");
		out.println("^CELLBG("+(nXCurPos+165)+","+(nYCurPos)+",108,20,1,RGB[230,230,250],RGB[230,230,250],0)\r");
		out.println("^CELLLINE("+(nXCurPos+165)+","+(nYCurPos)+",108,20,0,RGB[0,0,0],0)\r");
		out.println("^CELLLINE("+(nXCurPos+165)+","+(nYCurPos)+",108,20,0,RGB[0,0,0],1)\r");
		out.println("^CELLLINE("+(nXCurPos+165)+","+(nYCurPos)+",108,20,0,RGB[0,0,0],2)\r");
		out.println("^CELLLINE("+(nXCurPos+165)+","+(nYCurPos)+",108,20,0,RGB[0,0,0],3)\r");
		out.print("^PRINT("+(nXCurPos+165)+","+(nYCurPos)+",108,1,10,0/,돋움체,RGB[0,0,0], , , ,NONE,20,1)");
		out.println(sheet10_D3+"\r");
		out.println("^CELLBG("+(nXCurPos+273)+","+(nYCurPos)+",114,20,1,RGB[230,230,250],RGB[230,230,250],0)\r");
		out.println("^CELLLINE("+(nXCurPos+273)+","+(nYCurPos)+",114,20,0,RGB[0,0,0],0)\r");
		out.println("^CELLLINE("+(nXCurPos+273)+","+(nYCurPos)+",114,20,0,RGB[0,0,0],1)\r");
		out.println("^CELLLINE("+(nXCurPos+273)+","+(nYCurPos)+",114,20,0,RGB[0,0,0],2)\r");
		out.println("^CELLLINE("+(nXCurPos+273)+","+(nYCurPos)+",114,20,0,RGB[0,0,0],3)\r");
		out.print("^PRINT("+(nXCurPos+273)+","+(nYCurPos)+",114,1,10,0/,돋움체,RGB[0,0,0], , , ,NONE,20,1)");
		out.println(sheet10_E3+"\r");
		out.println("^CELLBG("+(nXCurPos+387)+","+(nYCurPos)+",79,20,1,RGB[230,230,250],RGB[230,230,250],0)\r");
		out.println("^CELLLINE("+(nXCurPos+387)+","+(nYCurPos)+",79,20,0,RGB[0,0,0],0)\r");
		out.println("^CELLLINE("+(nXCurPos+387)+","+(nYCurPos)+",79,20,0,RGB[0,0,0],1)\r");
		out.println("^CELLLINE("+(nXCurPos+387)+","+(nYCurPos)+",79,20,0,RGB[0,0,0],2)\r");
		out.println("^CELLLINE("+(nXCurPos+387)+","+(nYCurPos)+",79,20,0,RGB[0,0,0],3)\r");
		out.print("^PRINT("+(nXCurPos+387)+","+(nYCurPos)+",79,1,10,0/,돋움체,RGB[0,0,0], , , ,NONE,20,1)");
		out.println(sheet10_F3+"\r");
		out.println("^CELLBG("+(nXCurPos+466)+","+(nYCurPos)+",72,20,1,RGB[230,230,250],RGB[230,230,250],0)\r");
		out.println("^CELLLINE("+(nXCurPos+466)+","+(nYCurPos)+",72,20,0,RGB[0,0,0],0)\r");
		out.println("^CELLLINE("+(nXCurPos+466)+","+(nYCurPos)+",72,20,0,RGB[0,0,0],1)\r");
		out.println("^CELLLINE("+(nXCurPos+466)+","+(nYCurPos)+",72,20,0,RGB[0,0,0],2)\r");
		out.println("^CELLLINE("+(nXCurPos+466)+","+(nYCurPos)+",72,20,0,RGB[0,0,0],3)\r");
		out.print("^PRINT("+(nXCurPos+466)+","+(nYCurPos)+",72,1,10,0/,돋움체,RGB[0,0,0], , , ,NONE,20,1)");
		out.println(sheet10_G3+"\r");
		out.println("^CELLBG("+(nXCurPos+538)+","+(nYCurPos)+",218,20,1,RGB[230,230,250],RGB[230,230,250],0)\r");
		out.println("^CELLLINE("+(nXCurPos+538)+","+(nYCurPos)+",218,20,0,RGB[0,0,0],0)\r");
		out.println("^CELLLINE("+(nXCurPos+538)+","+(nYCurPos)+",218,20,0,RGB[0,0,0],1)\r");
		out.println("^CELLLINE("+(nXCurPos+538)+","+(nYCurPos)+",218,20,0,RGB[0,0,0],2)\r");
		out.println("^CELLLINE("+(nXCurPos+538)+","+(nYCurPos)+",218,20,0,RGB[0,0,0],3)\r");
		out.print("^PRINT("+(nXCurPos+538)+","+(nYCurPos)+",218,1,10,0/,돋움체,RGB[0,0,0], , , ,NONE,20,1)");
		out.println(sheet10_H3+"\r");
	}

	//----list 스크립트 문 출력 함수----
	private void writeScriptlist( ) throws Exception{
		//스크립트문 생성
		out.println("^CELLLINE("+(nXCurPos)+","+(nYCurPos)+",35,"+(nAutoHeight_list[0])+",0,RGB[0,0,0],0)\r");
		out.println("^CELLLINE("+(nXCurPos)+","+(nYCurPos)+",35,"+(nAutoHeight_list[0])+",0,RGB[0,0,0],1)\r");
		out.println("^CELLLINE("+(nXCurPos)+","+(nYCurPos)+",35,"+(nAutoHeight_list[0])+",0,RGB[0,0,0],2)\r");
		out.println("^CELLLINE("+(nXCurPos)+","+(nYCurPos)+",35,"+(nAutoHeight_list[0])+",0,RGB[0,0,0],3)\r");
		out.print("^PRINT("+(nXCurPos)+","+(nYCurPos)+",35,1,10,1/0/0,돋움체,RGB[0,0,0], , , ,XL,"+(nAutoHeight_list[0])+",1)");
		out.println(sheet10_A4+"\r");
		out.println("^CELLLINE("+(nXCurPos+35)+","+(nYCurPos)+",78,"+(nAutoHeight_list[0])+",0,RGB[0,0,0],0)\r");
		out.println("^CELLLINE("+(nXCurPos+35)+","+(nYCurPos)+",78,"+(nAutoHeight_list[0])+",0,RGB[0,0,0],1)\r");
		out.println("^CELLLINE("+(nXCurPos+35)+","+(nYCurPos)+",78,"+(nAutoHeight_list[0])+",0,RGB[0,0,0],2)\r");
		out.println("^CELLLINE("+(nXCurPos+35)+","+(nYCurPos)+",78,"+(nAutoHeight_list[0])+",0,RGB[0,0,0],3)\r");
		out.print("^PRINT("+(nXCurPos+35)+","+(nYCurPos)+",78,1,10,0/,돋움체,RGB[0,0,0], , , ,XL,"+(nAutoHeight_list[0])+",1)");
		out.println(sheet10_B4+"\r");
		out.println("^CELLLINE("+(nXCurPos+113)+","+(nYCurPos)+",52,"+(nAutoHeight_list[0])+",0,RGB[0,0,0],0)\r");
		out.println("^CELLLINE("+(nXCurPos+113)+","+(nYCurPos)+",52,"+(nAutoHeight_list[0])+",0,RGB[0,0,0],1)\r");
		out.println("^CELLLINE("+(nXCurPos+113)+","+(nYCurPos)+",52,"+(nAutoHeight_list[0])+",0,RGB[0,0,0],2)\r");
		out.println("^CELLLINE("+(nXCurPos+113)+","+(nYCurPos)+",52,"+(nAutoHeight_list[0])+",0,RGB[0,0,0],3)\r");
		out.print("^PRINT("+(nXCurPos+113)+","+(nYCurPos)+",52,1,10,0/,돋움체,RGB[0,0,0], , , ,XL,"+(nAutoHeight_list[0])+",1)");
		out.println(sheet10_C4+"\r");
		out.println("^CELLLINE("+(nXCurPos+165)+","+(nYCurPos)+",108,"+(nAutoHeight_list[0])+",0,RGB[0,0,0],0)\r");
		out.println("^CELLLINE("+(nXCurPos+165)+","+(nYCurPos)+",108,"+(nAutoHeight_list[0])+",0,RGB[0,0,0],1)\r");
		out.println("^CELLLINE("+(nXCurPos+165)+","+(nYCurPos)+",108,"+(nAutoHeight_list[0])+",0,RGB[0,0,0],2)\r");
		out.println("^CELLLINE("+(nXCurPos+165)+","+(nYCurPos)+",108,"+(nAutoHeight_list[0])+",0,RGB[0,0,0],3)\r");
		out.print("^PRINT("+(nXCurPos+165)+","+(nYCurPos)+",108,1,10,0/,돋움체,RGB[0,0,0], , , ,XL,"+(nAutoHeight_list[0])+",1)");
		out.println(sheet10_D4+"\r");
		out.println("^CELLLINE("+(nXCurPos+273)+","+(nYCurPos)+",114,"+(nAutoHeight_list[0])+",0,RGB[0,0,0],0)\r");
		out.println("^CELLLINE("+(nXCurPos+273)+","+(nYCurPos)+",114,"+(nAutoHeight_list[0])+",0,RGB[0,0,0],1)\r");
		out.println("^CELLLINE("+(nXCurPos+273)+","+(nYCurPos)+",114,"+(nAutoHeight_list[0])+",0,RGB[0,0,0],2)\r");
		out.println("^CELLLINE("+(nXCurPos+273)+","+(nYCurPos)+",114,"+(nAutoHeight_list[0])+",0,RGB[0,0,0],3)\r");
		out.print("^PRINT("+(nXCurPos+273)+","+(nYCurPos)+",114,1,10,0/,돋움체,RGB[0,0,0], , , ,XL,"+(nAutoHeight_list[0])+",1)");
		out.println(sheet10_E4+"\r");
		out.println("^CELLLINE("+(nXCurPos+387)+","+(nYCurPos)+",79,"+(nAutoHeight_list[0])+",0,RGB[0,0,0],0)\r");
		out.println("^CELLLINE("+(nXCurPos+387)+","+(nYCurPos)+",79,"+(nAutoHeight_list[0])+",0,RGB[0,0,0],1)\r");
		out.println("^CELLLINE("+(nXCurPos+387)+","+(nYCurPos)+",79,"+(nAutoHeight_list[0])+",0,RGB[0,0,0],2)\r");
		out.println("^CELLLINE("+(nXCurPos+387)+","+(nYCurPos)+",79,"+(nAutoHeight_list[0])+",0,RGB[0,0,0],3)\r");
		out.print("^PRINT("+(nXCurPos+387)+","+(nYCurPos)+",79,1,10,0/,돋움체,RGB[0,0,0], , , ,XL,"+(nAutoHeight_list[0])+",1)");
		out.println(sheet10_F4+"\r");
		out.println("^CELLLINE("+(nXCurPos+466)+","+(nYCurPos)+",72,"+(nAutoHeight_list[0])+",0,RGB[0,0,0],0)\r");
		out.println("^CELLLINE("+(nXCurPos+466)+","+(nYCurPos)+",72,"+(nAutoHeight_list[0])+",0,RGB[0,0,0],1)\r");
		out.println("^CELLLINE("+(nXCurPos+466)+","+(nYCurPos)+",72,"+(nAutoHeight_list[0])+",0,RGB[0,0,0],2)\r");
		out.println("^CELLLINE("+(nXCurPos+466)+","+(nYCurPos)+",72,"+(nAutoHeight_list[0])+",0,RGB[0,0,0],3)\r");
		out.print("^PRINT("+(nXCurPos+466)+","+(nYCurPos)+",72,1,10,0/,돋움체,RGB[0,0,0], , , ,NONE,"+(nAutoHeight_list[0])+",1)");
		out.println(sheet10_G4+"\r");
		out.println("^CELLLINE("+(nXCurPos+538)+","+(nYCurPos)+",218,"+(nAutoHeight_list[0])+",0,RGB[0,0,0],0)\r");
		out.println("^CELLLINE("+(nXCurPos+538)+","+(nYCurPos)+",218,"+(nAutoHeight_list[0])+",0,RGB[0,0,0],1)\r");
		out.println("^CELLLINE("+(nXCurPos+538)+","+(nYCurPos)+",218,"+(nAutoHeight_list[0])+",0,RGB[0,0,0],2)\r");
		out.println("^CELLLINE("+(nXCurPos+538)+","+(nYCurPos)+",218,"+(nAutoHeight_list[0])+",0,RGB[0,0,0],3)\r");
		out.print("^PRINT("+(nXCurPos+538)+","+(nYCurPos)+",218,0,10,0/,돋움체,RGB[0,0,0], , , ,NONE,"+(nAutoHeight_list[0])+",1)");
		out.println(sheet10_H4+"\r");
	}

	//파라미터 설정 함수
	private void setParam(){
		p_grcode_Param=GetB(request.getParameter("p_grcode"));
		p_grseq_Param=GetB(request.getParameter("p_grseq"));
	}

	//-----Connection 및 Statement 객체 생성 함수-----
	private void createConnAndStateObject() throws Exception{
		//DUNET Connection 객체 생성
		Class.forName("oracle.jdbc.driver.OracleDriver");
		conn_DUNET = DriverManager.getConnection("jdbc:oracle:thin:@(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=192.168.12.203)(PORT=1521))(ADDRESS=(PROTOCOL=TCP)(HOST=192.168.12.204)(PORT=1521))(FAILOVER=on)(LOAD_BALANCE=off))(CONNECT_DATA=(SERVER=DEDICATED)(SERVICE_NAME=LOTI)))","cmlms","fhxl21");stat_list=conn_DUNET.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
		stat_gr_info=conn_DUNET.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
	}

	//-----SQL문 변수 초기화 함수-----
	private void initSQLConst(){
		sql_list = "SELECT a.off_userno as off_userno,SearchUserid(a.userno) as user_id,a.name as name, ";
		sql_list = sql_list + "to_char(a.appdate,'YYYY.MM.DD') as appdate, ";
		sql_list = sql_list + "b.email as email,a.telno as telno,SearchDeptnm(b.dept) as deptnm, ";
		sql_list = sql_list + "substr(b.resno,1,6) || '-' || substr(b.resno,7,7) as resno,b.addr as addr, ";
		sql_list = sql_list + "b.hp as hp FROM  CMTB_OFFAPP_INFO a, CMTB_OFFMEMBER b WHERE a.off_userno=b.off_userno  ";
		sql_list = sql_list + "AND a.grcode='" + p_grcode_Param + "' AND a.grseq='" + p_grseq_Param + "' AND a.grchk='Y'";
		sql_gr_info = "SELECT substr(GRSEQ,1,4)||'년도 ' || GRCODENIKNM || ' ' || to_number(substr(grseq,5,2)) || '기' as GRCODENM  ";
		sql_gr_info = sql_gr_info + "FROM CMTB_GRSEQ  ";
		sql_gr_info = sql_gr_info + "WHERE grcode='" + p_grcode_Param + "' AND grseq='" + p_grseq_Param + "'";
	}

	//-----ResultSet 객체에서 필드 값 설정 함수-----
	//ResultSet list 객체에서 필드 값 설정 함수
	private void setFieldVariableFromlist() throws Exception{
		list_OFF_USERNO=GetB(list.getString(1));
		list_USER_ID=GetB(list.getString(2));
		list_NAME=GetB(list.getString(3));
		list_APPDATE=GetB(list.getString(4));
		list_EMAIL=GetB(list.getString(5));
		list_TELNO=GetB(list.getString(6));
		list_DEPTNM=GetB(list.getString(7));
		list_RESNO=GetB(list.getString(8));
		list_ADDR=GetB(list.getString(9));
		list_HP=GetB(list.getString(10));
	}

	//ResultSet list 객체의 필드 값 초기화 함수
	private void setFieldInitFromlist(){
		list_OFF_USERNO="";
		list_USER_ID="";
		list_NAME="";
		list_APPDATE="";
		list_EMAIL="";
		list_TELNO="";
		list_DEPTNM="";
		list_RESNO="";
		list_ADDR="";
		list_HP="";
	}

	//ResultSet gr_info 객체에서 필드 값 설정 함수
	private void setFieldVariableFromgr_info() throws Exception{
		gr_info_GRCODENM=GetB(gr_info.getString(1));
	}

	//ResultSet gr_info 객체의 필드 값 초기화 함수
	private void setFieldInitFromgr_info(){
		gr_info_GRCODENM="";
	}

	//-----고정 데이터 초기화 함수-----
	private void initConstVarient(){
		sheet10_A1="오프라인 교육생명단";
		sheet10_A5="#PAGE / #TOTALPAGE";
		sheet10_A3="No";
		sheet10_B3="주민번호";
		sheet10_C3="이름";
		sheet10_D3="기관명";
		sheet10_E3="Email";
		sheet10_F3="연락처";
		sheet10_G3="HP";
		sheet10_H3="주소";
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
