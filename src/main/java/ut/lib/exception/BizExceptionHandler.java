package ut.lib.exception;


import java.io.FileInputStream;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.Properties;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

import ut.lib.util.Constants;
import ut.lib.util.UtilLang;

@ControllerAdvice
public class BizExceptionHandler {
	
	@Autowired
	private ServletContext servletContext;
	
	protected final Logger log = LoggerFactory.getLogger(getClass());
	
	@ExceptionHandler(Throwable.class)
    public String exceptionHandler(Exception e, HttpServletRequest request) {
		
        String messageKey = e.getMessage();

        String message = null;
        Properties properties = new Properties();

        try {
        	
//        	log.debug(servletContext.getRealPath("/") + Constants.MSG + "message.properties");
        	
        	// 로그인이 필요한 경우임에도 접근시.
        	properties.load(new FileInputStream(servletContext.getRealPath("/") + Constants.MSG + "message.properties"));
        	
        	try{
        		message = UtilLang.ko(properties.getProperty(messageKey));
        	}catch(NullPointerException npe){
        		message = null;
        	}

        	if ("ERROR.MEMBER01".equals(messageKey)) {
        		return "/index.do?RETURN_URL=" + URLEncoder.encode(request.getRequestURI() + "?" + request.getQueryString(), "EUC_KR");
        	}

        	
        	if (message == null) {
        		request.setAttribute("ERROR_MESSAGE", messageKey);
        	} else {
        		request.setAttribute("ERROR_MESSAGE", (messageKey != null ? UtilLang.ko(properties.getProperty(messageKey)) : "messageKey is null"));
        	}
        	
//        	e.printStackTrace();

        	log.info("MSG >> " + (messageKey != null ? UtilLang.ko(properties.getProperty(messageKey)) : "messageKey is null"));
          
        } catch (IOException ioe) {
        	log.error(ioe.toString());
        	for(StackTraceElement ste : ioe.getStackTrace()){
        		log.error(ste.toString());
        	}
            request.setAttribute("ERROR_MESSAGE", "정의되지 않은 오류입니다.");
        }

        return "/commonInc/jsp/error";
    }
	
	
}
