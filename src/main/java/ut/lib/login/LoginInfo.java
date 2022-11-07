package ut.lib.login;


public class LoginInfo{
//	public class LoginInfo extends ActionForm{
	
	private boolean boolLogin;	//로그인 유무
	private String sessLoginYn; //로그인 유무
	
	private String sessNo; 		//유저 번호.
	private String sessName; 	//이름
	private String sessUserId;  //아이디
	private String sessUserHp;  //폰
	
	private String sessUserEmail; //메일
	private String sessUserDept;  //부서
	private String sessUserJik;  //직업코드
	
	private String sessResNo;   //비번
	
	private String sessClass; 	//권한
	private String sessDept; 	//기관
	private String sessPartcd;	//유저 부서
	private String sessCurrentAuth; 	//현재 권한
	private String sessCurrentAuthHome; //권한의 홈 경로
	
	private String sessAdminYN; 		//관리자 유무.
	private String[][] sessAuth = null; //권한이 있는 모든 정보의 배열
	
	private String sessGubun;	// 진행과정=1, 전체과정=2
	private String sessYear;	// left 년도
	private String sessGrcode;	// left 과정
	private String sessGrseq;	// left 기수
	private String sessSubj;	// left 과목
	
	
	
//	public void reset(ActionMapping mapping, HttpServletRequest request) {
//		
//		boolLogin = false;
//		sessLoginYn = "N";
//		
//		sessNo = "";
//		sessName = "";
//		sessUserId = "";
//		sessUserHp = "";
//		sessResNo = "";
//		sessClass = "";
//		sessDept = "";
//		sessPartcd = "";
//		sessCurrentAuth = "";
//		sessCurrentAuthHome = "/";
//		sessGubun = "2";
//		sessAdminYN = "N";
//		sessYear = "";
//		sessUserEmail = "";
//		sessUserJik = "";
//		sessUserDept = "";
//	}

	/**
	 * 로그인 여부 리턴
	 * @return
	 */
	public boolean isLogin() {
		return boolLogin;
	}
	/**
	 * 로그인 여부 세팅
	 * @param boolLogin
	 */
	public void setBoolLogin(boolean boolLogin) {
		this.boolLogin = boolLogin;
	}
	

	public String[][] getSessAuth() {
		return sessAuth;
	}
	public void setSessAuth(String[][] sessAuth) {
		this.sessAuth = sessAuth;
	}


	public String getSessClass() {
		return sessClass;
	}
	public void setSessClass(String sessClass) {
		this.sessClass = sessClass;
	}


	/**
	 * 현재 관리자 권한 코드 가져오기
	 * @return
	 */
	public String getSessCurrentAuth() {
		return sessCurrentAuth;
	}
	/**
	 * 현재 관리자 권한 세팅
	 * @param sessCurrentAuth
	 */
	public void setSessCurrentAuth(String sessCurrentAuth) {
		this.sessCurrentAuth = sessCurrentAuth;
	}
	

	public void setSessUserEmail(String sessUserEmail) {
		this.sessUserEmail = sessUserEmail;
	}
	
	public String getSessUserEmail() {
		return sessUserEmail;
	}
	
	public void setSessUserDept(String sessUserDept) {
		this.sessUserDept = sessUserDept;
	}
	
	public String getSessUserDept() {
		return sessUserDept;
	}
	
	public void setSessUserJik(String sessUserJik) {
		this.sessUserJik = sessUserJik;
	}
	
	public String getSessUserJik() {
		return sessUserJik;
	}	

	public String getSessDept() {
		return sessDept;
	}
	
	public void setSessDept(String sessDept) {
		this.sessDept = sessDept;
	}


	public String getSessName() {
		return sessName;
	}
	public void setSessName(String sessName) {
		this.sessName = sessName;
	}

	public String getSessNo() {
		return sessNo;
	}
	public void setSessNo(String sessNo) {
		this.sessNo = sessNo;
	}


	public String getSessPartcd() {
		return sessPartcd;
	}
	public void setSessPartcd(String sessPartcd) {
		this.sessPartcd = sessPartcd;
	}


	public String getSessResNo() {
		return sessResNo;
	}
	public void setSessResNo(String sessResNo) {
		this.sessResNo = sessResNo;
	}


	public String getSessUserHp() {
		return sessUserHp;
	}
	public void setSessUserHp(String sessUserHp) {
		this.sessUserHp = sessUserHp;
	}


	public String getSessUserId() {
		return sessUserId;
	}
	public void setSessUserId(String sessUserId) {
		this.sessUserId = sessUserId;
	}

	public String getSessLoginYn() {
		return sessLoginYn;
	}
	public void setSessLoginYn(String sessLoginYn) {
		this.sessLoginYn = sessLoginYn;
	}

	public String getSessCurrentAuthHome() {
		return sessCurrentAuthHome;
	}
	public void setSessCurrentAuthHome(String sessCurrentAuthHome) {
		this.sessCurrentAuthHome = sessCurrentAuthHome;
	}

	public String getSessAdminYN() {
		return sessAdminYN;
	}
	public void setSessAdminYN(String sessAdminYN) {
		this.sessAdminYN = sessAdminYN;
	}
	
	
	/**
	 * Left 진행, 전체과정 값 리턴
	 * @return
	 */
	public String getSessGubun(){
		return sessGubun;
	}
	/**
	 * Left 진행, 전체과정 값 세팅
	 * @param sessGubun
	 */
	public void setSessGubun(String sessGubun){
		this.sessGubun = sessGubun;
	}
	
	
	/**
	 * Left 년도 셀렉트 박스 지정 값 리턴
	 * @return
	 */
	public String getSessYear(){
		return sessYear;
	}
	/**
	 * Left 년도 셀렉트 박스 지정 값 세팅
	 * @param sessYear
	 */
	public void setSessYear(String sessYear){
		this.sessYear = sessYear;
	}
	
	/**
	 * Left 과정 셀렉트 박스 지정 값 리턴
	 * @return
	 */
	public String getSessGrcode(){
		return sessGrcode;
	}
	/**
	 * Left 과정 셀렉트 박스 지정 값 세팅
	 * @param sessGrcode
	 */
	public void setSessGrcode(String sessGrcode){
		this.sessGrcode = sessGrcode;
	}
	
	/**
	 * Left 기수 셀렉트 박스 지정 값 리턴
	 * @return
	 */
	public String getSessGrseq(){
		return sessGrseq;
	}
	/**
	 * Left 기수 셀렉트 박스 지정 값 세팅
	 * @param sessGrseq
	 */
	public void setSessGrseq(String sessGrseq){
		this.sessGrseq = sessGrseq;
	}
	
	/**
	 * Left 과목 셀렉트 박스 지정 값 리턴
	 * @return
	 */
	public String getSessSubj(){
		return sessSubj;
	}
	/**
	 * Left 과목 셀렉트 박스 지정 값 세팅
	 * @param sessSubj
	 */
	public void setSessSubj(String sessSubj){
		this.sessSubj = sessSubj;
	}
	
}
