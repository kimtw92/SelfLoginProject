package loti.courseMgr.service;

import gov.mogaha.gpin.sp.util.StringUtil;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import loti.courseMgr.mapper.CompleteProgressMapper;
import loti.courseMgr.mapper.CourseSeqMapper;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import ut.lib.exception.BizException;
import ut.lib.support.DataMap;
import ut.lib.util.Message;
import ut.lib.util.StringReplace;
import ut.lib.util.Util;
import common.service.BaseService;

@Service
public class CompleteProgressService extends BaseService {
	
	@Autowired
	private CompleteProgressMapper completeProgressMapper;
	@Autowired
	private CourseSeqMapper courseSeqMapper;
	
	/**
	 * 강의개설 정보 완료 여부 확인.
	 */
	public int selectSubjSeqCloseChk(Map<String, Object> paramMap) throws BizException{
		int resultValue = 0;
        
        try {
        	resultValue = completeProgressMapper.selectSubjSeqCloseChk(paramMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultValue;
	}
	
	/**
	 * 과정기수 종료 여부 확인.
	 */
	public int selectGrseqCloseChk(Map<String, Object> paramMap) throws BizException{
		int resultValue = 0;
        
        try {
        	resultValue = completeProgressMapper.selectGrseqCloseChk(paramMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultValue;
	}
	
	/**
	 * 강의개설 정보 종료 여부 확인. 종료된 과목수 반환.
	 */
	public int selectSubjSeqCloseChkByAllSubj(Map<String, Object> paramMap) throws BizException{
		int resultValue = 0;
        
        try {
        	resultValue = completeProgressMapper.selectSubjSeqCloseChkByAllSubj(paramMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultValue;
	}
	
	/**
	 * 전체과목 임시 이수처리.
	 */
	@Transactional
	public int execSubjTempCompletion(Map<String, Object> paramMap) throws BizException{
		int resultValue = 0;
        
        try {
        	//강의 개설 정보
            DataMap subjSeqList = completeProgressMapper.selectSubjSeqByAllSubjList(paramMap);
            if(subjSeqList == null) subjSeqList = new DataMap();
            subjSeqList.setNullToInitialize(true);
            
            Map<String, Object> paramMap2 = null;
            Map<String, Object> paramMap3 = null;
            for(int i=0; i < subjSeqList.keySize("grcode") ; i++){
            	
            	System.out.print("\n Index=" + i);
            	String subj = subjSeqList.getString("subj", i);
            	
            	double exavlcount = 0;
            	double paccept = 0; //취득점수
            	double avcourse = 0; //진도율점수
            	double avlcount = 0; //평가총점
            	
            	
            	//과목의 수강생 정보 리스트.
            	paramMap2 = new HashMap<String, Object>();
            	paramMap2.put("grcode", paramMap.get("grcode"));
            	paramMap2.put("grseq", paramMap.get("grseq"));
            	paramMap2.put("subj", subj);
            	
            	DataMap stuLecList = completeProgressMapper.selectStuLecUserListBySubj(paramMap2);
            	if(stuLecList == null) stuLecList = new DataMap(); 
            	stuLecList.setNullToInitialize(true);
            	
            	for(int k=0; k < stuLecList.keySize("userno") ; k++) {
            		//필수이수점수와 필수이수진도율을 초과 하는 사람
            		String grayn = "N";
            		if ( (double)subjSeqList.getInt("pgrad", i) <= Double.parseDouble(stuLecList.getString("paccept", k)) 
            				&& (double)subjSeqList.getInt("grastep", i) <= Double.parseDouble(stuLecList.getString("tstep", k)) ) {
            			grayn = "Y";
            		}
            		
            		//과목별 시험채점결과정보
            		paramMap3 = new HashMap<String, Object>();
                	paramMap3.put("grcode", paramMap.get("grcode"));
                	paramMap3.put("grseq", paramMap.get("grseq"));
                	paramMap3.put("subj", subj);
                	paramMap3.put("userno", stuLecList.getString("userno", k));
                	
            		DataMap examRow = completeProgressMapper.selectExResultRow(paramMap3);
                	if(examRow == null) examRow = new DataMap(); 
                	examRow.setNullToInitialize(true);
                	//System.out.print("\n #3");
                	exavlcount = Double.parseDouble(Util.getValue(examRow.getString("gakpoint"), "0")) + Double.parseDouble(Util.getValue(examRow.getString("jupoint"), "0"));
                	
                	//근태이면
                	if (StringReplace.subString(subj, 0, 3).equals("GUN")) {
                		//취득점수
                		paccept = Double.parseDouble(stuLecList.getString("avcourse", k));
                		//진도율 점수
                		avcourse = Double.parseDouble(stuLecList.getString("avcourse", k));
                		//평가총점
                		avlcount = exavlcount;
                	} else { //근태과목이 아니라면
                		//기수의 기준 진도율보다 학생의 진도율이 큰경우.
                		if( (double)subjSeqList.getInt("grastep", i) <= Double.parseDouble(stuLecList.getString("tstep", k))){
                			//진도율점수
                			avcourse  = Double.parseDouble(subjSeqList.getString("steppoint", i));
                			//취득점수
                			paccept = Double.parseDouble(stuLecList.getString("avreport", k)) + avcourse + exavlcount;
                			//평가총점
                			avlcount = exavlcount;
                		} else { //미달일경우.
                			//취득점수 = 과제물 총점 + 평가점수
                			paccept = Double.parseDouble(stuLecList.getString("avreport", k)) + exavlcount;
                			//진도율점수
                			avcourse = 0;
                			//평가총점
                			avlcount = exavlcount;
                		}
                	}
                	
                	//근태도 아니고 일반 과목도 아닐경우 (과제물이 아니고, 근태도 아닌 특수과목인경우)
                	if(!subj.equals("SUB1000025") 
                			&& !StringReplace.subString(subj, 0, 3).equals("GUN") 
                			&& subjSeqList.getString("subjtype", i).equals("S")){
    					//취득점수
    					paccept = Double.parseDouble(stuLecList.getString("avlcount", k));
    					//진도율점수
    					avcourse = 0;
    					//평가총점
    					avlcount = Double.parseDouble(stuLecList.getString("avlcount", k));
                	}
                	
                	DataMap resultStuLec = new DataMap();
                	resultStuLec.setNullToInitialize(true);
                	
                	resultStuLec.setString("grcode", paramMap.get("grcode").toString());
                	resultStuLec.setString("grseq", paramMap.get("grseq").toString());
                	resultStuLec.setString("subj", subj);
                	resultStuLec.setString("userno", stuLecList.getString("userno", k));
                	
                	resultStuLec.setDouble("tstep", Double.parseDouble(stuLecList.getString("tstep", k)));
                	resultStuLec.setDouble("avlcount", avlcount);
                	resultStuLec.setDouble("avcourse", avcourse);
                	resultStuLec.setDouble("paccept", paccept);
                	resultStuLec.setString("grayn", grayn);
                	
                	//수강 정보 수정.
                	completeProgressMapper.updateStuLecByResultData(resultStuLec);
            	}
            	resultValue++;
            }
            
            if(resultValue == 0){
            	resultValue = -1;
            }
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultValue;
	}
	
	/**
	 * 전체과목 이수처리
	 */
	@Transactional
	public int execSubjCompletion(Map<String, Object> paramMap) throws BizException{
		int resultValue = 0;
        
        try {
        	//수료처리 되지 않은 강의 개설 정보
            DataMap subjSeqList = completeProgressMapper.selectSubjSeqListByNotClosing(paramMap);
            if(subjSeqList == null) subjSeqList = new DataMap();
            subjSeqList.setNullToInitialize(true);
            
            Map<String, Object> paramMap2 = null;
            for(int i=0; i < subjSeqList.keySize("grcode") ; i++){
            	String subj = subjSeqList.getString("subj", i);
            	
            	//과목의 수강생 정보 리스트.
            	paramMap2 = new HashMap<String, Object>();
            	paramMap2.put("grcode", paramMap.get("grcode"));
            	paramMap2.put("grseq", paramMap.get("grseq"));
            	paramMap2.put("subj", subj);
            	
            	DataMap stuLecList = completeProgressMapper.selectStuLecListByResultInfo(paramMap2);
            	if(stuLecList == null) stuLecList = new DataMap(); 
            	stuLecList.setNullToInitialize(true);
            	
            	for(int k=0; k < stuLecList.keySize("userno") ; k++){
            		String userno = stuLecList.getString("userno", k);
            		
					double avcourse = Double.parseDouble(stuLecList.getString("avcourse", k));
					double avreport = Double.parseDouble(stuLecList.getString("avreport", k));
					double avlcount = Double.parseDouble(stuLecList.getString("avlcount", k));
					double tstep = Double.parseDouble(stuLecList.getString("tstep", k));
					double paccept = Double.parseDouble(stuLecList.getString("paccept", k));
					
					DataMap stuLecMap = new DataMap();
					stuLecMap.setNullToInitialize(true);
					
					stuLecMap.setString("grcode", paramMap.get("grcode").toString());
					stuLecMap.setString("grseq", paramMap.get("grseq").toString());
					stuLecMap.setString("subj", subj);
					stuLecMap.setString("userno", userno);
					stuLecMap.setString("luserno", paramMap.get("luserno").toString());
					stuLecMap.setString("started", subjSeqList.getString("started", i));
					stuLecMap.setString("enddate", subjSeqList.getString("enddate", i));
					stuLecMap.setDouble("avcourse", avcourse);
					stuLecMap.setDouble("avreport", avreport);
					stuLecMap.setDouble("avlcount", avlcount);
					stuLecMap.setDouble("tstep", tstep);
					stuLecMap.setDouble("paccept", paccept);
					
					if (completeProgressMapper.selectSubjResultStuChk(stuLecMap) > 0) { //과목 결과정보가 있다면 update
						//과목 결과 정보 수정.
						completeProgressMapper.updateSubjResult(stuLecMap);
					} else { //과목 결과정보가 없다면 insert
						stuLecMap.setString("grayn", "Y");
						
						//유저 정보(주민등록번호)
						DataMap userMap = courseSeqMapper.selectMemberSimpleRowAndUserid(userno);
		            	if(userMap == null) userMap = new DataMap(); 
		            	userMap.setNullToInitialize(true);
		            	
						stuLecMap.setString("rresno", userMap.getString("resno"));
						//과목 결과 정보 등록
						completeProgressMapper.insertSubjResult(stuLecMap);
					}
            		
            	} //end for stuLecList
            	
            	resultValue++;
            	
            	paramMap2.put("closing", "Y");
            	//강의 개설 정보 과목 이수 처리
            	completeProgressMapper.updateSubjSeqByClosing(paramMap2);
            } // end for subjSeqList
            
            if(resultValue == 0){
            	resultValue = -1;
            }
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultValue;
	}
	
	/**
	 * 취소처리할 이수결과가 없습니다
	 */
	@Transactional
	public int execSubjCompletionCancel(Map<String, Object> paramMap) throws BizException{
		int resultValue = 0;
        
        try {
        	//과정기수의 과목 결과 정보 삭제
            completeProgressMapper.deleteSubjResultByGrseq(paramMap);
 
            //수강생의 이수여부 수정
            paramMap.put("grayn", "N");
            completeProgressMapper.updateStuLecByGrayn(paramMap);
            
            //강의개설정보의 기수 종료 여부 수정
            paramMap.put("closing", "N");
            paramMap.put("preed", "Y");
            completeProgressMapper.updateSubjSeqByGrseqClosing(paramMap);
            
            resultValue++;
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultValue;
	}
	
	/**
	 * 사이버 과목의 완료 여부 확인.
	 */
	public int selectSubjSeqBySubjTypeCloseChk(Map<String, Object> paramMap) throws BizException{
		int resultValue = 0;
        
        try {
        	resultValue = completeProgressMapper.selectSubjSeqBySubjTypeCloseChk(paramMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultValue;
	}
	
	/**
	 * 기수의 완결처리 여부
	 */
	public int selectGrseqCloseYesChk(Map<String, Object> paramMap) throws BizException{
		int resultValue = 0;
        
        try {
        	resultValue = completeProgressMapper.selectGrseqCloseYesChk(paramMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultValue;
	}
	
	/**
	 * 임시수료처리
	 */
	@Transactional
	public int execGrseqTempCompletion(Map<String, Object> paramMap) throws BizException{
		int resultValue = 0;
        
        try {
        	//과정기수의 과목 결과 정보 삭제
            DataMap grseqMap = completeProgressMapper.selectGrseqByResultSimpleRow(paramMap);
            if(grseqMap == null) grseqMap = new DataMap();
            grseqMap.setNullToInitialize(true);
            
            int v_rpgrad = grseqMap.getInt("rpgrad"); //수료기준 점수.
            paramMap.put("grchk", "Y");
            int grseqAppInfoTotCnt = completeProgressMapper.selectAppInfoByGrchkCnt(paramMap); //과정 수강자수
            
            //과정결과정보 삭제
            completeProgressMapper.deleteGrResult(paramMap);
            
            //과목의 결과 정보가 있는 수강자 정보.
            DataMap userList = completeProgressMapper.selectSubjResultByDistinctUserList(paramMap);
            if(userList == null) userList = new DataMap();
            userList.setNullToInitialize(true);
            
            Map<String, Object> paramMap2 = null;
            for(int i=0; i < userList.keySize("userno"); i++){
            	String userno = userList.getString("userno", i);
            	
            	//회원정보
            	DataMap userRow = courseSeqMapper.selectMemberSimpleRowAndUserid(userno);
                if(userRow == null) userRow = new DataMap();
                userRow.setNullToInitialize(true);
                
                //회원번호 
                paramMap2 = new HashMap<String, Object>();
                paramMap2.put("grcode", paramMap.get("grcode").toString());
                paramMap2.put("grseq", paramMap.get("grseq").toString());
                paramMap2.put("userno", userno);
                DataMap edunoRow = courseSeqMapper.selectEdunoRow(paramMap2);
                if(edunoRow == null) edunoRow = new DataMap();
                edunoRow.setNullToInitialize(true);
                
                //취득점수합
                double v_total = Double.parseDouble(completeProgressMapper.selectStuLecGrseqTotalPaccept(paramMap2));
                
                //학생장,부학생장 가점
                double grstumasdata = Double.parseDouble(StringUtil.nvl(completeProgressMapper.selectGrStuMasAddpoint(paramMap2),"0"));
                
                String v_rgrayn = "N"; //과정 이수 여부
                
                v_total += grstumasdata;
                
                if("Y".equals(grseqMap.getString("fcyber"))) {
                    if(v_total > 100)
                    	v_total = 100;                
                }               
                
            	if (v_total >= v_rpgrad) 
            		v_rgrayn = "Y";
            	
            	//온/오프라인 과목수
                DataMap subjCnt = completeProgressMapper.selectSubjSeqSubjCntBySubjType(paramMap2);
                if(subjCnt == null) subjCnt = new DataMap();
                subjCnt.setNullToInitialize(true);
                
                //사이버과목만으로 과정이 구성된 경우 한과목이라도 미 이수일 경우 미수료
                if(subjCnt.getInt("vOffcount") == 0)
                	paramMap2.put("grayn", "N");
                	if(completeProgressMapper.selectStuLecGraynCnt(paramMap2) > 0) //수강생의 이수여부 갯수
                		v_rgrayn = "N";
                
                if(v_rpgrad == 0)
                	v_rgrayn = "X";
                
                DataMap resultMap = new DataMap();
                resultMap.setNullToInitialize(true);
                
                resultMap.setString("grcode", paramMap.get("grcode").toString());
                resultMap.setString("grseq", paramMap.get("grseq").toString());
                resultMap.setString("userno", userno);
                
                resultMap.setString("rdept", userRow.getString("dept"));
                resultMap.setString("rdeptsub", userRow.getString("deptsub"));
                resultMap.setString("rjik", userRow.getString("jik"));
                
                resultMap.setString("rname", userRow.getString("name"));
                resultMap.setString("rschool", userRow.getString("vSchool"));
                resultMap.setDouble("paccept", v_total);
                
                resultMap.setString("rgrayn", v_rgrayn);
                resultMap.setInt("totno", grseqAppInfoTotCnt);
                resultMap.setString("started", grseqMap.getString("started"));
                
                resultMap.setString("enddate", grseqMap.getString("enddate"));
                resultMap.setString("luserno", paramMap.get("luserno").toString());
                
                resultMap.setString("rresno", userRow.getString("resno"));
    			resultMap.setString("eduno", edunoRow.getString("eduno"));
                //과정결과 정보에 추가
                completeProgressMapper.insertGrResult(resultMap);
            }
            
            //과정 기수 수강생 학습 결과 계산한 유저 리스트
            DataMap grResultUserList = completeProgressMapper.selectGrResultUserListByCalc(paramMap);
            if(grResultUserList == null) grResultUserList = new DataMap();
            grResultUserList.setNullToInitialize(true);
            
            for(int i=0; i < grResultUserList.keySize("userno"); i++){
            	paramMap2 = new HashMap<String, Object>();
                paramMap2.put("grcode", paramMap.get("grcode").toString());
                paramMap2.put("grseq", paramMap.get("grseq").toString());
                paramMap2.put("userno", grResultUserList.getString("userno", i));
                
            	int v_seqno = completeProgressMapper.selectGrResultMaxSeqno(paramMap2); //석차
            	int eduNo =  completeProgressMapper.selectAppInfoEduno(paramMap2);//교번
            	
            	//과정 결과정보 등록 수료증번호,석차,교번
            	DataMap resultMap = new DataMap();
            	resultMap.setNullToInitialize(true);
            	resultMap.setString("rno", grResultUserList.getString("rno", i));
            	resultMap.setInt("eduno", eduNo);
            	resultMap.setInt("seqno", v_seqno);
            	resultMap.setString("grcode", paramMap.get("grcode").toString());
            	resultMap.setString("grseq", paramMap.get("grseq").toString());
            	resultMap.setString("userno", grResultUserList.getString("userno", i));
            	completeProgressMapper.updateGrResultByTempCompletion(resultMap);
            }
            
            //수료번호 생성 (연간 수료자 연번으로 생성)
            DataMap resultList = completeProgressMapper.selectGrResultListByEduno(paramMap);
            if(resultList == null) resultList = new DataMap();
            resultList.setNullToInitialize(true);
            
            for(int i=0; i < resultList.keySize("userno"); i++){
            	int v_temprno = 0;
            	if(resultList.getString("rgrayn", i).equals("Y")) {
            		v_temprno = completeProgressMapper.selectGrResultMaxRno(paramMap.get("grseq").toString());
            	}
            	
            	paramMap2 = new HashMap<String, Object>();
                paramMap2.put("grcode", paramMap.get("grcode").toString());
                paramMap2.put("grseq", paramMap.get("grseq").toString());
                paramMap2.put("userno", resultList.getString("userno", i));
                paramMap2.put("rno", String.valueOf(v_temprno));
            	completeProgressMapper.updateGrResultRno(paramMap2);
            }

            if(paramMap.get("closing").toString().equals("Y")){ //수료처리
            	completeProgressMapper.updateGrseqClosing(paramMap);
            }else{ //임시수료처리
            	//수료자 임시 수료 처리.
            	completeProgressMapper.updateGrseqClosing(paramMap);
            	completeProgressMapper.updateGrResultTempCompletion(paramMap);
            }
            
            resultValue++;
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultValue;
	}
	
	/**
	 * 과정 기수 수료 정보.
	 */
	public DataMap selectGrseqByResultSimpleRow(Map<String, Object> paramMap) throws BizException{
		DataMap resultMap = null;
        
        try {
        	resultMap = completeProgressMapper.selectGrseqByResultSimpleRow(paramMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;
	}
	
	/**
	 * 수료처리 완료 취소.
	 */
	@Transactional
	public int execGrseqCompletionCancel(Map<String, Object> paramMap) throws BizException{
		int resultValue = 0;
        
        try {
        	//과정기수의 결과정보 삭제
            completeProgressMapper.deleteGrResult(paramMap);
    			
            //과정결과 정보에 추가
            paramMap.put("closing", "N");
            completeProgressMapper.updateGrseqClosing(paramMap);
                
            resultValue++;
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultValue;
	}
}
