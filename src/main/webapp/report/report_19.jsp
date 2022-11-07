<%
/* ### Generated by AIDesigner 3.7.1.22 ### */
%>

<%@ page language="java" import="java.sql.*,java.io.*,java.text.*,java.util.*" %>
<%@ page contentType="text/plain; charset=euc-kr" %>
<%@ page import="oracle.sql.*,oracle.jdbc.*" %>

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
	String sheet10_C1;
	String sheet10_F1;
	int[] nAutoHeight_a=new int[1];
	String sheet10_A2;
	String sheet10_B2;
	String sheet10_C2;
	String sheet10_D2;
	String sheet10_E2;
	String sheet10_F2;
	String sheet10_G2;

	//-----Connection, Statement, ResultSet 객체 선언-----
	private Connection conn_DUNET;		//DSN DUNET Connection 객체
	private CallableStatement cs_WRTOOL_TMINFO_CUR_timelist;	//ResultSet WRTOOL_TMINFO_CUR_timelist 객체를 생성하기 위한 CallableStatement 객체
	private ResultSet WRTOOL_TMINFO_CUR_timelist;		//ResultSet WRTOOL_TMINFO_CUR_timelist 객체

	//-----쿼리 필드 변수 선언-----
	//ResultSet WRTOOL_TMINFO_CUR_timelist 객체에서 필드 값을 받는 쿼리 필드 변수
	private String WRTOOL_TMINFO_CUR_timelist_GOSI;
	private String WRTOOL_TMINFO_CUR_timelist_TIMEVAL;
	private String WRTOOL_TMINFO_CUR_timelist_LECVAL2;
	private String WRTOOL_TMINFO_CUR_timelist_LECVAL3;
	private String WRTOOL_TMINFO_CUR_timelist_LECVAL4;
	private String WRTOOL_TMINFO_CUR_timelist_LECVAL5;
	private String WRTOOL_TMINFO_CUR_timelist_LECVAL6;

	//파라미터 변수 선언
	String p_grcode1_Param;
	String p_grseq1_Param;
	String p_week1_Param;
	String p_type1_Param;
	String p_limit1_Param;
	String p_tmtitle1_Param;
	String p_clroom1_Param;

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
				if(WRTOOL_TMINFO_CUR_timelist!=null) WRTOOL_TMINFO_CUR_timelist.close();
				if(cs_WRTOOL_TMINFO_CUR_timelist!=null) cs_WRTOOL_TMINFO_CUR_timelist.close();
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
		initSheetVariant(69, 121, 518, 759, true);

		//시작 페이지 번호 출력
		out.print("-- " + nPageNum + " PAGE --\r");

		//밴드 함수 호출
		getScriptFromtitle(true, true);    //머리글 밴드 호출
		getScriptFroma(true);    //반복 밴드 호출

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
			//데이터 변수 초기화
			sheet10_C1="";

			//데이터 변수 할당
			sheet10_C1= "◈" +  p_tmtitle1_Param + "시간표";
		}   //end if(bIsFirst)

		//AI 스크립트 출력
		if(bIsPrint){   //감추기 속성이 지정되지 않으면 bIsPrint는 true
			//스크립트 출력 함수 호출
			writeScripttitle();
		}   //end if(bIsPrint)
	}

	//-----a RepeatBand Start-----
	//-----소속 쉬트 : SHEET=Sheet1   FRAME=Frame0
	//-----밴드 이름 : a
	//-----밴드 종류 : 반복 밴드
	//-----bIsPrint : 감추기 속성 설정 여부 true면 출력, false면 스크립트를 생성하지 않음
	private void getScriptFroma(boolean bIsPrint) throws Exception{
		//지역 변수 선언 및 초기화
		int nBandHeight=20;    //밴드 출력 높이
		boolean bIsFirst=true;
		//폰트명 : 굴림체
		//폰트 사이즈 : 10
		//각 문자별 폭을 할당할 배열 선언
		int[] charWidth = {5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,10};

		//데이터 변수 초기화
		sheet10_A2="";
		sheet10_B2="";
		sheet10_C2="";
		sheet10_D2="";
		sheet10_E2="";
		sheet10_F2="";
		sheet10_G2="";

		//DataSet 객체 생성
		//ResultSet WRTOOL_TMINFO_CUR_timelist 객체의 생성
		if(WRTOOL_TMINFO_CUR_timelist==null){
			WRTOOL_TMINFO_CUR_timelist = cs_WRTOOL_TMINFO_CUR_timelist.executeQuery();
			WRTOOL_TMINFO_CUR_timelist=(ResultSet)cs_WRTOOL_TMINFO_CUR_timelist.getObject(6);
		}else{
			WRTOOL_TMINFO_CUR_timelist.beforeFirst();
		}

		while(WRTOOL_TMINFO_CUR_timelist.next()){   //자동으로 생성되는 반복 밴드의 루프문
			//데이터 fetch
			setFieldVariableFromWRTOOL_TMINFO_CUR_timelist();	//RecordSet WRTOOL_TMINFO_CUR_timelist에서 필드 값 설정

			if(bIsFirst){   //밴드 호출 후 루프 내에서 한번 만 실행되는 코드
			}   //end if(bIsFirst)

			//데이터 변수 할당
			sheet10_A2=WRTOOL_TMINFO_CUR_timelist_GOSI;
			sheet10_B2=WRTOOL_TMINFO_CUR_timelist_TIMEVAL;
			sheet10_C2=WRTOOL_TMINFO_CUR_timelist_LECVAL2;
			sheet10_D2=WRTOOL_TMINFO_CUR_timelist_LECVAL3;
			sheet10_E2=WRTOOL_TMINFO_CUR_timelist_LECVAL4;
			sheet10_F2=WRTOOL_TMINFO_CUR_timelist_LECVAL5;
			sheet10_G2=WRTOOL_TMINFO_CUR_timelist_LECVAL6;

			sheet10_B2 = sheet10_B2.replaceAll("<br>","\r");
			sheet10_D2 = sheet10_D2.replaceAll("<br>","\r");
			sheet10_E2 = sheet10_E2.replaceAll("<br>","\r");
			sheet10_F2 = sheet10_F2.replaceAll("<br>","\r");
			sheet10_G2 = sheet10_G2.replaceAll("<br>","\r");

			//Auto Size Code
			nAutoHeight_a[0]=0;
			nAutoHeight_a[0]=getPrintHeight(sheet10_A2, charWidth, 10, 26, 20, nAutoHeight_a[0]);
			nAutoHeight_a[0]=getPrintHeight(sheet10_B2, charWidth, 10, 76, 20, nAutoHeight_a[0]);
			nAutoHeight_a[0]=getPrintHeight(sheet10_C2, charWidth, 10, 69, 20, nAutoHeight_a[0]);
			nAutoHeight_a[0]=getPrintHeight(sheet10_D2, charWidth, 10, 69, 20, nAutoHeight_a[0]);
			nAutoHeight_a[0]=getPrintHeight(sheet10_E2, charWidth, 10, 69, 20, nAutoHeight_a[0]);
			nAutoHeight_a[0]=getPrintHeight(sheet10_F2, charWidth, 10, 69, 20, nAutoHeight_a[0]);
			nAutoHeight_a[0]=getPrintHeight(sheet10_G2, charWidth, 10, 69, 20, nAutoHeight_a[0]);
			nAutoHeight_a[0]=nAutoHeight_a[0]+20;
			nBandHeight=nAutoHeight_a[0];   //밴드 출력 높이 설정

			//AI 스크립트 출력
			if(bIsPrint){   //감추기 속성이 지정되지 않으면 bIsPrint는 true
				if(isPageSkip(nYCurPos+nBandHeight)){   //스크립트 출력 영역 검사
					//페이지 스킵 함수 호출
					pageSkip(10);
				}   //end if(page skip test)

				//스크립트 출력 함수 호출
				writeScripta();

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
		out.print("^PRINT(171,83,207,1,13,0/,굴림체,RGB[0,0,0],BOLD, , ,NONE,38,1)");
		out.println(sheet10_C1+"\r");
		out.print("^PRINT(378,83,138,2,11,0/,굴림체,RGB[0,0,0], , , ,NONE,38,1)");
		out.println(sheet10_F1+"\r");
		out.print("^PRINT(351,97,,2,12,0/,굴림체,RGB[0,0,100],BOLD, , ,NONE,38,1)");
		out.println("※ 9시까지 등록 및 입실을 완료해주십시오."+"\r");
	}

	//----a 스크립트 문 출력 함수----
	private void writeScripta( ) throws Exception{
		//스크립트문 생성
		out.println("^CELLLINE("+(nXCurPos)+","+(nYCurPos)+",26,"+(nAutoHeight_a[0])+",0,RGB[0,0,0],0)\r");
		out.println("^CELLLINE("+(nXCurPos)+","+(nYCurPos)+",26,"+(nAutoHeight_a[0])+",0,RGB[0,0,0],1)\r");
		out.println("^CELLLINE("+(nXCurPos)+","+(nYCurPos)+",26,"+(nAutoHeight_a[0])+",0,RGB[0,0,0],2)\r");
		out.println("^CELLLINE("+(nXCurPos)+","+(nYCurPos)+",26,"+(nAutoHeight_a[0])+",0,RGB[0,0,0],3)\r");
		out.print("^PRINT("+(nXCurPos)+","+(nYCurPos)+",26,1,10,0/,굴림체,RGB[0,0,0], , , ,XL,"+(nAutoHeight_a[0])+",1)");
		out.println(sheet10_A2+"\r");
		out.println("^CELLLINE("+(nXCurPos+26)+","+(nYCurPos)+",76,"+(nAutoHeight_a[0])+",0,RGB[0,0,0],0)\r");
		out.println("^CELLLINE("+(nXCurPos+26)+","+(nYCurPos)+",76,"+(nAutoHeight_a[0])+",0,RGB[0,0,0],1)\r");
		out.println("^CELLLINE("+(nXCurPos+26)+","+(nYCurPos)+",76,"+(nAutoHeight_a[0])+",0,RGB[0,0,0],2)\r");
		out.println("^CELLLINE("+(nXCurPos+26)+","+(nYCurPos)+",76,"+(nAutoHeight_a[0])+",0,RGB[0,0,0],3)\r");
		out.print("^PRINT("+(nXCurPos+26)+","+(nYCurPos)+",76,1,10,0/,굴림체,RGB[0,0,0], , , ,XL,"+(nAutoHeight_a[0])+",1)");
		out.println(sheet10_B2+"\r");
		out.println("^CELLLINE("+(nXCurPos+102)+","+(nYCurPos)+",69,"+(nAutoHeight_a[0])+",0,RGB[0,0,0],0)\r");
		out.println("^CELLLINE("+(nXCurPos+102)+","+(nYCurPos)+",69,"+(nAutoHeight_a[0])+",0,RGB[0,0,0],1)\r");
		out.println("^CELLLINE("+(nXCurPos+102)+","+(nYCurPos)+",69,"+(nAutoHeight_a[0])+",0,RGB[0,0,0],2)\r");
		out.println("^CELLLINE("+(nXCurPos+102)+","+(nYCurPos)+",69,"+(nAutoHeight_a[0])+",0,RGB[0,0,0],3)\r");
		out.print("^PRINT("+(nXCurPos+102)+","+(nYCurPos)+",69,1,10,0/,굴림체,RGB[0,0,0], , , ,XL,"+(nAutoHeight_a[0])+",1)");
		out.println(sheet10_C2+"\r");
		out.println("^CELLLINE("+(nXCurPos+171)+","+(nYCurPos)+",69,"+(nAutoHeight_a[0])+",0,RGB[0,0,0],0)\r");
		out.println("^CELLLINE("+(nXCurPos+171)+","+(nYCurPos)+",69,"+(nAutoHeight_a[0])+",0,RGB[0,0,0],1)\r");
		out.println("^CELLLINE("+(nXCurPos+171)+","+(nYCurPos)+",69,"+(nAutoHeight_a[0])+",0,RGB[0,0,0],2)\r");
		out.println("^CELLLINE("+(nXCurPos+171)+","+(nYCurPos)+",69,"+(nAutoHeight_a[0])+",0,RGB[0,0,0],3)\r");
		out.print("^PRINT("+(nXCurPos+171)+","+(nYCurPos)+",69,1,10,0/,굴림체,RGB[0,0,0], , , ,XL,"+(nAutoHeight_a[0])+",1)");
		out.println(sheet10_D2+"\r");
		out.println("^CELLLINE("+(nXCurPos+240)+","+(nYCurPos)+",69,"+(nAutoHeight_a[0])+",0,RGB[0,0,0],0)\r");
		out.println("^CELLLINE("+(nXCurPos+240)+","+(nYCurPos)+",69,"+(nAutoHeight_a[0])+",0,RGB[0,0,0],1)\r");
		out.println("^CELLLINE("+(nXCurPos+240)+","+(nYCurPos)+",69,"+(nAutoHeight_a[0])+",0,RGB[0,0,0],2)\r");
		out.println("^CELLLINE("+(nXCurPos+240)+","+(nYCurPos)+",69,"+(nAutoHeight_a[0])+",0,RGB[0,0,0],3)\r");
		out.print("^PRINT("+(nXCurPos+240)+","+(nYCurPos)+",69,1,10,0/,굴림체,RGB[0,0,0], , , ,XL,"+(nAutoHeight_a[0])+",1)");
		out.println(sheet10_E2+"\r");
		out.println("^CELLLINE("+(nXCurPos+309)+","+(nYCurPos)+",69,"+(nAutoHeight_a[0])+",0,RGB[0,0,0],0)\r");
		out.println("^CELLLINE("+(nXCurPos+309)+","+(nYCurPos)+",69,"+(nAutoHeight_a[0])+",0,RGB[0,0,0],1)\r");
		out.println("^CELLLINE("+(nXCurPos+309)+","+(nYCurPos)+",69,"+(nAutoHeight_a[0])+",0,RGB[0,0,0],2)\r");
		out.println("^CELLLINE("+(nXCurPos+309)+","+(nYCurPos)+",69,"+(nAutoHeight_a[0])+",0,RGB[0,0,0],3)\r");
		out.print("^PRINT("+(nXCurPos+309)+","+(nYCurPos)+",69,1,10,0/,굴림체,RGB[0,0,0], , , ,XL,"+(nAutoHeight_a[0])+",1)");
		out.println(sheet10_F2+"\r");
		out.println("^CELLLINE("+(nXCurPos+378)+","+(nYCurPos)+",69,"+(nAutoHeight_a[0])+",0,RGB[0,0,0],0)\r");
		out.println("^CELLLINE("+(nXCurPos+378)+","+(nYCurPos)+",69,"+(nAutoHeight_a[0])+",0,RGB[0,0,0],1)\r");
		out.println("^CELLLINE("+(nXCurPos+378)+","+(nYCurPos)+",69,"+(nAutoHeight_a[0])+",0,RGB[0,0,0],2)\r");
		out.println("^CELLLINE("+(nXCurPos+378)+","+(nYCurPos)+",69,"+(nAutoHeight_a[0])+",0,RGB[0,0,0],3)\r");
		out.print("^PRINT("+(nXCurPos+378)+","+(nYCurPos)+",69,1,10,0/,굴림체,RGB[0,0,0], , , ,XL,"+(nAutoHeight_a[0])+",1)");
		out.println(sheet10_G2+"\r");
	}

	//파라미터 설정 함수
	private void setParam(){
		p_grcode1_Param=toKor(GetB(request.getParameter("p_grcode1")));
		p_grseq1_Param=toKor(GetB(request.getParameter("p_grseq1")));
		p_week1_Param=toKor(GetB(request.getParameter("p_week1")));
		p_type1_Param=toKor(GetB(request.getParameter("p_type1")));
		p_limit1_Param=toKor(GetB(request.getParameter("p_limit1")));
		p_tmtitle1_Param=toKor(GetB(request.getParameter("p_tmtitle1")));
		p_clroom1_Param=toKor(GetB(request.getParameter("p_clroom1")));
	}

	//-----Connection 및 Statement 객체 생성 함수-----
	private void createConnAndStateObject() throws Exception{
		//DUNET Connection 객체 생성
		Class.forName("oracle.jdbc.driver.OracleDriver").newInstance();
		conn_DUNET=DriverManager.getConnection("jdbc:oracle:thin:@(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=192.168.12.203)(PORT=1521))(ADDRESS=(PROTOCOL=TCP)(HOST=192.168.12.204)(PORT=1521))(FAILOVER=on)(LOAD_BALANCE=off))(CONNECT_DATA=(SERVER=DEDICATED)(SERVICE_NAME=LOTI)))","inchlms","fhxl21");cs_WRTOOL_TMINFO_CUR_timelist=conn_DUNET.prepareCall("{call WRTOOL.TMINFO_CUR(?, ?, ?, ?, ?, ?)}");
		cs_WRTOOL_TMINFO_CUR_timelist.setString(1, p_grcode1_Param);
		cs_WRTOOL_TMINFO_CUR_timelist.setString(2, p_grseq1_Param);
		cs_WRTOOL_TMINFO_CUR_timelist.setInt(3, Integer.parseInt(Get0(p_week1_Param)));
		cs_WRTOOL_TMINFO_CUR_timelist.setString(4, p_type1_Param);
		cs_WRTOOL_TMINFO_CUR_timelist.setString(5, p_limit1_Param);
		cs_WRTOOL_TMINFO_CUR_timelist.registerOutParameter(6, OracleTypes.CURSOR);
	}

	//-----SQL문 변수 초기화 함수-----
	private void initSQLConst(){
	}

	//-----ResultSet 객체에서 필드 값 설정 함수-----
	//ResultSet WRTOOL_TMINFO_CUR_timelist 객체에서 필드 값 설정 함수
	private void setFieldVariableFromWRTOOL_TMINFO_CUR_timelist() throws Exception{
		WRTOOL_TMINFO_CUR_timelist_GOSI=GetB(WRTOOL_TMINFO_CUR_timelist.getString(1));
		WRTOOL_TMINFO_CUR_timelist_TIMEVAL=GetB(WRTOOL_TMINFO_CUR_timelist.getString(2));
		WRTOOL_TMINFO_CUR_timelist_LECVAL2=GetB(WRTOOL_TMINFO_CUR_timelist.getString(3));
		WRTOOL_TMINFO_CUR_timelist_LECVAL3=GetB(WRTOOL_TMINFO_CUR_timelist.getString(4));
		WRTOOL_TMINFO_CUR_timelist_LECVAL4=GetB(WRTOOL_TMINFO_CUR_timelist.getString(5));
		WRTOOL_TMINFO_CUR_timelist_LECVAL5=GetB(WRTOOL_TMINFO_CUR_timelist.getString(6));
		WRTOOL_TMINFO_CUR_timelist_LECVAL6=GetB(WRTOOL_TMINFO_CUR_timelist.getString(7));
	}

	//ResultSet WRTOOL_TMINFO_CUR_timelist 객체의 필드 값 초기화 함수
	private void setFieldInitFromWRTOOL_TMINFO_CUR_timelist(){
		WRTOOL_TMINFO_CUR_timelist_GOSI="";
		WRTOOL_TMINFO_CUR_timelist_TIMEVAL="";
		WRTOOL_TMINFO_CUR_timelist_LECVAL2="";
		WRTOOL_TMINFO_CUR_timelist_LECVAL3="";
		WRTOOL_TMINFO_CUR_timelist_LECVAL4="";
		WRTOOL_TMINFO_CUR_timelist_LECVAL5="";
		WRTOOL_TMINFO_CUR_timelist_LECVAL6="";
	}

	//-----고정 데이터 초기화 함수-----
	private void initConstVarient(){
		sheet10_F1="" + p_clroom1_Param + "";
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
