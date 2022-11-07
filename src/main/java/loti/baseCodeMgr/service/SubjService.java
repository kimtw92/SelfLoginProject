package loti.baseCodeMgr.service;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;
import java.util.StringTokenizer;

import loti.baseCodeMgr.mapper.SubjMapper;
import loti.movieMgr.mapper.MovieMapper;

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
public class SubjService extends BaseService {
	
	@Autowired
	private SubjMapper subjMapper;
	@Autowired
	private MovieMapper movieMapper;
	
	/**
	 * 가 ~ 기타 까지 한글인덱스 코드
	 */
	public DataMap selectCharIndex() throws BizException{
		DataMap resultMap = null;
        
        try {
        	resultMap = subjMapper.selectCharIndex();
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;        
	}
	
	/**
	 * 과목관리 리스트(인덱스 사용안하는 것)
	 */
	public DataMap selectSubjList(DataMap requestMap) throws BizException{
		DataMap resultMap = null;
        
        try {
        	int selectSubjListCount = subjMapper.selectSubjListCount(requestMap);
        	
        	Map<String, Object> pageInfo = Util.getPageInfo(selectSubjListCount, requestMap);
        	
        	pageInfo.put("s_useYn", requestMap.getString("s_useYn"));
        	pageInfo.put("s_subType", requestMap.getString("s_subType"));
        	pageInfo.put("s_searchTxt", requestMap.getString("s_searchTxt"));
        	
            resultMap = subjMapper.selectSubjList(pageInfo);
            PageNavigation pageNavi = Util.getPageNavigation(pageInfo);
        	
        	resultMap.set("PAGE_INFO", pageNavi);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;        
	}
	
	/**
	 * 과목관리 리스트(인덱스 사용)
	 */
	public DataMap selectSubjListByIndex(DataMap requestMap) throws BizException{
		DataMap resultMap = null;
        
        try {
        	int selectSubjListByIndexCount = subjMapper.selectSubjListByIndexCount(requestMap);
        	
        	Map<String, Object> pageInfo = Util.getPageInfo(selectSubjListByIndexCount, requestMap);
        	pageInfo.put("s_indexSeq", requestMap.getString("s_indexSeq"));
        	pageInfo.put("s_useYn", requestMap.getString("s_useYn"));
        	pageInfo.put("s_subType", requestMap.getString("s_subType"));
        	pageInfo.put("s_searchTxt", requestMap.getString("s_searchTxt"));
        	
            resultMap = subjMapper.selectSubjListByIndex(pageInfo);
            
            PageNavigation pageNavi = Util.getPageNavigation(pageInfo);
        	
        	resultMap.set("PAGE_INFO", pageNavi);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;        
	}
	
	/**
	 * 과목코드 기본 정보 (업데이트 상세보기용)
	 */
	public DataMap selectSubjRow(String subj) throws BizException{
		DataMap resultMap = null;
        
        try {
        	resultMap = subjMapper.selectSubjRow(subj);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;        
	}
	
	/**
	 * 과목등록(사이버과목)
	 */
	public String insertSubjByCyber(DataMap requestMap) throws BizException{
		String returnSubj = "";
		
		try {
			StringBuffer sbSubjType = new StringBuffer();
			sbSubjType.append("NU").append(requestMap.getString("subjtype"));
			
			returnSubj = subjMapper.selectSubjNextSubj(sbSubjType.toString());
			
			if (returnSubj != null && !returnSubj.equals("")) {
				requestMap.setString("nextSubj", returnSubj);
				
				int returnVal = subjMapper.insertSubjByCyber(requestMap);
				if (returnVal <= 0) {
					returnSubj = "";
				}
			}
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
		return returnSubj;
	}
	
	/**
	 * 과목코드 등록
	 */
	public int insertSubjByGeneral(DataMap requestMap) throws BizException{
        int returnValue = 0;
        
        try {
        	if(requestMap.getString("subjtype").equals("Y")){ //사이버 과목일경우
            	String subj = this.insertSubjByCyber(requestMap);
            	
            	if(!subj.equals("") && !requestMap.getString("arrayOrgDir").equals("")){ //넘어온 매핑정보가 있으면.
            		String[] arrOrgDir = requestMap.getString("arrayOrgDir").split("[|]");
                	int tmpInt = 0; //결과 정보 담을 임시 변수.
                	
                	if (!subj.equals("")) {
                		// Mapping정보 등록
                		int mappingSeq = subjMapper.selectScormMappingInfoMaxSeq();
                		
                		if (mappingSeq > 0) {
                			Map<String, Object> paramMap = new HashMap<String, Object>();
                			paramMap.put("mappingSeq", mappingSeq);
                			paramMap.put("subj", subj);
                			
                			tmpInt = subjMapper.insertScormMappingInfo(paramMap);  //SCORM_MAPPING_info등록
                			
                			int orgSeq = 0;
                    		if(tmpInt > 0){
                    			for(int i=0; i < arrOrgDir.length; i++){
                    				String orgDir = arrOrgDir[i].split(",,")[0]; //넘어온 회차 정보
                    				
                    				orgSeq = subjMapper.selectScormMappingOrgMaxSeq();  //max org_seq
                    				
                    				DataMap orgMap = new DataMap();
                    				orgMap.setNullToInitialize(true);
                    				
                    				orgMap.setInt("orgSeq", orgSeq);
                    				orgMap.setString("orgDir", orgDir);
                    				orgMap.setInt("mappingSeq", mappingSeq);
                    				orgMap.setInt("dates", (i+1) );
                    				orgMap.setString("previewYn", "N");
                    				
                    				// SCORM_MAPPING_ORG.. 등록
                    				tmpInt = subjMapper.insertScormMappingOrg(orgMap);
                    				
                    				if(tmpInt > 0){
                    					//ITEM정보 추출
                    					DataMap itemMap = subjMapper.selectLcmsItemListBySimple(orgDir);
                        				itemMap.setNullToInitialize(true);
                        				
                        				//SCORM_MAPPING_Item정보 등록
                        				Map<String, Object> paramMap2 = null;
                        				for(int j=0; j < itemMap.keySize("itemId"); j++) {
                        					paramMap2 = new HashMap<String, Object>();
                        					paramMap2.put("itemId", itemMap.getString("itemId", j));
                                			paramMap2.put("orgSeq", orgSeq);
                        					subjMapper.insertScormMappingItem(paramMap2);
                        				}
                    				}
                    			} //END FOR
                    		}
                		}
                	} //END if(!subj.equals("")){
            	}
            	
            	returnValue ++;
            } else {
            	returnValue = subjMapper.insertSubjByGeneral(requestMap);
            }
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return returnValue;        
	}
	
	/**
	 * 일반과목 등록(동영상인 경우)
	 */
	public int insertSubjByGeneralMov(DataMap requestMap) throws BizException{
		int returnValue = 0;
        
        try {
        	//과목등록
        	//int insSub = 
        	subjMapper.insertSubjByMov(requestMap);

        	if (!requestMap.getString("arrayOrgDir").equals("")) { //넘어온 매핑정보가 있으면.
        		String[] arrOrgDir = requestMap.getString("arrayOrgDir").split("[|]");
        	
            	if (!requestMap.getString("subj").equals("")) {
            		// MAX(mapping_seq)+1
            		int mappingSeq = subjMapper.selectScormMappingInfoMaxSeq(); 
            		
            		// 매핑정보 입력
            		if (mappingSeq > 0) {
            			Map<String, Object> paramMap = new HashMap<String, Object>();
            			paramMap.put("mappingSeq", mappingSeq);
            			paramMap.put("subj", requestMap.getString("subj"));
            			int insMappingInfo = subjMapper.insertScormMappingInfo(paramMap);  //SCORM_MAPPING_INFO 등록
            			
                		if (insMappingInfo > 0) {
                			for(int i=0; i < arrOrgDir.length; i++) {
                				String orgDir = arrOrgDir[i].split(",,")[0]; 	//ID
                				String orgTitle = arrOrgDir[i].split(",,")[1];  //제목
                				int orgSeq = subjMapper.selectScormMappingOrgMaxSeq();	//MAX(org_seq)+1
                				
                				DataMap orgMap = new DataMap();
                				orgMap.setNullToInitialize(true);
                				
                				orgMap.setInt("orgSeq", orgSeq);
                				orgMap.setString("orgDir", orgDir);
                				orgMap.setInt("mappingSeq", mappingSeq);
                				orgMap.setInt("dates", (i+1) );
                				orgMap.setString("previewYn", "N");
                				orgMap.setString("orgTitle", orgTitle);
                				orgMap.setString("sessNo", requestMap.getString("sessNo"));                    				
                				
                				//SCORM_MAPPING_ORGANIZATION 입력
                				//int insOrg =
                				subjMapper.insertScormMappingOrg(orgMap);
                				
                				//LCMS에 ORG 입력
                				orgMap.setString("subj", requestMap.getString("subj"));
                				int insLcmsOrg = subjMapper.insertOrganization(orgMap);
                				
                				if (insLcmsOrg > 0) {
                					//ITEM정보 추출
                					DataMap itemMap = subjMapper.selectLcmsItemListBySimple(orgDir);
                    				itemMap.setNullToInitialize(true);
                    				
                    				//SCORM_MAPPING_ITEM 정보 등록
                    				Map<String, Object> paramMap2 = null;
                    				for(int j=0; j < itemMap.keySize("itemId"); j++) {
                    					paramMap2 = new HashMap<String, Object>();
                    					paramMap2.put("itemId", itemMap.getString("itemId", j));
                            			paramMap2.put("orgSeq", orgSeq);
                    					//int insItem =
                    					subjMapper.insertScormMappingItem(paramMap2);
                    				}
                				}
                			} //END for()
                		}
            		}
            	} //END if(!subj.equals(""))
        	}	// END if()
            
        	returnValue ++;
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return returnValue;        
	}
	
	/**
	 * 과목 수정
	 */
	@Transactional
	public int updateSubjByGeneral(DataMap requestMap) throws BizException {
		int returnValue = 0;
        
        try {
        	String subj = requestMap.getString("subj");
            
            //과목이 수정되기전 과목과 연결된 콘텐츠 매핑 정보 삭제.
            
            //수정시 수정전 과목유형이 사이버||동영상 이고, 
            //수정전 매핑된 정보가 있고, 수정이 되었다면 기존 내용 삭제.
            if ((requestMap.getString("oldSubjtype").equals("Y") || requestMap.getString("oldSubjtype").equals("M")) 
            		&& !requestMap.getString("oldArrayOrgDir").equals("")
            		&& !requestMap.getString("oldArrayOrgDir").equals(requestMap.getString("arrayOrgDir"))
               ) {
            	//int delItem =
            	subjMapper.deleteScormMappingItem(subj); //SCORM_MAPPING_ITEM
                //int delOrg =
                subjMapper.deleteScormMappingOrg(subj);  //SCORM_MAPPING_ORGANIZATION
                //int delMappingIfo =
                subjMapper.deleteScormMappingInfo(subj); //SCORM_MAPPING_INFO
            }
            
            // 과목유형이 사이버인경우
            if(requestMap.getString("subjtype").equals("Y")) {
            	returnValue = subjMapper.updateSubjByCyber(requestMap); //과목 정보 수정
            	
            	//수정되었고, 
            	if(returnValue > 0
            			&& !requestMap.getString("arrayOrgDir").equals("") //넘어온 매핑정보가 있고
            			&& !requestMap.getString("arrayOrgDir").equals(requestMap.getString("oldArrayOrgDir"))){ //기존내용에서 수정되었다면
            		
            		String[] arrOrgDir = requestMap.getString("arrayOrgDir").split("[|]");
                	int tmpInt = 0; //결과 정보 담을 임시 변수.
                	
                	if (!subj.equals("")) {
                		// Mapping정보 등록
                		int mappingSeq = subjMapper.selectScormMappingInfoMaxSeq();
                		if (mappingSeq > 0) {
                			Map<String, Object> paramMap = new HashMap<String, Object>();
                			paramMap.put("mappingSeq", mappingSeq);
                			paramMap.put("subj", subj);
                			
                			tmpInt = subjMapper.insertScormMappingInfo(paramMap);  //SCORM_MAPPING_info등록
                			
                			int orgSeq = 0;
                    		if (tmpInt > 0) {
                    			for(int i=0; i < arrOrgDir.length; i++){
                    				String orgDir = arrOrgDir[i].split(",,")[0]; //넘어온 회차 정보
                    				
                    				orgSeq = subjMapper.selectScormMappingOrgMaxSeq();  //max org_seq
                    				
                    				DataMap orgMap = new DataMap();
                    				orgMap.setNullToInitialize(true);
                    				
                    				orgMap.setInt("orgSeq", orgSeq);
                    				orgMap.setString("orgDir", orgDir);
                    				orgMap.setInt("mappingSeq", mappingSeq);
                    				// orgMap.setInt("mappingSeq", requestMap.getInt("mappingSeq"));
                    				orgMap.setInt("dates", (i+1) );
                    				orgMap.setString("previewYn", "N");
                    				
                    				// SCORM_MAPPING_ORG 등록
                    				tmpInt = subjMapper.insertScormMappingOrg(orgMap);
                    				
                    				if (tmpInt > 0) {
                    					//ITEM 정보 추출
                    					DataMap itemMap = subjMapper.selectLcmsItemListBySimple(orgDir);
                        				itemMap.setNullToInitialize(true);
                        				
                        				//SCORM_MAPPING_ITEM 정보 등록
                        				Map<String, Object> paramMap2 = null;
                        				for(int j=0; j < itemMap.keySize("itemId"); j++) {
                        					paramMap2 = new HashMap<String, Object>();
                        					paramMap2.put("itemId", itemMap.getString("itemId", j));
                                			paramMap2.put("orgSeq", orgSeq);
                        					subjMapper.insertScormMappingItem(paramMap2);
                        				}
                    				}
                    			} //END FOR
                    		}
                		}
                	} //END if(!subj.equals("")){
            	}
            } else {
            	// 과목유형이 집합인경우
            	returnValue = subjMapper.updateSubjByGeneral(requestMap);
            }
            
            // 선택과목 삭제 후 입력
            if (returnValue > 0) {
            	//선택과목값을 split 한다.
                StringTokenizer st = new StringTokenizer(requestMap.getString("subjgrp_code") , "|");
                int stCount = st.countTokens();
                
                if (stCount > 0) {
                	// 선택과목 삭제
                	subjMapper.deleteSubjByStep2(requestMap.getString("subj"));
                }
                
                Map<String, Object> paramMap3 = null;
                for(int i=0; i < stCount ; i++) {
                	paramMap3 = new HashMap<String, Object>();
                	paramMap3.put("subj", requestMap.getString("subj"));
                	paramMap3.put("subSubj", st.nextToken());
                	returnValue = subjMapper.insertSubjgrp(paramMap3);
                }                
            }
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return returnValue;        
	}
	
	/**
	 * 과목 수정(동영상과목인 경우)
	 */
	public int updateSubjByGeneralMov(DataMap requestMap) throws BizException {
		int returnValue = 0;
        
        try {
            String subj = requestMap.getString("subj");
            
            //수정전 매핑된 정보가 있고, 
            //수정이 되었다면 기존 콘텐츠 매핑  삭제.
            if ( !requestMap.getString("oldArrayOrgDir").equals("") 
            		&& !requestMap.getString("oldArrayOrgDir").equals(requestMap.getString("arrayOrgDir"))
               ) {
            	//int delItem = 
            	subjMapper.deleteScormMappingItem(subj); 		//SCORM_MAPPING_ITEM
                //int delOrg  = 
            	subjMapper.deleteScormMappingOrg(subj);			//SCORM_MAPPING_ORGANIZATION
                //int delMappingIfo = 
            	subjMapper.deleteScormMappingInfo(subj);	//SCORM_MAPPING_INFO
                int delLcms	= deleteLcmsOrg(subj);						//LCMSINCH.LCMS_ORGANIZATION
                
                System.out.println("rtn === SubjSV.updateSubjByGeneralMov(DataMap).delLcms ========== " + delLcms);
            }

        	returnValue = subjMapper.updateSubjByCyber(requestMap); //과목 정보 수정
        	
        	if (returnValue > 0	//수정되었고,
        			&& !requestMap.getString("arrayOrgDir").equals("") //넘어온 매핑정보가 있고
        			&& !requestMap.getString("arrayOrgDir").equals(requestMap.getString("oldArrayOrgDir"))
        	   ) { //기존내용에서 수정되었다면
        		String[] arrOrgDir = requestMap.getString("arrayOrgDir").split("[|]");
        	
            	int tmpInt = 0;
            	if (!subj.equals("")) {
            		// Mapping 정보 등록
            		int mappingSeq = subjMapper.selectScormMappingInfoMaxSeq(); 
            		if (mappingSeq > 0) {
            			Map<String, Object> paramMap = new HashMap<String, Object>();
            			paramMap.put("mappingSeq", mappingSeq);
            			paramMap.put("subj", subj);
            			tmpInt = subjMapper.insertScormMappingInfo(paramMap);  //SCORM_MAPPING_info등록
            			
            			int orgSeq = 0;
                		if (tmpInt > 0) {
                			for(int i=0; i < arrOrgDir.length; i++) {
                				String orgDir = arrOrgDir[i].split(",,")[0];	//회차 ID
                				String orgTitle = arrOrgDir[i].split(",,")[1];	//회차 제목
                				
                				orgSeq = subjMapper.selectScormMappingOrgMaxSeq();  //max org_seq
                				
                				DataMap orgMap = new DataMap();
                				orgMap.setNullToInitialize(true); 
                				
                				orgMap.setInt("orgSeq", orgSeq);
                				orgMap.setString("orgDir", orgDir);
                				orgMap.setString("orgTitle", orgTitle);
                				orgMap.setInt("mappingSeq", mappingSeq);
                				orgMap.setInt("dates", (i+1) );
                				orgMap.setString("previewYn", "N");
                				orgMap.setString("sessNo", requestMap.getString("sessNo"));
                				
                				// SCORM_MAPPING_ORG 등록
                				tmpInt = subjMapper.insertScormMappingOrg(orgMap);
                				
                				//LCMS에 ORG 정보 입력
                				orgMap.setString("subj", requestMap.getString("subj"));
                				//int insertLcmsOrg = 
                				subjMapper.insertOrganization(orgMap);
                				
                				if (tmpInt > 0) {
                					//ITEM 리스트 추출
                					DataMap itemMap = subjMapper.selectLcmsItemListBySimple(orgDir);
                    				itemMap.setNullToInitialize(true);
                    				
                    				//SCORM_MAPPING_ITEM 정보 등록
                    				Map<String, Object> paramMap2 = null;
                    				for(int j=0; j < itemMap.keySize("itemId"); j++) {
                    					paramMap2 = new HashMap<String, Object>();
                    					paramMap2.put("itemId", itemMap.getString("itemId", j));
                            			paramMap2.put("orgSeq", orgSeq);
                    					subjMapper.insertScormMappingItem(paramMap2);
                    				}
                				}
                			} //END for()
                		}
            		}
            	} //END if(!subj.equals(""))
        	}
            	
            // 선택과목 삭제 후 입력
            if (returnValue > 0) {
            	//TB_SUBJGRP 선택과목 삭제
            	subjMapper.deleteSubjByStep2(requestMap.getString("subj"));
            	
                //TB_SUBJGRP 선택과목 입력
                StringTokenizer st = new StringTokenizer(requestMap.getString("subjgrp_code") , "|");
                int stCount = st.countTokens();
                Map<String, Object> paramMap3 = null;
                for(int i=0; i < stCount ; i++) {
                	paramMap3 = new HashMap<String, Object>();
                	paramMap3.put("subj", requestMap.getString("subj"));
                	paramMap3.put("subSubj", st.nextToken());
                	returnValue = subjMapper.insertSubjgrp(paramMap3);
                }
            }
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return returnValue;        
	}
	
	/**
	 * 과목 삭제
	 */
	public int deleteSubj(DataMap requestMap) throws BizException{
		int returnValue = 0;
        
        try {
        	returnValue += subjMapper.deleteSubjByStep1(requestMap.getString("subj"));	//TB_SUBJ_WEEK
            returnValue += subjMapper.deleteSubjByStep2(requestMap.getString("subj"));	//TB_SUBJ_GRP
            returnValue += subjMapper.deleteSubjByStep3(requestMap.getString("subj"));	//TB_SUBJ
            
            returnValue += subjMapper.deleteScormMappingItem(requestMap.getString("subj")); 	//SCORM_MAPPING_ITEM
            returnValue += subjMapper.deleteScormMappingOrg(requestMap.getString("subj"));  	//SCORM_MAPPING_ORGANIZATION
            returnValue += subjMapper.deleteScormMappingInfo(requestMap.getString("subj")); 	//SCORM_MAPPING_INFO
            
            //동영상강의 정보 삭제
            if("M".equals(requestMap.getString("subjtype"))) {
            	returnValue += movieMapper.deleteContInfoBySubj(requestMap);
            }
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return returnValue;
	}
	
	/**
	 * 과목 삭제
	 */
	public int deleteLcmsOrg(String subj) throws BizException{
		int returnValue = 0;
        
        try {
        	returnValue = subjMapper.deleteLcmsOrg(subj);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return returnValue;        
	}
	
	/**
	 * 선택과목 추가용 검색 리스트
	 */
	public DataMap selectSearchSubjPop(String searchTxt) throws BizException{
		DataMap resultMap = null;
        
        try {
        	resultMap = subjMapper.selectSearchSubjPop(searchTxt);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;        
	}
	
	/**
	 * 선택과목 리스트
	 */
	public DataMap selectSubjgrp(String subj) throws BizException{
		DataMap resultMap = null;
        
        try {
        	resultMap = subjMapper.selectSubjgrp(subj);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;        
	}

	/**
	 * 선택 과목 등록(기본정보 등록 후 선택과목 등록)
	 */
	public int insertOptionSubj(DataMap requestMap) throws BizException{
		int returnValue = 0;
        
        try {
        	// max(subj) 값을 가져온다.
            DataMap maxSubjMap = null;
            StringBuffer sbSubjCode = new StringBuffer();
            sbSubjCode.append("NU").append(requestMap.getString("subjtype"));
            maxSubjMap = subjMapper.selectMaxSubj(sbSubjCode.toString());              
            requestMap.setString("subj", maxSubjMap.getString("subj"));
            
            // 과목 기본정보 등록
            returnValue = subjMapper.insertSubjBySelect(requestMap);
            
            if (returnValue > 0) {
            	//선택과목값을 split 한다.
                StringTokenizer st = new StringTokenizer(requestMap.getString("subjgrp_code") , "|");
                int stCount = st.countTokens();
                Map<String, Object> paramMap = null;
                for(int i=0; i < stCount; i++) {
                	paramMap = new HashMap<String, Object>();
                	paramMap.put("subj", maxSubjMap.getString("subj"));
                	paramMap.put("subSubj", st.nextToken());
                	returnValue = subjMapper.insertSubjgrp(paramMap);
                }                
            }
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return returnValue;
	}
	
	/**
	 * Lcms 카테고리(콘텐츠) 리스트
	 */
	public DataMap selectLcmsCategoryList() throws BizException{
		DataMap resultMap = null;
        
        try {
        	resultMap = subjMapper.selectLcmsCategoryList();
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;        
	}
	
	/**
	 * 과목의 등록된 콘텐츠 매핑 정보
	 */
	public DataMap selectSubjByContentMappingList(String subj) throws BizException{
		DataMap resultMap = null;
        
        try {
        	resultMap = subjMapper.selectSubjByContentMappingList(subj);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;        
	}

	/**
	 * LCMS콘텐츠의 등록된 회차 정보 리스트
	 */
	public DataMap selectLcmsOrganizationList(String lcmsCtId) throws BizException{
		DataMap resultMap = null;
        
        try {
        	resultMap = subjMapper.selectLcmsOrganizationList(lcmsCtId);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;        
	}
}
