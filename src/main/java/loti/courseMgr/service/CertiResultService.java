package loti.courseMgr.service;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import loti.courseMgr.mapper.CertiResultMapper;
import loti.courseMgr.mapper.LectureApplyMapper;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ut.lib.exception.BizException;
import ut.lib.page.PageNavigation;
import ut.lib.support.DataMap;
import ut.lib.util.Constants;
import ut.lib.util.Message;
import ut.lib.util.Util;
import common.service.BaseService;

@Service
public class CertiResultService extends BaseService {

	@Autowired
	private CertiResultMapper certiResultMapper;
	@Autowired
	private LectureApplyMapper lectureApplyMapper;
	
	/**
	 * 과정 기수 수료자 목록
	 */
	public DataMap selectGrResultByAllList(DataMap requestMap) throws BizException{
		DataMap resultMap = new DataMap();
        
        try {
        	String grcode = requestMap.getString("commGrcode");
    		String grseq = requestMap.getString("commGrseq");
    		
    		String searchStr = ""; //검색 조건
    		String orderStr = ""; //정렬 조건
    		if(!requestMap.getString("searchDept").equals(""))
    			searchStr += " AND GRR.RDEPT = '" + requestMap.getString("searchDept") + "' ";

    		if(!requestMap.getString("searchRgrayn").equals(""))
    			searchStr += " AND GRR.RGRAYN = '" + requestMap.getString("searchRgrayn") + "' ";
    		
    		if(!requestMap.getString("searchName").equals(""))
    			searchStr += " AND GRR.RNAME LIKE '%" + requestMap.getString("searchName") + "%' ";
    		
    		if(requestMap.getString("searchOrder").equals("DEPT"))
    			orderStr = " ORDER BY DECODE(GRR.RDEPT,6280000,1,6280053,2,3490000,3,3500000,4,3510000,5,3520000,6,3530000,7,3540000,8,3550000,9,3560000,10,3570000,11,3580000,12,6289999,13,14), GRR.RNAME";
    		else if(requestMap.getString("searchOrder").equals("JIK"))
    			orderStr = " ORDER BY JK.JIKNM, GRR.RNAME ";
    		else if(requestMap.getString("searchOrder").equals("NAME"))
    			orderStr = " ORDER BY GRR.RNAME ";
    		else if(requestMap.getString("searchOrder").equals("PACCEPT"))
    			orderStr = " ORDER BY GRR.PACCEPT, GRR.RNAME  ";
    		else
    			orderStr = " ORDER BY DECODE(GRR.RDEPT,6280000,1,6280053,2,3490000,3,3500000,4,3510000,5,3520000,6,3530000,7,3540000,8,3550000,9,3560000,10,3570000,11,3580000,12,6289999,13,14), GRR.RNAME";
    			// orderStr = " ORDER BY GRR.RDEPT, GRR.RNAME  ";
    		
    		Map<String, Object> paramMap = new HashMap<String, Object>();
    		paramMap.put("grcode", grcode);
    		paramMap.put("grseq", grseq);
    		paramMap.put("searchStr", searchStr);
    		paramMap.put("orderStr", orderStr);
    		
            resultMap = certiResultMapper.selectGrResultByAllList(paramMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;
	}
	
	/**
	 * 과정 기수의 수료자 목록
	 * (교육수료증/상장발급 리스트용)
	 */
	public DataMap selectGrResultByAllCertiList(DataMap requestMap) throws BizException{
		DataMap resultMap = new DataMap();
        
        try {
        	String grcode = requestMap.getString("commGrcode");
    		String grseq = requestMap.getString("commGrseq");
    		
    		String searchStr = ""; //검색 조건
    		String orderStr = ""; //정렬 조건

    		searchStr += "	AND GRR.RGRAYN = 'Y' ";
    		
    		if(requestMap.getString("searchOrder").equals("seqno"))
    			orderStr = " ORDER BY GRR.SEQNO ASC, GRR.PACCEPT DESC ";
    		else if(requestMap.getString("searchOrder").equals("dept"))
    			orderStr = " ORDER BY DECODE(GRR.RDEPT,6280000,1,6280053,2,3490000,3,3500000,4,3510000,5,3520000,6,3530000,7,3540000,8,3550000,9,3560000,10,3570000,11,3580000,12,6289999,13,14), GRR.RNAME ";
    		else
    			orderStr = "  ORDER BY GRR.EDUNO ASC  ";
    		
    		Map<String, Object> paramMap = new HashMap<String, Object>();
    		paramMap.put("grcode", grcode);
    		paramMap.put("grseq", grseq);
    		paramMap.put("searchStr", searchStr);
    		paramMap.put("orderStr", orderStr);
    		
            resultMap = certiResultMapper.selectGrResultByAllList(paramMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;
	}
	
	
	/**
	 * 과정 기수 수료자 목록
	 */
	public DataMap selectGrResultByAllNotSearchList(String grcode, String grseq) throws BizException{
		DataMap resultMap = new DataMap();
        
        try {
        	Map<String, Object> paramMap = new HashMap<String, Object>();
    		paramMap.put("grcode", grcode);
    		paramMap.put("grseq", grseq);
    		
        	resultMap = certiResultMapper.selectGrResultByAllNotSearchList(paramMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;
	}
	
	/**
	 * 과정 기수의 수료자 인원 조회
	 */
	public DataMap selectGrResultCompletionCntRow(String grcode, String grseq) throws BizException{
		DataMap resultMap = new DataMap();
        
        try {
        	Map<String, Object> paramMap = new HashMap<String, Object>();
    		paramMap.put("grcode", grcode);
    		paramMap.put("grseq", grseq);
    		
        	resultMap = certiResultMapper.selectGrResultCompletionCntRow(paramMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;
	}
	
	/**
	 * 과정기수 수료자의 부서 리스트
	 */
	public DataMap selectGrResultDeptList(String grcode, String grseq) throws BizException{
		DataMap resultMap = new DataMap();
        
        try {
        	Map<String, Object> paramMap = new HashMap<String, Object>();
    		paramMap.put("grcode", grcode);
    		paramMap.put("grseq", grseq);
    		
        	resultMap = certiResultMapper.selectGrResultDeptList(paramMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;
	}
	
	/**
	 * 기수 수료자 일괄 상장번호 삭제
	 */
	public int updateGrResultByAllRawardnoNull(String grcode, String grseq) throws BizException{
		int returnValue = 0;
        
        try {
        	Map<String, Object> paramMap = new HashMap<String, Object>();
    		paramMap.put("grcode", grcode);
    		paramMap.put("grseq", grseq);
    		
        	returnValue = certiResultMapper.updateGrResultByAllRawardnoNull(paramMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return returnValue;        
	}
	
	/**
	 * 기수 수료자 수료번호 삭제
	 */
	public int updateGrResultByAllRnoNull(String grcode, String grseq) throws BizException{
		int returnValue = 0;
        
        try {
        	Map<String, Object> paramMap = new HashMap<String, Object>();
    		paramMap.put("grcode", grcode);
    		paramMap.put("grseq", grseq);
    		
        	returnValue = certiResultMapper.updateGrResultByAllRnoNull(paramMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return returnValue;        
	}
	
	/**
	 * 수료 번호 일괄 재생성.
	 */
	public int updateGrResultByGrseqAllRno(String grcode, String grseq, int certino) throws BizException{
		int returnValue = 0;
        
        try {
        	//수료자 추출
        	Map<String, Object> paramMap = new HashMap<String, Object>();
    		paramMap.put("grcode", grcode);
    		paramMap.put("grseq", grseq);
    		
            DataMap resultMap = certiResultMapper.selectGrResultSimpleList(paramMap);
            if(resultMap == null) resultMap = new DataMap();
            resultMap.setNullToInitialize(true);
            
            //수료자 추출
            for(int i=0; i < resultMap.keySize("userno"); i++){
            	//수료 번호 등록
            	paramMap = new HashMap<String, Object>();
            	paramMap.put("grcode", grcode);
        		paramMap.put("grseq", grseq);
        		paramMap.put("userno", resultMap.getString("userno", i));
        		paramMap.put("rno", Integer.toString(certino));
        		
            	certiResultMapper.updateGrResultByRno(paramMap);
            	
            	returnValue++;
            	certino++;
            }
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return returnValue;        
	}
	
	/**
	 * 상장번호 등록
	 */
	public int updateGrResultRawardNo(DataMap requestMap) throws BizException{
		int returnValue = 0;
        
        try {
        	String grcode = requestMap.getString("grcode");
            String grseq = requestMap.getString("grseq");
            int rawardno = requestMap.getInt("rawardno");
            
            Map<String, Object> paramMap = null;
            //수료자 추출
            for(int i=0; i < requestMap.keySize("chkUserno[]"); i++){
            	System.out.println("\n userno[]" + i + "=" + requestMap.getString("chkUserno[]", i));
            	//상장번호 확인.
            	paramMap = new HashMap<String, Object>();
            	paramMap.put("grcode", grcode);
        		paramMap.put("grseq", grseq);
        		paramMap.put("userno", requestMap.getString("chkUserno[]", i));
        		
            	int tmpResult = certiResultMapper.selectGrResultByUserRawardNoChk(paramMap);
            	
            	//상장번호가 등록되어있지 않다면 
            	if(tmpResult == 0) {
            		paramMap.put("rawardno", Integer.toString(rawardno));
            		certiResultMapper.updateGrResultByRawardNo(paramMap);
            	} else
            		continue;
            	
            	rawardno++;
            }
            returnValue++;
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return returnValue;        
	}
	
	/**
	 * 시스템에 기록된 상장 부여번호를 조회후 최고 상장 번호를 가져옴.
	 */
	public int selectGrResultNextRawardNo(String year) throws BizException{
		int returnValue = 0;
        
        try {
        	year = year + "__";
        	returnValue = certiResultMapper.selectGrResultNextRawardNo(year); //시스템의 최고 상장 번호
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return returnValue;        
	}
	
	/**
	 * 수료자 검색
	 */
	public DataMap selectGrResultListBySearch(String searchName, String sessClass, String sessDept, String ldapcode) throws BizException{
		DataMap resultMap = new DataMap();
        
        try {
        	String whereStr = "";
            
            if(sessClass.equals(Constants.ADMIN_SESS_CLASS_DEPT))
            	whereStr += " AND GRR.RDEPT = '" + sessDept + "' ";
            	
            if(!searchName.equals(""))
            	whereStr += "   AND GRR.RNAME LIKE '"+searchName+"%'   ";
            
		    if("6289999".equals(sessDept)) {
		    	whereStr += "  AND MB.LDAPCODE = '" + ldapcode + "'  ";
            }
            
		    Map<String, Object> paramMap = new HashMap<String, Object>();
		    paramMap.put("whereStr", whereStr);
		    
            resultMap = certiResultMapper.selectGrResultListBySearch(paramMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;
	}
	
	/**
	 * 수료자 수료 내역 조회
	 */
	public DataMap selectGrResultListByUserno(String userno, String sessClass, String sessDept) throws BizException{
		DataMap resultMap = new DataMap();
        
        try {
        	String whereStr = "";
            
            if(sessClass.equals(Constants.ADMIN_SESS_CLASS_DEPT))
            	whereStr += " AND GRR.RDEPT = '" + sessDept + "' ";
            	
            Map<String, Object> paramMap = new HashMap<String, Object>();
        	paramMap.put("userno", userno);
    		paramMap.put("whereStr", whereStr);
    		
            resultMap = certiResultMapper.selectGrResultListByUserno(paramMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;
	}
	
	/**
	 * 수료자 수료 내역 조회 기관별 조회
	 */
	public DataMap selectGrResultListByDept(DataMap requestMap, String ldapcode, String dept) throws BizException{
		DataMap resultMap = new DataMap();
        
        try {
        	//String grcode = requestMap.getString("commGrcode");
    		String grseq = requestMap.getString("commGrseq");
    		
    		String searchStr = ""; //검색 조건
    		
    		if(!requestMap.getString("searchDept").equals(""))
    			searchStr += " AND GRR.RDEPT = '" + requestMap.getString("searchDept") + "' ";

    		if(!requestMap.getString("searchRgrayn").equals(""))
    			searchStr += " AND GRR.RGRAYN = '" + requestMap.getString("searchRgrayn") + "' ";
		    if("6289999".equals(dept)) {
		    	searchStr += "  AND M.LDAPCODE = '" + ldapcode + "'  ";
            }
    		
		    if(!requestMap.getString("commGrcode").equals(""))
    			searchStr += " AND GRR.GRCODE = '" + requestMap.getString("commGrcode") + "' ";
		    System.out.println("searchStr: " + searchStr);
		    Map<String, Object> paramMap = new HashMap<String, Object>();
        	paramMap.put("grseq", grseq);
    		paramMap.put("searchStr", searchStr);
    		
            resultMap = certiResultMapper.selectGrResultListByDept(paramMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;
	}
	
	/**
	 * 과정 기수 수료자 목록 (사이버)
	 */
	public DataMap selectGrResultByAllListForCyber(DataMap requestMap) throws BizException{
		DataMap resultMap = new DataMap();
        
        try {
        	String grcode = requestMap.getString("commGrcode");
    		String grseq = requestMap.getString("commGrseq");
    		
    		String searchStr = ""; //검색 조건
    		String orderStr = ""; //정렬 조건
    		if(!requestMap.getString("searchDept").equals(""))
    			searchStr += " AND GRR.RDEPT = '" + requestMap.getString("searchDept") + "' ";

    		if(!requestMap.getString("searchRgrayn").equals(""))
    			searchStr += " AND GRR.RGRAYN = '" + requestMap.getString("searchRgrayn") + "' ";
    		
    		if(!requestMap.getString("searchName").equals(""))
    			searchStr += " AND GRR.RNAME LIKE '%" + requestMap.getString("searchName") + "%' ";
    		
    		if(requestMap.getString("searchOrder").equals("DEPT"))
    			orderStr = " ORDER BY GRR.RDEPT, GRR.RNAME ";
    		else if(requestMap.getString("searchOrder").equals("JIK"))
    			orderStr = " ORDER BY JK.JIKNM, GRR.RNAME ";
    		else if(requestMap.getString("searchOrder").equals("NAME"))
    			orderStr = " ORDER BY GRR.RNAME ";
    		else if(requestMap.getString("searchOrder").equals("PACCEPT"))
    			orderStr = " ORDER BY GRR.PACCEPT, GRR.RNAME  ";
    		else
    			orderStr = " ORDER BY GRR.RDEPT, GRR.RNAME  ";
    		
    		if(!grcode.equals(""))
    			searchStr += " AND GRR.GRCODE = '" + grcode + "' ";
    		
    		Map<String, Object> paramMap = new HashMap<String, Object>();
        	paramMap.put("grseq", grseq);
    		paramMap.put("searchStr", searchStr);
    		paramMap.put("orderStr", orderStr);
    		
    		int grResultByAllListForCyber = certiResultMapper.selectGrResultByAllListForCyberCount(paramMap);
    		
    		Map<String, Object> pageInfo = Util.getPageInfo(grResultByAllListForCyber, requestMap);
        	pageInfo.put("grseq", grseq);
			pageInfo.put("searchStr", searchStr);
			pageInfo.put("orderStr", orderStr);
			
            resultMap = certiResultMapper.selectGrResultByAllListForCyber(pageInfo);
            
            PageNavigation pageNavi = Util.getPageNavigation(pageInfo);
			
			resultMap.set("PAGE_INFO", pageNavi);
			
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;
	}
	
	/**
	 * 과정 기수 수료자 목록 (사이버)
	 */
	public DataMap selectGrResultByAllListForCyber2(DataMap requestMap) throws BizException{
		DataMap resultMap = new DataMap();
        
        try {
        	String grcode = requestMap.getString("commGrcode");
    		String grseq = requestMap.getString("commGrseq");
    		
    		String searchStr = ""; //검색 조건
    		String orderStr = ""; //정렬 조건
    		if(!requestMap.getString("searchDept").equals(""))
    			searchStr += " AND GRR.RDEPT = '" + requestMap.getString("searchDept") + "' ";

    		if(!requestMap.getString("searchRgrayn").equals(""))
    			searchStr += " AND GRR.RGRAYN = '" + requestMap.getString("searchRgrayn") + "' ";
    		
    		if(!requestMap.getString("searchName").equals(""))
    			searchStr += " AND GRR.RNAME LIKE '%" + requestMap.getString("searchName") + "%' ";
    		
    		if(requestMap.getString("searchOrder").equals("DEPT"))
    			orderStr = " ORDER BY GRR.RDEPT, GRR.RNAME ";
    		else if(requestMap.getString("searchOrder").equals("JIK"))
    			orderStr = " ORDER BY JK.JIKNM, GRR.RNAME ";
    		else if(requestMap.getString("searchOrder").equals("NAME"))
    			orderStr = " ORDER BY GRR.RNAME ";
    		else if(requestMap.getString("searchOrder").equals("PACCEPT"))
    			orderStr = " ORDER BY GRR.PACCEPT, GRR.RNAME  ";
    		else
    			orderStr = " ORDER BY GRR.RDEPT, GRR.RNAME  ";
    		
    		if(!grcode.equals(""))
    			searchStr += " AND GRR.GRCODE = '" + grcode + "' ";
    		
    		Map<String, Object> paramMap = new HashMap<String, Object>();
        	paramMap.put("grseq", grseq);
    		paramMap.put("searchStr", searchStr);
    		paramMap.put("orderStr", orderStr);
			
            resultMap = certiResultMapper.selectGrResultByAllListForCyber2(paramMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;
	}	
	
	/**
	 * 과정 기수의 수료자 인원 조회 (사이버)
	 */
	public DataMap selectGrResultCompletionCntRowForCyber(String grcode, String grseq) throws BizException{
		DataMap resultMap = new DataMap();
        
        try {
        	String whereStr = "";
            if(!grcode.equals(""))
            	whereStr = " AND A.GRCODE = '" + grcode + "' ";
            
            Map<String, Object> paramMap = new HashMap<String, Object>();
        	paramMap.put("grseq", grseq);
    		paramMap.put("whereStr", whereStr);
    		
            resultMap = certiResultMapper.selectGrResultCompletionCntRowForCyber(paramMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;
	}
	
	/**
	 * 과정기수 수료자의 부서 리스트(사이버)
	 */
	public DataMap selectGrResultDeptListForCyber(String grcode, String grseq) throws BizException{
		DataMap resultMap = new DataMap();
        
        try {
        	String whereStr = "";
            if(!grcode.equals(""))
            	whereStr = " AND A.GRCODE = '" + grcode + "' ";
            
            Map<String, Object> paramMap = new HashMap<String, Object>();
        	paramMap.put("grseq", grseq);
    		paramMap.put("whereStr", whereStr);
    		
            resultMap = certiResultMapper.selectGrResultDeptListForCyber(paramMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;
	}
	
	/**
	 * 간단한 회원정보 리스트 추출
	 */
	public DataMap selectMemberBySimpleDataList(DataMap requestMap) throws BizException{
		DataMap resultMap = new DataMap();
        
        try {
        	String userWhereStr = "";
            String userWhereStr2 = "";
            for(int i = 0 ; i < requestMap.keySize("userno[]") ; i++){
            	if(i <= 999) {
            		if(!"".equals(userWhereStr)) {
            			if(i > 0) userWhereStr += ", ";
            		}
        			userWhereStr += "'" + requestMap.getString("userno[]", i) + "'";
            	} else {
            		if(!"".equals(userWhereStr2)) {
            			if(i > 0) userWhereStr2 += ", ";
            		}
            		userWhereStr2 += "'" + requestMap.getString("userno[]", i) + "'";            		
            	}
            }

            if(userWhereStr.equals(""))
            	resultMap = new DataMap();
            else {
            	if("".equals(userWhereStr2)) {
            		userWhereStr = " AND USERNO IN (" + userWhereStr + ") ";
            	} else {
            		userWhereStr = " AND (USERNO IN (" + userWhereStr + ") OR USERNO IN (" + userWhereStr2 + ")) ";
            	}
            }
            resultMap = lectureApplyMapper.selectMemberBySimpleDataList(userWhereStr + " AND SMS_YN = 'Y' ");
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;
	}
	
	/**
	 * 수료증 출력을 위한 수료자 조회
	 */
	public DataMap selectGrResultByResultDocList(DataMap requestMap) throws BizException{
		DataMap resultMap = new DataMap();
        
        try {
        	String grcode = requestMap.getString("grcode");
            String grseq = requestMap.getString("grseq");
            String userno = requestMap.getString("userno");
            
            String whereStr = userno;
            
            
            
            /*for(int i = 0 ; i < requestMap.keySize("chkUserno[]") ; i++){
        		if(i > 0) whereStr += ", ";
        		
        		whereStr += "'" + requestMap.getString("chkUserno[]", i) + "'";
            }*/
            
            if(whereStr.equals(""))
            	resultMap = new DataMap();
            else{
            	whereStr = " AND A.USERNO ='"+ userno +"'";
            	
            	Map<String, Object> paramMap = new HashMap<String, Object>();
            	paramMap.put("grcode", grcode);
            	paramMap.put("grseq", grseq);
        		paramMap.put("whereStr", whereStr);
        		
            	resultMap = certiResultMapper.selectGrResultByResultDocList(paramMap);
            }
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;
	}
	
	/**
	 * 과목별 이수현황
	 */
	public DataMap selectStuLectBySubjStudyList(String grcode, String grseq, String subj, DataMap requestMap) throws BizException{
		DataMap resultMap = new DataMap();
        
        try {
        	String whereStr = "";
            
            if( !requestMap.getString("searchDept").equals("") ) //기관
            	whereStr += " AND A.DEPT = '" + requestMap.getString("searchDept") + "' ";
            
            if( !requestMap.getString("searchName").equals("") ) //성명
            	whereStr += " AND A.NAME like '%" + requestMap.getString("searchName") + "%' ";
            
            if( !requestMap.getString("commClass").equals("") ) //반
            	whereStr += " AND A.CLASSNO = '" + requestMap.getString("commClass") + "' ";
            
            if( requestMap.getString("searchRgrayn").equals("Y") ) //이수여부
            	whereStr += " AND A.GRAYN = 'Y' ";
            else if( requestMap.getString("searchRgrayn").equals("N") )
            	whereStr += " AND ( A.GRAYN IS NULL OR A.GRAYN = 'N' )"; //이게 맞는거 아냐? ㅡㅡ;;
            	//whereStr += " AND A.GRAYN IS NULL ";
            
            Map<String, Object> paramMap = new HashMap<String, Object>();
        	paramMap.put("grcode", grcode);
        	paramMap.put("grseq", grseq);
        	paramMap.put("subj", subj);
    		paramMap.put("whereStr", whereStr);
    		
            resultMap = certiResultMapper.selectStuLectBySubjStudyList(paramMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;
	}
}
