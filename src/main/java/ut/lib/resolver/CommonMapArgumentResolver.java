package ut.lib.resolver;

import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import org.apache.log4j.Logger;
import org.springframework.core.MethodParameter;
import org.springframework.web.bind.support.WebDataBinderFactory;
import org.springframework.web.context.request.NativeWebRequest;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.method.support.HandlerMethodArgumentResolver;
import org.springframework.web.method.support.ModelAndViewContainer;

import ut.lib.login.LoginInfo;
import ut.lib.support.CommonMap;
import ut.lib.support.RequestUtil;

public class CommonMapArgumentResolver implements HandlerMethodArgumentResolver{
	
	private Logger log = Logger.getLogger(getClass());
	
    @Override
    public boolean supportsParameter(MethodParameter parameter) {
        return CommonMap.class.isAssignableFrom(parameter.getParameterType());
    }
 
    @Override
    public Object resolveArgument(MethodParameter parameter, ModelAndViewContainer mavContainer, NativeWebRequest webRequest, WebDataBinderFactory binderFactory) throws Exception {
    	
    	CommonMap commonMap = new CommonMap();
    	
    	commonMap.setRequest(((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest());
    	commonMap.setSession(commonMap.getRequest().getSession());
    	commonMap.setDataMap(RequestUtil.getRequest(commonMap.getRequest()));
    	commonMap.setLoginInfo((LoginInfo)commonMap.getRequest().getAttribute("LOGIN_INFO"));
    	
    	commonMap.getRequest().setAttribute("commonMap", commonMap);
    	
    	String queryString = commonMap.getRequest().getQueryString();
    	
    	if(queryString == null){

    		StringBuilder queryStringBuilder = new StringBuilder();

    		Map<String,String[]> paramMap = commonMap.getRequest().getParameterMap();
    		
    		Set<Entry<String, String[]>> entrySet = paramMap.entrySet();
    		
    		String key;
    		String[] values;
    		
    		int i = 0;
    		for(Entry<String,String[]> e : entrySet){
    			key = e.getKey();
    			values = e.getValue();
    			for(String value : values){
    				if(i != 0){
    					queryStringBuilder.append("&");
    				}
    				queryStringBuilder.append(key).append("=").append(value);
    			}
    			i++;
    		}
    		
    		queryString = queryStringBuilder.toString();
    	}
    	
    	log.debug("요청 URI : " + commonMap.getRequest().getRequestURI() + "?" + queryString);
    	log.debug("요청 방식 : " + (commonMap.getDataMap().containsKey("UPLOAD_FILE") ? "multipart 전송" : "일반 요청"));
    	
        return commonMap;
    }
}