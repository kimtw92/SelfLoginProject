<%
/* ### Generated by AIDesigner 3.7.1.23 ### */
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
	String sheet10_D2;
	String sheet10_A3;
	String sheet10_B3;
	String sheet10_C3;
	String sheet10_D3;
	String sheet10_E3;
	long sheet10_A4;
	String sheet10_B4;
	String sheet10_C4;
	String sheet10_D4;
	String sheet10_E4;

	//-----Connection, Statement, ResultSet 객체 선언-----
	private Connection conn_DUNET;		//DSN DUNET Connection 객체
	private java.sql.Statement stat_list;		//ResultSet list 객체를 생성하기 위한 Statement 객체
	private ResultSet list;		//ResultSet list 객체

	//-----SQL 변수 선언-----
	private String sql_list;		//ResultSet list 객체를 생성하기 위한 쿼리문 저장

	//-----쿼리 필드 변수 선언-----
	//ResultSet list 객체에서 필드 값을 받는 쿼리 필드 변수
	private double list_NO;
	private String list_NAME;
	private String list_GADMINNM;
	private String list_GADMIN;
	private String list_DEPTNM;
	private String list_DEPT;
	private String list_IDATE;
	private String list_CDATE;
	private String list_LNAME;

	//파라미터 변수 선언
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
		initSheetVariant(41, 119, 546, 773, true);

		//시작 페이지 번호 출력
		out.print("-- " + nPageNum + " PAGE --\r");

		//밴드 함수 호출
		getScriptFromheader(true, true);    //머리글 밴드 호출
		getScriptFromlist(true);    //반복 밴드 호출

		//페이지 및 좌표 설정
		nMaxPage=(int)MAX((long)nMaxPage, (long)nPageNum);    //생성된 최대 페이지 번호 구하기
	}

	//-----밴드 함수-----
	//----header HeaderBand Start----
	//----소속 쉬트 : SHEET=Sheet1    FRAME=Frame0
	//----밴드 이름 : header
	//----밴드 종류 : 머리글 밴드
	//----bIsFrist : 쉬트 함수에서 최초로 호출될 때 true, 페이지 스킵 함수에서 호출될 때 false
	//----bIsPrint : 감추기 속성 설정 여부. true면 출력, false면 AI 스크립트를 생성하지 않음.
	private void getScriptFromheader(boolean bIsFirst, boolean bIsPrint) throws Exception{
		if(bIsFirst){   //밴드 최초 호출 시에만 실행되는 코드
		}   //end if(bIsFirst)

		//AI 스크립트 출력
		if(bIsPrint){   //감추기 속성이 지정되지 않으면 bIsPrint는 true
			//스크립트 출력 함수 호출
			writeScriptheader();
		}   //end if(bIsPrint)
	}

	//----listHeader RepeatHeader Start----
	//----소속 쉬트 : SHEET=Sheet1    FRAME=Frame0
	//----밴드 이름 : listHeader
	//----밴드 종류 : 반복 헤더
	//----bIsFrist : 반복 밴드 함수에서 최초로 호출될 때 true, 그 이후 호출될 때 false
	//----bIsPrint : 감추기 속성 설정 여부. true면 출력, false면 AI 스크립트를 생성하지 않음.
	private void getScriptFromlistHeader(boolean bIsFirst, boolean bIsPrint) throws Exception{
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
			writeScriptlistHeader();

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

		//데이터 변수 초기화
		sheet10_A4=0L;
		sheet10_B4="";
		sheet10_C4="";
		sheet10_D4="";
		sheet10_E4="";

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
				getScriptFromlistHeader(bIsFirst, true);	//반복 헤더 호출
			}   //end if(bIsFirst)

			//데이터 변수 할당
			sheet10_A4=COUNT(sheet10_A4);
			sheet10_B4=list_NAME;
			sheet10_C4=list_IDATE;
			sheet10_D4=list_CDATE;
			sheet10_E4=list_LNAME;

			//AI 스크립트 출력
			if(bIsPrint){   //감추기 속성이 지정되지 않으면 bIsPrint는 true
				if(isPageSkip(nYCurPos+nBandHeight)){   //스크립트 출력 영역 검사
					//페이지 스킵 함수 호출
					pageSkip(10);

					//반복 헤더 및 부모 반복단위 호출
					getScriptFromlistHeader(false, true);	//반복 헤더 호출
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
	//----header 스크립트 문 출력 함수----
	private void writeScriptheader( ) throws Exception{
		//스크립트문 생성
		out.print("^PRINT(41,69,505,1,16,0/,굴림체,RGB[0,0,0],BOLD, , ,NONE,30,1)");
		out.println(sheet10_A1+"\r");
		out.print("^PRINT(321,99,225,2,10,0/,굴림체,RGB[0,0,0], , , ,NONE,20,1)");
		out.println(sheet10_D2+"\r");
	}

	//----listHeader 스크립트 문 출력 함수----
	private void writeScriptlistHeader( ) throws Exception{
		//스크립트문 생성
		out.println("^CELLBG("+(nXCurPos)+","+(nYCurPos)+",55,20,1,RGB[230,230,250],RGB[230,230,250],0)\r");
		out.println("^CELLLINE("+(nXCurPos)+","+(nYCurPos)+",55,20,0,RGB[0,0,0],0)\r");
		out.println("^CELLLINE("+(nXCurPos)+","+(nYCurPos)+",55,20,0,RGB[0,0,0],1)\r");
		out.println("^CELLLINE("+(nXCurPos)+","+(nYCurPos)+",55,20,0,RGB[0,0,0],2)\r");
		out.println("^CELLLINE("+(nXCurPos)+","+(nYCurPos)+",55,20,0,RGB[0,0,0],3)\r");
		out.print("^PRINT("+(nXCurPos)+","+(nYCurPos)+",55,1,10,0/,굴림체,RGB[0,0,0], , , ,NONE,20,1)");
		out.println(sheet10_A3+"\r");
		out.println("^CELLBG("+(nXCurPos+55)+","+(nYCurPos)+",100,20,1,RGB[230,230,250],RGB[230,230,250],0)\r");
		out.println("^CELLLINE("+(nXCurPos+55)+","+(nYCurPos)+",100,20,0,RGB[0,0,0],0)\r");
		out.println("^CELLLINE("+(nXCurPos+55)+","+(nYCurPos)+",100,20,0,RGB[0,0,0],1)\r");
		out.println("^CELLLINE("+(nXCurPos+55)+","+(nYCurPos)+",100,20,0,RGB[0,0,0],2)\r");
		out.println("^CELLLINE("+(nXCurPos+55)+","+(nYCurPos)+",100,20,0,RGB[0,0,0],3)\r");
		out.print("^PRINT("+(nXCurPos+55)+","+(nYCurPos)+",100,1,10,0/,굴림체,RGB[0,0,0], , , ,NONE,20,1)");
		out.println(sheet10_B3+"\r");
		out.println("^CELLBG("+(nXCurPos+155)+","+(nYCurPos)+",125,20,1,RGB[230,230,250],RGB[230,230,250],0)\r");
		out.println("^CELLLINE("+(nXCurPos+155)+","+(nYCurPos)+",125,20,0,RGB[0,0,0],0)\r");
		out.println("^CELLLINE("+(nXCurPos+155)+","+(nYCurPos)+",125,20,0,RGB[0,0,0],1)\r");
		out.println("^CELLLINE("+(nXCurPos+155)+","+(nYCurPos)+",125,20,0,RGB[0,0,0],2)\r");
		out.println("^CELLLINE("+(nXCurPos+155)+","+(nYCurPos)+",125,20,0,RGB[0,0,0],3)\r");
		out.print("^PRINT("+(nXCurPos+155)+","+(nYCurPos)+",125,1,10,0/,굴림체,RGB[0,0,0], , , ,NONE,20,1)");
		out.println(sheet10_C3+"\r");
		out.println("^CELLBG("+(nXCurPos+280)+","+(nYCurPos)+",125,20,1,RGB[230,230,250],RGB[230,230,250],0)\r");
		out.println("^CELLLINE("+(nXCurPos+280)+","+(nYCurPos)+",125,20,0,RGB[0,0,0],0)\r");
		out.println("^CELLLINE("+(nXCurPos+280)+","+(nYCurPos)+",125,20,0,RGB[0,0,0],1)\r");
		out.println("^CELLLINE("+(nXCurPos+280)+","+(nYCurPos)+",125,20,0,RGB[0,0,0],2)\r");
		out.println("^CELLLINE("+(nXCurPos+280)+","+(nYCurPos)+",125,20,0,RGB[0,0,0],3)\r");
		out.print("^PRINT("+(nXCurPos+280)+","+(nYCurPos)+",125,1,10,0/,굴림체,RGB[0,0,0], , , ,NONE,20,1)");
		out.println(sheet10_D3+"\r");
		out.println("^CELLBG("+(nXCurPos+405)+","+(nYCurPos)+",100,20,1,RGB[230,230,250],RGB[230,230,250],0)\r");
		out.println("^CELLLINE("+(nXCurPos+405)+","+(nYCurPos)+",100,20,0,RGB[0,0,0],0)\r");
		out.println("^CELLLINE("+(nXCurPos+405)+","+(nYCurPos)+",100,20,0,RGB[0,0,0],1)\r");
		out.println("^CELLLINE("+(nXCurPos+405)+","+(nYCurPos)+",100,20,0,RGB[0,0,0],2)\r");
		out.println("^CELLLINE("+(nXCurPos+405)+","+(nYCurPos)+",100,20,0,RGB[0,0,0],3)\r");
		out.print("^PRINT("+(nXCurPos+405)+","+(nYCurPos)+",100,1,10,0/,굴림체,RGB[0,0,0], , , ,NONE,20,1)");
		out.println(sheet10_E3+"\r");
	}

	//----list 스크립트 문 출력 함수----
	private void writeScriptlist( ) throws Exception{
		//스크립트문 생성
		out.println("^CELLLINE("+(nXCurPos)+","+(nYCurPos)+",55,20,0,RGB[0,0,0],0)\r");
		out.println("^CELLLINE("+(nXCurPos)+","+(nYCurPos)+",55,20,0,RGB[0,0,0],1)\r");
		out.println("^CELLLINE("+(nXCurPos)+","+(nYCurPos)+",55,20,0,RGB[0,0,0],2)\r");
		out.println("^CELLLINE("+(nXCurPos)+","+(nYCurPos)+",55,20,0,RGB[0,0,0],3)\r");
		out.print("^PRINT("+(nXCurPos)+","+(nYCurPos)+",55,1,10,1/0/0,굴림체,RGB[0,0,0], , , ,NONE,20,1)");
		out.println(sheet10_A4+"\r");
		out.println("^CELLLINE("+(nXCurPos+55)+","+(nYCurPos)+",100,20,0,RGB[0,0,0],0)\r");
		out.println("^CELLLINE("+(nXCurPos+55)+","+(nYCurPos)+",100,20,0,RGB[0,0,0],1)\r");
		out.println("^CELLLINE("+(nXCurPos+55)+","+(nYCurPos)+",100,20,0,RGB[0,0,0],2)\r");
		out.println("^CELLLINE("+(nXCurPos+55)+","+(nYCurPos)+",100,20,0,RGB[0,0,0],3)\r");
		out.print("^PRINT("+(nXCurPos+55)+","+(nYCurPos)+",100,1,10,0/,굴림체,RGB[0,0,0], , , ,NONE,20,1)");
		out.println(sheet10_B4+"\r");
		out.println("^CELLLINE("+(nXCurPos+155)+","+(nYCurPos)+",125,20,0,RGB[0,0,0],0)\r");
		out.println("^CELLLINE("+(nXCurPos+155)+","+(nYCurPos)+",125,20,0,RGB[0,0,0],1)\r");
		out.println("^CELLLINE("+(nXCurPos+155)+","+(nYCurPos)+",125,20,0,RGB[0,0,0],2)\r");
		out.println("^CELLLINE("+(nXCurPos+155)+","+(nYCurPos)+",125,20,0,RGB[0,0,0],3)\r");
		out.print("^PRINT("+(nXCurPos+155)+","+(nYCurPos)+",125,1,10,0/,굴림체,RGB[0,0,0], , , ,NONE,20,1)");
		out.println(sheet10_C4+"\r");
		out.println("^CELLLINE("+(nXCurPos+280)+","+(nYCurPos)+",125,20,0,RGB[0,0,0],0)\r");
		out.println("^CELLLINE("+(nXCurPos+280)+","+(nYCurPos)+",125,20,0,RGB[0,0,0],1)\r");
		out.println("^CELLLINE("+(nXCurPos+280)+","+(nYCurPos)+",125,20,0,RGB[0,0,0],2)\r");
		out.println("^CELLLINE("+(nXCurPos+280)+","+(nYCurPos)+",125,20,0,RGB[0,0,0],3)\r");
		out.print("^PRINT("+(nXCurPos+280)+","+(nYCurPos)+",125,1,10,0/,굴림체,RGB[0,0,0], , , ,NONE,20,1)");
		out.println(sheet10_D4+"\r");
		out.println("^CELLLINE("+(nXCurPos+405)+","+(nYCurPos)+",100,20,0,RGB[0,0,0],0)\r");
		out.println("^CELLLINE("+(nXCurPos+405)+","+(nYCurPos)+",100,20,0,RGB[0,0,0],1)\r");
		out.println("^CELLLINE("+(nXCurPos+405)+","+(nYCurPos)+",100,20,0,RGB[0,0,0],2)\r");
		out.println("^CELLLINE("+(nXCurPos+405)+","+(nYCurPos)+",100,20,0,RGB[0,0,0],3)\r");
		out.print("^PRINT("+(nXCurPos+405)+","+(nYCurPos)+",100,1,10,0/,굴림체,RGB[0,0,0], , , ,NONE,20,1)");
		out.println(sheet10_E4+"\r");
	}

	//파라미터 설정 함수
	private void setParam(){
		p_dept_Param=toKor(GetB(request.getParameter("p_dept")));
	}

	//-----Connection 및 Statement 객체 생성 함수-----
	private void createConnAndStateObject() throws Exception{
		//DUNET Connection 객체 생성
		Class.forName("oracle.jdbc.driver.OracleDriver").newInstance();
		conn_DUNET=DriverManager.getConnection("jdbc:oracle:thin:@(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=192.168.12.203)(PORT=1521))(ADDRESS=(PROTOCOL=TCP)(HOST=192.168.12.204)(PORT=1521))(FAILOVER=on)(LOAD_BALANCE=off))(CONNECT_DATA=(SERVER=DEDICATED)(SERVICE_NAME=LOTI)))","cmlms","fhxl21");stat_list=conn_DUNET.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
	}

	//-----SQL문 변수 초기화 함수-----
	private void initSQLConst(){
		sql_list = "select no, ";
		sql_list = sql_list + "  ( ";
		sql_list = sql_list + "    select name ";
		sql_list = sql_list + "    from CMTB_member ";
		sql_list = sql_list + "    where userno = a.userno) as name, ";
		sql_list = sql_list + "  ( ";
		sql_list = sql_list + "    select gadminnm ";
		sql_list = sql_list + "    from CMTB_gadmin ";
		sql_list = sql_list + "    where gadmin = a.gadmin) as gadminnm , ";
		sql_list = sql_list + "  gadmin, ";
		sql_list = sql_list + "  ( ";
		sql_list = sql_list + "    select deptnm ";
		sql_list = sql_list + "    from CMTB_dept ";
		sql_list = sql_list + "    where dept = a.dept) as deptnm, ";
		sql_list = sql_list + "  dept, ";
		sql_list = sql_list + "  to_char(idate, 'YYYY-MM-DD HH24:MI:SS') as idate, ";
		sql_list = sql_list + "  to_char(cdate, 'YYYY-MM-DD HH24:MI:SS') as cdate, ";
		sql_list = sql_list + "  ( ";
		sql_list = sql_list + "    select name ";
		sql_list = sql_list + "    from CMTB_member ";
		sql_list = sql_list + "    where userno = a.luserno) as lname ";
		sql_list = sql_list + "from CMTB_GADMIN_HISTORY a ";
		sql_list = sql_list + "where dept = '" + p_dept_Param + "' ";
		sql_list = sql_list + "  AND gadmin = '2' ";
		sql_list = sql_list + "order by ldate desc";
	}

	//-----ResultSet 객체에서 필드 값 설정 함수-----
	//ResultSet list 객체에서 필드 값 설정 함수
	private void setFieldVariableFromlist() throws Exception{
		list_NO=list.getDouble(1);
		list_NAME=GetB(list.getString(2));
		list_GADMINNM=GetB(list.getString(3));
		list_GADMIN=GetB(list.getString(4));
		list_DEPTNM=GetB(list.getString(5));
		list_DEPT=GetB(list.getString(6));
		list_IDATE=GetB(list.getString(7));
		list_CDATE=GetB(list.getString(8));
		list_LNAME=GetB(list.getString(9));
	}

	//ResultSet list 객체의 필드 값 초기화 함수
	private void setFieldInitFromlist(){
		list_NO=0;
		list_NAME="";
		list_GADMINNM="";
		list_GADMIN="";
		list_DEPTNM="";
		list_DEPT="";
		list_IDATE="";
		list_CDATE="";
		list_LNAME="";
	}

	//-----고정 데이터 초기화 함수-----
	private void initConstVarient(){
		sheet10_A1="부서담당자 이력현황";
		sheet10_D2="기간 : 2004.1.1 ~ 2005.1.12";
		sheet10_A3="번호";
		sheet10_B3="성명";
		sheet10_C3="지정일";
		sheet10_D3="삭제일";
		sheet10_E3="지정인";
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
			getScriptFromheader(false, true);		//머리글 밴드 호출
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
