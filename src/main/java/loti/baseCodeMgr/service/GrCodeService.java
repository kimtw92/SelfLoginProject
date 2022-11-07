package loti.baseCodeMgr.service;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ut.lib.exception.BizException;
import ut.lib.page.PageNavigation;
import ut.lib.support.DataMap;
import ut.lib.util.ConvType;
import ut.lib.util.Message;
import ut.lib.util.Util;
import loti.baseCodeMgr.mapper.GrCodeMapper;
import common.service.BaseService;

@Service
public class GrCodeService extends BaseService {

	@Autowired
	private GrCodeMapper grCodeMapper;
	
	/**
	 * 과정코드 리스트.
	 */
	public DataMap selectGrCodeList(DataMap requestMap) throws BizException{
		DataMap resultMap = null;
		
		try {
			int grCodeListCount = grCodeMapper.selectGrCodeListCount(requestMap);
			
			Map<String, Object> pageInfo = Util.getPageInfo(grCodeListCount, requestMap);
			
			pageInfo.put("searchKey", requestMap.getString("searchKey"));
			pageInfo.put("searchValue", requestMap.getString("searchValue"));
			
			resultMap = grCodeMapper.selectGrCodeList(pageInfo);
			PageNavigation pageNavi = Util.getPageNavigation(pageInfo);
			
			resultMap.set("PAGE_INFO", pageNavi);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
		
		return resultMap;
	}
	
	/**
	 * 과정코드 상세보기.
	 */
	public DataMap selectGrCodeRow(String grCode) throws BizException {
		DataMap resultMap = null;
		
		try {
			resultMap = grCodeMapper.selectGrCodeRow(grCode);
		} catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
		
		return resultMap;
	}
	
	/**
	 * 과정코드 등록
	 */
	public int insertGrCode(DataMap requestMap) throws BizException {
		int returnValue = 0;
		
		try {
			Map<String, Object> paramMap = new HashMap<String, Object>(); 
			
			StringBuffer sb = new StringBuffer();
			
			String grGubun = requestMap.getString("grgubun");
			paramMap.put("grGubun", grGubun);
			sb.append("10").append(grGubun);
			
			String maxGrCode = grCodeMapper.selectMaxGrCode(sb.toString());
			sb = new StringBuffer();
			sb.append("10").append(grGubun);
			if (maxGrCode.equals("")) {
				sb.append("0000001");
			} else {
				sb.append(ConvType.plusZero(Integer.parseInt(maxGrCode.substring(3, 10))+1, 7));
			}
			paramMap.put("grCode", sb.toString());
			paramMap.put("grType", requestMap.getString("grtype"));
			paramMap.put("grSubCd", requestMap.getString("grsubcd"));
			paramMap.put("grCodeNm", requestMap.getString("grcodenm"));
			paramMap.put("mkYear", requestMap.getString("mkYear"));
			paramMap.put("rullYn", requestMap.getString("rullYn"));
			paramMap.put("musicYn", requestMap.getString("musicYn"));
			paramMap.put("useYn", requestMap.getString("useYn"));
			paramMap.put("lUserNo", requestMap.getString("userNo"));
			paramMap.put("grPoint", requestMap.getInt("grPoint"));
			paramMap.put("grTime", requestMap.getString("grtime"));
		    
			returnValue = grCodeMapper.insertGrCode(paramMap);
		} catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
		
		return returnValue;
	}
	
	/**
	 * 과정코드 수정.
	 */
	public int modifyGrCode(DataMap requestMap) throws BizException{
		int returnValue = 0;
        
        try {
        	Map<String, Object> paramMap = new HashMap<String, Object>(); 
			
			paramMap.put("grGubun", requestMap.getString("grgubun"));
			paramMap.put("grCode", requestMap.getString("grcode"));
			paramMap.put("grType", requestMap.getString("grtype"));
			paramMap.put("grSubCd", requestMap.getString("grsubcd"));
			paramMap.put("grCodeNm", requestMap.getString("grcodenm"));
			paramMap.put("mkYear", requestMap.getString("mkYear"));
			paramMap.put("rullYn", requestMap.getString("rullYn"));
			paramMap.put("musicYn", requestMap.getString("musicYn"));
			paramMap.put("useYn", requestMap.getString("useYn"));
			paramMap.put("lUserNo", requestMap.getString("userNo"));
			paramMap.put("grPoint", requestMap.getInt("grPoint"));
			paramMap.put("grTime", requestMap.getInt("grtime"));
		    
        	returnValue = grCodeMapper.updateGrCode(paramMap);                        
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return returnValue;        
	}
	
	/**
	 * 과정코드 삭제.
	 */
	public int deleteGrCode(String grCode) throws BizException{
		int returnValue = 0;
        
        try {
        	// 등록된 과정 차수 갯수 정보. (등록된 과정차수가 있을경우는 삭제 처리 안됨) return -1
            int grSeqCnt = grCodeMapper.selectGrSeqCheck(grCode); 
            if (grSeqCnt == 0) {
            	returnValue = grCodeMapper.deleteGrCode(grCode);
            } else { //과정 차수가 존재하면.
            	returnValue = -1;
            }
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return returnValue;        
	}
}
