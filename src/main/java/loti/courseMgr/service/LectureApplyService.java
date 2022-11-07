package loti.courseMgr.service;

import gov.mogaha.gpin.sp.util.StringUtil;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import loti.courseMgr.mapper.LectureApplyMapper;
import loti.courseMgr.mapper.StuOutMapper;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import ut.lib.exception.BizException;
import ut.lib.login.LoginInfo;
import ut.lib.page.PageNavigation;
import ut.lib.support.DataMap;
import ut.lib.util.Constants;
import ut.lib.util.Message;
import ut.lib.util.Util;
import common.service.BaseService;

@Service
public class LectureApplyService extends BaseService {

	@Autowired
	private LectureApplyMapper lectureApplyMapper;
	@Autowired
	@Qualifier("courseMgrStuOutMapper")
	private StuOutMapper stuOutMapper;
	
	/**
	 * 기관명 리스트
	 */
	public DataMap selectDeptList() throws BizException{
		DataMap resultMap = new DataMap();
        
        try {
        	resultMap = lectureApplyMapper.selectDeptList();
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;
	}
	
	/**
	 * 이전기수 수료 인원 조회
	 */
	public DataMap selectGrseqFinishMember(String grcode, String grseq, String deptStr) throws BizException{
		DataMap resultMap = new DataMap();
        
        try {
        	String whereDeptStr = "";
            if(!deptStr.equals(""))
            	whereDeptStr = "  AND A.rdept IN ("+deptStr+")  ";
            
            Map<String, Object> paramMap = new HashMap<String, Object>();
            paramMap.put("grcode", grcode);
            paramMap.put("grseq", grseq);
            paramMap.put("whereDeptStr", whereDeptStr);
            
            resultMap = lectureApplyMapper.selectGrseqFinishMember2(paramMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;
	}
	
	/**
	 * 이전기수 수료 인원 조회 (사이버)
	 */
	public DataMap selectGrseqFinishMemberForCyber(String grcode, String grseq, String deptStr) throws BizException{
		DataMap resultMap = new DataMap();
        
        try {
        	String whereDeptStr = "";
            if(!deptStr.equals(""))
            	whereDeptStr = "  AND dept IN (" + deptStr + ")  ";
            if(!grcode.equals(""))
            	whereDeptStr = "  AND A.GRCODE = '" + grcode + "'  ";
            
            Map<String, Object> paramMap = new HashMap<String, Object>();
            paramMap.put("grseq", grseq);
            paramMap.put("whereDeptStr", whereDeptStr);
            
            resultMap = lectureApplyMapper.selectGrseqFinishMemberForCyber(paramMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;
	}
	
	/**
	 * 기관별 조회/승인 (부서별) (수료정보 table TB_GRRESULT)
	 */
	public DataMap selectAppInfoByDeptList(String grcode, String grseq, String deptStr) throws BizException{
		DataMap resultMap = new DataMap();
        
        try {
        	String whereDeptStr = "";
            if(!deptStr.equals(""))
            	whereDeptStr = "  AND dept IN ("+deptStr+")  ";
            
            Map<String, Object> paramMap = new HashMap<String, Object>();
            paramMap.put("grcode", grcode);
            paramMap.put("grseq", grseq);
            paramMap.put("whereDeptStr", whereDeptStr);
            
            resultMap = lectureApplyMapper.selectAppInfoByDeptList(paramMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;
	}
	
	/**
	 * Cyber 수강신청 리스트
	 */
	public DataMap selectAppInfoByDeptListForCyber(String grcode, String grseq, String deptStr) throws BizException{
		DataMap resultMap = new DataMap();
        
        try {
        	String whereDeptStr = "";
            if(!deptStr.equals(""))
            	whereDeptStr = "  AND a.dept IN (" + deptStr + ")  ";
            if(!grcode.equals(""))
            	whereDeptStr = "  AND A.GRCODE = '" + grcode + "'  ";
            
            Map<String, Object> paramMap = new HashMap<String, Object>();
            paramMap.put("grseq", grseq);
            paramMap.put("whereDeptStr", whereDeptStr);
            
            resultMap = lectureApplyMapper.selectAppInfoByDeptListForCyber2(paramMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;  
		
	}
	
	/**
	 * 기수의 부서별 수강신청 인원수
	 */
	public DataMap selectAppInfoByDeptCntList(String grcode, String grseq) throws BizException{
		DataMap resultMap = new DataMap();
        
        try {
        	 Map<String, Object> paramMap = new HashMap<String, Object>();
             paramMap.put("grcode", grcode);
             paramMap.put("grseq", grseq);
             
        	resultMap = lectureApplyMapper.selectAppInfoByDeptCntList(paramMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;
	}
	
	/**
	 * 기수의 부서별 수강신청 인원수 (사이버)
	 */
	public DataMap selectAppInfoByDeptCntListForCyber(String grcode, String grseq) throws BizException{
		DataMap resultMap = new DataMap();
        
        try {
        	String whereStr = "";
            if(!grcode.equals("")){
            	whereStr += " AND A.GRCODE = '"+ grcode +"' " ;
            }
            
            Map<String, Object> paramMap = new HashMap<String, Object>();
            paramMap.put("grseq", grseq);
            paramMap.put("whereStr", whereStr);
            
            resultMap = lectureApplyMapper.selectAppInfoByDeptCntListForCyber(paramMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;
	}
	
	/**
	 * 수강생의 교번 부여
	 */
	public int updateAppInfoEduNo(String userno, DataMap requestMap) throws BizException{
		int resultValue = 0;
        
        try {
        	String grcode = requestMap.getString("grcode");
            String grseq = requestMap.getString("grseq");
            
            //과정 기수를 듣고 있는 학생 가져오기.
            Map<String, Object> paramMap = new HashMap<String, Object>();
            paramMap.put("grcode", grcode);
            paramMap.put("grseq", grseq);
            
            DataMap userMap = lectureApplyMapper.selectAppInfoByGrChkList(paramMap);
            if(userMap == null) userMap = new DataMap();
            userMap.setNullToInitialize(true);
            
            DataMap appInfoMap = new DataMap();
            for(int i = 0; i < userMap.keySize("userno"); i++){
            	appInfoMap.setString("grcode", grcode);
            	appInfoMap.setString("grseq", grseq);
            	appInfoMap.setInt("eduno", i+1); //교번은 차후 다시 논의가 필요 할것 같음. 현재는 1,2,3,4,5....
            	appInfoMap.setString("luserno", userno);
            	appInfoMap.setString("userno", userMap.getString("userno", i));
            	
            	lectureApplyMapper.updateAppInfoEduNo(appInfoMap); //수강생 교번 부여
            	
            	appInfoMap.clear();
            }
            resultValue++;         
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultValue;
	}
	
	/**
	 * 수강신청 승인
	 */
	public int execAppInfoAgree(String userno, DataMap requestMap) throws BizException{
		int resultValue = 0;
		Map<String, Object> paramMap = null;
		
        try {
        	String grcode = requestMap.getString("grcode");
            String grseq = requestMap.getString("grseq");
            
            String person = "";
            String dept = "";
            String name = "";
            String jik = "";
            
            int tmpResult = 0;
            DataMap appInfoMap = new DataMap();
            for(int i = 1 ; i <= requestMap.getInt("applyCnt") ; i++){
            	person = requestMap.getString("edu"+i);
            	dept = requestMap.getString("dept"+i);
            	name = requestMap.getString("name"+i);
            	jik = requestMap.getString("jik"+i);
            	
            	appInfoMap.setString("grcode", grcode);
            	appInfoMap.setString("grseq", grseq);
            	appInfoMap.setString("luserno", userno);
            	appInfoMap.setString("userno", person);
    			appInfoMap.setString("name", name);
    			appInfoMap.setString("dept", dept);
    			appInfoMap.setString("jik", jik);
    			
            	if( !requestMap.getString("chk"+i).equals("") ){ //체크시
                	appInfoMap.setString("grchk", "Y"); 
                	
                	//수강생의 승인/승인취소 처리.
                	lectureApplyMapper.updateAppInfoGrChk(appInfoMap);
            		
                	paramMap = new HashMap<String, Object>();
                	paramMap.put("grcode", grcode);
                    paramMap.put("grseq", grseq);
                    paramMap.put("userno", person);
                    
            		tmpResult = lectureApplyMapper.selectStuLecUserCnt(paramMap); //수강생 등록 여부 확인.
            		
            		if(tmpResult == 0){ //수강생 등록이 안되어있는경우
            			//수강생 등록
            			lectureApplyMapper.insertStuLecUserSpec(appInfoMap);
            		}
            		
            		resultValue++;
            	}else{ //미 체크시
            		appInfoMap.setString("eduno", "");
                	appInfoMap.setString("grchk", "N"); 
                	
                	//수강생의 승인/승인취소 및 교번 처리.
                	lectureApplyMapper.updateAppInfoGrChkAndEduNo(appInfoMap);
            		
            		// 과정기수의 수강생 과목 결과 정보 삭제.
                	paramMap = new HashMap<String, Object>();
                	paramMap.put("grcode", grcode);
                    paramMap.put("grseq", grseq);
                    paramMap.put("userno", person);
                    
                	lectureApplyMapper.deleteSubjResultByUserno(paramMap);
            		
            		// 과정기수의 속한 학생 정보 삭제.
                	lectureApplyMapper.deleteStuLecByGrseq(paramMap);
            		
            		resultValue++;
            	}
            	appInfoMap.clear();
            }
            
            //과정 기수를 듣고 있는 학생 가져오기.
            paramMap = new HashMap<String, Object>();
        	paramMap.put("grcode", grcode);
            paramMap.put("grseq", grseq);
            
            DataMap userMap = lectureApplyMapper.selectAppInfoByGrChkList(paramMap);
            if(userMap == null) userMap = new DataMap();
            userMap.setNullToInitialize(true);
            
            appInfoMap.clear();
            for(int i = 0; i < userMap.keySize("userno"); i++){
            	appInfoMap.setString("grcode", grcode);
            	appInfoMap.setString("grseq", grseq);
            	appInfoMap.setInt("eduno", i+1); //교번은 차후 다시 논의가 필요 할것 같음. 현재는 1,2,3,4,5....
            	appInfoMap.setString("luserno", userno);
            	appInfoMap.setString("userno", userMap.getString("userno", i));
            	
            	lectureApplyMapper.updateAppInfoEduNo(appInfoMap); //수강생 교번 부여
            	appInfoMap.clear();
            }
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultValue;
	}
	
	/**
	 * 수강신청 승인
	 */
	public int execAppInfoAgree2(String userno, DataMap requestMap) throws BizException{
		int resultValue = 0;
		Map<String, Object> paramMap = null;
		
        try {
        	String grcode = requestMap.getString("grcode");
            String grseq = requestMap.getString("grseq");
            
            String dept = "";
            String name = "";
            String jik = "";
            
            int tmpResult = 0;
            DataMap appInfoMap = new DataMap();
            	
        	dept = requestMap.getString("deptcode");
        	name = requestMap.getString("name");
        	jik = requestMap.getString("jik");
        	
        	appInfoMap.setString("grcode", grcode);
        	appInfoMap.setString("grseq", grseq);
        	appInfoMap.setString("luserno", "A000000000000");
        	appInfoMap.setString("userno", userno);
			appInfoMap.setString("name", name);
			appInfoMap.setString("dept", dept);
			appInfoMap.setString("jik", jik);
			appInfoMap.setString("grchk", "Y"); 
			
			lectureApplyMapper.updateAppInfoGrChk(appInfoMap);
    		
			paramMap = new HashMap<String, Object>();
        	paramMap.put("grcode", grcode);
            paramMap.put("grseq", grseq);
            paramMap.put("userno", userno);
            
    		tmpResult = lectureApplyMapper.selectStuLecUserCnt(paramMap); //수강생 등록 여부 확인.
    		
    		if(tmpResult == 0){ //수강생 등록이 안되어있는경우
    			//수강생 등록
    			lectureApplyMapper.insertStuLecUserSpec(appInfoMap);
    		}
    		resultValue++;
            	
            appInfoMap.clear();
            //과정 기수를 듣고 있는 학생 가져오기.
            DataMap userMap = lectureApplyMapper.selectAppInfoByGrChkMaxCnt(paramMap);
            if(userMap == null) userMap = new DataMap();
            userMap.setNullToInitialize(true);
            
            appInfoMap.clear();
        	appInfoMap.setString("grcode", grcode);
        	appInfoMap.setString("grseq", grseq);
        	appInfoMap.setInt("eduno", userMap.getInt("seqno", 0));
        	appInfoMap.setString("luserno", userno);
        	appInfoMap.setString("userno", userno);
        	lectureApplyMapper.updateAppInfoEduNo(appInfoMap); //수강생 교번 부여
        	appInfoMap.clear();
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultValue;
	}

	/**
	 * 수강신청 승인 취소.
	 */
	public int execAppInfoCancel(String userno, DataMap requestMap) throws BizException{
		int resultValue = 0;
		Map<String, Object> paramMap = null;
		
        try {
        	String grcode = requestMap.getString("grcode");
            String grseq = requestMap.getString("grseq");
            
            String person = "";
            String dept = "";
            String name = "";
            String jik = "";
            
            DataMap appInfoMap = new DataMap();
            for(int i = 1 ; i <= requestMap.getInt("applyCnt") ; i++){
            	System.out.println("chichi ---- chk: " + requestMap.getString("chk"+i));
            	
            	person = requestMap.getString("edu"+i);
            	dept = requestMap.getString("dept"+i);
            	name = requestMap.getString("name"+i);
            	jik = requestMap.getString("jik"+i);
            	
            	appInfoMap.setString("grcode", grcode);
            	appInfoMap.setString("grseq", grseq);
            	appInfoMap.setString("luserno", userno);
            	appInfoMap.setString("userno", person);
    			appInfoMap.setString("name", name);
    			appInfoMap.setString("dept", dept);
    			appInfoMap.setString("jik", jik);
    			
            	if(!requestMap.getString("chk"+i).equals("")){
            		appInfoMap.setString("grchk", "");
            		
            		System.out.println("chichi ---- grchk: " + appInfoMap.getString("grchk", i));
            		
            		///수강생의 승인/승인취소 처리.
            		lectureApplyMapper.updateAppInfoGrChk(appInfoMap);
            		
            		//과정기수의 속한 학생 정보 삭제.
            		paramMap = new HashMap<String, Object>();
                	paramMap.put("grcode", grcode);
                    paramMap.put("grseq", grseq);
                    paramMap.put("userno", person);
                    
            		lectureApplyMapper.deleteStuLecByGrseq(paramMap);
            	}
            }
            
            //과정 기수를 듣고 있는 학생 가져오기.
            paramMap = new HashMap<String, Object>();
        	paramMap.put("grcode", grcode);
            paramMap.put("grseq", grseq);
            
            DataMap userMap = lectureApplyMapper.selectAppInfoByGrChkList(paramMap);
            if(userMap == null) userMap = new DataMap();
            userMap.setNullToInitialize(true);
            
            appInfoMap.clear();
            for(int i = 0; i < userMap.keySize("userno"); i++){
            	appInfoMap.setString("grcode", grcode);
            	appInfoMap.setString("grseq", grseq);
            	appInfoMap.setInt("eduno", i+1); //교번은 차후 다시 논의가 필요 할것 같음. 현재는 1,2,3,4,5....
            	appInfoMap.setString("luserno", userno);
            	appInfoMap.setString("userno", userMap.getString("userno", i));
            	
            	lectureApplyMapper.updateAppInfoEduNo(appInfoMap); //수강생 교번 부여
            	appInfoMap.clear();
            }
            
            resultValue++;
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultValue;
	}
	
	/**
	 * 기관 담당자의 1차 승인 취소
	 */
	public int execAppInfoCancelByDept(String userno, DataMap requestMap) throws BizException{
		int resultValue = 0;
        
        try {
        	String grcode = requestMap.getString("grcode");
            String grseq = requestMap.getString("grseq");
            
            String person = "";
            
            DataMap appInfoMap = new DataMap();
            for(int i = 1 ; i <= requestMap.getInt("applyCnt") ; i++){
            	person = requestMap.getString("edu"+i);
            	
            	appInfoMap.setString("grcode", grcode);
            	appInfoMap.setString("grseq", grseq);
            	appInfoMap.setString("luserno", userno);
            	appInfoMap.setString("userno", person);
    			
            	if( !requestMap.getString("chk"+i).equals("") ){
            		// 기관담당자의 1차 승인 취소
            		appInfoMap.setString("deptchk", ""); 
            		lectureApplyMapper.updateAppInfoDeptChk(appInfoMap);
            	}
            	appInfoMap.clear();
            }
            resultValue++;
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultValue;
	}
	
	/**
	 * 간략한 유저 정보 가져오기.
	 */
	public DataMap selectMemberDeptSimpleRow(String userNo) throws BizException{
		DataMap resultMap = null;
        
        try {
        	resultMap = lectureApplyMapper.selectMemberDeptSimpleRow(userNo);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;
	}
	
	/**
	 * 수료 이력 조회
	 */
	public DataMap selectMemberFinishList(String userNo) throws BizException{
		DataMap resultMap = new DataMap();
        
        try {
        	resultMap = lectureApplyMapper.selectMemberFinishList(userNo);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;
	}
	
	/**
	 * 수강신청자 정보 상세 조회
	 */
	public DataMap selectAppInfoRow(String grcode, String grseq, String userNo) throws BizException{
		DataMap resultMap = new DataMap();
		Map<String, Object> paramMap = null;
		
        try {
        	paramMap = new HashMap<String, Object>();
        	paramMap.put("grcode", grcode);
        	paramMap.put("grseq", grseq);
        	paramMap.put("userno", userNo);
        	
        	resultMap = lectureApplyMapper.selectAppInfoRow(paramMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;  
		
	}
	
	/**
	 * 기관명 리스트
	 */
	public DataMap selectDeptByUserYnList(String useYn) throws BizException{
		DataMap resultMap = new DataMap();
        
        try {
        	resultMap = lectureApplyMapper.selectDeptByUserYnList(useYn);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;
	}
	
	/**
	 * 부서 리스트
	 */
	public DataMap selectPartUseList(String dept) throws BizException{
		DataMap resultMap = new DataMap();
        
        try {
        	resultMap = lectureApplyMapper.selectPartUseList(dept);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;
	}
	
	/**
	 * 부서 리스트
	 */
	public DataMap selectLdapcodeList(String dept) throws BizException{
		DataMap resultMap = new DataMap();
        
        try {
        	resultMap = lectureApplyMapper.selectLdapcodeList(dept);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;
	}
	
	/**
	 * 수강신청 기관 및 부서 정보수정.
	 */
	public int updateAppInfoDeptAndPart(DataMap requestMap) throws BizException{
		int resultValue = 0;
		Map<String, Object> paramMap = null;
		
        try {
        	// 회원 테이블에 부서정보 동시 수정 쿼리 추가
        	paramMap = new HashMap<String, Object>();
        	paramMap.put("dept", requestMap.getString("dept"));
        	paramMap.put("partcd", requestMap.getString("partcd"));
        	paramMap.put("deptsub", requestMap.getString("deptsub"));
        	paramMap.put("jik", requestMap.getString("jik"));
        	paramMap.put("hp", requestMap.getString("hp"));
        	paramMap.put("partcd", requestMap.getString("partcd"));
        	paramMap.put("partnm", "".equals(StringUtil.nvl(requestMap.getString("partcd"),"")) ? "":StringUtil.nvl(requestMap.getString("deptsub"),""));
        	paramMap.put("userno", requestMap.getString("userno"));
        	
        	lectureApplyMapper.setMemberDept2(paramMap);
        	
        	paramMap.put("grcode", requestMap.getString("grcode"));
        	paramMap.put("grseq", requestMap.getString("grseq"));
        	lectureApplyMapper.updateGrrSultDeptAndPart(paramMap);
        	
            resultValue = lectureApplyMapper.updateAppInfoDeptAndPart(paramMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultValue;
	}
	
	/**
	 * 수강신청정보 삭제
	 */
	@Transactional
	public int deleteAppInfo(DataMap requestMap) throws BizException{
		int resultValue = 0;
		Map<String, Object> paramMap = null;
		
        try {
        	paramMap = new HashMap<String, Object>();
        	paramMap.put("grcode", requestMap.getString("grcode"));
        	paramMap.put("grseq", requestMap.getString("grseq"));
        	paramMap.put("userno", requestMap.getString("userno"));
        	
            //수강신청정보 삭제
        	stuOutMapper.deleteAppInfo(requestMap);
            //과목수강정보 삭제
            lectureApplyMapper.deleteStuLecByGrseq(paramMap);
            
            resultValue++;
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultValue;  
	}
	
	/**
	 * 수강신청 리스트.
	 */
	public DataMap selectAppInfoList(String grcode, String grseq, DataMap requestMap) throws BizException{
		DataMap resultMap = new DataMap();
		
        try {
        	Map<String, Object> paramMap = new HashMap<String, Object>();
        	paramMap.put("grcode", grcode);
        	paramMap.put("grseq", grseq);
        	
        	int appInfoListCount = lectureApplyMapper.selectAppInfoListCount(paramMap);
        	
        	Map<String, Object> pageInfo = Util.getPageInfo(appInfoListCount, requestMap);
        	pageInfo.put("grcode", grcode);
			pageInfo.put("grseq", grseq);
			
        	resultMap = lectureApplyMapper.selectAppInfoList(pageInfo);
        	PageNavigation pageNavi = Util.getPageNavigation(pageInfo);
			
			resultMap.set("PAGE_INFO", pageNavi);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;
	}

	/**
	 * 과정기수의 학생의 정보 숫자.
	 */
	public int selectStuLecUserCnt(String grcode, String grseq, String userNo) throws BizException{
		int resultValue = 0;
        
        try {
        	Map<String, Object> paramMap = new HashMap<String, Object>();
        	paramMap.put("grcode", grcode);
        	paramMap.put("grseq", grseq);
        	paramMap.put("userno", userNo);
        	
        	resultValue = lectureApplyMapper.selectStuLecUserCnt(paramMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultValue;
	}
	
	/**
	 * 사이버 과정의 교번 부여
	 */
	public int execCAppInfoEduNoForCyber(String userno, DataMap requestMap) throws BizException{
		int resultValue = 0;
		Map<String, Object> paramMap = null;
		
        try {
        	String grcode = requestMap.getString("grcode");
            String grseq = requestMap.getString("grseq");
            
            //과정 정보 가져오기 (기수만 선택했을경우에는 기수에 속한 사이버 과정 모두 가져와야함.)
            String whereStr = "";
            if(!grcode.equals(""))
            	whereStr = "  AND GRCODE = '" + grcode + "'  ";
            
            paramMap = new HashMap<String, Object>();
            paramMap.put("grcode", grcode);
        	paramMap.put("grseq", grseq);
        	paramMap.put("whereStr", whereStr);
        	
            DataMap grcodeListMap = lectureApplyMapper.selectGrseqByCyberGrcodeList(paramMap);
            if(grcodeListMap == null) grcodeListMap = new DataMap();
            grcodeListMap.setNullToInitialize(true);
            
            for(int k = 0; k < grcodeListMap.keySize("grcode"); k++){
            	grcode = grcodeListMap.getString("grcode", k);
            	
                //과정 기수를 듣고 있는 학생 가져오기.
                DataMap userMap = lectureApplyMapper.selectAppInfoByGrChkList(paramMap);
                if(userMap == null) userMap = new DataMap();
                userMap.setNullToInitialize(true);
                
                DataMap appInfoMap = new DataMap();
                for(int i = 0; i < userMap.keySize("userno"); i++){
                	appInfoMap.setString("grcode", grcode);
                	appInfoMap.setString("grseq", grseq);
                	appInfoMap.setInt("eduno", i+1); //교번은 차후 다시 논의가 필요 할것 같음. 현재는 1,2,3,4,5....
                	appInfoMap.setString("luserno", userno);
                	appInfoMap.setString("userno", userMap.getString("userno", i));
                	
                	lectureApplyMapper.updateAppInfoEduNo(appInfoMap); //수강생 교번 부여
                	
                	appInfoMap.clear();
                }
                resultValue++;
            }
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultValue;
	}
	
	
	/**
	 * 사이버 과정의 수강신청 승인 처리.
	 * @param userno
	 * @param requestMap
	 * @return
	 * @throws BizException
	 */
	public int execAppInfoAgreeForCyber(String userno, DataMap requestMap) throws BizException{
		int resultValue = 0;
		Map<String, Object> paramMap = null;
		
        try {
        	String grcode = requestMap.getString("grcode");
            String grseq = requestMap.getString("grseq");
            
            String person = "";
            String dept = "";
            String name = "";
            String jik = "";
            
            int tmpCnt = 0;
            int tmpResult = 0;
            DataMap appInfoMap = new DataMap();
            String tmpGrcode = "";
            for(int i = 1 ; i <= requestMap.getInt("applyCnt") ; i++){
            	person = requestMap.getString("edu"+i);
            	dept = requestMap.getString("dept"+i);
            	name = requestMap.getString("name"+i); 
            	jik = requestMap.getString("jik"+i);
            	tmpGrcode = requestMap.getString("grcode"+i);
            	
            	appInfoMap.setString("grcode", tmpGrcode);
            	appInfoMap.setString("grseq", grseq);
            	appInfoMap.setString("luserno", userno);
            	appInfoMap.setString("userno", person);
    			appInfoMap.setString("name", name);
    			appInfoMap.setString("dept", dept);
    			appInfoMap.setString("jik", jik);
    			
            	if(!requestMap.getString("chk"+i).equals("")){
                	appInfoMap.setString("grchk", "Y"); 
                	
                	//수강생의 승인/승인취소 처리.
                	lectureApplyMapper.updateAppInfoGrChk(appInfoMap);
            		
                	paramMap = new HashMap<String, Object>();
                    paramMap.put("grcode", tmpGrcode);
                	paramMap.put("grseq", grseq);
                	paramMap.put("userno", person);
                	
            		tmpResult = lectureApplyMapper.selectStuLecUserCnt(paramMap); //수강생 등록 여부 확인.
            		if(tmpResult == 0){ //수강생 등록이 안되어있는경우
            			//수강생 등록
            			lectureApplyMapper.insertStuLecUserSpec(appInfoMap);
            		}
            		
            		tmpCnt++;
            	}else{
            		appInfoMap.setString("eduno", "");
                	appInfoMap.setString("grchk", "N"); 
                	
                	//수강생의 승인/승인취소 및 교번 처리.
                	lectureApplyMapper.updateAppInfoGrChkAndEduNo(appInfoMap);
            		
            		// 과정기수의 수강생 과목 결과 정보 삭제.
                	paramMap = new HashMap<String, Object>();
                    paramMap.put("grcode", tmpGrcode);
                	paramMap.put("grseq", grseq);
                	paramMap.put("userno", person);
                	lectureApplyMapper.deleteSubjResultByUserno(paramMap);
            		
            		// 과정기수의 속한 학생 정보 삭제.
                	lectureApplyMapper.deleteStuLecByGrseq(paramMap);
            	}
            	appInfoMap.clear();
            }
            
            //선택한 수강생이 있을경우만.
            if(tmpCnt > 0){
                //교번 다시 부여 [s]
                //과정 정보 가져오기 (기수만 선택했을경우에는 기수에 속한 사이버 과정 모두 가져와야함.)
                String whereStr = "";
                if(!grcode.equals(""))
                	whereStr = "  AND GRCODE = '" + grcode + "'  ";
                
                paramMap = new HashMap<String, Object>();
                paramMap.put("grseq", grseq);
                paramMap.put("whereStr", whereStr);
            	
                DataMap grcodeListMap = lectureApplyMapper.selectGrseqByCyberGrcodeList(paramMap);
                if(grcodeListMap == null) grcodeListMap = new DataMap();
                grcodeListMap.setNullToInitialize(true);
                
                for(int k = 0; k < grcodeListMap.keySize("grcode"); k++){
                	tmpGrcode = grcodeListMap.getString("grcode", k);
                	
                    //과정 기수를 듣고 있는 학생 가져오기.
                	paramMap = new HashMap<String, Object>();
                	paramMap.put("grcode", tmpGrcode);
                	paramMap.put("grseq", grseq);
                    
                    DataMap userMap = lectureApplyMapper.selectAppInfoByGrChkList(paramMap);
                    if(userMap == null) userMap = new DataMap();
                    userMap.setNullToInitialize(true);
                    
                    appInfoMap.clear();
                    for(int i = 0; i < userMap.keySize("userno"); i++){
                    	appInfoMap.setString("grcode", tmpGrcode);
                    	appInfoMap.setString("grseq", grseq);
                    	appInfoMap.setInt("eduno", i+1); //교번은 차후 다시 논의가 필요 할것 같음. 현재는 1,2,3,4,5....
                    	appInfoMap.setString("luserno", userno);
                    	appInfoMap.setString("userno", userMap.getString("userno", i));
                    	
                    	lectureApplyMapper.updateAppInfoEduNo(appInfoMap); //수강생 교번 부여
                    	appInfoMap.clear();
                    }
                }
                //교번 다시 부여 [e]
            }
            resultValue++;
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultValue;
	}
	
	/**
	 * 사이버 과정의 수강신청 승인 취소 처리.
	 */
	public int execAppInfoCancelForCyber(String userno, DataMap requestMap) throws BizException{
		int resultValue = 0;
		Map<String, Object> paramMap = null;
		
        try {
        	String grcode = requestMap.getString("grcode");
            String grseq = requestMap.getString("grseq");
            
            String person = "";
            String dept = "";
            String name = "";
            String jik = "";
            int tmpCnt = 0;
            
            DataMap appInfoMap = new DataMap();
            String tmpGrcode = "";
            for(int i = 1 ; i <= requestMap.getInt("applyCnt") ; i++){
            	person = requestMap.getString("edu"+i);
            	dept = requestMap.getString("dept"+i);
            	name = requestMap.getString("name"+i);
            	jik = requestMap.getString("jik"+i);
            	tmpGrcode = requestMap.getString("grcode"+i);
            	
            	appInfoMap.setString("grcode", tmpGrcode);
            	appInfoMap.setString("grseq", grseq);
            	appInfoMap.setString("luserno", userno);
            	appInfoMap.setString("userno", person);
    			appInfoMap.setString("name", name);
    			appInfoMap.setString("dept", dept);
    			appInfoMap.setString("jik", jik);
    			
            	if(!requestMap.getString("chk"+i).equals("")){
            		appInfoMap.setString("grchk", ""); 
            		
            		///수강생의 승인/승인취소 처리.
            		lectureApplyMapper.updateAppInfoGrChk(appInfoMap);
            		
            		//과정기수의 속한 학생 정보 삭제.
            		paramMap = new HashMap<String, Object>();
                	paramMap.put("grcode", tmpGrcode);
                	paramMap.put("grseq", grseq);
                	paramMap.put("userno", person);
            		lectureApplyMapper.deleteStuLecByGrseq(paramMap);
            		
            		tmpCnt++;
            	}
            }
            
            //선택한 수강생이 있을경우만.
            if(tmpCnt > 0){
                //교번 다시 부여 [s]
                //과정 정보 가져오기 (기수만 선택했을경우에는 기수에 속한 사이버 과정 모두 가져와야함.)
                String whereStr = "";
                if(!grcode.equals(""))
                	whereStr = "  AND GRCODE = '" + grcode + "'  ";
                
                paramMap = new HashMap<String, Object>();
                paramMap.put("grseq", grseq);
                paramMap.put("whereStr", whereStr);
                
                DataMap grcodeListMap = lectureApplyMapper.selectGrseqByCyberGrcodeList(paramMap);
                if(grcodeListMap == null) grcodeListMap = new DataMap();
                grcodeListMap.setNullToInitialize(true);
                
                for(int k = 0; k < grcodeListMap.keySize("grcode"); k++){
                	tmpGrcode = grcodeListMap.getString("grcode", k);
                	
                    //과정 기수를 듣고 있는 학생 가져오기.
                	paramMap = new HashMap<String, Object>();
                	paramMap.put("grcode", tmpGrcode);
                	paramMap.put("grseq", grseq);
                	
                    DataMap userMap = lectureApplyMapper.selectAppInfoByGrChkList(paramMap);
                    if(userMap == null) userMap = new DataMap();
                    userMap.setNullToInitialize(true);
                    
                    appInfoMap.clear();
                    for(int i = 0; i < userMap.keySize("userno"); i++){
                    	appInfoMap.setString("grcode", tmpGrcode);
                    	appInfoMap.setString("grseq", grseq);
                    	appInfoMap.setInt("eduno", i+1); //교번은 차후 다시 논의가 필요 할것 같음. 현재는 1,2,3,4,5....
                    	appInfoMap.setString("luserno", userno);
                    	appInfoMap.setString("userno", userMap.getString("userno", i));
                    	
                    	lectureApplyMapper.updateAppInfoEduNo(appInfoMap); //수강생 교번 부여
                    	appInfoMap.clear();
                    }
                }
                //교번 다시 부여 [e]
            }

            resultValue++;
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultValue;
	}
	
	/**
	 * 간단한 회원정보 리스트 추출
	 */
	public DataMap selectMemberBySimpleDataList(DataMap requestMap) throws BizException{
		DataMap resultMap = null;
        
        try {
        	String whereStr = "";
            int tmpCnt = 0;
            
            for(int i = 1 ; i <= requestMap.getInt("applyCnt") ; i++){
            	if(!requestMap.getString("chk"+i).equals("")){
            		if(tmpCnt > 0) whereStr += ", ";
            		
            		whereStr += "'" + requestMap.getString("chk"+i) + "'";
            		
            		tmpCnt++;
            	}
            }
            if(whereStr.equals(""))
            	resultMap = new DataMap();
            else{
            	resultMap = lectureApplyMapper.selectMemberBySimpleDataList(" AND USERNO IN (" + whereStr + ") AND SMS_YN = 'Y' ");
            }
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;
	}
	
	/**
	 * 기관별 조회/승인 (부서별) (기관담당자)
	 */
	public DataMap selectAppInfoBySessDeptList(String grcode, String grseq, String ldapcode, LoginInfo loginInfo) throws BizException{
		DataMap resultMap = new DataMap();
        
        try {
        	String whereDeptStr = "";
            
            if(loginInfo.getSessClass().equals(Constants.ADMIN_SESS_CLASS_DEPT) && !loginInfo.getSessDept().equals(""))
            	whereDeptStr = "  AND a.DEPT = '" + loginInfo.getSessDept() + "'  ";
            
            if( loginInfo.getSessClass().equals(Constants.ADMIN_SESS_CLASS_PART) ) //음.. 부서담당자는 메뉴 없는데...
            	whereDeptStr = "  AND a.PARTCD = '" + loginInfo.getSessPartcd() + "'  ";
            
            if("6289999".equals(loginInfo.getSessDept())) {
            	whereDeptStr += "  AND b.LDAPCODE = '" + ldapcode + "'  ";
            }
            
            Map<String, Object> paramMap = new HashMap<String, Object>();
            paramMap.put("grcode", grcode);
            paramMap.put("grseq", grseq);
            paramMap.put("whereDeptStr", whereDeptStr);
            
            resultMap = lectureApplyMapper.selectAppInfoBySessDeptList2(paramMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;
	}
	
	/**
	 * 기관별 조회/승인 (부서별) (기관담당자) 페이지 처리
	 */
	public DataMap selectAppInfoBySessDeptList(String grcode, String grseq, String ldapcode, LoginInfo loginInfo, DataMap requestMap) throws BizException{
		DataMap resultMap = null;
        
        try {
        	String whereDeptStr = "";
            
            if(loginInfo.getSessClass().equals(Constants.ADMIN_SESS_CLASS_DEPT) && !loginInfo.getSessDept().equals(""))
            	whereDeptStr = "  AND a.DEPT = '" + loginInfo.getSessDept() + "'  ";
            
            if( loginInfo.getSessClass().equals(Constants.ADMIN_SESS_CLASS_PART) ) //음.. 부서담당자는 메뉴 없는데...
            	whereDeptStr = "  AND a.PARTCD = '" + loginInfo.getSessPartcd() + "'  ";
           
            if("6289999".equals(loginInfo.getSessDept())) {
            	whereDeptStr += "  AND b.LDAPCODE = '" + ldapcode + "'  ";
            }

            Map<String, Object> paramMap = new HashMap<String, Object>();
            paramMap.put("grcode", grcode);
            paramMap.put("grseq", grseq);
            paramMap.put("whereDeptStr", whereDeptStr);
            
            int appInfoBySessDeptList3Count = lectureApplyMapper.selectAppInfoBySessDeptList3Count(paramMap);
            
            Map<String, Object> pageInfo = Util.getPageInfo(appInfoBySessDeptList3Count, requestMap);
            
            pageInfo.put("grcode", grcode);
			pageInfo.put("grseq", grseq);
			pageInfo.put("whereDeptStr", whereDeptStr);
			
            resultMap = lectureApplyMapper.selectAppInfoBySessDeptList3(pageInfo);
            PageNavigation pageNavi = Util.getPageNavigation(pageInfo);
			
			resultMap.set("PAGE_INFO", pageNavi);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;
	}

	/**
	 * 간단한 기관 정보 조회
	 */
	public DataMap selectDeptBySimpleRow(String dept) throws BizException{
		DataMap resultMap = new DataMap();
        
        try {
        	resultMap = lectureApplyMapper.selectDeptBySimpleRow(dept);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;
	}
	
	/**
	 * 기관담당자의 1차 승인 처리
	 */
	public int execAppInfoAgreeByDept(String userno, DataMap requestMap, String dept) throws BizException{
		int resultValue = 0;
        
        try {
        	String grcode = requestMap.getString("grcode");
            String grseq = requestMap.getString("grseq");
            
            String person = "";
            
            DataMap appInfoMap = new DataMap();
            for(int i = 1 ; i <= requestMap.getInt("applyCnt") ; i++){
            	person = requestMap.getString("edu"+i);
            	
            	appInfoMap.setString("grcode", grcode);
            	appInfoMap.setString("grseq", grseq);
            	appInfoMap.setString("luserno", userno);
            	appInfoMap.setString("userno", person);
    			
            	if( !requestMap.getString("chk"+i).equals("") ){
                	appInfoMap.setString("deptchk", "Y"); 
                	// 기관담당자의 1차 승인 처리
                	lectureApplyMapper.updateAppInfoDeptChk(appInfoMap);
            	}
            	appInfoMap.clear();
            	
            }
            appInfoMap.setString("grcode", grcode);
        	appInfoMap.setString("grseq", grseq);
        	
        	Map<String, Object> paramMap = new HashMap<String, Object>();
        	paramMap.put("deptchk", "N");
        	paramMap.put("grcode", grcode);
        	paramMap.put("grseq", grseq);
        	paramMap.put("dept", dept);
            // NULL VALUE N
        	lectureApplyMapper.updateAppInfoDeptNChk(paramMap);
            appInfoMap.clear();
            
            resultValue++;
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultValue;
	}

	/**
	 * 기관담당자(외부)의 1차 승인 처리
	 */
	public int execAppInfoAgreeByDeptOuter(String userno, DataMap requestMap, String dept, String sess_ldapcode) throws BizException{
		int resultValue = 0;   
        try {
        	String grcode = requestMap.getString("grcode");
            String grseq = requestMap.getString("grseq");
            
            String person = "";
            
            DataMap appInfoMap = new DataMap();
            for(int i = 1 ; i <= requestMap.getInt("applyCnt") ; i++){
            	person = requestMap.getString("edu"+i);
            	
            	appInfoMap.setString("grcode", grcode);
            	appInfoMap.setString("grseq", grseq);
            	appInfoMap.setString("luserno", userno);
            	appInfoMap.setString("userno", person);
    			
            	if( !requestMap.getString("chk"+i).equals("") ){
                	appInfoMap.setString("deptchk", "Y"); 
                	// 기관담당자의 1차 승인 처리
                	lectureApplyMapper.updateAppInfoDeptChk(appInfoMap);
            	}
            	appInfoMap.clear();
            	
            }
            appInfoMap.setString("grcode", grcode);
        	appInfoMap.setString("grseq", grseq);
        	
        	Map<String, Object> paramMap = new HashMap<String, Object>();
        	paramMap.put("deptchk", "N");
        	paramMap.put("grcode", grcode);
        	paramMap.put("grseq", grseq);
        	paramMap.put("dept", dept);
        	paramMap.put("ldapcode", sess_ldapcode);
            // NULL VALUE N
        	lectureApplyMapper.updateAppInfoDeptNChk(paramMap);
            appInfoMap.clear();
            
            resultValue++;
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultValue;
	}
	
	/**
	 * 기관담당자의 1차 승인 처리
	 */
	public int execAppInfoAgreeByDept2(String userno, DataMap requestMap, String dept) throws BizException{
		int resultValue = 0;
        
        try {
        	String grcode = requestMap.getString("grcode");
            String grseq = requestMap.getString("grseq");
            
            DataMap appInfoMap = new DataMap();
        	
        	appInfoMap.setString("grcode", grcode);
        	appInfoMap.setString("grseq", grseq);
        	appInfoMap.setString("luserno", "A000000000000");
        	appInfoMap.setString("userno", userno);
        	appInfoMap.setString("deptchk", "Y"); 
        	// 기관담당자의 1차 승인 처리
        	System.out.println("jkl;");
        	lectureApplyMapper.updateAppInfoDeptChk(appInfoMap);
        	
         for(int i = 1 ; i <= requestMap.getInt("applyCnt") ; i++){
        	
        	if(requestMap.getString("chk"+i).equals("")){
        		System.out.println("abcd");
        		appInfoMap.setString("deptchk", "N");
        		
        		lectureApplyMapper.updateAppInfoDeptChk(appInfoMap);
        	}
         }	
        	
        	appInfoMap.clear();

            appInfoMap.setString("grcode", grcode);
        	appInfoMap.setString("grseq", grseq);
            // NULL VALUE N
        	Map<String, Object> paramMap = new HashMap<String, Object>();
        	paramMap.put("deptchk", "N");
        	paramMap.put("grcode", grcode);
        	paramMap.put("grseq", grseq);
        	paramMap.put("dept", dept);
        	lectureApplyMapper.updateAppInfoDeptNChk(paramMap);
            appInfoMap.clear();
            
            resultValue++;
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultValue;
	}
	
	/**
	 * Cyber 수강신청 리스트
	 */
	public DataMap selectAppInfoByDeptListForCyber(String grcode, String grseq, String ldapcode, LoginInfo loginInfo) throws BizException{
		DataMap resultMap = new DataMap();
        
        try {
        	String whereDeptStr = "";
            
            if(loginInfo.getSessClass().equals(Constants.ADMIN_SESS_CLASS_DEPT) && !loginInfo.getSessDept().equals(""))
            	whereDeptStr += "  AND A.DEPT = '" + loginInfo.getSessDept() + "'  ";
            
            if( loginInfo.getSessClass().equals(Constants.ADMIN_SESS_CLASS_PART) ) //음.. 부서담당자는 메뉴 없는데...
            	whereDeptStr += "  AND PARTCD = '" + loginInfo.getSessPartcd() + "'  ";
            
            if(!grcode.equals(""))
            	whereDeptStr += "  AND A.GRCODE = '" + grcode + "'  ";
            
		    if("6289999".equals(loginInfo.getSessDept())) {
            	whereDeptStr += "  AND D.LDAPCODE = '" + ldapcode + "'  ";
            }
		    
		    Map<String, Object> paramMap = new HashMap<String, Object>();
            paramMap.put("grseq", grseq);
            paramMap.put("whereDeptStr", whereDeptStr);
            
            resultMap = lectureApplyMapper.selectAppInfoByDeptListForCyber2(paramMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;
	}
	
	/**
	 * 
	 */
	public DataMap selectGrseqFinishMemberForCyber(String grcode, String grseq, LoginInfo loginInfo) throws BizException{
		DataMap resultMap = new DataMap();
        
        try {
        	String whereDeptStr = "";
            
            if(loginInfo.getSessClass().equals(Constants.ADMIN_SESS_CLASS_DEPT) && !loginInfo.getSessDept().equals(""))
            	whereDeptStr += "  AND A.DEPT = '" + loginInfo.getSessDept() + "'  ";
            
            if( loginInfo.getSessClass().equals(Constants.ADMIN_SESS_CLASS_PART) ) //음.. 부서담당자는 메뉴 없는데...
            	whereDeptStr += "  AND A.PARTCD = '" + loginInfo.getSessPartcd() + "'  ";
            
            if( !grcode.equals("") )
            	whereDeptStr += "  AND A.GRCODE = '" + grcode + "'  ";
		    
            Map<String, Object> paramMap = new HashMap<String, Object>();
            paramMap.put("grseq", grseq);
            paramMap.put("whereDeptStr", whereDeptStr);
            
            resultMap = lectureApplyMapper.selectGrseqFinishMemberForCyber(paramMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;
	}
}
