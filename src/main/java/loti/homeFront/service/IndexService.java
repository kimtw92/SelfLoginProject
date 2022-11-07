package loti.homeFront.service;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import loti.homeFront.mapper.IndexMailMapper;
import loti.homeFront.mapper.IndexMapper;
import loti.homeFront.mapper.IndexSmsMapper;
import loti.homeFront.vo.PersonVO;

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
public class IndexService extends BaseService {

	@Autowired
	private IndexMapper indexMapper;
	
	@Autowired
	private IndexMailMapper indexMailMapper;
	
	@Autowired
	private IndexSmsMapper indexSmsMapper;

	public DataMap getNoticeList() throws BizException {

		DataMap resultMap = null;

		try {
			resultMap = indexMapper.getNoticeList();
		} catch (SQLException e) {
			throw new BizException(Message.getKey(e), e);
		} finally {
		}
		return resultMap;

	}

	public DataMap getCyberList() throws BizException {
		DataMap resultMap = null;

		try {

			// String query =
			// XmlQueryParser.getInstance().getSql("homeFrontSql.xml",
			// "cyberList");
			resultMap = indexMapper.getCyberList();

		} catch (SQLException e) {
			throw new BizException(Message.getKey(e), e);
		} finally {
		}
		return resultMap;
	}

	public DataMap getNonCyberList() throws BizException {

		DataMap resultMap = null;

		try {

			resultMap = indexMapper.getNonCyberList();

		} catch (SQLException e) {
			throw new BizException(Message.getKey(e), e);
		} finally {
		}
		return resultMap;
	}

	public DataMap getMonthList(DataMap dataMap)
			throws BizException {

		DataMap resultMap = null;

		Map<String, Object> param = new HashMap<String, Object>();
		param.put("month", dataMap.getString("month"));

		try {
			// 이달의 교육 리스트 가지고 오기
			resultMap = indexMapper.getMonthList(param);

		} catch (SQLException e) {
			throw new BizException(Message.getKey(e), e);
		} finally {
		}
		return resultMap;
	}

	public DataMap getWeekList() throws BizException {

		DataMap resultMap = null;

		try {

			// 주간일정 리스트 가지고 오기
			resultMap = indexMapper.getWeekList();

		} catch (SQLException e) {
			throw new BizException(Message.getKey(e), e);
		} finally {
		}
		return resultMap;
	}

	public DataMap getMonthAJAXList(DataMap dataMap)
			throws BizException {

		DataMap resultMap = null;

		Map<String, Object> param = new HashMap<String, Object>();
		
		
		if (dataMap.getString("monthajax") == null) {
			param.put("month", dataMap.getString("month"));
		} else {
			param.put("month", dataMap.getString("monthajax"));
		}
		
		

		try {

			// resultMap =
			// indexMapper.getMonthAJAXList(requestMap.getString("monthajax"));
			resultMap = indexMapper.getMonthList(param);

		} catch (SQLException e) {
			throw new BizException(Message.getKey(e), e);
		} finally {
		}
		return resultMap;
	}

	public DataMap getPopupList() throws BizException {

		DataMap resultMap = null;

		try {

			resultMap = indexMapper.getPopupList();

		} catch (SQLException e) {
			throw new BizException(Message.getKey(e), e);
		} finally {
		}
		return resultMap;
	}

	public DataMap getPhotoList() throws BizException {

		DataMap resultMap = null;

		try {

			resultMap = indexMapper.getPhotoList();

		} catch (SQLException e) {
			throw new BizException(Message.getKey(e), e);
		} finally {
		}
		return resultMap;
	}

	public DataMap getGrseqPlanList() throws BizException {

		DataMap resultMap = null;

		try {

			resultMap = indexMapper.getGrseqPlanList();

		} catch (SQLException e) {
			throw new BizException(Message.getKey(e), e);
		} finally {
		}
		return resultMap;
	}

	public int insertLoginStats(String tyGubun, String userNo)
			throws BizException {

		int returnValue = 0;

		Map<String, Object> param = new HashMap<String, Object>();
		param.put("tyGubun", tyGubun);
		param.put("userNo", userNo);

		try {

			returnValue = indexMapper.insertLoginStats(param);

		} catch (SQLException e) {
			throw new BizException(Message.getKey(e), e);
		} finally {
		}
		return returnValue;
	}

	public DataMap getExistIdValue(DataMap dataMap) throws BizException {
		
		DataMap resultMap = null;

		try {

			resultMap = indexMapper.getExistIdValue(dataMap.getString("ssn"));

		} catch (SQLException e) {
			throw new BizException(Message.getKey(e), e);
		} finally {
		}
		return resultMap;
	}

	public DataMap getAllNonCyberList() throws BizException {

		DataMap resultMap = null;
        
        try {
        	
            resultMap = indexMapper.getAllNonCyberList();
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;   
	}

	public DataMap getAllCyberList() throws BizException {

		DataMap resultMap = null;
        
        try {
        	
            resultMap = indexMapper.getAllCyberList();
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;  
	}

	public DataMap getPopupView(String no) throws BizException {

		DataMap resultMap = null;      
        try {
            resultMap = indexMapper.getPopupView(no);          	                                   
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;  
	}

	public DataMap getEatList(String day, int weekCount) throws BizException {

		DataMap resultMap = null;
        
        try {
        	
        	Map<String, Object> params = new HashMap<String, Object>();
        	
        	params.put("day", day);
        	params.put("weekCount", weekCount);
        	
            resultMap = indexMapper.getEatList(params);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}

	public DataMap getDeptList() throws BizException {

		DataMap resultMap = null;
	    
	    try {
	    	
	        resultMap = indexMapper.getDeptList();
	                                
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return resultMap;    
	}
	
	public Integer getFileNo() throws BizException {

		Integer result = null;
        try {
        	
            result = indexMapper.getFileNo();
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return result;  
	}
	
	public void setJoinPicture(String fileNo, String path, String fileName) throws Exception{
		
        try {
            
        	Map<String, Object> params = new HashMap<String, Object>();
        	
        	params.put("fileNo", fileNo);
        	params.put("path", path);
        	params.put("fileName", fileName);
        	params.put("d", "0");
        	
            indexMapper.setJoinPicture(params);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
  
	}

	public DataMap getJoinYn(DataMap requestMap) throws BizException {

		DataMap resultMap = null;
	    
	    try {
	    	
	        resultMap = indexMapper.getJoinYn(requestMap.getString("userid"));
	                                
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return resultMap;       
	}

	public DataMap getEmailYn(DataMap requestMap) throws BizException {
		
		DataMap resultMap = null;
	    
	    try {
	    	
	        resultMap = indexMapper.getEmailYn(requestMap.getString("email"));
	                                
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return resultMap;        
	}

	public DataMap getZikList(DataMap requestMap) throws BizException {

		DataMap resultMap = null;
	    
	    try {
	    	
	        resultMap = indexMapper.getZikList(requestMap.getString("jik"));
	                                
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return resultMap; 
	}

	public void joinMember(Map<String,Object> requestMap) throws BizException {

	    try {
	        
	        //dao.joinMember(requestMap);
	        // 2011.01.11 - woni82
	        // 아이핀 모듈 적용 이후 새로 회원 등록하는 dao프로세스
	        indexMapper.joinMemberRnG(requestMap);
	                                
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	}
	
	public void updateDamoMember(String user_id) throws BizException {

	    try {
	    	Map<String, Object> params = Util.valueToMap( "user_id", user_id);
	        //dao.joinMember(requestMap);
	        // 2011.01.11 - woni82
	        // 아이핀 모듈 적용 이후 새로 회원 등록하는 dao프로세스
	        indexMapper.updateDamoMemberRnG(params);
	                                
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	}
	

	public String getUserNo() throws BizException {

        String resultString = null;
        
        try {
        	DataMap res = indexMapper.getUserNo();
            resultString = res.get("userno")+"";
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultString;        
	}
	
	
//	-----------------------------------------------------------------------------------------
	

	
	/**
	 * 페이징 셈플
	 * @param requestMap
	 * @return
	 * @throws Exception
	 */
	public DataMap pageingSample(DataMap requestMap) throws Exception{
		
        DataMap resultMap = null;
        
        try {
        	
        	int totalCnt = 200;
        	
        	Map<String, Object> pageInfo = Util.getPageInfo(totalCnt, requestMap);
        	
        	resultMap = indexMapper.pageingSample(pageInfo);
            
           	PageNavigation pageNavi = Util.getPageNavigation(pageInfo);
           	resultMap.set("PAGE_INFO", pageNavi);
        	
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
	
	
	public DataMap getZipcodeList(DataMap requestMap) throws Exception{
		
		DataMap resultMap = null;
	    
	    try {
			String address = requestMap.getString("address");	
	        resultMap = indexMapper.getZipcodeList(address);
	                                
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return resultMap;        
	}		
	
	
	//2011.01.11 - woni82
	// 회원의 아이디/ 비밀번호를 찾는 로직
	// 주민등록번호를 사용안하고 이메일 주소를 사용한다.
	public DataMap findPasswordByEmail(DataMap requestMap) throws Exception{
		
	    DataMap resultMap = null;
	    
	    try {
	    	
	        resultMap = indexMapper.findPasswordByEmail(requestMap);
	                                
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return resultMap;        
	}
	// 회원의 아이디/ 비밀번호를 찾는 로직
	// 주민등록번호를 사용
	public DataMap findPassword(DataMap requestMap) throws Exception{
		
		DataMap resultMap = null;
	    
	    try {
	    	
	        resultMap = indexMapper.findPassword(requestMap);
	                                
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return resultMap;        
	}		

	public DataMap findUserPassword(DataMap requestMap) throws Exception{
		
		DataMap resultMap = null;
	    
	    try {
	    	
	        resultMap = indexMapper.findUserPassword(requestMap);
	                                
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return resultMap;        
	}		
	
	public DataMap iPinfindUserPassword(DataMap requestMap) throws Exception{
		
		DataMap resultMap = null;
	    
	    try {
	    	
	        resultMap = indexMapper.iPinfindUserPassword(requestMap);
	                                
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return resultMap;        
	}		
	
	public DataMap findQuestion(DataMap requestMap) throws Exception{
		
		DataMap resultMap = null;
	    
	    try {
	    	
	        resultMap = indexMapper.findQuestion(requestMap);
	                                
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return resultMap;        
	}		
	
	public int updatePasswd(DataMap requestMap) throws Exception{
		
        int returnValue = 0;
        
        try {
                                    
            returnValue = indexMapper.updatePasswd(requestMap);          	                                   
            
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return returnValue;        
	}
	
	public DataMap finddupinfo(DataMap requestMap) throws Exception{
		
		DataMap resultMap = null;
	    
	    try {
	    	
	        resultMap = indexMapper.finddupinfo(requestMap);
	                                
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return resultMap;        
	}	
	

	public int setPassword(String password, String userno) throws Exception{
		
        int returnValue = 0;
        
        try {
                                    
        	
        	Map<String, Object> params = new HashMap<String, Object>();
        	
        	params.put("password", password);
        	params.put("userno", userno);
        	
            indexMapper.setPassword(params);          	                                   
            
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return returnValue;        
	}
	
	public String getMailSeq() throws Exception{
		
        String seq = null;
        
        try {
        	
            seq = indexMapper.getMailSeq();          	                                   
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return seq;        
	}		
	
	public PersonVO getPersonInfo(String userno) throws Exception{
		
        PersonVO vo = new PersonVO();
        
        try {
        	
            vo = indexMapper.getPersonInfo(userno);          	                                   
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return vo;        
	}	
	
	public String getPersonInfoByhp(String username, String hp) throws Exception{
		
        String userno = "";
        
        try {
        	Map<String, Object> params = new HashMap<String, Object>();
        	
        	params.put("username", username);
        	params.put("hp", hp);
        	
        	userno = indexMapper.getPersonInfoByhp(params);          	                                   
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return userno;        
	}	
	
	public int sendMail(PersonVO vo) throws Exception{
		
		int errorcode = -1;
        try {
                                    
//            errorcode = indexMapper.sendMail(vo);
            errorcode = indexMailMapper.sendMail(vo);
//            if(errorcode > 0) {
//            	con.commit();
//            } else {
//            	con.rollback();
//            }
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return errorcode;
	}
	
	public int sendSms(String hp, String msg) throws Exception{
		
        int errorCode = -1;
        try {
        	
        	Map<String, Object> params = new HashMap<String, Object>();
        	
        	params.put("hp", hp);
        	params.put("msg", msg);
        	
        	System.out.println("SMS_Test2::::::::::::::::::::::::::::::::::::::::::::::::::");
            errorCode = indexSmsMapper.sendSms(params);           
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return errorCode;
	}
	
	public DataMap getGoodLectureList() throws Exception{
		
		DataMap resultMap = null;
	    
	    try {
	    	
	        resultMap = indexMapper.getGoodLectureList();
	                                
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return resultMap;        
	}

	
	
	
	public Boolean checkCmlmsJoin(String email, String name) throws Exception{
		
        Boolean result = false;
        
        try {
        	
        	Map<String, Object> params = new HashMap<String, Object>();
        	
        	params.put("email", email);
        	params.put("name", name);
        	
            result = indexMapper.checkCmlmsJoin(params)>0;
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return result;        
	}
	
	public void updateCmlmsId(String cm_id, String id) throws Exception{
		
        try {
            
        	Map<String,Object> params = new HashMap<String, Object>();
        	
        	params.put("cm_id", cm_id);
        	params.put("id", id);
        	
            indexMapper.updateCmlmsId(params);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
 	}
	
	public Boolean checkCmlmsIdExist(String id) throws Exception{
		
        Boolean result = false;
        
        try {
        	
            result = indexMapper.checkCmlmsIdExist(id)>0;
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return result;        
	}	
	
	public void joinCmlmsMember(DataMap requestMap, String id, String userno) throws Exception{
		
	    try {
	    	
	    	requestMap.setString("id", id);
	    	requestMap.setString("userno", userno);
	    	
	        indexMapper.joinCmlmsMember(requestMap);
	                                
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	}
	
	public String getCmlmsUserNo() throws Exception{
		
        String cmlmsUserno = null;
        
        try {
        	
            cmlmsUserno = indexMapper.getCmlmsUserNo();          	                                   
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return cmlmsUserno;        
	}	
	
	public void setRejoin(String id, String pw, String resno) throws Exception{
		
        try {
        	
        	Map<String, Object> params = new HashMap<String, Object>();
        	
        	params.put("id", id);
        	params.put("pw", pw);
        	params.put("resno", resno);
        	
            indexMapper.setRejoin(params);          	                                   
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
	}

	public int getMemberSSOAgree(Map<String, Object> params) throws Exception {
		try {
            return indexMapper.getMemberSSOAgree(params);          	                                   
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
	}

	public void insertSSOAgree(Map<String, Object> params) throws Exception {
		try {
            indexMapper.insertSSOAgree(params);          	                                   
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
	}
	
	public void changeNewPwd(Map<String, Object> params) throws Exception {
		try {
            indexMapper.changeNewPwd(params);          	                                   
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
	}	
	
	/**
	 * 설문 응답 등록
	 * @param requestMap
	 * @return
	 * @throws Exception
	 */
	@Transactional
	public int insertGrinqAnser(DataMap requestMap, DataMap questionMap, String sessUserNo) throws Exception{
		
        int resultValue = 0;
        
        try {
        	
            int titleNo = 9999;
            int setNo = 1;
            String userno = "Z" + 1;
            if(questionMap == null) questionMap = new DataMap();
            questionMap.setNullToInitialize(true);
            
            
            for(int i=0; i < 10; i++){
            	
            	String anwserNo = "";
            	String anwserStr = "";
            	
        		DataMap sampList = (DataMap)questionMap.get("SAMP_LIST_DATA", i);
        		if(sampList == null) sampList = new DataMap();
        		sampList.setNullToInitialize(true); 
        		
        		int qtype = 0;
        		for(int k=0; k < sampList.keySize("questionNo"); k++){
        			qtype = sampList.getInt("answerKind", k);
        		}
        		
            	if(qtype == 1){
            		anwserNo = requestMap.getString("poll_"+i);
            		anwserStr = "";
            	}
            	
            	int questionNo = questionMap.getInt("questionNo", i);
            	
            	DataMap answerMap = new DataMap();
            	answerMap.setNullToInitialize(true);
            	
            	answerMap.setInt("titleNo", titleNo);
            	answerMap.setInt("setNo", setNo);
            	answerMap.setInt("questionNo", questionNo);
            	answerMap.setString("userno", userno);
            	answerMap.setString("ansNo", anwserNo);
            	
            	IndexMapper.insertGrinqAnswer(answerMap); //응답 등록.
            	
            	resultValue++;

            }
            
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultValue;  
		
	}
	
	
	
}
