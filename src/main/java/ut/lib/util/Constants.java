package ut.lib.util;

import java.io.File;

/**
 * <B>Constants</B>
 * - 상수 정의 클래스
 * @author  kang
 * @version 2008-04-25
 */
public class Constants {

	
	
	// 웹로직용
	//public static String URL 		= "http://hrd.incheon.go.kr";
	//public static String HTTPS_URL 	= "https://hrd.incheon.go.kr";
	
	// 톰캣용
	//public static String URL 		= "http://152.99.42.130:8080";
	//public static String HTTPS_URL 	= "http://152.99.42.130:8080";
	
//	public static String URL 		= "http://localhost:8080";
//	public static String HTTPS_URL 	= "http://localhost:8080";
	public static String URL 		= "http://adm.hrd.incheon.go.kr:7003";
	public static String HTTPS_URL 	= "http://adm.hrd.incheon.go.kr:7003";
	
	
	// Root 경로
	//public static String rootPath = "/app1/apache/htdocs/LOTI/WebRoot/";
//	public static String rootPath = "/app1/apache2/htdocs/LOTI/WebRoot/";
//	public static String rootPath =  "C:/dev/eGov3.2/eGovFrameDev-3.2.0-64bit/workspace/loti/src/main/webapp/";
//	public static String rootPath =  "/home/tmax/jeus6/webhome/dev_container1/LOTI/LOTI_war___/";
	public static String rootPath =  "";
	
	// SQL XML 경로
	public static String QUERY = rootPath + "WEB-INF/classes/sqlmap/mappers";
	
	// message.properties 파일의 경로
    public static String MSG = rootPath + "WEB-INF/message/";
	
	/**
     * Query 출력 flag
     */
	public static boolean DBWRAP_FLAG = true;

    /**
     * query를 매번 파일에서 읽어올지를 결정하는 flag
     */
	public static boolean QUERY_DEBUG = true;

	/**
     * DataMap Warning 메시지 출력여부
     */
	public static boolean DATAMAP_DEBUG = false;

	/**
     * 수행쿼리 결과의 수행시간 DB저장 여부
     */
	public static boolean TRACE_FLAG = false;
	
	
    // 사용안하면 관련된거 모두 삭제해야 함
	public static final String EMAIL_SENDER	= "Webmaster@cyber.incheon.kr";	 //E-MAIL SENDER
 	public static String WEBMASTER 		= "인천 공무원 교육원";		//웹마스터
	
	// 사용여부 확인, 필요없으면 지워야 함
    // 파일을 업로드 할 물리적 경로 (게시물 코드가 제외됨)
	public static String UPLOAD = "pds";	
    // 파일 업로드에 사용되는 임시 폴더
	public static String TEMP = UPLOAD + "/temp";
	public static String DIRECT_FILE_TEMP = "/temp/";
	public static int MAX_FILE_SIZE = 10 * 1024 * 1024;
	

 	
 	// 디폴트 페이징 객체
 	public static String DEFAULT_PAGE_CLASS = "ut.lib.page.FrontPageNavigation";
    
 	public static String LOGIN_FAIL_URL = "/homepage/index.do?mode=homepage";  //"/index.do?mode=index";
 	
 	//AI 리포트 주소.
 	public static String AIREPORT_URL = "152.99.42.130";

 	//관리자 권한별 정보 
 	public static String ADMIN_SESS_CLASS_ADMIN 	= "0";
 	public static String ADMIN_SESS_CLASS_COURSE 	= "2";
 	public static String ADMIN_SESS_CLASS_DEPT 		= "3";
 	public static String ADMIN_SESS_CLASS_TEST 		= "5";
 	public static String ADMIN_SESS_CLASS_TUTOR 	= "7";
 	public static String ADMIN_SESS_CLASS_COURSEMAN = "A";
 	public static String ADMIN_SESS_CLASS_HOMEPAGE 	= "B";
 	public static String ADMIN_SESS_CLASS_PART 		= "C";
 	public static String ADMIN_SESS_CLASS_STUDENT 	= "8";
 	
 	//관리자 권한 정보 및 관리자 첫 메인 페이지 URL 
	public static String[] ADMIN_SESS_INFO = {
												"0", 	// 시스템관리자
												"2", 	// 과정운영자
												"3", 	// 기관담당자
												"5", 	// 평가담당자												
												"7", 	// 강사
												"A", 	// 과정장
												"B", 	// 홈페이지관리자
												"C",	// 부서담당자
												"8"		// 학생
											};
	public static String[] ADMIN_SESS_INFO_NAME = {
												"시스템관리자", 
												"과정운영자", 
												"기관담당자", 
												"평가담당자",											
												"강사",
												"과정장",
												"홈페이지관리자",
												"부서담당자",
												"학생"
											};
	
	// 관리자 권한에 따른 Home Url
	public static String[] ADMIN_SESS_INFO_URL = {
												"/index/sysAdminIndex.do?mode=sysAdmin", 
												"/index/sysAdminIndex.do?mode=sysAdmin", 
												"/index/sysAdminIndex.do?mode=sysAdmin", 
												"/index/sysAdminIndex.do?mode=sysAdmin",
												"/index/sysAdminIndex.do?mode=sysAdmin",
												"/index/sysAdminIndex.do?mode=sysAdmin",
												"/index/sysAdminIndex.do?mode=sysAdmin",
												"/index/sysAdminIndex.do?mode=sysAdmin",
												"/homepage/index.do?mode=homepage"
											};	
	
	
	
	// pds
	
	// 각종 게시판 나모웹에디터용 파일 업로드 경로
	// 코딩 하면서 옆에 해당 경로의 주석 작성해야 함
	public static String NAMOUPLOAD_CYBERPOLL 	= "/AS_tmp/Cyber_poll/";
	public static String NAMOUPLOAD_GRDISCUS 	= "/AS_tmp/grdiscussmng/";
	public static String NAMOUPLOAD_GRNOTICE 	= "/AS_tmp/grnotice/";		//과정 공지사항.
	public static String NAMOUPLOAD_GUIDE 		= "/gr_poll/guide_no_";
	public static String NAMOUPLOAD_HTML 		= "/AS_tmp/html/";
	public static String NAMOUPLOAD_NOTICE 		= "/AS_tmp/noticemng/";		//게시판
	public static String NAMOUPLOAD_NAVITEMP 	= "/NaviTemp/";
	public static String NAMOUPLOAD_REPORT 		= "/AS_tmp/report/";		//과제물관리
	public static String NAMOUPLOAD_PIC 		= "/pic/";
	public static String NAMOUPLOAD_FAQ 		= "/AS_tmp/Faq/";			//Faq관리
	public static String NAMOUPLOAD_POPUP 		= "/AS_tmp/Popup/";			//팝업관리
	public static String NAMOUPLOAD_QNA 		= "/AS_tmp/qnamng/";
	public static String NAMOUPLOAD_SUBJPOLL 	= "/AS_tmp/SUBJ_poll/";
	public static String NAMOUPLOAD_SUGGEST 	= "/AS_tmp/suggest/";	
	public static String NAMOUPLOAD_SUBJNOTICE 	= "/AS_tmp/subjnotice/";
	public static String NAMOUPLOAD_SUBJDATA 	= "/AS_tmp/subjdata/";		// 과목코드관리용 부교재, 학습프로그램 파일경로
	public static String NAMOUPLOAD_SUBJPDS 	= "/AS_tmp/subjpds/";
	public static String NAMOUPLOAD_WEBZIN 		= "/AS_tmp/Webzin/";
	public static String NAMOUPLOAD_RESULTHTML 	= "/AS_tmp/resultWebzin/";

	// 첨부파일용
	public static String UPLOADDIR_INNO 		= "/inno";			// 이노 컴퍼넌트 파일 저장 경로. 
	public static String UPLOADDIR_COMMON 		= UPLOADDIR_INNO + "/common/";			// 공통
	public static String UPLOADDIR_BASECODE 	= UPLOADDIR_INNO + "/basecode/";		// 기본코드
	public static String UPLOADDIR_COURSE 		= UPLOADDIR_INNO + "/course/";			// 과정운영
	public static String UPLOADDIR_SUBJ 		= UPLOADDIR_INNO + "/subj/";			// 과목운영
	public static String UPLOADDIR_EVAL 		= UPLOADDIR_INNO + "/eval/";			// 시험
	public static String UPLOADDIR_POLL 		= UPLOADDIR_INNO + "/poll/";			// 설문
	public static String UPLOADDIR_HOMEPAGE 	= UPLOADDIR_INNO + "/homepage/";		// 홈페이지
	public static String UPLOADDIR_MEMBER 		= UPLOADDIR_INNO + "/member/";			// 회원
	public static String UPLOADDIR_TUTOR 		= UPLOADDIR_INNO + "/tutor/";				// 강사
	public static String UPLOADDIR_WEBZINE 		= UPLOADDIR_INNO + "/webzine/";			// 웹진
	public static String UPLOADDIR_REPORT 		= UPLOADDIR_INNO + "/report/";			// 과제물 출제 관리
	
	// 문제은행
	public static String UPLOADDIR_Q 			= "/questionMgr/";		// 문제은행
		
	/** SMS 발송시 사용되는 상수값 */
	public static String SMS_CALLBACK = "0324407684"; //회신 번호.
	public static String SMS_STATUS = "0";
	public static String SMS_COMPKEY = "052";
	public static String SMS_ID = "edu00";
}
