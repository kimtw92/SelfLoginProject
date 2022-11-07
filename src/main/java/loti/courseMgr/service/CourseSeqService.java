package loti.courseMgr.service;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import loti.baseCodeMgr.mapper.QuestionMgrMapper;
import loti.common.mapper.CommonMapper;
import loti.courseMgr.mapper.CompleteProgressMapper;
import loti.courseMgr.mapper.CourseSeqMapper;
import loti.evalMgr.mapper.EvalItemMapper;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;

import ut.lib.exception.BizException;
import ut.lib.page.PageNavigation;
import ut.lib.support.DataMap;
import ut.lib.util.Message;
import ut.lib.util.Util;
import common.service.BaseService;

@Service
public class CourseSeqService extends BaseService {

	@Autowired
	private CourseSeqMapper courseSeqMapper;
	@Autowired
	private CommonMapper commonMapper;
	@Autowired
	private CompleteProgressMapper completeProgressMapper;
	@Autowired
	private EvalItemMapper evalItemMapper;
	@Autowired
	private QuestionMgrMapper questionMgrMapper;
	
	/**
	 * 과정기수의 DISTINCT조건으로 년도 검색(진행,전체별 과정장ID별)
	 */
	public DataMap selectGrSeqDistictYearList(Map<String, Object> paramMap) throws BizException{
		DataMap resultMap = null;
        
        try {
        	resultMap = courseSeqMapper.selectGrSeqDistictYearList(paramMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;        
	}
	
	/**
	 * 과정기수관리 리스트 (SESS_GUBUN별)
	 */
	public DataMap selectGrSeqList(String year, String grcode, String sessGubun) throws BizException{
		DataMap grSeqMap = null;
        
        try {
        	Map<String, Object> paramMap = new HashMap<String, Object>();
            paramMap.put("year", year);
            paramMap.put("grcode", grcode);
            paramMap.put("sessGubun", sessGubun);
            //과정 기수 목록.
            grSeqMap = courseSeqMapper.selectGrSeqList(paramMap);
            if (grSeqMap == null) {
            	grSeqMap = new DataMap();
            }
            grSeqMap.setNullToInitialize(true);
            
            //과목 기수의 과목 목록
            Map<String, Object> paramMap2 = null;
            for(int i=0; i < grSeqMap.keySize("grcode"); i++) {
            	String forGrcode = grSeqMap.getString("grcode", i);
            	String forGrSeq = grSeqMap.getString("grseq", i);
            	
            	//과정 기수의 포함될 과목정보.
            	DataMap addSubjMap = new DataMap("SUBJ");
            	
        		addSubjMap.addString("grcode", forGrcode);
        		addSubjMap.addString("grseq", forGrSeq);
        		addSubjMap.addString("grcodenm", grSeqMap.getString("grcodenm", i));
        		addSubjMap.addString("subjCount", grSeqMap.getString("subjCount", i));
        		addSubjMap.addString("cafeYn", grSeqMap.getString("cafeYn", i));
        		
            	//과정기수의 과목 리스트.
        		paramMap2 = new HashMap<String, Object>();
        		paramMap2.put("grcode", grcode);
        		paramMap2.put("forGrSeq", forGrSeq);
            	DataMap subjMap = courseSeqMapper.selectSubjLecTypeList1(paramMap2);
            	subjMap.setNullToInitialize(true);
            	
            	if (subjMap.keySize("subj") > 0) {
            		for(int j=0; j < subjMap.keySize("subj"); j++) {
            			//기본 과목 정보
        				addSubjMap.addString("refSubjnm", subjMap.getString("subjnm", j));
        				addSubjMap.addString("refSubj", subjMap.getString("subj", j));
        				addSubjMap.addString("lecType", subjMap.getString("lecType", j));
        				addSubjMap.addString("subj", subjMap.getString("subj", j));
        				
        				//상세 과목 정보
            			DataMap addSubjRefMap = new DataMap("SUBJ_REF");
            			
            			if (subjMap.getString("lecType", j).equals("P")) {
            				//선택과목의 서브과목 목록
            				Map<String, Object> paramMap3 = new HashMap<String, Object>();
            				paramMap3.put("grcode", grcode);
            				paramMap3.put("forGrSeq", forGrSeq);
            				paramMap3.put("subj", subjMap.getString("subj", j));
            				paramMap3.put("lecType", subjMap.getString("lecType", j));
            				DataMap refSubjMap = courseSeqMapper.selectSubjLecTypeList1(paramMap3);
            				if (refSubjMap == null) {
            					refSubjMap = new DataMap();
            				}
            				refSubjMap.setNullToInitialize(true);
            				
            				//addSubjMap.addString("REF_SIZE", 	"1");
            				addSubjMap.addString("refSize", refSubjMap.keySize("subj")+"");
            				
            				if (refSubjMap.keySize("subj") <= 0) {
            					addSubjRefMap.addString("grcode", forGrcode);
            					addSubjRefMap.addString("grseq", forGrSeq);
            					addSubjRefMap.addString("subj", subjMap.getString("subj", j));
                				addSubjRefMap.addString("count1", subjMap.getString("count1", j));
                				addSubjRefMap.addString("count2", subjMap.getString("count2", j));
                				addSubjRefMap.addString("count3", subjMap.getString("count3", j));
                				addSubjRefMap.addString("started", subjMap.getString("started", j));
                				addSubjRefMap.addString("enddate", subjMap.getString("enddate", j));
                				addSubjRefMap.addString("gakpoint", refSubjMap.getString("gakpoint", j));
                				addSubjRefMap.addString("jupoint", refSubjMap.getString("jupoint", j));
                				addSubjRefMap.addString("gakweight", refSubjMap.getString("gakweight", j));
                				addSubjRefMap.addString("juweight", refSubjMap.getString("juweight", j));
            				}
            				
            				for(int k = 0; k < refSubjMap.keySize("subj"); k++) {
                				addSubjRefMap.addString("subj", refSubjMap.getString("subj", k));
                				addSubjRefMap.addString("subjnm", refSubjMap.getString("subjnm", k));
                				addSubjRefMap.addString("ptype", subjMap.getString("ptype", j));
                				addSubjRefMap.addString("evlYn", subjMap.getString("evlYn", j));
                				addSubjRefMap.addString("subjtype", subjMap.getString("subjtype", j));
                				addSubjRefMap.addString("started", refSubjMap.getString("started", k));
                				addSubjRefMap.addString("enddate", refSubjMap.getString("enddate", k));
                				addSubjRefMap.addString("lecType", refSubjMap.getString("lecType", k));
                				addSubjRefMap.addString("preed", subjMap.getString("preed", j));
                				addSubjRefMap.addString("closing", refSubjMap.getString("closing", k));
                				addSubjRefMap.addString("count1", refSubjMap.getString("count1", k));
                				addSubjRefMap.addString("count2", refSubjMap.getString("count2", k));
                				addSubjRefMap.addString("count3", refSubjMap.getString("count3", k));
                				addSubjRefMap.addString("gakpoint", refSubjMap.getString("gakpoint", k));
                				addSubjRefMap.addString("jupoint", refSubjMap.getString("jupoint", k));
                				addSubjRefMap.addString("gakweight", refSubjMap.getString("gakweight", k));
                				addSubjRefMap.addString("juweight", refSubjMap.getString("juweight", k));
        					}
            			} else {
            				addSubjRefMap.addString("refSubjnm", "");
            				addSubjRefMap.addString("refSubj", subjMap.getString("subj", j));
            				addSubjRefMap.addString("subj", subjMap.getString("subj", j));
            				addSubjRefMap.addString("subjnm", subjMap.getString("subjnm", j));
            				addSubjRefMap.addString("ptype", subjMap.getString("ptype", j));
            				addSubjRefMap.addString("ptypenm", subjMap.getString("ptypenm", j));
            				addSubjRefMap.addString("evlYn", subjMap.getString("evlYn", j));
            				addSubjRefMap.addString("subjtype", subjMap.getString("subjtype", j));
            				addSubjRefMap.addString("started", subjMap.getString("started", j));
            				addSubjRefMap.addString("enddate", subjMap.getString("enddate", j));
            				addSubjRefMap.addString("lecType", subjMap.getString("lecType", j));
            				addSubjRefMap.addString("count1", subjMap.getString("count1", j));
            				addSubjRefMap.addString("count2", subjMap.getString("count2", j));
            				addSubjRefMap.addString("count3", subjMap.getString("count3", j));
            				addSubjRefMap.addString("preed", subjMap.getString("preed", j));
            				addSubjRefMap.addString("closing", subjMap.getString("closing", j));
            				addSubjRefMap.addString("gakpoint", subjMap.getString("gakpoint", j));
            				addSubjRefMap.addString("jupoint", subjMap.getString("jupoint", j));
            				addSubjRefMap.addString("gakweight", subjMap.getString("gakweight", j));
            				addSubjRefMap.addString("juweight", subjMap.getString("juweight", j));
            			}
            			addSubjMap.add("SUBJ_REF_LIST_MAP", addSubjRefMap);
            		}
            	}
            	grSeqMap.add("SUBJ_LIST_MAP", addSubjMap);
            }//end for 과목 기수의 과목 목록
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return grSeqMap;        
	}
	
	/**
	 * 과정기수 정보
	 */
	public DataMap selectGrSeqRow(String grcode, String grseq) throws BizException {
		DataMap resultMap = null;
        
        try {
        	Map<String, Object> paramMap = new HashMap<String, Object>();
        	paramMap.put("grcode", grcode);
        	paramMap.put("grseq", grseq);
        	
            resultMap = courseSeqMapper.selectGrSeqRow(paramMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;        
	}
	
	/**
	 * 과정 기수 정보. (사이버)
	 */
	public DataMap selectGrSeqRowForCyber(DataMap requestMap) throws BizException{
		DataMap resultMap = null;
        
        try {
            resultMap = courseSeqMapper.selectGrSeqRowForCyber(requestMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;        
	}
	
	/**
	 * 과정 기수 정보 수정.
	 */
	public int updateGrSeq(DataMap paramMap) throws BizException{
		int returnValue = 0;
        
        try {
        	//과정기수 수정
            returnValue = courseSeqMapper.updateGrSeq(paramMap);
            
            if(returnValue > 0 ) //강의 개설 정보 수정.
            	courseSeqMapper.updateSubjSeqDate(paramMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return returnValue;        
	}
	
	/**
	 * 연계된 과목기수정보 갯수.
	 */
	public int selectGrSeqSubjConnectChk(Map<String, Object> paramMap) throws BizException{
		int resultValue = 0;
        
        try {
        	resultValue = courseSeqMapper.selectGrSeqSubjConnectChk(paramMap);                        
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultValue;        
	}
	
	/**
	 * 과정 기수 삭제.
	 */
	public int deleteGrSeq(String grcode, String grseq) throws BizException{
		int returnValue = 0;
		Map<String, Object> paramMap = null;
		
        try {
        	StringBuffer sbWhereStr = new StringBuffer();
        	
        	sbWhereStr.append(" AND GRCODE = '").append(grcode).append("' AND GRSEQ = '").append(grseq).append("' ");
        	
        	paramMap = new HashMap<String, Object>();
        	paramMap.put("TABLENAME", "TB_EVLINFO_GRSEQ");
        	paramMap.put("WHERE_STRING", sbWhereStr.toString());
        	commonMapper.deleteCommonQuery(paramMap);
        	
        	paramMap = new HashMap<String, Object>();
        	paramMap.put("TABLENAME", "TB_GREXPAGE");
        	paramMap.put("WHERE_STRING", sbWhereStr.toString());
        	commonMapper.deleteCommonQuery(paramMap);
        	
        	paramMap = new HashMap<String, Object>();
        	paramMap.put("TABLENAME", "TB_EXRESULT");
        	paramMap.put("WHERE_STRING", sbWhereStr.toString());
        	commonMapper.deleteCommonQuery(paramMap);
        	
        	paramMap = new HashMap<String, Object>();
        	paramMap.put("TABLENAME", "TB_GREXAM_INFO");
        	paramMap.put("WHERE_STRING", sbWhereStr.toString());
        	commonMapper.deleteCommonQuery(paramMap);
        	
        	paramMap = new HashMap<String, Object>();
        	paramMap.put("TABLENAME", "TB_SUBJNOTICE");
        	paramMap.put("WHERE_STRING", sbWhereStr.toString());
        	commonMapper.deleteCommonQuery(paramMap);
            
        	paramMap = new HashMap<String, Object>();
        	paramMap.put("TABLENAME", "TB_STU_LEC");
        	paramMap.put("WHERE_STRING", sbWhereStr.toString());
        	commonMapper.deleteCommonQuery(paramMap);
        	
        	paramMap = new HashMap<String, Object>();
        	paramMap.put("TABLENAME", "TB_REPORT_SUBMIT");
        	paramMap.put("WHERE_STRING", sbWhereStr.toString());
        	commonMapper.deleteCommonQuery(paramMap);
        	
        	paramMap = new HashMap<String, Object>();
        	paramMap.put("TABLENAME", "TB_REPORT");
        	paramMap.put("WHERE_STRING", sbWhereStr.toString());
        	commonMapper.deleteCommonQuery(paramMap);
        	
        	paramMap = new HashMap<String, Object>();
        	paramMap.put("TABLENAME", "TB_REJ_REPORT_SUBMIT");
        	paramMap.put("WHERE_STRING", sbWhereStr.toString());
        	commonMapper.deleteCommonQuery(paramMap);
        	
        	paramMap = new HashMap<String, Object>();
        	paramMap.put("TABLENAME", "TB_REPORT_GRADE");
        	paramMap.put("WHERE_STRING", sbWhereStr.toString());
        	commonMapper.deleteCommonQuery(paramMap);
            
        	paramMap = new HashMap<String, Object>();
        	paramMap.put("TABLENAME", "TB_GRSEQMANAGER");
        	paramMap.put("WHERE_STRING", sbWhereStr.toString());
        	commonMapper.deleteCommonQuery(paramMap);
        	
        	paramMap = new HashMap<String, Object>();
        	paramMap.put("TABLENAME", "TB_GRSTUMAS");
        	paramMap.put("WHERE_STRING", sbWhereStr.toString());
        	commonMapper.deleteCommonQuery(paramMap);
        	
        	paramMap = new HashMap<String, Object>();
        	paramMap.put("TABLENAME", "TB_GRSUBJ");
        	paramMap.put("WHERE_STRING", sbWhereStr.toString());
        	commonMapper.deleteCommonQuery(paramMap);
        	
        	paramMap = new HashMap<String, Object>();
        	paramMap.put("TABLENAME", "TB_EVLINFO_SUBJ");
        	paramMap.put("WHERE_STRING", sbWhereStr.toString());
        	commonMapper.deleteCommonQuery(paramMap);
        	
        	paramMap = new HashMap<String, Object>();
        	paramMap.put("TABLENAME", "TB_EXDETAIL");
        	paramMap.put("WHERE_STRING", sbWhereStr.toString());
        	commonMapper.deleteCommonQuery(paramMap);
            
        	paramMap = new HashMap<String, Object>();
        	paramMap.put("TABLENAME", "TB_GREXPAGE");
        	paramMap.put("WHERE_STRING", sbWhereStr.toString());
        	commonMapper.deleteCommonQuery(paramMap);
        	
        	paramMap = new HashMap<String, Object>();
        	paramMap.put("TABLENAME", "TB_EXPAGE");
        	paramMap.put("WHERE_STRING", sbWhereStr.toString());
        	commonMapper.deleteCommonQuery(paramMap);
        	
        	paramMap = new HashMap<String, Object>();
        	paramMap.put("TABLENAME", "TB_SUBJMANAGER");
        	paramMap.put("WHERE_STRING", sbWhereStr.toString());
        	commonMapper.deleteCommonQuery(paramMap);
        	
        	paramMap = new HashMap<String, Object>();
        	paramMap.put("TABLENAME", "TB_SUBJCLASS");
        	paramMap.put("WHERE_STRING", sbWhereStr.toString());
        	commonMapper.deleteCommonQuery(paramMap);
        	
        	paramMap = new HashMap<String, Object>();
        	paramMap.put("TABLENAME", "TB_SUBJSEQ");
        	paramMap.put("WHERE_STRING", sbWhereStr.toString());
        	commonMapper.deleteCommonQuery(paramMap);
            
        	paramMap = new HashMap<String, Object>();
        	paramMap.put("TABLENAME", "TB_GRSEQ");
        	paramMap.put("WHERE_STRING", sbWhereStr.toString());
        	commonMapper.deleteCommonQuery(paramMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return returnValue;        
	}
	
	/**
	 * 과정기수에 속한 과목 리스트
	 */
	public DataMap selectSubjLecTypeList2(Map<String, Object> paramMap) throws BizException{
		DataMap resultMap = null;
        
        try {
        	resultMap = courseSeqMapper.selectSubjLecTypeList2(paramMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;        
	}
	
	/**
	 * 관리자 구분별, 진행.전체 구분별 과정목록 SELECTBOX
	 */
	public DataMap selectSessClassGrCodeList(Map<String, Object> paramMap) throws BizException{
		DataMap resultMap = null;
        
        try {
        	resultMap = courseSeqMapper.selectSessClassGrCodeList(paramMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;        
	}
	
	/**
	 * 과정기수관리 개설과정 리스트 (년도별, 과정검색)
	 */
	public DataMap selectGrcodeList(DataMap requestMap) throws BizException{
		DataMap resultMap = null;
        
        try {
        	resultMap = courseSeqMapper.selectGrcodeList(requestMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;        
	}
	
	/**
	 * 과정정보 및 MAX SEQ 가져오기.
	 */
	public DataMap selectGrseqMaxList(String year, String whereStr) throws BizException{
		DataMap resultMap = null;
        
        try {
        	Map<String, Object> paramMap = new HashMap<String, Object>();
        	paramMap.put("year", year);
        	paramMap.put("whereStr", whereStr);
        	resultMap = courseSeqMapper.selectGrseqMaxList(paramMap);                        
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;        
	}
	
	/**
	 * 과정기수관리 개설과정 추가.
	 */
	public int insertGrSeqGrcode(DataMap requestMap, DataMap grSeqListMap, String userNo) throws BizException{
		int returnValue = 0;
		Map<String, Object> paramMap = null;
		
        try {
        	// 교육 계획 등록
    		if (grSeqListMap != null && grSeqListMap.keySize("grcode") > 0) {
    			for (int i = 0;i < grSeqListMap.keySize("grcode");i++) {
    				paramMap = new HashMap<String, Object>();
        			paramMap.put("grcode", grSeqListMap.getString("grcode", i));
        			paramMap.put("grseq", grSeqListMap.getString("grseq", i));
        			paramMap.put("grcodenm", grSeqListMap.getString("grcodenm", i));
        			paramMap.put("useYn", grSeqListMap.getString("useYn", i));
        			paramMap.put("grPoint", Float.parseFloat(Util.getValue(grSeqListMap.getString("grPoint", i), "0")));
        			paramMap.put("grgubun", grSeqListMap.getString("grgubun", i));
        			paramMap.put("tdate", grSeqListMap.getString("tdate",i));
        			
    				returnValue = courseSeqMapper.insertGrSeqGrcodeLittle(paramMap);
    				
    	            if(returnValue > 0){
    	            	courseSeqMapper.insertGrSubjSpec(paramMap);
    	            	paramMap.put("userNo", userNo);
    	            	courseSeqMapper.insertSubjSeqSpec(paramMap);
    	            	courseSeqMapper.insertSubjClassSpec(paramMap);
    	            }
    			}//end for
    		}   
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return returnValue;        
	}
	
	/**
	 * 과정기수관리 개설과정 삭제.
	 */
	public int deleteGrSeqGrcode(DataMap requestMap) throws BizException{
		int returnValue = 0;
        
        try {
        	courseSeqMapper.deleteGrSubjClass(requestMap);
            
        	courseSeqMapper.deleteSubjSeq(requestMap);
            
        	courseSeqMapper.deleteGrsubj(requestMap);
            
            returnValue = courseSeqMapper.deleteGrseqGrcode(requestMap);                        
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return returnValue;        
	}
	
	/**
	 * 과정기수에 속한 회장, 부회장 리스트
	 */
	public DataMap selectGrStuMasList(DataMap requestMap) throws BizException{
		DataMap resultMap = null;
        
        try {
        	resultMap = courseSeqMapper.selectGrStuMasList(requestMap);                        
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;        
	}
	
	/**
	 * 과정기수에 속한 회장, 부회장 리스트
	 */
	public DataMap selectGrStuMasGubunList(DataMap requestMap) throws BizException{
		DataMap resultMap = null;
        
        try {
        	resultMap = courseSeqMapper.selectGrStuMasGubunList(requestMap);                        
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;        
	}
	
	/**
	 * 과정기수 수강신청 완료 된 학생 검색 리스트
	 */
	public DataMap selectGrSeqAppMemberList(DataMap requestMap) throws BizException{
		DataMap resultMap = null;
        
        try {
        	resultMap = courseSeqMapper.selectGrSeqAppMemberList(requestMap);                        
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;        
	}
	
	/**
	 * 과정기수에 속한 회장, 부회장 등록
	 */
	public int insertGrSeqStuMas(Map<String, Object> paramMap) throws BizException{
		int returnValue = 0;
        
        try {
        	returnValue = courseSeqMapper.insertGrSeqStuMas(paramMap);                        
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return returnValue;        
	}
	
	/**
	 * 과정기수에 속한 회장, 부회장 삭제
	 */
	public int deleteGrSeqStuMas(DataMap requestMap) throws BizException{
		int returnValue = 0;
        
        try {
        	returnValue = courseSeqMapper.deleteGrSeqStuMas(requestMap);                        
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return returnValue;        
	}
	
	/**
	 * 강사 검색.
	 */
	public DataMap selectMemberTutorList(DataMap requestMap) throws BizException{
		DataMap resultMap = new DataMap();
        
        try {
        	Map<String, Object> paramMap = new HashMap<String, Object>();
        	paramMap.put("searchName", requestMap.getString("searchName"));
        	
        	int memberTutorListCount = courseSeqMapper.selectMemberTutorListCount(paramMap);
        	
        	Map<String, Object> pageInfo = Util.getPageInfo(memberTutorListCount, requestMap);
        	
        	pageInfo.put("searchName", requestMap.getString("searchName"));
        	
        	resultMap = courseSeqMapper.selectMemberTutorList(pageInfo);
        	
        	PageNavigation pageNavi = Util.getPageNavigation(pageInfo);
			
        	resultMap.set("PAGE_INFO", pageNavi);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;        
	}
	
	/**
	 * 과정 기수 추가.
	 */
	public int insertGrSeq(DataMap requestMap, String userNo) throws BizException{
		int returnValue = 0;
		Map<String, Object> paramMap = null;
		
        try {
        	if (requestMap.keySize("grcode") > 0) {
            	for(int i = 0; i < requestMap.keySize("grcode"); i++) {
            		paramMap = new HashMap<String, Object>();
            		paramMap.put("year", requestMap.getString("year"));
            		paramMap.put("grcode", requestMap.getString("grcode", i));
            		
            		DataMap nextGrseqMap = courseSeqMapper.selectNextGrSeqRow(paramMap);
            		nextGrseqMap.setNullToInitialize(true);
            		
            		//과정 기수 등록
            		paramMap = new HashMap<String, Object>();
            		paramMap.put("grcode", nextGrseqMap.get("grcode"));
        			paramMap.put("grseq", nextGrseqMap.get("grseq"));
        			paramMap.put("grcodenm", nextGrseqMap.get("grcodenm"));
        			paramMap.put("useYn", nextGrseqMap.get("useYn"));
        			paramMap.put("grPoint", Float.parseFloat(nextGrseqMap.get("grPoint").toString()));
        			paramMap.put("grgubun", nextGrseqMap.get("grgubun"));
        			paramMap.put("tdate", nextGrseqMap.get("tdate"));
        			
            		int result = courseSeqMapper.insertGrSeqGrcodeLittle(paramMap);
            		
            		if(result > 0){
            			//과정 기수 외에 과목정보 등 등록.
            			courseSeqMapper.insertGrSubjSpec(paramMap);
            			paramMap.put("userNo", userNo);
            			courseSeqMapper.insertSubjSeqSpec(paramMap);
            			courseSeqMapper.insertSubjClassSpec(paramMap);
    	            	
    	            	returnValue++;
            		}
            		nextGrseqMap.clear();
            	}
            }
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return returnValue;        
	}
	
	/**
	 * 과목 정보 검색 (index검색, 과목 유형검색, 현재 과정기수의 과목이 아닌것만 검색.)
	 */
	public DataMap selectSubjByIndexList(DataMap requestMap) throws BizException{
		DataMap resultMap = null;
        
        try {
        	int subjByIndexListCount = courseSeqMapper.selectSubjByIndexListCount(requestMap);
        	
        	Map<String, Object> pageInfo = Util.getPageInfo(subjByIndexListCount, requestMap);
        	pageInfo.put("grcode", requestMap.getString("grcode"));
        	pageInfo.put("grseq", requestMap.getString("grseq"));
        	pageInfo.put("searchKey", requestMap.getString("searchKey"));
        	pageInfo.put("searchValue", requestMap.getString("searchValue"));
        	pageInfo.put("qu", requestMap.getString("qu"));
        	
        	resultMap = courseSeqMapper.selectSubjByIndexList(pageInfo);
        	
        	PageNavigation pageNavi = Util.getPageNavigation(pageInfo);
			
        	resultMap.set("PAGE_INFO", pageNavi);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;        
	}
	
	/**
	 * 과정기수에 등록한 과목 리스트.
	 */
	public DataMap selectSubjInGrSeqList(DataMap requestMap) throws BizException{
		DataMap resultMap = null;
        
        try {
        	resultMap = courseSeqMapper.selectSubjInGrSeqList(requestMap);                        
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;        
	}
	
	/**
	 * 과목 추가.
	 */
	public int insertGrSeqSubj(DataMap requestMap, String userNo) throws BizException{
		int returnValue = 0;
        
        try {
        	String grcode = requestMap.getString("grcode");
            String grseq = requestMap.getString("grseq");
            String subj = "";
            
            //과정 기수 정보 가져 옴.
            Map<String, Object> paramMap = new HashMap<String, Object>();
            paramMap.put("grcode", grcode);
            paramMap.put("grseq", grseq);
            DataMap grSeqMap = courseSeqMapper.selectGrSeqRow(paramMap);
            if (grSeqMap == null) {
            	grSeqMap = new DataMap();
            }
            grSeqMap.setNullToInitialize(true);
            
            String whereSubjStr = "";
            for(int i=0; i < requestMap.keySize("subj"); i++){
            	if(requestMap.getString("subj", i).equals(""))
            		continue;
            	
            	if(!whereSubjStr.equals(""))
            		whereSubjStr += ", ";
            	
            	whereSubjStr += " '" + requestMap.getString("subj", i) + "' ";
            }
            
            DataMap subjListMap = null;
        	if("insert".equals(requestMap.getString("qu"))) {
        		//선택한 과목의 정보 가져오기.
        		if(!whereSubjStr.equals("")) {
            		whereSubjStr = " AND SUBJ IN ( " + whereSubjStr + " ) ";
            	}
        		
        		paramMap = new HashMap<String, Object>();
                paramMap.put("whereSubjStr", whereSubjStr);
                
                subjListMap = courseSeqMapper.selectSubjList(paramMap);
                
                if(subjListMap == null) {
                	subjListMap = new DataMap();
                }
                
        	//이전과목복사일때
        	} else {
        		//선택한 과목의 정보 가져오기.
        		if(!whereSubjStr.equals("")) {
            		whereSubjStr = " AND SS.SUBJ IN ( " + whereSubjStr + " ) ";
            	}
        		
        		paramMap = new HashMap<String, Object>();
        		paramMap.put("grcode", grcode);
                paramMap.put("grseq", requestMap.getString("copyGrseq"));
                paramMap.put("whereSubjStr", whereSubjStr);
                
                subjListMap = courseSeqMapper.selectSubjInfoList(paramMap);
                
                if(subjListMap == null) {
                	subjListMap = new DataMap();
                }
        	}
        	subjListMap.setNullToInitialize(true);
            
            DataMap insertSubjMap = null; //과목
            DataMap insertSeqMap = null; //강의개설 정보
            DataMap insertClassMap = null; //반구성
            //선택한 과목 수만큼 반복.
            for(int i=0; i < subjListMap.keySize("subj"); i++) {
            	int tmpResult = 0;
            	subj = subjListMap.getString("subj", i);
            	
            	insertSubjMap = new DataMap();
            	insertSubjMap.setNullToInitialize(true);
            	
            	insertSubjMap.setString("grcode", grcode);
            	insertSubjMap.setString("grseq", grseq);
            	insertSubjMap.setString("subj", subj);
            	insertSubjMap.setString("fOk", "N");
            	insertSubjMap.setString("lecType", subjListMap.getString("selGubun", i));
            	
            	//과목 등록.
            	courseSeqMapper.insertGrSubj(insertSubjMap);
            	
            	insertSeqMap = new DataMap();
            	insertSeqMap.setNullToInitialize(true);
            	
            	insertSeqMap.setString("grcode", grcode);
            	insertSeqMap.setString("grseq", grseq);
            	insertSeqMap.setString("subj", subj);
            	insertSeqMap.setString("lecType", subjListMap.getString("selGubun", i));
            	insertSeqMap.setString("lecnm", subjListMap.getString("subjnm", i));
            	insertSeqMap.setString("started", grSeqMap.getString("started"));
            	insertSeqMap.setString("enddate", grSeqMap.getString("enddate"));
            	insertSeqMap.setString("closing", "N");
            	//insertSeqMap.setString("tsection", subjListMap.getString("weekCount", i));
            	//tsection(총일차수) - 차시 카운트를 이전기수의 과목정보로 대체함.
            	insertSeqMap.setString("tsection", subjListMap.getString("tsection", i));
            	insertSeqMap.setString("limit", subjListMap.getString("limit", i));
            	insertSeqMap.setString("grastep", subjListMap.getString("grastep", i));
            	insertSeqMap.setString("luserno", userNo);
            	insertSeqMap.setString("refSubj", "");

            	//TB_SUBJSEQ 등록
            	tmpResult = courseSeqMapper.insertSubjSeq(insertSeqMap);
            	
            	if (tmpResult > 0) {
            		//반구성
            		insertClassMap = new DataMap();
            		insertClassMap.setNullToInitialize(true);
                	
            		insertClassMap.setString("grcode", grcode);
            		insertClassMap.setString("grseq", grseq);
            		insertClassMap.setString("subj", subj);
            		insertClassMap.setString("classno", "1");
                	insertClassMap.setString("classnm", "1반");
                	insertClassMap.setString("luserno", userNo);
                	
                	//반등록
                	courseSeqMapper.insertSubjClass(insertClassMap);
                	
                	insertClassMap.clear();
            	}
            	
            	//수강생 등록.
            	paramMap = new HashMap<String, Object>();
            	paramMap.put("grcode", grcode);
            	paramMap.put("grseq", grseq);
            	paramMap.put("subj", subj);
            	paramMap.put("userNo", userNo);
            	
            	if (courseSeqMapper.selectStuLecCnt(paramMap) > 0 && courseSeqMapper.selectStuLecSubjCnt(paramMap) <= 0 ) {
                	//수강신청후 과목 tb_stu_lec에 과목 추가.
                	tmpResult = courseSeqMapper.insertStuLecSubjSpec(paramMap);
            	}
            	
            	//선택 과목이라면 
            	if(subjListMap.getString("selGubun", i).equals("P")){
            		whereSubjStr = " AND SUBJ IN ( ( SELECT SUB_SUBJ FROM TB_SUBJGRP WHERE SUBJ = '" + subj + "') ) ";
            		//System.out.print("\n ##2 whereString = "+ whereSubjStr + "\n");
            		
            		paramMap = new HashMap<String, Object>();
                    paramMap.put("whereSubjStr", whereSubjStr);
                    
                    DataMap choiceSubjListMap = courseSeqMapper.selectSubjList(paramMap);
                    if (choiceSubjListMap == null) {
                    	choiceSubjListMap = new DataMap();
                    }
                    choiceSubjListMap.setNullToInitialize(true);
                    
                    //선택과목의 리스트 만큼 등록.
                    for(int j=0; j < choiceSubjListMap.keySize("subj"); j++) {
                    	insertSubjMap.setString("subj", choiceSubjListMap.getString("subj", j));
                    	insertSubjMap.setString("lecType", choiceSubjListMap.getString("selGubun", j));
                    	
                    	//선택 과목 등록.
                    	courseSeqMapper.insertGrSubj(insertSubjMap);
                    	
                    	insertSeqMap.setString("subj", choiceSubjListMap.getString("subj", j));
                    	insertSeqMap.setString("lecType", "C");
                    	insertSeqMap.setString("lecnm", choiceSubjListMap.getString("subjnm", j));
                    	insertSeqMap.setString("closing", "N");
                    	insertSeqMap.setString("tsection", choiceSubjListMap.getString("weekCount", j));
                    	insertSeqMap.setString("limit", choiceSubjListMap.getString("limit", j));
                    	insertSeqMap.setString("refSubj", subj);
                    	
                    	//강의 개설 정보 등록.
                    	tmpResult = courseSeqMapper.insertSubjSeq(insertSeqMap);
                    	
                    	if (tmpResult > 0) {
                        	//반구성
                    		insertClassMap = new DataMap();
                    		insertClassMap.setNullToInitialize(true);
                        	
                    		insertClassMap.setString("grcode", grcode);
                    		insertClassMap.setString("grseq", grseq);
                    		insertClassMap.setString("subj", choiceSubjListMap.getString("subj", j));
                    		insertClassMap.setString("classno", "1");
                        	insertClassMap.setString("classnm", "1반");
                        	insertClassMap.setString("luserno", userNo);
                        	
                        	//반등록
                        	courseSeqMapper.insertSubjClass(insertClassMap);
                        	
                        	insertClassMap.clear();
                    	}
                    }
            	}
            	
            	insertSubjMap.clear();
            	insertSeqMap.clear();
            	
            	returnValue++;
            } // end for   
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return returnValue;
	}
	
	/**
	 * 과정 수료 인원 count
	 */
	public int selectGrResultCnt(DataMap requestMap) throws BizException{
		int resultValue = 0;
        
        try {
        	resultValue = courseSeqMapper.selectGrResultCnt(requestMap);                        
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultValue;        
	}
	
	/**
	 * 과목 수료 인원 count
	 */
	public int selectSubjResultCnt(DataMap requestMap) throws BizException{
		int resultValue = 0;
        
        try {
        	if(!requestMap.getString("subj").equals("ALL")) {
            	resultValue = courseSeqMapper.selectSubjResultCnt(requestMap); //과목
        	} else {
            	resultValue = courseSeqMapper.selectSubjAllResultCnt(requestMap); //전체 과목
        	}
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultValue;        
	}
	
	/**
	 * 과목 전체 수료 인원 count
	 */
	public int selectSubjAllResultCnt(DataMap requestMap) throws BizException{
		int resultValue = 0;
        
        try {
        	resultValue = courseSeqMapper.selectSubjAllResultCnt(requestMap); //전체 과목                        
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultValue;        
	}
	
	/**
	 * 과목 삭제.
	 */
	public int deleteSubj(DataMap requestMap) throws BizException{
		int returnValue = 0;
		Map<String, Object> paramMap = null;
		
        try {
        	StringBuffer sbWhereStr = new StringBuffer();
        	sbWhereStr.append(" AND GRCODE = '").append(requestMap.getString("grcode")).append("' ");
        	sbWhereStr.append(" AND GRSEQ = '").append(requestMap.getString("grseq")).append("' ");
            if(!requestMap.getString("subj").equals("ALL")) {
            	sbWhereStr.append(" AND SUBJ = '").append(requestMap.getString("subj")).append("' ");
            }
            
            paramMap = new HashMap<String, Object>();
        	paramMap.put("TABLENAME", "TB_SUBJCLASS");
        	paramMap.put("WHERE_STRING", sbWhereStr.toString());
            commonMapper.deleteCommonQuery(paramMap);
            
            paramMap = new HashMap<String, Object>();
        	paramMap.put("TABLENAME", "TB_SUBJMANAGER");
        	paramMap.put("WHERE_STRING", sbWhereStr.toString());
        	commonMapper.deleteCommonQuery(paramMap);
            
            paramMap = new HashMap<String, Object>();
        	paramMap.put("TABLENAME", "TB_GREXPAGE");
        	paramMap.put("WHERE_STRING", sbWhereStr.toString());
        	commonMapper.deleteCommonQuery(paramMap);
            
            paramMap = new HashMap<String, Object>();
        	paramMap.put("TABLENAME", "TB_EXDETAIL");
        	paramMap.put("WHERE_STRING", sbWhereStr.toString());
        	commonMapper.deleteCommonQuery(paramMap);
            
            paramMap = new HashMap<String, Object>();
        	paramMap.put("TABLENAME", "TB_GREXPAGE");
        	paramMap.put("WHERE_STRING", sbWhereStr.toString());
        	commonMapper.deleteCommonQuery(paramMap);
            
            paramMap = new HashMap<String, Object>();
        	paramMap.put("TABLENAME", "TB_EXPAGE");
        	paramMap.put("WHERE_STRING", sbWhereStr.toString());
        	commonMapper.deleteCommonQuery(paramMap);
            
            paramMap = new HashMap<String, Object>();
        	paramMap.put("TABLENAME", "TB_EXRESULT");
        	paramMap.put("WHERE_STRING", sbWhereStr.toString());
        	commonMapper.deleteCommonQuery(paramMap);
            
            paramMap = new HashMap<String, Object>();
        	paramMap.put("TABLENAME", "TB_SUBJNOTICE");
        	paramMap.put("WHERE_STRING", sbWhereStr.toString());
        	commonMapper.deleteCommonQuery(paramMap);
            
            /***** check start ******/
            paramMap = new HashMap<String, Object>();
        	paramMap.put("TABLENAME", "TB_SUBJCLASS");
        	paramMap.put("WHERE_STRING", sbWhereStr.toString());
        	commonMapper.deleteCommonQuery(paramMap);
            /***** check end ******/
            
            paramMap = new HashMap<String, Object>();
        	paramMap.put("TABLENAME", "TB_STU_LEC");
        	paramMap.put("WHERE_STRING", sbWhereStr.toString());
        	commonMapper.deleteCommonQuery(paramMap);
            
            paramMap = new HashMap<String, Object>();
        	paramMap.put("TABLENAME", "TB_REJ_REPORT_SUBMIT");
        	paramMap.put("WHERE_STRING", sbWhereStr.toString());
        	commonMapper.deleteCommonQuery(paramMap);
            
            paramMap = new HashMap<String, Object>();
        	paramMap.put("TABLENAME", "TB_EVLINFO_SUBJ");
        	paramMap.put("WHERE_STRING", sbWhereStr.toString());
        	commonMapper.deleteCommonQuery(paramMap);
            
            paramMap = new HashMap<String, Object>();
        	paramMap.put("TABLENAME", "TB_GRSUBJ");
        	paramMap.put("WHERE_STRING", sbWhereStr.toString());
        	commonMapper.deleteCommonQuery(paramMap);
            
            paramMap = new HashMap<String, Object>();
        	paramMap.put("TABLENAME", "TB_SUBJSEQ");
        	paramMap.put("WHERE_STRING", sbWhereStr.toString());
        	commonMapper.deleteCommonQuery(paramMap);
            
            returnValue++;         
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return returnValue;        
	}
	
	/**
	 * 과목의 개설정보
	 */
	public DataMap selectSubjSeqRow(DataMap requestMap) throws BizException{
		DataMap resultMap = null;
        
        try {
        	resultMap = courseSeqMapper.selectSubjSeqRow(requestMap);                        
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;        
	}
	
	/**
	 * 개설 과정 정보 수정 
	 */
	public int updateSubjSeq(DataMap requestMap) throws BizException{
		int returnValue = 0;
        
        try {
        	//개설과목 정보 수정.
            returnValue = courseSeqMapper.updateSubjSeq(requestMap);
            System.out.println("returnValue ==================== " + returnValue);
            
            //하위 개설 과목 .
            if(returnValue > 0){
            	int rtnUpdateDate = courseSeqMapper.updateSubjSeqDateSub(requestMap);
            	System.out.println("rtnUpdateDate ======================== " + rtnUpdateDate);
            }         
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return returnValue;        
	}
	
	/**
	 * 과정기수관리 리스트 (입력한 기수 제외)
	 */
	public DataMap selectGrSeqByNotInList(DataMap requestMap) throws BizException{
		DataMap resultMap = null;
        
        try {
        	resultMap = courseSeqMapper.selectGrSeqByNotInList(requestMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;        
	}
	
	/**
	 * 과목의 개설정보 리스트
	 */
	public DataMap selectSubjSeqList(DataMap requestMap) throws BizException{
		DataMap resultMap = null;
        
        try {
            resultMap = courseSeqMapper.selectSubjSeqList(requestMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;        
	}
	
	/**
	 * 개설과정 정보의 과목 리스트 (복사위해)
	 */
	public DataMap selectSubjSeqCopyList(DataMap requestMap) throws BizException{
		DataMap resultMap = null;
        
        try {
        	resultMap = courseSeqMapper.selectSubjSeqCopyList(requestMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;        
	}
	
	/**
	 * 년도에 속한 기수 코드 리스트.
	 */
	public DataMap selectGrseqMngGrseqList(int year) throws BizException{
		DataMap resultMap = null;
        
        try {
        	resultMap = courseSeqMapper.selectGrseqMngGrseqList(year);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;        
	}
	
	/**
	 * 과정 리스트 (기수에 속한)
	 */
	public DataMap selectGrcodeListByGrseq(DataMap requestMap) throws BizException{
		DataMap resultMap = null;
        
        try {
            resultMap = courseSeqMapper.selectGrcodeListByGrseq(requestMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;        
	}
	
	/**
	 * 기수코드 관리의 개설과정 추가
	 */
	public int insertGrseqByGrseqMng(DataMap requestMap) throws BizException{
		int returnValue = 0;
        
        try {
        	String whereStr = "";
			
			for (int i = 0;i < requestMap.keySize("grcode[]");i++){
				if(i == 0) 
					whereStr += " AND GRCODE IN ( ";
				else 
					whereStr += ", ";
				whereStr += "'" + requestMap.getString("grcode[]", i) + "'";
			}
			
			if(!whereStr.equals("")){
				whereStr+= ") ";
	            
	            //개설과정 추가
				Map<String, Object> paramMap = new HashMap<String, Object>();
				paramMap.put("grseq", requestMap.getString("grseq"));
				paramMap.put("whereStr", whereStr);
	            returnValue = courseSeqMapper.insertGrseqByGrseqMng(paramMap);    
        	}
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return returnValue;        
	}
	
	/**
	 * 간단한 과정 기수 정보.
	 */
	public DataMap selectGrseqSimpleRow(Map<String, Object> paramMap) throws BizException{
		DataMap resultMap = null;
        
        try {
        	resultMap = courseSeqMapper.selectGrseqSimpleRow(paramMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;        
	}

	/**
	 * 유저 정보.
	 */
	public DataMap selectMemberSimpleRow(String userNo) throws BizException{
		DataMap resultMap = null;
        
        try {
        	resultMap = courseSeqMapper.selectMemberSimpleRowAndUserid(userNo);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;  
		
	}
	
	/**
	 * 과정기수의 수강 인원.
	 */
	public int selectStuLecCnt(Map<String, Object> paramMap) throws BizException{
		int resultValue = 0;
        
        try {
        	resultValue = courseSeqMapper.selectStuLecCnt(paramMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultValue;        
	}
	
	/**
	 * 과정기수관리 이전 기수 코드
	 */
	public String selectGrseqPrevMaxGrseq(DataMap requestMap) throws BizException{
		String resultValue = "";
        
        try {
        	resultValue = courseSeqMapper.selectGrseqPrevMaxGrseq(requestMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultValue;        
	}
	
	/**
	 * 이전 기수 정보 복사.
	 */
	@Transactional
	public int execPrevGrseq(DataMap requestMap, String sessUserNo) throws BizException{
		int returnValue = 0;
		Map<String, Object> paramMap = null;
		
        try {
        	String grcode = requestMap.getString("grcode"); //과정코드
            String grseq = requestMap.getString("grseq"); //수정될 기수
            String prevGrseq = requestMap.getString("prevGrseq"); //이전 기수 코드
            
			if (requestMap.getString("copyGubun1").equals("grseq")) {
				//이전기수 정보 
				paramMap = new HashMap<String, Object>();
	        	paramMap.put("grcode", grcode);
	        	paramMap.put("grseq", prevGrseq);
				DataMap prevGrseqMap = courseSeqMapper.selectGrSeqRow(paramMap);
				if (prevGrseqMap == null) {
					prevGrseqMap = new DataMap();
				}
				prevGrseqMap.setNullToInitialize(true);
				
				prevGrseqMap.setString("grseq", grseq);
				prevGrseqMap.setString("started", requestMap.getString("started"));
				prevGrseqMap.setString("enddate", requestMap.getString("enddate"));
				//수강 신청 일자의 시간은 초기화 이미 eapplyst에는 시간까지 들어있음
				prevGrseqMap.setString("eapplysth", "");
				prevGrseqMap.setString("eapplyedh", "");
				prevGrseqMap.setString("newSexampropose", "");
				prevGrseqMap.setString("newEexampropose", "");
				prevGrseqMap.setString("questionSdate", "");
				prevGrseqMap.setString("questionEdate", "");
				
				courseSeqMapper.updateGrSeq(prevGrseqMap);
				
				//과목 복사
				if (requestMap.getString("copyGubun2").equals("subj")) {
					// 1. 기존 과목 정보 삭제. 
					StringBuffer sbWhereStr = new StringBuffer();
		            sbWhereStr.append(" AND GRCODE = '").append(grcode).append("' AND GRSEQ = '").append(grseq).append("' ");
		            
		            paramMap = new HashMap<String, Object>();
		        	paramMap.put("TABLENAME", "TB_SUBJCLASS");
		        	paramMap.put("WHERE_STRING", sbWhereStr.toString());
		            commonMapper.deleteCommonQuery(paramMap);
		            
		            paramMap = new HashMap<String, Object>();
		        	paramMap.put("TABLENAME", "TB_SUBJMANAGER");
		        	paramMap.put("WHERE_STRING", sbWhereStr.toString());
		        	commonMapper.deleteCommonQuery(paramMap);
		            
		            paramMap = new HashMap<String, Object>();
		        	paramMap.put("TABLENAME", "TB_GREXPAGE");
		        	paramMap.put("WHERE_STRING", sbWhereStr.toString());
		        	commonMapper.deleteCommonQuery(paramMap);
		            
		            paramMap = new HashMap<String, Object>();
		        	paramMap.put("TABLENAME", "TB_EXDETAIL");
		        	paramMap.put("WHERE_STRING", sbWhereStr.toString());
		        	commonMapper.deleteCommonQuery(paramMap);
		            
		            paramMap = new HashMap<String, Object>();
		        	paramMap.put("TABLENAME", "TB_GREXPAGE");
		        	paramMap.put("WHERE_STRING", sbWhereStr.toString());
		        	commonMapper.deleteCommonQuery(paramMap);
		            
		            paramMap = new HashMap<String, Object>();
		        	paramMap.put("TABLENAME", "TB_EXPAGE");
		        	paramMap.put("WHERE_STRING", sbWhereStr.toString());
		        	commonMapper.deleteCommonQuery(paramMap);
		            
		            paramMap = new HashMap<String, Object>();
		        	paramMap.put("TABLENAME", "TB_EXRESULT");
		        	paramMap.put("WHERE_STRING", sbWhereStr.toString());
		        	commonMapper.deleteCommonQuery(paramMap);
		            
		            paramMap = new HashMap<String, Object>();
		        	paramMap.put("TABLENAME", "TB_SUBJNOTICE");
		        	paramMap.put("WHERE_STRING", sbWhereStr.toString());
		        	commonMapper.deleteCommonQuery(paramMap);
		            
		            paramMap = new HashMap<String, Object>();
		        	paramMap.put("TABLENAME", "TB_SUBJCLASS");
		        	paramMap.put("WHERE_STRING", sbWhereStr.toString());
		        	commonMapper.deleteCommonQuery(paramMap);
		            
		            paramMap = new HashMap<String, Object>();
		        	paramMap.put("TABLENAME", "TB_STU_LEC");
		        	paramMap.put("WHERE_STRING", sbWhereStr.toString());
		        	commonMapper.deleteCommonQuery(paramMap);
		            
		            paramMap = new HashMap<String, Object>();
		        	paramMap.put("TABLENAME", "TB_REJ_REPORT_SUBMIT");
		        	paramMap.put("WHERE_STRING", sbWhereStr.toString());
		        	commonMapper.deleteCommonQuery(paramMap);
		            
		            paramMap = new HashMap<String, Object>();
		        	paramMap.put("TABLENAME", "TB_EVLINFO_SUBJ");
		        	paramMap.put("WHERE_STRING", sbWhereStr.toString());
		        	commonMapper.deleteCommonQuery(paramMap);
		            
		            paramMap = new HashMap<String, Object>();
		        	paramMap.put("TABLENAME", "TB_GRSUBJ");
		        	paramMap.put("WHERE_STRING", sbWhereStr.toString());
		        	commonMapper.deleteCommonQuery(paramMap);
		            
		            paramMap = new HashMap<String, Object>();
		        	paramMap.put("TABLENAME", "TB_SUBJSEQ");
		        	paramMap.put("WHERE_STRING", sbWhereStr.toString());
		        	commonMapper.deleteCommonQuery(paramMap);
		            
					// 2. 과목 등록 
		        	paramMap = new HashMap<String, Object>();
		        	paramMap.put("grcode", grcode);
		        	paramMap.put("grseq", grseq);
		        	paramMap.put("prevGrseq", prevGrseq);
		        	paramMap.put("started", requestMap.getString("started"));
		        	paramMap.put("enddate", requestMap.getString("enddate"));
		        	paramMap.put("userno", sessUserNo);
		            //과정 구성 정보 등록
		        	courseSeqMapper.insertGrSubjByPrevGrseq(paramMap);
					//개설과정 정보 등록
		        	courseSeqMapper.insertSubjSeqByPrevGrseq(paramMap);
					//반구성 정보 복사
		        	courseSeqMapper.insertSubjClassByPrevGrseq(paramMap);
					
	            	//3. 수강생 등록.
					//수강신청 한 인원이 있는지 확인.
		        	paramMap.put("grchk", "Y");
					int tmpInt = completeProgressMapper.selectAppInfoByGrchkCnt(paramMap);
					if (tmpInt > 0) {
						//수강생 등록을 위해서는 과목의 리스트를 가져 와서 과목마다 수강 신청을 해준다. 선택 과목도 수강신청을 함.
						DataMap subjList = completeProgressMapper.selectSubjSeqByAllSubjList(paramMap);
						if (subjList == null) {
							subjList = new DataMap();
						}
						subjList.setNullToInitialize(true);
						
						for(int i=0; i < subjList.keySize("subj"); i++) {
							paramMap = new HashMap<String, Object>();
				        	paramMap.put("grcode", grcode);
				        	paramMap.put("grseq", grseq);
				        	paramMap.put("subj", subjList.getString("subj", i));
				        	paramMap.put("userno", sessUserNo);
		                	//수강생에 과목 추가.
							tmpInt = courseSeqMapper.insertStuLecSubjSpec(paramMap);
						}
					}

					//평가 복사
					if (requestMap.getString("copyGubun3").equals("eval")) {
						// 1. 기존 과목의 평가 정보 삭제.
						sbWhereStr = new StringBuffer();
			            sbWhereStr.append(" AND GRCODE = '").append(grcode).append("' AND GRSEQ = '").append(grseq).append("' ");
			            paramMap = new HashMap<String, Object>();
			        	paramMap.put("TABLENAME", "TB_EVLINFO_SUBJ");
			        	paramMap.put("WHERE_STRING", sbWhereStr.toString());
			        	commonMapper.deleteCommonQuery(paramMap);
			        	
			        	paramMap = new HashMap<String, Object>();
			        	paramMap.put("TABLENAME", "TB_EVLINFO_GRSEQ");
			        	paramMap.put("WHERE_STRING", sbWhereStr.toString());
			        	commonMapper.deleteCommonQuery(paramMap);
						
						// 2. 이전기수의 평가마스터, 과목별 평가, 과목별 배점 정보 등록.
						//평가 마스터 복사
			            paramMap = new HashMap<String, Object>();
			        	paramMap.put("grcode", grcode);
			        	paramMap.put("grseq", grseq);
			        	paramMap.put("prevGrseq", prevGrseq);
			        	paramMap.put("userno", sessUserNo);
						tmpInt = courseSeqMapper.insertEvalInfoGrseqByPrevGrseq(paramMap);
						if (tmpInt > 0) {
							//평가 과목 정보
							courseSeqMapper.insertEvalInfoSubjByPrevGrseq(paramMap);
							//과목별 문제지 정보
							courseSeqMapper.insertExPageByPrevGrseq(paramMap);
						}
						
						//기수의 평가 일정 수정.
						paramMap.put("evlSdate", requestMap.getString("newSexampropose"));
			        	paramMap.put("evlEdate", requestMap.getString("newEexampropose"));
						courseSeqMapper.updateGrseqByEvlDate(paramMap);
					} else {
						paramMap = new HashMap<String, Object>();
			        	paramMap.put("grcode", grcode);
			        	paramMap.put("grseq", grseq);
						//과목 복사를 하게 되면 이전기수의 평가 내용까지 복사가 되어지는데
						//평가 복사를 선택하지 않았으면 평가 항목은 초기화를 해주어야 함.
						courseSeqMapper.updateSubjSeqByEvlNull(paramMap);
					}
					
					//설문복사
					if (requestMap.getString("copyGubun4").equals("inq")) {
						paramMap = new HashMap<String, Object>();
			        	paramMap.put("grcode", grcode);
			        	paramMap.put("grseq", grseq);
						// 1. 기존 설문 내용 삭제. 과목이 삭제 되었으므로 삭제 해야 함.
						DataMap inqList = courseSeqMapper.selectGrInqTtlByGrseqSimpleList(paramMap);
						if (inqList == null) {
							inqList = new DataMap();
						}
						inqList.setNullToInitialize(true);
						
						Map<String, Object> paramMap2 = null;
						for(int i=0; i < inqList.keySize("titleNo"); i++) {
							sbWhereStr = new StringBuffer();
				            sbWhereStr.append(" AND TITLE_NO = ").append(inqList.getString("titleNo", i));
				            
				            paramMap2 = new HashMap<String, Object>();
				        	paramMap2.put("TABLENAME", "TB_GRINQ_ANSWER");
				        	paramMap2.put("WHERE_STRING", sbWhereStr.toString());
				            commonMapper.deleteCommonQuery(paramMap2); //설문 응답
				            
				            paramMap2 = new HashMap<String, Object>();
				        	paramMap2.put("TABLENAME", "TB_GRINQ_SAMP_SET");
				        	paramMap2.put("WHERE_STRING", sbWhereStr.toString());
				            commonMapper.deleteCommonQuery(paramMap2); //보기
				            
				            paramMap2 = new HashMap<String, Object>();
				        	paramMap2.put("TABLENAME", "TB_GRINQ_QUESTION_SET");
				        	paramMap2.put("WHERE_STRING", sbWhereStr.toString());
				            commonMapper.deleteCommonQuery(paramMap2); //설문 항목(SET)
				            
				            paramMap2 = new HashMap<String, Object>();
				        	paramMap2.put("TABLENAME", "TB_GRINQ_TTL");
				        	paramMap2.put("WHERE_STRING", sbWhereStr.toString());
				            commonMapper.deleteCommonQuery(paramMap2); //설문 리스트
						}
						
						// 2. 이전 기수의 설문 리스트 만큼 반복하여 등록함.
						// 설문리스트, SET, 보기  순으로 이전 기수 내용 등록.
						paramMap = new HashMap<String, Object>();
			        	paramMap.put("grcode", grcode);
			        	paramMap.put("grseq", grseq);
						DataMap prevInqList = courseSeqMapper.selectGrInqTtlByGrseqSimpleList(paramMap);
						if (prevInqList == null) {
							prevInqList = new DataMap();
						}
						prevInqList.setNullToInitialize(true);
						
						for(int i=0; i < prevInqList.keySize("titleNo"); i++) {
							// 등록할 title_no 추출
							int titleNo = courseSeqMapper.selectGrInqTtlMaxTitleNo();
							
							//설문 리스트 복사
							paramMap = new HashMap<String, Object>();
				        	paramMap.put("grseq", grseq);
				        	paramMap.put("titleNo", titleNo);
				        	paramMap.put("prevTitleNo", prevInqList.getInt("titleNo", i));
							tmpInt = courseSeqMapper.insertGrInqTtlByPrevGrseq(paramMap);
							if (tmpInt > 0) {
								//설문 set 복사
								paramMap.put("userno", sessUserNo);
								tmpInt = courseSeqMapper.insertGrInqQuestionSetByPrevGrseq(paramMap);
								if (tmpInt > 0) {
									//설문 보기 복사
									courseSeqMapper.insertGrInqSampSetByPrevGrseq(paramMap);
								}
							}
						}
						//기수의 설문 일정 수정.
						paramMap = new HashMap<String, Object>();
			        	paramMap.put("grcode", grcode);
			        	paramMap.put("grseq", grseq);
			        	paramMap.put("questionSdate", requestMap.getString("questionSdate"));
			        	paramMap.put("questionEdate", requestMap.getString("questionEdate"));
						courseSeqMapper.updateGrseqByQuestionDate(paramMap);
					}
				}
			}
			returnValue++;     
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return returnValue;        
	}
	
	/**
	 * 과정기수의 파일 정보 수정
	 */
	public int updateGrseqByGroupFileNo(Map<String, Object> paramMap) throws BizException{
		int returnValue = 0;
        
        try {
        	//과정기수의 파일 정보 수정
            returnValue = courseSeqMapper.updateGrseqByGroupFileNo(paramMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return returnValue;        
	}
	
	/**
	 * 해당년의 과정의 수강신청 인원 있는지 확인.
	 */
	public int selectAppInfoByGrcodeYearCnt(DataMap requestMap) throws BizException{
		int resultValue = 0;
        
        try {
        	resultValue = courseSeqMapper.selectAppInfoByGrcodeYearCnt(requestMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultValue;        
	}
	
	/**
	 * 과정기수의 DISTINCT조건으로 년도 검색(진행,전체별 과정장ID별)
	 */
	public DataMap selectMemberLecture(String userno) throws BizException{
		DataMap resultMap = null;
        
        try {
        	resultMap = courseSeqMapper.selectMemberLecture(userno);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;        
	}

	public DataMap findEvlinfoSubjByGrcodeAndGrseqAndSubj(DataMap requestMap) throws BizException {
		
		DataMap resultMap = null;
		int nevalCnt = -1;
		DataMap evalItemEvalCnt = null;
		
		try {
			evalItemEvalCnt = evalItemMapper.selectEvalItemEvalCnt(requestMap);
			evalItemEvalCnt.setNullToInitialize(true);
			nevalCnt = evalItemEvalCnt.getInt("nevalCnt");
			requestMap.setInt("nevalCnt", nevalCnt);
			
			resultMap = courseSeqMapper.findSubjseqJoinSubjJoinEvlinfoJoinEvlCntByGrcodeAndGrseqAndSubjAndPtype(requestMap);
			resultMap.setNullToInitialize(true);
			
			if (resultMap.keySize("subj") > 0) {
				char ptype = resultMap.getString("ptype").charAt(0);
				
				double questionCnt = -1;
				double totalScore = -1;
				double juQuestionCnt = -1;
				double gakQuestionCnt = -1;
				double juWeight = -1;
				double gakWeight = -1;
				
				switch (ptype) {
				case 'T':
					juQuestionCnt = resultMap.getDouble("mjupoint");
					gakQuestionCnt = resultMap.getDouble("mgakpoint");
					juWeight = resultMap.getDouble("mjuweight");
					gakWeight = resultMap.getDouble("mgakweight");
					break;
				case 'M':
					gakQuestionCnt = resultMap.getDouble("lgakpoint");
					juQuestionCnt = resultMap.getDouble("ljupoint");
					gakWeight = resultMap.getDouble("lgakweight");
					juWeight = resultMap.getDouble("ljuweight");
					break;
				case '1':
					gakQuestionCnt = resultMap.getDouble("ngakpoint1");
					juQuestionCnt = resultMap.getDouble("njupoint1");
					gakWeight = resultMap.getDouble("ngakweight1");
					juWeight = resultMap.getDouble("njuweight1");
					break;
				case '2':
					gakQuestionCnt = resultMap.getDouble("ngakpoint2");
					juQuestionCnt = resultMap.getDouble("njupoint2");
					gakWeight = resultMap.getDouble("ngakweight2");
					juWeight = resultMap.getDouble("njuweight2");
					break;
				case '3':
					gakQuestionCnt = resultMap.getDouble("ngakpoint3");
					juQuestionCnt = resultMap.getDouble("njupoint3");
					gakWeight = resultMap.getDouble("ngakweight3");
					juWeight = resultMap.getDouble("njuweight3");
					break;
				case '4':
					gakQuestionCnt = resultMap.getDouble("ngakpoint4");
					juQuestionCnt = resultMap.getDouble("njupoint4");
					gakWeight = resultMap.getDouble("ngakweight4");
					juWeight = resultMap.getDouble("njuweight4");
					break;
				case '5':
					gakQuestionCnt = resultMap.getDouble("ngakpoint5");
					juQuestionCnt = resultMap.getDouble("njupoint5");
					gakWeight = resultMap.getDouble("ngakweight5");
					juWeight = resultMap.getDouble("njuweight5");
					break;
				default:
					break;
				}
				
				questionCnt = juQuestionCnt + gakQuestionCnt;
				totalScore = juQuestionCnt*juWeight + gakQuestionCnt*gakWeight;
				
				resultMap.setDouble("juQuestionCnt", juQuestionCnt);
				resultMap.setDouble("gakQuestionCnt", gakQuestionCnt);
				resultMap.setDouble("juWeight", juWeight);
				resultMap.setDouble("gakWeight", gakWeight);
				resultMap.setDouble("questionCnt", questionCnt);
				resultMap.setDouble("totalScore", totalScore);
			} else {
				resultMap = new DataMap();
				resultMap.setDouble("juQuestionCnt", 0);
				resultMap.setDouble("gakQuestionCnt", 0);
				resultMap.setDouble("juWeight", 0);
				resultMap.setDouble("gakWeight", 0);
				resultMap.setDouble("questionCnt", 0);
				resultMap.setDouble("totalScore", 0);
			}
			
		} catch (SQLException e) {
			throw new BizException(Message.getKey(e), e);
        } finally {
        }
		
		return resultMap;
	}

	// 시험정보
	public DataMap findExamMByGrcodeAndGrseqAndSubj(DataMap evlinfoSubjList) throws SQLException {
		return courseSeqMapper.findExamMJoinExamSubjectByGrcodeAndGrseqAndSubj(evlinfoSubjList);
	}

	// 교시정보
	public DataMap findExamUnitByIdExam(DataMap examM) throws SQLException {
		return courseSeqMapper.findExamUnitByIdExam(examM);
	}

	public DataMap countExamQByIdExamAndIdSubject(DataMap examM) throws SQLException {
		return courseSeqMapper.countExamQByIdExamAndIdSubject(examM);
	}

	public DataMap findQAnsByKeyExceptNo(DataMap dataMap) throws SQLException {
		return courseSeqMapper.findQAnsByKeyExceptNo(dataMap);
	}
	
	public DataMap selectExamSubject(Map<String, Object> paramMap) throws BizException {
		DataMap resultMap = new DataMap();
		
		try {
			resultMap = courseSeqMapper.selectExamSubject(paramMap);
		} catch (SQLException e) {
			throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
		return resultMap;
	}
	

	public DataMap selectQCount(String subj) throws BizException {
		DataMap resultMap = new DataMap();
		
		try {
			resultMap = courseSeqMapper.selectQCount(subj);
		} catch (SQLException e) {
			throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
		return resultMap;
	}

	public DataMap selectExamPaper(String idExam) throws BizException {
		DataMap resultMap = new DataMap();
		
		try {
			resultMap = courseSeqMapper.selectExamPaper(idExam);
		} catch (SQLException e) {
			throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
		return resultMap;
	}

	public int selectExamPaperSetCount(String idExam) throws BizException {
		int result = 0;
		
		try {
			result = courseSeqMapper.selectExamPaperSetCount(idExam);
		} catch (SQLException e) {
			throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
		return result;
	}

	@Transactional
	public int insertExam(DataMap requestMap) throws BizException {
		int result = 0;
		Map<String, Object> paramMap = null;
		
		try {
			paramMap = new HashMap<String, Object>();
			paramMap.put("idCompany", "10034");
			String idExam = courseSeqMapper.selectIdExamFromDual(paramMap.get("idCompany").toString());
			paramMap.put("idExam", idExam);
			DataMap chapterMap = questionMgrMapper.selectChapter(requestMap.getString("subj"));
			paramMap.put("idCourse", chapterMap.getString("idCourse"));
			paramMap.put("courseYear", requestMap.getString("grcode"));
			paramMap.put("courseNo", requestMap.getString("grseq"));
			paramMap.put("title", requestMap.getString("title"));
			int idExamKind = 0;
			if (requestMap.getString("ptype").equals("T")) {
				idExamKind = 0;
			} else if (requestMap.getString("ptype").equals("M")) {
				idExamKind = 1;
			} else if (requestMap.getString("ptype").equals("1")) {
				idExamKind = 2;
			} else if (requestMap.getString("ptype").equals("2")) {
				idExamKind = 3;
			} else if (requestMap.getString("ptype").equals("3")) {
				idExamKind = 4;
			} else if (requestMap.getString("ptype").equals("4")) {
				idExamKind = 5;
			} else if (requestMap.getString("ptype").equals("5")) {
				idExamKind = 6;
			}
			paramMap.put("idExamKind", idExamKind);
			StringBuffer sb = new StringBuffer();
			sb.append(requestMap.getString("examStart1Date")).append(requestMap.getString("examStart1Time"));
			paramMap.put("examStart1", sb.toString());
			sb = new StringBuffer();
			sb.append(requestMap.getString("examEnd1Date")).append(requestMap.getString("examEnd1Time"));
			paramMap.put("examEnd1", sb.toString());
			paramMap.put("idAuthType", 1);
			paramMap.put("ynOpenQa", "D");
			paramMap.put("ynOpenScoreDirect", "Y");
			paramMap.put("userid", requestMap.getString("userno"));
			paramMap.put("logOption", "B");
			paramMap.put("onoffType", requestMap.getString("onoff"));
			result = courseSeqMapper.insertExamM(paramMap);
			
			if (result > 0) {
				result = 0;
				paramMap.put("examUnit", 1);
				paramMap.put("title", "1교시");
				paramMap.put("userRptFormat", "hwp,doc,xls,ppt,mdb,gul,txt,jpg,psd,gif,tif,zip,arj,rar");
				paramMap.put("idLtimetype", "T");
				paramMap.put("idMovepage", "F");
				paramMap.put("ynStartstop", "N");
				paramMap.put("ynSavetemp", "Y");
				paramMap.put("ynViewas", "Y");
				paramMap.put("ynViewhint", "N");
				paramMap.put("qcntperpage", requestMap.getInt("qcntperpage"));
				paramMap.put("idExlabel", 11);
				paramMap.put("fontname", "굴림");
				paramMap.put("fontsize", 11);
				paramMap.put("paperType", 11);
				result = courseSeqMapper.insertExamUnit(paramMap);
				if (result > 0) {
					result = 0;
					paramMap.put("idSubject", chapterMap.getString("idSubject"));
					paramMap.put("subjectOrder", 1);
					paramMap.put("subjGroup", 0);
					paramMap.put("limittime", requestMap.getInt("limittime")*60);
					paramMap.put("qcount", requestMap.getInt("totalCnt"));
					int oxCnt = 0; double oxWeight = 0, oxCalc = 0;
					int choiceCnt = 0; double choiceWeight = 0, choiceCalc = 0;
					int multiAnsCnt = 0; double multiAnsWeight = 0, multiAnsCalc = 0;
					int shortAnsCnt = 0; double shortAnsWeight = 0, shortAnsCalc = 0;
					int essayCnt = 0; double essayWeight = 0, essayCalc = 0;
					for(int i=0; i<requestMap.keySize("qtype[]"); i++) {
						switch (requestMap.getInt("qtype[]",i)) {
						case 1:
							oxCnt = requestMap.getInt("oxCnt");
							oxWeight = requestMap.getDouble("oxWeight");
							oxCalc = requestMap.getDouble("oxCalc");
							break;
						case 2:
							choiceCnt = requestMap.getInt("choiceCnt");
							choiceWeight = requestMap.getDouble("choiceWeight");
							choiceCalc = requestMap.getDouble("choiceCalc");
							break;
						case 3:
							multiAnsCnt = requestMap.getInt("multiAnsCnt");
							multiAnsWeight = requestMap.getDouble("multiAnsWeight");
							multiAnsCalc = requestMap.getDouble("multiAnsCalc");
							break;
						case 4:
							shortAnsCnt = requestMap.getInt("shortAnsCnt");
							shortAnsWeight = requestMap.getDouble("shortAnsWeight");
							shortAnsCalc = requestMap.getDouble("shortAnsCalc");
							break;
						case 5:
							essayCnt = requestMap.getInt("essayCnt");
							essayWeight = requestMap.getDouble("essayWeight");
							essayCalc = requestMap.getDouble("essayCalc");
							break;
							default:
								break;
						}
					}
					paramMap.put("oxCnt", oxCnt);
					paramMap.put("oxWeight", oxWeight);
					paramMap.put("oxCalc", oxCalc);
					paramMap.put("choiceCnt", choiceCnt);
					paramMap.put("choiceWeight", choiceWeight);
					paramMap.put("choiceCalc", choiceCalc);
					paramMap.put("multiAnsCnt", multiAnsCnt);
					paramMap.put("multiAnsWeight", multiAnsWeight);
					paramMap.put("multiAnsCalc", multiAnsCalc);
					paramMap.put("shortAnsCnt", shortAnsCnt);
					paramMap.put("shortAnsWeight", shortAnsWeight);
					paramMap.put("shortAnsCalc", shortAnsCalc);
					paramMap.put("essayCnt", essayCnt);
					paramMap.put("essayWeight", essayWeight);
					paramMap.put("essayCalc", essayCalc);
					paramMap.put("allotting", requestMap.getDouble("totalCalc"));
					paramMap.put("idRandomtype", requestMap.getString("idRandomtype"));
					int examCount = requestMap.getInt("selExamCount");
					paramMap.put("setcount", examCount);
					paramMap.put("ynChapterStat", "N");
					paramMap.put("scoringDate", "");
					paramMap.put("manScoringEnd", "");
					paramMap.put("ynDisplayMsg", "N");
				    
					result = courseSeqMapper.insertExamSubject(paramMap);
					if (result > 0) {
						paramMap.put("idChapter", chapterMap.getString("idChapter"));
						/*
						DataMap maxCntMap = new DataMap();
						maxCntMap = courseSeqMapper.selectMaxCountByPType(paramMap);
						int maxOx = maxCntMap.getInt("cnt", 0);
						int maxChoice = maxCntMap.getInt("cnt", 1);
						int maxMultiAns = maxCntMap.getInt("cnt", 2);
						int maxShortAns = maxCntMap.getInt("cnt", 3);
						int maxEssay = maxCntMap.getInt("cnt", 4);
						int startNoOx = 0, endNoOx = 0;
						int startNoChoice = 0, endNoChoice = 0;
						int startNoMultiAns = 0, endNoMultiAns = 0;
						int startNoShortAns = 0, endNoShortAns = 0;
						int startNoEssay = 0, endNoEssay = 0;
						*/
						DataMap questionMap = new DataMap();
						for(int i=1; i<=examCount; i++) {
							//if (requestMap.getString("idRandomtype").equals("YQ")) {
								questionMap = courseSeqMapper.selectRandomQuestions(paramMap);
							/*
							} else {
								startNoOx = oxCnt*i+1;
								endNoOx = oxCnt*i+oxCnt;
								startNoChoice = choiceCnt*i+1;
								endNoChoice = choiceCnt*i+choiceCnt;
								startNoMultiAns = multiAnsCnt*i+1;
								endNoMultiAns = multiAnsCnt*i+multiAnsCnt;
								startNoShortAns = shortAnsCnt*i+1;
								endNoShortAns = shortAnsCnt*i+shortAnsCnt;
								startNoEssay = essayCnt*i+1;
								endNoEssay = essayCnt*i+essayCnt;
								
								if (maxOx == 0) {
									startNoOx = 0;
									endNoOx = 0;
								} else {
									if (maxOx < endNoOx) {
										
									} else {
										
									}
								}
								questionMap = courseSeqMapper.selectOrderedQuestions(paramMap);
							}
							*/
							int page = 1;
							if (questionMap.keySize("idQ") > 0) {
								Map<String, Object> paramMap2 = null;
								for(int j=0; j<questionMap.keySize("idQ"); j++) {
									paramMap2 = new HashMap<String, Object>();
									paramMap2.put("idExam", paramMap.get("idExam"));
									paramMap2.put("examUnit", 1);
									paramMap2.put("idSubject", paramMap.get("idSubject"));
									paramMap2.put("nrSet", i);
									paramMap2.put("nrQ", questionMap.getInt("nrQ", j));
									paramMap2.put("idQ", questionMap.getInt("idQ", j));
									paramMap2.put("exOrder", questionMap.getString("exOrder", j));
									switch (questionMap.getInt("idQtype", j)) {
									case 1:
										paramMap2.put("allotting", oxWeight);
										break;
									case 2:
										paramMap2.put("allotting", choiceWeight);
										break;
									case 3:
										paramMap2.put("allotting", multiAnsWeight);
										break;
									case 4:
										paramMap2.put("allotting", shortAnsWeight);
										break;
									case 5:
										paramMap2.put("allotting", essayWeight);
										break;
										default:
											paramMap2.put("allotting", 0);
											break;
									}
									if (requestMap.getInt("qcntperpage") == 1) {
										paramMap2.put("page", questionMap.getInt("nrQ", j));
									} else if (requestMap.getInt("qcntperpage") > 1) {
//										paramMap2.put("page", (questionMap.getInt("nrQ", j) / requestMap.getInt("qcntperpage")) + 1);
										paramMap2.put("page", page);
										if(questionMap.getInt("nrQ", j) % requestMap.getInt("qcntperpage")  == 0){
											page++;
										}
									} else {
										paramMap2.put("page", questionMap.getInt("nrQ", j));
									}
									
									result = courseSeqMapper.insertQuestionIntoPaper(paramMap2);
									int qCnt = 0;
									if (result > 0) {
										qCnt = courseSeqMapper.selectExamQCnt(paramMap2);
										if (qCnt == 0) {
											result = courseSeqMapper.insertQuestionIntoQ(paramMap2);
										}
									} else {
										result = 0;
										TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
										break;
									}
								}
							} else {
								result = 0;
								TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
								break;
							}
						}
					}
				} else {
					result = 0;
					TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
				}
			} else {
				result = 0;
				TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			}
		} catch (SQLException e) {
			throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
		return result;
	}

	@Transactional
	public int updateExam(DataMap requestMap) throws BizException {
		int result = 0;
		Map<String, Object> paramMap = null;
		
		try {
			paramMap = new HashMap<String, Object>();
			paramMap.put("idCompany", "10034");
			paramMap.put("idExam", requestMap.getString("idExam"));
			DataMap chapterMap = questionMgrMapper.selectChapter(requestMap.getString("subj"));
			paramMap.put("idCourse", chapterMap.getString("idCourse"));
			paramMap.put("courseYear", requestMap.getString("grcode"));
			paramMap.put("courseNo", requestMap.getString("grseq"));
			paramMap.put("title", requestMap.getString("title"));
			int idExamKind = 0;
			if (requestMap.getString("ptype").equals("T")) {
				idExamKind = 0;
			} else if (requestMap.getString("ptype").equals("M")) {
				idExamKind = 1;
			} else if (requestMap.getString("ptype").equals("1")) {
				idExamKind = 2;
			} else if (requestMap.getString("ptype").equals("2")) {
				idExamKind = 3;
			} else if (requestMap.getString("ptype").equals("3")) {
				idExamKind = 4;
			} else if (requestMap.getString("ptype").equals("4")) {
				idExamKind = 5;
			} else if (requestMap.getString("ptype").equals("5")) {
				idExamKind = 6;
			}
			paramMap.put("idExamKind", idExamKind);
			StringBuffer sb = new StringBuffer();
			sb.append(requestMap.getString("examStart1Date")).append(requestMap.getString("examStart1Time"));
			paramMap.put("examStart1", sb.toString());
			sb = new StringBuffer();
			sb.append(requestMap.getString("examEnd1Date")).append(requestMap.getString("examEnd1Time"));
			paramMap.put("examEnd1", sb.toString());
			paramMap.put("idAuthType", 1);
			paramMap.put("ynOpenScoreDirect", "N");
			paramMap.put("userid", requestMap.getString("userno"));
			paramMap.put("logOption", "B");
			paramMap.put("onoffType", requestMap.getString("onoff"));
			result = courseSeqMapper.updateExamM(paramMap);
			
			if (result > 0) {
				result = 0;
				paramMap.put("examUnit", 1);
				paramMap.put("title", "1교시");
				paramMap.put("userRptFormat", "hwp,doc,xls,ppt,mdb,gul,txt,jpg,psd,gif,tif,zip,arj,rar");
				paramMap.put("idLtimetype", "T");
				paramMap.put("idMovepage", "F");
				paramMap.put("ynStartstop", "N");
				paramMap.put("ynSavetemp", "Y");
				paramMap.put("ynViewas", "Y");
				paramMap.put("ynViewhint", "N");
				paramMap.put("qcntperpage", requestMap.getInt("qcntperpage"));
				paramMap.put("idExlabel", 11);
				paramMap.put("fontname", "굴림");
				paramMap.put("fontsize", 11);
				paramMap.put("paperType", 11);
				result = courseSeqMapper.updateExamUnit(paramMap);
				if (result > 0) {
					result = 0;
					paramMap.put("idSubject", chapterMap.getString("idSubject"));
					paramMap.put("subjectOrder", 1);
					paramMap.put("subjGroup", 0);
					paramMap.put("limittime", requestMap.getInt("limittime")*60);
					paramMap.put("qcount", requestMap.getInt("totalCnt"));
					int oxCnt = 0; double oxWeight = 0, oxCalc = 0;
					int choiceCnt = 0; double choiceWeight = 0, choiceCalc = 0;
					int multiAnsCnt = 0; double multiAnsWeight = 0, multiAnsCalc = 0;
					int shortAnsCnt = 0; double shortAnsWeight = 0, shortAnsCalc = 0;
					int essayCnt = 0; double essayWeight = 0, essayCalc = 0;
					for(int i=0; i<requestMap.keySize("qtype[]"); i++) {
						switch (requestMap.getInt("qtype[]",i)) {
						case 1:
							oxCnt = requestMap.getInt("oxCnt");
							oxWeight = requestMap.getDouble("oxWeight");
							oxCalc = requestMap.getDouble("oxCalc");
							break;
						case 2:
							choiceCnt = requestMap.getInt("choiceCnt");
							choiceWeight = requestMap.getDouble("choiceWeight");
							choiceCalc = requestMap.getDouble("choiceCalc");
							break;
						case 3:
							multiAnsCnt = requestMap.getInt("multiAnsCnt");
							multiAnsWeight = requestMap.getDouble("multiAnsWeight");
							multiAnsCalc = requestMap.getDouble("multiAnsCalc");
							break;
						case 4:
							shortAnsCnt = requestMap.getInt("shortAnsCnt");
							shortAnsWeight = requestMap.getDouble("shortAnsWeight");
							shortAnsCalc = requestMap.getDouble("shortAnsCalc");
							break;
						case 5:
							essayCnt = requestMap.getInt("essayCnt");
							essayWeight = requestMap.getDouble("essayWeight");
							essayCalc = requestMap.getDouble("essayCalc");
							break;
							default:
								break;
						}
					}
					paramMap.put("oxCnt", oxCnt);
					paramMap.put("oxWeight", oxWeight);
					paramMap.put("oxCalc", oxCalc);
					paramMap.put("choiceCnt", choiceCnt);
					paramMap.put("choiceWeight", choiceWeight);
					paramMap.put("choiceCalc", choiceCalc);
					paramMap.put("multiAnsCnt", multiAnsCnt);
					paramMap.put("multiAnsWeight", multiAnsWeight);
					paramMap.put("multiAnsCalc", multiAnsCalc);
					paramMap.put("shortAnsCnt", shortAnsCnt);
					paramMap.put("shortAnsWeight", shortAnsWeight);
					paramMap.put("shortAnsCalc", shortAnsCalc);
					paramMap.put("essayCnt", essayCnt);
					paramMap.put("essayWeight", essayWeight);
					paramMap.put("essayCalc", essayCalc);
					paramMap.put("allotting", requestMap.getDouble("totalCalc"));
					paramMap.put("idRandomtype", requestMap.getString("idRandomtype"));
					int examCount = requestMap.getInt("selExamCount");
					paramMap.put("setcount", examCount);
					paramMap.put("ynChapterStat", "N");
					paramMap.put("scoringDate", "");
					paramMap.put("manScoringEnd", "");
					paramMap.put("ynDisplayMsg", "N");
				    
					result = courseSeqMapper.updateExamSubject(paramMap);
					if (result > 0) {
						courseSeqMapper.deleteQuestionFromPaper(paramMap);
						courseSeqMapper.deleteQuestionFromQ(paramMap);
						
						paramMap.put("idChapter", chapterMap.getString("idChapter"));
						DataMap questionMap = new DataMap();
						for(int i=1; i<=examCount; i++) {
							questionMap = courseSeqMapper.selectRandomQuestions(paramMap);
							
							if (questionMap.keySize("idQ") > 0) {
								Map<String, Object> paramMap2 = null;
								for(int j=0; j<questionMap.keySize("idQ"); j++) {
									paramMap2 = new HashMap<String, Object>();
									paramMap2.put("idExam", paramMap.get("idExam"));
									paramMap2.put("examUnit", 1);
									paramMap2.put("idSubject", paramMap.get("idSubject"));
									paramMap2.put("nrSet", i);
									paramMap2.put("nrQ", questionMap.getInt("nrQ", j));
									paramMap2.put("idQ", questionMap.getInt("idQ", j));
									paramMap2.put("exOrder", questionMap.getString("exOrder", j));
									switch (questionMap.getInt("idQtype", j)) {
									case 1:
										paramMap2.put("allotting", oxWeight);
										break;
									case 2:
										paramMap2.put("allotting", choiceWeight);
										break;
									case 3:
										paramMap2.put("allotting", multiAnsWeight);
										break;
									case 4:
										paramMap2.put("allotting", shortAnsWeight);
										break;
									case 5:
										paramMap2.put("allotting", essayWeight);
										break;
										default:
											paramMap2.put("allotting", 0);
											break;
									}
									if (requestMap.getInt("qcntperpage") == 1) {
										paramMap2.put("page", questionMap.getInt("nrQ", j));
									} else if (requestMap.getInt("qcntperpage") > 1) {
										paramMap2.put("page", (questionMap.getInt("nrQ", j) / requestMap.getInt("qcntperpage")) + 1);
									} else {
										paramMap2.put("page", questionMap.getInt("nrQ", j));
									}
									
									result = courseSeqMapper.insertQuestionIntoPaper(paramMap2);
									int qCnt = 0;
									if (result > 0) {
										qCnt = courseSeqMapper.selectExamQCnt(paramMap2);
										if (qCnt == 0) {
											result = courseSeqMapper.insertQuestionIntoQ(paramMap2);
										}
									} else {
										result = 0;
										TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
										break;
									}
								}
							} else {
								result = 0;
								TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
								break;
							}
						}
					}
				} else {
					result = 0;
					TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
				}
			} else {
				result = 0;
				TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			}
		} catch (SQLException e) {
			throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
		return result;
	}
	
	
	
	@Transactional
	public int updateExamDate(DataMap requestMap) throws BizException {
		int result = 0;
		Map<String, Object> paramMap = null;
		
		try {
			paramMap = new HashMap<String, Object>();
			paramMap.put("idCompany", "10034");
			paramMap.put("idExam", requestMap.getString("idExam"));			
			
			StringBuffer sb = new StringBuffer();
			
			sb.append(requestMap.getString("examStart1Date")).append(requestMap.getString("examStart1Time"));
			paramMap.put("examStart1", sb.toString());
			sb = new StringBuffer();
			sb.append(requestMap.getString("examEnd1Date")).append(requestMap.getString("examEnd1Time"));
			paramMap.put("examEnd1", sb.toString());
			paramMap.put("ynOpenScoreDirect", "N");
			paramMap.put("userid", requestMap.getString("userno"));
			paramMap.put("logOption", "B");
			result = courseSeqMapper.updateExamDate(paramMap);
			
		} catch (SQLException e) {
			throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
		return result;
	}

	public DataMap selectExamPaperBySet(DataMap requestMap) throws BizException {
		DataMap resultMap = new DataMap();
		
		try {
			resultMap = courseSeqMapper.selectExamPaperBySet(requestMap);
		} catch (SQLException e) {
			throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
		return resultMap;
	}
	
	public DataMap selectOffExamPaperBySet(DataMap requestMap) throws BizException {
		DataMap resultMap = new DataMap();
		
		try {
			resultMap = courseSeqMapper.selectOffExamPaperBySet(requestMap);
		} catch (SQLException e) {
			throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
		return resultMap;
	}

	public int updateYNEnable(DataMap requestMap) throws BizException {
		int result = 0;
		
		try {
			result = courseSeqMapper.updateYNEnable(requestMap);
		} catch (SQLException e) {
			throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
		return result;
	}

	public DataMap selectSubjSeq(Map<String, Object> paramMap) throws BizException {
		DataMap resultMap = new DataMap();
		
		try {
			resultMap = courseSeqMapper.selectSubjSeq(paramMap);
		} catch (SQLException e) {
			throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
		return resultMap;
	}

	public String selectIDExamFromDual(String idCompany) throws BizException {
		String result = "";
		
		try {
			result = courseSeqMapper.selectIdExamFromDual(idCompany);
		} catch (SQLException e) {
			throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
		return result;
	}

	@Transactional
	public int updateOffExamInfo(DataMap requestMap, DataMap rowMap)  throws BizException {
		int result = 0;
		Map<String, Object> paramMap = new HashMap<String, Object>();
		
		try {
			paramMap.put("idExam", requestMap.getString("idExam"));
			paramMap.put("title", requestMap.getString("title"));
			paramMap.put("userid", requestMap.getString("userid"));
			result = courseSeqMapper.updateOffExamM(paramMap);
			
			if (result > 0) {
				result = 0;
				paramMap.put("idSubject", rowMap.getString("idSubject"));
				paramMap.put("qcount", requestMap.getString("qcount"));
				paramMap.put("allotting", requestMap.getString("allotting"));
				paramMap.put("setcount", requestMap.getInt("setcount")+1);
				paramMap.put("afile", rowMap.getString("afile"));
				paramMap.put("afileRn", rowMap.getString("afileRn"));
				result = courseSeqMapper.updateOffExamSubject(paramMap);
			} else {
				TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			}
		} catch (SQLException e) {
			throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
		return result;
	}

	@Transactional
	public int insertOffExamInfo(DataMap requestMap, DataMap rowMap) throws BizException {
		int result = 0;
		Map<String, Object> paramMap = null;
		
		try {
			paramMap = new HashMap<String, Object>();
			String idExam = courseSeqMapper.selectIdExamFromDual(requestMap.getString("idCompany"));
			paramMap.put("idExam", idExam);
			paramMap.put("idCourse", rowMap.getString("idCourse"));
			paramMap.put("courseYear", requestMap.getString("grcode"));
			paramMap.put("courseNo", requestMap.getString("grseq"));
			paramMap.put("title", requestMap.getString("title"));
			paramMap.put("idCompany", requestMap.getString("idCompany"));
			paramMap.put("userid", requestMap.getString("userid"));
			paramMap.put("onoffType", requestMap.getString("M"));
			
			result = courseSeqMapper.insertOffExamM(paramMap);
			
			if (result > 0) {
				result = 0;
				result = courseSeqMapper.insertOffExamUnit(paramMap);
				
				if (result > 0) {
					result = 0;
					paramMap.put("idSubject", rowMap.getString("idSubject"));
					paramMap.put("qcount", requestMap.getString("qcount"));
					paramMap.put("allotting", requestMap.getString("allotting"));
					paramMap.put("setcount", requestMap.getInt("setcount")+1);
					paramMap.put("afile", rowMap.getString("afile"));
					paramMap.put("afileRn", rowMap.getString("afileRn"));
					
					result = courseSeqMapper.insertOffExamSubject(paramMap);
				} else {
					TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
				}
			} else {
				TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			}
		} catch (SQLException e) {
			throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
		return result;
	}

	public String selectIdExamFromDual(String idCompany) throws BizException {
		String result = "";
		
		try {
			result = courseSeqMapper.selectIdExamFromDual(idCompany);
		} catch (SQLException e) {
			throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
		return result;
	}
	
	public int deleteQuestionFromPaper(Map<String, Object> paramMap) throws BizException {
		int result = 0;
		
		try {
			result = courseSeqMapper.deleteQuestionFromPaper(paramMap);
		} catch (SQLException e) {
			throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
		return result;
	}

	public int deleteQuestionFromQ(Map<String, Object> paramMap) throws BizException {
		int result = 0;
		
		try {
			result = courseSeqMapper.deleteQuestionFromQ(paramMap);
		} catch (SQLException e) {
			throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
		return result;
	}

	public DataMap selectOffExamQuestion(DataMap requestMap, DataMap rowMap) throws BizException {
		DataMap resultMap = new DataMap();
		
		try {
			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("idCourse", rowMap.getString("idCourse"));
			paramMap.put("idSubject", rowMap.getString("idSubject"));
			paramMap.put("grcode", requestMap.getString("grcode"));
			paramMap.put("grseq", requestMap.getString("grseq"));
			
			resultMap = courseSeqMapper.selectOffExamQuestion(paramMap);
		} catch (SQLException e) {
			throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
		return resultMap;
	}

	public int insertQuestionIntoPaper(Map<String, Object> paramMap2) throws BizException {
		int result = 0;
		
		try {
			result = courseSeqMapper.insertQuestionIntoPaper(paramMap2);
		} catch (SQLException e) {
			throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
		return result;
	}

	public int selectExamQCnt(Map<String, Object> paramMap2) throws BizException {
		int result = 0;
		
		try {
			result = courseSeqMapper.selectExamQCnt(paramMap2);
		} catch (SQLException e) {
			throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
		return result;
	}

	public int insertQuestionIntoQ(Map<String, Object> paramMap2) throws BizException {
		int result = 0;
		
		try {
			result = courseSeqMapper.insertQuestionIntoQ(paramMap2);
		} catch (SQLException e) {
			throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
		return result;
	}

	@Transactional
	public int deleteExam(String idExam) throws BizException {
		int result = 0;
		
		try {
			result = courseSeqMapper.deleteExamM(idExam);
			if (result > 0) {
				result = 0;
				result = courseSeqMapper.deleteExamUnit(idExam);
				if (result > 0) {
					result = 0;
					result = courseSeqMapper.deleteExamSubject(idExam);
					if (result > 0) {
						result = 0;
						result = courseSeqMapper.deleteExamPaper(idExam);
						if (result > 0) {
							result = 0;
							result = courseSeqMapper.deleteExamQ(idExam);
						} else {
							result = 0;
							TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
						}
					} else {
						result = 0;
						TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
					}
				} else {
					result = 0;
					TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
				}
			} else {
				result = 0;
				TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			}
		} catch (SQLException e) {
			result = 0;
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
		
		return result;
	}

	public DataMap selectEvalSubjectList(DataMap requestMap) throws BizException {
		DataMap resultMap = new DataMap();
		
		try {
			resultMap = courseSeqMapper.selectEvalSubjectList(requestMap);
		} catch (SQLException e) {
			throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
		return resultMap;
	}

	@Transactional
	public int deleteOffExam(String idExam) throws BizException {
		int result = 0;
		
		try {
			result = courseSeqMapper.deleteOffExamQ(idExam);
			result = courseSeqMapper.deleteOffExamPaper(idExam);
			result = courseSeqMapper.deleteOffExamSubject(idExam);
			result = courseSeqMapper.deleteOffExamUnit(idExam);
			result = courseSeqMapper.deleteOffExamM(idExam);
			result = 1;
		} catch (SQLException e) {
			result = 0;
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
		
		return result;
	}

	public DataMap selectMainChapterBySubj(String subj) throws BizException {
		DataMap resultMap = new DataMap();
		
		try {
			resultMap = courseSeqMapper.selectMainChapterBySubj(subj);
		} catch (SQLException e) {
			throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
		
		return resultMap;
	}
	
	public DataMap selectSubChapterBySubj(String mainSubj, String subSubj, String idChapter) throws BizException {
		DataMap resultMap = new DataMap();
		
		try {
			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("mainSubj", mainSubj);
			paramMap.put("subSubj", subSubj);
			paramMap.put("idChapter", idChapter);
			resultMap = courseSeqMapper.selectSubChapterBySubj(paramMap);
		} catch (SQLException e) {
			throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
		
		return resultMap;
	}

	public DataMap selectChapterByIdExam(String idExam, String subj) throws BizException {
		DataMap resultMap = new DataMap();
		
		try {
			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("idExam", idExam);
			paramMap.put("subj", subj);
			resultMap = courseSeqMapper.selectChapterByIdExam(paramMap);
		} catch (SQLException e) {
			throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
		
		return resultMap;
	}

	public int insertMainChapter(String subj, String idCompany) throws BizException {
		int result = 0;
		
		try {
			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("idCourse", subj);
			paramMap.put("idSubject", subj);
			paramMap.put("idChapter", questionMgrMapper.selectIdChapterFromDual(idCompany));
			paramMap.put("chapter", courseSeqMapper.selectSubjnm(subj));
			paramMap.put("chapterOrder", 1);
			paramMap.put("courseCode", subj);
			result = questionMgrMapper.insertChapter2(paramMap);
		} catch (SQLException e) {
			throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
		
		return result;
	}

	public int insertSubChapter(String subj, String subjCd, String idChapter, String grseq, String idCompany) throws BizException {
		int result = 0;
		
		try {
			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("idCourse", subj);
			paramMap.put("idSubject", subj);
			paramMap.put("idChapter", idChapter);
			StringBuffer sb = new StringBuffer();
			sb.append(courseSeqMapper.selectSubjnm(subjCd)).append("(").append(grseq).append(")");
			paramMap.put("chapter", sb.toString());
			paramMap.put("chapterOrder", 1);
			paramMap.put("courseCode", subjCd);
			result = questionMgrMapper.insertChapter2(paramMap);
		} catch (SQLException e) {
			throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
		
		return result;
	}

	public int deleteOffQuestions(Map<String, Object> paramMap) throws BizException {
		int result = 0;
		
		try {
			result = courseSeqMapper.deleteOffQuestions(paramMap);
		} catch (SQLException e) {
			result = 0;
			throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
		return result;
	}

	@Transactional
	public int deleteOffQuestionSet(DataMap chapterMap) throws BizException {
		int result = 0;
		
		try {
			for(int i=0; i<chapterMap.keySize("idChapter"); i++) {
				result = courseSeqMapper.deleteOffQ(chapterMap.getString("idChapter", i));
				result = courseSeqMapper.deleteOffChapter(chapterMap.getString("idChapter", i));
			}
			result = 1;
		} catch (SQLException e) {
			result = 0;
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
		return result;
	}
}
