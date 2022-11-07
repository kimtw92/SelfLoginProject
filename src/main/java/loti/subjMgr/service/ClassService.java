package loti.subjMgr.service;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;
import java.util.StringTokenizer;

import loti.subjMgr.mapper.ClassMapper;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import ut.lib.exception.BizException;
import ut.lib.support.DataMap;
import ut.lib.util.Message;
import common.service.BaseService;

@Service
public class ClassService extends BaseService {

	@Autowired
	private ClassMapper classMapper;
	
	/*********************/
	/***  반 구성 관련 *****/
	/*********************/
	
	
	/**
	 * 입교자 반지정 여부
	 * @param requestMap
	 * @return
	 * @throws Exception
	 */
	public DataMap selectCountBySubjresult(DataMap requestMap) throws Exception{
		
        DataMap resultMap = null;
        
        try {
        	
            resultMap = classMapper.selectCountBySubjresult(requestMap);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
	
	/**
	 * 기관별 입교자 리스트
	 * @param requestMap
	 * @return
	 * @throws Exception
	 */
	public DataMap selectDeptClassList(DataMap requestMap) throws Exception{
		
        DataMap resultMap = null;
        
        try {
        	
            resultMap = classMapper.selectDeptClassList(requestMap);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
	
	/**
	 * 반 리스트
	 * @param requestMap
	 * @return
	 * @throws Exception
	 */
	public DataMap selectClassList(DataMap requestMap) throws Exception{
		
        DataMap resultMap = null;
        
        try {
        	
            resultMap = classMapper.selectClassList(requestMap);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
	
	/**
	 * 반지정 현황보기
	 * @param requestMap
	 * @return
	 * @throws Exception
	 */
	public DataMap selectClassViewList(DataMap requestMap) throws Exception{
		
        DataMap resultMap = null;
        
        try {
        	
            resultMap = classMapper.selectClassViewList(requestMap);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}

	/**
	 * 수강인원
	 * @param requestMap
	 * @return
	 * @throws Exception
	 */
	public DataMap selectCountByStuLec(DataMap requestMap) throws Exception{
		
        DataMap resultMap = null;
        
        try {
        	
            resultMap = classMapper.selectCountByStuLec(requestMap);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
	
	/**
	 * 분반구성 리스트
	 * @param requestMap
	 * @param strClassNo1
	 * @param strClassNo2
	 * @return
	 * @throws Exception
	 */
	public DataMap selectStuLecList(DataMap requestMap, String strClassNo1, String strClassNo2) throws Exception{
		
        DataMap resultMap = null;
        
        try {
        	
        	requestMap.setString("strClassNo1", strClassNo1);
        	requestMap.setString("strClassNo2", strClassNo2);
        	
            resultMap = classMapper.selectStuLecList(requestMap);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}

	/**
	 * 반 구성 등록
	 * @param requestMap
	 * @param sessNo
	 * @return
	 * @throws Exception
	 */
	@Transactional
	public int insertBySubjClass(DataMap requestMap, String sessNo) throws Exception{
		
        int returnValue = 0;
        
        String grCode = requestMap.getString("commGrcode");
        String grSeq = requestMap.getString("commGrseq");
        String subj = requestMap.getString("commSubj");
        int classCnt = requestMap.getInt("classCnt");
        String nameByClassNm = "";
        String classNm = "";
        
        try {
        	
            // 반 구성 삭제 grCode, grSeq, subj
            returnValue = classMapper.deleteBySubjClass(requestMap);
            
            DataMap params = (DataMap) requestMap.clone();
            
            // 반 구성 등록
            for(int i=0; i < classCnt; i++){
            	nameByClassNm = "classnm" + i;
            	classNm = requestMap.getString(nameByClassNm);
            	String classNo = String.valueOf(i+1);        
            	
            	params.setString("classNm", classNm);
            	params.setString("classNo", classNo);
            	params.setString("sessNo", sessNo);
//            	grCode, grSeq, subj, classNo, classNm, sessNo
            	returnValue = classMapper.insertBySubjClass(params);
            }
            
            // 과목수강정보 업데이트 grCode, grSeq, subj
            returnValue = classMapper.updateByStulec(requestMap);
            
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return returnValue;        
	}

	/**
	 * 반 갯수 지정 카운트
	 * @param requestMap
	 * @return
	 * @throws Exception
	 */
	public DataMap selectCountBySubjClass(DataMap requestMap) throws Exception{
		
        DataMap resultMap = null;
        
        try {
        	
            resultMap = classMapper.selectCountBySubjClass(requestMap);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
	
	/**
	 * 단일 분반 저장
	 * @param requestMap
	 * @return
	 * @throws Exception
	 */
	@Transactional
	public int insertSubjClassBySingle(DataMap requestMap) throws Exception{
		
        int returnValue = 0;
        
        String grCode = requestMap.getString("commGrcode");
        String grSeq = requestMap.getString("commGrseq");
        String subj = requestMap.getString("commSubj");
        
        try {
        	
            // 단일 분반용, 반 구성 삭제 단, class > 1 인것만
            returnValue = classMapper.deleteBySubjClassToOne(requestMap);
            
            // 과목수강정보 업데이트
            returnValue = classMapper.updateByStulec(requestMap);
            
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return returnValue;        
	}

	/**
	 * 분반 갯수 리스트
	 * @param requestMap
	 * @return
	 * @throws Exception
	 */
	public DataMap selectSubjClass(String grCode, String grSeq, String subj) throws Exception{
		
        DataMap resultMap = null;
        
        try {
        	
        	Map<String, Object> params = new HashMap<String, Object>();
        	
        	params.put("commGrcode", grCode);
        	params.put("commGrseq", grSeq);
        	params.put("commSubj", subj);
//        	grCode, grSeq, subj
            resultMap = classMapper.selectSubjClass(params);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
	
	/**
	 * 기관별 분반 업데이트 type 1
	 * @param requestMap
	 * @return
	 * @throws Exception
	 */
	public int updateSubjClassByDept1(DataMap requestMap) throws Exception{
		
        int returnValue = 0;
        
        String grCode = requestMap.getString("commGrcode");
        String grSeq = requestMap.getString("commGrseq");
        String subj = requestMap.getString("commSubj");        
        int rowCount = requestMap.getInt("rowCount");
        
        String classNo = "";
        String dept = "";
        String tmpClass = "";
        String tmpDept = "";
        
        try {
        	
        	DataMap params = (DataMap) requestMap.clone();
        	
            // 총 기관갯수 만큼 업데이트 한다.
            for(int i=0; i < rowCount; i++){
            	
            	tmpClass = "selSubjClass" + i;
            	tmpDept = "txtDept" + i;
            	
            	classNo = requestMap.getString(tmpClass);
            	dept = requestMap.getString(tmpDept);    
            	
            	params.setString("classNo", classNo);
            	params.setString("dept", dept);
//            	classNo, grCode, grSeq, subj, dept
            	returnValue = classMapper.updateSubjClassByDept(params);
            	
            }
            
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return returnValue;        
	}
	
	/**
	 * 기관별 분반 Type2 리스트
	 * @param requestMap
	 * @return
	 * @throws Exception
	 */
	public DataMap selectSubjClassByDeptType2(DataMap requestMap) throws Exception{
		
        DataMap resultMap = null;
        
        try {
        	
            resultMap = classMapper.selectSubjClassByDeptType2(requestMap);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
	
	/**
	 * 기관별 분반 업데이트 type 2
	 * @param requestMap
	 * @return
	 * @throws Exception
	 */
	@Transactional
	public int updateSubjClassByDept2(DataMap requestMap) throws Exception{
		
        int returnValue = 0;
        
        String grCode = requestMap.getString("commGrcode");
        String grSeq = requestMap.getString("commGrseq");
        String subj = requestMap.getString("commSubj");                
        String classNo = requestMap.getString("selSubjClass");
        String dept = "";
        int rowCount = 0;
        
        try {
        	
            // dept 가  aaa|aaa|aaa 이렇게 들어있음.
            StringTokenizer st = new StringTokenizer(requestMap.getString("chkData") , "|");            
            rowCount = st.countTokens();
            
            DataMap params = (DataMap) requestMap.clone();
            
            params.setString("classNo", classNo);
            for(int i=0; i < rowCount; i++){
            	dept = st.nextToken();
            	params.setString("dept", dept);
//            	classNo, grCode, grSeq, subj, dept
            	returnValue = classMapper.updateSubjClassByDept(params);
            }
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return returnValue;        
	}

	/**
	 * 자유분반 설정 리스트
	 * @param requestMap
	 * @return
	 * @throws Exception
	 */
	public DataMap selectFreeList(DataMap requestMap) throws Exception{
		
        DataMap resultMap = null;
        
        try {
        	
            resultMap = classMapper.selectFreeList(requestMap);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}

	/**
	 * 자유 분반  업데이트
	 * @param requestMap
	 * @return
	 * @throws Exception
	 */
	public int updateSubjClassByFree(DataMap requestMap) throws Exception{
		
        int returnValue = 0;
        
        String grCode = requestMap.getString("commGrcode");
        String grSeq = requestMap.getString("commGrseq");
        String subj = requestMap.getString("commSubj");                
        String classNo = requestMap.getString("selSubjClass");
        String userno = "";
        int rowCount = 0;
        
        try {
        	
            // dept 가  aaa|aaa|aaa 이렇게 들어있음.
            StringTokenizer st = new StringTokenizer(requestMap.getString("chkData") , "|");            
            rowCount = st.countTokens();
            
            DataMap params = (DataMap) requestMap.clone();
            
            params.setString("classNo", classNo);
            for(int i=0; i < rowCount; i++){
            	userno = st.nextToken();
            	params.setString("userno", userno);
            	returnValue = classMapper.updateSubjClassByFreeOption(params);
            }
            
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return returnValue;        
	}

	/**
	 * 조건별 분반  설정 리스트
	 * @param requestMap
	 * @return
	 * @throws Exception
	 */
	public DataMap selectOptionList(DataMap requestMap) throws Exception{
		
        DataMap resultMap = null;
        
        try {
//        	requestMap, requestMap.getString("orderby") 
            resultMap = classMapper.selectOptionList(requestMap);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
	
	/**
	 * 조건별 분반 업데이트
	 * @param requestMap
	 * @return
	 * @throws Exception
	 */
	@Transactional
	public int updateSubjClassByOption(DataMap requestMap) throws Exception{
		
        int returnValue = 0;
        
        String grCode = requestMap.getString("commGrcode");
        String grSeq = requestMap.getString("commGrseq");
        String subj = requestMap.getString("commSubj");
        String classNo = "";
        String userno = "";
        String tmpClassObjId = "";
        String tmpUserObjId = "";
        
        int rowCount = requestMap.getInt("rowCount");	// 총 리스트 갯수
        
        try {
        	
        	DataMap params = (DataMap) requestMap.clone();
        	
            for(int i=0; i < rowCount; i++){
            	            	
            	tmpClassObjId = "tClassno" + i;
            	tmpUserObjId = "tUserno" + i;
            	
            	classNo = requestMap.getString(tmpClassObjId);
            	userno = requestMap.getString(tmpUserObjId);
            	
            	params.setString("classNo", classNo);
            	params.setString("userno", userno);
//            	classNo, grCode, grSeq, subj, userno
            	returnValue = classMapper.updateSubjClassByFreeOption(params);
            }
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return returnValue;        
	}
	
	/**
	 * 타과목 동일반 구성하기 리스트
	 * @param requestMap
	 * @return
	 * @throws Exception
	 */
	public DataMap selectOtherClassList(DataMap requestMap) throws Exception{
		
        DataMap resultMap = null;
        
        try {
        	
            resultMap = classMapper.selectOtherClassList( requestMap );
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
	
	/**
	 * 타 과목 동일반 구성하기 업데이트
	 * @param requestMap
	 * @return
	 * @throws Exception
	 */
	@Transactional
	public int updateSubjClassByOther(DataMap requestMap) throws Exception{
		
        int returnValue = 0;
        
        String grCode = requestMap.getString("commGrcode");
        String grSeq = requestMap.getString("commGrseq");
        String subj = requestMap.getString("commSubj");
        
        String classNo = "";
        String rowBySubj = "";
        String pSubj = "";
        int rowCount = 0;
        String userNo = "";
        
        DataMap listMap = null;
        
        try {
        	
            // dept 가  aaa|aaa|aaa 이렇게 들어있음.
            StringTokenizer st = new StringTokenizer(requestMap.getString("chkData") , "|");
            StringTokenizer st2 = new StringTokenizer(requestMap.getString("chkData") , "|");
            
            rowCount = st.countTokens();
            
            for(int i=0; i < rowCount; i++){
            	if(i==0){
            		rowBySubj = "'" + st.nextToken() + "'";
            	}else{
            		rowBySubj += ",'" + st.nextToken() + "'";
            	}            	            
            }
            
            DataMap params = (DataMap) requestMap.clone();
            
            params.setString("rowBySubj", rowBySubj);
            
            // 타 과목 동일반 구성하기용 Step 1
            // 선택한 과목정보를 초기화 한다
//            grCode, grSeq, rowBySubj
            returnValue = classMapper.otherClassStep1ByDelete(params);
            
                                                                       
            // 타 과목 동일반 구성하기용 Step 2
            rowCount = st2.countTokens();
            for(int j=0; j < rowCount; j++){            	
            	pSubj = st2.nextToken();
            	params.setString("pSubj", pSubj);
//            	pSubj, grCode, grSeq, subj
            	returnValue = classMapper.otherClassStep2ByInsert(params);            	
            }
            
            
            // 타 과목 동일반 구성하기용 Step 3
            listMap = classMapper.selectStuLec(requestMap);
            for(int k=0; k < listMap.keySize("userno"); k++){
            	
            	userNo = listMap.getString("userno",k);
            	classNo = listMap.getString("classno",k);
            	
            	params.setString("userNo", userNo);
            	params.setString("classNo", classNo);
//            	classNo, userNo, grCode, grSeq, rowBySubj
            	returnValue = classMapper.otherClassStep3ByUpdate(params);
            }                        
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return returnValue;        
	}

	
	
	
	/***************************/
	/***  입교자 반편성  관련 *****/
	/***************************/
	
	
	/**
	 * 입교자 반편성용 리스트
	 * @param requestMap
	 * @param sqlWhere
	 * @return
	 * @throws Exception
	 */
	public DataMap selectStuClassList(DataMap requestMap, String sqlWhere) throws Exception{
		
        DataMap resultMap = null;
        
        try {
        	
            resultMap = classMapper.selectStuClassList(sqlWhere);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
	
	/**
	 * 입교자 지정 리스트 상단 과목 셀렉트박스	 
	 * @param subj
	 * @return
	 * @throws Exception
	 */
	public DataMap selectStuClassTopSubj(String subj) throws Exception{
		
        DataMap resultMap = null;
        
        try {
        	
            resultMap = classMapper.selectStuClassTopSubj(subj);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
	
	/**
	 * 해당 과정기수의 이수처리가 완결되었는지 체크
	 * @param grCode
	 * @param grSeq
	 * @param s_refSubj
	 * @return
	 * @throws Exception
	 */
	public DataMap selectCheckGrayn(String grCode, String grSeq, String s_refSubj) throws Exception{
		
        DataMap resultMap = null;
        
        try {
        	
        	DataMap params = new DataMap();
        	
        	params.setString("grCode", grCode);
        	params.setString("grSeq", grSeq);
        	params.setString("s_refSubj", s_refSubj);
        	
            resultMap = classMapper.selectCheckGrayn(params);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
	
	/**
	 * 입교자 반편성 선택과목에 해당하는 리스트
	 * @param grCode
	 * @param grSeq
	 * @param subj
	 * @param refSubj
	 * @return
	 * @throws Exception
	 */
	public DataMap selectStuClassListByDetail(String grCode, String grSeq, String subj, String refSubj) throws Exception{
		
        DataMap resultMap = null;
        
        try {
        	
        	DataMap params = new DataMap();
        	
        	params.setString("grCode", grCode);
        	params.setString("grSeq", grSeq);
        	params.setString("subj", subj);
        	params.setString("refSubj", refSubj);
        	
            resultMap = classMapper.selectStuClassListByDetail(params);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
	
	/**
	 * 입교자 반편성 선택과목 과목수강정보에 업데이트
	 * @param requestMap
	 * @return
	 * @throws Exception
	 */
	@Transactional
	public int updateStuClassListByDetail(DataMap requestMap) throws Exception{
		
        int returnValue = 0;
        
        String grCode = requestMap.getString("grCode");
        String grSeq = requestMap.getString("grSeq");
        String saveSubj = "";
        String subj = "";
        String userNo = "";
            
        int rowCount = 0;        
        
        
        try {
        	
            // data 가  aaa|aaa|aaa 이렇게 들어있음.
            StringTokenizer stUser = new StringTokenizer(requestMap.getString("chkDataUserNo") , "|");
            StringTokenizer stSaveSubj = new StringTokenizer(requestMap.getString("chkDataSubj") , "|");            
            StringTokenizer stSubj = new StringTokenizer(requestMap.getString("chkDataWhereSubj") , "|");
            
            rowCount = stUser.countTokens();
            
            DataMap params = (DataMap)requestMap.clone();
            
            for(int i=0; i < rowCount; i++){
            	saveSubj = stSaveSubj.nextToken();
            	subj = stSubj.nextToken();
            	userNo = stUser.nextToken();
            	
            	params.setString("saveSubj", saveSubj);
            	params.setString("subj", subj);
            	params.setString("userNo", userNo);
//            	saveSubj, grCode, grSeq, subj, userNo
            	classMapper.updateStuClassListByDetail(params);
            	
            }
                        
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return returnValue;        
	}
}
