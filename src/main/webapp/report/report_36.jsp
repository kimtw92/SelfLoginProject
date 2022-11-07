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
	String sheet10_D1;
	String sheet10_A2;
	String sheet10_A3;
	String sheet10_B3;
	String sheet10_C3;
	String sheet10_D3;
	String sheet10_E3;
	String sheet10_F3;
	double sheet10_A4;
	String sheet10_B4;
	String sheet10_C4;
	String sheet10_D4;
	String sheet10_E4;
	String sheet10_F4;

	//-----Connection, Statement, ResultSet 객체 선언-----
	private Connection conn_DUNET;		//DSN DUNET Connection 객체
	private java.sql.Statement stat_qry_grcodenm;		//ResultSet qry_grcodenm 객체를 생성하기 위한 Statement 객체
	private ResultSet qry_grcodenm;		//ResultSet qry_grcodenm 객체
	private java.sql.Statement stat_Query;		//ResultSet Query 객체를 생성하기 위한 Statement 객체
	private ResultSet Query;		//ResultSet Query 객체

	//-----SQL 변수 선언-----
	private String sql_qry_grcodenm;		//ResultSet qry_grcodenm 객체를 생성하기 위한 쿼리문 저장
	private String sql_Query;		//ResultSet Query 객체를 생성하기 위한 쿼리문 저장

	//-----쿼리 필드 변수 선언-----
	//ResultSet qry_grcodenm 객체에서 필드 값을 받는 쿼리 필드 변수
	private String qry_grcodenm_GRCODENM;

	//ResultSet Query 객체에서 필드 값을 받는 쿼리 필드 변수
	private double Query_EDUNO;
	private String Query_DEPTNM;
	private String Query_JIKNM;
	private String Query_NAME;
	private String Query_SEX;
	private String Query_AGE;

	//파라미터 변수 선언
	String p_grcode_Param;
	String p_grseq_Param;
	String p_dept_Param;
	String p_dapcode_Param;

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
				if(Query!=null) Query.close();
				if(stat_Query!=null) stat_Query.close();
				if(qry_grcodenm!=null) qry_grcodenm.close();
				if(stat_qry_grcodenm!=null) stat_qry_grcodenm.close();
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
		initSheetVariant(41, 79, 546, 781, true);

		//시작 페이지 번호 출력
		out.print("-- " + nPageNum + " PAGE --\r");

		//밴드 함수 호출
		getScriptFromtitle(true, true);    //머리글 밴드 호출
		getScriptFromfoot(true, true);    //바닥글 밴드 호출
		getScriptFrommaster(true);    //반복 밴드 호출

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
			//DataSet 객체 생성
			//ResultSet qry_grcodenm 객체의 생성
			if(qry_grcodenm==null){
				qry_grcodenm = stat_qry_grcodenm.executeQuery(sql_qry_grcodenm);
			}else{
				qry_grcodenm.beforeFirst();
			}

			//데이터 fetch
			if(qry_grcodenm.next()){
				setFieldVariableFromqry_grcodenm();	//ResultSet qry_grcodenm에서 필드 값 설정
			}else{
				setFieldInitFromqry_grcodenm();	//ResultSet qry_grcodenm의 필드 값 초기화
			}

			//데이터 변수 초기화
			sheet10_A1="";

			//데이터 변수 할당
			sheet10_A1=qry_grcodenm_GRCODENM;
		}   //end if(bIsFirst)

		//AI 스크립트 출력
		if(bIsPrint){   //감추기 속성이 지정되지 않으면 bIsPrint는 true
			//스크립트 출력 함수 호출
			writeScripttitle();
		}   //end if(bIsPrint)
	}

	//----foot FooterBand Start----
	//----소속 쉬트 : SHEET=Sheet1    FRAME=Frame0
	//----밴드 이름 : foot
	//----밴드 종류 : 바닥글 밴드
	//----bIsFrist : 쉬트 함수에서 최초로 호출될 때 true, 페이지 스킵 함수에서 호출될 때 false
	//----bIsPrint : 감추기 속성 설정 여부. treu면 출력, false면 AI 스크립트를 생성하지 않음.
	private void getScriptFromfoot(boolean bIsFirst, boolean bIsPrint) throws Exception{
		if(bIsFirst){   //밴드 최초 호출 시에만 실행되는 코드
		}   //end if(bIsFirst)

		//AI 스크립트 출력
		if(bIsPrint){   //감추기 속성이 지정되지 않으면 bIsPrint는 true
			//스크립트 출력 함수 호출
			writeScriptfoot();
		}   //end if(bIsPrint)
	}

	//----header RepeatHeader Start----
	//----소속 쉬트 : SHEET=Sheet1    FRAME=Frame0
	//----밴드 이름 : header
	//----밴드 종류 : 반복 헤더
	//----bIsFrist : 반복 밴드 함수에서 최초로 호출될 때 true, 그 이후 호출될 때 false
	//----bIsPrint : 감추기 속성 설정 여부. treu면 출력, false면 AI 스크립트를 생성하지 않음.
	private void getScriptFromheader(boolean bIsFirst, boolean bIsPrint) throws Exception{
		//지역 변수 선언 및 초기화
		int nBandHeight=32;	//밴드 출력 높이

		if(bIsFirst){   //밴드 최초 호출 시에만 실행되는 코드
		}   //end if(bIsFirst)

		//AI 스크립트 출력
		if(bIsPrint){   //감추기 속성이 지정되지 않으면 bIsPrint는 true
			//스크립트 출력 영역 검사
			if(isPageSkip(nYCurPos+nBandHeight)){
				pageSkip(10);
			}

			//스크립트 출력 함수 호출
			writeScriptheader();

			//다음 출력 좌표 설정
			nYCurPos=nYCurPos+nBandHeight;
		}   //end if(bIsPrint)
	}

	//-----master RepeatBand Start-----
	//-----소속 쉬트 : SHEET=Sheet1   FRAME=Frame0
	//-----밴드 이름 : master
	//-----밴드 종류 : 반복 밴드
	//-----bIsPrint : 감추기 속성 설정 여부 true면 출력, false면 스크립트를 생성하지 않음
	private void getScriptFrommaster(boolean bIsPrint) throws Exception{
		//지역 변수 선언 및 초기화
		int nBandHeight=20;    //밴드 출력 높이
		boolean bIsFirst=true;

		//데이터 변수 초기화
		sheet10_A4=0;
		sheet10_B4="";
		sheet10_C4="";
		sheet10_D4="";
		sheet10_E4="";
		sheet10_F4="";

		//DataSet 객체 생성
		//ResultSet Query 객체의 생성
		if(Query==null){
			Query = stat_Query.executeQuery(sql_Query);
		}else{
			Query.beforeFirst();
		}

		while(Query.next()){   //자동으로 생성되는 반복 밴드의 루프문
			//데이터 fetch
			setFieldVariableFromQuery();	//RecordSet Query에서 필드 값 설정

			if(bIsFirst){   //밴드 호출 후 루프 내에서 한번 만 실행되는 코드
				//반복 헤더 호출 및 조건 플래그 초기화
				getScriptFromheader(bIsFirst, true);	//반복 헤더 호출
			}   //end if(bIsFirst)

			//데이터 변수 할당
			sheet10_A4=Query_EDUNO;
			sheet10_B4=Query_DEPTNM;
			sheet10_C4=Query_JIKNM;
			sheet10_D4=Query_NAME;
			sheet10_E4=Query_SEX;
			sheet10_F4=Query_AGE;

			//AI 스크립트 출력
			if(bIsPrint){   //감추기 속성이 지정되지 않으면 bIsPrint는 true
				if(isPageSkip(nYCurPos+nBandHeight)){   //스크립트 출력 영역 검사
					//페이지 스킵 함수 호출
					pageSkip(10);

					//반복 헤더 및 부모 반복단위 호출
					getScriptFromheader(false, true);	//반복 헤더 호출
				}   //end if(page skip test)

				//스크립트 출력 함수 호출
				writeScriptmaster();

				//다음 출력 좌표 설정
				nYCurPos=nYCurPos+nBandHeight;
			}   //end if(bIsPrint)

			//bIsFirst 및 출력 라인 설정
			bIsFirst=false;
		}   //while end
	}

	//-----스크립트 출력 함수-----
	//----title 스크립트 문 출력 함수----
	private void writeScripttitle( ) throws Exception{
		//스크립트문 생성
		out.print("^PRINT(41,41,341,2,16,0/,돋움체,RGB[0,0,0],BOLD, , ,NONE,38,1)");
		out.println(sheet10_A1+"\r");
		out.print("^PRINT(382,41,163,1,16,0/,돋움체,RGB[0,0,0],BOLD, , ,NONE,38,1)");
		out.println(sheet10_D1+"\r");
	}

	//----foot 스크립트 문 출력 함수----
	private void writeScriptfoot( ) throws Exception{
		//스크립트문 생성
		out.print("^PRINT(41,781,504,1,10,0/,돋움체,RGB[0,0,0], , , ,NONE,20,1)");
		out.println(sheet10_A2+"\r");
	}

	//----header 스크립트 문 출력 함수----
	private void writeScriptheader( ) throws Exception{
		//스크립트문 생성
		out.println("^CELLBG("+(nXCurPos)+","+(nYCurPos)+",43,32,1,RGB[230,230,250],RGB[230,230,250],0)\r");
		out.println("^CELLLINE("+(nXCurPos)+","+(nYCurPos)+",43,32,0,RGB[0,0,0],0)\r");
		out.println("^CELLLINE("+(nXCurPos)+","+(nYCurPos)+",43,32,0,RGB[0,0,0],1)\r");
		out.println("^CELLLINE("+(nXCurPos)+","+(nYCurPos)+",43,32,0,RGB[0,0,0],2)\r");
		out.println("^CELLLINE("+(nXCurPos)+","+(nYCurPos)+",43,32,0,RGB[0,0,0],3)\r");
		out.print("^PRINT("+(nXCurPos)+","+(nYCurPos)+",43,1,10,0/,돋움체,RGB[0,0,0], , , ,NONE,32,1)");
		out.println(sheet10_A3+"\r");
		out.println("^CELLBG("+(nXCurPos+43)+","+(nYCurPos)+",149,32,1,RGB[230,230,250],RGB[230,230,250],0)\r");
		out.println("^CELLLINE("+(nXCurPos+43)+","+(nYCurPos)+",149,32,0,RGB[0,0,0],0)\r");
		out.println("^CELLLINE("+(nXCurPos+43)+","+(nYCurPos)+",149,32,0,RGB[0,0,0],1)\r");
		out.println("^CELLLINE("+(nXCurPos+43)+","+(nYCurPos)+",149,32,0,RGB[0,0,0],2)\r");
		out.println("^CELLLINE("+(nXCurPos+43)+","+(nYCurPos)+",149,32,0,RGB[0,0,0],3)\r");
		out.print("^PRINT("+(nXCurPos+43)+","+(nYCurPos)+",149,1,10,0/,돋움체,RGB[0,0,0], , , ,NONE,32,1)");
		out.println(sheet10_B3+"\r");
		out.println("^CELLBG("+(nXCurPos+192)+","+(nYCurPos)+",149,32,1,RGB[230,230,250],RGB[230,230,250],0)\r");
		out.println("^CELLLINE("+(nXCurPos+192)+","+(nYCurPos)+",149,32,0,RGB[0,0,0],0)\r");
		out.println("^CELLLINE("+(nXCurPos+192)+","+(nYCurPos)+",149,32,0,RGB[0,0,0],1)\r");
		out.println("^CELLLINE("+(nXCurPos+192)+","+(nYCurPos)+",149,32,0,RGB[0,0,0],2)\r");
		out.println("^CELLLINE("+(nXCurPos+192)+","+(nYCurPos)+",149,32,0,RGB[0,0,0],3)\r");
		out.print("^PRINT("+(nXCurPos+192)+","+(nYCurPos)+",149,1,10,0/,돋움체,RGB[0,0,0], , , ,NONE,32,1)");
		out.println(sheet10_C3+"\r");
		out.println("^CELLBG("+(nXCurPos+341)+","+(nYCurPos)+",55,32,1,RGB[230,230,250],RGB[230,230,250],0)\r");
		out.println("^CELLLINE("+(nXCurPos+341)+","+(nYCurPos)+",55,32,0,RGB[0,0,0],0)\r");
		out.println("^CELLLINE("+(nXCurPos+341)+","+(nYCurPos)+",55,32,0,RGB[0,0,0],1)\r");
		out.println("^CELLLINE("+(nXCurPos+341)+","+(nYCurPos)+",55,32,0,RGB[0,0,0],2)\r");
		out.println("^CELLLINE("+(nXCurPos+341)+","+(nYCurPos)+",55,32,0,RGB[0,0,0],3)\r");
		out.print("^PRINT("+(nXCurPos+341)+","+(nYCurPos)+",55,1,10,0/,돋움체,RGB[0,0,0], , , ,NONE,32,1)");
		out.println(sheet10_D3+"\r");
		out.println("^CELLBG("+(nXCurPos+396)+","+(nYCurPos)+",54,32,1,RGB[230,230,250],RGB[230,230,250],0)\r");
		out.println("^CELLLINE("+(nXCurPos+396)+","+(nYCurPos)+",54,32,0,RGB[0,0,0],0)\r");
		out.println("^CELLLINE("+(nXCurPos+396)+","+(nYCurPos)+",54,32,0,RGB[0,0,0],1)\r");
		out.println("^CELLLINE("+(nXCurPos+396)+","+(nYCurPos)+",54,32,0,RGB[0,0,0],2)\r");
		out.println("^CELLLINE("+(nXCurPos+396)+","+(nYCurPos)+",54,32,0,RGB[0,0,0],3)\r");
		out.print("^PRINT("+(nXCurPos+396)+","+(nYCurPos)+",54,1,10,0/,돋움체,RGB[0,0,0], , , ,NONE,32,1)");
		out.println(sheet10_E3+"\r");
		out.println("^CELLBG("+(nXCurPos+450)+","+(nYCurPos)+",54,32,1,RGB[230,230,250],RGB[230,230,250],0)\r");
		out.println("^CELLLINE("+(nXCurPos+450)+","+(nYCurPos)+",54,32,0,RGB[0,0,0],0)\r");
		out.println("^CELLLINE("+(nXCurPos+450)+","+(nYCurPos)+",54,32,0,RGB[0,0,0],1)\r");
		out.println("^CELLLINE("+(nXCurPos+450)+","+(nYCurPos)+",54,32,0,RGB[0,0,0],2)\r");
		out.println("^CELLLINE("+(nXCurPos+450)+","+(nYCurPos)+",54,32,0,RGB[0,0,0],3)\r");
		out.print("^PRINT("+(nXCurPos+450)+","+(nYCurPos)+",54,1,10,0/,돋움체,RGB[0,0,0], , , ,NONE,32,1)");
		out.println(sheet10_F3+"\r");
	}

	//----master 스크립트 문 출력 함수----
	private void writeScriptmaster( ) throws Exception{
		//스크립트문 생성
		out.println("^CELLLINE("+(nXCurPos)+","+(nYCurPos)+",43,20,0,RGB[0,0,0],0)\r");
		out.println("^CELLLINE("+(nXCurPos)+","+(nYCurPos)+",43,20,0,RGB[0,0,0],1)\r");
		out.println("^CELLLINE("+(nXCurPos)+","+(nYCurPos)+",43,20,0,RGB[0,0,0],2)\r");
		out.println("^CELLLINE("+(nXCurPos)+","+(nYCurPos)+",43,20,0,RGB[0,0,0],3)\r");
		out.print("^PRINT("+(nXCurPos)+","+(nYCurPos)+",43,1,10,1/0/0,돋움체,RGB[0,0,0], , , ,NONE,20,1)");
		out.println(sheet10_A4+"\r");
		out.println("^CELLLINE("+(nXCurPos+43)+","+(nYCurPos)+",149,20,0,RGB[0,0,0],0)\r");
		out.println("^CELLLINE("+(nXCurPos+43)+","+(nYCurPos)+",149,20,0,RGB[0,0,0],1)\r");
		out.println("^CELLLINE("+(nXCurPos+43)+","+(nYCurPos)+",149,20,0,RGB[0,0,0],2)\r");
		out.println("^CELLLINE("+(nXCurPos+43)+","+(nYCurPos)+",149,20,0,RGB[0,0,0],3)\r");
		out.print("^PRINT("+(nXCurPos+43)+","+(nYCurPos)+",149,0,10,0/,돋움체,RGB[0,0,0], , , ,NONE,20,1)");
		out.println(sheet10_B4+"\r");
		out.println("^CELLLINE("+(nXCurPos+192)+","+(nYCurPos)+",149,20,0,RGB[0,0,0],0)\r");
		out.println("^CELLLINE("+(nXCurPos+192)+","+(nYCurPos)+",149,20,0,RGB[0,0,0],1)\r");
		out.println("^CELLLINE("+(nXCurPos+192)+","+(nYCurPos)+",149,20,0,RGB[0,0,0],2)\r");
		out.println("^CELLLINE("+(nXCurPos+192)+","+(nYCurPos)+",149,20,0,RGB[0,0,0],3)\r");
		out.print("^PRINT("+(nXCurPos+192)+","+(nYCurPos)+",149,0,10,0/,돋움체,RGB[0,0,0], , , ,NONE,20,1)");
		out.println(sheet10_C4+"\r");
		out.println("^CELLLINE("+(nXCurPos+341)+","+(nYCurPos)+",55,20,0,RGB[0,0,0],0)\r");
		out.println("^CELLLINE("+(nXCurPos+341)+","+(nYCurPos)+",55,20,0,RGB[0,0,0],1)\r");
		out.println("^CELLLINE("+(nXCurPos+341)+","+(nYCurPos)+",55,20,0,RGB[0,0,0],2)\r");
		out.println("^CELLLINE("+(nXCurPos+341)+","+(nYCurPos)+",55,20,0,RGB[0,0,0],3)\r");
		out.print("^PRINT("+(nXCurPos+341)+","+(nYCurPos)+",55,1,10,0/,돋움체,RGB[0,0,0], , , ,NONE,20,1)");
		out.println(sheet10_D4+"\r");
		out.println("^CELLLINE("+(nXCurPos+396)+","+(nYCurPos)+",54,20,0,RGB[0,0,0],0)\r");
		out.println("^CELLLINE("+(nXCurPos+396)+","+(nYCurPos)+",54,20,0,RGB[0,0,0],1)\r");
		out.println("^CELLLINE("+(nXCurPos+396)+","+(nYCurPos)+",54,20,0,RGB[0,0,0],2)\r");
		out.println("^CELLLINE("+(nXCurPos+396)+","+(nYCurPos)+",54,20,0,RGB[0,0,0],3)\r");
		out.print("^PRINT("+(nXCurPos+396)+","+(nYCurPos)+",54,1,10,0/,돋움체,RGB[0,0,0], , , ,NONE,20,1)");
		out.println(sheet10_E4+"\r");
		out.println("^CELLLINE("+(nXCurPos+450)+","+(nYCurPos)+",54,20,0,RGB[0,0,0],0)\r");
		out.println("^CELLLINE("+(nXCurPos+450)+","+(nYCurPos)+",54,20,0,RGB[0,0,0],1)\r");
		out.println("^CELLLINE("+(nXCurPos+450)+","+(nYCurPos)+",54,20,0,RGB[0,0,0],2)\r");
		out.println("^CELLLINE("+(nXCurPos+450)+","+(nYCurPos)+",54,20,0,RGB[0,0,0],3)\r");
		out.print("^PRINT("+(nXCurPos+450)+","+(nYCurPos)+",54,1,10,0/,돋움체,RGB[0,0,0], , , ,NONE,20,1)");
		out.println(sheet10_F4+"\r");
	}

	//파라미터 설정 함수
	private void setParam(){
		p_grcode_Param=toKor(GetB(request.getParameter("p_grcode")));
		p_grseq_Param=toKor(GetB(request.getParameter("p_grseq")));
		p_dept_Param=toKor(GetB(request.getParameter("p_dept")));
		p_dapcode_Param=toKor(GetB(request.getParameter("p_dapcode")));
	}

	//-----Connection 및 Statement 객체 생성 함수-----
	private void createConnAndStateObject() throws Exception{
		//DUNET Connection 객체 생성
		Class.forName("oracle.jdbc.driver.OracleDriver");
		conn_DUNET = DriverManager.getConnection("jdbc:oracle:thin:@(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=192.168.12.203)(PORT=1521))(ADDRESS=(PROTOCOL=TCP)(HOST=192.168.12.204)(PORT=1521))(FAILOVER=on)(LOAD_BALANCE=off))(CONNECT_DATA=(SERVER=DEDICATED)(SERVICE_NAME=LOTI)))","inchlms","fhxl21");stat_qry_grcodenm=conn_DUNET.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
		stat_Query=conn_DUNET.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
	}

	//-----SQL문 변수 초기화 함수-----
	private void initSQLConst(){
		sql_qry_grcodenm = "SELECT GRCODENIKNM || ' ' || SUBSTR(GRSEQ,1,4) || '년 ' || SUBSTR(GRSEQ,5,2) || '기' AS GRCODENM ";
		sql_qry_grcodenm = sql_qry_grcodenm + "FROM TB_GRSEQ ";
		sql_qry_grcodenm = sql_qry_grcodenm + "WHERE GRCODE = '" + p_grcode_Param + "' AND GRSEQ = '" + p_grseq_Param + "'";
		sql_Query = "select b.eduno ";
		sql_Query = sql_Query + "     ,DECODE(a.dept,'6280000',searchdeptnm(a.dept),REPLACE(searchdeptnm(a.dept),'인천광역시 ')) || ' ' || a.deptsub AS deptnm ";
		sql_Query = sql_Query + "     , decode(SearchJiknm(a.jik),'',a.mjiknm,SearchJiknm(a.jik)) as  jiknm ";
		sql_Query = sql_Query + "     , name ";
		sql_Query = sql_Query + "     , decode(decode(a.sex,'F','여','M','남'),'',decode(substr(resno,7,1),'1','남','2','여'),decode(a.sex,'F','여','M','남')) as sex ";
		//sql_Query = sql_Query + "     , SearchAge(a.resno) as age  ";
		sql_Query = sql_Query + "     , SearchAgebirthdate(a.birthdate) as age  ";
		sql_Query = sql_Query + "  FROM TB_MEMBER a ";
		sql_Query = sql_Query + "   , (SELECT userno ";
		sql_Query = sql_Query + "           , eduno,dept  ";
		sql_Query = sql_Query + "	FROM TB_APP_INFO  ";
		sql_Query = sql_Query + "       WHERE grcode = '" + p_grcode_Param + "' ";
		sql_Query = sql_Query + "       AND grseq    = '" + p_grseq_Param + "'  ";
		sql_Query = sql_Query + "       AND grchk    ='Y') b ";
		sql_Query = sql_Query + " WHERE a.userno = b.userno  ";
		if("6289999".equals(p_dept_Param)) {
			sql_Query = sql_Query + " and a.dapcode = '"+p_dapcode_Param+"' ";
		}
		sql_Query = sql_Query + " and decode('" + p_dept_Param + "', null, 1, '', 1,  b.dept, 1, 0) =1 ";
		sql_Query = sql_Query + " ORDER BY b.eduno,a.name asc";
	}

	//-----ResultSet 객체에서 필드 값 설정 함수-----
	//ResultSet qry_grcodenm 객체에서 필드 값 설정 함수
	private void setFieldVariableFromqry_grcodenm() throws Exception{
		qry_grcodenm_GRCODENM=GetB(qry_grcodenm.getString(1));
	}

	//ResultSet qry_grcodenm 객체의 필드 값 초기화 함수
	private void setFieldInitFromqry_grcodenm(){
		qry_grcodenm_GRCODENM="";
	}

	//ResultSet Query 객체에서 필드 값 설정 함수
	private void setFieldVariableFromQuery() throws Exception{
		Query_EDUNO=Query.getDouble(1);
		Query_DEPTNM=GetB(Query.getString(2));
		Query_JIKNM=GetB(Query.getString(3));
		Query_NAME=GetB(Query.getString(4));
		Query_SEX=GetB(Query.getString(5));
		Query_AGE=GetB(Query.getString(6));
	}

	//ResultSet Query 객체의 필드 값 초기화 함수
	private void setFieldInitFromQuery(){
		Query_EDUNO=0;
		Query_DEPTNM="";
		Query_JIKNM="";
		Query_NAME="";
		Query_SEX="";
		Query_AGE="";
	}

	//-----고정 데이터 초기화 함수-----
	private void initConstVarient(){
		sheet10_D1="교 육 생 명 단";
		sheet10_A2="#PAGE / #TOTALPAGE";
		sheet10_A3="교번";
		sheet10_B3="소속";
		sheet10_C3="직급";
		sheet10_D3="성명";
		sheet10_E3="성별";
		sheet10_F3="나이";
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
			getScriptFromfoot(false, true);		//바닥글 밴드 호출
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
