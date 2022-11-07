package loti.poll.service;

import java.sql.SQLException;

import loti.poll.mapper.InquiryPollMapper;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ut.lib.exception.BizException;
import ut.lib.support.DataMap;
import ut.lib.util.Message;

import common.service.BaseService;

@Service
public class InquiryPollService extends BaseService {

	@Autowired
	private InquiryPollMapper inquiryPollMapper;
	
	/**
	 * 설문결과관리 검색 ajax리스트
	 * 작성일 9월 22일
	 * 작성자 정윤철
	 * @param pagingInfoMap
	 * @return selectFaqList
	 * @throws Exception
	 */
	public DataMap selectInquiryPollAjax(DataMap requestMap) throws BizException{
			
	    DataMap resultMap = new DataMap();
	    
	    try {
	    	
	        resultMap = inquiryPollMapper.selectInquiryPollAjax(requestMap);
	        
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return resultMap;        
	}
	
	/**
	 * 설문결과관리 설문SET번호
	 * 작성일 9월 22일
	 * 작성자 정윤철
	 * @param pagingInfoMap
	 * @return selectFaqList
	 * @throws Exception
	 */
	public DataMap selectInquirySetPollAjax(DataMap requestMap) throws BizException{
			
	    DataMap resultMap = null;
	    
	    try {
	    	
	        resultMap = inquiryPollMapper.selectInquirySetPollAjax(requestMap);
	        
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return resultMap;        
	}	
	
}
