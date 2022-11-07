package ut.lib.support;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import ut.lib.login.LoginInfo;

public class CommonMap {

	public CommonMap(){}
	
	public CommonMap(DataMap map){
		this.dataMap = map;
	}
	
	private DataMap dataMap;
	private HttpServletRequest request;
	private HttpSession session;
	private LoginInfo loginInfo;

	public DataMap getDataMap() {
		return dataMap;
	}
	
	public Map<String,Object> getMap(){
		Map<String,Object> res = new HashMap<String, Object>();
		for(Object o : dataMap.keySet()){
			res.put(o.toString(), dataMap.get(o, 0));
		}
		return res;
	}

	public void setDataMap(DataMap dataMap) {
		this.dataMap = dataMap;
	}

	public HttpServletRequest getRequest() {
		return request;
	}

	public void setRequest(HttpServletRequest request) {
		this.request = request;
	}

	public HttpSession getSession() {
		return session;
	}

	public void setSession(HttpSession session) {
		this.session = session;
	}

	public LoginInfo getLoginInfo() {
		return loginInfo;
	}

	public void setLoginInfo(LoginInfo loginInfo) {
		this.loginInfo = loginInfo;
	}
	
	
}
