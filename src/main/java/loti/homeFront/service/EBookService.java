package loti.homeFront.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import loti.homeFront.mapper.EBookMapper;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ut.lib.exception.BizException;
import ut.lib.page.PageFactory;
import ut.lib.page.PageInfo;
import ut.lib.page.PageNavigation;
import ut.lib.support.DataMap;
import ut.lib.util.Constants;
import ut.lib.util.Message;
import ut.lib.util.Util;

import common.service.BaseService;

import egovframework.rte.psl.dataaccess.util.EgovMap;

@Service
public class EBookService extends BaseService {

	@Autowired
	private EBookMapper eBookMapper;
	
	public DataMap ebookList(DataMap requestMap) throws BizException {

		DataMap resultMap = null;
        
        try {
        	
        	int totalCnt = eBookMapper.ebookListCount();
        	
        	Map<String, Object> pageInfo = Util.getPageInfo(totalCnt, requestMap);
        	
            resultMap = eBookMapper.ebookList(pageInfo);
            
           	PageNavigation pageNavi = Util.getPageNavigation(pageInfo);
        				
           	resultMap.set("PAGE_INFO", pageNavi);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;  
	}

}
