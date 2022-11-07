package loti.mypage.service;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import loti.courseMgr.service.MailService;
import loti.mypage.mapper.MyClassMapper;
import loti.mypage.model.PollVO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import ut.lib.exception.BizException;
import ut.lib.login.LoginInfo;
import ut.lib.page.PageNavigation;
import ut.lib.support.DataMap;
import ut.lib.util.DateUtil;
import ut.lib.util.Functions;
import ut.lib.util.ListUtil;
import ut.lib.util.Message;
import ut.lib.util.Util;
import common.RegExpUtil;
import common.service.BaseService;
import gov.mogaha.gpin.sp.util.StringUtil;

@Service
@Transactional
public class MyClassService extends BaseService {

	@Autowired
	private MyClassMapper myClassMapper;
	
	@Autowired
	private MailService mailService;
	
	public DataMap ldapList(String deptCode) throws BizException {

		DataMap resultMap = null;
        
        try {
        	
            // 전체 강좌 리스트 가져오기
            resultMap = myClassMapper.ldapList(deptCode);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;      
	}

	public DataMap partList(String deptCode) throws BizException {

		DataMap resultMap = null;
        
        try {
        	
            // 전체 강좌 리스트 가져오기
            resultMap = myClassMapper.partList(deptCode);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap; 
	}

	public DataMap attendList(DataMap requestMap) throws BizException {

		DataMap resultMap = null;
        
        try {
        	
        	String userno = requestMap.getString("userno");
        	
            // 전체 강좌 리스트 가져오기
            resultMap = myClassMapper.attendList(userno);
            // 제한값이 있는지 확인
            requestMap.setString("restrict",myClassMapper.getRestrict(userno));
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;       
	}

	public DataMap selectAttendDetail(DataMap requestMap) throws BizException {

		DataMap resultMap = null;
        try {
        	
            resultMap = myClassMapper.selectAttendDetail(requestMap.getString("userno"));

        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}

	public DataMap courseList(DataMap requestMap) throws BizException {

		DataMap resultMap = null;
        
        try {
        	
            /**
             * 각 검색조건 만들기
             */
            String strCList = "WHERE USERNO='"+requestMap.getString("userno")+"'";
            
            resultMap = myClassMapper.courseList(strCList);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;     
	}
	
	
	public DataMap courseBasicList(DataMap requestMap) throws BizException {

		DataMap resultMap = null;
        
        try {
        	
            /**
             * 각 검색조건 만들기
             */
            String strCList = "WHERE USERNO='"+requestMap.getString("userno")+"'";
            
            resultMap = myClassMapper.courseBasicList(strCList);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;     
	}


	public DataMap courseReView(DataMap requestMap) throws BizException {

		DataMap resultMap = null;
        
        try {
        	
            resultMap = myClassMapper.courseReView(requestMap.getString("userno"));
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;  
	}

	public DataMap courseApplication(DataMap requestMap) throws BizException {

		DataMap resultMap = null;
        
        try {
            resultMap = myClassMapper.courseApplication(requestMap.getString("userno"));
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;    
	}

	/**
	 * 수료 내역
	 * @param requestMap
	 * @return tableName
	 * @return DataMap
	 * @throws Exception
	 */
	public DataMap selectCompletionList(DataMap requestMap) throws BizException {

		DataMap resultMap = null;
        
        try {
        	
            resultMap = myClassMapper.selectCompletionList(requestMap.getString("userno"));
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;  
	}

	public DataMap getMyQuestionList(DataMap requestMap) throws BizException {

		DataMap resultMap = null;
        
        try {
    	
        	String userno = requestMap.getString("userno");
        	
        	int totalCnt =  myClassMapper.getMyQuestionListCount(userno);
        	
        	Map<String, Object> pageInfo = Util.getPageInfo(totalCnt, requestMap);
        	
        	pageInfo.put("userno", userno);
        	
            resultMap = myClassMapper.getMyQuestionList(pageInfo);
            
            PageNavigation pageNavi = Util.getPageNavigation(pageInfo);
            resultMap.set("PAGE_INFO", pageNavi);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;    
	}

	//2011.01.11 - woni82
	//회원정보를 수정하기 위하여 기본정보를 가져온다.
	// 기존 - 주민등록번호 포함
	// 수정 - 주민등록번호 제외
	// sv, dao 수정
	public DataMap getModifyInfo(String userno) throws BizException {

		DataMap resultMap = null;
        
        try {
        	
            resultMap = myClassMapper.getModifyInfoNoRes(userno);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;
	}

	public DataMap getModifyInfoPic(String userno) throws BizException {

		DataMap resultMap = null;
        
        try {
        	
            resultMap = myClassMapper.getModifyInfoPic(userno);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;
	}

	public void deleteUser(String userno) throws BizException {

        try {
        	
            myClassMapper.deleteUser(userno);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
	}

	public void updateUser(Map<String, Object> requestMap) throws BizException {

        try {
        	
        	myClassMapper.updateUser(requestMap);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
	}

	public void updateUserLog(Map<String, Object> requestMap)  throws BizException {

        try {
        	
            myClassMapper.updateUserLog(requestMap);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
	}

	public void updateUserPicture(String fileno, String userno) throws BizException {
		 
        try {
            
        	Map<String, Object> params = Util.valueToMap("fileno", fileno, "userno", userno);
        	
            myClassMapper.updateUserPicture(params);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
	}

	public void updateUserPassword(String password, String userno) throws BizException  {

        try {
        	
        	Map<String, Object> params = Util.valueToMap("password", password, "userno", userno);
        	
            myClassMapper.updateUserPassword(params);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
	}
	
	public void updateUserDamoPassword(String userno) throws BizException  {

        try {
        	
        	Map<String, Object> params = Util.valueToMap( "userno", userno);
        	
            myClassMapper.updateUserDamoPassword(params);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
	}

	/**
	 * 소속기관 리스트
	 * @param requestMap
	 * @return DataMap
	 * @throws Exception
	 */
	public DataMap deptList() throws BizException {

		DataMap resultMap = null;
        
        try {
            
            // 전체 강좌 리스트 가져오기
            resultMap = myClassMapper.deptList();
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap; 
	}

	/**selectAttendDetail
	 * 등록
	 * @param requestMap
	 * @return DataMap
	 * @throws Exception
	 */
	@Transactional
	public String applyInfo(DataMap requestMap, LoginInfo loginInfo) throws Exception {
        String Msg = "";
        String grcode = requestMap.getString("grcode");
        try {
        	
        	Map<String, Object> params = new HashMap<String, Object>();
        	
        	params.put("userno", requestMap.getString("userno"));
        	params.put("grcode", requestMap.getString("grcode"));
        	params.put("grseq", requestMap.getString("grseq"));
        	params.put("jik", requestMap.getString("jik"));
            //동일과정 1년 내 재신청 불가 체크

        	System.out.println("requestMap================== " + requestMap.toString());
        	
            DataMap sp1 = myClassMapper.sameClass(params);
            sp1.setNullToInitialize(true);
            if(Util.getIntValue(sp1.getString("cnt"),0) > 0){
            	Msg = "동일과정은 3년 내 재신청이 불가합니다.";
            			
            	if("10G0000370".equals(grcode)){
            		Msg = "";
            	}
            }
            
            DataMap sp2 = myClassMapper.grseqList(params);
            sp2.setNullToInitialize(true);
            
            
            if(sp2.getString("fCyber").equals("Y")){
            	params.put("started", sp2.getString("started"));
            	DataMap sp3 = myClassMapper.sameTimeList(params);
            	sp3.setNullToInitialize(true);
            	if (Util.getIntValue(sp3.getString("cnt"),0) > 0){
            		Msg = "사이버교육과정은 동일 교육기간 내에 2개까지만 신청 가능합니다.";
            	}
            } else {
            	params.put("reseq", requestMap.getString("reseq"));
            	DataMap sp4 = myClassMapper.sameCourseList(params);
            	sp4.setNullToInitialize(true);
            	if (Util.getIntValue(sp4.getString("cnt2"),0) > 0){
            		Msg = "선택한 과정은 집합교육일정에 중복되어서 신청이 불가합니다.";
            	}
            }
            
            if (Msg.length() == 0){
//            	int i = dao.insertData(requestMap.getString("grcode"), requestMap.getString("grseq"), requestMap.getString("userno"));
            	requestMap.setString("sessName", loginInfo.getSessName());
            	int i = myClassMapper.insertData(requestMap);
            	if (i > 0){
            		requestMap.setString("ldapname", "".equals(StringUtil.nvl(requestMap.getString("ldapcode"),"")) ? null:requestMap.getString("deptsub"));
            		myClassMapper.modUserInfo(requestMap);
            		myClassMapper.modUserInfoLog(requestMap);
            		Msg = "신청되었습니다";
            		// SMS 내용 설정
            		
            		if(sp2.get("fCyber").equals("Y")) {
	            		String name = requestMap.getString("userName");
	            		int month = DateUtil.getMonth();
	            		
	            		String txtMessage = "[인천인재개발원] " +name+ "님 공무원 사이버 교육이 시작되었으니 " +month+ ".21 일 까지 수료 바랍니다."; 
	            		requestMap.setString("txtMessage", txtMessage);
	            		requestMap.setString("callback", "0324407684");
	            		mailService.insertSmsMsgAction(requestMap);
            		}
            	}
            }
            
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return Msg; 
	}

	
	// -------------------------------------------------------------------------------------------------------------
	
	
	
	/**
	 * 수강신청 가능한 과정인지 체크한다.
	 * @param requestMap
	 * @return tableName
	 * @return DataMap
	 * @throws Exception
	 */
	public String ajaxGetGrseq(String grcode, String grseq, String userno) throws Exception{
		
        DataMap resultMap1 = null;
        DataMap resultMap2 = null;
        DataMap resultMap3 = null;
        //String strResult = "true";
        String strResult = "1";
        
        try {
        	
            /**
             * 예외 과정은 무조건 신청가능
             * 연중 같은 과정 수강여부 체크(안됨)
             * 기수당 1개 과정만
             * 연간 3개 과정
             * 최종승인된 과정만 체크
             * 
             * */
            
            //횟수 제약이 없는 예외과정들...
		   
		     //String checkValue = "10C0000183,10C0000168,10C0000170,10C0000117,10C0000204,10C0000205,10C0000172,10C0000062,10C0000176,10C0000188,10C0000151,10C0000215,10C0000216,";        							
        	String checkValue = "10C0000219,10C0000117,10C0000151,10C0000168,10C0000170,10C0000176,10C0000188,10C0000202,10C0000205,10C0000223,10G0000203,10C0000239,10C0000214,10C0000243,10C0000244,10C0000246,10C0000248,10C0000249,10C0000250,10C0000252,10C0000271,10C0000274,10C0000276,10C0000278,10C0000255,10C0000262,10C0000264,10C0000268,10C0000258,10C0000245,10C0000254,10C0000267,10C0000273,10C0000257,10C0000263,10C0000279,10C0000240,10C0000242,10C0000253,10C0000266,10C0000270,10C0000256,10C0000260,10C0000247,10C0000275,10C0000265,10C0000272,10C0000277,10C0000261,10C0000241,10C0000251,10C0000269,10C0000259,10C0000291,10C0000281,10C0000282,10C00000962,10C0000293,10C0000303,10C0000304,10C0000305";
        	
	            
            // 사이버 횟수 제약없이 예외과정들
			//String checkValue2 = "10C0000183,10C0000168,10C0000170,10C0000117,10C0000204,10C0000205,10C0000172,10C0000062,10C0000176,10C0000188,10C0000151,10C0000215,10C0000216";
        	
        	String checkValue2 = "10C0000219,10C0000117,10C0000151,10C0000168,10C0000170,10C0000176,10C0000188,10C0000202,10C0000205,10C0000223,10G0000203,10C0000239,10C0000214,10C0000243,10C0000244,10C0000246,10C0000248,10C0000249,10C0000250,10C0000252,10C0000271,10C0000274,10C0000276,10C0000278,10C0000255,10C0000262,10C0000264,10C0000268,10C0000258,10C0000245,10C0000254,10C0000267,10C0000273,10C0000257,10C0000263,10C0000279,10C0000240,10C0000242,10C0000253,10C0000266,10C0000270,10C0000256,10C0000260,10C0000247,10C0000275,10C0000265,10C0000272,10C0000277,10C0000261,10C0000241,10C0000251,10C0000269,10C0000259,10C0000291,10C0000281,10C0000282,10C00000962,10C0000293,10C0000303,10C0000304,10C0000305";
			
			
                           
			Map<String, Object> params = new HashMap<String, Object>();
			
			params.put("grcode", grcode);
			params.put("grseq", grseq);
			params.put("userno", userno);
			
            //올해 수강신청한 과정인지 확인
            resultMap1 = myClassMapper.ajaxCountGrcodeYear(params);
            int cntGrcode = Util.parseInt(resultMap1.get("cnt"));
            //올해 수강신청한 과정 건수 조회
            resultMap2 = myClassMapper.ajaxCountGrcodeYearTotal(params);
            int cntGrcodeTotal = Util.parseInt(resultMap2.get("cnt"));
            //이번 기수의 수강신청한 과정 건수
            resultMap3 = myClassMapper.ajaxCountGrseq(params);
            int cntGrseq = Util.parseInt(resultMap3.get("cnt"));
            /*
            //올해 수강신청한 이력이 있으면 신청불가
            if(cntGrcode > 0) {
            	strResult = "false";
            }
            //수강신청은 1년에 3개까지만 가능
            if(cntGrcodeTotal > 2) {
            	strResult = "false";
            }
            //수강신청은 1기수에 1개만 가능
            
            if(cntGrseq > 0) {
            	strResult = "false";
            }
            
            //예외과정인 경우 무조건 신청가능
            if(checkValue.indexOf(grcode) > 0){
            	strResult = "true";
            }
            */
            if(cntGrcode > 0) {
            	strResult = "-1";
            }
            //수강신청은 1년에 3개까지만 가능
            if(cntGrcodeTotal > 2) {
            	if(checkValue2.indexOf(grcode) == -1) {
            		strResult = "-2";
            	}
            }
            //수강신청은 1기수에 1개만 가능
            if(cntGrseq > 0) {
            	strResult = "-3";
            }
            
            //예외과정인 경우 무조건 신청가능
            if(checkValue.indexOf(grcode) >= 0){
            	strResult = "1";
            }
            
            /* 기존 비지니스로직. hwawni. 2010-04-07.
			//이번기수중 신청한 사이버과정 건수
			resultMap1 = dao.ajaxSelectGrseqCnt(grseq, userno, grcode);
			resultMap1.setNullToInitialize(true);
			int nowCnt = resultMap1.getInt("nowcnt");
            //예외과정만큼 감산
            if (checkValue.indexOf(grcode) > 0){
            	nowCnt = nowCnt - 1;
            }
            
            //신청과목이 없다면
            if (nowCnt <= 0) {
            	//전체 신청한 과목 건수. 신청하려는 기수에 몇 개를 수강신청하였는지 카운트
            	resultMap2 = dao.ajaxSelectGrseqTotalCnt(grseq, userno);
            	resultMap2.setNullToInitialize(true);
            	
            	//2개까지 허용한다.
            	if (resultMap2.getInt("totalcnt") < 3){
            		strResult = "true";
            	}
            }
            
            //연중 수강한 기수인지
            resultMap3 = dao.ajaxSelectGrcodeCnt(grcode, grseq, userno);
            resultMap3.setNullToInitialize(true);
            
            if (resultMap3.getInt("totalcnt") > 0 ){
            	strResult = "false";
            }
            */         

        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return strResult;        
	}
	
	public int ajaxGetCount(String grcode, String grseq) throws Exception{
		
        DataMap resultMap1 = null;
        int strResult = -999;
        
        try {
        	
        	Map<String, Object> params = new HashMap<String, Object>();
        	
        	params.put("grcode", grcode);
        	params.put("grseq", grseq);
        	
            resultMap1 = myClassMapper.ajaxGetCount(params);
            strResult = Util.parseInt(resultMap1.get("cnt"));
         
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return strResult;        
	}
	
	public int ajaxGetTseat(String grcode, String grseq) throws Exception{
		
        DataMap resultMap1 = null;
        int strResult = -999;
        
        try {
        	
        	Map<String, Object> params = new HashMap<String, Object>();
        	
        	params.put("grcode", grcode);
        	params.put("grseq", grseq);
        	
            resultMap1 = myClassMapper.ajaxGetTseat(params);
            strResult = Util.parseInt(resultMap1.get("tseat"));
         
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return strResult;        
	}

	/**
	 * 수강중인 목록
	 * @param requestMap
	 * @return tableName
	 * @return DataMap
	 * @throws Exception
	 */
	public DataMap ajaxReadCnt(String grcode, String grseq, String subj, String userno) throws Exception{
		
		DataMap resultMap = null;
        
        try {
        	
            /**
             * 각 검색조건 만들기   (String grcode, String grseq, String subj, String userno)
             */
        	Map<String, Object> params = new HashMap<String, Object>();
        	
        	params.put("grcode", grcode);
        	params.put("grseq", grseq);
        	params.put("subj", subj);
        	params.put("userno", userno);
        	
            resultMap = myClassMapper.selectAjaxReadCnt(params);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}

	// 삭제
	public int reExamTest(String idExam, String userId) throws Exception{
		
        int iProc = 0;
        
        try {
      	
        	Map<String, Object> params = new HashMap<String, Object>();
        	
        	params.put("idExam", idExam);
        	params.put("userId", userId);
        	
            iProc = myClassMapper.examTestBackup(params);
            if (iProc > 0){
            	myClassMapper.deleteExamTestDelAns(params);
            	myClassMapper.deleteExamTestDelAnsNon(params);
            } else {
//            	con.rollback();
            	return 0;
            }
//            con.commit();
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return iProc;        
	}

	// lcms_cmi xml 비교 정리
	public int setLcmsCmiClear(DataMap requestMap) throws Exception{
		
        DataMap resultMap = null;
        int iProc = 0;
        
        try {
      	
            //String user_no, String subj, String grcode, String grseq) 
//        	requestMap.getString("userno"), requestMap.getString("subj"), requestMap.getString("grcode"), requestMap.getString("grseq")
            resultMap = myClassMapper.selectLcmsCmiXML(requestMap);
            resultMap.setNullToInitialize(true);
            
            boolean typeCheck = false;
            
            if (resultMap.keySize("szxml") > 0){
	            for(int i=0, l=resultMap.keySize("szxml");i<l;i++){
	            	if (resultMap.getString("szxml",i).length() > 0 && resultMap.getString("szxml",i).indexOf("comments_from_learner") == -1){
	            		typeCheck = true;
	            	}
	            }
            }
            if (typeCheck){
//            	requestMap.getString("userno"), requestMap.getString("subj"), requestMap.getString("grcode"), requestMap.getString("grseq")
            	iProc = myClassMapper.updateLcmsCmiXML(requestMap);	
            }
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return iProc;        
	}
	
	// 설문 주관식 답변 리스트
	public String viewReportSubmit(DataMap requestMap) throws Exception{
		
        String resultStr = null;
        
        try {
      	
            //String subj, String grcode, String classno, String dates, String userno
//        	requestMap.getString("subj"), requestMap.getString("grcode"), requestMap.getString("grseq"), requestMap.getString("classno"), requestMap.getString("dates"), requestMap.getString("userno")
            resultStr = myClassMapper.viewReportSubmit(requestMap);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultStr;        
	}
	
	
	// 설문 주관식 답변 리스트
	public DataMap getGriqAnswerList(DataMap requestMap) throws Exception{
		
		DataMap resultMap = null;
        
        try {
      	
	    	int totalCnt = myClassMapper.selectGriqAnswerTxtCount(requestMap);
        	
        	Map<String, Object> pageInfo = Util.getPageInfo(totalCnt, requestMap);
        	
        	requestMap.set("page", pageInfo);
        	
            resultMap = myClassMapper.selectGriqAnswerTxt(requestMap);
            
            PageNavigation pageNavi = Util.getPageNavigation(pageInfo);
            resultMap.set("PAGE_INFO", pageNavi);
        	
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
	
	// 설문 등록
	public int pollExec(DataMap requestMap) throws Exception{
		
		int inNum = 0;

        try {
        	
            if (requestMap.keySize("keyVal") > 0){
            	
            	for(int i=0, l=requestMap.keySize("keyVal");i<l;i++){
	            	String strAnsNo = "";
	            
	            	if (requestMap.getString("keyType",i).equals("3")){
	            		for(int x=0,y=requestMap.keySize("poll_"+i);x<y;x++){
	            			if( x != 0){
	            				strAnsNo += ",";
	            			}
	            			strAnsNo += requestMap.getString("poll_"+i, x);
	            		}
	            	} else {
	            		strAnsNo = requestMap.getString("poll_"+i);
	            	}
//	            	requestMap.getString("title_no"), , requestMap.getString("set_no"), requestMap.getString("userno"), strAnsNo, requestMap.getString("poll_"+i+"_text")
	            	requestMap.set("ans_no", strAnsNo);
	            	requestMap.set("question_no", ""+(i+1));
	            	requestMap.set("answer_txt", requestMap.getString("poll_"+i+"_text"));
	            	
	            	inNum += myClassMapper.insertGrinqAnswer(requestMap);
	            	
	            }
            }
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return inNum;        
	}
	
	// 설문 응시 및 결과 보기
	public DataMap pollView(DataMap requestMap) throws Exception{
		
		DataMap resultMap = null;

        try {
        	
            resultMap = myClassMapper.grinqQuestionSet(requestMap);
            resultMap.setNullToInitialize(true);
            
            Map<String, Object> params = new HashMap<String, Object>();
            
            for(int i=0, l=resultMap.keySize("titleNo");i<l;i++){
            	
            	List<PollVO> ansList = new ArrayList<PollVO>();
            	
//            	resultMap.getString("titleNo",i), resultMap.getString("setNo",i), resultMap.getString("questionNo",i)
            	params.put("titleNo", resultMap.getString("titleNo",i));
            	params.put("setNo", resultMap.getString("setNo",i));
            	params.put("questionNo", resultMap.getString("questionNo",i));
            	
            	DataMap rData = myClassMapper.grinqSampSet(params);
            	rData.setNullToInitialize(true);
            	
            	for (int x=0,y=rData.keySize("titleNo");x<y;x++){
            		
            		PollVO pollVO = new PollVO();
            		pollVO.setTitle_no(rData.getString("titleNo",x));
            		pollVO.setSet_no(rData.getString("setNo",x));
            		pollVO.setQuestion_no(rData.getString("questionNo",x));
            		pollVO.setAnswer_no(rData.getString("answerNo",x));
            		pollVO.setAnswer(rData.getString("answer",x));
            		pollVO.setAnswer_kind(rData.getString("answerKind",x));
            		
            		params.put("answerNo", rData.getString("answerNo",x));
            		params.put("titleNo", resultMap.getString("titleNo",i));
            		params.put("setNo", resultMap.getString("setNo",i));
            		params.put("questionNo", resultMap.getString("questionNo",i));
            		
            		if (pollVO.getAnswer_kind().equals("4")){
//            			rData.getString("titleNo",x), rData.getString("setNo",x), rData.getString("questionNo",x)
            			pollVO.setTxtAns(myClassMapper.grinqAnswerText(params));
            		} else if (!pollVO.getAnswer_kind().equals("3")){
//            			rData.getString("titleNo",x), rData.getString("setNo",x), rData.getString("questionNo",x),rData.getString("answerNo",x)
            			pollVO.setTotalCnt(myClassMapper.grinqAnswerOne(params));
            		} else {
//            			rData.getString("titleNo",x), rData.getString("setNo",x), rData.getString("questionNo",x),rData.getString("answerNo",x)
            			pollVO.setTotalCnt(myClassMapper.grinqAnswerSome(params));
            		}
            		
            		ansList.add(pollVO);
            	}

            	resultMap.add("answer", ansList);
            	
            }

        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
	
	
	
	
	// 시험 응시, 점수확인 계정이 틀림
	public DataMap pollList(DataMap requestMap) throws Exception{
		DataMap resultMap = null;

        try {
//        	requestMap.getString("grcode"),  requestMap.getString("grseq"), requestMap.getString("userno")
            resultMap = myClassMapper.pollList(requestMap);

        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
	
	// 시험 응시, 점수확인 계정이 틀림
	public String selectTestValue(DataMap requestMap) throws Exception{
		
        String Msg = "";

        try {
//        	requestMap.getString("grcode"), requestMap.getString("grseq"), requestMap.getString("userno"), requestMap.getString("display")
            DataMap resultMap1 = myClassMapper.courseTest(requestMap);
            
            requestMap.add("cTest", resultMap1);
//            requestMap.getString("grcode"), requestMap.getString("grseq"), requestMap.getString("userno")
            DataMap resultMap2 = myClassMapper.findScore(requestMap);
            
            requestMap.add("cScore", resultMap2);
            Msg = "성공";

        } catch (SQLException e) {
        	Msg = "실패";
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return Msg;        
	}
	
	// 수료여부 확인
	public DataMap findGrade(DataMap requestMap) throws Exception{
		
		DataMap resultMap = null;

        try {
//        	requestMap.getString("grcode"), requestMap.getString("grseq")
            resultMap = myClassMapper.findGrade(requestMap);

        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
		
	public DataMap findGrade2(DataMap requestMap) throws Exception{
		
		DataMap resultMap = null;

        try {
//        	requestMap.getString("grcode"), requestMap.getString("grseq")
            resultMap = myClassMapper.findGrade2(requestMap);

        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
	
	/**selectAttendDetail
	 * 등록
	 * @param requestMap
	 * @return DataMap
	 * @throws Exception
	 */
	public String reportSubmit(DataMap requestMap) throws Exception{
		
        String Msg = "";

        try {
//        	requestMap.getString("grcode"), requestMap.getString("grseq"), requestMap.getString("subj"),  requestMap.getString("classno"), requestMap.getString("dates")
            DataMap dm1 = myClassMapper.reportCheck(requestMap);
            
            if  ("N".equals(dm1.get("submit1"))){
            	Msg = "아직 레포트 출제기한전 입니다";
            }
            if  ("N".equals(dm1.get("submit2"))){
            	Msg = "레포트 출제기한이 경과되었습니다";
            }
            
            if (Msg.length() == 0){
//            	requestMap.getString("grcode"), requestMap.getString("grseq"), requestMap.getString("subj"), requestMap.getString("classno"), Util.plusZero(requestMap.getString("dates")), requestMap.getString("userno")
            	int iNum = myClassMapper.regChoice(requestMap);
            	if (iNum == 0){
//            		requestMap.getString("grcode"), requestMap.getString("grseq"), requestMap.getString("subj"), requestMap.getString("classno"), Util.plusZero(requestMap.getString("dates")), requestMap.getString("userno")
            		iNum = myClassMapper.reportInsert(requestMap);
            	}
            	if (iNum == 1){
//            		requestMap.getString("grcode"), requestMap.getString("grseq"), requestMap.getString("subj"), requestMap.getString("classno"), Util.plusZero(requestMap.getString("dates")), requestMap.getString("userno"), Util.getIntValue(requestMap.getString("groupfileNo"),0)
            		iNum = myClassMapper.reportUpdate(requestMap);
            	}
            	Msg = "등록되었습니다";
            }
            
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return Msg;        
	}
	
	

	/**selectAttendDetail
	 * 등록
	 * @param requestMap
	 * @return DataMap
	 * @throws Exception
	 */
	public DataMap reportView(DataMap requestMap) throws Exception{
		
		DataMap resultMap = null;

        try {
//        	requestMap.getString("grcode"), requestMap.getString("grseq"), requestMap.getString("subj"), requestMap.getString("userno"), requestMap.getString("classno"), requestMap.getString("dates")
            resultMap = myClassMapper.reportView(requestMap);

        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
	
	
	/**selectAttendDetail
	 * 등록
	 * @param requestMap
	 * @return DataMap
	 * @throws Exception
	 */
	public DataMap selectReportList(DataMap requestMap) throws Exception{
		
		DataMap resultMap = null;
        try {
//        	requestMap.getString("grcode"), requestMap.getString("grseq"), requestMap.getString("subj"), requestMap.getString("userno")
            resultMap = myClassMapper.selectReportList(requestMap);

        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
	
	
	
	/**selectAttendDetail
	 *삭제
	 * @param requestMap
	 * @return DataMap
	 * @throws Exception
	 */
	public String applyCancel(DataMap requestMap) throws Exception{
		
        String Msg = "";
        
        try {
        	
            //동일과정 1년 내 재신청 불가 체크
//        	requestMap.getString("grcode"), requestMap.getString("grseq"), requestMap.getString("userno")
            DataMap sp1 = myClassMapper.attendConfirm(requestMap);
            
            // 조건 확인
            if("Y".equals(sp1.get("deptchk")) || "Y".equals(sp1.get("grchk"))){
            	Msg = "관리자가 승인하였습니다. 취소하시려면 관리자에게 문의하시기 바랍니다.";
            }else if("N".equals(sp1.get("deptchk")) || "N".equals(sp1.get("grchk"))){
				Msg = "탈락하였습니다. 탈락한 과목은 수강취소하실수 없습니다.";	
			}
            
            // 조건을 만족하는 경우 삭제
            if (Msg.length() == 0){
//            	requestMap.getString("grcode"), requestMap.getString("grseq"), requestMap.getString("userno")
            	int i = myClassMapper.attendCancel(requestMap);
            	if (i > 0){
            		Msg = "수강 신청이 취소되었습니다. ";
            	}
            }
            
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return Msg;        
	}
	
	/**selectAttendDetail
	 *삭제
	 * @param requestMap
	 * @return DataMap
	 * @throws Exception
	 */
	public String autoCancelAttend(DataMap requestMap) throws Exception{
		
        String Msg = "";
        
        try {
        	
        	
            //동일과정 1년 내 재신청 불가 체크
//        	requestMap.getString("grcode"), requestMap.getString("grseq"), requestMap.getString("userno")
            DataMap sp1 = myClassMapper.attendConfirm(requestMap);

            // 조건 확인
            if("Y".equals(sp1.get("deptchk")) || "Y".equals(sp1.get("grchk"))){
            	Msg = "관리자가 승인하였습니다. 취소하시려면 관리자에게 문의하시기 바랍니다.";
            }
            
            // 조건 확인
            if("N".equals(sp1.get("deptchk")) || "N".equals(sp1.get("grchk"))){
				Msg = "탈락하였습니다. 탈락한 과목은 수강취소하실수 없습니다.";	
			}
//            requestMap.getString("grcode"), requestMap.getString("grseq"), requestMap.getString("userno")
            DataMap checkDeleteYn = myClassMapper.checkDeleteYn(requestMap);
            checkDeleteYn.put("ratio", Util.nvl(checkDeleteYn.get("ratio"),"0"));

            if(!Util.nvl(checkDeleteYn.get("ratio"),"0").equals("0")) {
            	Msg = "[삭제 불가 ] \n이미 수강하신 과목은 삭제하실수 없습니다.";	
            }

            // 조건을 만족하는 경우 삭제
            if (Msg.length() == 0){
//            	requestMap.getString("grcode"), requestMap.getString("grseq"), requestMap.getString("userno")
            	int i = myClassMapper.attendCancel(requestMap);
//            	requestMap.getString("grcode"), requestMap.getString("grseq"), requestMap.getString("userno")
            	i = myClassMapper.canonStuLec(requestMap);
            	
            	if (i > 0){
            		Msg = "수강 신청이 취소되었습니다. ";
            	}
            }
          
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return Msg;        
	}	
	
	

	
	/**selectAttendDetail
	 * 등록
	 * @param requestMap
	 * @return DataMap
	 * @throws Exception
	 */
	public String applyInfo2(DataMap requestMap, HttpServletRequest request) throws Exception{
		String grcode = requestMap.getString("grcode");
		String Msg = "";
        try {
        	
            //동일과정 1년 내 재신청 불가 체크
//        	requestMap.getString("userno"), requestMap.getString("grcode")
            DataMap sp1 = myClassMapper.sameClass(requestMap);
            sp1.setNullToInitialize(true);
            
            boolean check = true;
            
            LoginInfo loginInfo = (LoginInfo)request.getAttribute("LOGIN_INFO");
            
            System.out.println(sp1.get("cnt") + "_______________");
            
            if(Util.getIntValue(sp1.getString("cnt"),0) > 0){
            	Msg = "동일과정은 3년 내 재신청이 불가합니다.";
            	check = false;
            	if("10G0000370".equals(grcode)){
            		Msg = "";
            	}
            }
            
            // 같은 직읍에서 동일과정 수강 신청 불가
            
            /*if(!("6289999".equals(loginInfo.getSessDept()))) {   // 공무원 
	            DataMap sp11 = myClassMapper.sameJik(requestMap);
	            sp1.setNullToInitialize(true);
	            
	            System.out.println(sp11.get("cnt") + "_______________");
	            
	            if(Util.getIntValue(sp11.getString("cnt"),0) > 0){
	            	Msg = "이미 동일 직급에서  수료하신 과정은  재신청이 불가합니다.";
	            	check = false;
	            }
            }*/
            
//            requestMap.getString("grcode"), requestMap.getString("grseq")
            DataMap sp2 = myClassMapper.grseqList(requestMap);
            sp2.setNullToInitialize(true);
            
            if(sp2.getString("fCyber").equals("Y")){
//            	requestMap.getString("userno"), requestMap.getString("grcode"), sp2.getString("started")
            	requestMap.set("started", sp2.getString("started"));
            	DataMap sp3 = myClassMapper.sameTimeList(requestMap);
            	sp3.setNullToInitialize(true);
            	if (Util.getIntValue(sp3.getString("cnt").toString(),0) > 0){
            		Msg = "사이버교육과정은 동일 교육기간 내에 2개까지만 신청 가능합니다.";
            		check = false;
            	}
            } else {
//            	requestMap.getString("grcode"), requestMap.getString("reseq"), requestMap.getString("userno")
            	DataMap sp4 = myClassMapper.sameCousreList(requestMap);
            	sp4.setNullToInitialize(true);
            	if (Util.getIntValue(sp4.getString("cnt2"),0) > 0){
            		Msg = "선택한 과정은 집합교육일정에 중복되어서 신청이 불가합니다.";
            		check = false;
            	}
            }
            
            if (check){
            	//사용자 정보 추출.
        		//LoginInfo loginInfo = (LoginInfo)request.getAttribute("LOGIN_INFO");
            	requestMap.setString("sessName", loginInfo.getSessName());
            	int i = myClassMapper.insertData(requestMap);
            	if (i > 0){
//        			pstmt.setString(10, "".equals(StringUtil.nvl(requestMap.getString("ldapcode"),"")) ? null:requestMap.getString("deptsub"));
            		requestMap.setString("ldapname", "".equals(StringUtil.nvl(requestMap.getString("ldapcode"),"")) ? null:requestMap.getString("deptsub"));
            		myClassMapper.modUserInfo(requestMap);
            		myClassMapper.modUserInfoLog(requestMap);
            		
            		if(sp2.get("fCyber").equals("Y")) {
	            		String name = requestMap.getString("userName");
	            		int month = DateUtil.getMonth();
	            		
	            		String txtMessage = "[인천인재개발원] " +name+ "님 공무원 사이버 교육이 시작되었으니 " +month+ ".21 일 까지 수료 바랍니다."; 
	            		requestMap.setString("txtMessage", txtMessage);
	            		requestMap.setString("callback", "0324407684");
	            		mailService.insertSmsMsgAction(requestMap);
            		}
            		Msg = "ok";
            	}
            }
            
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return Msg;        
	}
	
	public DataMap ajaxMemberUpdate(String deptCode) throws Exception{
		
        DataMap resultMap = null;
        
        try {
        	
            // 전체 강좌 리스트 가져오기
            resultMap = myClassMapper.partList(deptCode);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}	
	
	public int ajaxMemberUpdate(DataMap requestMap) throws Exception{
		
        int errorcode = -1;
        
        try {
        	requestMap.setString("hp", requestMap.getString("hp").replaceAll(" ", ""));
            errorcode = myClassMapper.ajaxMemberUpdate(requestMap);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return errorcode;        
	}	
	
	

	
	
	public DataMap attendPopupList(DataMap requestMap) throws Exception{
		
        DataMap resultMap = null;
        
        try {
        	
            resultMap = myClassMapper.attendPopupList(requestMap);
            requestMap.setString("restrict",myClassMapper.getRestrict(requestMap));
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
	
	
	public DataMap attendPopupBasicList(DataMap requestMap) throws Exception{
		
        DataMap resultMap = null;
        
        try {
        	
            resultMap = myClassMapper.attendPopupBasicList(requestMap);
            requestMap.setString("restrict",myClassMapper.getRestrict(requestMap));
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
	
	/**
	 * 사용자 게시판 답글시 step의 제일 낮은값을 구해온다
	 * @param tableName
	 * @param step
	 * @param minSetp
	 * @param depth
	 * @return
	 * @throws Exception
	 */
	public double selectSuggestionMinNoRow(String grcode, String grseq, double step, double minSetp, int depth) throws Exception{
    	double resultValue = 0;
    	try {
    		
    		Map params = new HashMap();
    		
    		params.put("grcode", grcode);
    		params.put("grseq", grseq);
    		params.put("step", step);
    		params.put("minSetp", minSetp);
    		params.put("depth", depth);
    		
//    		grcode, grseq, step, minSetp, depth
    		resultValue = myClassMapper.selectSuggestionMinNoRow(params);
    		
    	}catch(SQLException e){ 
    		throw new BizException(Message.getKey(e),e);
    	}finally {
        }
    	  return resultValue;
    }
	
	/**
	 * 게시판 권한정보 삭제
	 * 작성자 정윤철
	 * 작성일 6월 12일
	 * @param String boardId
	 * @return  deleteBoardManager
	 * @throws Exception
	 */
	public int modifySuggestion(DataMap requestMap) throws Exception{
		
	    int returnValue = 0;
	    
	    try {
	    	
	        returnValue = myClassMapper.modifySuggestion(requestMap);
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return returnValue;        
	}
	
	/**
	 * 카운트 최대값 가져오기
	 * @param requestMap
	 * @param tableName
	 * @param stringWhere
	 * @return
	 * @throws Exception
	 */
	
	public int suggestionDelete(DataMap requestMap) throws Exception {
		
		
    	int returnvalue = 0;
    	//테이블 네임
    	int count = Integer.parseInt(requestMap.getString("count"));
    	
	    try {
	    	
	    	if(count == 0){
	    		//하위글이 없을경우
	    		returnvalue = myClassMapper.deleteSuggestion(requestMap);
	    	}else{
	    		//하위글이 있을경우
	    		returnvalue = myClassMapper.updateSuggestionLikeDelete(requestMap);
	    	}
	    	
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return returnvalue;
    }
	
	/**
	 * 최대값 검색
	 * @param requestMap
	 * @return DataMap
	 * @throws Exception
	 */
	public int suggestionMaxCount(DataMap requestMap) throws Exception{
		
        int iNum = 0;
        
        try {
			//사용자글 등록 수정 하여야함
            iNum = myClassMapper.suggestionMaxCount(requestMap);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return iNum;        
	}	
	/**
	 * 방문자수 증가
	 * @param requestMap
	 * @return DataMap
	 * @throws Exception
	 * 
	 * 사용 안함 act에 주석처리 되어 있음
	 */
//	public int suggestionCnt(String stringQuery) throws Exception{
//		
//        int iNum = 0;
//        
//        try {
//        	
//            iNum = myClassMapper.suggestionCnt(stringQuery);
//                                    
//        } catch (SQLException e) {
//            throw new BizException(Message.getKey(e), e);
//        } finally {
//        }
//        return iNum;        
//	}
	
	/**
	 * 과정리스트
	 * @param requestMap
	 * @return DataMap
	 * @throws Exception
	 */
	public DataMap suggestionList(DataMap requestMap) throws Exception{
		
		DataMap resultMap = null;
        
        try {
        	
            /**
             * 공지사항 검색조건 설정
             */
	    	int totalCnt = myClassMapper.suggestionListCount(requestMap);
        	
        	Map<String, Object> pageInfo = Util.getPageInfo(totalCnt, requestMap);
        	
        	requestMap.set("page", pageInfo);
        	
            resultMap = myClassMapper.suggestionList(requestMap);
            
            PageNavigation pageNavi = Util.getPageNavigation(pageInfo);
            resultMap.set("PAGE_INFO", pageNavi);
            
            // 과정명 등록
//		    requestMap.getString("grcode"), requestMap.getString("grseq")
		    requestMap.setString("grcodeniknm",myClassMapper.getGrseqName(requestMap));
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
	
	
	/**
	 * 과정 상세보기
	 * @param requestMap
	 * @return userId
	 * @throws Exception
	 */
	public DataMap suggestionView(DataMap requestMap) throws Exception{
		
		DataMap resultMap = null;
        
        try {
        	
            /**
             * 공지사항 검색조건 설정
             */
            resultMap = myClassMapper.suggestionView(requestMap);
            
            // 과정명 등록
//            requestMap.getString("grcode"), requestMap.getString("grseq")
            resultMap.setString("grcodeniknm",myClassMapper.getGrseqName(requestMap));                        
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
	
	public int insertSuggestion(DataMap requestMap) throws Exception{
		
	    int returnValue = 0;
	    
	    try {
	        
	    	requestMap.setString("namoContent", requestMap.getString("namoContent").replaceAll("script", "스크립트").replaceAll("/script", "/스크립트").replaceAll("css", "씨에스에스").replaceAll("/css", "/씨에스에스"));
	    	requestMap.setString("finishYn", "N");
	    	requestMap.setString("title", RegExpUtil.replacePattern(requestMap.getString("title"), RegExpUtil.HTML_PATTERN));
	    	
	        returnValue = myClassMapper.insertSuggestion(requestMap);
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return returnValue;        
	}

	
	/*
	 * 사용자 게시판 답글시 step의 제일 낮은값을 구해온다
	 * @param tableName
	 * @param step
	 * @param minSetp
	 * @param depth
	 * @return
	 * @throws Exception
	 */
	public double selectDiscussMinNoRow(String grcode, String grseq, double step, double minSetp, int depth) throws Exception{
    	double resultValue = 0;
    	try {
    		
    		Map params = new HashMap();
    		
    		params.put("grcode", grcode);
    		params.put("grseq", grseq);
    		params.put("step", step);
    		params.put("minSetp", minSetp);
    		params.put("depth", depth);
//    		grcode, grseq, step, minSetp, depth
    		resultValue = myClassMapper.selectDiscussMinNoRow(params);
    		
    	}catch(SQLException e){ 
    		throw new BizException(Message.getKey(e),e);
    	}finally {
        }
    	  return resultValue;
    }
	
	/**
	 * 게시판 권한정보 삭제
	 * 작성자 정윤철
	 * 작성일 6월 12일
	 * @param String boardId
	 * @return  deleteBoardManager
	 * @throws Exception
	 */
	public int modifyDiscuss(DataMap requestMap) throws Exception{
		
	    int returnValue = 0;
	    
	    try {
	    	
	        returnValue = myClassMapper.modifyDiscuss(requestMap);
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return returnValue;        
	}
	
	/**
	 * 카운트 최대값 가져오기
	 * @param requestMap
	 * @param tableName
	 * @param stringWhere
	 * @return
	 * @throws Exception
	 */
	
	public int discussDelete(DataMap requestMap) throws Exception {
		
    	int returnvalue = 0;
    	//테이블 네임
    	String query = "";
    	
    	int count = Integer.parseInt(requestMap.getString("count"));
    	
	    try {
	    	
	    	if(count == 0){
	    		//하위글이 없을경우
				myClassMapper.deleteDiscuss(requestMap);
	    		
	    	}else{
	    		//하위글이 있을경우
	    		query = "UPDATE TB_GRDISCUSS SET TITLE='삭제된 글입니다', CONTENT= '삭제된 글입니다', GROUPFILE_NO='-2' ";
	    		query += "WHERE grcode = '"+requestMap.getString("grcode")+"' ";
				query += "AND grseq = '"+requestMap.getString("grseq")+"' ";
				query += "AND seq = '"+requestMap.getString("seq")+"' ";
	    		//talbeName +="AND WUSERNO =" + requestMap.getString("sessNo");
				myClassMapper.updateDiscussLikeDelete(requestMap);
	    	}
	    	
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return returnvalue;
    }
	
	/**
	 * 최대값 검색
	 * @param requestMap
	 * @return DataMap
	 * @throws Exception
	 */
	public int discussMaxCount(String strQuery) throws Exception{
		
        int iNum = 0;
        
        try {
        	
//            iNum = myClassMapper.discussMaxCount(strQuery);
        	iNum = myClassMapper.discussCnt(strQuery);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return iNum;        
	}	
	/**
	 * 방문자수 증가
	 * @param requestMap
	 * @return DataMap
	 * @throws Exception
	 */
	public int discussCnt(String stringQuery) throws Exception{
		
        int iNum = 0;
        
        try {
        	
            iNum = myClassMapper.discussCntUpdate(stringQuery);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return iNum;        
	}
	
	/**
	 * 과정리스트
	 * @param requestMap
	 * @return DataMap
	 * @throws Exception
	 */
	public DataMap discussList(DataMap requestMap) throws Exception{
		
		DataMap resultMap = null;
        
        try {
        	
	    	int totalCnt = myClassMapper.discussListCount(requestMap);
        	
        	Map<String, Object> pageInfo = Util.getPageInfo(totalCnt, requestMap);
        	
        	requestMap.set("page", pageInfo);
        	
            resultMap = myClassMapper.discussList(requestMap);
            
            PageNavigation pageNavi = Util.getPageNavigation(pageInfo);
            resultMap.set("PAGE_INFO", pageNavi);
        	
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
	
	
	/**
	 * 과정 상세보기
	 * @param requestMap
	 * @return userId
	 * @throws Exception
	 */
	public DataMap discussView(DataMap requestMap) throws Exception{
		
		DataMap resultMap = null;
        
        try {
        	
            /**
             * 공지사항 검색조건 설정
             */
            resultMap = myClassMapper.discussView(requestMap);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
	
	public int insertDiscuss(DataMap requestMap) throws Exception{
		
	    int returnValue = 0;
	    
	    try {
	        
	    	requestMap.setString("namoContent", requestMap.getString("namoContent").replaceAll("script", "스크립트").replaceAll("/script", "/스크립트").replaceAll("css", "씨에스에스").replaceAll("/css", "/씨에스에스"));
	    	requestMap.setString("title", RegExpUtil.replacePattern(requestMap.getString("title"), RegExpUtil.HTML_PATTERN));
	    	requestMap.setInt("visit", 0);
	    	
	        returnValue = myClassMapper.insertDiscuss(requestMap);
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return returnValue;        
	}
	
	

	/**
	 * 사이버과목 회차별 SCO(ITEM) 진도율확인하기
	 * 작성자 최종삼
	 * 작성일 8월 29일
	 * @param String boardId
	 * @return  deleteBoardManager
	 * @throws Exception
	 */
	public DataMap progressRate(DataMap requestMap) throws Exception{
	    
		DataMap resultMap = null;
	    
	    try {
	    	
	        // 상세정보 가져오기
            resultMap = myClassMapper.progressRate(requestMap);
	        
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return resultMap;      
	}
	
	/**
	 * 사이버과목 선택
	 * 작성자 최종삼
	 * 작성일 8월 29일
	 * @param String boardId
	 * @return  deleteBoardManager
	 * @throws Exception
	 */
	public String choiceSubLecture(DataMap requestMap) throws Exception{
	    
	    String Msg = "";
	    
	    try {
//	    	requestMap.getString("grcode"), requestMap.getString("grseq"), requestMap.getString("userno"),requestMap.getString("subj"), requestMap.getString("choice_subj")
	       	int iNum = myClassMapper.choiceSubLecture(requestMap);
	       	if (iNum == 0){
	       		Msg = "선택과목 등록이 실패하였습니다.";
	       	} else {
	       		Msg = "선택과목이 선택 되었습니다.";
	       	}
	        
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return Msg;      
	}
	
	/**
	 * 사이버과목 선택 리스트
	 * 작성자 최종삼
	 * 작성일 8월 29일
	 * @param String boardId
	 * @return  deleteBoardManager
	 * @throws Exception
	 */
	public DataMap selectSubLecture(DataMap requestMap) throws Exception{
	    
		DataMap resultMap = null;
	    
	    try {
	    	
	        // 사이버 과목인지 아닌지 체크
	        String str = myClassMapper.kindSubLecture(requestMap.getString("subj"));
	        
	        // 사이버 과목이라면 해당 선택 과목리스트 가져오기
	        if (str.equals("S")){
//	        	requestMap.getString("grcode"), requestMap.getString("grseq"), requestMap.getString("subj")
	        	resultMap = myClassMapper.selectSubLecture(requestMap);
	        }
	        
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return resultMap;      
	}
	
	/**
	 * 사이버과목 회차 리스트
	 * 작성자 최종삼
	 * 작성일 8월 29일
	 * @param String boardId
	 * @return  deleteBoardManager
	 * @throws Exception
	 */
	public DataMap courseDetail(DataMap requestMap) throws Exception{
	    
		DataMap resultMap = null;
	    
	    try {
	    	
	        // 상세정보 가져오기
            resultMap = myClassMapper.courseDetail(requestMap);
	        
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return resultMap;      
	}

	 /**
	 * 수강 개별 뷰페이지
	 * 작성자 최종삼
	 * 작성일 8월 29일
	 * @param String boardId
	 * @return  deleteBoardManager
	 * @throws Exception
	 */
//	selectGrnoticeList
	public DataMap grnoticeListView(DataMap requestMap) throws Exception{
	    
		DataMap resultMap = null;
	    
	    try {
	    	
            // 카운터 증가
            myClassMapper.grnoticeCntPlus(requestMap);
	        // 상세정보 가져오기
            resultMap = myClassMapper.selectGrnoticeView(requestMap);
	        
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return resultMap;      
	}
	

	public DataMap selectGrnoticeList(DataMap requestMap) throws Exception{
		
	    DataMap resultMap = null;
	    
	    try {
	    	int totalCnt = myClassMapper.selectGrnoticeListCount(requestMap);
        	
        	Map<String, Object> pageInfo = Util.getPageInfo(totalCnt, requestMap);
        	
        	requestMap.set("page", pageInfo);
        	
            resultMap = myClassMapper.selectGrnoticeList(requestMap);
            
            PageNavigation pageNavi = Util.getPageNavigation(pageInfo);
		    resultMap.set("PAGE_INFO", pageNavi);
	        
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return resultMap;        
	}
	
	/**
	 * 신청중인 수강목록
	 * @param requestMap
	 * @return tableName
	 * @return DataMap
	 * @throws Exception
	 */
	public DataMap selectCourseList(DataMap requestMap) throws Exception{
		
        DataMap resultMap = null;
        
        try {
        	
            resultMap = myClassMapper.selectCourseList(requestMap);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
	
	
	
	
	/**
	 * 수강 세부 내역
	 * @param requestMap
	 * @return tableName
	 * @return DataMap
	 * @throws Exception
	 */
	public DataMap courseDetailView(DataMap requestMap) throws Exception{
		
		DataMap resultMap = null;
        
        try {
        	
            resultMap = myClassMapper.courseDetailView(requestMap);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
	
	
	
	/**
	 * 동기모임 상세 리스트
	 * @param requestMap
	 * @return tableName
	 * @return DataMap
	 * @throws Exception
	 */
	public DataMap selectClassView(DataMap requestMap) throws Exception{
		
		DataMap resultMap = null;
        
        try {
        	
	    	int totalCnt = myClassMapper.classViewCount(requestMap);
        	
        	Map<String, Object> pageInfo = Util.getPageInfo(totalCnt, requestMap);
        	
        	requestMap.set("page", pageInfo);
        	
            resultMap = myClassMapper.classView(requestMap);
            
            PageNavigation pageNavi = Util.getPageNavigation(pageInfo);
		    resultMap.set("PAGE_INFO", pageNavi);
        	
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
	
	
	/**
	 * 동기모임 리스트
	 * @param requestMap
	 * @return tableName
	 * @return DataMap
	 * @throws Exception
	 */
	public DataMap selectClassList(DataMap requestMap) throws Exception{
		
		DataMap resultMap = null;
        
        try {
        	
	    	int totalCnt = myClassMapper.classListCount(requestMap);
        	
        	Map<String, Object> pageInfo = Util.getPageInfo(totalCnt, requestMap);
        	
        	requestMap.set("page", pageInfo);
        	
            resultMap = myClassMapper.classList(requestMap);
            
            PageNavigation pageNavi = Util.getPageNavigation(pageInfo);
		    resultMap.set("PAGE_INFO", pageNavi);
        	
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
	
	

	//2010.01.11 - woni82
	//회원탈퇴를 위한 프로세스 변경
	//기존의 주민등록번호에서 이메일 주소로 변경.
	public DataMap searchDeleteUserEmail(DataMap requestMap) throws Exception{
		
		DataMap resultMap = null;
        
        try {
        	
            resultMap = myClassMapper.searchDeleteUserEmail(requestMap);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
	
	//회원탈퇴를 위한 프로세스 
	//기존의 주민등록번호 사용 프로세스.
	public DataMap searchDeleteUser(DataMap requestMap) throws Exception{
		
        DataMap resultMap = null;
        
        try {
        	
            resultMap = myClassMapper.searchDeleteUser(requestMap);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
	
	
	
	
	public DataMap getUserNoticeList(DataMap requestMap) throws Exception{
		
        DataMap resultMap = null;
        
        try {
    	
            resultMap = myClassMapper.getUserNoticeList(requestMap);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
	
	
	public DataMap getUserNoticeView(DataMap requestMap) throws Exception{
		
        DataMap resultMap = null;
        
        try {
        	
            resultMap = myClassMapper.getUserNoticeView(requestMap);
            myClassMapper.getUserNoticeViewReadUpdate(requestMap);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
	
	public DataMap getMyQuestionView(DataMap requestMap) throws Exception{
		
		DataMap resultMap = null;
        
        try {
      	
            resultMap = myClassMapper.getMyQuestionView(requestMap);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
	
	
	/**
	 * 학습개체 내역
	 * @param requestMap
	 * @return DataMap
	 * @throws Exception
	 */
	public DataMap selectItemList(DataMap requestMap) throws Exception{
		
        DataMap resultMap = null;
        
        try {
        	
            /**
             * 각 검색조건 만들기
            String stringValue = "DECODE(PROGRESSSUBJ(A.GRCODE,A.GRSEQ,B.SUBJ,'"+requestMap.getString("userno")+"'),'',0,PROGRESSSUBJ(A.GRCODE,A.GRSEQ,B.SUBJ,'"+requestMap.getString("userno")+"'))||'%' AS PROGRESS";
            
            String strCList = "AND A.GRCODE = '"+requestMap.getString("grcode")+"'";
            	strCList += "AND A.GRSEQ = '"+requestMap.getString("grseq")+"'";
            	strCList += "AND A.USERNO = '"+requestMap.getString("userno")+"'";
            
            resultMap = dao.selectItemList(requestMap, strCList, stringValue);
            */
            resultMap = myClassMapper.selectItemList(requestMap);
            
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        
        return resultMap;        
	}
	
	/**
	 * 과정기수 상세정보
	 * @param requestMap
	 * @return DataMap
	 * @throws Exception
	 */
	public DataMap selectGrInfo(DataMap requestMap) throws Exception {
		
		DataMap resultMap = null;
        
        try {
        	
            resultMap = myClassMapper.selectGrInfo(requestMap);
            
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
	
	public Double selectProgressscoAvg(DataMap requestMap) throws Exception {
		
		Double return_number = null;
        
        try {
        	
            return_number = myClassMapper.selectProgressscoAvg(requestMap);
            
            if(return_number == null){
            	return 0.0;
            }
            
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return return_number;        
	}
	
	
	public DataMap selectLimit(String grcode, String grseq, String userno) throws Exception{
		
		DataMap limitMap = new DataMap();
		DataMap limit = new DataMap();
		
        limit.put("grcode", grcode);
        limit.put("grseq", grseq);
        
        limitMap.add("limit",myClassMapper.selectDeptInfo(userno).trim());
        
       String limitNumber =  myClassMapper.selectGrInfo(limit).getString("limit");
       
       	if(limitNumber != null){
       		
       		limitMap.add("limit",limitNumber.trim());     
       	}
       
        

		return limitMap;
		
	}
	
	
}
