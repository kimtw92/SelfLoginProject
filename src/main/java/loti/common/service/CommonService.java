package loti.common.service;

import java.io.File;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import loti.common.mapper.CommonMapper;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import ut.lib.exception.BizException;
import ut.lib.file.FileUtil;
import ut.lib.support.DataMap;
import ut.lib.util.Constants;
import ut.lib.util.DateUtil;
import ut.lib.util.Message;
import ut.lib.util.SpringUtils;
import ut.lib.util.Util;
import common.service.BaseService;

/**
 * 공통으로 사용할 service 클래스
 * 상단 메뉴 및 좌측 메뉴 같이 여러곳에서 공통으로 사용
 * 
 * @author 이용문
 *
 */
@Service
public class CommonService extends BaseService{

	public CommonService(){}

	@Autowired
	private CommonMapper commonMapper;
	
	/**
	 * 상단 메뉴
	 * @param menuGrade
	 * @return
	 * @throws BizException
	 */
	public DataMap selectTopMenu(String menuGrade) throws BizException{
		
		DataMap resultMap = null;
        
        try {
        	
            resultMap = commonMapper.selectTopMenu(menuGrade);
            
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
	
	/**
	 * 좌측 메뉴 리스트
	 * @param menuGrade
	 * @param menuDepth1
	 * @return
	 * @throws BizException
	 */
	public DataMap selectLeftMenu(String menuGrade, int menuDepth1) throws BizException{
		
		DataMap resultMap = null;
        
        try {
        	
        	Map<String,Object> params = Util.valueToMap("menuGrade", menuGrade, "menuDepth1", menuDepth1);
        	
            resultMap = commonMapper.selectLeftMenu(params);                   
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
	
	/**
	 * 좌측 서브 메뉴 리스트
	 * @param menuGrade
	 * @param menuDepth1
	 * @param menuDepth2
	 * @return
	 * @throws BizException
	 */
	public DataMap selectLeftSubMenu(String menuGrade, int menuDepth1, int menuDepth2) throws BizException{
		
		DataMap resultMap = null;
        
        try {
        	
        	Map<String, Object> params = Util.valueToMap(
										        				"menuGrade", menuGrade
										        				, "menuDepth1", menuDepth1
										        				, "menuDepth2", menuDepth2
										        			);
        	
            resultMap = commonMapper.selectLeftSubMenu(params);                   
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
	
	
	/**
	 * 좌측 메뉴 전체.
	 * @param menuGrade
	 * @param menuDepth1
	 * @return
	 * @throws BizException
	 */
	public DataMap selectTotalLeftMenu(String menuGrade, int menuDepth1) throws BizException{
		
		DataMap resultMap = null;
        
        try {
        	
        	Map<String,Object> params = Util.valueToMap("menuGrade", menuGrade, "menuDepth1", menuDepth1);
        	
            resultMap = commonMapper.selectTotalLeftMenu(params);                   
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
	
	/**
	 * 현재 메뉴 이름	
	 * @param menuGrade
	 * @param menuDepth1
	 * @param menuDepth2
	 * @param menuDepth3
	 * @return
	 * @throws BizException
	 */
	public DataMap selectCurrentMenuName(String menuGrade, int menuDepth1, int menuDepth2, int menuDepth3) throws BizException{
		
		DataMap resultMap = null;
        
        try {
        	
        	Map<String, Object> params = Util.valueToMap(
        														"menuGrade", menuGrade
        														, "menuDepth1", menuDepth1
        														, "menuDepth2", menuDepth2
        														, "menuDepth3", menuDepth3
        													);
        	
            resultMap = commonMapper.selectCurrentMenuName(params);                   
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
	
	
	
	/**
	 * 네비게이션 정보
	 * @param menuGrade
	 * @param menuDepth1
	 * @return
	 * @throws BizException
	 */
	public DataMap selectNavigationMenu(String menuGrade, int menuDepth1, int menuDepth2, int menuDepth3) throws BizException{
		
		DataMap resultMap = null;
        
        try {
        	
        	Map<String, Object> params = Util.valueToMap(
        				"menuGrade", menuGrade
        				, "menuDepth1", menuDepth1
        				, "menuDepth2", menuDepth2
        				, "menuDepth3", menuDepth3
        			);
        	
            resultMap = commonMapper.selectNavigationMenu(params);                   
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
	
	/**
	 * Left Menu 과정리스트
	 * @param year
	 * @param sessGubun
	 * @param sessUserNo
	 * @param sessCurrentAuth
	 * @return
	 * @throws BizException
	 */
	public DataMap selectGrCode(String year, String sessGubun, String sessUserNo, String sessCurrentAuth) throws BizException{
		
		DataMap resultMap = null;
        
        try {
        	
            if(sessCurrentAuth.equals("7")){
            	// 강사권한일때
            	Map<String, Object> params = new HashMap<String, Object>();
            	params.put("userNo", sessUserNo);
            	params.put("year", year);
            	resultMap = commonMapper.selectGrCodeByTutor(params);
            }else{
            	Map<String, Object> params = new HashMap<String, Object>();
            	params.put("year", year);
            	
    			if(sessGubun.equals("1")){
    				// 진행과정
    				resultMap = commonMapper.selectGrCodeByIng(params);
    			}else{
    				// 전체과정
    				resultMap = commonMapper.selectGrCodeByAll(params);
    			}
            	
            }
                        
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
	
	/**
	 * Left Menu 기수 리스트
	 * @param year
	 * @param grCode
	 * @param userNo
	 * @param currentAuth
	 * @return
	 * @throws BizException
	 */
	public DataMap selectGrSeq(String year, String grCode, String userNo, String currentAuth) throws BizException{
		
		DataMap resultMap = null;
        
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("year", year);
		param.put("grCode", grCode);
		param.put("userNo", userNo);
		
		String where = "";
		if(!"".equals(grCode)) {
			where = " AND 	GRCODE = '"+grCode+"' ";	
		}
		
		param.put("where", where);
		
        try {
        	
            if(currentAuth.equals("7")){
            	// 강사권한일때            	
            	resultMap = commonMapper.selectGrSeqByTutor(param);
            }else{
            	resultMap = commonMapper.selectGrSeq(param);
            }            
            
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
	
	/**
	 * Cyber 과정의 기수 정보 리스트
	 * @param year
	 * @return
	 * @throws BizException
	 */
	public DataMap selectGrSeqByCyber(String year) throws BizException{
		
		DataMap resultMap = null;
        
        try {
        	
            resultMap = commonMapper.selectGrSeqByCyber(year);
            
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
	
	
	/**
	 * Left Menu 과목 리스트
	 * @param grCode
	 * @param grSeq
	 * @return
	 * @throws BizException
	 */
	public DataMap selectSubj(String grCode, String grSeq) throws BizException{
		
		DataMap resultMap = null;
        
        Map<String, Object> param = new HashMap<String, Object>();
        
        param.put("grCode", grCode);
        param.put("grSeq", grSeq);
        
        try {
                           
            resultMap = commonMapper.selectSubj(param);
            
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
	
	
	/**
	 * 파일 가져오기
	 * @param groupfileNo
	 * @return
	 * @throws BizException
	 */
	public DataMap selectUploadFileList(int groupFileNo) throws BizException{
		
		DataMap resultMap = null;
        
        try {
        	
            resultMap = commonMapper.selectUploadFileList(groupFileNo);
            
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
	/**
	 * 파일정보 가져오기.
	 * @param groupfileNo
	 * @param fileNo
	 * @return
	 * @throws BizException
	 */
	public DataMap selectUploadFileRow(int groupFileNo, int fileNo) throws BizException{
		
		DataMap resultMap = null;
        
        try {
        	
        	Map<String,Object> params = Util.valueToMap("groupFileNo", groupFileNo, "fileNo", fileNo);
        	
            resultMap = commonMapper.selectUploadFileRow(params);
            
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
	
	
	
	/**
	 * 유저의 이름을 검색 한다.
	 * @param userNo
	 * @return
	 * @throws BizException
	 */
	public String selectUserNameString(String userNo) throws BizException{
		
        String returnValue = "";
        
        try {
        	
            returnValue = commonMapper.selectUserNameString(userNo);
            
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return returnValue;        
	}
	

	/**
	 * 파일정보 가져오기.
	 * @param searchMap 	검색할 데이터 들어있는 map (list,row 형태로 들어옴.)
	 * @param key 			검색할 데이터의 가져올 컬럼값
	 * @param addName		검색할 데이터의 추가되는 이름
	 * @return
	 * @throws BizException
	 */
	public DataMap selectUploadFileList(DataMap searchMap) throws BizException{
		return selectUploadFileList(searchMap, "groupfileNo", "FILE_GROUP_LIST");
	}
	public DataMap selectUploadFileList(DataMap searchMap, String key) throws BizException{
		return selectUploadFileList(searchMap, key, "FILE_GROUP_LIST");
	}
	public DataMap selectUploadFileList(DataMap searchMap, String key, String addName) throws BizException{
		
        try {
        	
            if (searchMap != null){
            	searchMap.setNullToInitialize(true);
            	
            	//파일 정보 담기.
            	if(searchMap.keySize(key) > 0)
            		for(int i=0; i < searchMap.keySize(key); i++)
            			searchMap.add(addName, commonMapper.selectUploadFileList(searchMap.getInt(key, i)));
            	else //비여 있으면 cast Error로 인하여 BizException 처리.
            		searchMap.add(addName, new DataMap());
            }
            
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return searchMap;        
	}
	
	
	/**
	 * 주소 검색 
	 * 작성일 5월 26일
	 * 작성자 정윤철
	 * @return
	 * @throws BizException
	 */
	public DataMap selectSearchZip(String addrStr) throws BizException{
		
		DataMap resultMap = null;
        
        try {
           
        	resultMap = commonMapper.selectSearchZip(addrStr);
            
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
	/**
	 * 첫번째 주소검색 후 선택된 주소의 리스트 값을 가져오기위해서 사용한다.
	 * 작성일 5월 26일
	 * 작성자 정윤철
	 * @return
	 * @throws BizException
	 */
	public DataMap selectSearchZip(String zipCode1,String zipCode2) throws BizException{
		
		DataMap resultMap = null;
        
        try {
        	
        	Map<String, Object> params = Util.valueToMap("zipCode1", zipCode1, "zipCode2", zipCode2);
        	
        	resultMap = commonMapper.selectTwoSearchZip(params);
            
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
	
	
	/**
	 * INNO 에서 넘어온 파일을 rename 시킨후 파일 등록 처리하는 메소드.
	 * 
	 * @param fileMap : 파일 정보가 들어있는 MAP
	 * @param innoSaveDir : 저장하는 경로 (/inno/common/... /inno/course/)
	 * @param userNo  : 등록하는 사람의 userno
	 * @return
	 * @throws BizException
	 */
	@Transactional
	public int insertInnoUploadFile(DataMap fileMap, String innoSaveDir, String userNo) throws BizException{
		
		if(fileMap == null)
			return -1;
		else
			fileMap.setNullToInitialize(true);
		
        int maxGroupFileNo = -1; //등록된 fileGroupNo
        
        try {
			
			maxGroupFileNo = commonMapper.selectMaxGroupFileNo(); //Max GroupFileNo
			
			int fileCnt = 1; //insert 되는 fileNo 값  (fileCnt++ 로 증가됨)
			
			int orgGroupFileNo = 0; 	//기존 파일의 GroupFileNo
			int orgFileNo = 0;			//수정 기존 파일의 fileNo
			String orgFileNoStr = "";	//수정시 기존 파일의 fileNo의 내용을 담을 변수 1,3,7
			
			
			// 1. 기존 파일에서 넘어온 존재 여부 파일이 있는지 확인한다.
			// 2. 존재 파일이 있을경우는 새로운 GroupFileNo 에 기존 파일 정보를 추가 시킨다.
			// 3. 기존 파일에서 삭제 파일이 있는경우는 기존 파일이 존재 하는 orgGroupFileNo 만 알려준다. (모든 파일이 삭제되고 존재되는 파일이 없을경우를 대비)
			// 4. 기존 파일 정보(orgGroupFileNo)가 있을 경우 존재 파일을 제외한 나머지 파일들을 삭제 시킨다.
			// 5. 기존 파일의 DB정보를 삭제 한다.
			// 6. 신규로 넘어온 파일이 있을경우는 새로운 GroupFileNo 에 등록시킨다(존재파일의 등록되는 새로운 groupFileNo 와 같음)
			// 7. fileCnt 가 사용되었는지 검사하여 (존재파일복사나 신규로 넘어온 파일이 있다면) 파일등록이 되었늕지를 반환해준다.
			
			//수정시 기존 존재 파일 등록.
			for (int i=0; i < fileMap.keySize("existFile"); i++){
				
				String tmpStr = fileMap.getString("existFile", i);
				String[] value = tmpStr.split("#"); //groupFile_no||file_no 형태로 들어옴 ( 7753#1, 7753#2 ... )
				
				try{
					
					orgGroupFileNo = Integer.parseInt(value[0]); 
					orgFileNo = Integer.parseInt(value[1]);
					
					Map<String, Object> params = Util.valueToMap(
								"maxGroupFileNo", maxGroupFileNo
								, "fileCnt", fileCnt++
								, "orgGroupFileNo", orgGroupFileNo
								, "orgFileNo", orgFileNo
							);
					
					commonMapper.insertCopyUpload(params); //기존 파일 등록 실행.
					
					if(orgFileNoStr.equals(""))
						orgFileNoStr = ""+orgFileNo;
					else
						orgFileNoStr += ","+orgFileNo;
					
					orgGroupFileNo = 0;
				}catch(Exception e){
					System.out.println(" ###### 기존 등록시 넘어온 파일 자를때 에러 발생됐음.");
					orgGroupFileNo = 0;
					break;
				}
			}
			
			//기존 파일에서 삭제한 파일이 있다면.
			for (int i=0; i < fileMap.keySize("deleteFile"); i++){
				
				String tmpStr = fileMap.getString("deleteFile", i);
				String[] value = tmpStr.split("#"); //groupFile_no||file_no 형태로 들어옴 ( 7753#1, 7753#2 ... )
				
				try{
					
					orgGroupFileNo = Integer.parseInt(value[0]); 
					orgFileNo = Integer.parseInt(value[1]);

				}catch(Exception e){
					System.out.println(" ###### 기존 등록시 넘어온 파일 자를때 에러 발생됐음.");
					orgGroupFileNo = 0;
					break;
				}
			}
			
			
			//실제 저장된 기존 파일 제거 및 DB에 기존 groupFileNo 로 DB제거.
			if(orgGroupFileNo > 0){
				
				DataMap orgFileListMap = commonMapper.selectUploadFileList(orgGroupFileNo);
				if( orgFileListMap == null)
					orgFileListMap = new DataMap();
				orgFileListMap.setNullToInitialize(true);
				
				try{

					//DB의 기존 파일의 모든 정보
					for(int i=0; i < orgFileListMap.keySize("fileNo"); i++){
						
						boolean isExist = false;
						int tempInt = orgFileListMap.getInt("fileNo", i);
						
						String[] value = orgFileNoStr.split(","); //기존 파일의 존재 값
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
					
					//기존 groupFile 삭제.
					commonMapper.deleteUploadGroupFileNo(orgGroupFileNo);  
				}
				
			}
			
			
			Map insertMap = new HashMap(); //파일 저장 메소드에 전송될 Map
			
			//신규로 넘어온 파일 처리.
			for (int i=0; i < fileMap.keySize("fileSysName"); i++){
				
				String orgFileName = fileMap.getString("fileSysName", i); //업로드된 파일명
				String changeFileName = DateUtil.getDateTimeMinSec() + i; //실제 저장되는 파일명. (현재시간 + i)
				String realDir = SpringUtils.getRealPath() + Constants.UPLOAD + innoSaveDir; //파일 존재 위치 경로. /pds/inno/common/ 등.
				String fileSize = fileMap.getString("fileSize", i); //파일 사이즈.
				
				//저장된 파일.
				File orgFile = new File(realDir + orgFileName);
				if ( orgFile.exists() ) //파일 이름 변경
					orgFile.renameTo(new File( realDir + changeFileName));
				
				
				//신규 파일 정보 셋팅.
				insertMap.put("groupfileNo", maxGroupFileNo + "");
				insertMap.put("fileNo", fileCnt++ + "");
				insertMap.put("filePath", innoSaveDir + changeFileName);
				insertMap.put("fileName", orgFileName);
				insertMap.put("luserno", userNo);
				insertMap.put("fileSize", fileSize);
				
				commonMapper.insertFileUpload(insertMap); //파일 내용 저장.
				
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
				
				
				//신규 파일 정보 셋팅.
				insertMap.put("groupfileNo", maxGroupFileNo + "");
				insertMap.put("fileNo", fileCnt++ + "");
				insertMap.put("filePath", innoSaveDir + changeFileName);
				insertMap.put("fileName", orgFileName);
				insertMap.put("luserno", userNo);
				insertMap.put("fileSize", fileSize);
				
				commonMapper.insertFileUpload(insertMap); //파일 내용 저장.
			}
			
//			fileBox.addString(item.getFieldName() + "_filePath", dir ); //저장 위치. /inno/common/
//			fileBox.addString(item.getFieldName() + "_fileOrgName", orgFileName); //사용자 파일명.
//			fileBox.addString(item.getFieldName() + "_fileName", uploadFile.getName()); //실제 저장되는 파일 이름.
//			fileBox.addLong(item.getFieldName() + "_fileSize", uploadFile.length());
//			fileBox.addString("fileUploadOk", "1");
			
			
			//파일 등록이 되지 않거나 기존 파일이 있을경우 존재 파일로 넘어 오지 않는 다면. 리턴은 -1
			if(fileCnt <= 1)
				maxGroupFileNo = -1;
			
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return maxGroupFileNo;        
	}
	
	/**
	 * 방문자수 증가.
	 * @param groupFileNo
	 * @param fileNo
	 * @return
	 * @throws BizException
	 */
	public int updateUploadVisitCnt(int groupFileNo, int fileNo) throws BizException{
		
        int resultValue = 0;
        
        try {
            
        	Map params = Util.valueToMap("groupFileNo", groupFileNo, "fileNo", fileNo);
        	
            resultValue = commonMapper.updateUploadVisitCnt(params);
            
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultValue;        
	}
	
	
	/**
	 * 직급 검색 
	 * 작성일 5월 28일
	 * 작성자 정윤철
	 * @return
	 * @throws BizException
	 */
	public DataMap selectSearchDept(String jiknm) throws BizException{
		
		DataMap resultMap = null;
        
        try {
        	resultMap = commonMapper.selectSearchDept(jiknm);
            
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
	
	/**
	 * 색인 코드 (셀렉트 박스용)
	 * @return
	 * @throws BizException
	 */
	public DataMap selectDicGroupCodeByCbo() throws BizException{
		
		DataMap resultMap = null;
        
        try {
        	
            resultMap = commonMapper.selectDicGroupCodeByCbo();
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
	
	/**
	 * 과목 코드 (셀렉트 박스용)
	 * @return
	 * @throws BizException
	 */
	public DataMap selectSubjCodeByCbo() throws BizException{
		
		DataMap resultMap = null;
        
        try {
        	
            resultMap = commonMapper.selectSubjCodeByCbo();
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
	
	/**
	 * 강사관리의 담당분야  (셀렉트 박스용)
	 * @return
	 * @throws BizException
	 */
	public DataMap selectTutorGubunByCbo() throws BizException{
		
		DataMap resultMap = null;
        
        try {
        	
            resultMap = commonMapper.selectTutorGubunByCbo();
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
	
	/**
	 * 강사관리의 강사등급  (셀렉트 박스용)
	 * @return
	 * @throws BizException
	 */
	public DataMap selectTutorLevelByCbo() throws BizException{
		
		DataMap resultMap = null;
        
        try {
        	
            resultMap = commonMapper.selectTutorLevelByCbo();
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}

	
	/**
	 * 과정명
	 * @param grCode
	 * @return
	 * @throws BizException
	 */
	public DataMap selectGrCodeByRow(String grCode) throws BizException{
		
		DataMap resultMap = null;
        
        try {
        	
            resultMap = commonMapper.selectGrCodeByRow(grCode);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
	
	/**
	 * 과목명
	 * @param subj
	 * @return
	 * @throws BizException
	 */
	public DataMap selectSubjByRow(String subj) throws BizException{
		
		DataMap resultMap = null;
        
        try {
        	
            resultMap = commonMapper.selectSubjByRow(subj);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}


	/**
	 * 테이블 명과 삭제 조건을 받아서 테이블의 내용을 삭제 하는 공통 삭제 쿼리.
	 * @param tableName
	 * @param whereStr
	 * @return
	 * @throws BizException
	 */
	public int deleteCommonQuery(String tableName, String whereStr) throws BizException{
		
        int resultValue = 0;
        
        try {
        	
        	Map params = Util.valueToMap("TABLENAME", tableName, "WHERE_STRING", whereStr);
        	
            resultValue = commonMapper.deleteCommonQuery(params);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultValue;        
	}
	
	
	/**
	 * 강의실 리스트.
	 * @return
	 * @throws BizException
	 */
	public DataMap selectClassRoomList() throws Exception{
		DataMap list =commonMapper.selectClassRoomList(); 
		return list;
	}
	/*public DataMap selectClassRoomList() throws BizException{
		
        Connection con = null;
        DataMap resultMap = null;
        
        try {
        	
            con = DBManager.getConnection();
            CommonDAO dao = new CommonDAO(con);
            
            resultMap = commonMapper.selectClassRoomList();
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
            if (con != null) {
                try {
                    con.close();
                } catch (SQLException e1) {
                    e1.printStackTrace();
                }
            }
        }
        return resultMap;        
	}*/
	
	
	/**
	 * 기관 검색.
	 * @param deptnm
	 * @return
	 * @throws BizException
	 */
	public DataMap selectDeptSearch(String deptnm) throws BizException{
		
		DataMap resultMap = null;
        
        try {
        	
            resultMap = commonMapper.selectDeptSearch(deptnm);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
	
	/**
	 * 페이지관리자정보
	 * @param menucode
	 * @return
	 * @throws BizException
	 */
	public DataMap selectPageAdminInfo(String menucode) throws BizException{
		
		DataMap resultMap = null;
        
        try {
        	
            resultMap = commonMapper.selectPageAdminInfo(menucode);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
	
	/**
	 * 페이지관리자목록정보
	 * @return
	 * @throws BizException
	 */
	public DataMap selectPageAdminInfoList() throws BizException{
		
		DataMap resultMap = null;
        
        try {
        	
            resultMap = commonMapper.selectPageAdminInfoList();
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
	
	/**
	 * 만족도 조사 목록
	 * @return
	 * @throws BizException
	 */
	public DataMap selectMenuScoreList() throws BizException{
		
		DataMap resultMap = null;
        
        try {
        	
            resultMap = commonMapper.selectMenuScoreList();
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
	
	/**
	 * 만족도 조사 참여 인원 리스트
	 * @param menucode
	 * @return
	 * @throws BizException
	 */
	public DataMap selectTotalMenuScoreList(String menucode) throws BizException{
		
        DataMap resultMap = null;
        
        try {
        	
            resultMap = commonMapper.selectTotalMenuScoreList(menucode);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
	
	/**
	 * 페이지별 관리자 정보
	 * @param menucode
	 * @param deptname
	 * @param adminName
	 * @param adminTel
	 * @param useyn
	 * @return
	 * @throws BizException
	 */
	public int savePageAdmininfo(String menucode, String deptname, String adminName, String adminTel, String adminUseyn) throws BizException{
		
        int errorcode = 0;
        try {
        	
        	Map params = new HashMap();
        	
        	params.put("menucode", menucode);
        	params.put("deptname", deptname);
        	params.put("adminName", adminName);
        	params.put("adminTel", adminTel);
        	params.put("adminUseyn", adminUseyn);
        	
            errorcode = commonMapper.savePageAdmininfo(params);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return errorcode;        
	}
	
	/**
	 * 만족도보임여부
	 * @param menucode
	 * @param menuscoreUseyn
	 * @return
	 * @throws BizException
	 */
	public int updateMenuScoreUseyn(String menucode, String menuscoreUseyn) throws BizException{
		
        int errorcode = 0;
        try {

        	Map params = new HashMap();
        	
        	params.put("menucode", menucode);
        	params.put("menuscoreUseyn", menuscoreUseyn);
        	
            errorcode = commonMapper.updateMenuScoreUseyn(params);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return errorcode;        
	}
	
	/**
	 * 메뉴별점수 저장
	 * @param menucode
	 * @param menuScore
	 * @param opinion
	 * @param user_id
	 * @return
	 * @throws BizException
	 */
	public int saveMenuScore(String menucode, String menuScore, String opinion, String userIP, String userNo) throws BizException{
		
        int errorcode = 0;
        try {
        	
        	Map params = new HashMap();
        	
        	params.put("menucode", menucode);
        	params.put("menuScore", menuScore);
        	params.put("opinion", opinion);
        	params.put("userIP", userIP);
        	params.put("userNo", userNo);
        	
            errorcode = commonMapper.saveMenuScore(params);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return errorcode;        
	}
	
	/**
	 * 메뉴별점수 저장전 확인
	 * @param menucode
	 * @param menuScore
	 * @param opinion
	 * @param user_id
	 * @return
	 * @throws BizException
	 */
	public Boolean isMenuScore(String menucode, String userNo) throws BizException{
		
        Boolean isSave = true;
        try {
        	
            int count = 0; 
            
            Map params = new HashMap();
            
            params.put("menucode", menucode);
            params.put("userNo", userNo);
            
            count = commonMapper.selectMenuScore(params);
           
            if(count != 0) {
            	isSave = false;
            }
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return isSave;        
	}
	
	/**
	 * 기관명 가져오기.
	 * @param dept
	 * @return
	 * @throws BizException
	 */
	public String selectDeptnmRow(String dept) throws BizException{
		
        String resultValue = "";
        
        try {
            
            resultValue = commonMapper.selectDeptnmRow(dept);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultValue;        
	}
	
	
	
	/**
	 * 과정 (강사기록입력에서 사용함, use = y 인것)
	 * @return
	 * @throws BizException
	 */
	public DataMap selectGrCodeByLec() throws BizException{
		
        DataMap resultMap = null;
        
        try {
        	
            resultMap = commonMapper.selectGrCodeByLec();
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
	
	/**
	 * 기수 (강사기록입력에서 사용함)
	 * @param grCode
	 * @return
	 * @throws BizException
	 */
	public DataMap selectGrSeqByLec(String grCode) throws BizException{
		
		DataMap resultMap = null;
        
        try {
        	
            resultMap = commonMapper.selectGrSeqByLec(grCode);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
	
	/**
	 * 과목 (강사기록입력에서 사용함)
	 * @param grCode
	 * @param grSeq
	 * @return
	 * @throws BizException
	 */
	public DataMap selectSubjByLec(String grCode, String grSeq) throws BizException{
		
        DataMap resultMap = null;
        
        try {
        	
        	Map params = Util.valueToMap("grCode", grCode, "grSeq", grSeq);
        	
            resultMap = commonMapper.selectSubjByLec(params);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
	
	/**
	 * Cyber 과정의 과정 코드 가져오기
	 * @param grSeq
	 * @return
	 * @throws BizException
	 */
	public DataMap selectGrcodeByCyber(String grSeq) throws BizException{

		DataMap resultMap = null;
        
        try {
            
            resultMap = commonMapper.selectGrcodeByCyber(grSeq);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
	
	/**
	 * 평가명 리스트 가져 오기 
	 * @param grcode
	 * @param grseq
	 * @return
	 * @throws BizException
	 */
	public DataMap selectEtestExamList(String grcode, String grseq) throws BizException{
		
		DataMap resultMap = null;
        
        try {
        	
        	Map params = Util.valueToMap("grcode", grcode, "grseq", grseq);
            
            resultMap = commonMapper.selectEtestExamList(params);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
	
	/**
	 * 주소코드 전체 등록
	 * 작성자 정윤철
	 * 작성일 8월 22일
	 * @param grSeq
	 * @return
	 * @throws BizException
	 */
	@Transactional
	public int insertAllZipcode(DataMap requestMap) throws BizException{
		
        int returnValue = 0;
        
        try {
        	
            if(requestMap.keySize("zipCode1") > 0){
            	
	            	for(int  i =0;  i< requestMap.keySize("zipCode1"); i++){
	            		
	            		if(requestMap.getString("zipCode1").length() > 3 || requestMap.getString("zipCode2").length() > 3){
	            			returnValue = 7;
	            			requestMap.setInt("rowCnt", i);
	            			break;
	            		}
	            		
	            		if(!requestMap.getString("zipCode1",i).equals("") && !requestMap.getString("zipCode2").equals("")){
	            			commonMapper.deleteAllZipcode();
	            			
	            			Map params = new HashMap();
	            			
	            			params.put("zipCode1", requestMap.getString("zipCode1", i));
	            			params.put("zipCode2", requestMap.getString("zipCode2", i));
	            			params.put("addr1", requestMap.getString("addr1"));
	            			params.put("addr2", requestMap.getString("addr2"));
	            			params.put("addr3", requestMap.getString("addr3"));
	            			params.put("addr4", requestMap.getString("addr4"));
	            			params.put("addr5", requestMap.getString("addr5"));
	            			
		            		returnValue = commonMapper.insertAllZipcode(params);
		            	}else{
		            		//Action단에서 에러가 나진 안았지만 이곳 서비스 단에서 에러가 날경우를 대비한다.
		            		returnValue = 2;
		            		break;
		            	}
	            	}
            }
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return returnValue;        
	}
	
	
	/**
	 * 과정의 과목별 반구성 리스트
	 * @param grcode
	 * @param grseq
	 * @param subj
	 * @return
	 * @throws BizException
	 */
	public DataMap selectSubjClassByClassList(String grcode, String grseq, String subj) throws BizException{
		
		DataMap resultMap = null;
        
        try {
        	
        	Map params = Util.valueToMap("grcode", grcode, "grseq", grseq, "subj", subj);
        	
            resultMap = commonMapper.selectSubjClassByClassList(params);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
	
	
	
	/**
	 * 선택과목 리스트를 생성해줌. (SelectBox의)
	 * @param grcode
	 * @param grseq
	 * @param subj
	 * @return
	 * @throws BizException
	 */
	public String commChoiceSubjSelectBoxStr(String grcode, String grseq, String subj) throws BizException{
		
        String optionStr = "";
        
        try {
        	
            //선택과목 리스트 (P)
        	Map params = Util.valueToMap("grcode", grcode, "grseq", grseq, "lecType", "P");
            DataMap subjList = commonMapper.selectSubjSeqByChioceList(params);
            if(subjList == null) subjList = new DataMap();
            subjList.setNullToInitialize(true);
            
            int subjCnt = subjList.size(); // 선택과목의 갯수.
            
            if(subjCnt > 0){
            	
                //선택과목 리스트 (C)
            	params.put("lecType", "C");
            	DataMap childSubjList = commonMapper.selectSubjSeqByChioceList(params);
            	 if(childSubjList == null) childSubjList = new DataMap();
                 childSubjList.setNullToInitialize(true);
                 
                 //전체 루프의 개수를 계산한다.
                 int totalLoop = 1;
                 String tmpSubj = "";
                 for(int i=0; i < subjCnt; i++){
                 	tmpSubj = subjList.getString("subj", i); //부모과목코드
                 	int childCnt = 0;
                 	for(int j=0; j < childSubjList.keySize("subj"); j++)
                 		if(tmpSubj.equals(childSubjList.getString("refSubj", j)))
                 			childCnt++;
                 	
                 	if(childCnt == 0) continue;
                 		
                 	totalLoop *= childCnt;
                 }
                
                //System.out.println("#### totalLoop = " + totalLoop);
                
                 for(int i=0; i < totalLoop; i++){
                 	
                 	String subjListStr = "";
                 	String subjNmListStr = "";
                 	
                 	for(int j=0; j < subjCnt; j++){
                 		
                 		int divVal = 1;
                 		int indexKey = 0;
                 		
                 		tmpSubj = subjList.getString("subj", j); //부모과목코드
                 		
                 		// 첫과목부터 현재과목까지의 과목조합수를 구한다.
                 		int childCnt = 0;
                     	for(int k=0; k < childSubjList.keySize("subj"); k++) //현재부모과목의 자식과목수
                     		if(tmpSubj.equals(childSubjList.getString("refSubj", k)))
                     			childCnt++;
                     	
                     	if(childCnt == 0) continue;
                     	
                     	if( j == (subjCnt-1) ){ //마지막과목인 경우
                     		
                     		divVal = 1;
                     		indexKey = ( (int)(i / divVal) % childCnt );
                     		
                     	}else{
                     		
                     		for(int k=j+1; k < subjCnt; k++){
                     			String nextSubj = subjList.getString("subj", k); //다음 부모 과목
                     			
                         		int childCnt2 = 0;
                             	for(int ii=0; ii < childSubjList.keySize("subj"); ii++) //다음 부모과목의 자식과목수
                             		if(nextSubj.equals(childSubjList.getString("refSubj", ii)))
                             			childCnt2++;
                             	if(childCnt2 == 0) continue;
                             	
                             	divVal = divVal * childCnt2;
                     		}
                     		indexKey = ( (int)(i / divVal) % childCnt );
                     	}
                     	//System.out.println("#### indexKey = " + indexKey);
                     	//System.out.println("#### tmpSubj = " + tmpSubj);
                     	
                     	String tmpSubj2 = "";
                     	String tmpSubj2Nm = "";
                     	int tmpCnt = 0;
                     	for(int k=0; k < childSubjList.keySize("subj"); k++)
                     		if(tmpSubj.equals(childSubjList.getString("refSubj", k))){
                     			
                     			if(indexKey == tmpCnt){
                     				tmpSubj2 = childSubjList.getString("subj", k);
                     				tmpSubj2Nm = childSubjList.getString("lecnm", k);
                     				break;
                     			}
                     			tmpCnt++;
                     			
                     		}
                     	//System.out.println("#### tmpSubj2 = " + tmpSubj2);
                     	//System.out.println("#### tmpSubj2Nm = " + tmpSubj2Nm);
                     	
                     	if(subjListStr.equals("")){
                     		subjListStr += tmpSubj2;
                     		subjNmListStr += tmpSubj2Nm;
                     	}else{
                     		subjListStr =  subjListStr + "|" + tmpSubj2;
                     		subjNmListStr = subjNmListStr + "|" + tmpSubj2Nm;
                     	}
                     	
                     	//System.out.println("#### subjListStr = " + subjListStr);
                     	//System.out.println("#### tmpSubj2Nm = " + tmpSubj2Nm);
                 	} //end j
                 	
                 	String tmpStr = "";
                 	if(subj.equals(subjListStr))
                 		tmpStr = "selected";
                 	
                 	optionStr += "<option value='"+subjListStr+"' " + tmpStr + ">" + subjNmListStr + "</option>";
                 } // end i
                 
             }else{
             	
             	optionStr = "<option value='A000000000'>선택과목없음</option>";
             }
            
            
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return optionStr;        
	}
	
	/**
	 * 키워드 체크
	 * @param contents
	 * @return
	 * @throws BizException
	 */
	public String checkKeyword(String contents) throws BizException{
	
		String checkValue = "pass";
        DataMap resultMap = null;
        
        try {
        	System.out.println(commonMapper);
            resultMap = commonMapper.checkKeyword();
            
            for(int i = 0; i < resultMap.keySize("seq"); i++) {
            	if(contents.indexOf(resultMap.getString("keyword", i)) != -1) {
            		checkValue = resultMap.getString("keyword", i);
            		break;
            	}
            }
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return checkValue;        
	}
	
	/**
	 * 키워드 필터링
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public String keywordFilter(String param) throws Exception{
        try {
	        	if(param != null) {
	        	String loop ="[|]_&_;_[$]_%_@_'_\"_\'_<_>_[(]_[)]_[+]_,";
	        	String[] loopTemp = loop.split("_");    	
	        	
	        	for(int i = 0; i < loopTemp.length; i++) {
	        		param = param.replaceAll(loopTemp[i], "");
	        	}
        	}
        	return param;
        } catch (Exception e) {
        	param = null;
        	return param;
        }
	}

}