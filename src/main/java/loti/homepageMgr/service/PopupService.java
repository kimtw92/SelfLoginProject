package loti.homepageMgr.service;

import java.sql.SQLException;
import java.util.Map;

import loti.homepageMgr.mapper.PopupMapper;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import ut.lib.exception.BizException;
import ut.lib.page.PageNavigation;
import ut.lib.support.DataMap;
import ut.lib.util.Message;
import ut.lib.util.Util;

import common.service.BaseService;

@Service("homepageMgrPopupService")
public class PopupService extends BaseService {
	
	@Autowired
	@Qualifier("homepageMgrPopupMapper")
	private PopupMapper popupMapper;

	/**
	 * 팝업관리 리스트
	 * 작성일 6월 16일
	 * 작성자 정윤철
	 * @param pagingInfoMap
	 * @return selectFaqList
	 * @throws Exception
	 */
	public DataMap selectPopupList(DataMap pagingInfoMap) throws Exception{
	    DataMap resultMap = null;
	    
	    try {
	    	
	    	int totalCnt = popupMapper.selectPopupListCount(pagingInfoMap);
        	
        	Map<String, Object> pageInfo = Util.getPageInfo(totalCnt, pagingInfoMap);
        	
        	pagingInfoMap.set("page", pageInfo);
        	
            resultMap = popupMapper.selectPopupList(pagingInfoMap);
            
            PageNavigation pageNavi = Util.getPageNavigation(pageInfo);
		    resultMap.set("PAGE_INFO", pageNavi);
	        
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return resultMap;        
	}
	
	/**
	 * 팝업관리 미리보기
	 * 작성일 6월 16일
	 * 작성자 정윤철
	 * @param no
	 * @return selectFaqList
	 * @throws Exception
	 */
	public DataMap selectPopupViewRow(int no) throws Exception{
	    DataMap resultMap = null;

	    
	    try {
		    resultMap = popupMapper.selectPopupViewRow(no);
	        
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return resultMap;        
	}
	
	/**
	 * 팝업관리 수정 데이터 폼
	 * 작성일 6월 16일
	 * 작성자 정윤철
	 * @param no
	 * @return selectFaqList
	 * @throws Exception
	 */
	public DataMap selectPopupModifyRow(int no) throws Exception{
	    DataMap resultMap = null;

	    
	    try {
			resultMap = popupMapper.selectPopupModifyRow(no);
	        
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return resultMap;        
	}
	
	
	/**
	 * 팝업관리 등록
	 * 작성일 6월 16일
	 * 작성자 정윤철
	 * @param no
	 * @return selectFaqList
	 * @throws Exception
	 */
	public void insertPopup(DataMap requestMap, int maxNo) throws Exception{
	   
	    try {
		    
	    	String eDate = "";
	    	
	    	//시작일 시간과 종료일 시간이 10이하일경우 앞에 0을 붙여서 두자리수로 만들어준다
	    	if(requestMap.getInt("pstrDateh") < 10){
	    		requestMap.setString("pstrDateh", "0"+requestMap.getString("pstrDateh"));
	    	}
	    	if(requestMap.getInt("pendDateh") < 10){
	    		requestMap.setString("pendDateh", "0"+requestMap.getString("pendDateh"));
	    	}
	    	
	    	
	    	//이벤트일과 시간을 합친다. 
	    	requestMap.setInt("sDate", Integer.parseInt(requestMap.getString("pstrDate")+requestMap.getString("pstrDateh")));
	    	
	    	//이벤트일 마지막날자에서 시간이 24일경우 일자를 하루 증가시키고 시간은 00으로 만든다.
	    	if(requestMap.getInt("pendDateh") <= 24){
	    		eDate = "TO_DATE('"+requestMap.getString("pendDate")+requestMap.getString("pendDateh")+"','YYYYMMDDHH24')";
	    	}else{
	    		eDate = "TO_DATE('"+requestMap.getString("pendDate")+"00"+"','YYYYMMDDHH24') + 1";
	    	}
	    	
	    	DataMap params = (DataMap)requestMap.clone();
	    	
	    	params.setString("eDate", eDate);
	    	params.setInt("maxNo", maxNo);

	    	popupMapper.insertPopup(params);
	    	
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	}
	
	
	/** 팝업 MAX넘버
	 * 작성자 정윤철
	 * 작성일 6월 16일
	 * @param requestMap
	 * @return updateDefaultInfo
	 * @throws Exception
	 */
	public int selectMaxNoRow() throws Exception{
		
	    int returnValue = 0;
	    
	    try {
	    	
	        returnValue = popupMapper.selectMaxNoRow();
	        
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return returnValue;        
	}
	
	/**
	 * 팝업관리 수정
	 * 작성일 6월 16일
	 * 작성자 정윤철
	 * @param no
	 * @param requestMap
	 * @return selectFaqList
	 * @throws Exception
	 */
	public void modifyPopup(DataMap requestMap) throws Exception{

	    try {
		    
	    	String eDate = "";
			
	    	//------------------------------------------------------------------------------------>
	    	//시작일 시간과 종료일 시간이 10이하일경우 앞에 0을 붙여서 두자리수로 만들어준다
	    	if(requestMap.getInt("pstrDateh") < 10){
	    		requestMap.setString("pstrDateh", "0"+requestMap.getString("pstrDateh"));
	    	}
	    	if(requestMap.getInt("pendDateh") < 10){
	    		requestMap.setString("pendDateh", "0"+requestMap.getString("pendDateh"));
	    	}
	    	
			//------------------------------------------------------------------------------------>

			
	    	//이벤트일과 시간을 합친다. 
	    	requestMap.setInt("sDate", Integer.parseInt(requestMap.getString("pstrDate")+requestMap.getString("pstrDateh")));
	    	
	    	//이벤트일 마지막날자에서 시간이 24일경우 일자를 하루 증가시키고 시간은 00으로 만든다.
	    	if(requestMap.getInt("pendDateh") < 24){
	    		eDate = "TO_DATE('"+requestMap.getString("pendDate")+requestMap.getString("pendDateh")+"','YYYYMMDDHH24')";
	    	}else{
	    		eDate = "TO_DATE('"+requestMap.getString("pendDate")+"00"+"','YYYYMMDDHH24') + 1";
	    	}
	    	
	    	DataMap params = (DataMap)requestMap.clone();
	    	
	    	params.setString("eDate", eDate);

	    	popupMapper.modifyPopup(params);
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	}
	/**
	 * 팝업관리 등록
	 * 작성일 6월 16일
	 * 작성자 정윤철
	 * @param no
	 * @return selectFaqList
	 * @throws Exception
	 */
	public void deletePopup(int no) throws Exception{
	    
	    try {
		    
	    	popupMapper.deletePopup(no);
	    	
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	}
}
