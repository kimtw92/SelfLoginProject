package loti.courseMgr.service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import loti.courseMgr.mapper.ReservationMapper;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ut.lib.exception.BizException;
import ut.lib.support.DataMap;
import ut.lib.util.Message;
import ut.lib.util.Util;

import common.service.BaseService;

@Service
public class ReservationService extends BaseService {

	@Autowired
	private ReservationMapper reservationMapper;
	
	/**
	 * 시설임대예약 리스트
	 * */
	public DataMap selectResvList(String type) throws BizException{
        DataMap resultMap = new DataMap();
        
        try {
        	resultMap = reservationMapper.reservationlist(type);
        } catch (Exception e) {
			throw new BizException(e);
		} finally {
			
		}
        return resultMap;  
	}
	
	/**
	 * 시설임대예약 등록
	 * */
	public void setReservation(String taPk,String value,String taAgrNo) throws BizException{
		try {
			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("taPk", taPk);
			paramMap.put("value", value);
			paramMap.put("taAgrNo", taAgrNo);
			
			reservationMapper.reservationaction(paramMap);
		} catch (Exception e) {
			throw new BizException(e);
		} finally {
			
		}
	}
	
	/**
	 * 시설임대예약 취소
	 * */
	public void setReservation(String taPk , String taAgreement) throws BizException{
		try {
			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("taPk", taPk);
			paramMap.put("taAgreement", taAgreement);
			
			reservationMapper.updateReservationaction(paramMap);
		} catch (Exception e) {
			throw new BizException(e);
		} finally {
			
		}
	}
	
	/**
	 * 시설임대예약 삭제
	 * */
	public void delReservation(String pk) throws BizException {
		try {
			reservationMapper.delReservation(pk);
		} catch (Exception e) {
			throw new BizException(e);
		} finally {
			
		}
	}
	
	/**
	 * 휴무일 리스트
	 * */
	public DataMap getHolyDay(DataMap requestMap) throws BizException{
		DataMap resultMap = new DataMap();
        
        try {
        	resultMap = reservationMapper.holyday(requestMap.getString("yyyy"));
        } catch (Exception e) {
			throw new BizException(e);
		} finally {
			
		}
        return resultMap;
	}
	
	/**
	 * 휴무일 년도 그룹
	 * */
	public DataMap getYearGroup() throws BizException{
		DataMap resultMap = new DataMap();
        
        try {
        	resultMap = reservationMapper.selectYearGroup();
        } catch (Exception e) {
			throw new BizException(e);
		} finally {
			
		}
        return resultMap;
	}
	
	/**
	 * 공휴일 추가
	 */
	public int insertHolyDay(DataMap requestMap) throws BizException{
		String holyday = requestMap.getString("save_holyday").replaceAll("-", "");
	
		requestMap.setString("holyday", holyday);
		requestMap.setString("holyday_name",  requestMap.getString("save_holyday_name"));
		requestMap.setString("yyyy", holyday.substring(0, 4));
		requestMap.setString("mm", holyday.substring(4, 6));
		requestMap.setString("dd", holyday.substring(6, 8));
		requestMap.setString("enterName", requestMap.getString("sess_name"));
		requestMap.setString("enterId", requestMap.getString("sess_userid"));

		
		
		int error_code = checkHolyDay(holyday);
		if(error_code >= 1) {
			error_code = -2;
			return error_code;
		}
		error_code = -1;
		
		try {
	        error_code = reservationMapper.insertHolyDay(requestMap);
		} catch (Exception e) {
			throw new BizException(e);
		} finally {
			
		}
	    return error_code;        
	}
	
	/**
	 * 공휴일 수정
	 */
	public int updateHolyDay(DataMap requestMap) throws BizException {
		String holyday = requestMap.getString("update_holyday").replaceAll("-", "");		
		requestMap.setString("holyday", holyday);
		requestMap.setString("holyday_name",  requestMap.getString("update_holyday_name"));
		requestMap.setString("yyyy", holyday.substring(0, 4));
		requestMap.setString("mm", holyday.substring(4, 6));
		requestMap.setString("dd", holyday.substring(6, 8));
		requestMap.setString("updateName", requestMap.getString("sess_name"));
		requestMap.setString("updateId", requestMap.getString("sess_userid"));

		int error_code = checkHolyDay(holyday);
		if(error_code >= 1) {
			if(!selectHolyDay(requestMap.getString("holyday_key")).equals(requestMap.getString("update_holyday").replaceAll("-", ""))) {
				error_code = -2;
				return error_code;
			}
		}
		error_code = -1;
	    
		try {
	        error_code = reservationMapper.updateHolyDay(requestMap);
		} catch (Exception e) {
			throw new BizException(e);
		} finally {
			
		}
	    return error_code;
	}
	
	/**
	 * 공휴일 삭제
	 */
	public int deleteHolyDay(DataMap requestMap) throws BizException{
		int error_code = -1;
	    
		try {
	        error_code = reservationMapper.deleteHolyDay(requestMap);
		} catch (Exception e) {
			throw new BizException(e);
		} finally {
			
		}
	    return error_code;        
	}
	
	/**
	 * 공휴일 중복 체크
	 */
	public int checkHolyDay(String holyday) throws BizException{
		int error_code = -1;
		
	    try {
	        error_code = reservationMapper.countHolyday(holyday);
	    } catch (Exception e) {
			throw new BizException(e);
		} finally {
			
		}
	    return error_code;        
	}
	
	/**
	 * 공휴일 중복 체크
	 */
	public String selectHolyDay(String holydayKey) throws BizException{
		String result = "";
		
	    try {
	        result = reservationMapper.selectHolyDay(holydayKey);
	    } catch (Exception e) {
			throw new BizException(e);
		} finally {
			
		}
	    return result;        
	}	
	
	/**
	 * 저장시 공휴일 및 주말 체크
	 */
	public int saveCheck() throws BizException{
		int resultCode = 0;
		
	    try {
	        resultCode = reservationMapper.saveChackHolyday();
	    } catch (Exception e) {
			throw new BizException(e);
		} finally {
			
		}
	    return resultCode;        
	}
	
	public int getDayCheck() throws BizException{
		
        int count = 0;
        try {
            count = reservationMapper.getDayCheck();
        } catch (Exception e) {
            throw new BizException(e);
        } finally {
        }
        return count;
	}
	
	/**
	 * 예약 마감일 가져오기 가져오기
	 * */
	public String getEndDate() throws BizException{
        String result = "";
        
        try {
        	result = reservationMapper.saveChackEndDate();
        } catch (Exception e) {
			throw new BizException(e);
		} finally {
			
		}
        return result;
	}
	
	/**
	 * 예약 시작일 가져오기
	 * */
	public int getDayChack() throws BizException{
        int count = 0;
        
        try {
        	count = reservationMapper.saveChackStartDate();
        } catch (Exception e) {
			throw new BizException(e);
		} finally {
			
		}
        return count;
	}
	
	/**
	 * 년도 가져 오기
	 * */
	public String getYear() throws BizException{
        String result = "";
        
        try {
        	result = reservationMapper.getCurrentdate("yyyy");
        } catch (Exception e) {
			throw new BizException(e);
		} finally {
			
		}
        return result;
	}
	
	/**
	 * 월 가져 오기
	 * */
	public String getMonth() throws BizException{
        String result = "";
        
        try {
        	result = reservationMapper.getCurrentdate("mm");
        } catch (Exception e) {
			throw new BizException(e);
		} finally {
			
		}
        return result;
	}
	
	/**
	 * 일 가져 오기
	 * */
	public String getDay() throws BizException{
        String result = "";
        
        try {
        	result = reservationMapper.getCurrentdate("dd");
        } catch (Exception e) {
			throw new BizException(e);
		} finally {
			
		}
        return result;
	}
	
	/**
	 * 현제 시간 가져오기
	 */
	public String getCurrentdate() throws BizException{
        String result = "";
        
        try {
        	result = reservationMapper.getCurrentdate("yyyymmddhh24miss");
        } catch (Exception e) {
			throw new BizException(e);
		} finally {
			
		}
        return result;
	}
	
	/**
	 * 시설임대신청 사용여부
	 * */
	public DataMap getResvUse() throws BizException{
		DataMap resultMap = new DataMap();
		
        try {
        	resultMap = reservationMapper.getUseMenu();
        } catch (Exception e) {
			throw new BizException(e);
		} finally {
			
		}
        return resultMap;
	}
	
	public DataMap getResvUse2(String menucd) throws BizException{
		DataMap resultMap = new DataMap();
        
        try {
        	resultMap = reservationMapper.getUseMenu2(menucd);
        } catch (Exception e) {
			throw new BizException(e);
		} finally {
			
		}
        return resultMap;
	}
	
	/**
	 * 공휴일  ui 목록
	 * */
	public DataMap selectHolyDayUiList(DataMap requestMap) throws BizException{
		DataMap resultMap = new DataMap();
		requestMap.setNullToInitialize(true);
        try {
        	String year = "".equals(requestMap.getString("year")) ? String.valueOf(Integer.parseInt(requestMap.getString("pre_year"))):requestMap.getString("year");
			String month = "".equals(requestMap.getString("month")) ? String.valueOf(Integer.parseInt(requestMap.getString("pre_month"))):requestMap.getString("month");
			if(month.length() == 1) {
				month = "0" + month;
			}
			
			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("year", year);
			paramMap.put("month", month);
			
        	resultMap = reservationMapper.holydayUiList(paramMap);
        } catch (Exception e) {
			throw new BizException(e);
		} finally {
			
		}
        return resultMap;
	}
	
	/**
	 * 시설임대신청 사용여부 수정
	 * */
	public void updateUseMenu(DataMap requestMap) throws BizException{
		try {
			reservationMapper.updateUseMenu(requestMap);
		} catch (Exception e) {
			throw new BizException(e);
		} finally {
			
		}
	}
	
	/**
	 * 시설임대예약 관리자SMS 리스트
	 * */
	public DataMap selectResvAdmin() throws BizException{
		DataMap resultMap = new DataMap();
        
        try {
        	resultMap = reservationMapper.selectResvAdmin();
        } catch (Exception e) {
			throw new BizException(e);
		} finally {
			
		}
        return resultMap;  
	}	
	
	/**
	 * 시설임대예약 관리자SMS 입력
	 * */
	public int insertResvAdmin(DataMap requestMap) throws BizException{
		int result = 0;
        
        try {
        	//키 최대 값 조회후 셋팅
            requestMap.setInt("raNo", reservationMapper.selectRaNo());
            result = reservationMapper.insertResvAdmin(requestMap);
        } catch (Exception e) {
			throw new BizException(e);
		} finally {
			
		}
		return result;
	}
	
	/**
	 * 시설임대예약 관리자SMS 삭제
	 * */
	public int deleteResvAdmin(DataMap requestMap) throws BizException{
		int result = 0;
        
        try {
        	result = reservationMapper.deleteResvAdmin(requestMap);
        } catch (Exception e) {
			throw new BizException(e);
		} finally {
			
		}
        return result;
	}
	
	public int saveReservationSurvey(DataMap requestMap) throws BizException{
		int error_code = -1;
		
	    try {
	    	String check1 = Util.getValue(requestMap.getString("check1"));	
			String check2 = Util.getValue(requestMap.getString("check2"));	
			String sDate = Util.getValue(requestMap.getString("sDate"));
			String check4 = Util.getValue(requestMap.getString("check4"));	
			String check5 = Util.getValue(requestMap.getString("check5"));	
			String price = Util.getValue(requestMap.getString("price"));
			String check6 = Util.getValue(requestMap.getString("check6"));	
			String check7 = Util.getValue(requestMap.getString("check7"));	
			String etc = Util.getValue(requestMap.getString("etc"));
			String enterip = Util.getValue(requestMap.getString("enterip"));
			
			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("enterip", enterip);
			paramMap.put("sDate", sDate);
			paramMap.put("check1", Integer.valueOf(check1));
			paramMap.put("check2", Integer.valueOf(check2));
			paramMap.put("check4", Integer.valueOf(check4));
			paramMap.put("check5", Integer.valueOf(check5));
			paramMap.put("check6", Integer.valueOf(check6));
			paramMap.put("check7", Integer.valueOf(check7));
			paramMap.put("etc", etc);
			if(price == "") {
				paramMap.put("price", null); // PRICE
			} else {
				paramMap.put("price", Integer.valueOf(price)); // PRICE
			}
			
	        error_code = reservationMapper.saveReservationSurvey(paramMap);
	    } catch (Exception e) {
			throw new BizException(e);
		} finally {
			
		}
	    return error_code;        
	}

	public int ajaxSaveMgrYn(DataMap requestMap) throws Exception{
	    int error_code = -1;
	    try {
	        error_code = reservationMapper.ajaxSaveMgrYn(requestMap);
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return error_code;        
	}
	
	public int ajaxDeleteMgrYn(DataMap requestMap) throws Exception{
	    int error_code = -1;
	    try {
	        error_code = reservationMapper.ajaxDeleteMgrYn(requestMap);
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return error_code;        
	}	
	
	public DataMap CheckSaveMgrYn(DataMap requestMap) throws Exception{
		
        DataMap resultMap = null;
        
        try {
        	
            resultMap = reservationMapper.CheckSaveMgrYn(requestMap);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;  
	}		
	
	public DataMap SaveMgrYnList(DataMap requestMap) throws Exception{
		
        DataMap resultMap = null;
        
        try {
        	
            resultMap = reservationMapper.SaveMgrYnList(requestMap);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;  
	}	
	
}
