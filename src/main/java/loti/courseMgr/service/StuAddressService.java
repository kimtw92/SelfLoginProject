package loti.courseMgr.service;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import loti.courseMgr.mapper.StuAddressMapper;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ut.lib.exception.BizException;
import ut.lib.page.PageNavigation;
import ut.lib.support.DataMap;
import ut.lib.util.Message;
import ut.lib.util.Util;
import common.service.BaseService;

@Service
public class StuAddressService extends BaseService {

	@Autowired
	private StuAddressMapper stuAddressMapper;
	
	/**
	 * 동기 주소록 리스트.
	 */
	public DataMap selectAppInfoDetailInfoList(String grcode, String grseq, String grchk, DataMap requestMap) throws BizException{
		DataMap resultMap = new DataMap();
        
        try {
        	Map<String, Object> paramMap = new HashMap<String, Object>();
        	paramMap.put("grcode", grcode);
        	paramMap.put("grseq", grseq);
        	paramMap.put("grchk", grchk);
        	
        	int appInfoDetailInfoListCount = stuAddressMapper.selectAppInfoDetailInfoListCount(paramMap);
        	
        	Map<String, Object> pageInfo = Util.getPageInfo(appInfoDetailInfoListCount, requestMap);
			
			pageInfo.put("grcode", grcode);
			pageInfo.put("grseq", grseq);
			pageInfo.put("grchk", grchk);
			
        	resultMap = stuAddressMapper.selectAppInfoDetailInfoList(pageInfo);
        	PageNavigation pageNavi = Util.getPageNavigation(pageInfo);
			
			resultMap.set("PAGE_INFO", pageNavi);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;
	}
}
