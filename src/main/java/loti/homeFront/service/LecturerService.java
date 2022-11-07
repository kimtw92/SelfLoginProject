package loti.homeFront.service;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.StringTokenizer;

import loti.common.mapper.CommonMapper;
import loti.common.service.CommonService;
import loti.homeFront.mapper.LecturerMapper;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import ut.lib.exception.BizException;
import ut.lib.file.FileUtil;
import ut.lib.support.DataMap;
import ut.lib.util.Message;
import ut.lib.util.Util;

import common.service.BaseService;


@Service
public class LecturerService extends BaseService {

	@Autowired
	private LecturerMapper lecturerMapper;
	
	@Autowired
	private CommonService commonService;
	
	@Autowired
	private CommonMapper commonMapper;
	
	@Transactional
	public int insertLecturer(DataMap p_requestMap) throws Exception{
	    int resultCode = -1;
	    try {
	        p_requestMap.setString("seqno", lecturerMapper.nextLecturerSeqno());
		    //등록 및 수정시만 파일 업로드 처리.
	        int fileGroupNo = -1;				
			//파일 등록.
			DataMap fileMap = (DataMap)p_requestMap.get("UPLOAD_FILE");
			if(fileMap == null) fileMap = new DataMap();
			fileMap.setNullToInitialize(true);
			if(fileMap.keySize("fileSysName") > 0 || fileMap.keySize("existFile") > 0 || fileMap.keySize("deleteFile") > 0 || fileMap.keySize("fileUploadOk") > 0) {
				fileGroupNo = commonService.insertInnoUploadFile(fileMap, p_requestMap.getString("INNO_SAVE_DIR"), "L" +p_requestMap.getString("seqno"));
				p_requestMap.setString("groupfile_no", String.valueOf(fileGroupNo));
			}
	        resultCode = lecturerMapper.insertLecturer(p_requestMap);      
	        if(resultCode > 0) {
		        // 학력, 전공분야, 경력사항, 저서 및 주요논문
	            StringTokenizer stOcinfo1 = new StringTokenizer( p_requestMap.getString("stOcinfo1"), "|#|" );
	            StringTokenizer stOcinfo2 = new StringTokenizer( p_requestMap.getString("stOcinfo2"), "|#|" );
	            StringTokenizer stOcinfo3 = new StringTokenizer( p_requestMap.getString("stOcinfo3"), "|#|" );
	            StringTokenizer stOcinfo4 = new StringTokenizer( p_requestMap.getString("stOcinfo4"), "|#|" );
	            
	            int ocinfoCount1 = stOcinfo1.countTokens();
	            int ocinfoCount2 = stOcinfo2.countTokens();
	            int ocinfoCount3 = stOcinfo3.countTokens();
	            int ocinfoCount4 = stOcinfo4.countTokens();
	            String tmpOcinfo = "";
	
	            for(int i=0; i < ocinfoCount1; i++){
	            	tmpOcinfo = stOcinfo1.nextToken();
	            	if(!"".equals(tmpOcinfo)) {
	            		Map<String, Object> params = new HashMap<String, Object>();
	            		params.put("seqno", p_requestMap.getString("seqno"));
	            		params.put("ocno", "1");
	            		params.put("ocgubun", String.valueOf(i));
	            		params.put("ocinfo", tmpOcinfo);
	            		lecturerMapper.insertLecturerHistory(params);
	            	}
	            }       
	            for(int i=0; i < ocinfoCount2; i++){
	            	tmpOcinfo = stOcinfo2.nextToken();
	            	if(!"".equals(tmpOcinfo)) {
	            		Map<String, Object> params = new HashMap<String, Object>();
	            		params.put("seqno", p_requestMap.getString("seqno"));
	            		params.put("ocno", "2");
	            		params.put("ocgubun", String.valueOf(i));
	            		params.put("ocinfo", tmpOcinfo);
	            		lecturerMapper.insertLecturerHistory(params);
	            	}
	            }
	            for(int i=0; i < ocinfoCount3; i++){
	            	tmpOcinfo = stOcinfo3.nextToken();
	            	if(!"".equals(tmpOcinfo)) {
	            		Map<String, Object> params = new HashMap<String, Object>();
	            		params.put("seqno", p_requestMap.getString("seqno"));
	            		params.put("ocno", "3");
	            		params.put("ocgubun", String.valueOf(i));
	            		params.put("ocinfo", tmpOcinfo);
	            		lecturerMapper.insertLecturerHistory(params);
	            	}
	            }
	            for(int i=0; i < ocinfoCount4; i++){
	            	tmpOcinfo = stOcinfo4.nextToken();
	            	if(!"".equals(tmpOcinfo)) {
	            		Map<String, Object> params = new HashMap<String, Object>();
	            		params.put("seqno", p_requestMap.getString("seqno"));
	            		params.put("ocno", "4");
	            		params.put("ocgubun", String.valueOf(i));
	            		params.put("ocinfo", tmpOcinfo);
	            		lecturerMapper.insertLecturerHistory(params);
	            	}
	            }
	        }
	    } catch (SQLException e) {
	    	throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return resultCode;        
	}
	
	@Transactional
	public int updateLecturer(DataMap p_requestMap) throws Exception{
	    int resultCode = -1;
	    try {
		    //등록 및 수정시만 파일 업로드 처리.
	        int fileGroupNo = -1;				
			//파일 등록.
			DataMap fileMap = (DataMap)p_requestMap.get("UPLOAD_FILE");
			if(fileMap == null) fileMap = new DataMap();
			fileMap.setNullToInitialize(true);
			if(fileMap.keySize("fileSysName") > 0 || fileMap.keySize("existFile") > 0 || fileMap.keySize("deleteFile") > 0 || fileMap.keySize("fileUploadOk") > 0) {
				fileGroupNo = commonService.insertInnoUploadFile(fileMap, p_requestMap.getString("INNO_SAVE_DIR"), "L" +p_requestMap.getString("seqno"));
				p_requestMap.setString("groupfile_no", String.valueOf(fileGroupNo));
			}
	        resultCode = lecturerMapper.updateLecturer(p_requestMap);      
	        if(resultCode > 0) {
	        	lecturerMapper.deleteLecturerHistory(p_requestMap.getString("seqno"));
		        // 학력, 전공분야, 경력사항, 저서 및 주요논문
	            StringTokenizer stOcinfo1 = new StringTokenizer( p_requestMap.getString("stOcinfo1"), "|#|" );
	            StringTokenizer stOcinfo2 = new StringTokenizer( p_requestMap.getString("stOcinfo2"), "|#|" );
	            StringTokenizer stOcinfo3 = new StringTokenizer( p_requestMap.getString("stOcinfo3"), "|#|" );
	            StringTokenizer stOcinfo4 = new StringTokenizer( p_requestMap.getString("stOcinfo4"), "|#|" );
	            
	            int ocinfoCount1 = stOcinfo1.countTokens();
	            int ocinfoCount2 = stOcinfo2.countTokens();
	            int ocinfoCount3 = stOcinfo3.countTokens();
	            int ocinfoCount4 = stOcinfo4.countTokens();
	            String tmpOcinfo = "";
	
	            for(int i=0; i < ocinfoCount1; i++){
	            	tmpOcinfo = stOcinfo1.nextToken();
	            	if(!"".equals(tmpOcinfo)) {
	            		Map<String, Object> params = new HashMap<String, Object>();
	            		params.put("seqno", p_requestMap.getString("seqno"));
	            		params.put("ocno", "1");
	            		params.put("ocgubun", String.valueOf(i));
	            		params.put("ocinfo", tmpOcinfo);
	            		lecturerMapper.insertLecturerHistory(params);
	            	}
	            }       
	            for(int i=0; i < ocinfoCount2; i++){
	            	tmpOcinfo = stOcinfo2.nextToken();
	            	if(!"".equals(tmpOcinfo)) {
	            		Map<String, Object> params = new HashMap<String, Object>();
	            		params.put("seqno", p_requestMap.getString("seqno"));
	            		params.put("ocno", "2");
	            		params.put("ocgubun", String.valueOf(i));
	            		params.put("ocinfo", tmpOcinfo);
	            		lecturerMapper.insertLecturerHistory(params);
	            	}
	            }
	            for(int i=0; i < ocinfoCount3; i++){
	            	tmpOcinfo = stOcinfo3.nextToken();
	            	if(!"".equals(tmpOcinfo)) {
	            		Map<String, Object> params = new HashMap<String, Object>();
	            		params.put("seqno", p_requestMap.getString("seqno"));
	            		params.put("ocno", "3");
	            		params.put("ocgubun", String.valueOf(i));
	            		params.put("ocinfo", tmpOcinfo);
	            		lecturerMapper.insertLecturerHistory(params);
	            	}
	            }
	            for(int i=0; i < ocinfoCount4; i++){
	            	tmpOcinfo = stOcinfo4.nextToken();
	            	if(!"".equals(tmpOcinfo)) {
	            		Map<String, Object> params = new HashMap<String, Object>();
	            		params.put("seqno", p_requestMap.getString("seqno"));
	            		params.put("ocno", "3");
	            		params.put("ocgubun", String.valueOf(i));
	            		params.put("ocinfo", tmpOcinfo);
	            		lecturerMapper.insertLecturerHistory(params);
	            	}
	            }
	        }
	    } catch (SQLException e) {
	    	throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return resultCode;        
	}
	
	public DataMap getLecturerSearch(String p_name, String p_birth, String p_password) throws Exception{
		
		DataMap resultMap = null;
	    
	    try {
	    	
	    	Map<String, Object> params = new HashMap<String, Object>();
	    	
	    	params.put("name", p_name);
	    	params.put("birth", p_birth);
	    	params.put("password", p_password);
	    	
	        resultMap = lecturerMapper.getLecturerSearch(params);
	                                
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return resultMap;        
	}
	
	public DataMap getLecturerView(String p_seqno, String p_name, String p_birth, String p_password) throws Exception{
		
		DataMap resultMap = null;
	    
	    try {
	    	
	    	Map<String, Object> params = new HashMap<String, Object>();
	    	
	    	params.put("seqno", p_seqno);
	    	params.put("name", p_name);
	    	params.put("birth", p_birth);
	    	params.put("password", p_password);
	    	
	        resultMap = lecturerMapper.getLecturerView(params);
	                                
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return resultMap;        
	}
	
	public DataMap getLecturerView(String p_seqno) throws Exception{
		
		DataMap resultMap = null;
	    
	    try {
	    	
	        resultMap = lecturerMapper.getLecturerView2(p_seqno);
	                                
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return resultMap;        
	}
	
	
	public String getLecturerFileNo(String p_seqno, String p_name, String p_birth, String p_password) throws Exception{
		
	    DataMap resultMap = null;
	    String groupFileNo = "";
	    try {
	    	
	    	Map<String, Object> params = new HashMap<String, Object>();
	    	
	    	params.put("seqno", p_seqno);
	    	params.put("name", p_name);
	    	params.put("birth", p_birth);
	    	params.put("password", p_password);
	    	
	    	resultMap = lecturerMapper.getLecturerFileNo(params);
	        groupFileNo = resultMap.get("groupfileno")+"";
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return groupFileNo;        
	}
	
	public String getLecturerFileNo(String p_seqno) throws Exception{
		
	    DataMap resultMap = null;
	    String groupFileNo = "";
	    try {
	    	
	        resultMap = lecturerMapper.getLecturerFileNo2(p_seqno);
	        groupFileNo = resultMap.get("groupfileno")+"";
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return groupFileNo;        
	}
	
	public DataMap lecturerHistoryList(String p_seqno, String p_ocgubun) throws Exception{
		
		DataMap resultMap = null;
	    
	    try {
	    	
	    	Map<String, Object> params = new HashMap<String, Object>();
	    	
	    	params.put("seqno", p_seqno);
	    	params.put("ocgubun", p_ocgubun);
	    	
	        resultMap = lecturerMapper.lecturerHistoryList(params);
	                                
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return resultMap;        
	}
	
	public int deleteLecturer(String p_seqno) throws Exception{
		
	    int error_code = -1;
	    try {
	    	
	        error_code = lecturerMapper.deleteLecturer(p_seqno);
	        if(error_code > 0) { // 성공시 무저건 삭제
	        	lecturerMapper.deleteLecturerHistory(p_seqno);
	        }
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return error_code;        
	}
	
	@Transactional
	public void deleteFileInfo(int orgGroupFileNo)  throws Exception{
		try {
	    	
			//실제 저장된 기존 파일 제거 및 DB에 기존 groupFileNo 로 DB제거.
			if(orgGroupFileNo > 0){
				DataMap orgFileListMap = commonMapper.selectUploadFileList(orgGroupFileNo);
				if( orgFileListMap == null)
					orgFileListMap = new DataMap();
				orgFileListMap.setNullToInitialize(true);
				try{
					int orgFileNo = 0;			//수정 기존 파일의 fileNo
					String orgFileNoStr = "";
					//DB의 기존 파일의 모든 정보
					for(int i=0; i < orgFileListMap.keySize("fileNo"); i++){
						boolean isExist = false;
						int tempInt = orgFileListMap.getInt("fileNo", i);
						String[] value = orgFileNoStr.split(","); //기존 파일의 존재 값
						orgGroupFileNo = Integer.parseInt(value[0]); 
						orgFileNo = Integer.parseInt(value[1]);
						if(orgFileNoStr.equals(""))
							orgFileNoStr = ""+orgFileNo;
						else
							orgFileNoStr += ","+orgFileNo;
						
						for(int j = 0; j < value.length; j++){
							if(tempInt == Util.getIntValue(value[j], 0)){
								isExist = true;
								break;
							}
						}
						//기존 파일과 넘어온 파일이 일치 하지 않으면 기존 파일 삭제.
						if(!isExist)
							FileUtil.deleteFile(orgFileListMap.getString("filePath", i));						
					}
				}catch(Exception e){
					System.out.println(" ###### 기존 삭제시 에러 발생됐음.");
				}finally{
					commonMapper.deleteUploadGroupFileNo(orgGroupFileNo);  
				}
			}
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	}

}
