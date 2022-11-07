package loti.mypage.service;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import loti.mypage.mapper.PaperMapper;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import ut.lib.exception.BizException;
import ut.lib.page.PageNavigation;
import ut.lib.support.DataMap;
import ut.lib.util.Message;
import ut.lib.util.Util;

import common.service.BaseService;

@Service
public class PaperService extends BaseService {

	@Autowired
	private PaperMapper paperMapper;
	
	public DataMap paperNewCount(String sessNo) throws BizException{
		System.out.println("1111111111111111111111111111");
		DataMap resultMap = null;
        
        try {
        	
            resultMap = paperMapper.paperNewCount(sessNo);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}

	public int paperUpdate(DataMap requestMap) throws BizException {

        DataMap resultMap = null;
        int iNum = 0;
        try {
        	
            /**
             * 값 보내기
             */
           	iNum += paperMapper.paperUpdate(requestMap);
           	
        } catch (SQLException e) {

            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return iNum;        
	}

	public DataMap selectPaperList(DataMap requestMap) throws BizException {

		DataMap resultMap = null;
        
        try {
        	
            /**
             * 공지사항 검색조건 설정
             */
            String key = requestMap.getString("kind");
            String userno = requestMap.getString("userno");

            Map<String, Object> params = new HashMap<String, Object>();
            
            params.put("key", key);
            params.put("userno", userno);
            
            int totalCnt = paperMapper.paperListCount(params);
            
            params.putAll(Util.getPageInfo(totalCnt, requestMap));
            
            resultMap = paperMapper.paperList(params);
            
           	PageNavigation pageNavi = Util.getPageNavigation(params);
           	resultMap.set("PAGE_INFO", pageNavi);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;    
	}

	public DataMap selectMemberList(DataMap requestMap) throws BizException {

		DataMap resultMap = null;
        
        try {
        	
            /**
             * 공지사항 검색조건 설정
             */
            String stringWhere = "";
            String search = requestMap.getString("search");
            
        	stringWhere = "WHERE name like '%"+search+"%'";
            
        	

        	int totalCnt = paperMapper.memberListCount(search);
        	
        	Map<String, Object> pageInfo = Util.getPageInfo(totalCnt, requestMap);
        	
        	pageInfo.put("search", search);
        	
            resultMap = paperMapper.memberList(pageInfo);
            
            /**
        	 * 페이징 필수
        	 */

           	PageNavigation pageNavi = Util.getPageNavigation(pageInfo);
           	resultMap.set("PAGE_INFO", pageNavi);
        	
        	
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap; 
	}

	@Transactional
	public int sendPaper(DataMap requestMap) throws BizException {

        int iNum = 0;
        try {
        	
            /**
             * 값 보내기
             */
            String stringWhere = "";
            String[] recieveName = requestMap.getString("recieveName").split("[;]");
            String[] recieveNo = requestMap.getString("recieveNo").split("[;]");
            
            if (recieveName != null && recieveName.length > 0){
            	for(int i=0,l=recieveName.length;i<l;i++){
	            	requestMap.setString("recieveName",recieveName[i]);
	            	requestMap.setString("recieveNo",recieveNo[i]);
	            	requestMap.setString("sendDel","0");
	            	requestMap.setString("recieveDel","0");
	            	iNum += paperMapper.paperInsert(requestMap);
            	}
            }
            requestMap.setString("msg","쪽지가 발송되었습니다.");
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return iNum;  
	}

	public int paperDelete(DataMap requestMap) throws BizException {

        DataMap resultMap = null;
        int iNum = 0;
        try {
        	
            /**
             * 삭제 루프
             */
            String queryString = "UPDATE tb_paper SET "+requestMap.getString("kind")+"_DEL = '1' WHERE pap_no = ?";
            if(requestMap.keySize("papNo") > 0){		
            	
            	Map<String, Object> params = new HashMap<String, Object>();
            	
            	params.put("kind", requestMap.getString("kind"));
            	
            	for(int i=0; i < requestMap.keySize("papNo"); i++){
            		
            		params.put("papNo", requestMap.getString("papNo",i));
            		
            		iNum += paperMapper.paperDelete(params);
            	}
            }
            requestMap.setString("msg","선택된 쪽지가 삭제되었습니다.");
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return iNum;    
	}

	public int paperDelAll(DataMap requestMap) throws BizException {

        int iNum = 0;
        try {
        	
            /**
             * 삭제 루프
             */
            Map<String, Object> params = new HashMap<String, Object>();
            
            params.put("kind", requestMap.getString("kind"));
            params.put("userno", requestMap.getString("userno"));
            
       		iNum += paperMapper.paperDeleteAll(params);
       		requestMap.setString("msg","전체 삭제 되었습니다.");
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return iNum;       
	}
	
}
