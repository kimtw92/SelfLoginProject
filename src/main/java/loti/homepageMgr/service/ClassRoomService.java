package loti.homepageMgr.service;

import java.sql.SQLException;

import loti.homepageMgr.mapper.ClassRoomMapper;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import ut.lib.exception.BizException;
import ut.lib.support.DataMap;
import ut.lib.util.Message;
import common.service.BaseService;

@Service("homepageMgrClassRoomService")
public class ClassRoomService extends BaseService {

	@Autowired
	@Qualifier("homepageMgrClassRoomMapper")
	private ClassRoomMapper classRoomMapper;
	
	/**
	 * 게시판관리 리스트
	 * 작성일 6월 17일
	 * 작성자 정윤철
	 * @param pagingInfoMap
	 * @return boardList
	 * @throws Exception
	 */
	public DataMap selectClassRoomList(DataMap requestMap) throws Exception{
			
	    DataMap resultMap = null;
	    
	    try {
	    	
	        resultMap = classRoomMapper.selectClassRoomList(requestMap);
	        
	        
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return resultMap;        
	}
	
	
	/**
	 * 게시판관리 강의실코드 중복 체크
	 * 작성일 6월 17일
	 * 작성자 정윤철
	 * @param pagingInfoMap
	 * @return boardList
	 * @throws Exception
	 */
	public int selectClassRoomNoChk(String classroomNo) throws Exception{
			
	    int returnValue = 0;
	    
	    try {
	    	
	        returnValue = classRoomMapper.selectClassRoomNoChk(classroomNo);
	        
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return returnValue;        
	}
	
	
	/**
	 * 게시판관리 수정
	 * 작성일 6월 17일
	 * 작성자 정윤철
	 * @param pagingInfoMap
	 * @return boardList
	 * @throws Exception
	 */
	public int modifyClassRoom(DataMap requestMap) throws Exception{
			
	    int resultValue = 0;
	    
	    try {
	    	
	        resultValue = classRoomMapper.modifyClassRoom(requestMap);
	        
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return resultValue;
	}
	
	/**
	 * 게시판관리 등록
	 * 작성일 6월 17일
	 * 작성자 정윤철
	 * @param pagingInfoMap
	 * @return boardList
	 * @throws Exception
	 */
	public void insertClassRoom(DataMap requestMap) throws Exception{
			
	    try {
	    	
	    	classRoomMapper.insertClassRoom(requestMap);
	        
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	}
	
	/**
	 * 게시판관리 등록
	 * 작성일 6월 17일
	 * 작성자 정윤철
	 * @param pagingInfoMap
	 * @return boardList
	 * @throws Exception
	 */
	@Transactional
	public void deleteClassRoom(DataMap requestMap) throws Exception{
			
	    try {
	    	
	        for(int i = 0; requestMap.keySize("chk") > i; i++){
	        	//체크한 갯수만큼 삭제
	        	classRoomMapper.deleteClassRoom(requestMap.getString("chk", i));
	        	
	        }
	        
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	}
	
	/**
	 * 게시판관리 강의실코드 중복 체크
	 * 작성일 6월 17일
	 * 작성자 정윤철
	 * @param pagingInfoMap
	 * @return boardList
	 * @throws Exception
	 */
	public DataMap selectExcelList(String date) throws Exception{
			
	    DataMap resultMap = null;
	    
	    try {
	        
	        resultMap = classRoomMapper.selectExcelList(date);
	        
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return resultMap;        
	}
}
