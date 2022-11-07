package loti.homeFront.service;

import java.sql.SQLException;
import java.util.List;

import loti.homeFront.mapper.HtmlMapper;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ut.lib.exception.BizException;
import ut.lib.support.DataMap;
import ut.lib.util.Message;
import common.service.BaseService;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Service
public class HtmlService extends BaseService {

	@Autowired
	private HtmlMapper htmlMapper;

	public DataMap htmlTemplete(String htmlId) throws BizException {

		DataMap resultMap = null;
        
        try {
        	
            resultMap = htmlMapper.htmlTemplete(htmlId);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;    
	}
	
	public DataMap sample(String rowindex) throws Exception{
		
		DataMap resultMap = null;
        
        try {
            
            resultMap = htmlMapper.sample(rowindex);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}


}
