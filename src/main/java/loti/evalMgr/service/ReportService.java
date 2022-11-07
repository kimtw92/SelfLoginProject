package loti.evalMgr.service;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import loti.evalMgr.mapper.ReportMapper;
import loti.evalMgr.mapper.ReportSmsMapper;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import ut.lib.exception.BizException;
import ut.lib.support.DataMap;
import ut.lib.util.Message;
import common.service.BaseService;

@Service("evalMgrReportService")
public class ReportService extends BaseService {

	@Autowired
	@Qualifier("evalMgrReportMapper")
	private ReportMapper reportMapper;
	@Autowired
	private ReportSmsMapper reportSmsMapper;
	
	public DataMap selectReportClassNoList(DataMap requestMap) throws BizException{
		DataMap resultMap = new DataMap();
        
        try {
        	resultMap = reportMapper.selectReportClassNoList(requestMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;        
	}
	
	public DataMap selectReportList(DataMap requestMap) throws BizException{
		DataMap resultMap = new DataMap();
        
        try {
        	resultMap = reportMapper.selectReportNoList(requestMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;        
	}
	
	public DataMap selectReportYearList(String commYear) throws BizException{
		DataMap resultMap = new DataMap();
        
        try {
        	resultMap = reportMapper.selectReportYearList(commYear);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;        
	}
	
	public DataMap selectReportGrCodeList(DataMap requestMap) throws BizException{
		DataMap resultMap = new DataMap();
        
        try {
        	resultMap = reportMapper.selectReportGrCodeList(requestMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;        
	}
	
	public DataMap selectReportGrSeqList(DataMap requestMap) throws BizException{
		DataMap resultMap = new DataMap();
        
        try {
        	resultMap = reportMapper.selectReportGrSeqList(requestMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;        
	}
	
	/**
	 * 과제물 제출 마감 날짜
	 */
	public DataMap selectReportEndDate(DataMap requestMap) throws BizException{
		DataMap resultMap = new DataMap();
        
        try {
        	resultMap = reportMapper.selectReportEndDate(requestMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;        
	}
	
	/**
	 * 해당 과목 학생 리스트
	 */
	public DataMap selectReportStudentList(DataMap requestMap) throws BizException{
		DataMap resultMap = new DataMap();
        
        try {
        	resultMap = reportMapper.selectReportStudentList(requestMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;        
	}
	
	/**
	 * 미제출자 SMS 보낼때 체크된 학생들의 정보
	 */
	public DataMap selectReportNoSMSList(Map<String, Object> paramMap) throws BizException{
		DataMap resultMap = new DataMap();
        
        try {
        	resultMap = reportMapper.selectReportNoSMSList(paramMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;        
	}
	
	/**
	 * 학생들의 정보를 가지고 insert를 수행한다. 실제 입력된 학생들 정보를 리턴 받는다
	 */
	public DataMap insertSMSList(DataMap insertList,String msg) throws BizException{
		DataMap resultMap = new DataMap();
		
		try {
			Map<String, Object> paramMap = null;
			for(int i=0; i<insertList.keySize("userno"); i++){
            	//메세지에 각 사람의 이름 입력
            	msg = msg.replaceAll("name", insertList.getString("name",i));
            	paramMap = new HashMap<String, Object>();
            	paramMap.put("hp", insertList.getString("hp", i));
            	paramMap.put("msg", msg);
            	reportSmsMapper.insertSMSList(paramMap);
            	
            	//다시 넘겨줄 학생들 정보
            	resultMap.addString("name",insertList.getString("name",i));
            	resultMap.addString("hp",insertList.getString("hp",i));
            	resultMap.addString("msg",msg);
            }
		} catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
		return resultMap;        
	}
	
	/**
	 * 과정명
	 */
	public DataMap selectReportGrcodeNm(String commGrcode) throws BizException{
		DataMap resultMap = new DataMap();
        
        try {
        	resultMap = reportMapper.selectReportGrcodeNm(commGrcode);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;        
	}
}
