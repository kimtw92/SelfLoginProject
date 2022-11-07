package ut.lib.util;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.context.support.WebApplicationContextUtils;
import org.springframework.web.servlet.FrameworkServlet;

public class SpringUtils {

	public static String ATTR = FrameworkServlet.SERVLET_CONTEXT_PREFIX+"dispatcher";
	
	public static <V> V getBean(Class<V> beanType){
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		return getBean(beanType, request);
	}
	
	public static <V> V getBean(Class<V> beanType, HttpServletRequest request){
		WebApplicationContext context =  WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext(),ATTR);
		return context.getBean(beanType);
	}
	
	public static HttpServletRequest getRequest(){
		return ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
	}
	
	public static String getRealPath(){
		return getRealPath(getRequest());
	}
	
	public static String getRealPath(HttpServletRequest request){
		return getRealPath(request.getSession());
	}
	
	public static String getRealPath(HttpSession session){
		return session.getServletContext().getRealPath("/");
	}
	
	public static String getRealPath(ServletContext servletContext){
		return servletContext.getRealPath("/");
	}
	
	public static String getApplicationRealPath() throws IOException{
		return new File(".").getCanonicalPath();
	}
}
