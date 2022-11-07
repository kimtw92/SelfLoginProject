package loti.webzine.service;

import java.io.File;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import loti.webzine.mapper.WebzineMapper;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ut.lib.exception.BizException;
import ut.lib.file.FileUtil;
import ut.lib.page.PageFactory;
import ut.lib.page.PageInfo;
import ut.lib.page.PageNavigation;
import ut.lib.support.DataMap;
import ut.lib.util.Constants;
import ut.lib.util.DateUtil;
import ut.lib.util.Message;
import ut.lib.util.SpringUtils;
import ut.lib.util.Util;
import common.service.BaseService;

@Service
public class WebzineService extends BaseService{

	@Autowired
	private WebzineMapper webzineMapper;
	
	
	/**
	 * Webzine 사진 리스트
	 * 작성일 7월 2일
	 * 작성자 정윤철
	 * @param pagingInfoMap
	 * @return selectFaqList
	 * @throws Exception
	 */
	public DataMap selectComplateList(DataMap requestMap) throws BizException {
		
		DataMap resultMap = null;
	    
	    //검색 조건이 있을시 where절을 만든다.
	    String where  = "";
	    try {
	    	
	        if(!requestMap.getString("date").equals("")){
	        	where = "WHERE GRSEQ LIKE '%"+requestMap.getString("date")+"%'";
	        }
	        
	        Map<String, Object> params = new HashMap<String, Object>();
	        
	        params.put("where", where);
	        
	        int totalCnt = webzineMapper.selectComplateListCount(params);
	        
	        Map<String, Object> pageInfo = Util.getPageInfo(totalCnt, requestMap);
	        
	        params.putAll(pageInfo);
	        
	        resultMap = webzineMapper.selectComplateList(params);
	        
	    	/**
	    	 * 페이징 필수
	    	 */
	    	PageInfo pi = new PageInfo(totalCnt, Integer.valueOf(pageInfo.get("rowSize")+""), 0, Integer.valueOf(pageInfo.get("currPage")+""));

	       	PageNavigation pageNavi = PageFactory.getInstance(Constants.DEFAULT_PAGE_CLASS, pi);
	    				
	       	resultMap.set("PAGE_INFO", pageNavi);
	        
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return resultMap;
	}

	/**
	 * Webzine 사진 Row데이터
	 * 작성일 7월 2일
	 * 작성자 정윤철
	 * @param pagingInfoMap
	 * @return selectFaqList
	 * @throws Exception
	 */
	public DataMap selectComplateRow(int photoNo) throws BizException {
		
		DataMap resultMap = null;
	    
	    try {
	    	
	        resultMap = webzineMapper.selectComplateRow(photoNo);
	        
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return resultMap; 
	}
	



	/**
	 * Webzine 신규동지년도 리스트
	 * 작성일 7월 2일
	 * 작성자 정윤철
	 * @param pagingInfoMap
	 * @return selectFaqList
	 * @throws Exception
	 */
	public DataMap selectNewYearList() throws Exception{
			
	    DataMap resultMap = null;
	    
	    try {
	    	
	        resultMap = webzineMapper.selectNewYearList();
	        
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return resultMap;        
	}
	
	/**
	 * 사진관리 등록 exec
	 * 
	 * @param fileMap : 파일 정보가 들어있는 MAP
	 * @param innoSaveDir : 저장하는 경로 (/inno/common/... /inno/course/)
	 * @param userNo  : 등록하는 사람의 userno
	 * @return
	 * @throws Exception
	 */
	public int insertInnoUploadFile(DataMap fileMap, String innoSaveDir, String wcomments, String date) throws Exception{
		
		int returnValue = 0;
        
        try {
			
			DataMap insertMap = new DataMap(); //파일 저장 메소드에 전송될 Map
			
			//신규로 넘어온 파일 처리.
			for (int i=0; i < fileMap.keySize("fileSysName"); i++){
				
				String orgFileName = fileMap.getString("fileSysName", i); //업로드된 파일명
				String changeFileName = DateUtil.getDateTimeMinSec() + i; //실제 저장되는 파일명. (현재시간 + i)
				String realDir = SpringUtils.getRealPath() + Constants.UPLOAD + innoSaveDir; //파일 존재 위치 경로. /pds/inno/common/ 등.
				
				//저장된 파일.
				File orgFile = new File(realDir + orgFileName);
				if ( orgFile.exists() ) //파일 이름 변경
					orgFile.renameTo(new File( realDir + changeFileName));
				
				//초기화.
				insertMap.clear();
				insertMap.setNullToInitialize(true);
				
				//신규 파일 정보 셋팅.
				insertMap.add("filePath", innoSaveDir + changeFileName);
				insertMap.add("fileName", orgFileName);
				insertMap.add("wcomments", wcomments);
				if(!date.equals("")){
					//년도 데이터가 있을시
					insertMap.add("date", date);
					
				}else{
					//년도 데이터가 없을시 현재년도로 만든다.
					insertMap.add("date", DateUtil.getDateYyyyMm());
				}
				returnValue = webzineMapper.insertPhotoUpload(insertMap); //파일 내용 저장.
			}
			
			for(int i=0; i<fileMap.keySize("fileUploadOk"); i++){
				
				String fileName = fileMap.getString("file_fileName", i); //업로드된 파일명
				String orgFileName = fileMap.getString("file_fileOrgName", i); //업로드전 파일명
				String changeFileName = DateUtil.getDateTimeMinSec() + i; //실제 저장되는 파일명. (현재시간 + i)
				String realDir = SpringUtils.getRealPath() + Constants.UPLOAD + innoSaveDir; //파일 존재 위치 경로. /pds/inno/common/ 등.
				String fileSize = fileMap.getString("file_fileSize", i); //파일 사이즈.
				
				//저장된 파일.
				File orgFile = new File(realDir + fileName);
				if ( orgFile.exists() ) //파일 이름 변경
					orgFile.renameTo(new File( realDir + changeFileName));
				
				
				//초기화.
				insertMap.clear();
				insertMap.setNullToInitialize(true);
				
				//신규 파일 정보 셋팅.
				insertMap.add("filePath", innoSaveDir + changeFileName);
				insertMap.add("fileName", orgFileName);
				insertMap.add("wcomments", wcomments);
				if(!date.equals("")){
					//년도 데이터가 있을시
					insertMap.add("date", date);
					
				}else{
					//년도 데이터가 없을시 현재년도로 만든다.
					insertMap.add("date", DateUtil.getDateYyyyMm());
				}
				returnValue = webzineMapper.insertPhotoUpload(insertMap); //파일 내용 저장.
				
			}
			
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	returnValue = 1;
        }
        return returnValue;        
	}

	/**
	 * 사진관리 수정 exec
	 * 
	 * @param fileMap : 파일 정보가 들어있는 MAP
	 * @param innoSaveDir : 저장하는 경로 (/inno/common/... /inno/course/)
	 * @param userNo  : 등록하는 사람의 userno
	 * @return
	 * @throws Exception
	 */
	public int modifyComplate(DataMap fileMap, String innoSaveDir, String wcomments, int photoNo, String imgPath, String date) throws Exception{

		int returnValue = 0;
		DataMap imagePath = null;
        
        try {
			DataMap insertMap = new DataMap(); //파일 저장 메소드에 전송될 Map
			
			
			imagePath = webzineMapper.selectComplateRow(photoNo);
			
//			if(!imagePath.getString("imgName").equals(fileMap.getString("existFile"))){
			if(!imagePath.getString("photoNo").equals(fileMap.getString("existFile"))){

				//기존파일과 다르거나 또는 삭제되었을경우 
				String dir = imagePath.getString("imgPath");
				FileUtil.deleteFile(dir);
				
				if(fileMap.keySize("fileSysName") == 0 && fileMap.keySize("fileUploadOk") == 0){
					returnValue = webzineMapper.deleteComplate(photoNo); //파일 내용 삭제.
				}
				//신규로 넘어온 파일 처리.
				for (int i=0; i < fileMap.keySize("fileSysName"); i++){
					
					String orgFileName = fileMap.getString("fileSysName", i); //업로드된 파일명
					String changeFileName = DateUtil.getDateTimeMinSec() + i; //실제 저장되는 파일명. (현재시간 + i)
					String realDir = SpringUtils.getRealPath() + Constants.UPLOAD + innoSaveDir; //파일 존재 위치 경로. /pds/inno/common/ 등.
					
					//저장된 파일.
					File orgFile = new File(realDir + orgFileName);
					if ( orgFile.exists() ) //파일 이름 변경
						orgFile.renameTo(new File( realDir + changeFileName));
					
					//초기화.
					insertMap.clear();
					insertMap.setNullToInitialize(true);
					
					//신규 파일 정보 셋팅.
					insertMap.add("filePath", innoSaveDir + changeFileName);
					insertMap.add("fileName", orgFileName);
					insertMap.add("wcomments", wcomments);
					if(!date.equals("")){
						//년도 데이터가 있을시
						insertMap.add("date", date);
						
					}else{
						//년도 데이터가 없을시 현재년도로 만든다.
						insertMap.add("date", DateUtil.getDateYyyyMm());
					}
					
					insertMap.setInt("photoNo", photoNo);
					
					returnValue = webzineMapper.modifyComplate(insertMap); //파일 내용 저장.
				}
				
				for(int i=0; i<fileMap.keySize("fileUploadOk"); i++){
					
					String fileName = fileMap.getString("file_fileName", i); //업로드된 파일명
					String orgFileName = fileMap.getString("file_fileOrgName", i); //업로드전 파일명
					String changeFileName = DateUtil.getDateTimeMinSec() + i; //실제 저장되는 파일명. (현재시간 + i)
					String realDir = SpringUtils.getRealPath() + Constants.UPLOAD + innoSaveDir; //파일 존재 위치 경로. /pds/inno/common/ 등.
					String fileSize = fileMap.getString("file_fileSize", i); //파일 사이즈.
					
					//저장된 파일.
					File orgFile = new File(realDir + fileName);
					if ( orgFile.exists() ) //파일 이름 변경
						orgFile.renameTo(new File( realDir + changeFileName));
					
					
					//초기화.
					insertMap.clear();
					insertMap.setNullToInitialize(true);
					
					//신규 파일 정보 셋팅.
					insertMap.add("filePath", innoSaveDir + changeFileName);
					insertMap.add("fileName", orgFileName);
					insertMap.add("wcomments", wcomments);
					if(!date.equals("")){
						//년도 데이터가 있을시
						insertMap.add("date", date);
						
					}else{
						//년도 데이터가 없을시 현재년도로 만든다.
						insertMap.add("date", DateUtil.getDateYyyyMm());
					}
					
					insertMap.setInt("photoNo", photoNo);
					
					returnValue = webzineMapper.modifyComplate(insertMap); //파일 내용 저장.
					
				}
			}else{
				Map<String, Object> params = new HashMap<String, Object>();
				params.put("wcomments", wcomments);
				params.put("date", DateUtil.getDateYyyyMm());
				params.put("photoNo", photoNo);
				returnValue = webzineMapper.modifyHoldComplate(params); //파일 내용 저장.
			}
			
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	returnValue = 1;
        }
        return returnValue;        
	}
	
	/**
	 * Ebook관리 데이터 List
	 * 작성자 정윤철
	 * 작성일 7월 04일
	 * @param pagingInfoMap
	 * @return selectFaqList
	 * @throws Exception
	 */
	public DataMap selectEbookList(DataMap pagingInfoMap) throws Exception{
			
	    DataMap resultMap = null;
	    
	    try {
	    	
	    	int totalCnt = webzineMapper.selectEbookListCount(pagingInfoMap);
        	
        	Map<String, Object> pageInfo = Util.getPageInfo(totalCnt, pagingInfoMap);
        	
        	pagingInfoMap.set("page", pageInfo);
        	
        	resultMap = webzineMapper.selectEbookList(pagingInfoMap);
            
            PageNavigation pageNavi = Util.getPageNavigation(pageInfo);
		    resultMap.set("PAGE_INFO", pageNavi);
	        
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return resultMap;        
	}

	
	/**
	 * Ebook관리 데이터 Row
	 * 작성자 정윤철
	 * 작성일 7월 04일
	 * @param pagingInfoMap
	 * @return selectFaqList
	 * @throws Exception
	 */
	public DataMap selectEbookRow(int ebookNo) throws Exception{
			
	    DataMap resultMap = null;
	    
	    try {
	    	
	        resultMap = webzineMapper.selectEbookRow(ebookNo);
	        
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return resultMap;        
	}

	
	/**
	 * Ebook관리 데이터 등록
	 * 작성자 정윤철
	 * 작성일 7월 04일
	 * @param fileMap : 파일 정보가 들어있는 MAP
	 * @param innoSaveDir : 저장하는 경로 (/inno/common/... /inno/course/)
	 * @param userNo  : 등록하는 사람의 userno
	 * @return
	 * @throws Exception
	 */
	public int insertEbook(DataMap fileMap, DataMap requestMap) throws Exception{
		
		int returnValue = 0;
        
        try {
			
			DataMap insertMap = new DataMap(); //파일 저장 메소드에 전송될 Map
			
			//신규로 넘어온 파일 처리.
			for (int i=0; i < fileMap.keySize("fileSysName"); i++){
				
				String orgFileName = fileMap.getString("fileSysName", i); //업로드된 파일명
				String changeFileName = DateUtil.getDateTimeMinSec() + i; //실제 저장되는 파일명. (현재시간 + i)
				String realDir = SpringUtils.getRealPath() + Constants.UPLOAD + requestMap.getString("INNO_SAVE_DIR"); //파일 존재 위치 경로. /pds/inno/common/ 등.
				
				//저장된 파일.
				File orgFile = new File(realDir + orgFileName);
				if ( orgFile.exists() ) //파일 이름 변경
					orgFile.renameTo(new File( realDir + changeFileName));
				
				//초기화.
				insertMap.clear();
				insertMap.setNullToInitialize(true);
				
				//신규 파일 정보 셋팅.
				insertMap.add("ebookTitle", requestMap.getString("ebookTitle"));
				insertMap.add("ebookAuth", requestMap.getString("ebookAuth"));
				insertMap.add("filePath", requestMap.getString("INNO_SAVE_DIR") + changeFileName);
				insertMap.add("fileName", orgFileName);
				insertMap.add("grseq", requestMap.getString("grseq").substring(0,4)+"-"+requestMap.getString("grseq").substring(4,6)+"-"+requestMap.getString("grseq").substring(6,8));
				insertMap.add("ebookPage", requestMap.getString("ebookPage"));
				insertMap.add("ebookLink", requestMap.getString("ebookLink"));
				insertMap.add("useYn", requestMap.getString("useYn"));
				
				returnValue = webzineMapper.insertEbook(insertMap); //파일 내용 저장.
			}
			
			for(int i=0; i<fileMap.keySize("fileUploadOk"); i++){
				
				String fileName = fileMap.getString("file_fileName", i); //업로드된 파일명
				String orgFileName = fileMap.getString("file_fileOrgName", i); //업로드전 파일명
				String changeFileName = DateUtil.getDateTimeMinSec() + i; //실제 저장되는 파일명. (현재시간 + i)
				String realDir = SpringUtils.getRealPath() + Constants.UPLOAD +  requestMap.getString("INNO_SAVE_DIR"); //파일 존재 위치 경로. /pds/inno/common/ 등.
				String fileSize = fileMap.getString("file_fileSize", i); //파일 사이즈.
				
				//저장된 파일.
				File orgFile = new File(realDir + fileName);
				if ( orgFile.exists() ) //파일 이름 변경
					orgFile.renameTo(new File( realDir + changeFileName));
				
				
				//초기화.
				insertMap.clear();
				insertMap.setNullToInitialize(true);
				
				//신규 파일 정보 셋팅.
				insertMap.add("ebookTitle", requestMap.getString("ebookTitle"));
				insertMap.add("ebookAuth", requestMap.getString("ebookAuth"));
				insertMap.add("filePath", requestMap.getString("INNO_SAVE_DIR") + changeFileName);
				insertMap.add("fileName", orgFileName);
				insertMap.add("grseq", requestMap.getString("grseq").substring(0,4)+"-"+requestMap.getString("grseq").substring(4,6)+"-"+requestMap.getString("grseq").substring(6,8));
				insertMap.add("ebookPage", requestMap.getString("ebookPage"));
				insertMap.add("ebookLink", requestMap.getString("ebookLink"));
				insertMap.add("useYn", requestMap.getString("useYn"));
				
				returnValue = webzineMapper.insertEbook(insertMap); //파일 내용 저장.
				
			}
			
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	returnValue = 1;
        }
        return returnValue;        
	}
	
	/**
	 * Ebook관리 데이터 수정 및 삭제
	 * 작성자 정윤철
	 * 작성일 7월 04일
	 * @param fileMap : 파일 정보가 들어있는 MAP
	 * @param innoSaveDir : 저장하는 경로 (/inno/common/... /inno/course/)
	 * @param userNo  : 등록하는 사람의 userno
	 * @return
	 * @throws Exception
	 */
	public int modifyEbook(DataMap fileMap, DataMap requestMap) throws Exception{
		int returnValue = 0;
		DataMap imagePath = null;
        Connection con = null;
        
        
        
        try {
			
			DataMap insertMap = new DataMap(); //파일 저장 메소드에 전송될 Map
			
			
			imagePath = webzineMapper.selectEbookRow(requestMap.getInt("ebookNo"));
			
			if(!imagePath.getString("imgName").equals(fileMap.getString("existFile"))){
				
				//기존파일과 다르거나 또는 삭제되었을경우 
				String dir = imagePath.getString("imgPath");
				FileUtil.deleteFile(dir);
				
				if(fileMap.getString("fileSysName").equals("")){
					returnValue = webzineMapper.deleteEbook(requestMap.getInt("ebookNo")); //파일 내용 삭제.
					
				}
				
				
				
				//신규로 넘어온 파일 처리.
				for (int i=0; i < fileMap.keySize("fileSysName"); i++){
					
					String orgFileName = fileMap.getString("fileSysName", i); //업로드된 파일명
					String changeFileName = DateUtil.getDateTimeMinSec() + i; //실제 저장되는 파일명. (현재시간 + i)
					String realDir = SpringUtils.getRealPath() + Constants.UPLOAD + requestMap.getString("INNO_SAVE_DIR"); //파일 존재 위치 경로. /pds/inno/common/ 등.
					
					//저장된 파일.
					File orgFile = new File(realDir + orgFileName);
					if ( orgFile.exists() ) //파일 이름 변경
						orgFile.renameTo(new File( realDir + changeFileName));
					
					//초기화.
					insertMap.clear();
					insertMap.setNullToInitialize(true);
					
					//신규 파일 정보 셋팅.
					insertMap.add("ebookTitle", requestMap.getString("ebookTitle"));
					insertMap.add("ebookAuth", requestMap.getString("ebookAuth"));
					insertMap.add("filePath", requestMap.getString("INNO_SAVE_DIR") + changeFileName);
					insertMap.add("fileName", orgFileName);
					insertMap.add("ebookLink", requestMap.getString("ebookLink"));
					insertMap.add("useYn", requestMap.getString("useYn"));
					insertMap.add("grseq", requestMap.getString("grseq"));
					insertMap.add("ebookPage", requestMap.getString("ebookPage"));
					insertMap.add("ebookNo", requestMap.getString("ebookNo"));
					returnValue = webzineMapper.modifyEbook(insertMap); //파일 내용 저장.
				}
			}else{//기존파일을 수정하지 안았을경우
				returnValue = webzineMapper.modifyHoldEbook(requestMap); //파일을뺀 내용만 저장
			}
			
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	returnValue = 1;
        }
        return returnValue;        
	}
	
	

	/**
	 * Ebook관리 데이터 삭제
	 * 작성자 정윤철
	 * 작성일 9월 05일
	 * @param userNo  
	 * @return
	 * @throws Exception
	 */
	public int deleteEbook(DataMap requestMap) throws Exception{
		int returnValue = 0;
		DataMap imagePath = null;
        
        try {
			
			imagePath = webzineMapper.selectEbookRow(requestMap.getInt("ebookNo"));
			
				
			//기존파일과 다르거나 또는 삭제되었을경우 
			String dir = imagePath.getString("imgPath");
			FileUtil.deleteFile(dir);
			returnValue = webzineMapper.deleteEbook(requestMap.getInt("ebookNo")); //파일 내용 삭제.
			
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	returnValue = 1;
        }
        return returnValue;        
	}

}
