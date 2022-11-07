package loti.homepageMgr.service;

import java.sql.SQLException;

import loti.common.mapper.CommonMapper;
import loti.homepageMgr.mapper.NoticeMapper;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import ut.lib.exception.BizException;
import ut.lib.support.DataMap;
import ut.lib.util.Message;

import common.service.BaseService;

@Service("homepageMgrNoticeService")
public class NoticeService extends BaseService {

	@Autowired
	@Qualifier("homepageMgrNoticeMapper")
	private NoticeMapper noticeMapper;
	
	@Autowired
	private CommonMapper commonMapper;
	
	/**
	 * 개인 그룹 공지 관리 리스트
	 * @param whereStr
	 * @param pagingInfoMap
	 * @return
	 * @throws Exception
	 */
	public DataMap selectNotiPerGrpList(String searchKey, String searchValue, String userNo, DataMap pagingInfoMap) throws Exception{
		
        DataMap resultMap = null;
        
        try {
        	
        	DataMap params = (DataMap)pagingInfoMap.clone();
        	
        	params.setString("searchKey", searchKey);
        	params.setString("searchValue", searchValue);
        	
            resultMap = noticeMapper.selectNotiPerGrpList(params);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
	
	
	/**
	 * 개인 그룹 공지 관리 상세보기
	 * @param seq
	 * @return
	 * @throws Exception
	 */
	@Transactional
	public DataMap selectNotiPerGrpRow(int seq) throws Exception{
		
        DataMap resultMap = null;
        
        try {
        	
            resultMap = noticeMapper.selectNotiPerGrpRow(seq);
            resultMap.setNullToInitialize(true);
            
            
        	// 이름 및 권한명
            String tmpStr = resultMap.getString("notiPart");
            System.out.println("\n ##1 tmpStr = " + tmpStr);
            tmpStr = tmpStr.replaceAll("\\]\\[", ",");
            tmpStr = tmpStr.replaceAll("\\]", "");
            tmpStr = tmpStr.replaceAll("\\[", ""); 
            System.out.println("\n ##2 tmpStr = " + tmpStr);
            
            String[] tmpStrArr = tmpStr.split(",");
            
            String notiPartName = ""; //최종 이름 및 권한명.
            for(int i=0; i < tmpStrArr.length; i++){
            	
            	if(!notiPartName.equals("")) 
            		notiPartName += ",";

            	if(resultMap.getString("notiGubun").equals("P"))
            		notiPartName += commonMapper.selectUserNameString(tmpStrArr[i]);
            	else
            		notiPartName += commonMapper.selectGadminString(tmpStrArr[i]);
            }
            resultMap.add("notiPartName", notiPartName);

        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
	
	
	/**
	 * 개인 그룹 공지 관리 방문자수 증가.
	 * @param seq
	 * @return
	 * @throws Exception
	 */
	public int updateNotiPerGrpVisitCnt(int seq) throws Exception{
		
        int returnValue = 0;
        
        try {
        	
            returnValue = noticeMapper.updateNotiPerGrpVisitCnt(seq);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return returnValue;        
	}
}
